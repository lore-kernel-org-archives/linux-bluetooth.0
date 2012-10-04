Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349335599-12443-15-git-send-email-lucas.de.marchi@gmail.com>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
	<1349335599-12443-15-git-send-email-lucas.de.marchi@gmail.com>
Date: Thu, 4 Oct 2012 07:42:17 -0400
Message-ID: <CAJdJm_PZbDinMxO4En=3XMzjnNVTWpGQ9-pOV7VyfLJOJjY9Qg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 14/15] Use DBus.Properties on Control interface
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Oct 4, 2012 at 3:26 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> @@ -77,13 +76,11 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
>                 if (old_state != AVCTP_STATE_CONNECTED)
>                         break;
>
> -               value = FALSE;
>                 g_dbus_emit_signal(conn, dev->path,
>                                         AUDIO_CONTROL_INTERFACE,
>                                         "Disconnected", DBUS_TYPE_INVALID);
> -               emit_property_changed(dev->path,
> -                                       AUDIO_CONTROL_INTERFACE, "Connected",
> -                                       DBUS_TYPE_BOOLEAN, &value);
> +               g_dbus_emit_property_changed(conn, dev->path,
> +                                       AUDIO_CONTROL_INTERFACE, "Connected");

Out of curiosity, do you know why this API has Connected/Disconnected
signals besides the PropertyChanged("Connected", ...) ?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
