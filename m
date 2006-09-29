Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <451C2DCA.1080401@free.fr>
References: <451C2DCA.1080401@free.fr>
Date: Fri, 29 Sep 2006 13:44:40 +0200
Message-Id: <1159530280.6131.24.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez 3.5 and link_key_request but no pin	request
	and btsco failure
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Fabrice,

> It seems i have a prob when pairing with my headset (that used to work). 
> In syslog, i have only link_key_request but nothing about pin request.
> If we say i'm connected without pin request, i still have a prob with 
> btsco (see above).
> 
> I'm running debian etch on a 2.6.15
> 
> here is my hcid.conf:
> 
> FR-PORT:/etc/bluetooth# cat hcid.conf
> options {
>          autoinit yes;
>          security auto;
>          pairing multi;
>          passkey "0000";
> }
> device {
>          name "%h-%d";
>          class 0x3e0100;
>          iscan enable; pscan enable;
>          lm accept;
>          lp rswitch,hold,sniff,park;
> }
> 
> here is my rfcomm.conf:
> 
> FR-PORT:/etc/bluetooth# cat rfcomm.conf
> rfcomm0 {
>          bind yes;
>          device 00:03:89:AB:3D:76;
>          channel 1;
>          comment "Oreillette";
> }
> 
> 
> what i've done:
> 
> FR-PORT:/etc/bluetooth# /etc/init.d/bluetooth restart
> 
> FR-PORT:/etc/bluetooth# tail -n 12 /var/log/syslog
> Sep 28 21:48:14 localhost hcid[4897]: Bluetooth HCI daemon
> Sep 28 21:48:14 localhost hcid[4897]: Register path:/org/bluez fallback:1
> Sep 28 21:48:14 localhost hcid[4897]: HCI dev 0 registered
> Sep 28 21:48:14 localhost hcid[4897]: Register path:/org/bluez/hci0 
> fallback:0
> Sep 28 21:48:14 localhost hcid[4897]: HCI dev 0 already up
> Sep 28 21:48:14 localhost hcid[4897]: Device hci0 has been added
> Sep 28 21:48:14 localhost hcid[4897]: Starting security manager 0
> Sep 28 21:48:14 localhost sdpd[4901]: Bluetooth SDP daemon
> Sep 28 21:48:14 localhost hcid[4897]: Device hci0 has been activated
> Sep 28 21:48:14 localhost hcid[4897]: name_listener_add(:1.39)
> Sep 28 21:48:14 localhost hcid[4897]: Default passkey agent (:1.39, 
> /org/bluez/passkey_agent_4912) registered
> Sep 28 21:48:14 localhost hcid[4897]: name_listener_add(:1.40)
> 
> I put my headset in pairing mode then...
> 
> FR-PORT:/etc/bluetooth# hcitool scan
> Scanning ...
>          00:03:89:AB:3D:76       PLT 510 v.G
> 
> FR-PORT:~# hcidump -X -V  on an other console
> 
> FR-PORT:/etc/bluetooth# hcitool cc 00:03:89:AB:3D:76
> 
> FR-PORT:~# tail -f -n 5 /var/log/syslog
> Sep 28 21:58:14 localhost hcid[4897]: Passkey Agent at :1.40, 
> /org/bluez/passkey_agent_4910 timed out
> Sep 28 21:58:14 localhost hcid[4897]: Releasing agent :1.40, 
> /org/bluez/passkey_agent_4910
> Sep 28 21:58:14 localhost hcid[4897]: name_listener_remove(:1.40)
> Sep 28 22:00:02 localhost kernel: acerhk: mail led set to = 0x1
> Sep 28 22:00:28 localhost hcid[4897]: link_key_request 
> (sba=00:0B:6B:91:A2:E1, dba=00:03:89:AB:3D:76)
> 
> --> not asking for a pin key
> FR-PORT:~# hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.31
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>      bdaddr 00:03:89:AB:3D:76 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>      Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>  > HCI Event: Command Status (0x0f) plen 4
>      Create Connection (0x01|0x0005) status 0x00 ncmd 1
>  > HCI Event: Link Key Request (0x17) plen 6
>      bdaddr 00:03:89:AB:3D:76
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>      bdaddr 00:03:89:AB:3D:76 key 458E0ED3B6E315C6394005E9F9E9AFA1
>  > HCI Event: Command Complete (0x0e) plen 10
>      Link Key Request Reply (0x01|0x000b) ncmd 1
>      status 0x00 bdaddr 00:03:89:AB:3D:76
>  > HCI Event: Connect Complete (0x03) plen 11
>      status 0x00 handle 6 bdaddr 00:03:89:AB:3D:76 type ACL encrypt 0x00
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>      handle 6 policy 0x0f
>      Link policy: RSWITCH HOLD SNIFF PARK
>  > HCI Event: Command Complete (0x0e) plen 6
>      Write Link Policy Settings (0x02|0x000d) ncmd 1
>      status 0x00 handle 6
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>      bdaddr 00:03:89:AB:3D:76 mode 2 clkoffset 0x0000
>  > HCI Event: Command Status (0x0f) plen 4
>      Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>  > HCI Event: Remote Name Req Complete (0x07) plen 255
>      status 0x00 bdaddr 00:03:89:AB:3D:76 name 'PLT 510 v.G'
> 
> at the end:
> FR-PORT:/etc/bluetooth# hcitool con
> Connections:
>          < ACL 00:03:89:AB:3D:76 handle 6 state 1 lm MASTER
> 
> 
> Does it mean that my headset is correctly connected ?

this is not a paring problem. The pairing works fine and the device is
connected. Your problem is different and it looks like a btsco problem.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
