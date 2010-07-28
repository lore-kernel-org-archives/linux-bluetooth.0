Return-Path: <cyrus@holtmann.org>
Message-ID: <feb3c412e1be4c1b7b42efdbc581aabb.squirrel@www.codeaurora.org>
In-Reply-To: <20100726094444.GB20357@jh-x301>
References: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
    <20100723082045.GA1600@jh-x301> <20100723082754.GA12563@jh-x301>
    <20100723084300.GA14443@jh-x301>
    <b622ef9ae078ace2da7a8a6748823d2f.squirrel@www.codeaurora.org>
    <20100726094444.GB20357@jh-x301>
Date: Wed, 28 Jul 2010 13:08:09 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] Enhanced support for extended inquiry response
From: ingas@codeaurora.org
To: johan.hedberg@gmail.com
Cc: ingas@codeaurora.org, linux-bluetooth@vger.kernel.org,
	rshaffer@codeaurora.org, marcel@holtmann.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>
> Both the D-Bus interface as well as sdptool trigger the same code paths
> in src/sdpd-service.c. I.e. it doesn't make sense to solve this twice
> when it can be solved once by targetting the common lower layer. We
> already do this for the service class bits with update_svclass_list() in
> sdpd-service.c. The need to update the EIR data is very similar to the
> need to update the service class bits so the existing code is probably a
> good place to take example of.
>
>

My original intent when creating this patch set was no to perturb the code
that is already  in place too much.  Hence the changes were done only to
D-Bus methods. Sure, I can change the EIR write bot happen deeper down the
pipeline. However, before I invest your and my time in generating and
reviewing more patches , let’s agree on the solution first.

In the current implementation,  EIR write is keyed off HCI Command
Complete events for a set of commands (in security.c).
 - When first registering an OPP service with sdptool, the
update_svcclass_list()  (sdpd-service.c) calls manager_update_svc()
(manager.c) which in turn calls adapter_update()  (adapter.c).  BTW, why
this level of indirection, since manager_update_svc() is called only from
one place in the code and calling adapter_update()  is all it does? 
Probably some earlier architectural decision I am not aware of…

- Anyway, as a result, HCI command to write service class is done, returns
Command Complete event (processed in , calls back into adapter layer
adapter_set_class_complete() which invokes  invokes
update_ext_inquiry_response() and (voilà!) EIR is written. So far so good.

- When consequently another OBEX based service like FTP is added using
sdptool, service class of the device does not change, adapter_update()
does nothing, and ultimately EIR is not updated with FTP uuid. This is the
problem that you observed when testing with sdptool.  While showing either
only  OPP or only FTP might be considered not a big deal, skipping UUID in
EIR for  another OBEX-based service like PBAP in EIR might not be so
great, since those services are very different…

The current implementation may be extended as following:
Since update_svcclass_list() is being called throughout sdpd-service.c in
all the places where EIR needs to be updated as well, I propose to modify
the corresponding function  adapter_set_service_classes() (adapter.c) :

**********************
Before:
/* If we already have the CoD we want or the cache is enabled or an
* existing CoD write is in progress just bail out */
if (adapter->current_cod == adapter->wanted_cod ||
	adapter->cache_enable || adapter->pending_cod)
return 0;


***********************

After:
/* If we already have the CoD we want or the cache is enabled or an
* existing CoD write is in progress just bail out */
if (adapter->cache_enable || adapter->pending_cod)
return 0;

/* If we already have the CoD we want, update EIR and return */
if (adapter->current_cod == adapter->wanted_cod ) {
	update_ext_inquiry_response(adapter);
	return 0;
}

**********************
Will that be acceptable? I tested this modification and it’s working with
both d-bus methods and sdptool.

Of course, it might be possible to cache the EIR currently written down,
compare the update, and decide whether the EIR needs to be updated. But
this is more involved, not entirely safe, as we might run into coherency
issues.

As a side note, in future it might be a good idea to expose EIR writes to
an application layer providing external API. The intent of EIR is to allow
quick scan of the surroundings to find a particular service that a device
is interested at the moment (and in turn, exposing the services that the
device choses to expose at the moment) without actually going into full
blown connection mode.   EIR space is at a premium for sophisticated
devices with multiple services. Not every single service needs to be
exposed in EIR. It would be nice to be able to pick which one to add. For
example, if a device supports both headset and handsfree profiles (as all
of the phones do), it might not be necessary to advertise headset uuid in
EIR since the headsets  out there are mostly legacy devices that cannot
perform EIR anyway… Also, as more new services that use uuid128 are
introduced, the EIR buffer pretty quickly if every single one of them is
added without discretion. Just something to throw out there :)


Regards,

Inga


