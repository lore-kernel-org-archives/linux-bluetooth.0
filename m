Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Sep 2010 13:29:53 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: remove extra newline from debug output
Message-ID: <20100915102952.GD14330@null>
References: <1283952413-22791-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283952413-22791-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Sep 08, 2010 at 03:26:53PM +0200, ext Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Acked-by: Ville Tervo <ville.tervo@nokia.com>


> ---
>  net/bluetooth/rfcomm/core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 16b79f3..a7e4f2d 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1698,7 +1698,7 @@ static int rfcomm_recv_frame(struct rfcomm_session *s, struct sk_buff *skb)
>  		break;
>  
>  	default:
> -		BT_ERR("Unknown packet type 0x%02x\n", type);
> +		BT_ERR("Unknown packet type 0x%02x", type);
>  		break;
>  	}
>  	kfree_skb(skb);


-- 
Ville
