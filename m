Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Oct 2014 14:42:25 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	marcel@holtmann.org, Martin Townsend <martin.townsend@xsilon.com>
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20141001124223.GB25269@omega>
References: <1412165422-31063-1-git-send-email-martin.townsend@xsilon.com>
 <1412165422-31063-2-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1412165422-31063-2-git-send-email-martin.townsend@xsilon.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Wed, Oct 01, 2014 at 01:10:22PM +0100, Martin Townsend wrote:
> Currently there are a number of error paths in the lowpan_rcv function that
> free the skb before returning, the patch simplifies the receive path by
> ensuring that the skb is only freed from this function.
> 
> Passing the skb from 6lowpan up to the higher layers is not a
> function of IPHC.  By moving it out of IPHC we also remove the
> need to support error code returns with NET_RX codes.
> It also makes the lowpan_rcv function more extendable as we
> can support more compression schemes.
> 
> With the above 2 lowpan_rcv is refactored so eliminate incorrect return values.

I notice this patch and I need some time to take review of this. Also
Jukka should ack these changes, so we don't break anything of 6lowpan bluetooth branch.

Thanks for your work Martin.


Marcel, please wait until this patch will get Acked-by you, Jukka, others who like to give
review notes and me.

It's a terrible issue and we need a longer audit for this one.

- Alex
