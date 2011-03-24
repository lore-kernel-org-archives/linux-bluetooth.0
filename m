Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Mar 2011 16:11:56 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 1/3] Bluetooth: check info_rsp ident and states
Message-ID: <20110324191156.GC2236@joana>
References: <1300979768-31963-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1300979768-31963-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300979768-31963-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-03-24 17:16:06 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Information requests/responses are unbound to L2CAP channel. Patch
> fixes issue arising when two devices connects at the same time to
> each other. This way we do not process out of the context messages.
> We are safe dropping info_rsp since info_timer is left running.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/l2cap_core.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ca27f3a..fd58b8f 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2462,6 +2462,16 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
>  
>  	BT_DBG("type 0x%4.4x result 0x%2.2x", type, result);
>  
> +	if (cmd->ident != conn->info_ident) {
> +		BT_DBG("Collision receiving info response");
> +		return 0;
> +	}
> +
> +	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
> +		BT_DBG("Information request already done");
> +		return 0;
> +	}

This patch is good, but without the BT_DBG(). They are not needed.

-- 
Gustavo F. Padovan
http://profusion.mobi
