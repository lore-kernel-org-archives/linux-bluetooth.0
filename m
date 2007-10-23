Return-Path: <maxk@qualcomm.com>
Message-ID: <471DA835.2060308@qualcomm.com>
Date: Tue, 23 Oct 2007 00:52:21 -0700
From: Max Krasnyansky <maxk@qualcomm.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net, marcel@holtmann.org
Subject: What's the purpose of the new btusb driver ?
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

I was going through latest 2.6 updates and noticed
	"Generic Bluetooth USB driver"
Why do we need it ?

The driver code looks awfully similar to my very first implementation of the hci_usb.
ie No URB queuing, etc.
I think the only thing that is wrong with hci_usb is the custom urb queuing code
(ie _urb stuff). That code was temporary at the time I put it in (year ago now). 
Greg and I were discussing merging it into USB core. I think we should just do 
that instead.
If you think URB queuing is no longer needed (I doubt it) then maybe we can just
rip that part out.

Comments ?

Max
