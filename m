Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347639011-22924-1-git-send-email-s.syam@samsung.com>
References: <1347639011-22924-1-git-send-email-s.syam@samsung.com>
Date: Mon, 17 Sep 2012 16:55:33 +0300
Message-ID: <CABBYNZKwQe7B3tB9cOGF=y471vVD_cj-J2cH56Y1oXL+W4ihWw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 1/4] device: Remove dead code from get_properties()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Fri, Sep 14, 2012 at 7:10 PM, Syam Sidhardhan <s.syam@samsung.com> wrote:
> ---
>  src/device.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 49021e4..77215f1 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -318,7 +318,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
>         DBusMessageIter iter;
>         DBusMessageIter dict;
>         bdaddr_t src;
> -       char name[MAX_NAME_LENGTH + 1], srcaddr[18], dstaddr[18];
> +       char name[MAX_NAME_LENGTH + 1], dstaddr[18];
>         char **str;
>         const char *ptr, *icon = NULL;
>         dbus_bool_t boolean;
> @@ -348,7 +348,6 @@ static DBusMessage *get_properties(DBusConnection *conn,
>         ptr = NULL;
>         memset(name, 0, sizeof(name));
>         adapter_get_address(adapter, &src);
> -       ba2str(&src, srcaddr);
>
>         ptr = device->name;
>         dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &ptr);
> --
> 1.7.4.1

All 4 patches were pushed, I just did some small changes to 3/4 to
avoid double checking dbus_connection_send_with_reply_and_block return
since in case of error it is guaranteed that the reply is NULL and the
error is set: http://dbus.freedesktop.org/doc/api/html/group__DBusConnection.html#ga8d6431f17a9e53c9446d87c2ba8409f0

So the code now just check the if the error is set.

-- 
Luiz Augusto von Dentz
