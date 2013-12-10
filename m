Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1386598281-31302-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386598281-31302-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 10 Dec 2013 13:40:08 +0200
Message-ID: <CABBYNZJ6pt=1mytPAvryQD4unNZhpCQ8_z86tgVv1ua2zQtdEA@mail.gmail.com>
Subject: Re: [PATCH] android/socket: Use getsockopt to set buffer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Dec 9, 2013 at 4:11 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Use buffer size similar to one returned by getsockopt for RFCOMM socket.
> If getsockopt fails use default value 25400 which is half of the default
> RFCOMM kernel buffer (50800) calculated in kernel as:
> RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 10
> ---
>  android/socket.c | 43 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/android/socket.c b/android/socket.c
> index 9020874..b5f7b1d 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -52,6 +52,8 @@
>
>  #define SVC_HINT_OBEX 0x10
>
> +#define SOCKET_BUFFER 25400 /* Half of the kernel buffer */
> +
>  static bdaddr_t adapter_addr;
>
>  /* Simple list of RFCOMM server sockets */
> @@ -71,9 +73,33 @@ struct rfcomm_sock {
>         bdaddr_t dst;
>         uint32_t service_handle;
>
> +       unsigned char *buf;
> +       int buf_size;
> +
>         const struct profile_info *profile;
>  };
>
> +static void rfsock_set_buffer(struct rfcomm_sock *rfsock)
> +{
> +       socklen_t len = sizeof(int);
> +       int size;
> +
> +       if (getsockopt(rfsock->real_sock, SOL_SOCKET, SO_RCVBUF, &size, &len)
> +                                                                       < 0) {
> +               warn("getsockopt(SO_RCVBUF) failed: %s", strerror(errno));
> +               /* Use default buffer */
> +               size = SOCKET_BUFFER;
> +       } else {
> +               /* Kernel doubles this */
> +               size /= 2;
> +       }
> +
> +       DBG("Set buffer size %d", size);
> +
> +       rfsock->buf = g_malloc(size);
> +       rfsock->buf_size = size;
> +}
> +
>  static struct rfcomm_sock *create_rfsock(int sock, int *hal_fd)
>  {
>         int fds[2] = {-1, -1};
> @@ -90,6 +116,9 @@ static struct rfcomm_sock *create_rfsock(int sock, int *hal_fd)
>         *hal_fd = fds[1];
>         rfsock->real_sock = sock;
>
> +       if (sock >= 0)
> +               rfsock_set_buffer(rfsock);
> +
>         return rfsock;
>  }
>
> @@ -121,6 +150,9 @@ static void cleanup_rfsock(gpointer data)
>         if (rfsock->service_handle)
>                 bt_adapter_remove_record(rfsock->service_handle);
>
> +       if (rfsock->buf)
> +               g_free(rfsock->buf);
> +
>         g_free(rfsock);
>  }
>
> @@ -487,7 +519,6 @@ static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
>                                                                 gpointer data)
>  {
>         struct rfcomm_sock *rfsock = data;
> -       unsigned char buf[1024];
>         int len, sent;
>
>         if (cond & G_IO_HUP) {
> @@ -501,14 +532,14 @@ static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
>                 goto fail;
>         }
>
> -       len = read(rfsock->fd, buf, sizeof(buf));
> +       len = read(rfsock->fd, rfsock->buf, rfsock->buf_size);
>         if (len <= 0) {
>                 error("read(): %s", strerror(errno));
>                 /* Read again */
>                 return TRUE;
>         }
>
> -       sent = try_write_all(rfsock->real_sock, buf, len);
> +       sent = try_write_all(rfsock->real_sock, rfsock->buf, len);
>         if (sent < 0) {
>                 error("write(): %s", strerror(errno));
>                 goto fail;
> @@ -526,7 +557,6 @@ static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
>                                                                 gpointer data)
>  {
>         struct rfcomm_sock *rfsock = data;
> -       unsigned char buf[1024];
>         int len, sent;
>
>         if (cond & G_IO_HUP) {
> @@ -540,14 +570,14 @@ static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
>                 goto fail;
>         }
>
> -       len = read(rfsock->real_sock, buf, sizeof(buf));
> +       len = read(rfsock->real_sock, rfsock->buf, rfsock->buf_size);
>         if (len <= 0) {
>                 error("read(): %s", strerror(errno));
>                 /* Read again */
>                 return TRUE;
>         }
>
> -       sent = try_write_all(rfsock->fd, buf, len);
> +       sent = try_write_all(rfsock->fd, rfsock->buf, len);
>         if (sent < 0) {
>                 error("write(): %s", strerror(errno));
>                 goto fail;
> @@ -866,6 +896,7 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
>         }
>
>         rfsock->real_sock = g_io_channel_unix_get_fd(io);
> +       rfsock_set_buffer(rfsock);
>         rfsock->channel = chan;
>         connections = g_list_append(connections, rfsock);
>
> --
> 1.8.3.2

Pushed with the changes we discussed offline.


-- 
Luiz Augusto von Dentz
