Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1360258831-18243-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1360258831-18243-1-git-send-email-vinicius.gomes@openbossa.org>
Date: Thu, 14 Feb 2013 16:02:38 +0200
Message-ID: <CABBYNZKQWqa9yUzb_PrRtSRsZ5K2BO_i9ncwpKe=5W_juNQUBw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: Fix missing PropertiesChanged signal
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, Feb 7, 2013 at 7:40 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> If D-Bus ObjectManager is not supported, InterfacesAdded signal
> checking needs to be ignored otherwise PropertiesChanged signal
> will never be sent.
> ---
>  gdbus/object.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 0c11246..43fb1f0 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -1701,8 +1701,11 @@ void g_dbus_emit_property_changed(DBusConnection *connection,
>         if (iface == NULL)
>                 return;
>
> -       /* Don't emit property changed if interface is not yet published */
> -       if (g_slist_find(data->added, iface))
> +       /*
> +        * If ObjectManager is attached, don't emit property changed if
> +        * interface is not yet published
> +        */
> +       if (root && g_slist_find(data->added, iface))
>                 return;
>
>         property = find_property(iface->properties, name);
> --
> 1.8.1.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
