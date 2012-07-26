Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Jul 2012 17:45:27 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Subject: Re: [RFCv0 11/21] Bluetooth: Add move confirm response handling
Message-ID: <20120726144526.GF2686@aemeltch-MOBL1>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
 <1343260274-11953-12-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343260274-11953-12-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, Jul 25, 2012 at 04:51:03PM -0700, Mat Martineau wrote:
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 79f9d8e..bc56f09 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4579,6 +4579,7 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
>  						 u16 cmd_len, void *data)
>  {
>  	struct l2cap_move_chan_cfm_rsp *rsp = data;
> +	struct l2cap_chan *chan;
>  	u16 icid;
>  
>  	if (cmd_len != sizeof(*rsp))
> @@ -4588,6 +4589,32 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
>  
>  	BT_DBG("icid 0x%4.4x", icid);
>  
> +	chan = l2cap_get_chan_by_scid(conn, icid);
> +

nitpick: extra new line here.

> +	if (!chan)
> +		return 0;

are we going to use return code?

...

Best regards 
Andrei Emeltchenko 
