Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Dec 2010 15:39:51 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	rshaffer@codeaurora.org
Subject: Re: [PATCH 1/1] Support for reading long Characteristic Values.
Message-ID: <20101213183951.GB7549@eris>
References: <1292261066-28100-1-git-send-email-bgix@codeaurora.org>
 <1292261066-28100-3-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292261066-28100-3-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 09:24 Mon 13 Dec, Brian Gix wrote:
> Modify existing gatt_read_char() function support the reading of 
> attributes (specifically Characteristic Values) that are longer than
> the MTU would otherwise allow.  When a result to an ATT_OP_READ_REQ
> is received, it will be passed to the requester as always if the total
> result was shorter than the Default MTU (23). Any results equal to or
> longer will cause a series of READ_BLOB requests to be made, with the
> additional results built up until the end of the Attribute is detected.
> The full result will then be passed to the original requester.
> 
> The end of the Attribute is detected by either a successful result to
> the READ_BLOB request that is shorter than the Default MTU, or by an
> error result that indicates that a read is being attempted beyond the
> length of the attribute, or that the Attribute wasn't "Long".
> 
> This patch is dependant on the earlier patch:
> 0001-Implempent-READ_BLOB-encoding-for-ATT.patch
> 
> The packet composed conforms to the Bluetooth Core v4.0 specification.
> 
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
> 
> ---
>  attrib/gatt.c |  114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 112 insertions(+), 2 deletions(-)
> 
> diff --git a/attrib/gatt.c b/attrib/gatt.c
> index bca8b49..d888f1d 100644
> --- a/attrib/gatt.c
> +++ b/attrib/gatt.c
> @@ -97,15 +97,125 @@ guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
>  					pdu, plen, func, user_data, NULL);
>  }
>  
> +struct read_long_data {
> +	GAttrib *attrib;
> +	GAttribResultFunc func;
> +	gpointer user_data;
> +	guint8 *result_data;
> +	guint16 result_len;

I would call result_data "buffer" (or something like it) and result_len "size"
(or total). What do you think?

> +	guint16 handle;
> +};
> +
> +static void read_blob_helper(guint8 status, const guint8 *res_pdu,
> +					guint16 res_len, gpointer user_data)
> +{
> +	struct read_long_data *long_read = user_data;
> +	uint8_t pdu[ATT_DEFAULT_MTU];
> +	guint8 *tmp;
> +	guint16 plen;
> +	guint ret_val;
> +
> +	if (status == ATT_ECODE_ATTR_NOT_LONG ||
> +	    status == ATT_ECODE_INVALID_OFFSET) {
> +		status = 0;
> +		goto done;
> +	}
> +
> +	if (status != 0 || res_len == 1)
> +		goto done;
> +
> +	tmp = g_try_realloc(long_read->result_data,
> +			    	long_read->result_len + res_len - 1);
> +
> +	if (tmp == NULL) {
> +		status = ATT_ECODE_INSUFF_RESOURCES;
> +		goto done;
> +	}
> +
> +	memcpy(&tmp[long_read->result_len], &res_pdu[1], res_len-1);

It should be "res - 1".

> +	long_read->result_data = tmp;
> +	long_read->result_len += res_len-1;

Same here.

> +
> +	if (res_len < ATT_DEFAULT_MTU)
> +		goto done;
> +
> +	plen = enc_read_blob_req(long_read->handle, long_read->result_len-1,

And here.

> +			 				pdu, sizeof(pdu));
> +	ret_val = g_attrib_send(long_read->attrib, ATT_OP_READ_BLOB_REQ, pdu,
> +				plen, read_blob_helper, long_read, NULL);
> +
> +	if (ret_val != 0)
> +		return;
> +
> +	status = ATT_ECODE_INSUFF_RESOURCES;
> +
> +done:
> +	long_read->func(status, long_read->result_data, long_read->result_len,
> +							long_read->user_data);
> +	g_free(long_read->result_data);
> +	g_free(long_read);
> +}
> +
> +static void read_char_helper(guint8 status, const guint8 *res_pdu,
> +					guint16 res_len, gpointer user_data)
> +{
> +	struct read_long_data *long_read = user_data;
> +	uint8_t pdu[ATT_DEFAULT_MTU];
> +	guint16 plen;
> +	guint ret_val;
> +
> +	if (status != 0 || res_len < ATT_DEFAULT_MTU)
> +		goto done;
> +
> +	long_read->result_data = g_malloc(res_len);
> +
> +	if (long_read->result_data == NULL)
> +		goto done;
> +
> +	memcpy(long_read->result_data, res_pdu, res_len);
> +	long_read->result_len = res_len;
> +
> +	plen = enc_read_blob_req(long_read->handle, res_len-1, pdu,
> +				 				sizeof(pdu));
> +	ret_val = g_attrib_send(long_read->attrib, ATT_OP_READ_BLOB_REQ,
> +			pdu, plen, read_blob_helper, long_read, NULL);

g_attrib_send() returns an command id (something that could be used to cancel
the command later, if needed), so I think it would make more sense to call
ret_val "id" or just "ret". And thinking about it, I guess that the "res_"
prefix doesn't add much meaning to "res_pdu" and "res_len". Do you agree?

> +
> +	if (ret_val != 0)
> +		return;
> +
> +	status = ATT_ECODE_INSUFF_RESOURCES;
> +
> +done:
> +	long_read->func(status, res_pdu, res_len, long_read->user_data);

If g_attrib_send() fails, load_read->result_data may be leaking here.

> +	g_free(long_read);
> +}
> +
>  guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
>  							gpointer user_data)
>  {
>  	uint8_t pdu[ATT_DEFAULT_MTU];
>  	guint16 plen;
> +	guint ret_val;
> +	struct read_long_data *long_read;
> +
> +	long_read = g_try_new0(struct read_long_data, 1);
> +
> +	if (long_read == NULL)
> +		return 0;
> +
> +	long_read->attrib = attrib;
> +	long_read->func = func;
> +	long_read->user_data = user_data;
> +	long_read->handle = handle;
>  
>  	plen = enc_read_req(handle, pdu, sizeof(pdu));
> -	return g_attrib_send(attrib, ATT_OP_READ_REQ, pdu, plen, func,
> -							user_data, NULL);
> +	ret_val = g_attrib_send(attrib, ATT_OP_READ_REQ, pdu, plen,
> +			     		read_char_helper, long_read, NULL);
> +
> +	if (ret_val == 0)
> +		g_free(long_read);
> +
> +	return ret_val;
>  }
>  
>  guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
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
