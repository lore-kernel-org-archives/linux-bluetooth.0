Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jun 2011 15:03:28 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: ilia.kolominsky@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Ilia Kolomisnky <iliak@ti.com>
Subject: Re: [PATCH] bluetooth-next: Fixes l2cap incomming connection
 establishment when defer_setup is enabled.
Message-ID: <20110630180328.GC25602@joana>
References: <1309405258-25697-1-git-send-email-iliak@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309405258-25697-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

* ilia.kolominsky@gmail.com <ilia.kolominsky@gmail.com> [2011-06-30 06:40:58 +0300]:

> From: Ilia Kolomisnky <iliak@ti.com>
> 
> PTS test A2DP/SRC/SRC_SET/TC_SRC_SET_BV_02_I revealed that
> ( probably after the df3c3931e commit ) the l2cap connection
> could not be established in case when the "Auth Complete" HCI
> event does not arive before the initiator send "Configuration
> request", in which case l2cap replies with "Command rejected"
> since the channel is still in BT_CONNECT2 state.
> 
> Signed-off-by: Ilia Kolomisnky <iliak@ti.com>
> ---
>  net/bluetooth/l2cap_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 9ec9c8c..0d9699b 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2530,7 +2530,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
>  
>  	sk = chan->sk;
>  
> -	if (chan->state != BT_CONFIG) {
> +	if ((!bt_sk(sk)->defer_setup) && (chan->state != BT_CONFIG)) {

This will cause L2CAP fail to drop any connection request for any chan->state
when defer_setup is enabled. I think you want:

	if ((!bt_sk(sk)->defer_setup && chan->state != BT_CONNECT2)
			|| chan->state != BT_CONFIG) {

	Gustavo
