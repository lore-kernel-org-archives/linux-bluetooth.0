Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH BlueZ] shared/att: Fix responding to unknown command
 opcode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170426141917.9727-1-luiz.dentz@gmail.com>
Date: Wed, 26 Apr 2017 16:49:43 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EDC2CC27-E6A3-4D22-8363-2C9552A599C8@holtmann.org>
References: <20170426141917.9727-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> In case of receiving an unknown command no response shall be generated.
> ---
> src/shared/att.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 3071b51..10e182f 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -148,7 +148,7 @@ static enum att_op_type get_op_type(uint8_t opcode)
> 			return att_opcode_type_table[i].type;
> 	}
> 
> -	return ATT_OP_TYPE_UNKNOWN;
> +	return opcode & ATT_OP_CMD_MASK ? ATT_OP_TYPE_CMD : ATT_OP_TYPE_UNKNOWN;
> }

for readability I would use this:

	return (opcode & ATT_OP_CMD_MASK) ? ATT_OP_TYPE_CMD : ATT_OP_TYPE_UNKNOWN;

Or just do this:

	if (opcode & ATT_OP_CMD_MASK)
		return ATT_OP_TYPE_CMD;

	return ATT_OP_TYPE_UNKNOWN;

Regards

Marcel

