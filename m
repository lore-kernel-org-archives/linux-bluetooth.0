Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050205124828.1758.qmail@web60903.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] rfcomm question 3
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4203A93E.60102@gmx.ch>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1159380722-1107607708=:97959"
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
Date: Sat, 5 Feb 2005 20:48:28 +0800 (CST)

--0-1159380722-1107607708=:97959
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi all users!
    Sorry, but I have to say that I have knowledge about C, but I don't have so much knowledge about socket programming. And I would like to point out that what I find hard is just to let my main program to listen to what bluetooth mobile device wishes to connect to PC, and then let the program run even though no bluetooth device is connecting with the PC i.e. let PC to be server. Anyway, thank you very much for all of your advices. Sorry for any misunderstanding.
    By the way, C is the main programming language of my project, so it is not possible for me to use one language more. But I thank Marco for advice.
    And I wish to ask question here. I've heard that rfcom_bind can do something similar those things do in rctest.c, but until now, I can't find any detail about rfcomm_bind, even in this mail-list or in web. So, if anyone knows, please kindly inform me here and I'll use it once I understand what it does. Sorry for impolite reply but I am eager to learn more about this. Thank you very much!
Michael

Hello Ka Kin Cheung

It looks like you haven't that much c or socket programming knowledge. So
if you try to learn c, socket programming, compiling, bluetooth programming
and all relatet topics in one step, that's pretty hard.

What about Java? JSR 82?
It's fully documentated and you find a lot of samples if you ask google...

Take a look at this:
http://sourceforge.net/projects/avetanabt/
(It is available for windows as well.)

And a good general programming rule (specially for c/c++):
Do not use gcc if you haven't already understand what your code's supposed
to do.


regards
Marco


Ka Kin Cheung wrote:
> Hi all,
> I've added -lbluetooth in the command, and it successes. But when I 
> run the program, the program terminates and doesn't wait for any mobile 
> terminal involving into the program. What is the problem about my 
> program? And need I really link the header files in bluez-libs/include? 
> If so, should I include like this "bluez-libs-2.14/include/xx.h"? But 
> the /usr/include contains the files. So I wish to know why if it is so.
> Here is the syntax of my program.
> int main (int argc, char **argv)
> {
> ...
> int no_connection;
> ...
> printf("\E[H\E[J");
> printf ("Bluetooth infrared converter\n\n");
> printf ("Doing initializations !\n");
> no_connection=0;
> do_listen(recv_mode);
> ...
> while (1)
> {
> no_connection++;
> printf("Now %d mobile terminal(s) is(are) using this program\n");
> sprintf (command, "at+cscs=i\"8859-1\"\r");
> ret_code = put_command (command, answer, sizeof (answer), 5, 0);
> sprintf (command, "AT*EAM=\"Bt-IrConverter\"\r");
> ret_code = put_command (command, answer, sizeof (answer), 5, 0);
> submenu_selected = 0;
> while (!submenu_selected)
> {
> ....
> Thanks very much.
> Michael
> 
> */Alain Volmat /* wrote:
> 
> Hi Michael,
> 
> ba2str is a function provided by bluez-libs. Linking your
> program against the bluez-lib might solve your problem.
> 
> add -lbluetooth to your command line.
> 
> Alain
> 
> * Ka Kin Cheung [Thu, 3 Feb 2005 at 18:50 +0800]
> 
> > Hi all users!
> > I first give a thank to Alain Volmat that points
> > out my fault and confusion about rctest.c. Then I put
> > the parts do_listen and recv_mode in my main porgram.
> > But when I compile, strange things occur.....
> > As my program is MySQL C API, I have to compile
> > with "gcc -c -I/usr/include/mysql XX.c", and it is no
> > problem. But when I type "gcc -o XX XX.o
> > -L/usr/lib/mysql -lmysqlclient", following occurs:
> > bic_midterm.o(.text+0x1c0a): In function `do_listen':
> > : undefined reference to `ba2str'
> > collect2: ld returned 1 exit status
> > I checked with rctest.c, but there is not a function
> > for ba2str. On the other hand, tv2fl can be accepted
> > as there is a function in rctest.c. Here are the
> > include files in my main program.
> > #ifdef HAVE_CONFIG_H
> > #include
> > #endif
> >
> >
> > #include
> > #include
> > #include
> > #include
> > #include
> > #include
> > #include
> > #include
> > #include
> > #include
> > #include
> > #include
> > #include
> > #include
> > #include
> >
> >
> > #include
> > include
> > #include
> > #include
> > #include
> > #include
> > #include
> > #include
> > #include
> > #include
> >
> > #include
> >
> >
> > #include
> > #include
> > #include
> > #include
> > #include
> > #include
> >
> >
> > #include
> > Let's see if there is any function that is missing. If
> > there is no function missing, where can I find the
> > ba2str function? I believe that if ba2str function can
> > be found declared, the program can be run. Thank you
> > very much for your kindness.
> > Michael
> >
> >
> _______________________________________________________________________
> > 新年願望第一位 : 找到友緣人
> > http://personals.yahoo.com.hk
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IntelliVIEW -- Interactive
> Reporting
> > Tool for open source databases. Create drag-&-drop reports. Save time
> > by over 75%! Publish reports on the web. Export to DOC, XLS, RTF,
> etc.
> > Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> 
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
> 
> ------------------------------------------------------------------------
> 新年願望第一位 : 找到友緣人 


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

--0-1159380722-1107607708=:97959
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi all users!</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Sorry, but I have to say that I have knowledge about C, but I don't have so much knowledge about socket programming. And I would like to point out that what I find hard is just to let my main program to listen to what bluetooth mobile device wishes to connect to PC, and then let the program run even though no bluetooth device is connecting with the PC i.e. let PC to be server. Anyway, thank you very much for all of your advices. Sorry for any misunderstanding.</DIV>
<DIV>&nbsp;&nbsp;&nbsp; By the way, C is the main programming language of my project, so it is not possible for me to use one language more. But I thank Marco for advice.</DIV>
<DIV>&nbsp;&nbsp;&nbsp; And I wish to ask question here. I've heard that rfcom_bind can do something similar those things do in rctest.c, but until now, I can't find any detail about rfcomm_bind, even in this mail-list or in web. So, if anyone knows, please kindly inform me here and I'll use it once I understand what it does. Sorry for impolite reply but I am eager to learn more about this. Thank you very much!</DIV>
<DIV>Michael<BR></DIV><B><I></I></B>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hello Ka Kin Cheung<BR><BR>It looks like you haven't that much c or socket programming knowledge. So<BR>if you try to learn c, socket programming, compiling, bluetooth programming<BR>and all relatet topics in one step, that's pretty hard.<BR><BR>What about Java? JSR 82?<BR>It's fully documentated and you find a lot of samples if you ask google...<BR><BR>Take a look at this:<BR>http://sourceforge.net/projects/avetanabt/<BR>(It is available for windows as well.)<BR><BR>And a good general programming rule (specially for c/c++):<BR>Do not use gcc if you haven't already understand what your code's supposed<BR>to do.<BR><BR><BR>regards<BR>Marco<BR><BR><BR>Ka Kin Cheung wrote:<BR>&gt; Hi all,<BR>&gt; I've added -lbluetooth in the command, and it successes. But when I <BR>&gt; run the program, the program terminates and doesn't wait for any mobile <BR>&gt; terminal involving into the 
 program.
 What is the problem about my <BR>&gt; program? And need I really link the header files in bluez-libs/include? <BR>&gt; If so, should I include like this "bluez-libs-2.14/include/xx.h"? But <BR>&gt; the /usr/include contains the files. So I wish to know why if it is so.<BR>&gt; Here is the syntax of my program.<BR>&gt; int main (int argc, char **argv)<BR>&gt; {<BR>&gt; ...<BR>&gt; int no_connection;<BR>&gt; ...<BR>&gt; printf("\E[H\E[J");<BR>&gt; printf ("Bluetooth infrared converter\n\n");<BR>&gt; printf ("Doing initializations !\n");<BR>&gt; no_connection=0;<BR>&gt; do_listen(recv_mode);<BR>&gt; ...<BR>&gt; while (1)<BR>&gt; {<BR>&gt; no_connection++;<BR>&gt; printf("Now %d mobile terminal(s) is(are) using this program\n");<BR>&gt; sprintf (command, "at+cscs=i\"8859-1\"\r");<BR>&gt; ret_code = put_command (command, answer, sizeof (answer), 5, 0);<BR>&gt; sprintf (command, "AT*EAM=\"Bt-IrConverter\"\r");<BR>&gt; ret_code = put_command (command, answer, sizeof (answer), 5,
 0);<BR>&gt; submenu_selected = 0;<BR>&gt; while (!submenu_selected)<BR>&gt; {<BR>&gt; ....<BR>&gt; Thanks very much.<BR>&gt; Michael<BR>&gt; <BR>&gt; */Alain Volmat <AVOLMAT@SRC.RICOH.CO.JP>/* wrote:<BR>&gt; <BR>&gt; Hi Michael,<BR>&gt; <BR>&gt; ba2str is a function provided by bluez-libs. Linking your<BR>&gt; program against the bluez-lib might solve your problem.<BR>&gt; <BR>&gt; add -lbluetooth to your command line.<BR>&gt; <BR>&gt; Alain<BR>&gt; <BR>&gt; * Ka Kin Cheung [Thu, 3 Feb 2005 at 18:50 +0800]<BR>&gt; <BR>&gt; &gt; Hi all users!<BR>&gt; &gt; I first give a thank to Alain Volmat that points<BR>&gt; &gt; out my fault and confusion about rctest.c. Then I put<BR>&gt; &gt; the parts do_listen and recv_mode in my main porgram.<BR>&gt; &gt; But when I compile, strange things occur.....<BR>&gt; &gt; As my program is MySQL C API, I have to compile<BR>&gt; &gt; with "gcc -c -I/usr/include/mysql XX.c", and it is no<BR>&gt; &gt; problem. But when I type "gcc -o XX XX.o<BR>&
 gt; &gt;
 -L/usr/lib/mysql -lmysqlclient", following occurs:<BR>&gt; &gt; bic_midterm.o(.text+0x1c0a): In function `do_listen':<BR>&gt; &gt; : undefined reference to `ba2str'<BR>&gt; &gt; collect2: ld returned 1 exit status<BR>&gt; &gt; I checked with rctest.c, but there is not a function<BR>&gt; &gt; for ba2str. On the other hand, tv2fl can be accepted<BR>&gt; &gt; as there is a function in rctest.c. Here are the<BR>&gt; &gt; include files in my main program.<BR>&gt; &gt; #ifdef HAVE_CONFIG_H<BR>&gt; &gt; #include<BR>&gt; &gt; #endif<BR>&gt; &gt;<BR>&gt; &gt;<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt;<BR>&gt; &gt;<BR>&gt; &gt; #include<BR>&gt; &gt; include<BR>&gt; &gt; #include<BR>&gt; &gt
 ;
 #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt;<BR>&gt; &gt; #include<BR>&gt; &gt;<BR>&gt; &gt;<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt; #include<BR>&gt; &gt;<BR>&gt; &gt;<BR>&gt; &gt; #include<BR>&gt; &gt; Let's see if there is any function that is missing. If<BR>&gt; &gt; there is no function missing, where can I find the<BR>&gt; &gt; ba2str function? I believe that if ba2str function can<BR>&gt; &gt; be found declared, the program can be run. Thank you<BR>&gt; &gt; very much for your kindness.<BR>&gt; &gt; Michael<BR>&gt; &gt;<BR>&gt; &gt;<BR>&gt; _______________________________________________________________________<BR>&gt; &gt; 新年願望第一位 : 找到友緣人<BR>&gt; &gt; http://personals.yahoo.com.hk<BR>&gt; &gt;<BR>&gt; &gt;<BR>&gt; &gt;
 -------------------------------------------------------<BR>&gt; &gt; This SF.Net email is sponsored by: IntelliVIEW -- Interactive<BR>&gt; Reporting<BR>&gt; &gt; Tool for open source databases. Create drag-&amp;-drop reports. Save time<BR>&gt; &gt; by over 75%! Publish reports on the web. Export to DOC, XLS, RTF,<BR>&gt; etc.<BR>&gt; &gt; Download a FREE copy at http://www.intelliview.com/go/osdn_nl<BR>&gt; &gt; _______________________________________________<BR>&gt; &gt; Bluez-users mailing list<BR>&gt; &gt; Bluez-users@lists.sourceforge.net<BR>&gt; &gt; https://lists.sourceforge.net/lists/listinfo/bluez-users<BR>&gt; &gt;<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; -------------------------------------------------------<BR>&gt; This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting<BR>&gt; Tool for open source databases. Create drag-&amp;-drop reports. Save time<BR>&gt; by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.<BR>&gt; Download a FREE c
 opy at
 http://www.intelliview.com/go/osdn_nl<BR>&gt; _______________________________________________<BR>&gt; Bluez-users mailing list<BR>&gt; Bluez-users@lists.sourceforge.net<BR>&gt; https://lists.sourceforge.net/lists/listinfo/bluez-users<BR>&gt; <BR>&gt; <BR>&gt; ------------------------------------------------------------------------<BR>&gt; 新年願望第一位 : 找到友緣人 <HTTP: hk.personals.yahoo.com><BR><BR><BR>-------------------------------------------------------<BR>This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting<BR>Tool for open source databases. Create drag-&amp;-drop reports. Save time<BR>by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.<BR>Download a FREE copy at http://www.intelliview.com/go/osdn_nl<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p><br><hr size=1>新年願望第一位 :  <a
 href=http://hk.personals.yahoo.com>找到友緣人 </a><br>
--0-1159380722-1107607708=:97959--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
