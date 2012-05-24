Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 12:27:16 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 1/3] Bluetooth: check for already existent channel before
 create new one
Message-ID: <20120524092714.GI24715@aemeltch-MOBL1>
References: <1337821964-4618-9-git-send-email-gustavo@padovan.org>
 <1337839374-20443-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337839374-20443-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, May 24, 2012 at 03:02:52AM -0300, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> Move this check to before the channel time creation simplifies the code
> and avoid memory allocation if the channel already exist.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/l2cap_core.c |   13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 22ba699..c9de4f5 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3340,21 +3340,16 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
>  
>  	result = L2CAP_CR_NO_MEM;
>  
> +	/* Check if we already have channel with that dcid */
> +	if (__l2cap_get_chan_by_dcid(conn, scid))
> +		goto response;
> +
>  	chan = pchan->ops->new_connection(pchan->data);
>  	if (!chan)
>  		goto response;
>  
>  	sk = chan->sk;
>  
> -	/* Check if we already have channel with that dcid */
> -	if (__l2cap_get_chan_by_dcid(conn, scid)) {
> -		if (chan->ops->finalize)
> -			chan->ops->finalize(chan->data, 0);

What is finalize? Is this the first patch? We do not have finalize yet.

Best regards 
Andrei Emeltchenko 

