Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALvjcs9o63HGYCORmNtPaLuxWR2jAw1vndgUZL5jiGs5v4jp2w@mail.gmail.com>
References: <20171003183507.37885-1-yunhanw@google.com> <CABBYNZLBLNkyEgimzmB52Uq_SZKVeiHhUJJkR+0b56OtD2Sjvg@mail.gmail.com>
 <CALvjcs-EbVqERVoOaHgHXaLKGFY_4P6nY5ZTJ=+Af2+ug21tzQ@mail.gmail.com> <CALvjcs9o63HGYCORmNtPaLuxWR2jAw1vndgUZL5jiGs5v4jp2w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 5 Oct 2017 16:41:10 +0300
Message-ID: <CABBYNZ+s75ZqgazcLEBfojX0NLuFUp1Bq-tqa4XgQCNiUfy4KQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Fix sending indications with proxy
To: Yunhan Wang <yunhanw@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On Thu, Oct 5, 2017 at 11:21 AM, Yunhan Wang <yunhanw@google.com> wrote:
> Hi, Luiz
>
> With this change, all are working fine via using AcquireWrite and
> AcquireNotify now in my end. I have not yet see any issue so far. Any
> other concern or better idea?
>
> Thanks
> Best wishes
> Yunhan
>
> On Wed, Oct 4, 2017 at 7:55 AM, Yunhan Wang <yunhanw@google.com> wrote:
>> Hi, Luiz
>>
>> On Wed, Oct 4, 2017 at 4:19 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Yunhan,
>>>
>>> On Tue, Oct 3, 2017 at 9:35 PM, Yunhan Wang <yunhanw@google.com> wrote:
>>>> When using AcquireNotify with indication, the proxy needs to be filled in
>>>> send_notification_to_devices so as to get indication confirmation in
>>>> applciation.
>>>> ---
>>>>  src/gatt-database.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/src/gatt-database.c b/src/gatt-database.c
>>>> index 0c84b2569..47304704a 100644
>>>> --- a/src/gatt-database.c
>>>> +++ b/src/gatt-database.c
>>>> @@ -1831,7 +1831,7 @@ static bool pipe_io_read(struct io *io, void *user_data)
>>>>                                 buf, bytes_read,
>>>>                                 gatt_db_attribute_get_handle(chrc->ccc),
>>>>                                 chrc->props & BT_GATT_CHRC_PROP_INDICATE,
>>>> -                               NULL);
>>>> +                               chrc->proxy);
>>>>
>>>>         return true;
>>>>  }
>>>> --
>>>> 2.14.2.822.g60be5d43e6-goog
>>>
>>> Im not sure this the correct fix, the reason why the proxy is NULL is
>>> because the fd is being used for io, though the confirmation has no
>>> effect on the flow control Id expect some inband signalling in this
>>> case but that might actually require something like a socketpair in
>>> order to be able to write confirmation back.
>>>
>> I think pipe_io_read should be pretty similar to property_changed_cb
>> in https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n2103,
>> both are used to handle the written value from application. Therefore,
>> send_notification_to_devices should be fine here with proxy. For
>> "socketpair", I guess you concern is Confirm? If Confirm is defined in
>> application, then confirmation should be able to be sent back to
>> application. If Confirm is not defined, it should be also fine in
>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n883.
>>> --
>>> Luiz Augusto von Dentz

Applied, thanks.

-- 
Luiz Augusto von Dentz
