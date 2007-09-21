Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <OFFBAD6020.4E382E4A-ON8825735D.005AD683-8825735D.005D2673@etas.de>
From: rparker@vetronix.com
Date: Fri, 21 Sep 2007 09:57:26 -0700
Subject: [Bluez-users] UDP and TCP packets across Bluez connections?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0336257737=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multipart message in MIME format.
--===============0336257737==
Content-Type: multipart/alternative;
	boundary="=_alternative 005D26718825735D_="

This is a multipart message in MIME format.
--=_alternative 005D26718825735D_=
Content-Type: text/plain; charset="US-ASCII"

I have an emebdded Linux app that currently listens on a socket that 
receives messages from multiple interfaces (e.g. ethernet, USB with RNDIS, 
wireless). I want to add Bluetooth support.

My question: Do Bluez interfaces to Bluetooth devices act like any other 
IP interface?

I found example source code on the internet of sockets being opened with 
AF_BLUETOOTH as the socket domain (i.e. the first argument to the socket 
call). Does one have to always do it that way in order to receive inbound 
messages on a Bluetooth interface?

I came across text that makes it sound like one uses L2CAP in place of UDP 
and RFCOMM in place of TCP.
http://people.csail.mit.edu/albert/bluez-intro/x95.html 

http://bluez.sourceforge.net/contrib/HOWTO-PAN

So then is it not possible to do TCP/IP across Bluetooth connections? Does 
one need to write application level code that is different for Bluetooth 
as compared to ethernet/USB/wireless?

Also, if one can do TCP/IP over Bluetooth from Linux then does Windows 
recognize incoming TCP and UDP packets without loading a special driver on 
Windows? Currently with USB one uses RNDIS on Windows and an RNDIS 
equivalent driver configuration on Linux. Then Windows and Linux can talk. 
But to do TCP/IP between Linux and Windows over Bluetooth what does one 
do?

Or if there is not real TCP/IP support with Bluetooth does Windows 
understand RFCOMM and L2CAP?

Also, is there some sort of authoritative write-up on a web page somewhere 
about TCP/IP on Bluetooth? I've Googled up read probably 100 web pages 
looking for better info and haven't found it.
--=_alternative 005D26718825735D_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2><tt>I have an emebdded Linux app that currently listens
on a socket that receives messages from multiple interfaces (e.g. ethernet,
USB with RNDIS, wireless). I want to add Bluetooth support.</tt></font>
<br>
<br><font size=2><tt>My question: Do Bluez interfaces to Bluetooth devices
act like any other IP interface?</tt></font>
<br>
<br><font size=2><tt>I found example source code on the internet of sockets
being opened with AF_BLUETOOTH as the socket domain (i.e. the first argument
to the socket call). Does one have to always do it that way in order to
receive inbound messages on a Bluetooth interface?</tt></font>
<br>
<br><font size=2><tt>I came across text that makes it sound like one uses
L2CAP in place of UDP and RFCOMM in place of TCP.</tt></font>
<br><font size=2><tt>http://people.csail.mit.edu/albert/bluez-intro/x95.html
</tt></font>
<br>
<br><font size=2><tt>http://bluez.sourceforge.net/contrib/HOWTO-PAN</tt></font>
<br>
<br><font size=2><tt>So then is it not possible to do TCP/IP across Bluetooth
connections? Does one need to write application level code that is different
for Bluetooth as compared to ethernet/USB/wireless?</tt></font>
<br>
<br><font size=2><tt>Also, if one can do TCP/IP over Bluetooth from Linux
then does Windows recognize incoming TCP and UDP packets without loading
a special driver on Windows? Currently with USB one uses RNDIS on Windows
and an RNDIS equivalent driver configuration on Linux. Then Windows and
Linux can talk. But to do TCP/IP between Linux and Windows over Bluetooth
what does one do?</tt></font>
<br>
<br><font size=2><tt>Or if there is not real TCP/IP support with Bluetooth
does Windows understand RFCOMM and L2CAP?</tt></font>
<br>
<br><font size=2><tt>Also, is there some sort of authoritative write-up
on a web page somewhere about TCP/IP on Bluetooth? I've Googled up read
probably 100 web pages looking for better info and haven't found it.</tt></font>
--=_alternative 005D26718825735D_=--



--===============0336257737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0336257737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0336257737==--
