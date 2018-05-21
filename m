Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180516135230.7182-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180516135230.7182-1-grzegorz.kolodziejczyk@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 May 2018 11:38:34 +0300
Message-ID: <CABBYNZ+mHq81LLjUPDxCTcvS5xyntD52LNPd490J-ZUj0NoPkw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/5] client: Add missing duplicated string free
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wed, May 16, 2018 at 4:52 PM, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@codecoup.pl> wrote:
> This patch free duplicated strings in read, write attribute callbacks.
> ---
>  client/gatt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/client/gatt.c b/client/gatt.c
> index d59d1ba1e..c8267a75f 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -1598,6 +1598,7 @@ static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
>
>                 bt_shell_prompt_input("gatt", str, authorize_read_response,
>                                                                         aad);
> +               g_free(str);
>
>                 pending_message = dbus_message_ref(msg);
>
> @@ -1700,6 +1701,7 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
>
>                 bt_shell_prompt_input("gatt", str, authorize_write_response,
>                                                                         aad);
> +               g_free(str);
>
>                 pending_message = dbus_message_ref(msg);
>
> --
> 2.13.6

Patches 1 and 2 applied, thanks.

-- 
Luiz Augusto von Dentz
