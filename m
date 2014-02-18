Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1392741917-1145-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1392052498-9229-2-git-send-email-anderson.lizardo@openbossa.org>
	<1392741917-1145-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Tue, 18 Feb 2014 22:25:26 +0200
Message-ID: <CABBYNZLPPHJ50Q-OLif0e9z7U-TM0CvAZ9-TbkRZf+bLsu3jxA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] gdbus: Fix incorrect DBusConnection reference counting
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Tue, Feb 18, 2014 at 6:45 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Commit abfc2b0dd5c3e33abfdf1a815b16d492c1751c06 attempted to fix a crash
> related to improper reference counting, but the main issue was that the
> reference was taken only during the function call (which is usually
> unnecessary for single thread), but still passed a pointer to
> DBusConnection to a function that is called by the mainloop. This left a
> window where the DBusConnection can be destroyed.
>
> Fixes this crash on unit/test-gdbus-client:
>
> ==32642== Invalid read of size 4
> ==32642==    at 0x690D0A6: dbus_connection_ref (in
> /lib/i386-linux-gnu/libdbus-1.so.3.7.6)
> ==32642==    by 0x804CEDB: message_dispatch (mainloop.c:73)
> ==32642==    by 0x684580E: g_timeout_dispatch (gmain.c:4450)
> ==32642==    by 0x6844A75: g_main_context_dispatch (gmain.c:3065)
> ==32642==    by 0x6844E14: g_main_context_iterate.isra.23 (gmain.c:3712)
> ==32642==    by 0x68452FA: g_main_loop_run (gmain.c:3906)
> ==32642==    by 0x804C7D3: client_connect_disconnect
> (test-gdbus-client.c:188)
> ==32642==    by 0x6868DB2: g_test_run_suite_internal (gtestutils.c:2067)
> ==32642==    by 0x6868F8D: g_test_run_suite_internal (gtestutils.c:2138)
> ==32642==    by 0x6869320: g_test_run_suite (gtestutils.c:2189)
> ==32642==    by 0x686936B: g_test_run (gtestutils.c:1508)
> ==32642==    by 0x696D4D2: (below main) (libc-start.c:226)
> ==32642==  Address 0x709c6e4 is 140 bytes inside a block of size 144
> free'd
> ==32642==    at 0x67E806C: free (in
> /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
> ==32642==    by 0x692D62E: dbus_free (in
> /lib/i386-linux-gnu/libdbus-1.so.3.7.6)
> ==32642==    by 0x690E1C2: ??? (in
> /lib/i386-linux-gnu/libdbus-1.so.3.7.6)
> ==32642==    by 0x804AAEC: destroy_context (test-gdbus-client.c:104)
> ==32642==    by 0x6868DB2: g_test_run_suite_internal (gtestutils.c:2067)
> ==32642==    by 0x6868F8D: g_test_run_suite_internal (gtestutils.c:2138)
> ==32642==    by 0x6869320: g_test_run_suite (gtestutils.c:2189)
> ==32642==    by 0x686936B: g_test_run (gtestutils.c:1508)
> ==32642==    by 0x696D4D2: (below main) (libc-start.c:226)
> ---
>  gdbus/mainloop.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
> index 099b67f..ec52554 100644
> --- a/gdbus/mainloop.c
> +++ b/gdbus/mainloop.c
> @@ -70,8 +70,6 @@ static gboolean message_dispatch(void *data)
>  {
>         DBusConnection *conn = data;
>
> -       dbus_connection_ref(conn);
> -
>         /* Dispatch messages */
>         while (dbus_connection_dispatch(conn) == DBUS_DISPATCH_DATA_REMAINS);
>
> @@ -84,7 +82,8 @@ static inline void queue_dispatch(DBusConnection *conn,
>                                                 DBusDispatchStatus status)
>  {
>         if (status == DBUS_DISPATCH_DATA_REMAINS)
> -               g_timeout_add(DISPATCH_TIMEOUT, message_dispatch, conn);
> +               g_timeout_add(DISPATCH_TIMEOUT, message_dispatch,
> +                                               dbus_connection_ref(conn));
>  }
>
>  static gboolean watch_func(GIOChannel *chan, GIOCondition cond, gpointer data)
> @@ -92,9 +91,6 @@ static gboolean watch_func(GIOChannel *chan, GIOCondition cond, gpointer data)
>         struct watch_info *info = data;
>         unsigned int flags = 0;
>         DBusDispatchStatus status;
> -       DBusConnection *conn;
> -
> -       conn = dbus_connection_ref(info->conn);
>
>         if (cond & G_IO_IN)  flags |= DBUS_WATCH_READABLE;
>         if (cond & G_IO_OUT) flags |= DBUS_WATCH_WRITABLE;
> @@ -103,10 +99,8 @@ static gboolean watch_func(GIOChannel *chan, GIOCondition cond, gpointer data)
>
>         dbus_watch_handle(info->watch, flags);
>
> -       status = dbus_connection_get_dispatch_status(conn);
> -       queue_dispatch(conn, status);
> -
> -       dbus_connection_unref(conn);
> +       status = dbus_connection_get_dispatch_status(info->conn);
> +       queue_dispatch(info->conn, status);
>
>         return TRUE;
>  }
> --
> 1.8.5.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
