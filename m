Return-Path: <cyrus@holtmann.org>
Message-ID: <62cd80200804030132v1f26d36oe01f034811eec84@mail.gmail.com>
Date: Thu, 3 Apr 2008 17:32:12 +0900
From: "=?ISO-2022-JP?B?GyRCTXtFRBsoQg==?=" <leetand@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] pand Connection failed. Permission denied(13) BlueZ
	3.28
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1994023477=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1994023477==
Content-Type: multipart/alternative;
	boundary="----=_Part_277_32967026.1207211532428"

------=_Part_277_32967026.1207211532428
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,guys:

I use the newest 3.28 version of BlueZ and two bluetooth devices to setup
the PAN  network on two different Linux box.

the SERVER side running dbus-daemon,hcid and pand daemon like that:

 8180 ?        Ss     0:00 /sbin/hcid -s -f /etc/bluetooth/hcid.conf
 8183 ?        S      0:00 /lib/bluetooth/bluetoothd-service-input
 8184 ?        S      0:00 /lib/bluetooth/bluetoothd-service-network
 8185 ?        S      0:00 /lib/bluetooth/bluetoothd-service-serial
 8189 ?        Ss     0:00 pand --listen --master --role NAP --ethernet
bnep0 --device 00:A0:B0:E0:48:25


and then,the CLIENT side run in a simple way like this:
pand --connect 00:A0:B0:E0:48:25

the ERROR is :  pand[8191]: Connection failed. Permission denied(13)

the sys LOG is list below:

Apr  3 17:15:05 bip313 hcid[8180]: Bluetooth HCI daemon
Apr  3 17:15:05 bip313 hcid[8180]: HCI dev 0 registered
Apr  3 17:15:05 bip313 hcid[8180]: HCI dev 0 already up
Apr  3 17:15:05 bip313 hcid[8180]: Device hci0 has been added
Apr  3 17:15:05 bip313 hcid[8180]: Starting security manager 0
Apr  3 17:15:05 bip313 hcid[8180]: Device hci0 has been activated
Apr  3 17:15:05 bip313 hcid[8180]: Starting SDP server
Apr  3 17:15:05 bip313 hcid[8180]: Created local server at
unix:abstract=/var/run/dbus-BBAibFkMvI,guid=a5abffc66b1d327133d76e3847f49209
Apr  3 17:15:05 bip313 input[8183]: Bluetooth Input daemon
Apr  3 17:15:05 bip313 input[8183]: Registered input manager
path:/org/bluez/input
Apr  3 17:15:05 bip313 network[8184]: Bluetooth Network daemon
Apr  3 17:15:05 bip313 serial[8185]: Bluetooth Serial Port daemon
Apr  3 17:15:05 bip313 serial[8185]: Registered manager
path:/org/bluez/serial
Apr  3 17:15:05 bip313 network[8184]: Registered manager
path:/org/bluez/network
Apr  3 17:15:05 bip313 network[8184]: Registered server
path:/org/bluez/network/nap
Apr  3 17:15:05 bip313 network[8184]: Registered server
path:/org/bluez/network/gn
Apr  3 17:15:05 bip313 network[8184]: Registered server
path:/org/bluez/network/panu
Apr  3 17:17:33 bip313 pand[8189]: Bluetooth PAN daemon version 3.28
Apr  3 17:18:16 bip313 pand[8191]: Connection failed. Permission denied(13)

Please give me some idea, or I'm going to look into the souce code of
bnep_accept_connection to try to find what has happened.

Thanks ,everyone.

------=_Part_277_32967026.1207211532428
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,guys:<br><br>I use the newest 3.28 version of BlueZ and two bluetooth devices to setup the PAN&nbsp; network on two different Linux box.<br><br>the SERVER side running dbus-daemon,hcid and pand daemon like that:<br><br>&nbsp;8180 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ss&nbsp;&nbsp;&nbsp;&nbsp; 0:00 /sbin/hcid -s -f /etc/bluetooth/hcid.conf<br>
&nbsp;8183 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0:00 /lib/bluetooth/bluetoothd-service-input<br>&nbsp;8184 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0:00 /lib/bluetooth/bluetoothd-service-network<br>&nbsp;8185 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0:00 /lib/bluetooth/bluetoothd-service-serial<br>&nbsp;8189 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ss&nbsp;&nbsp;&nbsp;&nbsp; 0:00 pand --listen --master --role NAP --ethernet bnep0 --device 00:A0:B0:E0:48:25<br>
<br><br>and then,the CLIENT side run in a simple way like this:&nbsp; <br>pand --connect 00:A0:B0:E0:48:25<br><br>the ERROR is :&nbsp; pand[8191]: Connection failed. Permission denied(13)<br><br>the sys LOG is list below:<br><br>Apr&nbsp; 3 17:15:05 bip313 hcid[8180]: Bluetooth HCI daemon<br>
Apr&nbsp; 3 17:15:05 bip313 hcid[8180]: HCI dev 0 registered<br>Apr&nbsp; 3 17:15:05 bip313 hcid[8180]: HCI dev 0 already up<br>Apr&nbsp; 3 17:15:05 bip313 hcid[8180]: Device hci0 has been added<br>Apr&nbsp; 3 17:15:05 bip313 hcid[8180]: Starting security manager 0<br>
Apr&nbsp; 3 17:15:05 bip313 hcid[8180]: Device hci0 has been activated<br>Apr&nbsp; 3 17:15:05 bip313 hcid[8180]: Starting SDP server<br>Apr&nbsp; 3 17:15:05 bip313 hcid[8180]: Created local server at unix:abstract=/var/run/dbus-BBAibFkMvI,guid=a5abffc66b1d327133d76e3847f49209<br>
Apr&nbsp; 3 17:15:05 bip313 input[8183]: Bluetooth Input daemon<br>Apr&nbsp; 3 17:15:05 bip313 input[8183]: Registered input manager path:/org/bluez/input<br>Apr&nbsp; 3 17:15:05 bip313 network[8184]: Bluetooth Network daemon<br>Apr&nbsp; 3 17:15:05 bip313 serial[8185]: Bluetooth Serial Port daemon<br>
Apr&nbsp; 3 17:15:05 bip313 serial[8185]: Registered manager path:/org/bluez/serial<br>Apr&nbsp; 3 17:15:05 bip313 network[8184]: Registered manager path:/org/bluez/network<br>Apr&nbsp; 3 17:15:05 bip313 network[8184]: Registered server path:/org/bluez/network/nap<br>
Apr&nbsp; 3 17:15:05 bip313 network[8184]: Registered server path:/org/bluez/network/gn<br>Apr&nbsp; 3 17:15:05 bip313 network[8184]: Registered server path:/org/bluez/network/panu<br>Apr&nbsp; 3 17:17:33 bip313 pand[8189]: Bluetooth PAN daemon version 3.28<br>
Apr&nbsp; 3 17:18:16 bip313 pand[8191]: Connection failed. Permission denied(13)<br><br>Please give me some idea, or I&#39;m going to look into the souce code of bnep_accept_connection to try to find what has happened.<br><br>
Thanks ,everyone.<br><br>

------=_Part_277_32967026.1207211532428--


--===============1994023477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1994023477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1994023477==--
