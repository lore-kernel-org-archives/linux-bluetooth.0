Return-Path: <cyrus@holtmann.org>
From: Skamra Mariusz <mariusz.skamra@tieto.com>
Message-ID: <5524EB20.8090807@tieto.com>
Date: Wed, 08 Apr 2015 10:47:28 +0200
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv2 04/27] android/hog: Remove tracking gatt operations
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>	<1428068636-13073-5-git-send-email-mariusz.skamra@tieto.com> <CABBYNZK0gc4A6UaZHRZq5OJo1f2Vadd8QkCyOXWQ1LcAWFWj1A@mail.gmail.com>
In-Reply-To: <CABBYNZK0gc4A6UaZHRZq5OJo1f2Vadd8QkCyOXWQ1LcAWFWj1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

On 2015-04-07 09:50, Luiz Augusto von Dentz wrote:
> Hi Mariusz,
>
> On Fri, Apr 3, 2015 at 4:43 PM, Mariusz Skamra <mariusz.skamra@tieto.com> wrote:
>> Since the use of bt_gatt_client there is no need to queue pending gatt
>> operations. bt_gatt_client already keeps track on that, so that
>> on bt_gatt_client_unref the queue of pending requests is destroyed.
>
> This assumption that unref will properly cancel the pending request is
> not correct, it will only do what you are saying if it is the last
> reference so we still need to track the requests and properly cancel
> them since we have no idea how many references of bt_gatt_client
> exists.

Thanks for that. I will remove this patch from hog as well as other 
profiles (scpp, dis, bas). I already discussed that with Szymon, and my 
intention was to delete all the requests after the last gatt_client 
dereference (just like you wrote). I assumed that if we want to 
disconnect/remove device, all the pending requests, no matter of which 
gatt based service will be removed.

