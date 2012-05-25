Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 09:29:36 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 11/18] Bluetooth: A2MP: Process A2MP Change Notify
Message-ID: <20120525122936.GC31623@joana>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337859508-32274-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337859508-32274-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337859508-32274-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-05-24 14:38:21 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Placeholder for A2MP Change Notify handler.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/a2mp.c |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index ac095ac..d60be75 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -161,6 +161,22 @@ static int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
>  	return 0;
>  }
>  
> +static int a2mp_change_notify(struct amp_mgr *mgr, struct sk_buff *skb,
> +			      struct a2mp_cmd *hdr)
> +{
> +	struct a2mp_cl *cl = (struct a2mp_cl *) skb->data;

Use void *. Same for the next patches in this series.

	Gustavo
