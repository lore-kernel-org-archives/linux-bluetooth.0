Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <AFE91B59A185A5439840B43AB7919047A83D75@mchp997a.mch.sbs.de>
From: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
To: "'Bluez-devel@lists.sourceforge.net'" <Bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bluez-devel] scotest cant receive
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 28 Feb 2005 14:04:37 +0100

Hi all,

I have a problem with scotest on Linux (same with hsplay). I can send SCO
packets, I can see them
physical being sent indicated by blinking LEDs. But I cant receive any SCO
packets.
I tried with two different chipset (features and revision see below), I am
sure that
at least the Infineon works for SCO traffic (under Symbian OS).

I tried with different kernels 2.4.19, 2.4.21, 2.6.9, with SCO support
build-in.

But it's always the same: 
- hcidump of the sender indicates SCO packets sent (< SCO data: handle
0x002c dlen 64)
and error messages: CSR chipset says "HCI Event: Hardware Error", Infineon
says "Data overfolw", 
but both are still sending.
- hcidump on the receiver side shows no SCO packets and no Errors 
- /var/log/messages looks inconspicuous (Wait for connection, Connected from
.., Receiving..).
- The last output of scotest itself is "Sending..." resp. "Receiving...",
but
no packets are shown.
- It is the "recv" in the function recv_mode in scotest.c, that blocks
forever.
- lsmod shows module "sco" Used by 1 and it shows that "bluez" is used by
"sco" and "hci_uart".


I found no SCO-HOWTO. So what I am doing is just
hcid, hciattach and "scotest -r" resp "scotest -s <remote BDADDR>"

Has anyone an idea, what is going wrong?

Thanks, Matthias



CSR:
linux:~ # hciconfig hci0 revision
hci0:   Type: UART
        BD Address: 00:60:57:0A:5D:0B ACL MTU: 192:8  SCO MTU: 64:8
        HCI 16.4 (bc02x)
linux:~ # hciconfig hci0 features
hci0:   Type: UART
        BD Address: 00:60:57:0A:5D:0B ACL MTU: 192:8  SCO MTU: 64:8
        Features: 0xff 0xff 0x0b 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park mode> <RSSI> <channel quality> <SCO link>
                <HV2 packets> <HV3 packets> <u-law log> <A-law log>
                <CVSD> <paging scheme> <transparent SCO>

Infineon:
linux:~ # hciconfig hci0 revision
hci0:   Type: UART
        BD Address: 00:06:57:0A:5D:0B ACL MTU: 339:5  SCO MTU: 120:6
        Unsupported manufacturer
linux:~ # hciconfig hci0 features
hci0:   Type: UART
        BD Address: 00:06:57:0A:5D:0B ACL MTU: 339:5  SCO MTU: 120:6
        Features: 0xef 0xfb 0x1d 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <role switch> <hold mode> <sniff mode> <park mode>
                <RSSI> <SCO link> <HV2 packets> <HV3 packets>
                <u-law log> <A-law log> <CVSD> <power control>
                <transparent SCO>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
