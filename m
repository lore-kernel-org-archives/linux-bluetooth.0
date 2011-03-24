Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Mar 2011 15:57:59 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 2/3] Bluetooth: remove duplicated code
Message-ID: <20110324185759.GB2236@joana>
References: <1300979768-31963-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1300979768-31963-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300979768-31963-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-03-24 17:16:07 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> info_timer takes care about removed code
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/l2cap_core.c |   12 +++---------
>  1 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index fd58b8f..4255f00 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2472,16 +2472,10 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
>  		return 0;
>  	}
>  
> -	del_timer(&conn->info_timer);
> -
> -	if (result != L2CAP_IR_SUCCESS) {
> -		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
> -		conn->info_ident = 0;
> -
> -		l2cap_conn_start(conn);

Are you sure? Does remove this code won't create a delay to call
l2cap_conn_start()?

-- 
Gustavo F. Padovan
http://profusion.mobi
