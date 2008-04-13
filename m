Return-Path: <cyrus@holtmann.org>
Date: Sat, 12 Apr 2008 17:30:51 -0700 (PDT)
From: ramkumar gollamudi <rgollamudi@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <794890.52004.qm@web31005.mail.mud.yahoo.com>
Subject: [Bluez-users] Read error from /dev/rfcomm0
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1452726111=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1452726111==
Content-Type: multipart/alternative; boundary="0-1847138742-1208046651=:52004"

--0-1847138742-1208046651=:52004
Content-Type: text/plain; charset=us-ascii

Hello,
I have a problem reading from the file /dev/rfcomm0 after the tty was created when a remote device connected to my linux PC which was executing the rfcomm listen command. 

rfcomm listen 0 1 testreadapp {}

When the remote device connected to this local device my test application "testreadapp" was launched by the rfcomm utility. In this testreadapp application I open the /dev/rfcomm0 file and attempt to do a file read. It consistently failed and the read() returned 0 bytes. 

On the contrary if I launched testwriteapp after the rfcomm listen command, the testwriteapp not only successfully opened the /dev/rfcomm0 file but also wrote into the file successful. The data then got transmitted across the bluetooth link and were received successfully by the remote device.

I have two questions....

1) How do I got my testreadapp to successfully read from the /dev/rfcomm0 file?
2) Both testreadapp and testwriteapp are currently implemented in C. Are there any issues if I implement them in Java? I understand that execvp does not pass the "{}" argument to java applications. Are there ways to get around the issue?

I will be greatly appreciative if somebody can please help me address this issues. Thanks very much.

-Cheers,
Ram

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1847138742-1208046651=:52004
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><DIV>Hello,</DIV>
<DIV>I have a problem reading from the file /dev/rfcomm0 after the tty was created when a remote device connected to my linux PC which was executing the rfcomm listen command. </DIV>
<DIV>&nbsp;</DIV>
<DIV>rfcomm listen 0 1 testreadapp {}</DIV>
<DIV>&nbsp;</DIV>
<DIV>When the remote device connected to this local device my test application "testreadapp" was launched by the rfcomm utility. In this testreadapp application I open the /dev/rfcomm0 file and attempt to do a file read. It consistently failed and the read() returned 0 bytes. </DIV>
<DIV>&nbsp;</DIV>
<DIV>On the contrary if I&nbsp;launched testwriteapp after the rfcomm listen command, the testwriteapp not only successfully opened the /dev/rfcomm0 file but also wrote into the file successful. The data then got transmitted across the bluetooth link and were received successfully by the remote device.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I have two questions....</DIV>
<DIV>&nbsp;</DIV>
<DIV>1) How do I got my testreadapp to successfully read from the /dev/rfcomm0 file?</DIV>
<DIV>2) Both testreadapp and testwriteapp are currently implemented in C. Are there any issues if I implement them in Java? I understand that execvp does not pass the "{}" argument to java applications. Are there ways to get around the issue?</DIV>
<DIV>&nbsp;</DIV>
<DIV>I will be greatly appreciative if somebody can please help me address this issues. Thanks very much.</DIV>
<DIV>&nbsp;</DIV>
<DIV>-Cheers,</DIV>
<DIV>Ram</DIV>
<DIV>&nbsp;</DIV></div><br>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com </body></html>
--0-1847138742-1208046651=:52004--


--===============1452726111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============1452726111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1452726111==--
