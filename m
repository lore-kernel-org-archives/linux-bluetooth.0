Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4203A93E.60102@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] rfcomm question 3
References: <20050203130148.58115.qmail@web60901.mail.yahoo.com>
In-Reply-To: <20050203130148.58115.qmail@web60901.mail.yahoo.com>
Content-Type: text/plain; charset=Big5
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
Date: Fri, 04 Feb 2005 17:56:30 +0100

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
>      I've added -lbluetooth in the command, and it successes. But when I 
> run the program, the program terminates and doesn't wait for any mobile 
> terminal involving into the program. What is the problem about my 
> program? And need I really link the header files in bluez-libs/include? 
> If so, should I include like this "bluez-libs-2.14/include/xx.h"? But 
> the /usr/include contains the files. So I wish to know why if it is so.
>      Here is the syntax of my program.
> int main (int argc, char **argv)
> {
>  ...
>  int no_connection;
>  ...
>  printf("\E[H\E[J");
>  printf ("Bluetooth infrared converter\n\n");
>  printf ("Doing initializations !\n");
>  no_connection=0;
>  do_listen(recv_mode);
>  ...
>  while (1)
>  {
>   no_connection++;
>   printf("Now %d mobile terminal(s) is(are) using this program\n");
>   sprintf (command, "at+cscs=i\"8859-1\"\r");
>   ret_code = put_command (command, answer, sizeof (answer), 5, 0);
>   sprintf (command, "AT*EAM=\"Bt-IrConverter\"\r");
>   ret_code = put_command (command, answer, sizeof (answer), 5, 0);
>   submenu_selected = 0;
>   while (!submenu_selected)
>   {
> ....
>    Thanks very much.
> Michael
> 
> */Alain Volmat <avolmat@src.ricoh.co.jp>/* wrote:
> 
>     Hi Michael,
> 
>     ba2str is a function provided by bluez-libs. Linking your
>     program against the bluez-lib might solve your problem.
> 
>     add -lbluetooth to your command line.
> 
>     Alain
> 
>     * Ka Kin Cheung [Thu, 3 Feb 2005 at 18:50 +0800]
> 
>      > Hi all users!
>      > I first give a thank to Alain Volmat that points
>      > out my fault and confusion about rctest.c. Then I put
>      > the parts do_listen and recv_mode in my main porgram.
>      > But when I compile, strange things occur.....
>      > As my program is MySQL C API, I have to compile
>      > with "gcc -c -I/usr/include/mysql XX.c", and it is no
>      > problem. But when I type "gcc -o XX XX.o
>      > -L/usr/lib/mysql -lmysqlclient", following occurs:
>      > bic_midterm.o(.text+0x1c0a): In function `do_listen':
>      > : undefined reference to `ba2str'
>      > collect2: ld returned 1 exit status
>      > I checked with rctest.c, but there is not a function
>      > for ba2str. On the other hand, tv2fl can be accepted
>      > as there is a function in rctest.c. Here are the
>      > include files in my main program.
>      > #ifdef HAVE_CONFIG_H
>      > #include
>      > #endif
>      >
>      >
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      >
>      >
>      > #include
>      > include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      >
>      > #include
>      >
>      >
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      > #include
>      >
>      >
>      > #include
>      > Let's see if there is any function that is missing. If
>      > there is no function missing, where can I find the
>      > ba2str function? I believe that if ba2str function can
>      > be found declared, the program can be run. Thank you
>      > very much for your kindness.
>      > Michael
>      >
>      >
>     _______________________________________________________________________
>      > 新年願望第一位 : 找到友緣人
>      > http://personals.yahoo.com.hk
>      >
>      >
>      > -------------------------------------------------------
>      > This SF.Net email is sponsored by: IntelliVIEW -- Interactive
>     Reporting
>      > Tool for open source databases. Create drag-&-drop reports. Save time
>      > by over 75%! Publish reports on the web. Export to DOC, XLS, RTF,
>     etc.
>      > Download a FREE copy at http://www.intelliview.com/go/osdn_nl
>      > _______________________________________________
>      > Bluez-users mailing list
>      > Bluez-users@lists.sourceforge.net
>      > https://lists.sourceforge.net/lists/listinfo/bluez-users
>      >
> 
> 
> 
>     -------------------------------------------------------
>     This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
>     Tool for open source databases. Create drag-&-drop reports. Save time
>     by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
>     Download a FREE copy at http://www.intelliview.com/go/osdn_nl
>     _______________________________________________
>     Bluez-users mailing list
>     Bluez-users@lists.sourceforge.net
>     https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> ------------------------------------------------------------------------
> 新年願望第一位 : 找到友緣人 <http://hk.personals.yahoo.com>


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
