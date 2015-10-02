Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1443700140-3905-2-git-send-email-bharat.panda@samsung.com>
References: <1443700140-3905-1-git-send-email-bharat.panda@samsung.com>
	<1443700140-3905-2-git-send-email-bharat.panda@samsung.com>
Date: Fri, 2 Oct 2015 10:33:07 +0300
Message-ID: <CABBYNZKdTyqUVSJwZo_Z17DFBbWMka-n7pULFhoChirdG_xL4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools: Fix Invalid return
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Thu, Oct 1, 2015 at 2:49 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Return DBUS_HANDLER_RESULT_HANDLED instead of
> DBUS_HANDLER_RESULT_NOT_YET_HANDLED for player message handle.
> ---
>  tools/mpris-proxy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
> index 693055e..2a5cbae 100644
> --- a/tools/mpris-proxy.c
> +++ b/tools/mpris-proxy.c
> @@ -205,6 +205,7 @@ static void append_container(DBusMessageIter *base, DBusMessageIter *iter,
>         case DBUS_TYPE_ARRAY:
>         case DBUS_TYPE_VARIANT:
>                 sig = dbus_message_iter_get_signature(&iter_sub);
> +               printf("signature: %s\n", sig);
>                 break;
>         default:
>                 sig = NULL;
> @@ -406,7 +407,7 @@ static DBusHandlerResult player_message(DBusConnection *conn,
>  done:
>         dbus_message_unref(copy);
>
> -       return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
> +       return DBUS_HANDLER_RESULT_HANDLED;
>  }
>
>  static struct player *find_player_by_bus_name(const char *name)
> --
> 1.9.1

I went ahead and applied this one, note that I removed the printf.


-- 
Luiz Augusto von Dentz
