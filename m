Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mr Jie Liu <s4048156@student.uq.edu.au>
To: bluez-devel@lists.sourceforge.net
Message-ID: <2260c2221e01.221e012260c2@uq.edu.au>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] problem with hstest
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 18 May 2004 20:00:43 +1000

hi
  I am using Anycom's USB 220 and it is not based on CSR chip. Here is the device information of it on my computer:
[root@tom sbin]# ./hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:0B:0D:21:9E:81 ACL MTU: 339:4  SCO MTU: 64:0
        HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subver: 0x93
        Manufacturer: Transilica, Inc. (24)
[root@tom sbin]# ./hciconfig hci0 features
hci0:   Type: USB
        BD Address: 00:0B:0D:21:9E:81 ACL MTU: 339:4  SCO MTU: 64:0
        Features: 0xff 0xff 0x3d 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park mode> <RSSI> <channel quality> <SCO link>
                <HV2 packets> <HV3 packets> <u-law log> <A-law log>
                <CVSD> <power control> <transparent SCO>
[root@tom sbin]# ./hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0B:0D:21:9E:81 ACL MTU: 339:4  SCO MTU: 64:0
        Unsupported manufacturer

Is there any other way I could figure out if the sco packets are routed through HCI or PCM interface? Can I trace it by hcidump?


Hi,
> I try to play sound through my HBH-35 headset. I am using the hstest program of the bluez package to test the headset profile. But I can't hear anything through the headset. The voice setting is right(0x0060). I can establish rfcomm and soc link with the headset and the AT command seems to work fine because I can hear the RING tone. When I push the button on the headset, the AT command could also be printed out correctly. I use "hstest re
cor
> d sound X:X:X:X:X:X X" to record a file. Then I try to replay it by "hstest play sound X:X:X:X:X:X X". But there is nothing from the headset and the program also has no error message. Has anyone experienced this before? What kind of information should I provide to analyse it? 

check if the SCO data is routed through the HCI or through the PCMinterface of your Bluetooth dongle. If your dongle is CSR based, thiscan be done with "hciconfig hci0 revision".

Regards

Marcel



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
