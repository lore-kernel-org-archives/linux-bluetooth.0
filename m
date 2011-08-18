Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313669526.17513.37.camel@THOR>
References: <1313627852.10336.10.camel@THOR>
	<CABBYNZLRMK7ADwFQUQj6FS7RfQqDR8o-SjAJsqHUeFxXVYhXWg@mail.gmail.com>
	<1313669526.17513.37.camel@THOR>
Date: Thu, 18 Aug 2011 15:40:56 +0300
Message-ID: <CABBYNZJ=iKXKJy1YG1kvLcVT=Lb2+H86KbqjDw8r1prCrri-9g@mail.gmail.com>
Subject: Re: [RFC v2 2/5] Bluetooth: Minor optimization for multiple tx connections
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Aug 18, 2011 at 3:12 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Thanks. Yes, in the current scheduler a connection can be scheduled
> multiple times per tasklet run.
>
> For example, supposed that acl_cnt == 3 and 2 connections have packets
> in their queue. Let's assume for the sake of simplicity that no
> connections currently have unacked packets (c->sent == 0). Then (with
> the current scheduler),
>
>  1st iteration: conn list walked => conn A found (equal unacked)
>                 quote = 3/2 => 1 for conn A
>                 conn A now has 1 unacked packet (after send)
>
>  2nd iteration: conn list walked => conn B found (lowest unacked)
>                 quote = 2/2 => 1 for conn B
>                 conn B now has 1 unacked packet (after send)
>
>  3rd iteration: conn list walked => conn A found (equal unacked)
>                 quote = 1/2 => 1 for conn A
>                 conn A now has 2 unacked packets (after send)
>
> With the proposed change, only 2 iterations occur:
>
>  1st iteration: conn list walked => conn A found (equal unacked)
>                 quote = 3/2 => 2 for conn A
>                 conn A now has 2 unacked packets (after send)
>
>  2nd iteration: conn list walked => conn B found (lowest unacked)
>                 quote = 1/2 => 1 for conn B
>                 conn B now has 1 unacked packet (after send)
>
> However, even with this change it may be that connections are scheduled
> multiple times per tasklet. This can happen if a connection still has
> equal or fewer unacked packets even after spending it's quota.
>
> But I didn't see in your proposal where you assume that an HCI channel
> can only be scheduled once (or at least where it breaks down if true).

My last patch checks if a channel has already sent any data in the
current task and skip if it did (note that chan->sent != conn->sent),
I was trying to reduce the complexity but it seems it breaks the logic
with unacked packets.

-- 
Luiz Augusto von Dentz
