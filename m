Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1378744257-648-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1378744257-648-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Fri, 13 Sep 2013 13:43:26 +0300
Message-ID: <CABBYNZ+h5geiWDBx7C4fnbVH5j=p-RoJxV-1S_herqJ1k2o3=Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] obexd: Use documented values in org.bluez.obex.Message1
 Type property
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Mon, Sep 9, 2013 at 7:30 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> This updates the values that are presented in the Type property to use
> the values from the documentation ("email", "sms-gsm", "sms-cdma", "mms").
> The existing code directly used the values as received in the messages
> listing object ("EMAIL", "SMS_GSM", "SMS_CDMA", "MMS").
> ---
>  obexd/client/map.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index f0dcf72..95f0334 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -894,7 +894,17 @@ static void parse_type(struct map_msg *msg, const char *value)
>                 return;
>
>         g_free(msg->type);
> -       msg->type = g_strdup(value);
> +
> +       if (strcasecmp(value, "SMS_GSM") == 0)
> +               msg->type = g_strdup("sms-gsm");
> +       else if (strcasecmp(value, "SMS_CDMA") == 0)
> +               msg->type = g_strdup("sms-cdma");
> +       else if (strcasecmp(value, "EMAIL") == 0)
> +               msg->type = g_strdup("email");
> +       else if (strcasecmp(value, "MMS") == 0)
> +               msg->type = g_strdup("mms");
> +       else
> +               msg->type = NULL;
>
>         g_dbus_emit_property_changed(conn, msg->path,
>                                                 MAP_MSG_INTERFACE, "Type");
> --
> 1.8.3.4

Applied, thanks.


-- 
Luiz Augusto von Dentz
