Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Peter Johanson <peter@peterjohanson.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20050114051845.GA23441@butchy.cubesearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Philips PC Card + 2.6.10 kernel.
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
Date: Thu, 13 Jan 2005 21:18:45 -0800

Hey all,

I'm working on getting a newly aquired Philips PC Card working, using a
2.6.10 kernel (-gentoo-r4 to be specific). I believe i've run into the
problem as described here (and as potentially fixed for some -mmX sources):
http://sourceforge.net/mailarchive/message.php?msg_id=9953048,
which claimed to be resolved for 2.6.10-rc1-mm2, which I also gave a
try, but was unable to actually test, as my keyboard refused to work
with that kernel. I've also tried 2.6.10-mm2, with the same failure.
Here's the info on the card:

lspci -vvv for the card:
0000:03:00.0 Serial controller: Oxford Semiconductor Ltd OXCB950 Cardbus 16950 UART (prog-if 06 [16950])
	Subsystem: Oxford Semiconductor Ltd: Unknown device 0001
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 4010
	Region 1: Memory at 40800000 (32-bit, non-prefetchable) [size=4K]
	Region 2: I/O ports at 4000 [size=16]
	Region 3: Memory at 40801000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at 40802000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

dmesg, after implementing the small patch discussed here to recognize the card
http://www.cs.helsinki.fi/linux/linux-kernel/2002-08/1374.html:

PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ttyS14: detected caps 00000700 should be 00000100
ttyS14 at I/O 0x4010 (irq = 11) is a 16C950/954

Having found the specs based on the FCC ID on the FCC site, i know this
is the OXford Semiconductor chipset with a BlueCore01 inside. As such, I
tried:
gonzo root # hciattach /dev/ttyS14 bcsp 921600
BCSP initialization timed out

Was there ever any success in finding out what had changed for the user
who reported success for 2.6.10-r1-mm2? Any suggestions on ways to debug
this? Thanks in advance.

-pete

-- 
Peter Johanson
<latexer@gentoo.org>


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
