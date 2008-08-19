Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Aug 2008 11:53:22 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Oliver Neukum <oliver@neukum.org>,  <linux-bluetooth@vger.kernel.org>,
     <linux-usb@vger.kernel.org>
Subject: Re: [rfc]btusb with SCO support
In-Reply-To: <1219159134.7591.155.camel@violet.holtmann.net>
Message-ID: <Pine.LNX.4.44L0.0808191142160.2669-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 19 Aug 2008, Marcel Holtmann wrote:

> > And presumably, if the number of SCO connections increases from one to 
> > two then you need to switch to yet another altsetting -- while keeping 
> > the existing connection intact, yes?
> 
> The connection will be kept alive. That is not the problem. We have to
> cancel all URBs, select the new setting and then re-submit them.

Along with any URBs that were generated while the new altsetting was 
being installed, right?

If you're already keeping track of old URBs that were cancelled, why is 
it hard to keep track of new URBs as well?

> As mentioned above, there is nothing much we can do. Once we get the
> connection established event, we have to submit URBs. The event comes in
> via an interrupt URB. In theory we could defer the processing of the HCI
> events, but that would have bad impact on all other parts of Bluetooth
> and doing this only for audio makes no sense.

How about deferring only the submission of isoc URBs while doing all 
the others immediately?

> > Is it possible to change the subsystem design so that, for example, in
> > addition to getting a notify() callback when the connection settings
> > change, you also call a ready() function in the subsystem core to tell
> > it when the new settings are ready for use?
> 
> I was thinking about that. However it is still the same problem. We do
> have to submit URBs as soon as the connection is up. For the bulk URBs
> (for ACL) it is no problem. The only issue is with isoc URB (for SCO),
> because we have to pick an alternate setting first.

Well, you _can't_ submit isoc URBs before changing the altsetting; it
just won't work.  So you can't start submitting them as soon as the
connection is up -- the hardware doesn't allow it.  One way or another
they have to be deferred.  The only question is how the deferrals 
should be implemented.

> > If not, and you are forced to rely on queuing URBs for later 
> > submission, then I think it might be more appropriate to do this 
> > queuing in the Bluetooth driver code rather than in usbcore.  You could 
> > have an entire anchor devoted to deferred URBs.
> 
> What happens if we submit the isoc URBs right away and the call
> usb_set_interface at some later time. Will these be canceled or what
> happens to them when switching the endpoint.

When you call usb_set_interface(), all pending URBs for that interface 
will be cancelled and will complete with a status of -ESHUTDOWN.

(Hmm, looking at the code I see that the altsetting gets changed
_before_ the old URBs are cancelled.  That probably is a bug...)

Alan Stern
