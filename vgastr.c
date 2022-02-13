//Yostex OS VGA mode string support
//Added @ Version 0.0.1
//Author Chirs Yost @2022.02.13

void _strwrite(char* string)
{
  char* p_strdst = (char*)(0xb8000);    //指向显存的开始地址
  while (*string)
  {
    *p_strdst = *string++;
    p_strdst += 2;  //跳过字符颜色设置
  }
  return;
}

void printf(char* fmt, ...)
{
  _strwrite(fmt);
  return;
}