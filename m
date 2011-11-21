Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Nov 2011 13:48:30 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH-v4 6/9] Bluetooth: Cleanup blkcipher on SMP termination
Message-ID: <20111121154829.GC2552@joana>
References: <1321480400-17397-1-git-send-email-bgix@codeaurora.org>
 <1321480400-17397-7-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321480400-17397-7-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

* Brian Gix <bgix@codeaurora.org> [2011-11-16 13:53:17 -0800]:

> The blkcipher must be freed to avoid memory leak.
> 
> Signed-off-by: Brian Gix <bgix@codeaurora.org>
> ---
>  net/bluetooth/smp.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 94e94ca..3b3726a 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -379,7 +379,13 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
>  
>  void smp_chan_destroy(struct l2cap_conn *conn)
>  {
> -	kfree(conn->smp_chan);
> +	struct smp_chan *smp = conn->smp_chan;
> +
> +	if (smp && !IS_ERR(smp->tfm))
> +		crypto_free_blkcipher(smp->tfm);

smp->tfm doesn't say what you want, if its allocation failed its value is
still 0. And I don't think we need to check for smp == NULL. It can't be null
at this point.

	Gustavo
