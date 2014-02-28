Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCHv2 1/8] shared/hfp: Fix parsing line with few commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393494006-20363-2-git-send-email-marcin.kraglak@tieto.com>
Date: Thu, 27 Feb 2014 23:00:12 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AE23C6FB-1A02-4C3C-9E43-DE569BF3F90D@holtmann.org>
References: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com> <1393494006-20363-2-git-send-email-marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

> If hfp_gw received line with few commands, it called command
> handler one time, for first command. Next comamnd was processed
> only if next line was received.
> Now, after every response from gw, we call proces_input to be
> sure that all data has been be processed.
> It will process next command only if response for previous was sent.
> ---
> src/shared/hfp.c | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
> index 854cf46..0681b19 100644
> --- a/src/shared/hfp.c
> +++ b/src/shared/hfp.c
> @@ -121,23 +121,21 @@ static void process_input(struct hfp_gw *hfp)
> 
> 		*ptr = '\0';
> 		count = asprintf(&ptr, "%s%s", str, str2);
> -		str = ptr;
> 	} else {
> -		count = ptr - str;
> 		*ptr = '\0';
> +		count = asprintf(&ptr, "%s", str);
> 	}

the whole point here is to not allocate a string if the command is not wrapped in the ring buffer. No idea what you are fixing here. And it is also not described in the commit message.

> 	hfp->result_pending = true;
> 
> +	len = ringbuf_drain(hfp->read_buf, count + 1);
> +
> 	if (hfp->command_callback)
> -		hfp->command_callback(str, hfp->command_data);
> +		hfp->command_callback(ptr, hfp->command_data);
> 	else
> 		hfp_gw_send_result(hfp, HFP_RESULT_ERROR);
> 
> -	len = ringbuf_drain(hfp->read_buf, count + 1);
> -
> -	if (str == ptr)
> -		free(ptr);
> +	free(ptr);
> }
> 
> static void read_watch_destroy(void *user_data)
> @@ -341,6 +339,8 @@ bool hfp_gw_send_result(struct hfp_gw *hfp, enum hfp_result result)
> 
> 	hfp->result_pending = false;
> 
> +	process_input(hfp);
> +
> 	return true;
> }
> 
> @@ -356,6 +356,8 @@ bool hfp_gw_send_error(struct hfp_gw *hfp, enum hfp_error error)
> 
> 	hfp->result_pending = false;
> 
> +	process_input(hfp);
> +
> 	return true;
> }

We can certainly do this, but normally AT commands work that you get one, send a response and then get the next one. Except for unsolicited notification, but in HFP gateway case, we are the ones sending these and not the headset.

What is this all fixing?

Regards

Marcel

