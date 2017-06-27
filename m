Return-Path: <jeffy.chen@rock-chips.com>
Message-ID: <595228D7.1070807@rock-chips.com>
Date: Tue, 27 Jun 2017 17:43:51 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Rohit Vaswani <rvaswani@nvidia.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Brian Norris <briannorris@chromium.org>,
 Douglas Anderson <dianders@chromium.org>,
 Johan Hedberg <johan.hedberg@intel.com>,
 Peter Hurley <peter@hurleysoftware.com>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>
Subject: Re: Bluetooth: might sleep error in hidp_session_thread
References: <7be134d7f9904082a35a9cc926ec24d3@HQMAIL106.nvidia.com> <594D0BDE.10102@rock-chips.com> <cc75d14021724c2d8b74a92482d67b7b@HQMAIL105.nvidia.com>
In-Reply-To: <cc75d14021724c2d8b74a92482d67b7b@HQMAIL105.nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rohit,

On 06/24/2017 02:00 AM, Rohit Vaswani wrote:
> I don't have a way to reply back to the older message; but you can use by tested-by for the below patch and re-send:
>
ok, i've resent it, thanks for your test by~

and for replying to an old message, i've figured it out when i tried to 
do that recently:

1/ download the mbox file from the patchwork 
link(https://patchwork.kernel.org/patch/***)
2/ rename it to .mbox
3/ import into thunerbird(using ImportExportTools)

hope that helps ;)

> For patch: [v4,3/3] Bluetooth: hidp: fix possible might sleep error in hidp_session_thread
>
> Tested-by: Rohit Vaswani <rvaswani@nvidia.com>
>
> -Rohit
>
> -----Original Message-----
> From: jeffy [mailto:jeffy.chen@rock-chips.com]
> Sent: Friday, June 23, 2017 05:39
> To: Rohit Vaswani; linux-bluetooth@vger.kernel.org
> Cc: Brian Norris; Douglas Anderson; Johan Hedberg; Peter Hurley; Johan Hedberg; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; David S. Miller; Marcel Holtmann; Gustavo Padovan
> Subject: Re: Bluetooth: might sleep error in hidp_session_thread
>
> Hi Rohit,
>
> Thanx for your reply, and sorry to the delay, somehow your mail was marked as spam by the mail server :(
>
> On 06/13/2017 02:31 AM, Rohit Vaswani wrote:
>> Hi Jeffy,
>>
>> I was looking into the patch from Jeffy Chen from February 14 2017  :
>>    [v4,3/3] Bluetooth: hidp: fix possible might sleep error in
>> hidp_session_thread: https://patchwork.kernel.org/patch/9570931/
>>
>> We faced a similar issue and this patch seems to fix the problem in our preliminary test.
>> I am trying to check if there was a reason this wasn't merged earlier ?
>
> hmm, i'm not sure why, but please feel free to add your test-by~
>>
>> Thanks,
>> Rohit
>>
>> nvpublic
>>
>>
>>
>
>
