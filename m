Return-Path: <cyrus@holtmann.org>
Message-ID: <85686e0eb8df90f1f64a36832e1afb98.squirrel@www.codeaurora.org>
In-Reply-To: <20100802185542.GA28641@jh-x301>
References: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
    <20100723082045.GA1600@jh-x301> <20100723082754.GA12563@jh-x301>
    <20100723084300.GA14443@jh-x301>
    <b622ef9ae078ace2da7a8a6748823d2f.squirrel@www.codeaurora.org>
    <20100726094444.GB20357@jh-x301>
    <feb3c412e1be4c1b7b42efdbc581aabb.squirrel@www.codeaurora.org>
    <20100802185542.GA28641@jh-x301>
Date: Mon, 2 Aug 2010 14:24:09 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] Enhanced support for extended inquiry response
From: ingas@codeaurora.org
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Thanks for your reply.

> Hi Inga,
>
> First of all, sorry for the slight delay in my reply. I've been on
> holiday last week with quite limted email processing capability.
>
> On Wed, Jul 28, 2010, ingas@codeaurora.org wrote:
>> In the current implementation,  EIR write is keyed off HCI Command
>> Complete events for a set of commands (in security.c).
>>  - When first registering an OPP service with sdptool, the
>> update_svcclass_list()  (sdpd-service.c) calls manager_update_svc()
>> (manager.c) which in turn calls adapter_update()  (adapter.c).  BTW, why
>> this level of indirection, since manager_update_svc() is called only
>> from
>> one place in the code and calling adapter_update()  is all it does?
>> Probably some earlier architectural decision I am not aware of…
>
> That looks pretty stupid to me too. Might be some historical artifact.
> Anyway, feel free to send a patch to remove this indirection (i.e. call
> adapter_update directly).
>

Will do once i get through the initial submission.


>> The current implementation may be extended as following:
>> Since update_svcclass_list() is being called throughout sdpd-service.c
>> in
>> all the places where EIR needs to be updated as well, I propose to
>> modify
>> the corresponding function  adapter_set_service_classes() (adapter.c) :
>>
>> **********************
>> Before:
>> /* If we already have the CoD we want or the cache is enabled or an
>> * existing CoD write is in progress just bail out */
>> if (adapter->current_cod == adapter->wanted_cod ||
>> 	adapter->cache_enable || adapter->pending_cod)
>> return 0;
>>
>>
>> ***********************
>>
>> After:
>> /* If we already have the CoD we want or the cache is enabled or an
>> * existing CoD write is in progress just bail out */
>> if (adapter->cache_enable || adapter->pending_cod)
>> return 0;
>>
>> /* If we already have the CoD we want, update EIR and return */
>> if (adapter->current_cod == adapter->wanted_cod ) {
>> 	update_ext_inquiry_response(adapter);
>> 	return 0;
>> }
>>
>> **********************
>> Will that be acceptable? I tested this modification and it’s working
>> with
>> both d-bus methods and sdptool.
>
> Seems good to me.
>


I just submitted an updated patch set for EIR (hopefully, not messing up
my tabs an spaces in the process). This is certainly a learning process
and your patience is appreciated :)

Regards,

Inga


