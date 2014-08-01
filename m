Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Aug 2014 11:41:46 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH bluetooth-next] 6lowpan: Remove ununsed dev parameter
 from skb_delivery_cb callback.
Message-ID: <20140801094144.GA11159@omega>
References: <53DB5A53.5000004@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <53DB5A53.5000004@xsilon.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Fri, Aug 01, 2014 at 10:13:55AM +0100, Martin Townsend wrote:
> This parameter is never used by any function implementing this callback.
> ---
>  include/net/6lowpan.h         | 2 +-
>  net/6lowpan/iphc.c            | 2 +-
>  net/bluetooth/6lowpan.c       | 4 ++--
>  net/ieee802154/6lowpan_rtnl.c | 5 ++---
>  4 files changed, 6 insertions(+), 7 deletions(-)
> 

I don't test it yet, but you need to add a Signed-off-by: ...

You can create this with -s parameter while git format-patch.

Then I will test it.

- Alex
