Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1344409046-18394-1-git-send-email-vani.patel@stericsson.com>
References: <1344409046-18394-1-git-send-email-vani.patel@stericsson.com>
Date: Thu, 9 Aug 2012 00:59:32 +0530
Message-ID: <CAFBvHifSwPLpHitv8MCnTgrf9Gj18oE+55zhiotzarpmF1Vrsw@mail.gmail.com>
Subject: Re: [PATCH BlueZ V4 4/5] AVRCP: Register/Unregister Browsing handler
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: Vani-dineshbhai PATEL <vani.patel@stericsson.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto <luiz.dentz@gmail.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Joohi <Joohi.rastogi@stericsson.com>, Vani <vani273@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vani,

On Wed, Aug 8, 2012 at 12:27 PM, Vani-dineshbhai PATEL
<vani.patel@stericsson.com> wrote:
> From: Vani Patel <vani.patel@stericsson.com>
>
> Add functions to register and unregister Browsing
> handler
> ---
>  audio/avctp.c |   26 ++++++++++++++++++++++++++
>  audio/avctp.h |    8 ++++++++
>  2 files changed, 34 insertions(+), 0 deletions(-)
>
> diff --git a/audio/avctp.c b/audio/avctp.c
> index 96c5605..b5f84aa 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -157,6 +157,11 @@ struct avctp_pdu_handler {
>         unsigned int id;
>  };
>
> +struct avctp_browsing_pdu_handler {
> +       avctp_browsing_pdu_cb cb;
> +       void *user_data;
> +};
> +
>  static struct {
>         const char *name;
>         uint8_t avc;
> @@ -176,6 +181,7 @@ static GSList *callbacks = NULL;
>  static GSList *servers = NULL;
>  static GSList *control_handlers = NULL;
>  static uint8_t id = 0;
> +static struct avctp_browsing_pdu_handler *browsing_handler = NULL;
>
>  static void auth_cb(DBusError *derr, void *user_data);
>
> @@ -1251,6 +1257,18 @@ unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
>         return handler->id;
>  }
>
> +unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
> +                                                       void *user_data)
> +{
> +       unsigned int id = 0;
> +
> +       browsing_handler = g_new(struct avctp_browsing_pdu_handler, 1);
> +       browsing_handler->cb = cb;
> +       browsing_handler->user_data = user_data;
> +
> +       return ++id;
> +}
> +
>  gboolean avctp_unregister_pdu_handler(unsigned int id)
>  {
>         GSList *l;
> @@ -1269,6 +1287,14 @@ gboolean avctp_unregister_pdu_handler(unsigned int id)
>         return FALSE;
>  }
>
> +gboolean avctp_unregister_browsing_pdu_handler()
> +{
> +       if (browsing_handler)

Checking for the browsing_handler is not required, as g_free()
internally do the check.

> +               g_free(browsing_handler);
> +
> +       return TRUE;
> +}
> +
>  struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
>  {
>         struct avctp *session;
> diff --git a/audio/avctp.h b/audio/avctp.h
> index b80e300..3e1dabe 100644
> --- a/audio/avctp.h
> +++ b/audio/avctp.h
> @@ -83,6 +83,10 @@ typedef size_t (*avctp_control_pdu_cb) (struct avctp *session,
>  typedef gboolean (*avctp_rsp_cb) (struct avctp *session, uint8_t code,
>                                         uint8_t subunit, uint8_t *operands,
>                                         size_t operand_count, void *user_data);
> +typedef size_t (*avctp_browsing_pdu_cb) (struct avctp *session,
> +                                       uint8_t transaction,
> +                                       uint8_t *operands, size_t operand_count,
> +                                       void *user_data);
>
>  unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data);
>  gboolean avctp_remove_state_cb(unsigned int id);
> @@ -98,6 +102,10 @@ unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
>                                                         void *user_data);
>  gboolean avctp_unregister_pdu_handler(unsigned int id);
>
> +unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
> +                                                       void *user_data);
> +
> +gboolean avctp_unregister_browsing_pdu_handler();
>  int avctp_send_passthrough(struct avctp *session, uint8_t op);
>  int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
>                                 uint8_t code, uint8_t subunit,
> --
> 1.7.5.4

Thanks,
Syam.
