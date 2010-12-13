Return-Path: <cyrus@holtmann.org>
Message-ID: <4D067A6C.6080404@codeaurora.org>
Date: Mon, 13 Dec 2010 11:56:28 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	rshaffer@codeaurora.org
Subject: Re: [PATCH 1/1] Support for reading long Characteristic Values.
References: <1292261066-28100-1-git-send-email-bgix@codeaurora.org> <1292261066-28100-3-git-send-email-bgix@codeaurora.org> <20101213183951.GB7549@eris>
In-Reply-To: <20101213183951.GB7549@eris>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On 12/13/2010 10:39 AM, Vinicius Costa Gomes wrote:
> On 09:24 Mon 13 Dec, Brian Gix wrote:
>> Modify existing gatt_read_char() function support the reading of
>> attributes (specifically Characteristic Values) that are longer than
>> the MTU would otherwise allow.  When a result to an ATT_OP_READ_REQ
>> is received, it will be passed to the requester as always if the total
>> result was shorter than the Default MTU (23). Any results equal to or
>> longer will cause a series of READ_BLOB requests to be made, with the
>> additional results built up until the end of the Attribute is detected.
>> The full result will then be passed to the original requester.
>>
>> The end of the Attribute is detected by either a successful result to
>> the READ_BLOB request that is shorter than the Default MTU, or by an
>> error result that indicates that a read is being attempted beyond the
>> length of the attribute, or that the Attribute wasn't "Long".
>>
>> This patch is dependant on the earlier patch:
>> 0001-Implempent-READ_BLOB-encoding-for-ATT.patch
>>
>> The packet composed conforms to the Bluetooth Core v4.0 specification.
>>
>> Brian Gix
>> bgix@codeaurora.org
>> Employee of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

I will omit the sig in the annotation in the future.

Also, I will examine the subsequent submissions for non-TAB ws.  I need 
to work on my gvim settings a bit, I think.

>>
>> ---
>>   attrib/gatt.c |  114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 files changed, 112 insertions(+), 2 deletions(-)
>>
>> diff --git a/attrib/gatt.c b/attrib/gatt.c
>> index bca8b49..d888f1d 100644
>> --- a/attrib/gatt.c
>> +++ b/attrib/gatt.c
>> @@ -97,15 +97,125 @@ guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
>>   					pdu, plen, func, user_data, NULL);
>>   }
>>
>> +struct read_long_data {
>> +	GAttrib *attrib;
>> +	GAttribResultFunc func;
>> +	gpointer user_data;
>> +	guint8 *result_data;
>> +	guint16 result_len;
>
> I would call result_data "buffer" (or something like it) and result_len "size"
> (or total). What do you think?

Will rename to buffer and size. I often avoid "size" to avoid keyword 
collisions, but I don't believe it applies here.

>
>> +	guint16 handle;
>> +};
>> +
>> +static void read_blob_helper(guint8 status, const guint8 *res_pdu,
>> +					guint16 res_len, gpointer user_data)
>> +{
>> +	struct read_long_data *long_read = user_data;
>> +	uint8_t pdu[ATT_DEFAULT_MTU];
>> +	guint8 *tmp;
>> +	guint16 plen;
>> +	guint ret_val;
>> +
>> +	if (status == ATT_ECODE_ATTR_NOT_LONG ||
>> +	    status == ATT_ECODE_INVALID_OFFSET) {
>> +		status = 0;
>> +		goto done;
>> +	}
>> +
>> +	if (status != 0 || res_len == 1)
>> +		goto done;
>> +
>> +	tmp = g_try_realloc(long_read->result_data,
>> +			    	long_read->result_len + res_len - 1);
>> +
>> +	if (tmp == NULL) {
>> +		status = ATT_ECODE_INSUFF_RESOURCES;
>> +		goto done;
>> +	}
>> +
>> +	memcpy(&tmp[long_read->result_len],&res_pdu[1], res_len-1);
>
> It should be "res - 1".
>
>> +	long_read->result_data = tmp;
>> +	long_read->result_len += res_len-1;
>
> Same here.
>
>> +
>> +	if (res_len<  ATT_DEFAULT_MTU)
>> +		goto done;
>> +
>> +	plen = enc_read_blob_req(long_read->handle, long_read->result_len-1,
>
> And here.

done, done, done.

>
>> +			 				pdu, sizeof(pdu));
>> +	ret_val = g_attrib_send(long_read->attrib, ATT_OP_READ_BLOB_REQ, pdu,
>> +				plen, read_blob_helper, long_read, NULL);
>> +
>> +	if (ret_val != 0)
>> +		return;
>> +
>> +	status = ATT_ECODE_INSUFF_RESOURCES;
>> +
>> +done:
>> +	long_read->func(status, long_read->result_data, long_read->result_len,
>> +							long_read->user_data);
>> +	g_free(long_read->result_data);
>> +	g_free(long_read);
>> +}
>> +
>> +static void read_char_helper(guint8 status, const guint8 *res_pdu,
>> +					guint16 res_len, gpointer user_data)
>> +{
>> +	struct read_long_data *long_read = user_data;
>> +	uint8_t pdu[ATT_DEFAULT_MTU];
>> +	guint16 plen;
>> +	guint ret_val;
>> +
>> +	if (status != 0 || res_len<  ATT_DEFAULT_MTU)
>> +		goto done;
>> +
>> +	long_read->result_data = g_malloc(res_len);
>> +
>> +	if (long_read->result_data == NULL)
>> +		goto done;
>> +
>> +	memcpy(long_read->result_data, res_pdu, res_len);
>> +	long_read->result_len = res_len;
>> +
>> +	plen = enc_read_blob_req(long_read->handle, res_len-1, pdu,
>> +				 				sizeof(pdu));
>> +	ret_val = g_attrib_send(long_read->attrib, ATT_OP_READ_BLOB_REQ,
>> +			pdu, plen, read_blob_helper, long_read, NULL);
>
> g_attrib_send() returns an command id (something that could be used to cancel
> the command later, if needed), so I think it would make more sense to call
> ret_val "id" or just "ret". And thinking about it, I guess that the "res_"
> prefix doesn't add much meaning to "res_pdu" and "res_len". Do you agree?

renamed res_pdu to "rpdu", to avoid name collision with outbound local 
pdu variable.

renamed res_len to "rlen" to keep the two together, and distinct from 
plen, which is also used for the outbound pdu.

renamed ret_val to "ret".  In two of the functions, it has lost the 
ability to be used to cancel the GATT procedure. It can cancel the 
original ATT_OP_READ_REQ opcodes, but not the subsequent 
ATT_OP_READ_BLOB_REQ opcodes.

>
>> +
>> +	if (ret_val != 0)
>> +		return;
>> +
>> +	status = ATT_ECODE_INSUFF_RESOURCES;
>> +
>> +done:
>> +	long_read->func(status, res_pdu, res_len, long_read->user_data);
>
> If g_attrib_send() fails, load_read->result_data may be leaking here.

Is there no guarantee that the GAttribResultFunc parameter will be 
invoked if there is a non-Zero return value from g_attrib_send?

If there is paths that could result in a non-response (abnormal link 
termination?) then you are correct, and I will need to rethink clean-up.

If I am correctly reading the code, I can pass a function to the 
GDestroyNotify parameter of g_attrib_send, which will alert me to the 
destruction of the command, at which point I could do clean-up. Is that 
path foolproof? This would also entail removing all g_free clean-ups 
from the helper functions, because the destroy function is always 
called, including after invoking the GAttribResultFunc function.

Also:
If we intend to use the ID of the (original) command to cancel the GATT
procedure, I propose the following:

Compound GATT procedure such as the Read Long procedure that I am 
implementing, should save the original ID returned by g_attrib_send in 
the nested user_data structure such as I have done. When subsequent ATT 
commands are sent as part of the same GATT procedure, the new command 
shall be assigned the same ID as the original.  This could be done with 
a function in gattrib.c with the prototype:

g_attrib_set_id(GAttrib *attrib, guint old_id, guint new_id);

This would allow the upper layer to cancel the entire GATT procedure, 
even if it is partially completed.

This same methodology could then be applied to long writes, and other 
compound GATT procedures.

What do you think?

>
>> +	g_free(long_read);
>> +}
>> +
>>   guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
>>   							gpointer user_data)
>>   {
>>   	uint8_t pdu[ATT_DEFAULT_MTU];
>>   	guint16 plen;
>> +	guint ret_val;
>> +	struct read_long_data *long_read;
>> +
>> +	long_read = g_try_new0(struct read_long_data, 1);
>> +
>> +	if (long_read == NULL)
>> +		return 0;
>> +
>> +	long_read->attrib = attrib;
>> +	long_read->func = func;
>> +	long_read->user_data = user_data;
>> +	long_read->handle = handle;
>>
>>   	plen = enc_read_req(handle, pdu, sizeof(pdu));
>> -	return g_attrib_send(attrib, ATT_OP_READ_REQ, pdu, plen, func,
>> -							user_data, NULL);
>> +	ret_val = g_attrib_send(attrib, ATT_OP_READ_REQ, pdu, plen,
>> +			     		read_char_helper, long_read, NULL);
>> +
>> +	if (ret_val == 0)
>> +		g_free(long_read);
>> +
>> +	return ret_val;
>>   }
>>
>>   guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Cheers,

Thanks,

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
