Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1358775868-9963-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
References: <1358775868-9963-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
Date: Mon, 21 Jan 2013 18:07:41 +0200
Message-ID: <CABBYNZLxFAtbknKQUyOmUORQ=XZNtP=ktnsLe64LoC=rBpeKZA@mail.gmail.com>
Subject: Re: [PATCH] Check uuid in disconnect profile.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alexandros Antonopoulos <alexandros.antonopoulos@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexandros,

On Mon, Jan 21, 2013 at 3:44 PM, Alexandros Antonopoulos
<alexandros.antonopoulos@oss.bmw-carit.de> wrote:
> If the user calls Device1.DisconnectProfile with an invalid profile
> uuid disconnect_profile still tries to parse the uuid resulting in
> a SIGSEGV
>
> ---
>  src/device.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 3675616..1771c0f 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1270,6 +1270,9 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
>
>         uuid = bt_name2string(pattern);
>
> +       if (uuid == NULL)
> +               return btd_error_invalid_args(msg);
> +
>         p = find_connectable_profile(dev, uuid);
>         g_free(uuid);
>
> --
> 1.8.1

All four patches are now upstream, Ive changed the commit message for
this one to include the prefix and also please next time state it is a
fix and provide the backtrace so we know the severity of the problem.

btw, thanks for the patches.


--
Luiz Augusto von Dentz
