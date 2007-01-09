Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Valentin Plugaru <zmotok@cauterized.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Tue, 9 Jan 2007 23:01:00 +0100
MIME-Version: 1.0
Message-Id: <200701092301.00719.zmotok@cauterized.net>
Subject: [Bluez-users] link speed
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

Hello list,

I'm using a SonyEricsson K610i (specs below) paired to a Conceptronic usb 
bluetooth adapter and I'm seeing speeds of about 30KB/s up and down which is 
quite low for bluetooth 2.0.
I'm using a Debian with kernel 2.6.18, BlueZ 3.7 and KDE's bluetooth daemon 
(and obex kioslaves) to send/receive files from the phone.
I've seen the thread (archive here: 
http://www.archivesat.com/BlueZ_users/thread2033968.htm ) in which Marcel 
Holtmann said that both "sides" have to support EDR packets to achieve the 
(maximum) 3Mbit/s speed - and from what I can tell, both my phone and the 
adapter do support them, so why the low speed?

<> The bluetooth adapter is a Conceptronic CBT200U2 
hci0:   Type: USB
        BD Address: foobar ACL MTU: 384:8 SCO MTU: 64:8
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO> <broadcast encrypt>
                <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
                <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
                <extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave>
                <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
                <AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps>
                <EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features>
<> The phone:
BD Address:  foo
        Device Name: bar
        LMP Version: 2.0 (0x3) LMP Subversion: 0x520
        Manufacturer: ST Microelectronics (48)
        Features: 0xff 0xeb 0x8d 0xfe 0x9b 0xe9 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <SCO link> <HV3 packets> <u-law log>
                <A-law log> <CVSD> <power control> <transparent SCO>
                <broadcast encrypt> <EDR ACL 2 Mbps> <EDR ACL 3 Mbps>
                <enhanced iscan> <interlaced iscan> <interlaced pscan>
                <inquiry with RSSI> <extended SCO> <EV4 packets> <EV5 packets>
                <AFH cap. slave> <AFH class. slave> <3-slot EDR ACL>
                <5-slot EDR ACL> <AFH cap. master> <EDR eSCO 2 Mbps>
                <EDR eSCO 3 Mbps> <3-slot EDR eSCO>

What could be the problem/answer? I'm perfectly willing to do tests/give more 
information about both devices.

Thanks!

Valentin

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
