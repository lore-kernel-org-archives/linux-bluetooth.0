Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
References: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
Date: Wed, 20 Aug 2014 13:38:28 +0300
Message-ID: <CABBYNZKK_BLOM3LCUCS5vRC4JpFfJPp8TaGfQz3y-GZ93DV8Tg@mail.gmail.com>
Subject: Re: [PATCH 01/11] android/hal-ipc: Refactor handling of IPC error
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Aug 19, 2014 at 10:51 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Move all error handling to notification thread. This makes single
> point of error (ie exit()) and is a preparation for custom
> disconnect callback.

Does this imply every ipc must have a notification thread? iirc this
was not the case for audio.

> ---
>  android/hal-ipc.c | 134 +++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 93 insertions(+), 41 deletions(-)
>
> diff --git a/android/hal-ipc.c b/android/hal-ipc.c
> index 363072c..1f5cc52 100644
> --- a/android/hal-ipc.c
> +++ b/android/hal-ipc.c
> @@ -39,7 +39,7 @@ static int listen_sk = -1;
>  static int cmd_sk = -1;
>  static int notif_sk = -1;
>
> -static pthread_mutex_t cmd_sk_mutex = PTHREAD_MUTEX_INITIALIZER;
> +static pthread_mutex_t ipc_mutex = PTHREAD_MUTEX_INITIALIZER;
>
>  static pthread_t notif_th = 0;
>
> @@ -133,6 +133,7 @@ static void *notification_handler(void *data)
>         struct iovec iv;
>         struct cmsghdr *cmsg;
>         char cmsgbuf[CMSG_SPACE(sizeof(int))];
> +       bool failed = false;
>         char buf[IPC_MTU];
>         ssize_t ret;
>         int fd;
> @@ -157,20 +158,22 @@ static void *notification_handler(void *data)
>                 if (ret < 0) {
>                         error("Receiving notifications failed: %s",
>                                                         strerror(errno));
> -                       goto failed;
> +                       failed = true;
> +                       break;
>                 }
>
>                 /* socket was shutdown */
>                 if (ret == 0) {
> -                       pthread_mutex_lock(&cmd_sk_mutex);
> +                       pthread_mutex_lock(&ipc_mutex);
>                         if (cmd_sk == -1) {
> -                               pthread_mutex_unlock(&cmd_sk_mutex);
> +                               pthread_mutex_unlock(&ipc_mutex);
>                                 break;
>                         }
> -                       pthread_mutex_unlock(&cmd_sk_mutex);
> +                       pthread_mutex_unlock(&ipc_mutex);
>
> -                       error("Notification socket closed");
> -                       goto failed;
> +                       error("Notification socket closed unexpectedly");
> +                       failed = true;
> +                       break;
>                 }
>
>                 fd = -1;
> @@ -185,21 +188,25 @@ static void *notification_handler(void *data)
>                         }
>                 }
>
> -               if (!handle_msg(buf, ret, fd))
> -                       goto failed;
> +               if (!handle_msg(buf, ret, fd)) {
> +                       failed = true;
> +                       break;
> +               }
>         }
>
> +       pthread_mutex_lock(&ipc_mutex);
>         close(notif_sk);
>         notif_sk = -1;
> +       pthread_mutex_unlock(&ipc_mutex);
>
>         bt_thread_disassociate();
>
>         DBG("exit");
>
> -       return NULL;
> +       if (failed)
> +               exit(EXIT_FAILURE);
>
> -failed:
> -       exit(EXIT_FAILURE);
> +       return NULL;
>  }
>
>  static int accept_connection(int sk)
> @@ -238,32 +245,67 @@ bool hal_ipc_accept(void)
>  {
>         int err;
>
> +       pthread_mutex_lock(&ipc_mutex);
> +       if (cmd_sk >= 0) {
> +               close(cmd_sk);
> +               cmd_sk = -1;
> +       }
> +
> +       if (notif_sk >= 0) {
> +               close(notif_sk);
> +               notif_sk = -1;
> +       }
> +
> +       /*
> +        * If notification thread is running this means accept was called
> +        * from notification thread context . We need to detach thread to not
> +        * leak resources.
> +        *
> +        * TODO should we verify if context is really notification thread?
> +        * calling accept from other thread when IPC is running is an illegal
> +        * usage anyway..
> +        */
> +       if (notif_th) {
> +               pthread_detach(notif_th);
> +               notif_th = 0;
> +       }
> +
>         cmd_sk = accept_connection(listen_sk);
>         if (cmd_sk < 0)
> -               return false;
> +               goto failed;
>
>         notif_sk = accept_connection(listen_sk);
> -       if (notif_sk < 0) {
> -               close(cmd_sk);
> -               cmd_sk = -1;
> -               return false;
> -       }
> +       if (notif_sk < 0)
> +               goto failed;
>
>         err = pthread_create(&notif_th, NULL, notification_handler, NULL);
>         if (err) {
>                 notif_th = 0;
>                 error("Failed to start notification thread: %d (%s)", err,
>                                                         strerror(err));
> +               goto failed;
> +       }
> +
> +       pthread_mutex_unlock(&ipc_mutex);
> +
> +       info("IPC connected");
> +
> +       return true;
> +
> +failed:
> +       if (cmd_sk >= 0) {
>                 close(cmd_sk);
>                 cmd_sk = -1;
> +       }
> +
> +       if (notif_sk >= 0) {
>                 close(notif_sk);
>                 notif_sk = -1;
> -               return false;
>         }
>
> -       info("IPC connected");
> +       pthread_mutex_unlock(&ipc_mutex);
>
> -       return true;
> +       return false;
>  }
>
>  bool hal_ipc_init(const char *path, size_t size)
> @@ -307,23 +349,28 @@ bool hal_ipc_init(const char *path, size_t size)
>
>  void hal_ipc_cleanup(void)
>  {
> +       pthread_t th;
> +
> +       pthread_mutex_lock(&ipc_mutex);
> +
>         close(listen_sk);
>         listen_sk = -1;
>
> -       pthread_mutex_lock(&cmd_sk_mutex);
>         if (cmd_sk >= 0) {
>                 close(cmd_sk);
>                 cmd_sk = -1;
>         }
> -       pthread_mutex_unlock(&cmd_sk_mutex);
> -
> -       if (notif_sk < 0)
> -               return;
>
> -       shutdown(notif_sk, SHUT_RD);
> +       if (notif_sk >= 0)
> +               shutdown(notif_sk, SHUT_RD);
>
> -       pthread_join(notif_th, NULL);
> +       th = notif_th;
>         notif_th = 0;
> +
> +       pthread_mutex_unlock(&ipc_mutex);
> +
> +       if (th)
> +               pthread_join(th, NULL);
>  }
>
>  int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
> @@ -337,11 +384,6 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
>         struct ipc_status s;
>         size_t s_len = sizeof(s);
>
> -       if (cmd_sk < 0) {
> -               error("Invalid cmd socket passed to hal_ipc_cmd");
> -               goto failed;
> -       }
> -
>         if (!rsp || !rsp_len) {
>                 memset(&s, 0, s_len);
>                 rsp_len = &s_len;
> @@ -358,26 +400,29 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
>         iv[0].iov_base = &cmd;
>         iv[0].iov_len = sizeof(cmd);
>
> -       iv[1].iov_base = param;
> +       iv[1].iov_base = (void *) param;

Does this change is really necessary?

>         iv[1].iov_len = len;
>
>         msg.msg_iov = iv;
>         msg.msg_iovlen = 2;
>
> -       pthread_mutex_lock(&cmd_sk_mutex);
> +       pthread_mutex_lock(&ipc_mutex);
> +
> +       if (cmd_sk < 0) {
> +               error("Invalid cmd socket passed to hal_ipc_cmd");
> +               goto failed_locked;
> +       }
>
>         ret = sendmsg(cmd_sk, &msg, 0);
>         if (ret < 0) {
>                 error("Sending command failed:%s", strerror(errno));
> -               pthread_mutex_unlock(&cmd_sk_mutex);
> -               goto failed;
> +               goto failed_locked;
>         }
>
>         /* socket was shutdown */
>         if (ret == 0) {
>                 error("Command socket closed");
> -               pthread_mutex_unlock(&cmd_sk_mutex);
> -               goto failed;
> +               goto failed_locked;
>         }
>
>         memset(&msg, 0, sizeof(msg));
> @@ -400,7 +445,7 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
>
>         ret = recvmsg(cmd_sk, &msg, 0);
>
> -       pthread_mutex_unlock(&cmd_sk_mutex);
> +       pthread_mutex_unlock(&ipc_mutex);
>
>         if (ret < 0) {
>                 error("Receiving command response failed: %s", strerror(errno));
> @@ -467,5 +512,12 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
>         return BT_STATUS_SUCCESS;
>
>  failed:
> -       exit(EXIT_FAILURE);
> +       pthread_mutex_lock(&ipc_mutex);
> +
> +failed_locked:
> +       if (notif_sk >= 0)
> +               shutdown(notif_sk, SHUT_RD);
> +       pthread_mutex_unlock(&ipc_mutex);

Perhaps having ipc_shutdown would be a good idea here, it should
probably only be called with the lock being held, also if notif_sk is
not set perhaps it should shutdown the cmd_sk otherwise it can have no
effect.

> +
> +       return BT_STATUS_FAIL;
>  }
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
