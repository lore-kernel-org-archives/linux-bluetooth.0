Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346233190-6238-1-git-send-email-frederic.danis@linux.intel.com>
References: <1346233190-6238-1-git-send-email-frederic.danis@linux.intel.com>
Date: Thu, 30 Aug 2012 18:21:08 +0300
Message-ID: <CABBYNZKgTHcPDGOj4Qi+6=XDqFK6g9c-zZ-tANKCjLQqhKKjQw@mail.gmail.com>
Subject: Re: [PATCH obexd] client: Add parameters to get message in map module
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?=
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Wed, Aug 29, 2012 at 12:39 PM, Frédéric Danis
<frederic.danis@linux.intel.com> wrote:
> GetMessage function needs attachment and charset application params
> ---
>  client/map.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/client/map.c b/client/map.c
> index 4f07fcb..fa27c21 100644
> --- a/client/map.c
> +++ b/client/map.c
> @@ -29,6 +29,8 @@
>  #include <glib.h>
>  #include <gdbus.h>
>
> +#include <gobex/gobex-apparam.h>
> +
>  #include "dbus.h"
>  #include "log.h"
>
> @@ -36,6 +38,7 @@
>  #include "transfer.h"
>  #include "session.h"
>  #include "driver.h"
> +#include "map_ap.h"
>
>  #define OBEX_MAS_UUID \
>         "\xBB\x58\x2B\x40\x42\x0C\x11\xDB\xB0\xDE\x08\x00\x20\x0C\x9A\x66"
> @@ -258,6 +261,9 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
>         struct map_msg *msg = user_data;
>         struct obc_transfer *transfer;
>         const char *target_file;
> +       GObexApparam *apparam;
> +       guint8 buf[6];
> +       gsize len;
>         GError *err = NULL;
>         DBusMessage *reply;
>
> @@ -272,6 +278,14 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
>         if (transfer == NULL)
>                 goto fail;
>
> +       apparam = g_obex_apparam_set_uint8(NULL, MAP_AP_ATTACHMENT, 0);
> +       apparam = g_obex_apparam_set_uint8(apparam, MAP_AP_CHARSET, 1);
> +       len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
> +
> +       obc_transfer_set_params(transfer, buf, len);
> +
> +       g_obex_apparam_free(apparam);
> +
>         if (!obc_session_queue(msg->data->session, transfer, NULL, NULL, &err))
>                 goto fail;
>
> --
> 1.7.9.5

I have a pending patchset to address this, basically adding filters
parameters so the application can enable what this parameters should
be. Btw, Im confused why are you setting attachment as type uint8, the
spec says it should assume "On" or "Off", which normally means it is
of string type.


-- 
Luiz Augusto von Dentz
