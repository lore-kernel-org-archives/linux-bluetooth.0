Return-Path: <wim.delvaux@adaptiveplanet.com>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] 2.6.5 problems turned to 2.6.3 but also problems
Date: Mon, 12 Apr 2004 13:17:52 +0200
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <200404120349.34338.wim.delvaux@adaptiveplanet.com> <1081767326.5398.87.camel@pegasus>
In-Reply-To: <1081767326.5398.87.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404121317.52361.wim.delvaux@adaptiveplanet.com>
List-ID: <bluez-devel.lists.sourceforge.net>

I have tried with that version. (Applied the 2.6.5-mh3 patch)
However then I get these 'bad atomic' errors

I just retried with the 2.6.3 kernel and saw

'device not accepting address' messages error -110
And then

drivers/usb/host/uhci-hcd.c: uhci_result_control() failed with status 440000
[ceb01240] link (0eb011e2) element (0ecb9040)
  0: [cecb9040] link (0ecb9080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 
EndPt=0 Dev=0, PID=2d(SETUP) (buf=0bd05e40)
  1: [cecb9080] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 
Dev=0, PID=69(IN) (buf=00000000)

after a few inserts it gives

usb 1-1: new full speed USB device using address 10
usb 1-1: new device strings: Mfr=0, Product=0, SerialNumber=0
drivers/usb/core/usb.c: usb_hotplug
usb 1-1: registering 1-1:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
usb 1-1: registering 1-1:1.1 (config #1, interface 1)
drivers/usb/core/usb.c: usb_hotplug
usb 1-1: registering 1-1:1.2 (config #1, interface 2)
drivers/usb/core/usb.c: usb_hotplug
Bluetooth: HCI USB driver ver 2.4
hci_usb 1-1:1.0: usb_probe_interface
hci_usb 1-1:1.0: usb_probe_interface - got id
hci_usb 1-1:1.1: usb_probe_interface
hci_usb 1-1:1.2: usb_probe_interface
hci_usb 1-1:1.2: usb_probe_interface - got id
drivers/usb/core/usb.c: registered new driver hci_usb
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb c4d61214 err -22
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb c4d61214 err -22

W


On Monday 12 April 2004 12:55, Marcel Holtmann wrote:
> Hi Wim,
>
> > I have checked the devel list like greg pointed me out and after applying
> > all patches but with no help I turned back to 2.6.3.
> >
> > However There I get bluetooth errors too.
> >
> > hci_usb_isoc_rx_submit : hci0 isoc rx submit failed urb cec4e814 err -22
> >
> > Two times
> >
> > removing the usb dongle causes a kernel oops
> >
> > call trace is  (Typed over by hand)
> >
> > EIP is at uhci_remove_pending_qhs+0x63/0xb8 [uhci_hcd]
> > ...
> > process : hcid
> >
> > calltrace :
> >
> > 	uhci_irq+0x90/0x159 [uhci_hcd]
> > 	usb_hcd_irq+0x36/0x67 [usbbcore]
> > 	handle_IRQ_event+0x3a/0x64
> > 	do_IRQ+0x94/0x136
> > 	common_interrupt+0x18/0x20
> >
> > That means that for I do not know what reason my two systems are
> > completely messed up because of usb/bluetooth problems (*** crying tears
> > like rivers ***)
> >
> > I tried with 2.4.25/2.4.26-rc2 2.6.3/2.6.5 and mm  and even applied
> > patches on bluez download site
> >
> > Then I can insert my dongle but when I unplug I get A WHOLE LOT of
> >
> > 'bad atomic while scheduling'
> > and a call trace with top function schedule
>
> please try 2.6.5-mh3.
>
> Regards
>
> Marcel
