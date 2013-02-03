Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1359908071-15024-3-git-send-email-ospite@studenti.unina.it>
References: <1359908071-15024-1-git-send-email-ospite@studenti.unina.it>
	<1359908071-15024-3-git-send-email-ospite@studenti.unina.it>
Date: Sun, 3 Feb 2013 13:32:12 -0400
Message-ID: <CAJdJm_OFBu_gtgBz8+RFSS8cDVbtVH9DfuRtnimOd8auh8zDgw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] device: use device_set_trusted() in set_trust()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On Sun, Feb 3, 2013 at 12:14 PM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> @@ -724,17 +724,7 @@ static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data)
>  {
>         struct btd_device *device = data;
>
> -       if (device->trusted == value) {
> -               g_dbus_pending_property_success(id);
> -               return;
> -       }
> -
> -       device->trusted = value;
> -
> -       store_device_info(device);
> -
> -       g_dbus_emit_property_changed(dbus_conn, device->path,
> -                                               DEVICE_INTERFACE, "Trusted");
> +       device_set_trusted(device, value);
>
>         g_dbus_pending_property_success(id);

g_dbus_pending_property_success() is now called always (whether the
property changed or not). Not sure if this is an issue, but it is a
change that needs at least a clarification on the commit message.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
