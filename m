Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1358850763-19532-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
References: <1358850763-19532-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
Date: Tue, 22 Jan 2013 18:02:41 +0200
Message-ID: <CABBYNZLB5PSZihyW7krPYprWMdxD=0g9vP0y_WxUN0h15xP+eg@mail.gmail.com>
Subject: Re: [PATCH] avctp: Add functionality for CT browsing commands
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alexandros Antonopoulos <alexandros.antonopoulos@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexandros,

On Tue, Jan 22, 2013 at 12:32 PM, Alexandros Antonopoulos
<alexandros.antonopoulos@oss.bmw-carit.de> wrote:
> Add the missing functionality for full support of browsing channel
> on the CT side. This is required for AVRCP >= 1.4
> The patch is based on the control channel functionality
>
> ---
>  profiles/audio/avctp.c | 140 +++++++++++++++++++++++++++++++++++++++++++++++++
>  profiles/audio/avctp.h |   6 +++
>  2 files changed, 146 insertions(+)
>
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index e65594d..02bee2b 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -136,6 +136,14 @@ struct avctp_control_req {
>         void *user_data;
>  };
>
> +struct avctp_browsing_req {
> +       struct avctp_pending_req *p;
> +       uint8_t *operands;
> +       uint16_t operand_count;
> +       avctp_browsing_rsp_cb func;
> +       void *user_data;
> +};
> +
>  typedef int (*avctp_process_cb) (void *data);
>
>  struct avctp_pending_req {
> @@ -527,6 +535,44 @@ static int avctp_send(struct avctp_channel *control, uint8_t transaction,
>         return err;
>  }
>
> +static int avctp_browsing_send(struct avctp_channel *browsing,
> +                               uint8_t transaction, uint8_t cr,
> +                               uint8_t *operands, size_t operand_count)
> +{
> +       struct avctp_header *avctp;
> +       struct msghdr msg;
> +       struct iovec iov[2];
> +       int sk, err = 0;
> +
> +       iov[0].iov_base = browsing->buffer;
> +       iov[0].iov_len  = sizeof(*avctp);
> +       iov[1].iov_base = operands;
> +       iov[1].iov_len  = operand_count;
> +
> +       if (browsing->omtu < (iov[0].iov_len + iov[1].iov_len))
> +               return -EOVERFLOW;
> +
> +       sk = g_io_channel_unix_get_fd(browsing->io);
> +
> +       memset(browsing->buffer, 0, iov[0].iov_len);
> +
> +       avctp = (void *) browsing->buffer;
> +
> +       avctp->transaction = transaction;
> +       avctp->packet_type = AVCTP_PACKET_SINGLE;
> +       avctp->cr = cr;
> +       avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
> +
> +       memset(&msg, 0, sizeof(msg));
> +       msg.msg_iov = iov;
> +       msg.msg_iovlen = 2;
> +
> +       if (sendmsg(sk, &msg, 0) < 0)
> +               err = -errno;
> +
> +       return err;
> +}
> +
>  static void control_req_destroy(void *data)
>  {
>         struct avctp_control_req *req = data;
> @@ -535,6 +581,14 @@ static void control_req_destroy(void *data)
>         g_free(req);
>  }
>
> +static void browsing_req_destroy(void *data)
> +{
> +       struct avctp_browsing_req *req = data;
> +
> +       g_free(req->operands);
> +       g_free(req);
> +}
> +
>  static gboolean req_timeout(gpointer user_data)
>  {
>         struct avctp_channel *chan = user_data;
> @@ -563,6 +617,15 @@ static int process_control(void *data)
>                                         req->operands, req->operand_count);
>  }
>
> +static int process_browsing(void *data)
> +{
> +       struct avctp_browsing_req *req = data;
> +       struct avctp_pending_req *p = req->p;
> +
> +       return avctp_browsing_send(p->chan, p->transaction, AVCTP_COMMAND,
> +                                       req->operands, req->operand_count);
> +}
> +
>  static gboolean process_queue(void *user_data)
>  {
>         struct avctp_channel *chan = user_data;
> @@ -636,6 +699,48 @@ static void control_response(struct avctp_channel *control,
>         }
>  }
>
> +static void browsing_response(struct avctp_channel *browsing,
> +                                       struct avctp_header *avctp,
> +                                       uint8_t *operands,
> +                                       size_t operand_count)
> +{
> +       struct avctp_pending_req *p = browsing->p;
> +       struct avctp_browsing_req *req;
> +       GSList *l;
> +
> +       if (p && p->transaction == avctp->transaction) {
> +               browsing->processed = g_slist_prepend(browsing->processed, p);
> +
> +               if (p->timeout > 0) {
> +                       g_source_remove(p->timeout);
> +                       p->timeout = 0;
> +               }
> +
> +               browsing->p = NULL;
> +
> +               if (browsing->process_id == 0)
> +                       browsing->process_id = g_idle_add(process_queue,
> +                                                               browsing);
> +       }
> +
> +       for (l = browsing->processed; l; l = l->next) {
> +               p = l->data;
> +               req = p->data;
> +
> +               if (p->transaction != avctp->transaction)
> +                       continue;
> +
> +               if (req->func && req->func(browsing->session,
> +                                               operands, operand_count,
> +                                               req->user_data))
> +                       return;
> +
> +               browsing->processed = g_slist_remove(browsing->processed, p);
> +
> +               return;
> +       }
> +}
> +
>  static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
>                                 gpointer data)
>  {
> @@ -665,6 +770,11 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
>         ret -= AVCTP_HEADER_LENGTH;
>         operand_count = ret;
>
> +       if (avctp->cr == AVCTP_RESPONSE) {
> +               browsing_response(browsing, avctp, operands, operand_count);
> +               return TRUE;
> +       }
> +
>         packet_size = AVCTP_HEADER_LENGTH;
>         avctp->cr = AVCTP_RESPONSE;
>
> @@ -1294,6 +1404,36 @@ static int avctp_send_req(struct avctp *session, uint8_t code,
>         return 0;
>  }
>
> +int avctp_send_browsing_req(struct avctp *session,
> +                               uint8_t *operands, size_t operand_count,
> +                               avctp_browsing_rsp_cb func, void *user_data)
> +{
> +       struct avctp_channel *browsing = session->browsing;
> +       struct avctp_pending_req *p;
> +       struct avctp_browsing_req *req;
> +
> +       if (browsing == NULL)
> +               return -ENOTCONN;
> +
> +       req = g_new0(struct avctp_browsing_req, 1);
> +       req->func = func;
> +       req->operands = g_memdup(operands, operand_count);
> +       req->operand_count = operand_count;
> +       req->user_data = user_data;
> +
> +       p = pending_create(browsing, process_browsing, req,
> +                       browsing_req_destroy);
> +
> +       req->p = p;
> +
> +       g_queue_push_tail(browsing->queue, p);
> +
> +       if (browsing->process_id == 0)
> +               browsing->process_id = g_idle_add(process_queue, browsing);
> +
> +       return 0;
> +}
> +
>  static char *op2str(uint8_t op)
>  {
>         switch (op & 0x7f) {
> diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
> index c25a3b3..b9107bd 100644
> --- a/profiles/audio/avctp.h
> +++ b/profiles/audio/avctp.h
> @@ -82,6 +82,9 @@ typedef size_t (*avctp_control_pdu_cb) (struct avctp *session,
>  typedef gboolean (*avctp_rsp_cb) (struct avctp *session, uint8_t code,
>                                         uint8_t subunit, uint8_t *operands,
>                                         size_t operand_count, void *user_data);
> +typedef gboolean (*avctp_browsing_rsp_cb) (struct avctp *session,
> +                                       uint8_t *operands, size_t operand_count,
> +                                       void *user_data);
>  typedef size_t (*avctp_browsing_pdu_cb) (struct avctp *session,
>                                         uint8_t transaction,
>                                         uint8_t *operands, size_t operand_count,
> @@ -116,3 +119,6 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
>                                         uint8_t subunit, uint8_t *operands,
>                                         size_t operand_count,
>                                         avctp_rsp_cb func, void *user_data);
> +int avctp_send_browsing_req(struct avctp *session,
> +                               uint8_t *operands, size_t operand_count,
> +                               avctp_browsing_rsp_cb func, void *user_data);
> --
> 1.8.1

Patch applied, thanks.


--
Luiz Augusto von Dentz
