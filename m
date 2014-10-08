Return-Path: <cyrus@holtmann.org>
Message-ID: <54353F58.4090301@xsilon.com>
Date: Wed, 08 Oct 2014 14:42:48 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
CC: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
 marcel@holtmann.org, alex.aring@gmail.com
Subject: Re: [PATCH bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
References: <1412696037-25111-1-git-send-email-martin.townsend@xsilon.com>			 <1412696037-25111-2-git-send-email-martin.townsend@xsilon.com>			 <543408B2.1070309@xsilon.com>		 <1412763863.2705.22.camel@jrissane-mobl.ger.corp.intel.com>		 <54351AF4.5060907@xsilon.com>	 <1412770375.2705.25.camel@jrissane-mobl.ger.corp.intel.com>	 <54353387.3070007@xsilon.com> <1412775335.2705.31.camel@jrissane-mobl.ger.corp.intel.com>
In-Reply-To: <1412775335.2705.31.camel@jrissane-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

hi Jukka,

Thank you for running all these tests for me, it's very much appreciated.
I'll send out v4 in a bit.

Cheers, Martin.

On 08/10/14 14:35, Jukka Rissanen wrote:
> Hi Martin,
>
> On ke, 2014-10-08 at 13:52 +0100, Martin Townsend wrote:
>> Hi Jukka,
>>
>> I've misunderstood the constraints on pskb_expand_head.   I don't suppose you could quickly try this patch it now uses skb_share_check to ensure  skb->users == 1 and then I've put back in the skb_clone code that I took out which I think is causing the problem:
> Tried this one and did not see any errors so far. I will leave my test
> to run for the night. Please send a v4 and I will try to review it
> tomorrow.
>
> Cheers,
> Jukka
>
>
