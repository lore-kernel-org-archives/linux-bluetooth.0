Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5524EB20.8090807@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
	<1428068636-13073-5-git-send-email-mariusz.skamra@tieto.com>
	<CABBYNZK0gc4A6UaZHRZq5OJo1f2Vadd8QkCyOXWQ1LcAWFWj1A@mail.gmail.com>
	<5524EB20.8090807@tieto.com>
Date: Wed, 8 Apr 2015 13:11:10 +0300
Message-ID: <CABBYNZ+oS0c1hV2p6zDPyVsrOHGhjWg=27itZ2pVpmaMtz5-rw@mail.gmail.com>
Subject: Re: [PATCHv2 04/27] android/hog: Remove tracking gatt operations
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Skamra Mariusz <mariusz.skamra@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Wed, Apr 8, 2015 at 11:47 AM, Skamra Mariusz
<mariusz.skamra@tieto.com> wrote:
> Hi Luiz
>
>
> On 2015-04-07 09:50, Luiz Augusto von Dentz wrote:
>>
>> Hi Mariusz,
>>
>> On Fri, Apr 3, 2015 at 4:43 PM, Mariusz Skamra <mariusz.skamra@tieto.com>
>> wrote:
>>>
>>> Since the use of bt_gatt_client there is no need to queue pending gatt
>>> operations. bt_gatt_client already keeps track on that, so that
>>> on bt_gatt_client_unref the queue of pending requests is destroyed.
>>
>>
>> This assumption that unref will properly cancel the pending request is
>> not correct, it will only do what you are saying if it is the last
>> reference so we still need to track the requests and properly cancel
>> them since we have no idea how many references of bt_gatt_client
>> exists.
>
>
> Thanks for that. I will remove this patch from hog as well as other profiles
> (scpp, dis, bas). I already discussed that with Szymon, and my intention was
> to delete all the requests after the last gatt_client dereference (just like
> you wrote). I assumed that if we want to disconnect/remove device, all the
> pending requests, no matter of which gatt based service will be removed.

I would actually attempt to move this logic into bt_gatt_client, first
it needs to track the requests per instance so when an instance needs
to be freed we should be able to cancel all request done by that
instance, the second step is to create bt_gatt_client_clone so we can
clone/dup existing instances skipping the service discovery but
reusing the same bt_att and bt_gatt_db, that way bt_hog could clone on
bt_hog_attach then the cloned instance would be used to track the
requests and cancel if necessary. Anyway this can come in a separate
set, this set is already too big imo.



-- 
Luiz Augusto von Dentz
