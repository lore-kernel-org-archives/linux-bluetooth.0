Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] D-Link DBT-120
From: Gene Imes <ebi7@ozob.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1078503094.3700.5.camel@pegasus>
References: <1078322158.11523.83.camel@go2>
	 <1078322721.2787.86.camel@pegasus>  <1078339075.8547.2.camel@go2>
	 <1078487569.2762.56.camel@pegasus>
	 <1078493466.27893.11.camel@tr1a.ozob.net> <1078503094.3700.5.camel@pegasus>
Content-Type: text/plain
Message-Id: <1078518584.11763.2.camel@tr1a.ozob.net>
Mime-Version: 1.0
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
Date: Fri, 05 Mar 2004 14:29:44 -0600

On Fri, 2004-03-05 at 10:11, Marcel Holtmann wrote:
> Hi Gene,
> 
> > Marcel, I am not sure which patch fixes this but I was rebooting once
> > and pulled the DBT-120 out and got an oops or whatever. As much as I
> > could see looked like it may be the USB stuff.
> 
> what kind of USB host controller driver do you use? What do lspci say?

Hope this helps.

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y


root@tr1a:/usr/src# lspci
0000:00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
0000:00:00.1 System peripheral: Intel Corp.: Unknown device 3584 (rev
02)
0000:00:00.3 System peripheral: Intel Corp.: Unknown device 3585 (rev
02)
0000:00:02.0 VGA compatible controller: Intel Corp. 82852/855GM
Integrated Graphics Device (rev 02)
0000:00:02.1 Display controller: Intel Corp. 82852/855GM Integrated
Graphics Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller
(rev 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage
Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97
Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 03)
0000:02:05.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev b8)
0000:02:05.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C551 IEEE 1394
Controller
0000:02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (MOB)
Ethernet Controller (rev 83)
0000:02:0b.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B
Mini PCI Adapter (rev 04)

Gene



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
