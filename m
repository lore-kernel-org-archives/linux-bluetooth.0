Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b9c3b3cf0702210031j128eaed0p2d0cbee303215fc3@mail.gmail.com>
Date: Wed, 21 Feb 2007 09:31:01 +0100
From: "Ion Jaureguialzo Sarasola" <widemos@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Microsoft Wireless Presenter for Notebook 8000 and
	Macbook Internal Bluetooth
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1248687765=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1248687765==
Content-Type: multipart/alternative;
	boundary="----=_Part_133_698271.1172046661235"

------=_Part_133_698271.1172046661235
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, and using this combination and I can get the mouse working under Ubuntu
Feisty Fawn Herd4, but the wheel, and extra buttons are not seen by the
system.

I've tried to watch events which reach to /dev/input/event3 (where the mouse
is supposed to be) and can only see the events produced by left, right and
wheel-click. Also mouse movement is detected. Any other button, including
presentation buttons don't work.

My system's lspci:

00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT
Express Memory Controller Hub (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile 945GM/GMS/940GML
Express Integrated Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/940GML
Express Integrated Graphics Controller (rev 03)
00:07.0 Performance counters: Intel Corporation Unknown device 27a3 (rev 03)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port
1 (rev 02)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port
2 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1
(rev 02)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2
(rev 02)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3
(rev 02)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4
(rev 02)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge
(rev 02)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller
(rev 02)
00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial
ATA Storage Controller IDE (rev 02)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev
02)
01:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E
Gigabit Ethernet Controller (rev 22)
02:00.0 Network controller: Atheros Communications, Inc. Unknown device 0024
(rev 01)
03:03.0 FireWire (IEEE 1394): Agere Systems FW323 (rev 61)Linux macbook
2.6.20-8-generic #2 SMP Tue Feb 13 05:18:42 UTC 2007 i686 GNU/Linux

And my kernel version:

Linux macbook 2.6.20-8-generic #2 SMP Tue Feb 13 05:18:42 UTC 2007 i686
GNU/Linux

Suggestions?

-- 
Ion Jaureguialzo Sarasola
widemos@gmail.com
Vitoria-Gasteiz
Spain

------=_Part_133_698271.1172046661235
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, and using this combination and I can get the mouse working under Ubuntu Feisty Fawn Herd4, but the wheel, and extra buttons are not seen by the system.<br><br>I&#39;ve tried to watch events which reach to /dev/input/event3 (where the mouse is supposed to be) and can only see the events produced by left, right and wheel-click. Also mouse movement is detected. Any other button, including presentation buttons don&#39;t work.
<br><br>My system&#39;s lspci:<br><br>00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express Memory Controller Hub (rev 03)<br>00:02.0 VGA compatible controller: Intel Corporation Mobile 945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)
<br>00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)<br>00:07.0 Performance counters: Intel Corporation Unknown device 27a3 (rev 03)<br>00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
<br>00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 02)<br>00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 02)<br>00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 02)
<br>00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 02)<br>00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 02)<br>00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 02)
<br>00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02)<br>00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)<br>00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 02)
<br>00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 02)<br>00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controller IDE (rev 02)<br>00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
<br>01:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E Gigabit Ethernet Controller (rev 22)<br>02:00.0 Network controller: Atheros Communications, Inc. Unknown device 0024 (rev 01)<br>03:03.0 FireWire (IEEE 1394): Agere Systems FW323 (rev 61)Linux macbook 
2.6.20-8-generic #2 SMP Tue Feb 13 05:18:42 UTC 2007 i686 GNU/Linux<br><br clear="all">And my kernel version:<br><br>Linux macbook 2.6.20-8-generic #2 SMP Tue Feb 13 05:18:42 UTC 2007 i686 GNU/Linux<br><br>Suggestions?<br>
<br>-- <br>Ion Jaureguialzo Sarasola<br><a href="mailto:widemos@gmail.com">widemos@gmail.com</a><br>Vitoria-Gasteiz<br>Spain

------=_Part_133_698271.1172046661235--


--===============1248687765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1248687765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1248687765==--
