Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Gu Chaojie <chao.jie.gu@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 1/3] shared/att.c:Add signed command outgoing and CSRK function
Date: Tue, 16 Dec 2014 13:43:30 +0100
Message-ID: <2354164.LHDJc0HTbQ@uw000953>
In-Reply-To: <1415351073-4362-2-git-send-email-chao.jie.gu@intel.com>
References: <1415351073-4362-1-git-send-email-chao.jie.gu@intel.com> <1415351073-4362-2-git-send-email-chao.jie.gu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gu Chaojie,

commit prefix should be "shared/att: "

I'm not fully getting commit subject... maybe something like
"shared/att: Add support for signed write command"

Also please put some explanation what is being done in patch in commit body.

Note that I might have more comments once this is rebased.

On Friday 07 of November 2014 17:04:31 Gu Chaojie wrote:
> ---
>  src/shared/att-types.h |   3 +
>  src/shared/att.c       | 146 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  src/shared/att.h       |  12 ++++
>  3 files changed, 158 insertions(+), 3 deletions(-)
> 
> diff --git a/src/shared/att-types.h b/src/shared/att-types.h
> index a6b23e4..1bea1ef 100644
> --- a/src/shared/att-types.h
> +++ b/src/shared/att-types.h
> @@ -25,6 +25,9 @@
>  
>  #define BT_ATT_DEFAULT_LE_MTU 23
>  
> +/* Length of signature in write signed packet */
> +#define BT_ATT_SIGNATURE_LEN		12

I don't think this needs to be exposed so it could be defined in att.c

> +
>  /* ATT protocol opcodes */
>  #define BT_ATT_OP_ERROR_RSP	      		0x01
>  #define BT_ATT_OP_MTU_REQ			0x02
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 6adde22..988eaff 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -36,6 +36,7 @@
>  #include "lib/uuid.h"
>  #include "src/shared/att.h"
>  #include "src/shared/att-types.h"
> +#include "src/shared/crypto.h"
>  
>  #define ATT_MIN_PDU_LEN			1  /* At least 1 byte for the opcode. */
>  #define ATT_OP_CMD_MASK			0x40
> @@ -44,6 +45,8 @@
>  
>  struct att_send_op;
>  
> +struct sign_write_info;
> +

This is not needed, just define this struct here.

>  struct bt_att {
>  	int ref_count;
>  	int fd;
> @@ -79,6 +82,16 @@ struct bt_att {
>  	bt_att_debug_func_t debug_callback;
>  	bt_att_destroy_func_t debug_destroy;
>  	void *debug_data;
> +
> +	struct bt_crypto *crypto;
> +
> +	struct sign_write_info *local_info;
> +	struct sign_write_info *remote_info;
> +};
> +
> +struct sign_write_info {
> +	uint8_t csrk[16];
> +	uint32_t sign_cnt;
>  };
>  
>  enum att_op_type {
> @@ -178,6 +191,8 @@ struct att_send_op {
>  	bt_att_response_func_t callback;
>  	bt_att_destroy_func_t destroy;
>  	void *user_data;
> +
> +	struct bt_att *att;
>  };
>  
>  static void destroy_att_send_op(void *data)
> @@ -289,6 +304,10 @@ static bool encode_pdu(struct att_send_op *op, const void *pdu,
>  						uint16_t length, uint16_t mtu)
>  {
>  	uint16_t pdu_len = 1;
> +	struct bt_att *att = op->att;
> +
> +	if (op->opcode & ATT_OP_SIGNED_MASK)
> +		pdu_len += BT_ATT_SIGNATURE_LEN;
>  
>  	if (length && pdu)
>  		pdu_len += length;
> @@ -305,17 +324,36 @@ static bool encode_pdu(struct att_send_op *op, const void *pdu,
>  	if (pdu_len > 1)
>  		memcpy(op->pdu + 1, pdu, length);
>  
> +	if (!(op->opcode & ATT_OP_SIGNED_MASK))
> +		return true;
> +
> +	if (!att->local_info)
> +		return false;

You are leaking pdu here op->pdu here and after bt_crypto_sign_att() failure.

> +
> +	if (!(bt_crypto_sign_att(att->crypto,
> +				att->local_info->csrk,
> +				op->pdu,
> +				1 + length,
> +				att->local_info->sign_cnt,
> +				&((uint8_t *) op->pdu)[1 + length])))
> +		return false;

This should be formatted like:
	if (!(bt_crypto_sign_att(att->crypto, att->local_info->csrk, op->pdu,
					1 + length, att->local_info->sign_cnt,
					&((uint8_t *) op->pdu)[1 + length])))

> +
> +	att->local_info->sign_cnt++;
> +
>  	return true;
>  }
>  
> -static struct att_send_op *create_att_send_op(uint8_t opcode, const void *pdu,
> -						uint16_t length, uint16_t mtu,
> +static struct att_send_op *create_att_send_op(uint8_t opcode,
> +						const void *pdu,
> +						uint16_t length,
> +						struct bt_att *att,
>  						bt_att_response_func_t callback,
>  						void *user_data,
>  						bt_att_destroy_func_t destroy)
>  {
>  	struct att_send_op *op;
>  	enum att_op_type op_type;
> +	uint16_t mtu = att->mtu;
>  
>  	if (length && !pdu)
>  		return NULL;
> @@ -346,6 +384,7 @@ static struct att_send_op *create_att_send_op(uint8_t opcode, const void *pdu,
>  	op->callback = callback;
>  	op->destroy = destroy;
>  	op->user_data = user_data;
> +	op->att = att;
>  
>  	if (!encode_pdu(op, pdu, length, mtu)) {
>  		free(op);
> @@ -756,6 +795,8 @@ struct bt_att *bt_att_new(int fd)
>  
>  	att->fd = fd;
>  
> +	att->local_info = NULL;
> +	att->remote_info = NULL;

This is not needed since att is allocated wit new0.

>  	att->mtu = BT_ATT_DEFAULT_LE_MTU;
>  	att->buf = malloc(att->mtu);
>  	if (!att->buf)
> @@ -765,6 +806,10 @@ struct bt_att *bt_att_new(int fd)
>  	if (!att->io)
>  		goto fail;
>  
> +	att->crypto = bt_crypto_new();
> +	if (!att->crypto)
> +		goto fail;
> +
>  	att->req_queue = queue_new();
>  	if (!att->req_queue)
>  		goto fail;
> @@ -799,6 +844,7 @@ fail:
>  	queue_destroy(att->write_queue, NULL);
>  	queue_destroy(att->notify_list, NULL);
>  	queue_destroy(att->disconn_list, NULL);
> +	bt_crypto_unref(att->crypto);
>  	io_destroy(att->io);
>  	free(att->buf);
>  	free(att);
> @@ -852,6 +898,16 @@ void bt_att_unref(struct bt_att *att)
>  	if (att->debug_destroy)
>  		att->debug_destroy(att->debug_data);
>  
> +	if (att->local_info) {
> +		free(att->local_info);
> +		att->local_info = NULL;

Since we free att few lines later there is no need to set local_info to NULL.
(actually this should be fixed in all cases in this function)

> +	}
> +
> +	if (att->remote_info) {
> +		free(att->remote_info);
> +		att->remote_info = NULL;

Same here.

> +	}
> +
>  	free(att->buf);
>  	att->buf = NULL;
>  
> @@ -995,7 +1051,7 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
>  	if (!att || !att->io)
>  		return 0;
>  
> -	op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
> +	op = create_att_send_op(opcode, pdu, length, att, callback,
>  							user_data, destroy);
>  	if (!op)
>  		return 0;
> @@ -1178,3 +1234,87 @@ bool bt_att_unregister_all(struct bt_att *att)
>  
>  	return true;
>  }
> +
> +bool bt_att_set_local_csrk(struct bt_att *att, uint32_t local_sign_cnt,
> +						uint8_t local_key[16])

Name those sing_cnt and key.

> +{
> +	struct sign_write_info *local_sign_info;

I don't see how this local variable helps. Just use att->local_info

> +
> +	if (!att)
> +		return false;
> +
> +	local_sign_info = att->local_info;
> +
> +	if (!local_sign_info) {
> +		local_sign_info = new0(struct sign_write_info, 1);
> +		if (!local_sign_info)
> +			return false;
> +		att->local_info = local_sign_info;
> +	}
> +
> +	local_sign_info->sign_cnt = local_sign_cnt;
> +	memcpy(local_sign_info->csrk, local_key, 16);

Why so complicated?

	if (!att->local_info)
		att->local_info = new0(struct sign_write_info, 1);
	
	if (!att->local_info)
		return false;

	att->local_info->sign_cnt = local_sign_cnt;
	memcpy(att->local_info->csrk, local_key, 16);


There is also question if we should allow to change csrk ie. if info is already
set maybe this function should fail?


Same goes for remote_csrk variant.

> +
> +	return true;
> +}
> +
> +bool bt_att_set_remote_csrk(struct bt_att *att, uint32_t remote_sign_cnt,
> +						uint8_t remote_key[16])
> +{
> +	struct sign_write_info *remote_sign_info;
> +
> +	if (!att)
> +		return false;
> +
> +	remote_sign_info = att->remote_info;
> +
> +	if (!remote_sign_info) {
> +		remote_sign_info = new0(struct sign_write_info, 1);
> +		if (!remote_sign_info)
> +			return false;
> +		att->remote_info = remote_sign_info;
> +	}
> +
> +	remote_sign_info->sign_cnt = remote_sign_cnt;
> +	memcpy(remote_sign_info->csrk, remote_key, 16);
> +
> +	return true;
> +}
> +
> +bool bt_att_get_local_csrk(struct bt_att *att, uint8_t local_key[16],
> +					uint32_t *local_sign_cnt)

Since function name is self explaining just use key and sign_cnt for parameters
names. Also this should be indented more right. Same for remote_csrk variant.

> +{
> +	struct sign_write_info *local_sign_info;

I'm not sure how this local variable helps. Just use att->local_info directly.
Same for remote_csrk variant.

> +
> +	if (!att)
> +		return false;
> +
> +	if (!att->local_info)
> +		return false;
> +
> +	local_sign_info = att->local_info;
> +
> +	memcpy(local_key, local_sign_info->csrk, 16);
> +	*local_sign_cnt = local_sign_info->sign_cnt;
> +
> +	return true;
> +}
> +
> +bool bt_att_get_remote_csrk(struct bt_att *att, uint8_t remote_key[16],
> +					uint32_t *remote_sign_cnt)
> +{
> +	struct sign_write_info *remote_sign_info;
> +
> +	if (!att)
> +		return false;
> +
> +	if (!att->remote_info)
> +		return false;
> +
> +	remote_sign_info = att->remote_info;
> +
> +	memcpy(remote_key, remote_sign_info->csrk, 16);
> +	*remote_sign_cnt = remote_sign_info->sign_cnt;
> +
> +	return true;
> +}
> diff --git a/src/shared/att.h b/src/shared/att.h
> index 1063021..d232d22 100644
> --- a/src/shared/att.h
> +++ b/src/shared/att.h
> @@ -76,3 +76,15 @@ unsigned int bt_att_register_disconnect(struct bt_att *att,
>  bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id);
>  
>  bool bt_att_unregister_all(struct bt_att *att);
> +
> +bool bt_att_set_local_csrk(struct bt_att *att, uint32_t local_sign_cnt,
> +						uint8_t local_key[16]);
> +
> +bool bt_att_set_remote_csrk(struct bt_att *att, uint32_t remote_sign_cnt,
> +						uint8_t remote_key[16]);
> +
> +bool bt_att_get_local_csrk(struct bt_att *att, uint8_t local_key[16],
> +					uint32_t *local_sign_cnt);
> +
> +bool bt_att_get_remote_csrk(struct bt_att *att, uint8_t remote_key[16],
> +					uint32_t *remote_sign_cnt);

Indentation should be up to the right. 

-- 
Best regards, 
Szymon Janc
