Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Aug 2010 21:55:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: ingas@codeaurora.org
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH v4 0/5] Enhanced support for extended inquiry response
Message-ID: <20100802185542.GA28641@jh-x301>
References: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
 <20100723082045.GA1600@jh-x301>
 <20100723082754.GA12563@jh-x301>
 <20100723084300.GA14443@jh-x301>
 <b622ef9ae078ace2da7a8a6748823d2f.squirrel@www.codeaurora.org>
 <20100726094444.GB20357@jh-x301>
 <feb3c412e1be4c1b7b42efdbc581aabb.squirrel@www.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <feb3c412e1be4c1b7b42efdbc581aabb.squirrel@www.codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

First of all, sorry for the slight delay in my reply. I've been on
holiday last week with quite limted email processing capability.

On Wed, Jul 28, 2010, ingas@codeaurora.org wrote:
> In the current implementation,  EIR write is keyed off HCI Command
> Complete events for a set of commands (in security.c).
>  - When first registering an OPP service with sdptool, the
> update_svcclass_list()  (sdpd-service.c) calls manager_update_svc()
> (manager.c) which in turn calls adapter_update()  (adapter.c).  BTW, why
> this level of indirection, since manager_update_svc() is called only from
> one place in the code and calling adapter_update()  is all it does? 
> Probably some earlier architectural decision I am not aware of…

That looks pretty stupid to me too. Might be some historical artifact.
Anyway, feel free to send a patch to remove this indirection (i.e. call
adapter_update directly).

> The current implementation may be extended as following:
> Since update_svcclass_list() is being called throughout sdpd-service.c in
> all the places where EIR needs to be updated as well, I propose to modify
> the corresponding function  adapter_set_service_classes() (adapter.c) :
> 
> **********************
> Before:
> /* If we already have the CoD we want or the cache is enabled or an
> * existing CoD write is in progress just bail out */
> if (adapter->current_cod == adapter->wanted_cod ||
> 	adapter->cache_enable || adapter->pending_cod)
> return 0;
> 
> 
> ***********************
> 
> After:
> /* If we already have the CoD we want or the cache is enabled or an
> * existing CoD write is in progress just bail out */
> if (adapter->cache_enable || adapter->pending_cod)
> return 0;
> 
> /* If we already have the CoD we want, update EIR and return */
> if (adapter->current_cod == adapter->wanted_cod ) {
> 	update_ext_inquiry_response(adapter);
> 	return 0;
> }
> 
> **********************
> Will that be acceptable? I tested this modification and it’s working with
> both d-bus methods and sdptool.

Seems good to me.

> As a side note, in future it might be a good idea to expose EIR writes to
> an application layer providing external API. The intent of EIR is to allow
> quick scan of the surroundings to find a particular service that a device
> is interested at the moment (and in turn, exposing the services that the
> device choses to expose at the moment) without actually going into full
> blown connection mode.   EIR space is at a premium for sophisticated
> devices with multiple services. Not every single service needs to be
> exposed in EIR. It would be nice to be able to pick which one to add. For
> example, if a device supports both headset and handsfree profiles (as all
> of the phones do), it might not be necessary to advertise headset uuid in
> EIR since the headsets  out there are mostly legacy devices that cannot
> perform EIR anyway… Also, as more new services that use uuid128 are
> introduced, the EIR buffer pretty quickly if every single one of them is
> added without discretion. Just something to throw out there :)

Good point (not that any concrete examples of such a device/situation
would have come accross yet). One possibility to solve the issue without
directly exposing this to applications would be to have a (rather
static) setting in main.conf of UUIDs to be prioritized over others in
the EIR data.

Johan
