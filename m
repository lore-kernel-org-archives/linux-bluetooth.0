Return-Path: <cyrus@holtmann.org>
Message-ID: <4FC6240A.3030009@tieto.com>
Date: Wed, 30 May 2012 15:43:38 +0200
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Andre Guedes <andre.guedes@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: Use hci_conn data to handle failed LE Connection
 Complete
References: <1337201737-5983-1-git-send-email-andrzej.kaczmarek@tieto.com>  <1337202331.5970.269.camel@aeonflux>  <CA+6KyKZ0vrPHoXXfWwJdiVLDR+59azRwWMhJbjndM+Aw_dKSwA@mail.gmail.com>  <1337204910.5970.271.camel@aeonflux> <4FB4B13D.1010302@tieto.com>  <CACJA=fVgzh9-RXBeJ=N7KRHDnEo_GTcVOnnv2dc-JMxKriBb4g@mail.gmail.com> <1337928909.15105.88.camel@aeonflux>
In-Reply-To: <1337928909.15105.88.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 25.05.2012 08:55, Marcel Holtmann wrote:
>> I was taking a look at Core spec change request document [1] and I found this:
>>
>> Erratum 4215, LE connection complete event missing exception
>> "... On failure, for this event, all other parameters are not valid."
>>
>> It clearly states this is an expected behavior and nullify those
>> parameters doesn't make the adapter broken.
>>
>> Thus, in case of failure, we should not rely on those parameters
>> (BD_ADDR included) in order to properly handle LE Connection Complete
>> Events.
>
> if this is so, then we should only do that and strictly enforce only one
> LE connection attempt at a time. Also then there is no need to bother
> with trying to check for the BD_ADDR later.

I created patch which does not allow 2nd outgoing LE connection attempt 
and also reworded commit message for this one so it does state 
explicitly that we should consider BDADDR from failed LE Connection 
Complete as not valid and not use it.

Please take a look at my new patches (3 in total).

BR,
Andrzej
