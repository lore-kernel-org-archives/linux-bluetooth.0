Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 May 2012 17:21:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5] AVCTP: Fix setting wrong transaction id
 expected for responses
Message-ID: <20120523142122.GA19662@x220.P-661HNU-F1>
References: <1337695255-9197-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337695255-9197-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, May 22, 2012, Luiz Augusto von Dentz wrote:
> The id were incremented after being set to the request so it is always
> +1 of the actual transaction.
> ---
>  audio/avctp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/audio/avctp.c b/audio/avctp.c
> index d98d097..f2d5954 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -981,7 +981,7 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
>  	struct avctp_rsp_handler *handler;
>  	int err;
>  
> -	err = avctp_send(session, id++, AVCTP_COMMAND, code, subunit,
> +	err = avctp_send(session, ++id, AVCTP_COMMAND, code, subunit,
>  				AVC_OP_VENDORDEP, operands, operand_count);
>  	if (err < 0)
>  		return err;

By switching to pre-increment you're essentially jumping over one
possible value since the send_passthrough function uses post-increment.
Not a very big issue, but what would be a bit cleaner imo is to drop the
increment from the avctp_send call and instead do a post-increment
together with the assignment to handler->id.

Johan
