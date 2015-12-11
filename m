Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [RFCv3 bluetooth-next 4/4] 6lowpan: iphc: add support for
 stateful compression
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
References: <1448796882-316-1-git-send-email-alex.aring@gmail.com>
 <1448796882-316-5-git-send-email-alex.aring@gmail.com>
 <20151211170541.GA1119@omega>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	kernel@pengutronix.de, mcr@sandelman.ca, lukasz.duda@nordicsemi.no,
	martin.gergeleit@hs-rm.de
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <566B1FEE.5030509@osg.samsung.com>
Date: Fri, 11 Dec 2015 20:11:42 +0100
MIME-Version: 1.0
In-Reply-To: <20151211170541.GA1119@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

On 11/12/15 18:05, Alexander Aring wrote:
> Hi,
>
> status update here.
>
> I implemented successful basic 6CO RA messages at sending and
> processing inside radvd.
>
> There might also the question if processing 6CO inside kernel or
> userspace? I put the basic functionality inside userspace for now.

How are you feeding the entries your receive back into the kernel? The 
debugfs interface right now?
If we want to go with userspace handling for 6CO we need something 
better at some point.

> I will send patches for this in the next days.

Great.

>
> Anyway I figured some things out which was completely wrong inside this
> patch.
>
>   - There exist one context based table only.
>     
>     In rfc6282 stands:
>     The specification enables a node to use up to 16 contexts. The
>     context used to encode the source address does not have to be the
>     same as the context used to encode the destination address.
>
>     and I thought it was $SOME_TABLE[DCI] != $DIFFERENT_TABLE[SCI].
>     But it means in general simple that it can be: DCI != SCI.
>
>     With this knowledge the code gets much smaller.

Interesting point. I also overlooked this during the first review rounds.

regards
Stefan Schmidt
