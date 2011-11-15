Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1321368294-29379-1-git-send-email-bulislaw@linux.com>
References: <1321368294-29379-1-git-send-email-bulislaw@linux.com>
Date: Wed, 16 Nov 2011 00:29:27 +0200
Message-ID: <CABBYNZLMKiRjuc9de0g_26PW=OAmAgJfOSRaCFMHBSPSHjbnig@mail.gmail.com>
Subject: Re: [PATCH] gobex: Fix setpath to match one from OBEX spec
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Tue, Nov 15, 2011 at 4:44 PM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
> OBEX spec states that when bit 0 is set in flags, server should backup a
> level before applying name. It's accomplished by moving parsing of the
> path to upper layers (as gobex is low level lib and I think it should be
> based on level defined in OBEX spec, upper profiles may wrap that as
> defined in correspondent specifications) and exposing *cdup* flag in
> function parameters.
> ---
>  client/ftp.c      |    6 +++++-
>  client/pbap.c     |    4 ++--
>  gobex/gobex.c     |   16 ++++++++++------
>  gobex/gobex.h     |    5 +++--
>  unit/test-gobex.c |   46 ++++++++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 64 insertions(+), 13 deletions(-)
>
> diff --git a/client/ftp.c b/client/ftp.c
> index 336fc26..d9e31ad 100644
> --- a/client/ftp.c
> +++ b/client/ftp.c
> @@ -82,7 +82,11 @@ static DBusMessage *change_folder(DBusConnection *connection,
>                return g_dbus_create_error(message,
>                                "org.openobex.Error.InvalidArguments", NULL);
>
> -       g_obex_setpath(obex, folder, async_cb, message, &err);
> +       if (g_strcmp0("..", folder) == 0)
> +               g_obex_setpath(obex, NULL, TRUE, async_cb, message, &err);
> +       else
> +               g_obex_setpath(obex, folder, FALSE, async_cb, message, &err);
> +
>        if (err != NULL) {
>                DBusMessage *reply;
>                reply =  g_dbus_create_error(message,
> diff --git a/client/pbap.c b/client/pbap.c
> index 9e9eb05..5055ad9 100644
> --- a/client/pbap.c
> +++ b/client/pbap.c
> @@ -277,7 +277,7 @@ static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
>
>        data->index++;
>
> -       g_obex_setpath(obex, next, setpath_cb, data, &err);
> +       g_obex_setpath(obex, next, FALSE, setpath_cb, data, &err);
>        if (err != NULL) {
>                setpath_complete(err, data);
>                g_error_free(err);
> @@ -292,7 +292,7 @@ static gboolean setpath(GObex *obex, const char *path, size_t max_elem,
>
>        data = g_new0(struct setpath_data, 1);
>
> -       g_obex_setpath(obex, "", setpath_cb, data, &err);
> +       g_obex_setpath(obex, NULL, FALSE, setpath_cb, data, &err);
>        if (err != NULL) {
>                error("set_path: %s", err->message);
>                g_error_free(err);
> diff --git a/gobex/gobex.c b/gobex/gobex.c
> index 7840304..1085e78 100644
> --- a/gobex/gobex.c
> +++ b/gobex/gobex.c
> @@ -1083,11 +1083,13 @@ guint g_obex_connect(GObex *obex, GObexResponseFunc func, gpointer user_data,
>        return g_obex_send_req(obex, req, -1, func, user_data, err);
>  }
>
> -guint g_obex_setpath(GObex *obex, const char *path, GObexResponseFunc func,
> -                                       gpointer user_data, GError **err)
> +guint g_obex_setpath(GObex *obex, const char *folder, gboolean cdup,
> +                               GObexResponseFunc func, gpointer user_data,
> +                               GError **err)
>  {
>        GObexPacket *req;
>        struct setpath_data data;
> +       GObexHeader *hdr;
>
>        g_obex_debug(G_OBEX_DEBUG_COMMAND, "conn %u", obex->conn_id);
>
> @@ -1095,12 +1097,14 @@ guint g_obex_setpath(GObex *obex, const char *path, GObexResponseFunc func,
>
>        memset(&data, 0, sizeof(data));
>
> -       if (strcmp(path, "..") == 0)
> +       if (cdup)
>                data.flags = 0x03;
> -       else {
> -               GObexHeader *hdr;
> +       else
>                data.flags = 0x02;
> -               hdr = g_obex_header_new_unicode(G_OBEX_HDR_NAME, path);
> +
> +       if (!cdup || (folder != NULL && folder[0] != '\0')) {
> +               hdr = g_obex_header_new_unicode(G_OBEX_HDR_NAME,
> +                                               folder != NULL ? folder : "");
>                g_obex_packet_add_header(req, hdr);
>        }
>
> diff --git a/gobex/gobex.h b/gobex/gobex.h
> index 1b20333..d9d470d 100644
> --- a/gobex/gobex.h
> +++ b/gobex/gobex.h
> @@ -73,8 +73,9 @@ void g_obex_unref(GObex *obex);
>  guint g_obex_connect(GObex *obex, GObexResponseFunc func, gpointer user_data,
>                                GError **err, guint8 first_hdr_id, ...);
>
> -guint g_obex_setpath(GObex *obex, const char *path, GObexResponseFunc func,
> -                                       gpointer user_data, GError **err);
> +guint g_obex_setpath(GObex *obex, const char *folder, gboolean cdup,
> +                               GObexResponseFunc func, gpointer user_data,
> +                               GError **err);
>
>  guint g_obex_mkdir(GObex *obex, const char *path, GObexResponseFunc func,
>                                        gpointer user_data, GError **err);
> diff --git a/unit/test-gobex.c b/unit/test-gobex.c
> index 62443db..8b86dda 100644
> --- a/unit/test-gobex.c
> +++ b/unit/test-gobex.c
> @@ -46,6 +46,10 @@ static uint8_t pkt_setpath_req[] = { G_OBEX_OP_SETPATH | FINAL_BIT, 0x00, 0x10,
>                                        0, 'd', 0, 'i', 0, 'r', 0, 0 };
>  static uint8_t pkt_setpath_up_req[] = { G_OBEX_OP_SETPATH | FINAL_BIT,
>                                        0x00, 0x05, 0x03, 0x00 };
> +static uint8_t pkt_setpath_up_down_req[] = { G_OBEX_OP_SETPATH | FINAL_BIT,
> +                                       0x00, 0x10, 0x03, 0x00,
> +                                       G_OBEX_HDR_NAME, 0x00, 0x0b,
> +                                       0, 'd', 0, 'i', 0, 'r', 0, 0 };
>  static uint8_t pkt_success_rsp[] = { 0x20 | FINAL_BIT, 0x00, 0x03 };
>
>  static uint8_t pkt_mkdir_req[] = { G_OBEX_OP_SETPATH | FINAL_BIT, 0x00, 0x10,
> @@ -890,7 +894,7 @@ static void test_setpath(void)
>
>        timer_id = g_timeout_add_seconds(1, test_timeout, &d);
>
> -       g_obex_setpath(obex, "dir", req_complete, &d, &d.err);
> +       g_obex_setpath(obex, "dir", FALSE, req_complete, &d, &d.err);
>        g_assert_no_error(d.err);
>
>        g_main_loop_run(d.mainloop);
> @@ -926,7 +930,44 @@ static void test_setpath_up(void)
>
>        timer_id = g_timeout_add_seconds(1, test_timeout, &d);
>
> -       g_obex_setpath(obex, "..", req_complete, &d, &d.err);
> +       g_obex_setpath(obex, "", TRUE, req_complete, &d, &d.err);
> +       g_assert_no_error(d.err);
> +
> +       g_main_loop_run(d.mainloop);
> +
> +       g_assert_cmpuint(d.count, ==, 1);
> +
> +       g_main_loop_unref(d.mainloop);
> +
> +       g_source_remove(timer_id);
> +       g_io_channel_unref(io);
> +       g_source_remove(io_id);
> +       g_obex_unref(obex);
> +
> +       g_assert_no_error(d.err);
> +}
> +
> +static void test_setpath_up_down(void)
> +{
> +       GIOChannel *io;
> +       GIOCondition cond;
> +       guint io_id, timer_id;
> +       GObex *obex;
> +       struct test_data d = { 0, NULL, {
> +                       { pkt_setpath_up_down_req,
> +                                       sizeof(pkt_setpath_up_down_req) } }, {
> +                       { pkt_success_rsp, sizeof(pkt_success_rsp) } } };
> +
> +       create_endpoints(&obex, &io, SOCK_STREAM);
> +
> +       cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
> +       io_id = g_io_add_watch(io, cond, test_io_cb, &d);
> +
> +       d.mainloop = g_main_loop_new(NULL, FALSE);
> +
> +       timer_id = g_timeout_add_seconds(1, test_timeout, &d);
> +
> +       g_obex_setpath(obex, "dir", TRUE, req_complete, &d, &d.err);
>        g_assert_no_error(d.err);
>
>        g_main_loop_run(d.mainloop);
> @@ -1142,6 +1183,7 @@ int main(int argc, char *argv[])
>
>        g_test_add_func("/gobex/test_setpath", test_setpath);
>        g_test_add_func("/gobex/test_setpath_up", test_setpath_up);
> +       g_test_add_func("/gobex/test_setpath_up_down", test_setpath_up_down);
>
>        g_test_add_func("/gobex/test_mkdir", test_mkdir);
>
> --
> 1.7.4.1

I don't understand why you want to carry the burden of operating in
non standard paths? Or you are also planning to change the D-Bus API?
OBEX spec is just broke in this aspect, it should have allowed
standard paths and not this one level + cdup and now you are trying to
push this broken concept up to the user, why? How many uis have you
seem that can use do cdup + dir in practice? I don't remember seeing
any, and if that exist that would probably need to cache the folder
listing of the previous folder to be able to present to the user and
trust it wont get change in the meantime.

-- 
Luiz Augusto von Dentz
