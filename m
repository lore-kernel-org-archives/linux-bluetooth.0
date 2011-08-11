Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313078013-19103-19-git-send-email-lucas.demarchi@profusion.mobi>
References: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1313078013-19103-19-git-send-email-lucas.demarchi@profusion.mobi>
Date: Fri, 12 Aug 2011 00:22:40 +0300
Message-ID: <CABBYNZ+-Ake2J1iHMhJDa56BVEad2ucN55iPiqQzQYArXD6ssA@mail.gmail.com>
Subject: Re: [PATCH v4 18/22] avrcp: send response for registered events
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Aug 11, 2011 at 6:53 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> When a certain event occur, check if CT registered to receive that
> notification and send a response.
>
> Example event for PTS test TC_TG_NFY_BV_02_C:
>
>> ACL data: handle 11 flags 0x02 dlen 22
>    L2CAP(d): cid 0x0043 len 18 [psm 23]
>      AVCTP: Command : pt 0x00 transaction 2 pid 0x110e
>        AV/C: Notify: address 0x48 opcode 0x00
>          Subunit: Panel
>          Opcode: Vendor Dependent
>          Company ID: 0x001958
>          AVRCP: RegisterNotification: pt 0x00 len 0x0005
>            EventID: 0x02 (EVENT_TRACK_CHANGED)
>            Interval: 0x00000000 (0 seconds)
> < ACL data: handle 11 flags 0x02 dlen 26
>    L2CAP(d): cid 0x0043 len 22 [psm 23]
>      AVCTP: Response : pt 0x00 transaction 2 pid 0x110e
>        AV/C: Interim: address 0x48 opcode 0x00
>          Subunit: Panel
>          Opcode: Vendor Dependent
>          Company ID: 0x001958
>          AVRCP: RegisterNotification: pt 0x00 len 0x0009
>            EventID: 0x02 (EVENT_TRACK_CHANGED)
>            Identifier: 0x0 (PLAYING)
>
> [...]
>
> < ACL data: handle 11 flags 0x02 dlen 26
>    L2CAP(d): cid 0x0043 len 22 [psm 23]
>      AVCTP: Response : pt 0x00 transaction 2 pid 0x110e
>        AV/C: Changed: address 0x48 opcode 0x00
>          Subunit: Panel
>          Opcode: Vendor Dependent
>          Company ID: 0x001958
>          AVRCP: RegisterNotification: pt 0x00 len 0x0009
>            EventID: 0x02 (EVENT_TRACK_CHANGED)
>            Identifier: 0x0 (PLAYING)
> ---
>  audio/control.c |   95 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 91 insertions(+), 4 deletions(-)
>
> diff --git a/audio/control.c b/audio/control.c
> index a29a392..2070e10 100644
> --- a/audio/control.c
> +++ b/audio/control.c
> @@ -79,6 +79,7 @@
>  #define CTYPE_ACCEPTED         0x9
>  #define CTYPE_REJECTED         0xA
>  #define CTYPE_STABLE           0xC
> +#define CTYPE_CHANGED          0xD
>  #define CTYPE_INTERIM          0xF
>
>  /* opcodes */
> @@ -313,6 +314,7 @@ struct control {
>        uint8_t key_quirks[256];
>
>        uint16_t registered_events;
> +       uint8_t transaction_events[AVRCP_EVENT_TRACK_CHANGED + 1];
>  };
>
>  static struct {
> @@ -716,6 +718,73 @@ static const char *battery_status_to_str(enum battery_status status)
>        return NULL;
>  }
>
> +static int avctp_send_event(struct control *control, uint8_t id, void *data)
> +{
> +       uint8_t buf[AVCTP_HEADER_LENGTH + AVRCP_HEADER_LENGTH +
> +                                       AVRCP_SPECAVCPDU_HEADER_LENGTH + 9];
> +       struct avctp_header *avctp = (void *) buf;
> +       struct avrcp_header *avrcp = (void *) &buf[AVCTP_HEADER_LENGTH];
> +       struct avrcp_spec_avc_pdu *pdu = (void *) &buf[AVCTP_HEADER_LENGTH +
> +                                                       AVRCP_HEADER_LENGTH];
> +       int sk = g_io_channel_unix_get_fd(control->io);
> +       uint16_t size;
> +
> +       memset(buf, 0, sizeof(buf));
> +
> +       avctp->transaction = control->transaction_events[id];
> +       avctp->packet_type = AVCTP_PACKET_SINGLE;
> +       avctp->cr = AVCTP_RESPONSE;
> +       avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
> +
> +       avrcp->code = CTYPE_CHANGED;
> +       avrcp->subunit_type = SUBUNIT_PANEL;
> +       avrcp->opcode = OP_VENDORDEP;
> +
> +       pdu->company_id[0] = IEEEID_BTSIG >> 16;
> +       pdu->company_id[1] = (IEEEID_BTSIG >> 8) & 0xFF;
> +       pdu->company_id[2] = IEEEID_BTSIG & 0xFF;
> +
> +       pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
> +       pdu->params[0] = id;
> +
> +       DBG("id=%u", id);
> +
> +       switch (id) {
> +       case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
> +               size = 2;
> +               pdu->params[1] = *((uint8_t *)data);
> +
> +               break;
> +       case AVRCP_EVENT_TRACK_CHANGED: {
> +               size = 9;
> +
> +               /*
> +                * AVRCP 1.3 supports only one track identifier: PLAYING
> +                * (0x0). When 1.4 version is added, this shall be changed to
> +                * contain the identifier of the track.
> +                */
> +               memset(&pdu->params[1], 0, 8);
> +
> +               break;
> +       }
> +       default:
> +               error("Unknown event %u", id);
> +               return -EINVAL;
> +       }
> +
> +       pdu->params_len = htons(size);
> +       size += AVCTP_HEADER_LENGTH + AVRCP_HEADER_LENGTH +
> +                                       AVRCP_SPECAVCPDU_HEADER_LENGTH;
> +
> +       if (write(sk, buf, size) < 0)
> +               return -errno;
> +
> +       /* Unregister event as per AVRCP 1.3 spec, section 5.4.2 */
> +       control->registered_events ^= 1 << id;
> +
> +       return 0;
> +}
> +
>  static void mp_get_playback_status(struct media_player *mp, uint8_t *status,
>                                        uint32_t *elapsed, uint32_t *track_len)
>  {
> @@ -754,6 +823,13 @@ static void mp_set_playback_status(struct control *control, uint8_t status,
>                return;
>
>        mp->status = status;
> +
> +       if (control->state == AVCTP_STATE_CONNECTED &&
> +                               (control->registered_events &
> +                               (1 << AVRCP_EVENT_PLAYBACK_STATUS_CHANGED))) {
> +               avctp_send_event(control, AVRCP_EVENT_PLAYBACK_STATUS_CHANGED,
> +                                                               &status);
> +       }
>  }
>
>  /*
> @@ -901,6 +977,12 @@ static void mp_set_media_attributes(struct control *control,
>                           "\tTrack number: %u\n\tTrack duration: %u",
>                           mi->title, mi->artist, mi->album, mi->genre,
>                           mi->ntracks, mi->track, mi->track_len);
> +
> +       if (control->state == AVCTP_STATE_CONNECTED &&
> +                                       (control->registered_events &
> +                                        (1 << AVRCP_EVENT_TRACK_CHANGED))) {
> +               avctp_send_event(control, AVRCP_EVENT_TRACK_CHANGED, NULL);
> +       }
>  }
>
>  static int avrcp_handle_get_capabilities(struct control *control,
> @@ -1241,7 +1323,8 @@ static int avrcp_handle_get_play_status(struct control *control,
>  }
>
>  static int avrcp_handle_register_notification(struct control *control,
> -                                               struct avrcp_spec_avc_pdu *pdu)
> +                                               struct avrcp_spec_avc_pdu *pdu,
> +                                               uint8_t transaction)
>  {
>        uint16_t len = ntohs(pdu->params_len);
>        uint8_t status;
> @@ -1280,8 +1363,9 @@ static int avrcp_handle_register_notification(struct control *control,
>                goto err;
>        }
>
> -       /* Register event */
> +       /* Register event and save the transaction used */
>        control->registered_events |= (1 << pdu->params[0]);
> +       control->transaction_events[pdu->params[0]] = transaction;
>
>        pdu->params_len = htons(len);
>
> @@ -1294,6 +1378,7 @@ err:
>
>  /* handle vendordep pdu inside an avctp packet */
>  static int handle_vendordep_pdu(struct control *control,
> +                                       struct avctp_header *avctp,
>                                        struct avrcp_header *avrcp,
>                                        int operand_count)
>  {
> @@ -1464,7 +1549,8 @@ static int handle_vendordep_pdu(struct control *control,
>                        goto err_metadata;
>                }
>
> -               len = avrcp_handle_register_notification(control, pdu);
> +               len = avrcp_handle_register_notification(control, pdu,
> +                                                       avctp->transaction);
>                if (len < 0)
>                        goto err_metadata;
>
> @@ -1662,7 +1748,8 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
>                int r_size;
>                operand_count -= 3;
>                avctp->cr = AVCTP_RESPONSE;
> -               r_size = handle_vendordep_pdu(control, avrcp, operand_count);
> +               r_size = handle_vendordep_pdu(control, avctp, avrcp,
> +                                                               operand_count);
>                packet_size = AVCTP_HEADER_LENGTH + r_size;
>        } else {
>                avctp->cr = AVCTP_RESPONSE;
> --
> 1.7.6

Looks good now, thanks for the quick update.

-- 
Luiz Augusto von Dentz
