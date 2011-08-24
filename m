Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 11:36:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Stockwell <dstockwell@frequency-one.com>
Cc: linux-bluetooth@vger.kernel.org, lucas.demarchi@profusion.mobi,
	luiz.dentz@gmail.com
Subject: Re: [PATCH 3/3] AVRCP: Add Passthrough Signal
Message-ID: <20110824083658.GC19274@dell>
References: <201108232227.12124.dstockwell@frequency-one.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201108232227.12124.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Tue, Aug 23, 2011, David Stockwell wrote:
> +	if (key_pressed == VENDOR_UNIQUE_OP) {
> +		if (operands[1] == 0 || operand_count < 5) {
> +			pass_company_id = 0;
> +			pass_string = g_malloc0(1);

The above is a quite obscure way to allocate an empty string. Could you
change it to g_strdup(""). That requires a second or two less thinking
to figure out what the line is supposed to do :)

> +		} else if (operands[1] == 3 && operand_count == 5) {
> +			pass_company_id = get_company_id(operands + 2);
> +			pass_string = g_malloc0(1);

Same here.

> +		} else { /* op_length does not match operand_count */
> +			DBG("Passthrough: Malformed message");
> +			DBG("op_len %u, op_cnt %u", operands[1], operand_count);
> +			pass_company_id = 0;
> +			pass_string = g_malloc0(1);

And here.

> +		}
>  	} else {
> -		status = "pressed";
> -		pressed = 1;
> +		pass_company_id = 0;
> +		pass_string = g_malloc0(1);

And here.

> +		g_dbus_emit_signal(control->dev->conn, control->dev->path,
> +			   AUDIO_CONTROL_INTERFACE, "Passthrough",
> +			   DBUS_TYPE_BYTE, &key_pressed,
> +			   DBUS_TYPE_BOOLEAN, &key_state,
> +			   DBUS_TYPE_UINT32, &pass_company_id,
> +			   DBUS_TYPE_STRING, &pass_string,
> +			   DBUS_TYPE_INVALID);

The above lines still mix tabs and spaces for indentation. Just use
tabs.

Johan
