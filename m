Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
From: Marcel Holtmann <marcel@holtmann.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, linux-bluetooth@vger.kernel.org,
	linux-usb@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0808191032250.2669-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0808191032250.2669-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Tue, 19 Aug 2008 17:18:54 +0200
Message-Id: <1219159134.7591.155.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alan,

> > > > example have the USB core queue submitted URBs until the new alternate
> > > > setting has been selected?
> > > 
> > > this one's for you. Is there a deeper reason we enable and disable endpoints
> > > therein?
> 
> There is.  Endpoint properties can and do differ between altsettings.  
> In order to work properly, the host controller hardware needs to be
> aware of changes in the endpoint properties.  The only way to
> accomplish this is to disable the endpoints for the altsetting going
> away (thereby flushing their properties from the controller hardware)  
> and then to enable the endpoints for the altsetting coming into
> existence.
> 
> > just let me give you details on rational behind my question. A Bluetooth
> > USB device uses two interfaces. The first one for control (commands),
> > interrupt (event) and bulk (ACL data) endpoints. The second interface
> > contains the isoc (SCO data) endpoints.
> > 
> > T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> > D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > P:  Vendor=0bf8 ProdID=1003 Rev=53.42
> > C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
> > I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> > E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > I:* If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
> 
> What is that last interface for?  It doesn't appear to be very useful, 
> with no endpoints (and no driver)...

that is DFU. Don't worry about that one.

> > The second interface contains 6 alternate settings and you have to
> > select them based on your voice setting (8-bit or 16-bit) and the number
> > of SCO connections (0-3).
> > 
> > The Bluetooth specification has the details, but when using 16-bit input
> > data and one SCO connection, you have to select alternate setting #2. If
> > no SCO connections are open, we have to go with setting #0.
> 
> And presumably, if the number of SCO connections increases from one to 
> two then you need to switch to yet another altsetting -- while keeping 
> the existing connection intact, yes?

The connection will be kept alive. That is not the problem. We have to
cancel all URBs, select the new setting and then re-submit them.

> > So we can't have isoc URBs running all them time since that would drain
> > power. The old hci_usb did it this way and was an obvious issue showing
> > up on powertop.
> > 
> > The Bluetooth subsystem calls our notify() callback when the number of
> > connection or the voice setting changes. However this context can't
> > sleep and thus we can't call usb_set_interface().
> 
> That's the real problem.  Why doesn't opening or closing a connection 
> take place in a sleepable process context?

Because we get the HCI event for an established connection in an
interrupt context and then do the notifications based on that.

> > Right now are using a
> > workqueue, but that is not an optimal solution since as Oliver pointed
> > correctly out, we have no idea when this gets scheduled.
> > 
> > My question is if we can have a usb_set_interface() version that we can
> > call from interrupt context and that will queue the URBs that we submit
> > in between until the new alternate setting has been selected.
> > 
> > I personally think the Bluetooth USB specification is broken and a bad
> > design, but that is what we have at the moment.
> 
> I don't know how much of this comes from the Bluetooth USB spec and how 
> much comes from the design of the Bluetooth subsystem.  It sounds like 
> you're being asked to do too much in too short a time.

As mentioned above, there is nothing much we can do. Once we get the
connection established event, we have to submit URBs. The event comes in
via an interrupt URB. In theory we could defer the processing of the HCI
events, but that would have bad impact on all other parts of Bluetooth
and doing this only for audio makes no sense.

> Is it possible to change the subsystem design so that, for example, in
> addition to getting a notify() callback when the connection settings
> change, you also call a ready() function in the subsystem core to tell
> it when the new settings are ready for use?

I was thinking about that. However it is still the same problem. We do
have to submit URBs as soon as the connection is up. For the bulk URBs
(for ACL) it is no problem. The only issue is with isoc URB (for SCO),
because we have to pick an alternate setting first.

> If not, and you are forced to rely on queuing URBs for later 
> submission, then I think it might be more appropriate to do this 
> queuing in the Bluetooth driver code rather than in usbcore.  You could 
> have an entire anchor devoted to deferred URBs.

What happens if we submit the isoc URBs right away and the call
usb_set_interface at some later time. Will these be canceled or what
happens to them when switching the endpoint.

Regards

Marcel


