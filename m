Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201108201751.39618.dstockwell@frequency-one.com>
References: <201108201751.39618.dstockwell@frequency-one.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 22 Aug 2011 12:11:48 -0300
Message-ID: <CAMOw1v6e6V-2d_YR3_F_OpGFJa5YW4FY5=vePjvqyNOcueuRBA@mail.gmail.com>
Subject: Re: [PATCH 2/3] AVRCP: Add Passthrough signal
To: David Stockwell <dstockwell@frequency-one.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Sat, Aug 20, 2011 at 7:51 PM, David Stockwell
<dstockwell@frequency-one.com> wrote:
> Add Passthrough signal, passing key state.
>
> If key is Vendor Unique (0x7E), also pass vendor's company_id and vendor-
> unique message as string.
>
> Signed-off-by: David Stockwell <dstockwell@frequency-one.com>
> ---
>  audio/control.c     |   75
> ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  doc/control-api.txt |   14 +++------
>  2 files changed, 79 insertions(+), 10 deletions(-)
>
> diff --git a/audio/control.c b/audio/control.c
> index 882c9fb..4e10cac 100644
> --- a/audio/control.c
> +++ b/audio/control.c
> @@ -106,6 +106,8 @@
>  #define FORWARD_OP             0x4b
>  #define BACKWARD_OP            0x4c
>
> +#define VENDOR_UNIQUE_OP       0x7E
> +
>  /* Company IDs for vendor dependent commands */
>  #define IEEEID_BTSIG           0x001958
>
> @@ -470,6 +472,15 @@ static sdp_record_t *avrcp_tg_record(void)
>        return record;
>  }
>
> +/**
> + *     get_company_id:
> + *
> + *     Return three-byte Company_ID from AVRCP message
> + */
> +static uint32_t get_company_id(uint8_t *cid) {
> +       return *cid << 16 | *(cid + 1) << 8 | *(cid + 2);
> +}

I think if we are adding the generic function, It would be good to
split the patch and also change the handle_vendordep_pdu() function to
use it.


> +
>  static int send_event(int fd, uint16_t type, uint16_t code, int32_t value)
>  {
>        struct uinput_event event;
> @@ -491,16 +502,77 @@ static void send_key(int fd, uint16_t key, int pressed)
>        send_event(fd, EV_SYN, SYN_REPORT, 0);
>  }
>
> +/**
> + *     handle_panel_passthrough:
> + *
> + *     Handles AVRCP 1.0+ PASSTHROUGH command, passes the keystroke to uinput.
> + *
> + *     Added a Passthrough signal, with the key state and the optional
> + *     following company_id and vendor-unique message.
> + */
> +
>  static void handle_panel_passthrough(struct control *control,
>                                        const unsigned char *operands,
>                                        int operand_count)
>  {
>        const char *status;
>        int pressed, i;
> -
> +       uint8_t         key_pressed;
> +       gboolean        key_status;
> +       uint32_t        pass_company_id;
> +       gchar           *pass_string;
> +
>        if (operand_count == 0)
>                return;
>
> +       /*
> +        * Following creates the Passthrough signal.
> +        * Key_state is zero if key is pressed (AVRCP v13r00 sect 24, p89)
> +        */
> +
> +       key_pressed = operands[0] & 0x7F;
> +       key_status = ((operands[0] & 0x80) == 0);
> +
> +       DBG("Passthrough Key: %x Pressed: %s", key_pressed,
> +                                               key_status ? "true" : "false");
> +       if (key_pressed==VENDOR_UNIQUE_OP) {
> +               if (operands[1] > 3) {
> +                       pass_company_id = get_company_id((uint8_t *) &operands[2]);
> +                       pass_string = g_strndup((const char *) &operands[5],
> +                                               (gsize) operands[1] - 3);
> +                       DBG("Passthrough Company_ID: %06X String: %s",
> +                           pass_company_id, pass_string);
> +               } else if (operands[1] == 3) {
> +                       pass_company_id = get_company_id((uint8_t *) &operands[2]);
> +                       pass_string = (gchar *) g_malloc0(1);
> +                       DBG("Passthrough Company_ID: %06X String: <none>",
> +                           pass_company_id);
> +               } else {
> +                       pass_company_id = 0;
> +                       pass_string = (gchar *) g_malloc0(1);
> +                       DBG("Passthrough: No Company_ID or String!");
> +               };
> +       } else {
> +               pass_company_id = 0;
> +               pass_string = (gchar *) g_malloc0(1);
> +       };
> +
> +       /*
> +        * Generate passthrough signal only if not BTSIG Company_ID.
> +        * For BTSIG, passthrough only for Group Navigation (unimplemented).
> +        */
> +
> +       if (pass_company_id != IEEEID_BTSIG)
> +               g_dbus_emit_signal(control->dev->conn, control->dev->path,
> +                          AUDIO_CONTROL_INTERFACE, "Passthrough",
> +                          DBUS_TYPE_BYTE, &key_pressed,
> +                          DBUS_TYPE_BOOLEAN, &key_status,
> +                          DBUS_TYPE_UINT32, &pass_company_id,
> +                          DBUS_TYPE_STRING, &pass_string,
> +                          DBUS_TYPE_INVALID);
> +
> +       g_free(pass_string);

II think the API designed for these passthrough is not good for what
we have now. It should be changed the same way we changed for other
commands into a separated MediaPlayer interface.

Also notice that we only support BT SIG passthrough commands (and I
think these are the ones to be sent through an interface like this).
For other companies, adding them here would imply to add them to the
GetCapability command.


Luiz, do you have any comments on this API?


Lucas De Marchi
