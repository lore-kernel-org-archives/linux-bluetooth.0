Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1317232126-12640-8-git-send-email-sancane@gmail.com>
References: <1317232126-12640-1-git-send-email-sancane@gmail.com>
	<1317232126-12640-2-git-send-email-sancane@gmail.com>
	<1317232126-12640-3-git-send-email-sancane@gmail.com>
	<1317232126-12640-4-git-send-email-sancane@gmail.com>
	<1317232126-12640-5-git-send-email-sancane@gmail.com>
	<1317232126-12640-6-git-send-email-sancane@gmail.com>
	<1317232126-12640-7-git-send-email-sancane@gmail.com>
	<1317232126-12640-8-git-send-email-sancane@gmail.com>
Date: Wed, 28 Sep 2011 14:26:50 -0400
Message-ID: <CAJdJm_OGGROUJ1NoJAdT09CTVEngrNdfxYWC5c7kp8RhJcvvcA@mail.gmail.com>
Subject: Re: [PATCH 7/9] Read temperature type characteristic
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Wed, Sep 28, 2011 at 1:48 PM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> +static gchar* temptype2str(uint8_t value)

Small conding style issue here: gchar*  -> gchar *

> +{
> +       switch (value) {
> +       case 1: return "Armpit";
> +       case 2: return "Body";
> +       case 3: return "Ear";
> +       case 4: return "Finger";
> +       case 5: return "Intestines";
> +       case 6: return "Mouth";
> +       case 7: return "Rectum";
> +       case 8: return "Toe";
> +       case 9: return "Tympanum";
> +       default:
> +               error("Temperature type %d reserved for future use", value);
> +               return NULL;
> +       };
> +}
> +
>  static void destroy_char(gpointer user_data)
>  {
>        struct characteristic *c = user_data;
> @@ -113,7 +138,27 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
>  static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
>                                                        gpointer user_data)
>  {
> -       /* TODO */
> +       struct characteristic *ch = user_data;
> +       struct thermometer *t = ch->t;
> +       uint8_t value;
> +       int vlen;
> +
> +       if (status != 0) {
> +               DBG("Temperature Type value read failed: %s",
> +                                                       att_ecode2str(status));
> +               return;
> +       }
> +
> +       if (!dec_read_resp(pdu, len, &value, &vlen)) {

Your code is assuming that the read response PDU will always have a
one-byte value. This will cause memory corruption if the peer sends an
error response with size greater than 2 (first byte is the opcode).

Either put a check like "if (len == sizeof(uint8_t) + 1 &&
read_read_resp(...))", or use:

uint8_t value[ATT_MAX_MTU];

and cast the first byte.

(just noticed that Proximity monitor code has the same bug...)

> +               DBG("Protocol error");
> +               return;
> +       }
> +
> +       DBG("TEMPERATURE TYPE: %s", temptype2str(value));

Can you avoid using all-caps on the DBG() message above?

> +       if (!t->has_interval)
> +               t->has_interval = TRUE;

Why the if() check? You could just do "t->has_interval = TRUE;" always.

> +
> +       t->type = value;
>  }

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
