Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050203034226.82077.qmail@web60903.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] rfcomm question 3
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1107322449.9276.13.camel@pegasus>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-384490494-1107402146=:81099"
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
Date: Thu, 3 Feb 2005 11:42:26 +0800 (CST)

--0-384490494-1107402146=:81099
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Marcel!
    I'm sorry for that I made an unclear question before so that I'm confusing of how to do. Let me ask again here.
1.After seeing your reply, I'm deciding to change the rfcomm connection approach as from mobile terminal to computer in two ways: 
a)Just include "rctest.c" by creating "rctest.h" in bluez-utils-2.14/test directory, and put the function prototypes related to listening on a RFCOMM channel and include the header files bluetooth.h and rfcomm.h in my main program
b)put the functions related to listening on a RFCOMM channel in my main program, and include the header files  bluetooth.h and rfcomm.h in the beginning.
So, which approach is more appropriate? And for each approach, what variables need I to declare in the beginning of my main program?
2.My wish is to let the program to accept all mobiles that wish to connect to PC. Then how can I write the syntax so that if one mobile wish to connect to PC, the PC can accept it? And how can I do to count and check the number of mobile terminals connecting with PC?
3.What online reference is good for me to get familiar with the matter that I asked in the previous two questions?
Hope that my question and your answer can make me more clearer about what I've to do. Thank you very much for your kindness.

Marcel Holtmann <marcel@holtmann.org> wrote:
Hi Michael,

> Acutally, this project is just related to
> bluetooth. I've seen your reply, and then got through
> rctest.c. I found that the part of receiving mobile
> exists. Then I wish to know need I include the
> rctest.c file in my main program with which header
> files include in it? Or need I put the part in my
> program? And about the part you said that is the
> socket program, I wish to know is it ok if I just put
> it in my main program with which header files include
> in it? And as I need to accept all mobile, not the one
> that the address has been set in the program, to
> connect with PC and then access the program, how can I
> do to make sure that my wish is possible? Thank you
> very much.

you need to include the listen part, because this one gives you a socket
descriptor for the incoming connection in the end. From this descriptor
you can read() and write(). If you wanna accept only specific devices
then use getpeername() to get its address after they connected to you.
You can then decide what to do. If you don't like that device simple
close the connection.

The rctest.c is an example of how to do it. Don't include things that
you don't understand. For using RFCOMM it is enough to include the
bluetooth.h and rfcomm.h header files.

Regards

Marcel




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

--0-384490494-1107402146=:81099
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi Marcel!</DIV>
<DIV>&nbsp;&nbsp;&nbsp; I'm sorry for that I made an unclear question before so that I'm confusing of how to do. Let me ask again here.</DIV>
<DIV>1.After seeing your reply, I'm deciding to change the rfcomm connection approach as from mobile terminal to computer in two ways: </DIV>
<DIV>a)Just include "rctest.c" by creating "rctest.h" in bluez-utils-2.14/test directory, and put the function prototypes&nbsp;related to listening on a RFCOMM channel and include the&nbsp;header files bluetooth.h and rfcomm.h in my main program</DIV>
<DIV>b)put the functions related to listening on a RFCOMM channel in my main program, and&nbsp;include the&nbsp;header files &nbsp;bluetooth.h and rfcomm.h in the beginning.<BR>So, which approach is more appropriate? And for each approach, what variables need I to declare in the beginning of my main program?</DIV>
<DIV>2.My wish is to let the program to accept all mobiles that wish to connect to PC. Then how can I write the syntax so that if one mobile wish to connect to PC, the PC can accept it? And how can I do to count and check the number of mobile terminals connecting with PC?</DIV>
<DIV>3.What online reference is good for me to get familiar with the matter that I asked in the previous two questions?</DIV>
<DIV>Hope that my question and your answer can make me more clearer about what I've to do. Thank you very much for your kindness.</DIV>
<DIV><BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Michael,<BR><BR>&gt; Acutally, this project is just related to<BR>&gt; bluetooth. I've seen your reply, and then got through<BR>&gt; rctest.c. I found that the part of receiving mobile<BR>&gt; exists. Then I wish to know need I include the<BR>&gt; rctest.c file in my main program with which header<BR>&gt; files include in it? Or need I put the part in my<BR>&gt; program? And about the part you said that is the<BR>&gt; socket program, I wish to know is it ok if I just put<BR>&gt; it in my main program with which header files include<BR>&gt; in it? And as I need to accept all mobile, not the one<BR>&gt; that the address has been set in the program, to<BR>&gt; connect with PC and then access the program, how can I<BR>&gt; do to make sure that my wish is possible? Thank you<BR>&gt; very much.<BR><BR>you need to include the listen part, because this one gives you a socket<BR>des
 criptor
 for the incoming connection in the end. From this descriptor<BR>you can read() and write(). If you wanna accept only specific devices<BR>then use getpeername() to get its address after they connected to you.<BR>You can then decide what to do. If you don't like that device simple<BR>close the connection.<BR><BR>The rctest.c is an example of how to do it. Don't include things that<BR>you don't understand. For using RFCOMM it is enough to include the<BR>bluetooth.h and rfcomm.h header files.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR><BR>-------------------------------------------------------<BR>This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting<BR>Tool for open source databases. Create drag-&amp;-drop reports. Save time<BR>by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.<BR>Download a FREE copy at http://www.intelliview.com/go/osdn_nl<BR>_______________________________________________<BR>Bluez-users mailing
 list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p><br><hr size=1>新年願望第一位 :  <a href=http://hk.personals.yahoo.com>找到友緣人 </a><br>
--0-384490494-1107402146=:81099--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
