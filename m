Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1089366625.6730.7.camel@pc-04.ycom.ch>
Mime-Version: 1.0
Subject: [Bluez-users] USB Died
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 09 Jul 2004 11:50:25 +0200

Hi there, 

I'm using diNovo keyb/mice, and I always have this problem, from
2.6.2-mhx to 6.7.1-mh1 and the new hipd kernel module.

Let me list my hardware (only the USB port I'm using for BT hub) :
0000:00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)

The problem is that the USB bus (?) died after some time to work (couple
of days), not depend what I'm doing (use keyboard, mice, or nothing).

There is the dmesg related :
uhci_hcd 0000:00:10.1: host system error, PCI problems?
uhci_hcd 0000:00:10.1: host controller halted, very bad!

Complete USB info for that port :
lspci -vvv
0000:00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
(prog-if 00 [UHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
device c060
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


And there is the same status BEFORE hang :
0000:00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
(prog-if 00 [UHCI])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown
device c060
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-




Could you help me ? This is a very boring problem.

Best regards
-- 
	Alexandre



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
