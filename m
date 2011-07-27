Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1311624955-22360-5-git-send-email-anderson.lizardo@openbossa.org>
References: <1311624955-22360-1-git-send-email-anderson.lizardo@openbossa.org>
	<1311624955-22360-5-git-send-email-anderson.lizardo@openbossa.org>
Date: Tue, 26 Jul 2011 17:08:02 -0700
Message-ID: <CAE-CKujoGHF+8PgnhKZyXdQ1+eVjYzcaFVFsAR+BcnhwBCT2Eg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/5] Register primary service for Immediate Alert
From: mike tsai <mikeyhtsai@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>
> +static void register_immediate_alert(void)
> +{
> +       uint16_t start_handle, h;
> +       const int svc_size = 3;
> +       uint8_t atval[256];
> +       bt_uuid_t uuid;
> +
> +       start_handle = attrib_db_find_avail(svc_size);
> +       if (start_handle == 0) {
> +               error("Not enough free handles to register service");
> +               return;
> +       }
> +
> +       DBG("start_handle=0x%04x", start_handle);
> +
> +       h = start_handle;
> +
> +       /* Primary service definition */
> +       bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
> +       att_put_u16(IMMEDIATE_ALERT_SVC_UUID, &atval[0]);
> +       attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
> +
> +       /* Alert level characteristic */
> +       bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
> +       atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_WRITE;
> +       att_put_u16(h + 1, &atval[1]);
> +       att_put_u16(ALERT_LEVEL_CHR_UUID, &atval[3]);
> +       attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
> +
> +       /* Alert level value */
> +       bt_uuid16_create(&uuid, ALERT_LEVEL_CHR_UUID);
> +       att_put_u8(NO_ALERT, &atval[0]);
> +       attrib_db_add(h++, &uuid, ATT_NONE, ATT_NONE, atval, 1);
> +
> +       g_assert(h - start_handle == svc_size);
> +}
> +
[MT] a couple things here, first, should the attrib_db_add function
allow input parameters  "wgardrite_cb" and "read_cb"?
        second, should this function register a write_cb for immediate
alert characteristic? so if the client writes a value to this
characteristic, the write_cb can be called?  And I think a signal will
be sent to application that has registered with immediate alert
service?

Regards,

Mike
