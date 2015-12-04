Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56617959.9040206@felipetonello.com>
References: <5660D251.1070106@felipetonello.com>
	<56617959.9040206@felipetonello.com>
Date: Fri, 4 Dec 2015 13:48:12 +0200
Message-ID: <CABBYNZLvaZoZWx-sa84xd+4c=ocgE_OVZWyW4mk4_chUVmwq5Q@mail.gmail.com>
Subject: Re: BUG: btd_profile's accept not been called from second connection
 and on
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Fri, Dec 4, 2015 at 1:30 PM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
>
>
> On 12/03/2015 11:37 PM, Felipe Ferreri Tonello wrote:
>> Hi,
>>
>> So the accept function callback from btd_profile is only been called on
>> the first time bluetoothd runs. It never gets called after a
>> disconnection and reconnection.
>>
>> I did git bisect and found the commit that caused it:
>> 4522ac85dd6dc1db4d49507330b4abc3bbaf4e6c
>>
>> But that commit doesn't actually caused the bug. I debugged a little
>> more and found that from the second connection on the service->state is
>> BTD_SERVICE_STATE_CONNECTING instead of BTD_SERVICE_STATE_DISCONNECTED
>> (which is the state when first connecting), thus causing the
>> btd_profile's accept function not to be called in service_accept().
>>
>> I didn't have time to debug more so I wanted to shout here if anyone has
>> any idea on why this is happening and how to fix it.

Interesting, it doesn't seems to manifest in case of HoG, but that is
probably because it still uses btd_device_add_attio_callback which is
now deprecated. Well I was planning to start to cleanup the use of it
so it nice that you are testing accept code path.



-- 
Luiz Augusto von Dentz
