Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Don't response with error for NOTIFICATION and INDICATION
Date: Tue, 20 May 2014 20:24:21 +0200
Message-ID: <2463261.SrCrPTSHpr@athlon>
In-Reply-To: <1400565511-2360-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400565511-2360-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tuesday 20 May 2014 07:58:31 Marcin Kraglak wrote:
> We shouldn't response for these commands, as they will be serviced
> in client implementation.
> ---
>  android/gatt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 8e0d72a..5caa50f 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4762,11 +4762,13 @@ static void att_handler(const uint8_t *ipdu,
> uint16_t len, gpointer user_data) case ATT_OP_FIND_BY_TYPE_REQ:
>  		status = find_by_type_request(ipdu, len, dev);
>  		break;
> +        case ATT_OP_HANDLE_IND:
> +        case ATT_OP_HANDLE_NOTIFY:
> +		/* Client will handle this */
> +		return;
>  	case ATT_OP_EXEC_WRITE_REQ:
>  		/* TODO */
>  	case ATT_OP_HANDLE_CNF:
> -	case ATT_OP_HANDLE_IND:
> -	case ATT_OP_HANDLE_NOTIFY:
>  	case ATT_OP_READ_MULTI_REQ:
>  	default:
>  		DBG("Unsupported request 0x%02x", ipdu[0]);

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
