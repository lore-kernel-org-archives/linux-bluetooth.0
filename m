Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ+OgwPaSbLKnU9oVZ1ZormVNm=-+8MA5MStKdCfEn31w@mail.gmail.com>
References: <1473338340-7587-1-git-send-email-luiz.dentz@gmail.com>
 <38a00e58-cde7-8774-3956-15255854001f@felipetonello.com> <CABBYNZ+ByJpF_6rbFwjbqeSM9yPcTMXBPCOiV2nEXnQ54jfOFg@mail.gmail.com>
 <b4836467-b6e2-70fe-eda3-49e6de5882b7@felipetonello.com> <CABBYNZJ+OgwPaSbLKnU9oVZ1ZormVNm=-+8MA5MStKdCfEn31w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Sep 2016 17:34:47 +0300
Message-ID: <CABBYNZ+fj_1gpJvMMsF4d88NcdsX8ZOXeM5u_8buDJun8bLYmA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] core/service: Fix setting wrong state after
 calling accept
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 9, 2016 at 3:35 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Felipe,
>
> On Thu, Sep 8, 2016 at 6:37 PM, Felipe Ferreri Tonello
> <eu@felipetonello.com> wrote:
>> Hi Luiz,
>>
>> On 08/09/16 16:26, Luiz Augusto von Dentz wrote:
>>> Hi Felipe,
>>>
>>> On Thu, Sep 8, 2016 at 5:45 PM, Felipe Ferreri Tonello
>>> <eu@felipetonello.com> wrote:
>>>> Hi Luiz,
>>>>
>>>> On 08/09/16 13:38, Luiz Augusto von Dentz wrote:
>>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>>
>>>>> The accept calback may transit the state to connected on the call itself
>>>>> since most of the time it is just a matter of selecting the attributes
>>>>> in case of GATT profiles.
>>>>> ---
>>>>>  src/service.c | 3 ++-
>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/src/service.c b/src/service.c
>>>>> index f387fc4..20a41d0 100644
>>>>> --- a/src/service.c
>>>>> +++ b/src/service.c
>>>>> @@ -209,7 +209,8 @@ int service_accept(struct btd_service *service)
>>>>>       return err;
>>>>>
>>>>>  done:
>>>>> -     change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
>>>>> +     if (service->state == BTD_SERVICE_STATE_DISCONNECTED)
>>>>> +             change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
>>>>
>>>> This looks really hacky - I know it was like this before already.
>>>
>>> This is to avoid resetting the connection if the accept callback has
>>> set it already.
>>>
>>>> Why can you change the state in two different places? What if the
>>>> profile->accept doesn't change the state to connected? Will this change
>>>> to connecting and then the connected state will never be set?
>>>
>>> Going from connected to connecting is not valid, thus if the driver
>>> had changed the states there is nothing else to be done.
>>
>> Why do you have this done label if the driver is supposed to call
>> btd_service_connecting_complete() on success?
>>>
>>>> I think btd_service_connecting_complete() should always be called with
>>>> the same err as returned by profile->accept()
>>>
>>> Not sure what difference does this make?
>>
>> My suggestion is to handle the state based on the return value of the
>> driver's callback and not let the driver to change the state itself.
>> It's boilerplate code anyway.
>
> The driver may have to respond this asynchronously so we can't really
> depend on the return alone.

Applied.

-- 
Luiz Augusto von Dentz
