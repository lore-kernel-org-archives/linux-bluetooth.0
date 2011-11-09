Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1320835923-10989-2-git-send-email-sancane@gmail.com>
References: <1320835923-10989-1-git-send-email-sancane@gmail.com>
	<1320835923-10989-2-git-send-email-sancane@gmail.com>
Date: Wed, 9 Nov 2011 08:00:38 -0400
Message-ID: <CAJdJm_OVgJbGrBmTgTUFaRHazDBweSagPJE0UP0eXa4MVFm61A@mail.gmail.com>
Subject: Re: [PATCH 1/6] Manage GATT attribute indications in handle callback.
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Wed, Nov 9, 2011 at 6:51 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> +static gint cmp_char_val_handle(gconstpointer a, gconstpointer b)
> +{
> +       const struct characteristic *ch = a;
> +       const uint16_t *handle = b;
> +
> +       if (ch->attr.value_handle == *handle)
> +               return 0;
> +
> +       return -1;
> +}

Usually we implement the function above as:

return ch->attr.value_handle - *handle;

It will work exactly as your code.

>  static void ind_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
>  {
> -       /* TODO: Process indication */
> +       struct thermometer *t = user_data;
> +       const struct characteristic *ch;
> +       uint8_t opdu[ATT_MAX_MTU];
> +       uint16_t handle, olen;
> +       GSList *l;
> +
> +       if (len < 3) {
> +               DBG("Bad pdu received");
> +               goto done;
> +       }

Are you sure we should send a confirmation even if the PDU received is
invalid? What if it is not even an indication (you only check below)?

> +
> +       if (pdu[0] != ATT_OP_HANDLE_IND) {
> +               DBG("Not indication received");
> +               return;
> +       }

I suggest a more descriptive debug message here, something like:

DBG("Unexpected ATT opcode: 0x%02x", pdu[0]);

> +
> +       handle = att_get_u16(&pdu[1]);
> +       l = g_slist_find_custom(t->chars, &handle, cmp_char_val_handle);
> +       if (l == NULL)
> +               goto done;

Again, should we send a confirmation to the thermometer even if the
indication's handle does not match any characteristic value?

(note I didn't read the thermometer profile spec carefully yet. Not
sure if it covers invalid PDUs.)

> +
> +       ch = l->data;
> +       if (g_strcmp0(ch->attr.uuid, TEMPERATURE_MEASUREMENT_UUID) == 0)
> +               proc_measurement(t, pdu, len, TRUE);
> +       else if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0)
> +               proc_measurement_interval(t, pdu, len);
> +
> +done:
> +       olen = enc_confirmation(opdu, sizeof(opdu));
> +
> +       if (olen > 0)
> +               g_attrib_send(t->attrib, 0, opdu[0], opdu, olen, NULL, NULL,
> +                                                                       NULL);
>  }

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
