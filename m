Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] how to do inquiry with RSSI in bluetooth 1.2
	devices?
From: Marcel Holtmann <marcel@holtmann.org>
To: albert@csail.mit.edu
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ef9938ec04101511326a6342c3@mail.gmail.com>
References: <ef9938ec041012125930f0b8e3@mail.gmail.com>
	 <1097658003.4643.17.camel@notepaq>
	 <ef9938ec04101511326a6342c3@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1097928625.4911.30.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 16 Oct 2004 14:10:25 +0200

Hi Albert,

> > > When I run this with the anycom bluetooth device, the very first
> > > hci_send_req never returns.  I expected the READ_INQUIRY_MODE command
> > > to generate a CMD_COMPLETE event, but no event is ever generated (I
> > > tested this separately).  Also, when hcidump is run concurrently with
> > > this program, it doesn't pick anything up (no events are read by
> > > hcidump)  The same happens if I try to set the inquiry mode directly
> > > without reading it first (the WRITE_INQUIRY_MODE command never
> > > returns)
> > 
> > I never saw that on my dongle. Please recompile your kernel without the
> > SCO audio support for the hci_usb driver. What kind of USB host
> > controller are you using? What kernel version do you use?
> 
> I am using kernel 2.4.27, compiled from sources available in the
> debian repository.  I recompiled without SCO audio support for hci_usb
> and got the same result.
> 
> How do I find out what kind of USB host controller I'm using?  lspci
> gives the following output:
> 
> 0000:00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 04)
> 0000:00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)
> 0000:00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 04)
> 
> dmesg shows the following lines related to USB
> 
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-uhci.c: $Revision: 1.275 $ time 17:39:55 Oct 14 2004
> usb-uhci.c: High bandwidth mode enabled
> usb-uhci.c: USB UHCI at I/O 0xff80, IRQ 19
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> usb-uhci.c: USB UHCI at I/O 0xff60, IRQ 18
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> hub.c: new USB device 00:1f.2-2, assigned address 2
> usb.c: USB device 2 (vend/prod 0xa12/0x1) is not claimed by any active driver.
> BlueZ HCI USB driver ver 2.7 Copyright (C) 2000,2001 Qualcomm Inc
> usb.c: registered new driver hci_usb
> hub.c: new USB device 00:1f.4-1, assigned address 2

what is actually attached on your USB bus (check with lsusb), because
this device is a CSR dongle and the one from your other email is not.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
