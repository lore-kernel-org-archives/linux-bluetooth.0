Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050203130148.58115.qmail@web60901.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] rfcomm question 3
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050203105901.GC5792@snoopy.src.ricoh.co.jp>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-577222738-1107435707=:53515"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 3 Feb 2005 21:01:47 +0800 (CST)

--0-577222738-1107435707=:53515
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi all,
     I've added -lbluetooth in the command, and it successes. But when I run the program, the program terminates and doesn't wait for any mobile terminal involving into the program. What is the problem about my program? And need I really link the header files in bluez-libs/include? If so, should I include like this "bluez-libs-2.14/include/xx.h"? But the /usr/include contains the files. So I wish to know why if it is so.
     Here is the syntax of my program.
int main (int argc, char **argv)
{
 ...
 int no_connection;
 ...
 printf("\E[H\E[J"); 
 printf ("Bluetooth infrared converter\n\n");
 printf ("Doing initializations !\n");
 no_connection=0;
 do_listen(recv_mode);
 ...
 while (1)
 {
  no_connection++;
  printf("Now %d mobile terminal(s) is(are) using this program\n");
  sprintf (command, "at+cscs=i\"8859-1\"\r");
  ret_code = put_command (command, answer, sizeof (answer), 5, 0);
  sprintf (command, "AT*EAM=\"Bt-IrConverter\"\r");
  ret_code = put_command (command, answer, sizeof (answer), 5, 0);
  submenu_selected = 0;
  while (!submenu_selected)
  {
....
   Thanks very much.
Michael

Alain Volmat <avolmat@src.ricoh.co.jp> wrote:
Hi Michael,

ba2str is a function provided by bluez-libs. Linking your
program against the bluez-lib might solve your problem.

add -lbluetooth to your command line.

Alain

* Ka Kin Cheung [Thu, 3 Feb 2005 at 18:50 +0800]

> Hi all users!
> I first give a thank to Alain Volmat that points
> out my fault and confusion about rctest.c. Then I put
> the parts do_listen and recv_mode in my main porgram.
> But when I compile, strange things occur.....
> As my program is MySQL C API, I have to compile
> with "gcc -c -I/usr/include/mysql XX.c", and it is no
> problem. But when I type "gcc -o XX XX.o
> -L/usr/lib/mysql -lmysqlclient", following occurs:
> bic_midterm.o(.text+0x1c0a): In function `do_listen':
> : undefined reference to `ba2str'
> collect2: ld returned 1 exit status
> I checked with rctest.c, but there is not a function
> for ba2str. On the other hand, tv2fl can be accepted
> as there is a function in rctest.c. Here are the
> include files in my main program. 
> #ifdef HAVE_CONFIG_H
> #include 
> #endif
> 
> 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> 
> 
> #include 
> include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> 
> #include 
> 
> 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> 
> 
> #include 
> Let's see if there is any function that is missing. If
> there is no function missing, where can I find the
> ba2str function? I believe that if ba2str function can
> be found declared, the program can be run. Thank you
> very much for your kindness.
> Michael
> 
> _______________________________________________________________________
> 新年願望第一位 : 找到友緣人
> http://personals.yahoo.com.hk
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



---------------------------------
新年願望第一位 :  找到友緣人 

--0-577222738-1107435707=:53515
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi all,</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; I've added -lbluetooth in the command, and it successes. But when I run the program, the program terminates and doesn't wait for any mobile terminal involving into the program.&nbsp;What is the problem about my program? And need I really link the header files in bluez-libs/include? If so, should I include like this "bluez-libs-2.14/include/xx.h"? But the /usr/include contains the files. So I wish to know why if it is so.</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; Here is the syntax of my program.</DIV>
<DIV>int main (int argc, char **argv)<BR>{<BR>&nbsp;...<BR>&nbsp;int no_connection;<BR>&nbsp;...</DIV>
<DIV>&nbsp;printf("\E[H\E[J"); <BR>&nbsp;printf ("Bluetooth infrared converter\n\n");<BR>&nbsp;printf ("Doing initializations !\n");<BR>&nbsp;no_connection=0;<BR>&nbsp;do_listen(recv_mode);<BR>&nbsp;...<BR>&nbsp;while (1)<BR>&nbsp;{<BR>&nbsp;&nbsp;no_connection++;<BR>&nbsp;&nbsp;printf("Now %d mobile terminal(s) is(are) using this program\n");<BR>&nbsp;&nbsp;sprintf (command, "at+cscs=i\"8859-1\"\r");<BR>&nbsp;&nbsp;ret_code = put_command (command, answer, sizeof (answer), 5, 0);<BR>&nbsp;&nbsp;sprintf (command, "AT*EAM=\"Bt-IrConverter\"\r");<BR>&nbsp;&nbsp;ret_code = put_command (command, answer, sizeof (answer), 5, 0);<BR>&nbsp;&nbsp;submenu_selected = 0;<BR>&nbsp;&nbsp;while (!submenu_selected)<BR>&nbsp;&nbsp;{</DIV>
<DIV>....</DIV>
<DIV>&nbsp;&nbsp;&nbsp;Thanks very much.</DIV>
<DIV>Michael<BR><BR><B><I>Alain Volmat &lt;avolmat@src.ricoh.co.jp&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Michael,<BR><BR>ba2str is a function provided by bluez-libs. Linking your<BR>program against the bluez-lib might solve your problem.<BR><BR>add -lbluetooth to your command line.<BR><BR>Alain<BR><BR>* Ka Kin Cheung [Thu, 3 Feb 2005 at 18:50 +0800]<BR><QUOTE><BR>&gt; Hi all users!<BR>&gt; I first give a thank to Alain Volmat that points<BR>&gt; out my fault and confusion about rctest.c. Then I put<BR>&gt; the parts do_listen and recv_mode in my main porgram.<BR>&gt; But when I compile, strange things occur.....<BR>&gt; As my program is MySQL C API, I have to compile<BR>&gt; with "gcc -c -I/usr/include/mysql XX.c", and it is no<BR>&gt; problem. But when I type "gcc -o XX XX.o<BR>&gt; -L/usr/lib/mysql -lmysqlclient", following occurs:<BR>&gt; bic_midterm.o(.text+0x1c0a): In function `do_listen':<BR>&gt; : undefined reference to `ba2str'<BR>&gt; collect2: ld returned 1 exit
 status<BR>&gt; I checked with rctest.c, but there is not a function<BR>&gt; for ba2str. On the other hand, tv2fl can be accepted<BR>&gt; as there is a function in rctest.c. Here are the<BR>&gt; include files in my main program. <BR>&gt; #ifdef HAVE_CONFIG_H<BR>&gt; #include <CONFIG.H><BR>&gt; #endif<BR>&gt; <BR>&gt; <BR>&gt; #include <STDIO.H><BR>&gt; #include <STDLIB.H><BR>&gt; #include <UNISTD.H><BR>&gt; #include <FCNTL.H><BR>&gt; #include <SYS ioctl.h><BR>&gt; #include <SYS wait.h><BR>&gt; #include <SYS types.h><BR>&gt; #include <SYS time.h><BR>&gt; #include <SYS socket.h><BR>&gt; #include <STRING.H><BR>&gt; #include <TERMIOS.H><BR>&gt; #include <SYSLOG.H><BR>&gt; #include <ERRNO.H><BR>&gt; #include <CTYPE.H><BR>&gt; #include <SIGNAL.H><BR>&gt; <BR>&gt; <BR>&gt; #include <MODEMINIT.H><BR>&gt; include <MODEMINIT.C><BR>&gt; #include <LOGGING.C><BR>&gt; #include <LOGGING.H><BR>&gt; #include <EXTRAS.H><BR>&gt; #include <EXTRAS.C><BR>&gt; #include <LOCKING.C><BR>&gt; #include
 <LOCKING.H><BR>&gt; #include <ALARM.H><BR>&gt; #include <ALARM.C><BR>&gt; <BR>&gt; #include <SYS file.h><BR>&gt; <BR>&gt; <BR>&gt; #include <BLUETOOTH bluetooth.h><BR>&gt; #include <BLUETOOTH hci.h><BR>&gt; #include <BLUETOOTH hci_lib.h><BR>&gt; #include <BLUETOOTH rfcomm.h><BR>&gt; #include <BLUETOOTH sdp.h><BR>&gt; #include <BLUETOOTH sdp_lib.h><BR>&gt; <BR>&gt; <BR>&gt; #include <MYSQL mysql.h><BR>&gt; Let's see if there is any function that is missing. If<BR>&gt; there is no function missing, where can I find the<BR>&gt; ba2str function? I believe that if ba2str function can<BR>&gt; be found declared, the program can be run. Thank you<BR>&gt; very much for your kindness.<BR>&gt; Michael<BR>&gt; <BR>&gt; _______________________________________________________________________<BR>&gt; 新年願望第一位 : 找到友緣人<BR>&gt; http://personals.yahoo.com.hk<BR>&gt; <BR>&gt; <BR>&gt; -------------------------------------------------------<BR>&gt; This SF.Net email is sponsored by:
 IntelliVIEW -- Interactive Reporting<BR>&gt; Tool for open source databases. Create drag-&amp;-drop reports. Save time<BR>&gt; by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.<BR>&gt; Download a FREE copy at http://www.intelliview.com/go/osdn_nl<BR>&gt; _______________________________________________<BR>&gt; Bluez-users mailing list<BR>&gt; Bluez-users@lists.sourceforge.net<BR>&gt; https://lists.sourceforge.net/lists/listinfo/bluez-users<BR>&gt; <BR></QUOTE><BR><BR><BR>-------------------------------------------------------<BR>This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting<BR>Tool for open source databases. Create drag-&amp;-drop reports. Save time<BR>by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.<BR>Download a FREE copy at http://www.intelliview.com/go/osdn_nl<BR>_______________________________________________<BR>Bluez-users mailing
 list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p><br><hr size=1>新年願望第一位 :  <a href=http://hk.personals.yahoo.com>找到友緣人 </a><br>
--0-577222738-1107435707=:53515--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
