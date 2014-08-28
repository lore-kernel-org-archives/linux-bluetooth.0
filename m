Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAN_7+YZKP4uV2Q_bdPO_DHwU+pgiRJp-FMwJtQ6hGWax1h7CgA@mail.gmail.com>
References: <1409172464-30369-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1409172464-30369-2-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZK1OHKc4iuU-MovGHJoQGmrP2ckY2erTsPdD1PnwzVhiA@mail.gmail.com>
	<CAN_7+YZKP4uV2Q_bdPO_DHwU+pgiRJp-FMwJtQ6hGWax1h7CgA@mail.gmail.com>
Date: Thu, 28 Aug 2014 12:51:17 +0300
Message-ID: <CABBYNZKc3-iL=AYETcy77e5UGUDt-Y4VCYDukFOPM0wx3y34cw@mail.gmail.com>
Subject: Re: [PATCH 1/3] android/bluetooth: Add unpaired device callback
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Aug 28, 2014 at 11:47 AM, Lukasz Rymanowski
<lukasz.rymanowski@gmail.com> wrote:
> Hi Luiz,
>
> On Thu, Aug 28, 2014 at 10:06 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Lukasz,
>>
>> On Wed, Aug 27, 2014 at 11:47 PM, Lukasz Rymanowski
>> <lukasz.rymanowski@tieto.com> wrote:
>>> GATT, HID, HOG, might be interested in the fact that some device has
>>> been unpaired in order to clear cache or similar. This patch adds means
>>> to register callback for unpaired event.
>>> ---
>>>  android/bluetooth.c | 38 ++++++++++++++++++++++++++++++++++++++
>>>  android/bluetooth.h |  3 +++
>>>  2 files changed, 41 insertions(+)
>>>
>>> diff --git a/android/bluetooth.c b/android/bluetooth.c
>>> index 984ecba..588ecd4 100644
>>> --- a/android/bluetooth.c
>>> +++ b/android/bluetooth.c
>>> @@ -41,6 +41,7 @@
>>>  #include "lib/uuid.h"
>>>  #include "src/shared/util.h"
>>>  #include "src/shared/mgmt.h"
>>> +#include "src/shared/queue.h"
>>>  #include "src/eir.h"
>>>  #include "lib/sdp.h"
>>>  #include "lib/sdp_lib.h"
>>> @@ -223,6 +224,8 @@ static struct ipc *hal_ipc = NULL;
>>>
>>>  static bool kernel_conn_control = false;
>>>
>>> +static struct queue *unpaired_cb_list;
>>> +
>>>  static void get_device_android_addr(struct device *dev, uint8_t *addr)
>>>  {
>>>         /*
>>> @@ -1688,6 +1691,22 @@ void bt_auto_connect_remove(const bdaddr_t *addr)
>>>         error("Failed to remove device");
>>>  }
>>>
>>> +static bool match_by_value(const void *data, const void *user_data)
>>> +{
>>> +       return data == user_data;
>>> +}
>>> +
>>> +void bt_unpaired_register(bt_unpaired_device_cb cb)
>>> +{
>>> +       if (!unpaired_cb_list)
>>> +               return;
>>> +
>>> +       if (queue_find(unpaired_cb_list, match_by_value, cb))
>>> +               return;
>>> +
>>> +       queue_push_head(unpaired_cb_list, cb);
>>> +}
>>
>> Shouldn't it take the actual device address as well? Otherwise each
>> callback has to do a lookup on its own which is not that great.
>>
>
> I thought about it but eventually drop this idea. It is because each
> module interested in this callback needs to find provided device on
> their lists anyway. It is in order to remove it.
> If we would like to provide address in register function we would have
> to do some additional checks before actually callback call - so double
> check which is not nice.
> Queue would be also bigger since it would have to be  for each device
> etc. So I would keep that approach if you agree

I guess you don't want to pass the struct pointer as user data either,
that would save the extra lookup, anyway I guess we can deal with that
later if we found it does not do well in some cases.

-- 
Luiz Augusto von Dentz
