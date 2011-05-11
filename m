Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 May 2011 14:37:56 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com
Subject: Re: [PATCH] Bluetooth: Fix possible NULL pointer derefence in l2cap
 code
Message-ID: <20110511173756.GC22065@joana>
References: <1305119698-22888-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305119698-22888-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2011-05-11 15:14:58 +0200]:

> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/l2cap_core.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d0769a8..d9833d1 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3292,6 +3292,11 @@ static void l2cap_send_srejframe(struct l2cap_chan *chan, u8 tx_seq)
>  		l2cap_send_sframe(chan, control);
>  
>  		new = kzalloc(sizeof(struct srej_list), GFP_ATOMIC);
> +		if (!new) {
> +			BT_ERR("Memory allocation failed on tx_seq = %d",
> +							chan->expected_tx_seq);
> +			break;

I think a proper behavior here is disconnect the channel. The Enhanced
Retransmission mode is reliable and we have to guarantee that all data is
delivered. Skip adding to the list doesn't seem to be safe here. 

-- 
Gustavo F. Padovan
http://profusion.mobi
