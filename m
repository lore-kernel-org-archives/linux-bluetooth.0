Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <380-22007312614145425@M2W012.mail2web.com>
From: "vikram.bidkar@adamya.com" <vikram.bidkar@adamya.com>
To: bluez-users@lists.sourceforge.net
Date: Mon, 26 Mar 2007 10:14:54 -0400
MIME-Version: 1.0
Subject: [Bluez-users] problem in starting hcid
Reply-To: vikram.bidkar@adamya.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

Hi All,

I am not able to start "hcid" i.e. If I run ./hcid from
bluez-utils-3.9/hcid.

I am getting following error.

Mar 30 16:50:51 Netravathi hcid[18586]: Bluetooth HCI daemon
Mar 30 16:50:51 Netravathi hcid[18586]: Can't connect to system message
bus: Failed to connect to socket /usr/local/var/run/dbus/system_bus_socket:
No such file or directory
Mar 30 16:50:51 Netravathi hcid[18586]: Unable to get on D-Bus.

I could start SDP server succefully.

I think I am getting Sygmentation fault for
"sdp_set_access_protos(spp_info[0].record, aproto);",because I have not
started hcid successfully.

Please any buddy suggest me how to come out of this problem

Regards,
Vikram

--------------------------------------------------------------------
mail2web.com - Microsoft=AE Exchange solutions from a leading provider -
http://link.mail2web.com/Business/Exchange



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
