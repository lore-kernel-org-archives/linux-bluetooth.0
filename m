Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328182399-14828-1-git-send-email-jaganath.k@samsung.com>
References: <1328182399-14828-1-git-send-email-jaganath.k@samsung.com>
Date: Thu, 2 Feb 2012 09:14:51 -0800
Message-ID: <CABBYNZLnyh691Go-0qMCqYa_fGxqE+uSqLXKMJvb-F9kwhM_3A@mail.gmail.com>
Subject: Re: [PATCH obexd 1/4] gobex: Add unit test for PUT request followed
 by ABORT
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Feb 2, 2012 at 3:33 AM, Jaganath Kanakkassery
<jaganath.k@samsung.com> wrote:
> ---
>  unit/test-gobex-transfer.c |   50 ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 50 insertions(+), 0 deletions(-)
>
> diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
> index d4cf181..c712382 100644
> --- a/unit/test-gobex-transfer.c
> +++ b/unit/test-gobex-transfer.c
> @@ -59,6 +59,8 @@ static guint8 put_req_zero[255] = { G_OBEX_OP_PUT, 0x00, 0xff,
>  static guint8 put_req_last[] = { G_OBEX_OP_PUT | FINAL_BIT, 0x00, 0x06,
>                                        G_OBEX_HDR_BODY_END, 0x00, 0x03 };
>
> +static guint8 abort_req[] = { G_OBEX_OP_ABORT | FINAL_BIT, 0x00, 0x03 };
> +
>  static guint8 put_rsp_first[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
>                                                                0x00, 0x03 };
>  static guint8 put_rsp_first_srm[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
> @@ -453,6 +455,51 @@ static void test_stream_put_rsp(void)
>        g_assert_no_error(d.err);
>  }
>
> +static void test_stream_put_req_abort(void)
> +{
> +       GIOChannel *io;
> +       GIOCondition cond;
> +       guint io_id, timer_id;
> +       GObex *obex;
> +       struct test_data d = { 0, NULL, {
> +                               { put_rsp_first, sizeof(put_rsp_first) },
> +                               { put_rsp_first, sizeof(put_rsp_first) },
> +                               { put_rsp_first, sizeof(put_rsp_first) },
> +                               { put_rsp_last, sizeof(put_rsp_last) } }, {
> +                               { put_req_zero, sizeof(put_req_zero) },
> +                               { abort_req, sizeof(abort_req) },
> +                               { NULL, -1 },
> +                               { NULL, -1 } } };
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
> +       g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_seq, &d);
> +
> +       g_io_channel_write_chars(io, (char *) put_req_first,
> +                                       sizeof(put_req_first), NULL, &d.err);
> +       g_assert_no_error(d.err);
> +
> +       g_main_loop_run(d.mainloop);
> +
> +       g_assert_cmpuint(d.count, ==, RANDOM_PACKETS - 2);
> +
> +       g_main_loop_unref(d.mainloop);
> +
> +       g_source_remove(timer_id);
> +       g_io_channel_unref(io);
> +       g_source_remove(io_id);
> +       g_obex_unref(obex);
> +
> +       g_assert_error(d.err, G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED);
> +}
> +
>  static void handle_put_seq_wait(GObex *obex, GObexPacket *req,
>                                                        gpointer user_data)
>  {
> @@ -2110,6 +2157,9 @@ int main(int argc, char *argv[])
>        g_test_add_func("/gobex/test_stream_put_req", test_stream_put_req);
>        g_test_add_func("/gobex/test_stream_put_rsp", test_stream_put_rsp);
>
> +       g_test_add_func("/gobex/test_stream_put_req_abort",
> +                                               test_stream_put_req_abort);
> +
>        g_test_add_func("/gobex/test_stream_get_req", test_stream_get_req);
>        g_test_add_func("/gobex/test_stream_get_rsp", test_stream_get_rsp);
>
> --
> 1.7.1

Ack

-- 
Luiz Augusto von Dentz
