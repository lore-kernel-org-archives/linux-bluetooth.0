Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Oct 2012 17:34:03 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: SMP: Fix setting unknown auth_req bits
Message-ID: <20121011143355.GA28051@aemeltch-MOBL1>
References: <1349965566-29482-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349965566-29482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Oct 11, 2012 at 04:26:06PM +0200, Johan Hedberg wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> When sending a pairing request or response we should not just blindly
> copy the value that the remote device sent. Instead we should at least
> make sure to mask out any unknown bits. This is particularly critical
> from the upcoming LE Secure Connections feature perspective as
> incorrectly indicating support for it (by copying the remote value)
> would cause a failure to pair with devices that support it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@kernel.org
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/smp.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 9b54fea..9176bc1 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -32,6 +32,8 @@
>  
>  #define SMP_TIMEOUT	msecs_to_jiffies(30000)
>  
> +#define AUTH_REQ_MASK   0x07
> +
>  static inline void swap128(u8 src[16], u8 dst[16])
>  {
>  	int i;
> @@ -230,7 +232,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
>  		req->max_key_size = SMP_MAX_ENC_KEY_SIZE;
>  		req->init_key_dist = 0;
>  		req->resp_key_dist = dist_keys;
> -		req->auth_req = authreq;
> +		req->auth_req = (authreq & AUTH_REQ_MASK);
>  		return;
>  	}
>  
> @@ -239,7 +241,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
>  	rsp->max_key_size = SMP_MAX_ENC_KEY_SIZE;
>  	rsp->init_key_dist = 0;
>  	rsp->resp_key_dist = req->resp_key_dist & dist_keys;
> -	rsp->auth_req = authreq;
> +	rsp->auth_req = (authreq & AUTH_REQ_MASK);

Would it be better to omit braces like in the line above? For both cases.

Best regards 
Andrei Emeltchenko 

