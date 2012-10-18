Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Oct 2012 20:20:43 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Ludek Finstrle <luf@pzkagis.cz>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] attrib: Fix memleak if att_data_list_alloc fails
Message-ID: <20121018232043.GA29752@samus>
References: <CAJdJm_NiL522WPLrV-RiaJKBZeOBBgo_vSzQCwTdZwLZLTw88A@mail.gmail.com>
 <1350549561-16424-1-git-send-email-luf@pzkagis.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350549561-16424-1-git-send-email-luf@pzkagis.cz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 10:39 Thu 18 Oct, Ludek Finstrle wrote:
> Fix for memory leak which was introduced in commit f8619bef3406a2134082dc41c208105fe028c09f.
> I tested it with older bluez and rebase for git. Please review it.

Patch looks good. I would just re-send it without the last line in the
commit message.

But anyway, here's my Ack.

> 
> ---
>  src/attrib-server.c |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index ea27b13..4489edc 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -490,9 +490,11 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
>  	length = g_slist_length(groups);
>  
>  	adl = att_data_list_alloc(length, last_size + 4);
> -	if (adl == NULL)
> +	if (adl == NULL) {
> +		g_slist_free_full(groups, g_free);
>  		return enc_error_resp(ATT_OP_READ_BY_GROUP_REQ, start,
>  					ATT_ECODE_UNLIKELY, pdu, len);
> +	}
>  
>  	for (i = 0, l = groups; l; l = l->next, i++) {
>  		uint8_t *value;
> @@ -577,9 +579,11 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
>  	length += 2;
>  
>  	adl = att_data_list_alloc(num, length);
> -	if (adl == NULL)
> +	if (adl == NULL) {
> +		g_slist_free(types);
>  		return enc_error_resp(ATT_OP_READ_BY_TYPE_REQ, start,
>  					ATT_ECODE_UNLIKELY, pdu, len);
> +	}
>  
>  	for (i = 0, l = types; l; i++, l = l->next) {
>  		uint8_t *value;
> @@ -655,9 +659,11 @@ static uint16_t find_info(struct gatt_channel *channel, uint16_t start,
>  	}
>  
>  	adl = att_data_list_alloc(num, length + 2);
> -	if (adl == NULL)
> +	if (adl == NULL) {
> +		g_slist_free(info);
>  		return enc_error_resp(ATT_OP_FIND_INFO_REQ, start,
>  					ATT_ECODE_UNLIKELY, pdu, len);
> +	}
>  
>  	for (i = 0, l = info; l; i++, l = l->next) {
>  		uint8_t *value;
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius
