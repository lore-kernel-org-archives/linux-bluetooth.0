Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Feb 2012 14:38:46 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv6 01/14] Bluetooth: trivial: Fix long line
Message-ID: <20120220163846.GA28852@joana>
References: <1329747685-4163-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329747685-4163-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329747685-4163-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2012-02-20 16:21:12 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 37736c6..63539f9 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2720,7 +2720,8 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
>  	result = __le16_to_cpu(rsp->result);
>  	status = __le16_to_cpu(rsp->status);
>  
> -	BT_DBG("dcid 0x%4.4x scid 0x%4.4x result 0x%2.2x status 0x%2.2x", dcid, scid, result, status);
> +	BT_DBG("dcid 0x%4.4x scid 0x%4.4x result 0x%2.2x status 0x%2.2x",
> +						dcid, scid, result, status);
>  
>  	if (scid) {
>  		chan = l2cap_get_chan_by_scid(conn, scid);

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

	Gustavo
