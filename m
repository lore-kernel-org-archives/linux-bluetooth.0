Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1315826997-13818-1-git-send-email-luiz.dentz@gmail.com>
References: <1315826997-13818-1-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 12 Sep 2011 10:25:10 -0300
Message-ID: <CAMOw1v6DkURj+MVoA99=E7Nihe3_97O5Dh2b+94WSnVM4Yixxg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] AVRCP: use a vtable to simplify PDU parsing/handling
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 12, 2011 at 8:29 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This simplify a bit the handling by introducing common checks before
> calling the handler callback, it is also much easier to add/remove
> new PDUs in this way.
> ---
>  audio/control.c |  321 +++++++++++++++++++++----------------------------------
>  1 files changed, 124 insertions(+), 197 deletions(-)
>
> diff --git a/audio/control.c b/audio/control.c
> index 9990b06..f84c7f7 100644
> --- a/audio/control.c
> +++ b/audio/control.c
> @@ -986,8 +986,9 @@ static void mp_set_media_attributes(struct control *control,
>        avctp_send_event(control, AVRCP_EVENT_TRACK_CHANGED, NULL);
>  }
>
> -static int avrcp_handle_get_capabilities(struct control *control,
> -                                               struct avrcp_spec_avc_pdu *pdu)
> +static uint8_t avrcp_handle_get_capabilities(struct control *control,
> +                                               struct avrcp_spec_avc_pdu *pdu,
> +                                               uint8_t transaction)
>  {
>        uint16_t len = ntohs(pdu->params_len);
>        unsigned int i;
> @@ -1008,31 +1009,35 @@ static int avrcp_handle_get_capabilities(struct control *control,
>                pdu->params_len = htons(2 + (3 * G_N_ELEMENTS(company_ids)));
>                pdu->params[1] = G_N_ELEMENTS(company_ids);
>
> -               return 2 + (3 * G_N_ELEMENTS(company_ids));
> +               return CTYPE_STABLE;
>        case CAP_EVENTS_SUPPORTED:
>                pdu->params_len = htons(4);
>                pdu->params[1] = 2;
>                pdu->params[2] = AVRCP_EVENT_PLAYBACK_STATUS_CHANGED;
>                pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
>
> -               return 4;
> +               return CTYPE_STABLE;
>        }
>
>  err:
> +       pdu->params_len = htons(1);
>        pdu->params[0] = E_INVALID_PARAM;
> -       return -EINVAL;
> +
> +       return CTYPE_REJECTED;
>  }
>
> -static int avrcp_handle_list_player_attributes(struct control *control,
> -                                               struct avrcp_spec_avc_pdu *pdu)
> +static uint8_t avrcp_handle_list_player_attributes(struct control *control,
> +                                               struct avrcp_spec_avc_pdu *pdu,
> +                                               uint8_t transaction)

It might be my CFLAGS, but aren't you getting warnings of unused
parameters since now every handler carries the transaction id?

>  {
>        uint16_t len = ntohs(pdu->params_len);
>        struct media_player *mp = control->mp;
>        unsigned int i;
>
>        if (len != 0) {
> +               pdu->params_len = htons(1);
>                pdu->params[0] = E_INVALID_PARAM;
> -               return -EINVAL;
> +               return CTYPE_REJECTED;
>        }
>
>        if (!mp)
> @@ -1052,11 +1057,12 @@ done:
>        pdu->params[0] = len;
>        pdu->params_len = htons(len + 1);
>
> -       return len + 1;
> +       return CTYPE_STABLE;
>  }
>
> -static int avrcp_handle_list_player_values(struct control *control,
> -                                               struct avrcp_spec_avc_pdu *pdu)
> +static uint8_t avrcp_handle_list_player_values(struct control *control,
> +                                               struct avrcp_spec_avc_pdu *pdu,
> +                                               uint8_t transaction)
>  {
>        uint16_t len = ntohs(pdu->params_len);
>        struct media_player *mp = control->mp;
> @@ -1077,15 +1083,17 @@ static int avrcp_handle_list_player_values(struct control *control,
>        pdu->params[0] = len;
>        pdu->params_len = htons(len + 1);
>
> -       return len + 1;
> +       return CTYPE_STABLE;
>
>  err:
> +       pdu->params_len = htons(1);
>        pdu->params[0] = E_INVALID_PARAM;
> -       return -EINVAL;
> +       return CTYPE_REJECTED;
>  }
>
> -static int avrcp_handle_get_element_attributes(struct control *control,
> -                                               struct avrcp_spec_avc_pdu *pdu)
> +static uint8_t avrcp_handle_get_element_attributes(struct control *control,
> +                                               struct avrcp_spec_avc_pdu *pdu,
> +                                               uint8_t transaction)
>  {
>        uint16_t len = ntohs(pdu->params_len);
>        uint64_t *identifier = (void *) &pdu->params[0];
> @@ -1145,14 +1153,16 @@ done:
>        pdu->params[0] = len;
>        pdu->params_len = htons(pos);
>
> -       return pos;
> +       return CTYPE_STABLE;
>  err:
> +       pdu->params_len = htons(1);
>        pdu->params[0] = E_INVALID_PARAM;
> -       return -EINVAL;
> +       return CTYPE_REJECTED;
>  }
>
> -static int avrcp_handle_get_current_player_value(struct control *control,
> -                                               struct avrcp_spec_avc_pdu *pdu)
> +static uint8_t avrcp_handle_get_current_player_value(struct control *control,
> +                                               struct avrcp_spec_avc_pdu *pdu,
> +                                               uint8_t transaction)
>  {
>        uint16_t len = ntohs(pdu->params_len);
>        struct media_player *mp = control->mp;
> @@ -1202,19 +1212,21 @@ static int avrcp_handle_get_current_player_value(struct control *control,
>                pdu->params[0] = len;
>                pdu->params_len = htons(2 * len + 1);
>
> -               return 2 * len + 1;
> +               return CTYPE_STABLE;
>        }
>
>        error("No valid attributes in request");
>
>  err:
> +       pdu->params_len = htons(1);
>        pdu->params[0] = E_INVALID_PARAM;
>
> -       return -EINVAL;
> +       return CTYPE_REJECTED;
>  }
>
> -static int avrcp_handle_set_player_value(struct control *control,
> -                                               struct avrcp_spec_avc_pdu *pdu)
> +static uint8_t avrcp_handle_set_player_value(struct control *control,
> +                                               struct avrcp_spec_avc_pdu *pdu,
> +                                               uint8_t transaction)
>  {
>        uint16_t len = ntohs(pdu->params_len);
>        unsigned int i;
> @@ -1256,16 +1268,38 @@ static int avrcp_handle_set_player_value(struct control *control,
>        if (len) {
>                pdu->params_len = 0;
>
> -               return 0;
> +               return CTYPE_STABLE;
>        }
>
>  err:
> +       pdu->params_len = htons(1);
>        pdu->params[0] = E_INVALID_PARAM;
> -       return -EINVAL;
> +       return CTYPE_REJECTED;
>  }
>
> -static int avrcp_handle_ct_battery_status(struct control *control,
> -                                               struct avrcp_spec_avc_pdu *pdu)
> +static uint8_t avrcp_handle_displayable_charset(struct control *control,
> +                                               struct avrcp_spec_avc_pdu *pdu,
> +                                               uint8_t transaction)
> +{
> +       uint16_t len = ntohs(pdu->params_len);
> +
> +       if (len < 3) {
> +               pdu->params_len = htons(1);
> +               pdu->params[0] = E_INVALID_PARAM;
> +               return CTYPE_REJECTED;
> +       }
> +
> +       /*
> +        * We acknowledge the commands, but we always use UTF-8 for
> +        * encoding since CT is obliged to support it.
> +        */
> +       pdu->params_len = 0;
> +       return CTYPE_STABLE;
> +}
> +
> +static uint8_t avrcp_handle_ct_battery_status(struct control *control,
> +                                               struct avrcp_spec_avc_pdu *pdu,
> +                                               uint8_t transaction)
>  {
>        uint16_t len = ntohs(pdu->params_len);
>        const char *valstr;
> @@ -1282,15 +1316,17 @@ static int avrcp_handle_ct_battery_status(struct control *control,
>                                        DBUS_TYPE_STRING, &valstr);
>        pdu->params_len = 0;
>
> -       return 0;
> +       return CTYPE_STABLE;
>
>  err:
> +       pdu->params_len = htons(1);
>        pdu->params[0] = E_INVALID_PARAM;
> -       return -EINVAL;
> +       return CTYPE_REJECTED;
>  }
>
> -static int avrcp_handle_get_play_status(struct control *control,
> -                                               struct avrcp_spec_avc_pdu *pdu)
> +static uint8_t avrcp_handle_get_play_status(struct control *control,
> +                                               struct avrcp_spec_avc_pdu *pdu,
> +                                               uint8_t transaction)
>  {
>        uint16_t len = ntohs(pdu->params_len);
>        uint32_t elapsed;
> @@ -1298,8 +1334,9 @@ static int avrcp_handle_get_play_status(struct control *control,
>        uint8_t status;
>
>        if (len != 0) {
> +               pdu->params_len = htons(1);
>                pdu->params[0] = E_INVALID_PARAM;
> -               return -EINVAL;
> +               return CTYPE_REJECTED;
>        }
>
>        if (control->mp) {
> @@ -1319,10 +1356,10 @@ static int avrcp_handle_get_play_status(struct control *control,
>
>        pdu->params_len = htons(9);
>
> -       return 9;
> +       return CTYPE_STABLE;
>  }
>
> -static int avrcp_handle_register_notification(struct control *control,
> +static uint8_t avrcp_handle_register_notification(struct control *control,
>                                                struct avrcp_spec_avc_pdu *pdu,
>                                                uint8_t transaction)
>  {
> @@ -1369,24 +1406,59 @@ static int avrcp_handle_register_notification(struct control *control,
>
>        pdu->params_len = htons(len);
>
> -       return len;
> +       return CTYPE_INTERIM;
>
>  err:
> +       pdu->params_len = htons(1);
>        pdu->params[0] = E_INVALID_PARAM;
> -       return -EINVAL;
> +       return CTYPE_REJECTED;
>  }
>
> +static struct pdu_handler {
> +       uint8_t pdu_id;
> +       uint8_t code;
> +       uint8_t (*func) (struct control *control,
> +                                       struct avrcp_spec_avc_pdu *pdu,
> +                                       uint8_t transaction);
> +} handlers[] = {
> +               { AVRCP_GET_CAPABILITIES, CTYPE_STATUS,
> +                                       avrcp_handle_get_capabilities },
> +               { AVRCP_LIST_PLAYER_ATTRIBUTES, CTYPE_STATUS,
> +                                       avrcp_handle_list_player_attributes },
> +               { AVRCP_LIST_PLAYER_VALUES, CTYPE_STATUS,
> +                                       avrcp_handle_list_player_values },
> +               { AVRCP_GET_ELEMENT_ATTRIBUTES, CTYPE_STATUS,
> +                                       avrcp_handle_get_element_attributes },
> +               { AVRCP_GET_CURRENT_PLAYER_VALUE, CTYPE_STATUS,
> +                                       avrcp_handle_get_current_player_value },
> +               { AVRCP_SET_PLAYER_VALUE, CTYPE_CONTROL,
> +                                       avrcp_handle_set_player_value },
> +               { AVRCP_GET_PLAYER_ATTRIBUTE_TEXT, CTYPE_STATUS,
> +                                       NULL },
> +               { AVRCP_GET_PLAYER_VALUE_TEXT, CTYPE_STATUS,
> +                                       NULL },
> +               { AVRCP_DISPLAYABLE_CHARSET, CTYPE_STATUS,
> +                                       avrcp_handle_displayable_charset },
> +               { AVRCP_CT_BATTERY_STATUS, CTYPE_STATUS,
> +                                       avrcp_handle_ct_battery_status },
> +               { AVRCP_GET_PLAY_STATUS, CTYPE_STATUS,
> +                                       avrcp_handle_get_play_status },
> +               { AVRCP_REGISTER_NOTIFICATION, CTYPE_NOTIFY,
> +                                       avrcp_handle_register_notification },
> +               { },
> +};
> +
>  /* handle vendordep pdu inside an avctp packet */
>  static int handle_vendordep_pdu(struct control *control,
>                                        struct avctp_header *avctp,
>                                        struct avrcp_header *avrcp,
>                                        int operand_count)
>  {
> +       struct pdu_handler *handler;
>        struct avrcp_spec_avc_pdu *pdu = (void *) avrcp + AVRCP_HEADER_LENGTH;
>        uint32_t company_id = (pdu->company_id[0] << 16) |
>                                (pdu->company_id[1] << 8) |
>                                (pdu->company_id[2]);
> -       int len;
>
>        if (company_id != IEEEID_BTSIG ||
>                                pdu->packet_type != AVCTP_PACKET_SINGLE) {
> @@ -1397,177 +1469,32 @@ static int handle_vendordep_pdu(struct control *control,
>        pdu->packet_type = 0;
>        pdu->rsvd = 0;
>
> -       if (operand_count + 3 < AVRCP_SPECAVCPDU_HEADER_LENGTH) {
> -               pdu->params[0] = E_INVALID_COMMAND;
> +       if (operand_count + 3 < AVRCP_SPECAVCPDU_HEADER_LENGTH)
>                goto err_metadata;
> -       }
> -
> -       switch (pdu->pdu_id) {
> -       case AVRCP_GET_CAPABILITIES:
> -               if (avrcp->code != CTYPE_STATUS) {
> -                       pdu->params[0] = E_INVALID_COMMAND;
> -                       goto err_metadata;
> -               }
> -
> -               len = avrcp_handle_get_capabilities(control, pdu);
> -               if (len < 0)
> -                       goto err_metadata;
> -
> -               avrcp->code = CTYPE_STABLE;
> -
> -               break;
> -       case AVRCP_LIST_PLAYER_ATTRIBUTES:
> -               if (avrcp->code != CTYPE_STATUS) {
> -                       pdu->params[0] = E_INVALID_COMMAND;
> -                       goto err_metadata;
> -               }
>
> -               len = avrcp_handle_list_player_attributes(control, pdu);
> -               if (len < 0)
> -                       goto err_metadata;
> -
> -               avrcp->code = CTYPE_STABLE;
> -
> -               break;
> -       case AVRCP_LIST_PLAYER_VALUES:
> -               if (avrcp->code != CTYPE_STATUS) {
> -                       pdu->params[0] = E_INVALID_COMMAND;
> -                       goto err_metadata;
> -               }
> -
> -               len = avrcp_handle_list_player_values(control, pdu);
> -               if (len < 0)
> -                       goto err_metadata;
> -
> -               avrcp->code = CTYPE_STABLE;
> -
> -               break;
> -       case AVRCP_GET_ELEMENT_ATTRIBUTES:
> -               if (avrcp->code != CTYPE_STATUS) {
> -                       pdu->params[0] = E_INVALID_COMMAND;
> -                       goto err_metadata;
> -               }
> -
> -               len = avrcp_handle_get_element_attributes(control, pdu);
> -               if (len < 0)
> -                       goto err_metadata;
> -
> -               avrcp->code = CTYPE_STABLE;
> -
> -               break;
> -       case AVRCP_GET_CURRENT_PLAYER_VALUE:
> -               if (avrcp->code != CTYPE_STATUS) {
> -                       pdu->params[0] = E_INVALID_COMMAND;
> -                       goto err_metadata;
> -               }
> -
> -               len = avrcp_handle_get_current_player_value(control, pdu);
> -               if (len < 0)
> -                       goto err_metadata;
> -
> -               avrcp->code = CTYPE_STABLE;
> -
> -               break;
> -       case AVRCP_SET_PLAYER_VALUE:
> -               if (avrcp->code != CTYPE_CONTROL) {
> -                       pdu->params[0] = E_INVALID_COMMAND;
> -                       goto err_metadata;
> -               }
> -
> -               len = avrcp_handle_set_player_value(control, pdu);
> -               if (len < 0)
> -                       goto err_metadata;
> -
> -               avrcp->code = CTYPE_STABLE;
> -
> -               break;
> -       case AVRCP_GET_PLAYER_ATTRIBUTE_TEXT:
> -       case AVRCP_GET_PLAYER_VALUE_TEXT:
> -               if (avrcp->code != CTYPE_STATUS) {
> -                       pdu->params[0] = E_INVALID_COMMAND;
> -                       goto err_metadata;
> -               }
> +       for (handler = handlers; handler; handler++) {
> +               if (handler->pdu_id == pdu->pdu_id)
> +                       break;
> +       }
>
> -               /*
> -                * As per sec. 5.2.5 of AVRCP 1.3 spec, this command is
> -                * expected to be used only for extended attributes, i.e.
> -                * custom attributes defined by the application. As we
> -                * currently don't have any such attribute, we respond with
> -                * invalid param id.
> -                */
> -               pdu->params[0] = E_INVALID_PARAM;
> +       if (!handler || handler->code != avrcp->code) {
> +               pdu->params[0] = E_INVALID_COMMAND;
>                goto err_metadata;
> -       case AVRCP_DISPLAYABLE_CHARSET:
> -               if (avrcp->code != CTYPE_STATUS) {
> -                       pdu->params[0] = E_INVALID_COMMAND;
> -                       goto err_metadata;
> -               }
> -
> -               if (pdu->params[0] < 3) {
> -                       pdu->params[0] = E_INVALID_PARAM;
> -                       goto err_metadata;
> -               }
> -
> -               /*
> -                * We acknowledge the commands, but we always use UTF-8 for
> -                * encoding since CT is obliged to support it.
> -                */
> -               pdu->params_len = 0;
> -               avrcp->code = CTYPE_STABLE;
> -               len = 0;
> -
> -               break;
> -       case AVRCP_CT_BATTERY_STATUS:
> -               if (avrcp->code != CTYPE_STATUS) {
> -                       pdu->params[0] = E_INVALID_COMMAND;
> -                       goto err_metadata;
> -               }
> -
> -               len = avrcp_handle_ct_battery_status(control, pdu);
> -               if (len < 0)
> -                       goto err_metadata;
> -
> -               avrcp->code = CTYPE_STABLE;
> -
> -               break;
> -       case AVRCP_GET_PLAY_STATUS:
> -               if (avrcp->code != CTYPE_STATUS) {
> -                       pdu->params[0] = E_INVALID_COMMAND;
> -                       goto err_metadata;
> -               }
> -
> -               len = avrcp_handle_get_play_status(control, pdu);
> -               if (len < 0)
> -                       goto err_metadata;
> -
> -               avrcp->code = CTYPE_STABLE;
> -
> -               break;
> -       case AVRCP_REGISTER_NOTIFICATION:
> -               if (avrcp->code != CTYPE_NOTIFY) {
> -                       pdu->params[0] = E_INVALID_COMMAND;
> -                       goto err_metadata;
> -               }
> -
> -               len = avrcp_handle_register_notification(control, pdu,
> -                                                       avctp->transaction);
> -               if (len < 0)
> -                       goto err_metadata;
> -
> -               avrcp->code = CTYPE_INTERIM;
> +       }
>
> -               break;
> -       default:
> -               /* Invalid pdu_id */
> -               pdu->params[0] = E_INVALID_COMMAND;
> +       if (!handler->func) {
> +               pdu->params[0] = E_INVALID_PARAM;
>                goto err_metadata;
>        }
>
> -       return AVRCP_HEADER_LENGTH + AVRCP_SPECAVCPDU_HEADER_LENGTH + len;
> +       avrcp->code = handler->func(control, pdu, avctp->transaction);
> +
> +       return AVRCP_HEADER_LENGTH + AVRCP_SPECAVCPDU_HEADER_LENGTH +
> +                                               ntohs(pdu->params_len);
>
>  err_metadata:
> -       avrcp->code = CTYPE_REJECTED;
>        pdu->params_len = htons(1);
> +       avrcp->code = CTYPE_REJECTED;
>
>        return AVRCP_HEADER_LENGTH + AVRCP_SPECAVCPDU_HEADER_LENGTH + 1;
>  }

Otherwise looks good.



Lucas De Marchi
