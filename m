Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3F4F6BF2.6080303@gtmp.org>
From: "Alexandre Jousset@NL" <mid@gtmp.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Belkin F8T002 PC Card problem with Bluez
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 29 Aug 2003 17:06:26 +0200
Content-Type: text/plain; CHARSET=us-ascii; FORMAT=flowed

	Hi all,

	I am trying for 3 days to configure this card on my laptop. I am 
running Mandrake 9.2beta with a hand-compiled kernel 2.4.22.

	First, to make my card recognized by the hardware, I have to enter 
"cardctl insert". It does not do this automatically. Is this normal ? 
But when I remove the card it beeps and knows that the card is no more 
here. But this is not the most important problem... Here it is...

	I succeeded to know what to do to have the card recognized by the 
kernel (compile with CONFIG_SERIAL as a module) and now when I do the 
"cardctl insert"command, I have the new /dev/ttyS4 device that appears. 
OK. But then, when I try to hciattach it with "hciattach /dev/ttyS4 any 
flow", the CPU is loaded and in the /var/log/messages logfile is 
appended a lot of lines, all the same, saying "h4_recv: Unknown HCI 
packet type ef", with the last "ef" changed with "0f", "18", etc... each 
time a different hexadecimal number.

	I patched the drivers/char/serial.c module source and the 
include/linux/pci_ids.h to have the chip recognized by the serial module.

	Output of lspci -vv is :
-------------------------------------------
[...]
02:00.0 Serial controller: Oxford Semiconductor Ltd OXCB950 Cardbus 
16950 UART (prog-if 06 [16950])
         Subsystem: Oxford Semiconductor Ltd: Unknown device 0001
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at 4000 [size=8]
         Region 1: Memory at 20800000 (32-bit, non-prefetchable) [size=4K]
         Region 2: I/O ports at 4010 [size=16]
         Region 3: Memory at 20801000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at 20802000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [40] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
-------------------------------------------

Output of setserial /dev/ttyS4 is :
-------------------------------------------
/dev/ttyS4, UART: 16950/954, Port: 0x4000, IRQ: 11
-------------------------------------------

	This is my first try with bluetooth so if I made something wrong, 
please tell me...

	So, why is my log full of unknown HCI packets ? Thanks in advance.
-- 
    \^/   Cordialement/Regards,
  -/ O \----------------------------------------
| |/ \|       Alexandre (Midnite) Jousset      |
  -|___|----------------------------------------



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
