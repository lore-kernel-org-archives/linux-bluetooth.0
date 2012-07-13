Return-Path: <cyrus@holtmann.org>
Message-id: <4368C8F191BB414F84A70D30771FE893@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, s.syam@samsung.com
References: <1342165923-4901-1-git-send-email-jaganath.k@samsung.com>
 <20120713084859.GC2729@aemeltch-MOBL1>
In-reply-to: <20120713084859.GC2729@aemeltch-MOBL1>
Subject: Re: [PATCH] Bluetooth: Free the l2cap channel list only when refcount
 is zero
Date: Fri, 13 Jul 2012 16:56:02 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

--------------------------------------------------
From: "Andrei Emeltchenko" <andrei.emeltchenko.news@gmail.com>
Sent: Friday, July 13, 2012 2:19 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>; <s.syam@samsung.com>
Subject: Re: [PATCH] Bluetooth: Free the l2cap channel list only when 
refcount is zero

> Hi Jaganath,
>
> On Fri, Jul 13, 2012 at 01:22:03PM +0530, Jaganath Kanakkassery wrote:
>> Move the l2cap channel list chan->global_l under the refcnt
>> protection and free it based on the refcnt.
>
> The idea is good.
>
>> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
>> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
>> ---
>>  include/net/bluetooth/l2cap.h |    5 +++--
>>  net/bluetooth/a2mp.c          |    2 +-
>>  net/bluetooth/l2cap_core.c    |    4 +++-
>>  net/bluetooth/l2cap_sock.c    |    2 +-
>>  4 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h 
>> b/include/net/bluetooth/l2cap.h
>> index e5164ff..4c0dcba 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -670,6 +670,8 @@ enum {
>>  L2CAP_EV_RECV_FRAME,
>>  };
>>
>> +void l2cap_chan_destroy(struct l2cap_chan *chan);
>> +
>
> What I think is that l2cap_chan_destroy shall be static if it is used only
> inside l2cap_chan_put. Then l2cap_chan_hold/put shall be moved to
> l2cap_core or l2cap_chan_destroy moved to header. First is better IMO.

Ok. We will split the patches into two.
1. Refactoring patch which moves l2cap_chan_put() and l2cap_chan_get()
to l2cap_core.c and the

2. Moving the l2cap channel list chan->global_l under the refcnt protection

>>  static inline void l2cap_chan_hold(struct l2cap_chan *c)
>>  {
>>  BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->refcnt));
>> @@ -682,7 +684,7 @@ static inline void l2cap_chan_put(struct l2cap_chan 
>> *c)
>>  BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->refcnt));
>>
>>  if (atomic_dec_and_test(&c->refcnt))
>> - kfree(c);
>> + l2cap_chan_destroy(c);
>
> It does make sense to use kref mechanism here.

Ok. Once this patch is done we will raise the kref patch.

> Best regards
> Andrei Emeltchenko

Thanks,
Jaganath

 

