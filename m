Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1341913055-19754-1-git-send-email-vani.patel@stericsson.com>
References: <1341913055-19754-1-git-send-email-vani.patel@stericsson.com>
Date: Tue, 17 Jul 2012 14:55:42 +0300
Message-ID: <CABBYNZKAVFrZumVP+EyUR6=k9vAzp3T43-8u+Gevzg4d-5q64w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/5] AVRCP: Add handler for browsing pdu
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vani-dineshbhai PATEL <vani.patel@stericsson.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Joohi <Joohi.rastogi@stericsson.com>, Vani <vani273@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vani,

On Tue, Jul 10, 2012 at 12:37 PM, Vani-dineshbhai PATEL
<vani.patel@stericsson.com> wrote:
> +void avctp_send_browsing(struct avctp *session, uint8_t transaction,
> +                                       uint8_t *operands, size_t operand_count)
> +{
> +       struct avctp_header *avctp_header;
> +       uint8_t *buf;
> +       uint16_t length = 0;
> +       int sock;
> +
> +       length = AVCTP_HEADER_LENGTH + operand_count;
> +       buf = g_malloc0(length);
> +
> +       avctp_header = (void *) buf;
> +
> +       avctp_header->cr = AVCTP_RESPONSE;
> +       avctp_header->ipid = FALSE;
> +       avctp_header->packet_type = AVCTP_PACKET_SINGLE;
> +       avctp_header->pid = htons(AV_REMOTE_PROFILE_ID);
> +       avctp_header->transaction = transaction;
> +
> +       memcpy(&buf[AVCTP_HEADER_LENGTH], operands,
> +                                                       operand_count);
> +
> +       sock = g_io_channel_unix_get_fd(session->browsing_io);
> +       if (write(sock, buf, length) < 0)
> +               DBG("Write failed\n");
> +}

We can probably avoid using memcpy by using sendmsg, actually we
should do this for avctp_send as well.

> +static struct pdu_browsing_handler {
> +       uint8_t browsing_pdu;
> +       void (*func) (struct avrcp_player *player,
> +                                       struct avrcp_browsing_header *pdu);
> +       } browsing_handlers[] = {
> +               {},
> +};

What is the reason to have an empty array here? Is this just a place
holder for upcoming patches?

> +static void handle_browsing_pdu(struct avctp *session, uint8_t transaction,
> +                                       uint8_t *operands, size_t operand_count,
> +                                       void *user_data)
> +{
> +       struct avrcp_player *player = user_data;
> +       struct pdu_browsing_handler *b_handler;
> +       struct avrcp_browsing_header *avrcp_browsing = (void *) operands;
> +       uint8_t status, length;
> +
> +       if ((avrcp_browsing->browsing_pdu != AVRCP_SET_BROWSED_PLAYER) &&
> +                       (avrcp_browsing->browsing_pdu != AVRCP_GET_FOLDER_ITEMS) &&
> +                       (avrcp_browsing->browsing_pdu != AVRCP_CHANGE_PATH) &&
> +                       (avrcp_browsing->browsing_pdu != AVRCP_GET_ITEM_ATTRIBUTES)) {
> +
> +               avrcp_browsing->browsing_pdu = AVRCP_GENERAL_REJECT;
> +               status = AVRCP_STATUS_INVALID_COMMAND;
> +               goto err;
> +       }

This is over 80 columns and is inefficient since you are doing
basically the same bellow.

> +       for (b_handler = browsing_handlers; b_handler; b_handler++) {
> +               if (b_handler->browsing_pdu == avrcp_browsing->browsing_pdu)
> +                       break;
> +       }
> +

Where you should do the check if an handler was found e.g:

if (b_handler == NULL) {
        avrcp_browsing->browsing_pdu = AVRCP_GENERAL_REJECT;
        status = AVRCP_STATUS_INVALID_COMMAND;
        goto err;
}

> +       if (!b_handler->func) {
> +               status = AVRCP_STATUS_INVALID_PARAM;
> +               goto err;
> +       }
> +
> +       player->transaction = transaction;
> +       b_handler->func(player, avrcp_browsing);
> +       return;
> +
> +err:
> +       avrcp_browsing->param_len = htons(sizeof(status));
> +       length = AVRCP_BROWSING_HEADER_LENGTH + sizeof(status);
> +       memcpy(&operands[AVRCP_BROWSING_HEADER_LENGTH], &status,
> +                                               sizeof(status));
> +       avctp_send_browsing(session, player->transaction, operands,
> +                                                                       length);

If you gonna response immediately it is better to return the packet
size an write from the session_cb as done for control pdus, if nothing
should be written because the response will be asynchronous we can
just have it the handler return 0 and handle that in session_cb as no
response.

> +}
> +
>  size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
>  {
>         struct avrcp_header *pdu = (void *) operands;
> @@ -1233,6 +1299,11 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
>                         avctp_unregister_pdu_handler(player->control_handler);
>                         player->control_handler = 0;
>                 }
> +               if (player->browsing_handler) {
> +                       avctp_unregister_browsing_pdu_handler(
> +                                               player->browsing_handler);
> +                       player->browsing_handler = 0;
> +               }

The indentation above looks wrong, add a empty line before the if
statement, avctp_unregister_browsing_pdu_handler too long name.

>                 break;
>         case AVCTP_STATE_CONNECTING:
> @@ -1244,6 +1315,12 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
>                                                         AVC_OP_VENDORDEP,
>                                                         handle_vendordep_pdu,
>                                                         player);
> +               if (!player->browsing_handler)
> +                       player->browsing_handler =
> +                                       avctp_register_browsing_pdu_handler(
> +                                                       handle_browsing_pdu,
> +                                                       player);
> +

avctp_register_browsing_pdu_handler is also too long, in fact this is
another that we should probably just reuse avctp_register_pdu_handler
and maybe create an opcode for browsing just so that it be can
registered using avctp_register_pdu_handler.

>                 break;
>         case AVCTP_STATE_CONNECTED:
>                 rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
> diff --git a/audio/avrcp.h b/audio/avrcp.h
> index bf11a6c..7e2f018 100644
> --- a/audio/avrcp.h
> +++ b/audio/avrcp.h
> @@ -75,6 +75,8 @@
>  #define AVRCP_EVENT_TRACK_REACHED_START        0x04
>  #define AVRCP_EVENT_VOLUME_CHANGED     0x0d
>  #define AVRCP_EVENT_LAST               AVRCP_EVENT_VOLUME_CHANGED
> +struct avrcp_browsing_header;
> +#define AVRCP_BROWSING_HEADER_LENGTH 3

This is probably not necessary as the header should only be needed
inside avrcp.c you don't need to make it public.


-- 
Luiz Augusto von Dentz
