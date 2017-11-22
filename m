Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b15a118c-f975-1530-5c95-89c8db0a3d27@jp.fujitsu.com>
References: <b15a118c-f975-1530-5c95-89c8db0a3d27@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Nov 2017 10:53:58 +0200
Message-ID: <CABBYNZ+wqHxHHSepO9JcAcvK+9oYR0qStcZRjXbQtYot3pE80w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] obexd: Fix fd which is left even after closing session
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Fri, Nov 17, 2017 at 1:30 PM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> A fd is duplicated if dbus type is unix fd, and then it is not closed
> even after the file is finished transporting. In the end obexd can not
> transport due to the limitation of open-able fd as below.
>
>   Warning: invalid file descriptor 1031 in syscall fcntl(DUPFD_CLOEXEC)()
>
>   FILE DESCRIPTORS: 1021 open at exit.
>   Open pf-31 socket 1023:
>      at 0x5061F1F: fcntl_common (fcntl.c:46)
>      by 0x5061F1F: fcntl (fcntl.c:79)
>      by 0x52A1C3D: _dbus_dup (in /lib/x86_64-linux-gnu/libdbus-1.so.3.14.13)
>      by 0x528C7B8: dbus_message_iter_get_basic (in /lib/x86_64-linux-gnu/libdbus-1.so.3.14.13)
>      by 0x149E04: profile_new_connection (bluetooth.c:136)
>      by 0x18AAF2: process_message.isra.3 (object.c:259)
>      by 0x18B364: generic_message (object.c:1079)
>      by 0x5290FD2: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.14.13)
>      by 0x5282623: dbus_connection_dispatch (in /lib/x86_64-linux-gnu/libdbus-1.so.3.14.13)
>      by 0x1852FF: message_dispatch (mainloop.c:72)
>      by 0x5505E24: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)
>      by 0x55061EF: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)
>      by 0x5506501: g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)
> ---
>  obexd/plugins/bluetooth.c | 5 ++++-
>  obexd/src/obex.c          | 4 +++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
> index 3ee54325f..d6028d114 100644
> --- a/obexd/plugins/bluetooth.c
> +++ b/obexd/plugins/bluetooth.c
> @@ -144,12 +144,15 @@ static DBusMessage *profile_new_connection(DBusConnection *conn,
>         if (fcntl(fd, F_GETFD) < 0) {
>                 error("bluetooth: fcntl(%d, F_GETFD): %s (%d)", fd,
>                                                 strerror(errno), errno);
> +               close(fd);
>                 return invalid_args(msg);
>         }
>
>         io = g_io_channel_unix_new(fd);
> -       if (io == NULL)
> +       if (io == NULL) {
> +               close(fd);
>                 return invalid_args(msg);
> +       }
>
>         DBG("device %s", device);
>
> diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> index be79a778e..308e56d07 100644
> --- a/obexd/src/obex.c
> +++ b/obexd/src/obex.c
> @@ -235,8 +235,10 @@ static void obex_session_free(struct obex_session *os)
>  {
>         sessions = g_slist_remove(sessions, os);
>
> -       if (os->io)
> +       if (os->io) {
> +               g_io_channel_shutdown(os->io, TRUE, NULL);
>                 g_io_channel_unref(os->io);
> +       }
>
>         if (os->obex)
>                 g_obex_unref(os->obex);
> --
> 2.14.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
