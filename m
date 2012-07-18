Return-Path: <cyrus@holtmann.org>
From: "Malovany, Ram" <ramm@ti.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v4] Bluetooth: Fix Device Scan and connection collision
Date: Wed, 18 Jul 2012 08:50:18 +0000
Message-ID: <2683478DEE33CD4DAF508ABCF391F6A40B4AF312@DNCE05.ent.ti.com>
References: <1342596961-3446-1-git-send-email-ramm@ti.com>
 <20120718082410.GA10318@x220.ger.corp.intel.com>
In-Reply-To: <20120718082410.GA10318@x220.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



> -----Original Message-----
> From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
> Sent: Wednesday, July 18, 2012 11:24 AM
> To: Malovany, Ram
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v4] Bluetooth: Fix Device Scan and connection collision
> 
> Hi Ram,
> 
> On Wed, Jul 18, 2012, ramm@ti.com wrote:
> > During search of devices, HCI Remote Name Request Command is sent for
> > every device which name was not included in inquiry result. But the
> > same command is also sent during incoming connection establishing
> > procedure. Function hci_check_pending_name() was fixed in order to
> > handle this situation which led to a kernel crash when initiating
> > an incoming connection from a device that was not found in the
> > inquiry while doing a search. There is no need to continue resolving
> > the next name if we get the request from the incoming connection
> > procedure as it will be done upon receiving another remote name
> > request complete event
> >
> > Signed-off-by: Ram Malovany <ramm@ti.com>
> > ---
> >  net/bluetooth/hci_event.c |   21 ++++++++++++++-------
> >  1 files changed, 14 insertions(+), 7 deletions(-)
> 
> The fixes in this patch seem correct to me but there seems to be three
> of them and each one could be considered independently. I'd therefore
> split this into three separate patches:
> 
> >  	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_NEEDED);
> > -	if (hci_resolve_name(hdev, e) == 0) {
> > +	if (e && hci_resolve_name(hdev, e) == 0) {
> >  		e->name_state = NAME_PENDING;
> >  		return true;
> >  	}
> 
> This missing NULL check is the first fix. You might actually consider
> doing:
> 
> 	if (!e)
> 		return false;
> 

I didn't want to change the coding in this specific file , as you can see in the function:

hci_inquiry_complete_evt() , calling it the same way. 
But I can changed them both if needed. Do you want me to ?

> 	...
> 
> >  	e = hci_inquiry_cache_lookup_resolve(hdev, bdaddr, NAME_PENDING);
> > -	if (e) {
> > +	if (!e)
> > +		return;
> 
> This is the second fix. Since it's not directly clear why it's safe to
> risk not setting DISCOVERY_STOPPED in this case I'd also add a code
> comment explaining it (that if there's no matching entry in the cache it
> must mean that there's another pending command ongoing which we can
> safely wait for).

Correct I will add a short comment.

> 
> > +	} else {
> > +		e->name_state = NAME_NOT_KNOWN;
> >  	}
> 
> This missing setting back to NAME_NOT_KNOWN when name resolving fails is
> the third fix.
> 
> Please let me know if I misunderstood something or if some of these
> fixes really must go into the same patch (e.g. if applying just one of
> them will make the code more broken than it is now).
> 

This patch can be split to 3 ways , and no applying only one of them would not
Make the code more broken that it is right now , but it's important to integrate 
all of them in order to make the code more stable.

I will send a new set of patches that include your comments, but I don't know if I will
Change the first fix here due to the current code implementation.

> Johan

Thanks,
Ram
