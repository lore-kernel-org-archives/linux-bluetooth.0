Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 13:27:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Stockwell <dstockwell@frequency-one.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] AVRCP: Add Passthrough signal
Message-ID: <20110822102704.GB9949@dell>
References: <201108201751.39618.dstockwell@frequency-one.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201108201751.39618.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Sat, Aug 20, 2011, David Stockwell wrote:
> Add Passthrough signal, passing key state.
> 
> If key is Vendor Unique (0x7E), also pass vendor's company_id and vendor-
> unique message as string.
> 
> Signed-off-by: David Stockwell <dstockwell@frequency-one.com>

No signed-off-by in user-space patches please.

> +/**
> + *	get_company_id:
> + *
> + *	Return three-byte Company_ID from AVRCP message
> + */
> +static uint32_t get_company_id(uint8_t *cid) {
> +	return *cid << 16 | *(cid + 1) << 8 | *(cid + 2);
> +}

Please follow the coding style: new line before the opening {.  Also,
wouldn't it be a bit clearer if the input parameter was defined as:

	static uint32_t get_company_id(uint8_t cid[3])

>  static void handle_panel_passthrough(struct control *control,
>  					const unsigned char *operands,
>  					int operand_count)
>  {
>  	const char *status;
>  	int pressed, i;
> -
> +	uint8_t		key_pressed;
> +	gboolean	key_status;
> +	uint32_t	pass_company_id;
> +	gchar		*pass_string;

It seems to me you're adding some redundancies here with the existing
pressed and status variables. Try to consolidate these to the bare
minimum if possible.

> +	if (key_pressed==VENDOR_UNIQUE_OP) {

Coding style: space before and after ==

> +		if (operands[1] > 3) {
> +			pass_company_id = get_company_id((uint8_t *) &operands[2]);

You're not checking that operand_count is large enough before accessing
operands[1] and operands[2], i.e. essentially exposing yourself to a
buffer overflow dependent on unchecked data received from the remote
device.

> +			pass_string = g_strndup((const char *) &operands[5],
> +						(gsize) operands[1] - 3);

Same thing here with operands[5] and operands[1]

> +			DBG("Passthrough Company_ID: %06X String: %s",
> +			    pass_company_id, pass_string);

Mixed tabs and spaces for indentation in the line above.

> +		} else if (operands[1] == 3) {
> +			pass_company_id = get_company_id((uint8_t *) &operands[2]);

Seems line an unnecessary typecast here, or then you need to change the
parameter type for get_company_id

> +			pass_string = (gchar *) g_malloc0(1);

certainly an unnecessary typecast. gpointer and void* never need it.

> +			DBG("Passthrough Company_ID: %06X String: <none>",
> +			    pass_company_id);

Mixed tabs and spaces in the line above.

> +		} else {
> +			pass_company_id = 0;
> +			pass_string = (gchar *) g_malloc0(1);

Unnecessary typecast.

> +			DBG("Passthrough: No Company_ID or String!");
> +		};
> +	} else {
> +		pass_company_id = 0;
> +		pass_string = (gchar *) g_malloc0(1);

Same here.

> +	if (pass_company_id != IEEEID_BTSIG)
> +		g_dbus_emit_signal(control->dev->conn, control->dev->path,
> +			   AUDIO_CONTROL_INTERFACE, "Passthrough",
> +			   DBUS_TYPE_BYTE, &key_pressed,
> +			   DBUS_TYPE_BOOLEAN, &key_status,
> +			   DBUS_TYPE_UINT32, &pass_company_id,
> +			   DBUS_TYPE_STRING, &pass_string,
> +			   DBUS_TYPE_INVALID);
> +	

Mixed tabs and spaces above. Additionally you've got a tab on the last
line which should be empty (i.e. only contain the newline character).

Johan
