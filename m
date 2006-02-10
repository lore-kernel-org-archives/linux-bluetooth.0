Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43ECFB21.3030101@gmail.com>
From: nix4me@gmail.com
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Re: bluez and dbus
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
Date: Fri, 10 Feb 2006 13:44:17 -0700

Marcel,

>it should be started from /etc/init.d/bluetooth depending on your Linux
>distribution. You get a connection once you press a key on your
>keyboard.

I happen to have the m$ dongle that came with the keyboard.
It does have a CCR chip, so is it flashable for HID proxy support?



$hciconfig hci0 features
hci0:   Type: USB
        BD Address: 00:50:F2:E4:B6:C5 ACL MTU: 192:8 SCO MTU: 64:8
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO>
root@slack |
/home/chopp/downloads/bluez | 02:11:16
$hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:50:F2:E4:B6:C5 ACL MTU: 192:8 SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x1f9 LMP Ver: 1.1 (0x1) LMP Subver: 
0x1f9
        Manufacturer: Cambridge Silicon Radio (10)
root@slack |
/home/chopp/downloads/bluez | 02:11:49
$hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:50:F2:E4:B6:C5 ACL MTU: 192:8 SCO MTU: 64:8
        HCI 16.1.1
        Chip version: BlueCore02-External
        Max key size: 128 bit
        SCO mapping:  HCI


also the DBT-122 that I have, sais the HCI version is 1.2, which would 
make it a (RevB3)
but all the other info I see on it seem's to say otherwise?
http://www.holtmann.org/linux/bluetooth/features.html

if it really is (RevB3), isn't this chip also able to be upgraded to HID 
proxy support?

$hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:13:46:AD:A1:8C ACL MTU: 377:10 SCO MTU: 16:0
        Firmware 0.3 / 9
root@slack |
/home/chopp/downloads/bluez | 02:13:17
$hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:13:46:AD:A1:8C ACL MTU: 377:10 SCO MTU: 16:0
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
        Manufacturer: Broadcom Corporation (15)
root@slack |
/home/chopp/downloads/bluez | 02:14:14
$hciconfig hci0 features
hci0:   Type: USB
        BD Address: 00:13:46:AD:A1:8C ACL MTU: 377:10 SCO MTU: 16:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
                <transparent SCO> <enhanced iscan> <interlaced iscan>
                <interlaced pscan> <AFH cap. slave> <AFH cap. master>

any info would be greatly appreciated, and thank you for the help thus far.

Regard's
Doug


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
