Return-Path: <cyrus@holtmann.org>
Message-id: <811664ADB4E0418995BFBAA79F38831C@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, jaganath.k@samsung.com
References: <1343413282-8901-1-git-send-email-s.syam@samsung.com>
 <1343413282-8901-2-git-send-email-s.syam@samsung.com>
 <20120806094607.GB2819@aemeltch-MOBL1>
Subject: Re: [PATCH] Bluetooth: debug: Correct the PSM printing
Date: Mon, 13 Aug 2012 20:07:08 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

----- Original Message ----- 
From: "Andrei Emeltchenko" <andrei.emeltchenko.news@gmail.com>
To: "Syam Sidhardhan" <s.syam@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>; <jaganath.k@samsung.com>
Sent: Monday, August 06, 2012 3:16 PM
Subject: Re: [PATCH] Bluetooth: debug: Correct the PSM printing


> Hi Syam,
>
> On Fri, Jul 27, 2012 at 11:51:22PM +0530, Syam Sidhardhan wrote:
>> Earlier we were printing chan->psm before assigning any value.
>>
>> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
>
> Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
>> ---
>>  net/bluetooth/l2cap_core.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index bedc960..0912a63 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -1447,7 +1447,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, 
>> __le16 psm, u16 cid,
>>  int err;
>>
>>  BT_DBG("%s -> %s (type %u) psm 0x%2.2x", batostr(src), batostr(dst),
>> -        dst_type, __le16_to_cpu(chan->psm));
>> +        dst_type, __le16_to_cpu(psm));
>>
>>  hdev = hci_get_route(dst, src);
>>  if (!hdev)
>> -- 
>> 1.7.4.1
>>

ping..

Regards,
Syam 

