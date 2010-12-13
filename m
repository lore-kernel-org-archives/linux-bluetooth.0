Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Dec 2010 15:15:29 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	rshaffer@codeaurora.org
Subject: Re: [PATCH 1/1] Implempent READ_BLOB encoding for ATT.
Message-ID: <20101213181529.GA7549@eris>
References: <1292261066-28100-1-git-send-email-bgix@codeaurora.org>
 <1292261066-28100-2-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292261066-28100-2-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On 09:24 Mon 13 Dec, Brian Gix wrote:
> Added enc_read_blob_req() API to ATT transport, to enable
> the reading of attributes that exceed the length of the
> MTU.
> 
> The packet composed conforms to the Bluetooth Core v4.0 specification.
> 
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 

Not sure if this signature belongs in the patch comment.

> 
> ---
>  attrib/att.c |   18 ++++++++++++++++++
>  attrib/att.h |    2 ++
>  2 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/attrib/att.c b/attrib/att.c
> index 445b192..d0879f8 100644
> --- a/attrib/att.c
> +++ b/attrib/att.c
> @@ -542,6 +542,24 @@ uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len)
>  	return min_len;
>  }
>  
> +uint16_t enc_read_blob_req(uint16_t handle, uint16_t offset, uint8_t *pdu,
> +			   						int len)

I couldn't apply the patches because there were a mix between tabs and spaces,
please use only tabs for indentation.

> +{
> +	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle) + sizeof(offset);
> +
> +	if (pdu == NULL)
> +		return 0;
> +
> +	if (len < min_len)
> +		return 0;
> +
> +	pdu[0] = ATT_OP_READ_BLOB_REQ;
> +	att_put_u16(handle, &pdu[1]);
> +	att_put_u16(offset, &pdu[3]);
> +
> +	return min_len;
> +}
> +
>  uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle)
>  {
>  	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
> diff --git a/attrib/att.h b/attrib/att.h
> index 2c8c724..46bdad4 100644
> --- a/attrib/att.h
> +++ b/attrib/att.h
> @@ -202,6 +202,8 @@ uint16_t enc_write_req(uint16_t handle, const uint8_t *value, int vlen,
>  uint16_t dec_write_req(const uint8_t *pdu, int len, uint16_t *handle,
>  						uint8_t *value, int *vlen);
>  uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, int len);
> +uint16_t enc_read_blob_req(uint16_t handle, uint16_t offset, uint8_t *pdu,
> +			   						int len);
>  uint16_t dec_read_req(const uint8_t *pdu, int len, uint16_t *handle);
>  uint16_t enc_read_resp(uint8_t *value, int vlen, uint8_t *pdu, int len);
>  uint16_t dec_read_resp(const uint8_t *pdu, int len, uint8_t *value, int *vlen);
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Vinicius
