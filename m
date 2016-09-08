Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <38a00e58-cde7-8774-3956-15255854001f@felipetonello.com>
References: <1473338340-7587-1-git-send-email-luiz.dentz@gmail.com> <38a00e58-cde7-8774-3956-15255854001f@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 Sep 2016 18:26:50 +0300
Message-ID: <CABBYNZ+ByJpF_6rbFwjbqeSM9yPcTMXBPCOiV2nEXnQ54jfOFg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] core/service: Fix setting wrong state after
 calling accept
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Thu, Sep 8, 2016 at 5:45 PM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> Hi Luiz,
>
> On 08/09/16 13:38, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> The accept calback may transit the state to connected on the call itself
>> since most of the time it is just a matter of selecting the attributes
>> in case of GATT profiles.
>> ---
>>  src/service.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/service.c b/src/service.c
>> index f387fc4..20a41d0 100644
>> --- a/src/service.c
>> +++ b/src/service.c
>> @@ -209,7 +209,8 @@ int service_accept(struct btd_service *service)
>>       return err;
>>
>>  done:
>> -     change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
>> +     if (service->state == BTD_SERVICE_STATE_DISCONNECTED)
>> +             change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
>
> This looks really hacky - I know it was like this before already.

This is to avoid resetting the connection if the accept callback has
set it already.

> Why can you change the state in two different places? What if the
> profile->accept doesn't change the state to connected? Will this change
> to connecting and then the connected state will never be set?

Going from connected to connecting is not valid, thus if the driver
had changed the states there is nothing else to be done.

> I think btd_service_connecting_complete() should always be called with
> the same err as returned by profile->accept()

Not sure what difference does this make?

>
>>       return 0;
>>  }
>>
>>
>
> --
> Felipe



-- 
Luiz Augusto von Dentz
