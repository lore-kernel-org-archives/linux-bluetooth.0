Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347541403-11780-9-git-send-email-chen.ganir@ti.com>
References: <1347541403-11780-1-git-send-email-chen.ganir@ti.com>
	<1347541403-11780-9-git-send-email-chen.ganir@ti.com>
Date: Thu, 13 Sep 2012 10:47:23 -0400
Message-ID: <CAJdJm_N1mmNQFCbFD7BSfxQK1SigRL8exjg_jYqO_o0L8juRTQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] battery: Read Battery level characteristic
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Sep 13, 2012 at 9:03 AM,  <chen.ganir@ti.com> wrote:
> +static void read_batterylevel_cb(guint8 status, const guint8 *pdu, guint16 len,
> +                                                       gpointer user_data)
> +{
> +       struct characteristic *ch = user_data;
> +       uint8_t value[ATT_MAX_MTU];
> +       int vlen;
> +
> +       if (status != 0) {
> +               error("Failed to read Battery Level:%s", att_ecode2str(status));
> +               return;
> +       }
> +
> +       vlen = dec_read_resp(pdu, len, value, sizeof(value));
> +       if (!vlen) {
> +               error("Failed to read Battery Level: Protocol error\n");
> +               return;
> +       }

You should check for vlen < 0 instead. See dec_read_resp()
implementation (there may be other places with this bug in bluez as
well, feel free to fix them if you find).

Also note that messages in error() should not contain "\n" (I've seen
this in other patches on the series as well).

> +
> +       if (vlen < 1) {
> +               error("Failed to read Battery Level: Wrong pdu len");
> +               return;
> +       }

What about checking for "vlen != 1" instead ?

> +static struct characteristic *find_battery_char(struct btd_battery *db)
> +{
> +       GSList *l, *b;
> +
> +       for (l = servers; l != NULL; l = g_slist_next(l)) {
> +               struct battery *batt = l->data;
> +
> +               b = g_slist_find_custom(batt->chars, db, device_battery_cmp);
> +               if (!b)
> +                       return NULL;

Shouldn't it be a "continue" above instead of "return NULL" ?
Otherwise the loop will never go past the first server.

> +
> +               return b->data;
> +       }
> +
> +       return NULL;
> +}

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
