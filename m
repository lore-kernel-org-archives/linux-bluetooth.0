Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060829183511.65481.qmail@web25714.mail.ukl.yahoo.com>
Date: Tue, 29 Aug 2006 19:35:11 +0100 (BST)
From: Ray <whatdoineed2do@yahoo.co.uk>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] hci0 only comes up with PSCAN (no ISCAN)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

hi guys,

i am currently using bluez 3.4 (hcid has dynamic dep
on libbluetooth-2.2.1) so the disable iscan bug still
exists.

i followed the instructions and put in "discovto 0;"
to hcid.conf and restarted everything and this fixed
the problem.  i didnt do anything else (no dbus-send
etc)

can you take another look to confirm yourselves?
thanks
ray


		=

___________________________________________________________ =

Try the all-new Yahoo! Mail. "The New Version is radically easier to use" =
=96 The Wall Street Journal =

http://uk.docs.yahoo.com/nowyoucan.html

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
