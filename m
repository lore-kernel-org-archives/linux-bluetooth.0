Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <420BDA1B.7040708@web.de>
From: Andreas Millinger <andreas.millinger@web.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-devel] PCMCIA/hciattach problem
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
Date: Thu, 10 Feb 2005 23:03:07 +0100

Hello Marcel,

>so no SMP and no PREEMPT. This means that this can't be a deadlock and
>there should be no problem, but you can try to disable the REGPARM.
>  

I have done some tests with different PCMCIA-Cards. It seams, that this 
problem doesn`t depend on the bluetooth subsystem. With other cards, 
there is also a error when shuting down (but no freez). And when no card 
is in PCMCIA there is a error, too:

FATAL: Module yenta_socket is in use

output of lspci is:

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8605 [ProSavage PM133]
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8605 [PM133 AGP]
0000:00:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
0000:00:06.0 Communication controller: Ambient Technologies Inc HaM 
controllerless modem (rev02)
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
South] (rev 40)
0000:00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 1a)
0000:00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
ACPI] (rev 40)
0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. 
VT82C686 AC97 Audio Controller (rev 50)
0000:00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller 
(rev 01)
0000:00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller 
(rev 01)
0000:00:0d.0 FireWire (IEEE 1394): Agere Systems (former Lucent 
Microelectronics) FW323 (rev 04)
0000:01:00.0 VGA compatible controller: S3 Inc. 86C380 [ProSavageDDR 
K4M266] (rev 02)

What to do now? If I should post on the kernel mailing list, where do I 
find the kernel mailing list? And what information is needed?

Best regards
Andreas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
