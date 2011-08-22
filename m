Return-Path: <cyrus@holtmann.org>
Message-ID: <DDBE962D5DE94A97A6602C2DCC9EFBC1@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Johan Hedberg" <johan.hedberg@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <201108201751.39618.dstockwell@frequency-one.com> <20110822102704.GB9949@dell>
In-Reply-To: <20110822102704.GB9949@dell>
Subject: Re: [PATCH 2/3] AVRCP: Add Passthrough signal
Date: Mon, 22 Aug 2011 07:07:22 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, Johan.

-----Original Message----- 
From: Johan Hedberg
Sent: Monday, August 22, 2011 5:27 AM
To: David Stockwell
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] AVRCP: Add Passthrough signal

Hi David,

On Sat, Aug 20, 2011, David Stockwell wrote:
> Add Passthrough signal, passing key state.
>
> If key is Vendor Unique (0x7E), also pass vendor's company_id and vendor-
> unique message as string.
>
> Signed-off-by: David Stockwell <dstockwell@frequency-one.com>

No signed-off-by in user-space patches please.

+++++ Got it.  Will (not) do.

> +/**
> + * get_company_id:
> + *
> + * Return three-byte Company_ID from AVRCP message
> + */
> +static uint32_t get_company_id(uint8_t *cid) {
> + return *cid << 16 | *(cid + 1) << 8 | *(cid + 2);
> +}

Please follow the coding style: new line before the opening {.  Also,
wouldn't it be a bit clearer if the input parameter was defined as:

static uint32_t get_company_id(uint8_t cid[3])

Regarding new style...sorry, this is an old fix.  Should have run this 
through the check-patches tool.  Will fix and resubmit.
Also agree regarding the input...it is more clear the way you recommend.

>  static void handle_panel_passthrough(struct control *control,
>  const unsigned char *operands,
>  int operand_count)
>  {
>  const char *status;
>  int pressed, i;
> -
> + uint8_t key_pressed;
> + gboolean key_status;
> + uint32_t pass_company_id;
> + gchar *pass_string;

It seems to me you're adding some redundancies here with the existing
pressed and status variables. Try to consolidate these to the bare
minimum if possible.

+++++ OK, will take a look.

> + if (key_pressed==VENDOR_UNIQUE_OP) {

Coding style: space before and after ==

Right, forgot to run the patch check...got lazy.

> + if (operands[1] > 3) {
> + pass_company_id = get_company_id((uint8_t *) &operands[2]);

You're not checking that operand_count is large enough before accessing
operands[1] and operands[2], i.e. essentially exposing yourself to a
buffer overflow dependent on unchecked data received from the remote
device.

+++++  Yes... will fix.

> + pass_string = g_strndup((const char *) &operands[5],
> + (gsize) operands[1] - 3);

Same thing here with operands[5] and operands[1]

> + DBG("Passthrough Company_ID: %06X String: %s",
> +     pass_company_id, pass_string);

Mixed tabs and spaces for indentation in the line above.

> + } else if (operands[1] == 3) {
> + pass_company_id = get_company_id((uint8_t *) &operands[2]);

Seems line an unnecessary typecast here, or then you need to change the
parameter type for get_company_id

> + pass_string = (gchar *) g_malloc0(1);

certainly an unnecessary typecast. gpointer and void* never need it.

> + DBG("Passthrough Company_ID: %06X String: <none>",
> +     pass_company_id);

Mixed tabs and spaces in the line above.

> + } else {
> + pass_company_id = 0;
> + pass_string = (gchar *) g_malloc0(1);

Unnecessary typecast.

> + DBG("Passthrough: No Company_ID or String!");
> + };
> + } else {
> + pass_company_id = 0;
> + pass_string = (gchar *) g_malloc0(1);

Same here.

> + if (pass_company_id != IEEEID_BTSIG)
> + g_dbus_emit_signal(control->dev->conn, control->dev->path,
> +    AUDIO_CONTROL_INTERFACE, "Passthrough",
> +    DBUS_TYPE_BYTE, &key_pressed,
> +    DBUS_TYPE_BOOLEAN, &key_status,
> +    DBUS_TYPE_UINT32, &pass_company_id,
> +    DBUS_TYPE_STRING, &pass_string,
> +    DBUS_TYPE_INVALID);
> +

Mixed tabs and spaces above. Additionally you've got a tab on the last
line which should be empty (i.e. only contain the newline character).

+++++ Actually, if I had just run check patches it would have caught all of 
this.

Sorry to see you expend the effort to write all of this (unless you have a 
"reject this patch" Perl script or something ;-).

Will resubmit, and it will be clean.



Johan 

