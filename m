Return-Path: <cyrus@holtmann.org>
Message-id: <8E965D3870DC4AC1B476EF6E12DC2FE6@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: Syam Sidhardhan <s.syam@samsung.com>,
	linux-bluetooth@vger.kernel.org
References: <1322144076-1913-1-git-send-email-s.syam@samsung.com>
 <1322144076-1913-3-git-send-email-s.syam@samsung.com>
Subject: Re: [PATCH 3/3] Send the Extended Error result code,
 if requested in the failure cases
Date: Thu, 24 Nov 2011 20:46:22 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

----- Original Message ----- 
From: "Syam Sidhardhan" <s.syam@samsung.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: "Syam Sidhardhan" <s.syam@samsung.com>
Sent: Thursday, November 24, 2011 7:44 PM
Subject: [PATCH 3/3] Send the Extended Error result code, if requested in 
the failure cases


> If HF has already requested for the Extended Error result code reporting,
> then send the same in certain failure cases. Earlier in this case we were
> sending normal Error.
> ---
> audio/headset.c |    8 +++++++-
> 1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/audio/headset.c b/audio/headset.c
> index 6aef6a8..2bddedc 100644
> --- a/audio/headset.c
> +++ b/audio/headset.c
> @@ -1331,7 +1331,13 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, 
> GIOCondition cond,
>  if (err == -EINVAL) {
>  error("Badly formated or unrecognized command: %s",
>  &slc->buf[slc->data_start]);
> - err = headset_send(hs, "\r\nERROR\r\n");
> +
> + if (slc->enabled)
> + err = headset_send(hs, "\r\n+CME ERROR: %d\r\n",
> + CME_ERROR_NOT_SUPPORTED);
> + else
> + err = headset_send(hs, "\r\nERROR\r\n");
> +
>  if (err < 0)
>  goto failed;
>  } else if (err < 0)
> -- 
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kindly ignore this patch. Its should be if (slc->cme_enabled). Sorry, By 
mistake got posted before correcting.
Also I want to distinguish CME error message in the case of invalid AT 
commands and parse error(eg AT+CMER ).
Both case handle_event() returns -EINVAL.


Regards,
Syam.

