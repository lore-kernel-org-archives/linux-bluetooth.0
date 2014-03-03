Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1393842906-5883-1-git-send-email-szymon.janc@tieto.com>
References: <1393842906-5883-1-git-send-email-szymon.janc@tieto.com>
Date: Mon, 3 Mar 2014 16:16:42 +0200
Message-ID: <CABBYNZLmc5AetBvuvO25dW1KBVDDSrou_1P2==yTqTfJftyjwQ@mail.gmail.com>
Subject: Re: [PATCH v2] android/avrcp-lib: Fix destroy callback handling
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Mar 3, 2014 at 12:35 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> AVRCP destroy callback was directly passed as AVCTP destroy callback
> resulting in struct avrcp not being freed on remote disconnect.
>
> This fix following Valgrind report:
>
> 931 (36 direct, 895 indirect) bytes in 1 blocks are definitely lost in
>      loss record 53 of 55
>    at 0x4896DC8: calloc (in /system/lib/valgrind/
>      vgpreload_memcheck-arm-linux.so)
>    by 0x48C5DB7: g_malloc0 (gmem.c:189)
>    by 0x118671: avrcp_new (avrcp-lib.c:219)
>    by 0x117D4F: connect_cb (avrcp.c:346)
>    by 0x12068B: connect_cb (btio.c:232)
>    by 0x48BD9C7: g_io_unix_dispatch (giounix.c:166)
>    by 0x48C2CCB: g_main_context_dispatch (gmain.c:2539)
>    by 0x48C2ED9: g_main_context_iterate.isra.19 (gmain.c:3146)
>    by 0x48C3167: g_main_loop_run (gmain.c:3340)
>    by 0x10BA03: main (main.c:490)
> ---
>
> v2: fix crash on local shutdown due to double call to avrcp_shutdown,
>     now avctp destroy callback is cleared when shuting down localy.
>
>  android/avrcp-lib.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
> index 26bcce1..c5cfa12 100644
> --- a/android/avrcp-lib.c
> +++ b/android/avrcp-lib.c
> @@ -98,6 +98,9 @@ struct avrcp {
>         const struct avrcp_passthrough_handler *passthrough_handlers;
>         void *passthrough_data;
>         unsigned int passthrough_id;
> +
> +       avrcp_destroy_cb_t destroy;
> +       void *destroy_data;
>  };
>
>  void avrcp_shutdown(struct avrcp *session)
> @@ -109,9 +112,15 @@ void avrcp_shutdown(struct avrcp *session)
>                 if (session->passthrough_id > 0)
>                         avctp_unregister_passthrough_handler(session->conn,
>                                                 session->passthrough_id);
> +
> +               /* clear destroy callback that would call shutdown again */
> +               avctp_set_destroy_cb(session->conn, NULL, NULL);
>                 avctp_shutdown(session->conn);
>         }
>
> +       if (session->destroy)
> +               session->destroy(session->destroy_data);
> +
>         g_free(session->tx_buf);
>         g_free(session);
>  }
> @@ -199,6 +208,15 @@ static bool handle_passthrough_pdu(struct avctp *conn, uint8_t op,
>         return handler->func(session);
>  }
>
> +static void disconnect_cb(void *data)
> +{
> +       struct avrcp *session = data;
> +
> +       session->conn = NULL;
> +
> +       avrcp_shutdown(session);
> +}
> +
>  struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
>  {
>         struct avrcp *session;
> @@ -223,13 +241,16 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
>                                                         handle_vendordep_pdu,
>                                                         session);
>
> +       avctp_set_destroy_cb(session->conn, disconnect_cb, session);
> +
>         return session;
>  }
>
>  void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
>                                                         void *user_data)
>  {
> -       avctp_set_destroy_cb(session->conn, cb, user_data);
> +       session->destroy = cb;
> +       session->destroy_data = user_data;
>  }
>
>  void avrcp_set_control_handlers(struct avrcp *session,
> --
> 1.8.5.3

Pushed, thanks.


-- 
Luiz Augusto von Dentz
