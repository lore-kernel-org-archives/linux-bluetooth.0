Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41597F43.9060208@xs4all.nl>
From: Stefan de Konink <skinkie@xs4all.nl>
MIME-Version: 1.0
To: bluez devel <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] testing Bleuz/SCO with hsplay
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 28 Sep 2004 17:12:03 +0200

Hello,

For the Asterisk PABX I'm testing the Bluetooth functionality of a Nokia 
phone to be used as phone channel. Still in the basic stage I allready 
have a problem.

attest works, I get the complete list of the phonenumbers and names. So 
heading straight for hsplay. The phone is connected by bluetooth, the 
little headset icon is on the phone's display, but when I call out with 
the phone I still have no MP3 playing on my ear.

Some output of hciconfig:
hci0:   Type: USB
         BD Address: 00:02:8A:DB:39:04 ACL MTU: 192:8  SCO MTU: 64:8
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                 <3-slot packets> <5-slot packets> <encryption> <slot 
offset>
                 <timing accuracy> <role switch> <hold mode> <sniff mode>
                 <park state> <RSSI> <channel quality> <SCO link> <HV2 
packets>
                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging 
scheme>
                 <power control> <transparent SCO>

hci0:   Type: USB
         BD Address: 00:02:8A:DB:39:04 ACL MTU: 192:8  SCO MTU: 64:8
         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP 
Subver: 0x20d
         Manufacturer: Cambridge Silicon Radio (10)

hci0:   Type: USB
         BD Address: 00:02:8A:DB:39:04 ACL MTU: 192:8  SCO MTU: 64:8
         HCI 16.4
         Chip version: BlueCore02
         Max key size: 56 bit
         SCO mapping:  HCI


Anyone some pointers to look at?


Greetings,

Stefan de Konink


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
