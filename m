Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20070102122919.91570.qmail@web53310.mail.yahoo.com>
Date: Tue, 2 Jan 2007 20:29:19 +0800 (CST)
From: KS H <kspam1234@yahoo.com.hk>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <57c68ddc0701020215i4ad8b549k9ae917a20b2b49ff@mail.gmail.com>
MIME-Version: 1.0
Subject: [Bluez-users]
	=?big5?q?=A6^=C2=D0=A1G=20Re:=20=20Cross=20compile=20error?=
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1170303624=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1170303624==
Content-Type: multipart/alternative; boundary="0-1576362426-1167740959=:89244"
Content-Transfer-Encoding: 8bit

--0-1576362426-1167740959=:89244
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit


Thanks. it is done after setting the PKG_CONFIG_PATH

siddhant tewari <siddhant.tewari@gmail.com> 說： hi,
    After doing make install , while building bluez ,bluez.pc file should be there in the /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu /lib/pkgconfig folder ... then you can set PKG_CONFIG_PATH variable to ask pkg-config to use this file. I hope this should work.

regards
siddhant 




 On 1/2/07, KS H <kspam1234@yahoo.com.hk> wrote: I would like to cross compile the bluez v3.8 on samsung S3C2440 Arm processor. I am using the arm cross compiler and then compile and installed bluez-lib-3.8 into the tool chain directory as following

/usr/local/arm/arm- gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib

Then I set the libdir and includedir path as above when I configure the blue-util-3.8. However it return following error during the configuration.
 
checking for BLUEZ... no
 configure: error: Bluetooth library is required

Do anyone know how to configurate and make it work?

The following log may be useful
*************************************************************************************** 
> ./configure CC=arm-linux-gnu-gcc --host=arm-linux-gnu --libdir=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib --includedir=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include  --with-bluez=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/libconfigure: 

WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used. 
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for arm-linux-gnu-strip... arm-linux-gnu-strip 
checking whether to enable maintainer-specific portions of Makefiles... no
checking for arm-linux-gnu-gcc... arm-linux-gnu-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes 
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether  arm-linux-gnu-gcc accepts -g... yes
checking for arm-linux-gnu-gcc option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of arm-linux-gnu-gcc... gcc3 
checking whether arm-linux-gnu-gcc accepts -fPIE... yes
checking for a BSD-compatible install... /usr/bin/install -c
checking for bison... bison -y
checking for flex... flex
checking for yywrap in -lfl... no 
checking for yywrap in -ll... no
checking lex output file root... lex.yy
checking whether yytext is a pointer... no
checking build system type... i686-redhat-linux-gnu
checking host system type... arm-unknown-linux-gnu 
checking for a sed that does not truncate output... /bin/sed
checking for egrep... grep -E
checking for ld used by arm-linux-gnu-gcc... /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld 
checking if the linker  (/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld) is GNU ld... yes
checking for /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld option to reload object files... -r 
checking for BSD-compatible nm... /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/bin//arm-linux-gnu-nm -B
checking whether ln -s works... yes
checking how to recognise dependent libraries... pass_all 
checking how to run the C preprocessor... arm-linux-gnu-gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for  string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking dlfcn.h usability... yes
checking  dlfcn.h presence... yes
checking for dlfcn.h...  yes
checking the maximum length of command line arguments... 32768
checking command to parse /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/bin//arm-linux-gnu-nm -B output from arm-linux-gnu-gcc object... ok 
checking for objdir... .libs
checking for arm-linux-gnu-ar... arm-linux-gnu-ar
checking for arm-linux-gnu-ranlib... arm-linux-gnu-ranlib
checking for arm-linux-gnu-strip... (cached) arm-linux-gnu-strip
checking if arm-linux-gnu-gcc supports -fno-rtti -fno-exceptions... no 
checking for arm-linux-gnu-gcc option to produce PIC... -fPIC
checking if arm-linux-gnu-gcc PIC flag -fPIC works... yes
checking if arm-linux-gnu-gcc static flag -static works... yes
checking if arm-linux-gnu-gcc supports -c -o  file.o... yes
checking whether the arm-linux-gnu-gcc linker (/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld) supports shared libraries... yes
checking whether -lc should be  explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
 checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
configure: creating libtool
checking for ppoll... no
checking for arm-linux-gnu-pkg-config... no 
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for BLUEZ... no
configure: error: Bluetooth library is required
***************************************************************************** 

Regards

 _______________________________________
 YM - 離線訊息
 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。
  http://messenger.yahoo.com.hk 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your 
opinions on IT & business topics through brief surveys - and earn cash
 http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

_______________________________________________
Bluez-users mailing list
 Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users 




 -------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 _______________________________________
 YM - 離線訊息
 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。
 http://messenger.yahoo.com.hk
--0-1576362426-1167740959=:89244
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<br>Thanks. it is done after setting the PKG_CONFIG_PATH<br><br><b><i>siddhant tewari &lt;siddhant.tewari@gmail.com&gt;</i></b> 說：<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> hi,<br>&nbsp;&nbsp;&nbsp; After doing make install , while building bluez ,bluez.pc file should be there in the /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> /lib/pkgconfig folder ... then you can set PKG_CONFIG_PATH variable to ask pkg-config to use this file. I hope this should work.</blockquote><div><br><br>regards<br>siddhant <br></div><br><br><br><div><span class="gmail_quote"> On 1/2/07, <b class="gmail_sendername">KS H</b> &lt;<a href="mailto:kspam1234@yahoo.com.hk">kspam1234@yahoo.com.hk</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> I would like to cross compile the bluez v3.8 on samsung S3C2440 Arm processor. I am using the arm cross compiler and then compile and installed bluez-lib-3.8 into the tool chain directory as following<br><br>/usr/local/arm/arm- gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib<br><br>Then I set the libdir and includedir path as above when I configure the blue-util-3.8. However it return following error during the configuration.<br> <br>checking for BLUEZ... no<br> configure: error: Bluetooth library is required<br><br>Do anyone know how to configurate and make it work?<br><br>The following log may be useful<br>*************************************************************************************** <br>&gt; ./configure CC=arm-linux-gnu-gcc --host=arm-linux-gnu --libdir=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/lib
 --includedir=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/include  --with-bluez=/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/libconfigure: <br><br>WARNING: If you wanted to set the --build type, don't use --host.<br>&nbsp;&nbsp;&nbsp; If a cross compiler is detected then cross compile mode will be used. <br>checking for a BSD-compatible install... /usr/bin/install -c<br>checking whether build environment is sane... yes<br>checking for gawk... gawk<br>checking whether make sets $(MAKE)... yes<br>checking for arm-linux-gnu-strip... arm-linux-gnu-strip <br>checking whether to enable maintainer-specific portions of Makefiles... no<br>checking for arm-linux-gnu-gcc... arm-linux-gnu-gcc<br>checking for C compiler default output file name... a.out<br>checking whether the C compiler works... yes <br>checking whether we are cross compiling... yes<br>checking for suffix of executables...<br>checking for suffix of
 object files... o<br>checking whether we are using the GNU C compiler... yes<br>checking whether  arm-linux-gnu-gcc accepts -g... yes<br>checking for arm-linux-gnu-gcc option to accept ANSI C... none needed<br>checking for style of include used by make... GNU<br>checking dependency style of arm-linux-gnu-gcc... gcc3 <br>checking whether arm-linux-gnu-gcc accepts -fPIE... yes<br>checking for a BSD-compatible install... /usr/bin/install -c<br>checking for bison... bison -y<br>checking for flex... flex<br>checking for yywrap in -lfl... no <br>checking for yywrap in -ll... no<br>checking lex output file root... lex.yy<br>checking whether yytext is a pointer... no<br>checking build system type... i686-redhat-linux-gnu<br>checking host system type... arm-unknown-linux-gnu <br>checking for a sed that does not truncate output... /bin/sed<br>checking for egrep... grep -E<br>checking for ld used by arm-linux-gnu-gcc...
 /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld <br>checking if the linker  (/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld) is GNU ld... yes<br>checking for /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld option to reload object files... -r <br>checking for BSD-compatible nm... /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/bin//arm-linux-gnu-nm -B<br>checking whether ln -s works... yes<br>checking how to recognise dependent libraries... pass_all <br>checking how to run the C preprocessor... arm-linux-gnu-gcc -E<br>checking for ANSI C header files... yes<br>checking for sys/types.h... yes<br>checking for sys/stat.h... yes<br>checking for stdlib.h... yes<br>checking for  string.h... yes<br>checking for memory.h... yes<br>checking for strings.h... yes<br>checking for inttypes.h... yes<br>checking for stdint.h... yes<br>checking for unistd.h...
 yes<br>checking dlfcn.h usability... yes<br>checking  dlfcn.h presence... yes<br>checking for dlfcn.h...  yes<br>checking the maximum length of command line arguments... 32768<br>checking command to parse /usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/bin//arm-linux-gnu-nm -B output from arm-linux-gnu-gcc object... ok <br>checking for objdir... .libs<br>checking for arm-linux-gnu-ar... arm-linux-gnu-ar<br>checking for arm-linux-gnu-ranlib... arm-linux-gnu-ranlib<br>checking for arm-linux-gnu-strip... (cached) arm-linux-gnu-strip<br>checking if arm-linux-gnu-gcc supports -fno-rtti -fno-exceptions... no <br>checking for arm-linux-gnu-gcc option to produce PIC... -fPIC<br>checking if arm-linux-gnu-gcc PIC flag -fPIC works... yes<br>checking if arm-linux-gnu-gcc static flag -static works... yes<br>checking if arm-linux-gnu-gcc supports -c -o  file.o... yes<br>checking whether the arm-linux-gnu-gcc linker
 (/usr/local/arm/arm-gcc-3.4.4/gcc-3.4.4-glibc-2.3.3/arm-linux-gnu/arm-linux-gnu/bin/ld) supports shared libraries... yes<br>checking whether -lc should be  explicitly linked in... no<br>checking dynamic linker characteristics... GNU/Linux ld.so<br>checking how to hardcode library paths into programs... immediate<br>checking whether stripping libraries is possible... yes<br> checking if libtool supports shared libraries... yes<br>checking whether to build shared libraries... yes<br>checking whether to build static libraries... no<br>configure: creating libtool<br>checking for ppoll... no<br>checking for arm-linux-gnu-pkg-config... no <br>checking for pkg-config... /usr/bin/pkg-config<br>checking pkg-config is at least version 0.9.0... yes<br>checking for BLUEZ... no<br>configure: error: Bluetooth library is required<br>***************************************************************************** <br><br>Regards<br><span class="ad"><br><div>
 _______________________________________<br> YM - 離線訊息<br> 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。<br> <a href="http://messenger.yahoo.com.hk" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)"> http://messenger.yahoo.com.hk</a> </div></span><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your <br>opinions on IT &amp; business topics through brief surveys - and earn cash<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank"> http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br><br>_______________________________________________<br>Bluez-users mailing list<br><a onclick="return
 top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-users@lists.sourceforge.net"> Bluez-users@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users </a><br><br><br></blockquote></div><br> -------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br>http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;_______________________________________<br> YM -
 離線訊息<br> 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。<br> http://messenger.yahoo.com.hk
--0-1576362426-1167740959=:89244--


--===============1170303624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1170303624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1170303624==--
