Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1344409069-19556-1-git-send-email-vani.patel@stericsson.com>
References: <1344409069-19556-1-git-send-email-vani.patel@stericsson.com>
Date: Thu, 9 Aug 2012 00:52:27 +0530
Message-ID: <CAFBvHid_kqZMV3ReOE0b=udeK6M7rwwEF0yU8+g-Y=EcBkm-JQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ V4 5/5] AVRCP: Add handler for browsing pdu
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
> Implement generic handling of browsing
> PDU IDs
> ---
>  audio/avctp.c |   27 ++++++++++++++++++--
>  audio/avrcp.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 3 deletions(-)
>
> diff --git a/audio/avctp.c b/audio/avctp.c
> index b5f84aa..7bbcecc 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -458,9 +458,9 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
>                                 gpointer data)
>  {
>         struct avctp *session = data;
> -       uint8_t  *buf;
> +       uint8_t *operands, *buf;
>         struct avctp_header *avctp;
> -       int ret, sock;
> +       int ret, packet_size, operand_count, sock;
>
>         buf = (uint8_t *)malloc(session->browsing_mtu);

Need a space after typecasting.

>         if (!(cond & G_IO_IN))
> @@ -472,6 +472,8 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
>         if (ret <= 0)
>                 goto failed;
>
> +       DBG("Got %d bytes of data for AVCTP Browsing session %p", ret, session);
> +
>         if ((unsigned int) ret < sizeof(struct avctp_header)) {
>                 error("Too small AVRCP packet on browsing channel");
>                 goto failed;
> @@ -479,9 +481,28 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
>
>         avctp = (struct avctp_header *) buf;
>
> +       DBG("AVCTP transaction %u, packet type %u, C/R %u, IPID %u, "
> +                       "PID 0x%04X",
> +                       avctp->transaction, avctp->packet_type,
> +                       avctp->cr, avctp->ipid, ntohs(avctp->pid));
> +
>         if (avctp->packet_type != AVCTP_PACKET_SINGLE)
>                 goto failed;

It's better to have a  blank line here.

> +       operands = buf + AVCTP_HEADER_LENGTH;
> +       ret -= AVCTP_HEADER_LENGTH;
> +       operand_count = ret;
> +
> +       packet_size = AVCTP_HEADER_LENGTH;
> +       avctp->cr = AVCTP_RESPONSE;
> +       if (browsing_handler)
> +               packet_size += browsing_handler->cb(session, avctp->transaction,
> +                       operands, operand_count, browsing_handler->user_data);
>
> +       if (packet_size !=0 ) {

Space required after '!=' and space prohibited before ')'

> +               ret = write(sock, buf, packet_size);
> +               if (ret != packet_size)
> +                       goto failed;
> +       }
>         free(buf);
>         return TRUE;
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 9d29073..deba4a6 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -94,6 +94,9 @@
>  #define AVRCP_ABORT_CONTINUING         0x41
>  #define AVRCP_SET_ABSOLUTE_VOLUME      0x50
>
> +#define AVRCP_INVALID_BROWSING_PDU     0x00
> +
> +#define AVRCP_GENERAL_REJECT           0xA0
>  /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
>  #define CAP_COMPANY_ID         0x02
>  #define CAP_EVENTS_SUPPORTED   0x03
> @@ -140,6 +143,12 @@ struct avrcp_header {
>  #error "Unknown byte order"
>  #endif
>
> +struct avrcp_browsing_header {
> +       uint8_t browsing_pdu;
> +       uint16_t param_len;
> +} __attribute__ ((packed));
> +#define AVRCP_BROWSING_HEADER_LENGTH 3
> +
>  #define AVRCP_MTU      (AVC_MTU - AVC_HEADER_LENGTH)
>  #define AVRCP_PDU_MTU  (AVRCP_MTU - AVRCP_HEADER_LENGTH)
>
> @@ -163,7 +172,9 @@ struct avrcp_player {
>         struct audio_device *dev;
>
>         unsigned int control_handler;
> +       unsigned int browsing_handler;
>         uint16_t registered_events;
> +       uint8_t transaction;
>         uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
>         struct pending_pdu *pending_pdu;
>
> @@ -1075,6 +1086,15 @@ static struct control_pdu_handler {
>                 { },
>  };
>
> +static struct pdu_browsing_handler {
> +       uint8_t browsing_pdu;
> +       void (*func) (struct avrcp_player *player,
> +                                       struct avrcp_browsing_header *pdu);
> +       } browsing_handlers[] = {
> +               { AVRCP_INVALID_BROWSING_PDU,
> +                                       NULL },
> +};
> +
>  /* handle vendordep pdu inside an avctp packet */
>  static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
>                                         uint8_t *code, uint8_t *subunit,
> @@ -1134,6 +1154,49 @@ err_metadata:
>         return AVRCP_HEADER_LENGTH + 1;
>  }
>
> +static size_t handle_browsing_pdu(struct avctp *session,
> +                                       uint8_t transaction, uint8_t *operands,
> +                                       size_t operand_count, void *user_data)
> +{
> +       struct avrcp_player *player = user_data;
> +       struct pdu_browsing_handler *b_handler;
> +       struct avrcp_browsing_header *avrcp_browsing = (void *) operands;
> +       uint8_t status;
> +
> +       operand_count += AVRCP_BROWSING_HEADER_LENGTH;
> +
> +       for (b_handler = browsing_handlers; b_handler; b_handler++) {
> +               if (b_handler->browsing_pdu == AVRCP_INVALID_BROWSING_PDU) {
> +                       b_handler = NULL;
> +                       break;
> +               }
> +               if (b_handler->browsing_pdu == avrcp_browsing->browsing_pdu)
> +                       break;
> +       }
> +
> +       if (!b_handler) {
> +               avrcp_browsing->browsing_pdu = AVRCP_GENERAL_REJECT;
> +               status = AVRCP_STATUS_INVALID_COMMAND;
> +               goto err;
> +       }
> +
> +       if (!b_handler->func) {
> +               status = AVRCP_STATUS_INVALID_PARAM;
> +               avrcp_browsing->param_len = htons(sizeof(status));
> +               goto err;
> +       }
> +       player->transaction = transaction;
> +       b_handler->func(player, avrcp_browsing);
> +       return AVRCP_BROWSING_HEADER_LENGTH + ntohs(avrcp_browsing->param_len);
> +
> +err:
> +       avrcp_browsing->param_len = htons(sizeof(status));
> +       memcpy(&operands[AVRCP_BROWSING_HEADER_LENGTH], &status,
> +                                                       (sizeof(status)));
> +       return AVRCP_BROWSING_HEADER_LENGTH + sizeof(status);
> +}
> +
> +
>  size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
>  {
>         struct avrcp_header *pdu = (void *) operands;
> @@ -1233,6 +1296,10 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
>                         avctp_unregister_pdu_handler(player->control_handler);
>                         player->control_handler = 0;
>                 }
> +               if (player->browsing_handler) {
> +                       avctp_unregister_browsing_pdu_handler();
> +                       player->browsing_handler = 0;
> +               }
>
>                 break;
>         case AVCTP_STATE_CONNECTING:
> @@ -1244,6 +1311,12 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
>                                                         AVC_OP_VENDORDEP,
>                                                         handle_vendordep_pdu,
>                                                         player);
> +               if (!player->browsing_handler)
> +                       player->browsing_handler =
> +                                       avctp_register_browsing_pdu_handler(
> +                                                       handle_browsing_pdu,
> +                                                       player);
> +
>                 break;
>         case AVCTP_STATE_CONNECTED:
>                 rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
> --
> 1.7.5.4
>

It's always better to run checkpatch.pl script on the patches before
sending to the ML. It can capture the coding style issues.

Thanks,
Syam.
