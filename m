Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY117-W1565CAE437311BAB2A5C31C0680@phx.gbl>
From: "" <semiyd@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Fri, 7 Dec 2007 02:36:49 +0000
MIME-Version: 1.0
Subject: [Bluez-users] Problems while using Bluetoothd-service-transfer
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Hi All:


       I encountered a problem while using bluetoothd-service-transfer daem=
on in bluez 3.22.
       After the daemon is launched at startup , other linux systems can di=
scover the FTP/OPP service provided by bluetoothd-service-transfer by using=
 "sdptool browse". So far so good.
       Later , i used obexftp to push some files into the system which is r=
unning FTP service using bluetoothd-service-transfer(BD address is 11:11:11=
:11:11:11). Then i got the following error message:
       / $ obexftp -v -b 11:11:11:11:11:11 -p /tmp/q.jpg
            Browsing 11:11:11:11:11:11 ...
            Channel: 9
            Connecting...failed: FBS UUID
            Still trying to connect
            Connecting...failed: FBS UUID
            Still trying to connect
            Connecting...failed: FBS UUID
            Still trying to connect

I got some similar error as well when i used a cellphone to push files into=
 the system running this daemon.

I dont know exactly what this is about. It seems obexftp didn't get the rig=
ht uuid he wanted while doing sdp query with bluetoothd-service-transfer?

Thanks for any help!




Best Regards



semiyd
_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline
-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
