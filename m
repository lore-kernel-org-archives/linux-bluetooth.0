Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41AA747D.5020800@vdsoft.org>
From: Vladimir Dvorak <dvorakv@vdsoft.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] BCM203x - firmware load failed
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
Date: Mon, 29 Nov 2004 01:59:41 +0100


Hi *,

I have a problem with Belkin Bluetooth USB adapter based on BCM203x 
chip. When I plug this dongle into USB port, kernel returns:

Bluetooth: Broadcom Blutonium firmware driver ver 1.0
bcm203x_probe: Mini driver request failed
bcm203x: probe of 2-1:1.0 failed with error -5
usbcore: registered new driver bcm203x

I am using :

# cat /proc/versions
Linux version 2.6.9-9-amd64-k8 (root@athlon.lowpingbastards.de) (gcc 
version 3.4.2 (Debian 3.4.2-3)) #1 Wed Nov 10 19:02:19 CET 2004

#lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0282
0000:00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1282
0000:00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2282
0000:00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3282
0000:00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4282
0000:00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7282
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge 
[K8T800 South]
0000:00:0a.0 Ethernet controller: Marvell Technology Group Ltd. Yukon 
Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)
0000:00:0c.0 Network controller: RaLink Ralink RT2500 802.11 Cardbus 
Reference Card (rev 01)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA 
RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge 
[K8T800 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: nVidia Corporation NV18 
[GeForce4 MX 440 AGP 8x] (rev c1)


The same configuration is working for me on other hardware very well.

Could you have a look please ? Thank you.


Vladimir


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
