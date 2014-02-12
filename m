Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/socket: Fix wrong memory access
Date: Wed, 12 Feb 2014 15:24:45 +0100
Message-ID: <2280349.UgpCoNr8dQ@leonov>
In-Reply-To: <1392214396-2576-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1392214396-2576-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 12 of February 2014 16:13:16 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> This fixes accessing proto[2] in the code.
> ---
>  android/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/socket.c b/android/socket.c
> index c62ca61..1551e9b 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -190,7 +190,7 @@ static sdp_record_t *create_rfcomm_record(uint8_t chan,
> uuid_t *uuid, {
>  	sdp_list_t *svclass_id;
>  	sdp_list_t *seq, *proto_seq, *pbg_seq;
> -	sdp_list_t *proto[2];
> +	sdp_list_t *proto[3];
>  	uuid_t l2cap_uuid, rfcomm_uuid, obex_uuid, pbg_uuid;
>  	sdp_data_t *channel;
>  	sdp_record_t *record;

Pushed, thanks.

-- 
BR
Szymon Janc
