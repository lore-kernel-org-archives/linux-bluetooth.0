Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1340878959-1343-1-git-send-email-michal.labedzki@tieto.com>
References: <1340878959-1343-1-git-send-email-michal.labedzki@tieto.com>
Date: Wed, 4 Jul 2012 16:40:18 +0300
Message-ID: <CABBYNZ+d-a=4+t1OU533axeH4GPP=DCg2bqY3CdQLf_0+vTjXg@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] AVRCP: Update constants
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, lucas.demarchi@profusion.mobi,
	johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Thu, Jun 28, 2012 at 1:22 PM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> Update constant names for AVRCP 1.4 to avoid confusion.
> AVRCP 1.4 introduces status code that is not error code, so using
> "status" prefix for both. Also do not use AVRCP prefix for local
> constants and add constants for addressed player feature.
> ---
>  audio/avrcp.c |  216 ++++++++++++++++++++++++++++++---------------------------
>  audio/avrcp.h |   17 +++--
>  audio/media.c |    2 +-
>  3 files changed, 124 insertions(+), 111 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 89ee112..125baa4 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -61,54 +61,67 @@
>  /* Company IDs for vendor dependent commands */
>  #define IEEEID_BTSIG           0x001958
>
> -/* Error codes for metadata transfer */
> -#define E_INVALID_COMMAND      0x00
> -#define E_INVALID_PARAM                0x01
> -#define E_PARAM_NOT_FOUND      0x02
> -#define E_INTERNAL             0x03
> -
>  /* Packet types */
> -#define AVRCP_PACKET_TYPE_SINGLE       0x00
> -#define AVRCP_PACKET_TYPE_START                0x01
> -#define AVRCP_PACKET_TYPE_CONTINUING   0x02
> -#define AVRCP_PACKET_TYPE_END          0x03
> -
> -/* PDU types for metadata transfer */
> -#define AVRCP_GET_CAPABILITIES         0x10
> -#define AVRCP_LIST_PLAYER_ATTRIBUTES   0X11
> -#define AVRCP_LIST_PLAYER_VALUES       0x12
> -#define AVRCP_GET_CURRENT_PLAYER_VALUE 0x13
> -#define AVRCP_SET_PLAYER_VALUE         0x14
> -#define AVRCP_GET_PLAYER_ATTRIBUTE_TEXT        0x15
> -#define AVRCP_GET_PLAYER_VALUE_TEXT    0x16
> -#define AVRCP_DISPLAYABLE_CHARSET      0x17
> -#define AVRCP_CT_BATTERY_STATUS                0x18
> -#define AVRCP_GET_ELEMENT_ATTRIBUTES   0x20
> -#define AVRCP_GET_PLAY_STATUS          0x30
> -#define AVRCP_REGISTER_NOTIFICATION    0x31
> -#define AVRCP_REQUEST_CONTINUING       0x40
> -#define AVRCP_ABORT_CONTINUING         0x41
> -#define AVRCP_SET_ABSOLUTE_VOLUME      0x50
> -
> -/* Capabilities for AVRCP_GET_CAPABILITIES pdu */
> +#define PACKET_TYPE_SINGLE     0x00
> +#define PACKET_TYPE_START      0x01
> +#define PACKET_TYPE_CONTINUING 0x02
> +#define PACKET_TYPE_END                0x03
> +
> +/* Status codes */
> +#define STATUS_INVALID_COMMAND         0x00
> +#define STATUS_INVALID_PARAMETER       0x01
> +#define STATUS_INTERNAL_ERROR          0x03
> +#define STATUS_OK                      0x04
> +#define STATUS_INVALID_PLAYER_ID       0x11
> +#define STATUS_NO_AVAILABLE_PLAYERS    0x15
> +#define STATUS_ADDRESSED_PLAYER_CHANGED        0x16
> +
> +/* Control channel PDUs */
> +#define PDU_GET_CAPABILITIES           0x10
> +#define PDU_LIST_PLAYER_ATTRIBUTES     0X11
> +#define PDU_LIST_PLAYER_VALUES         0x12
> +#define PDU_GET_CURRENT_PLAYER_VALUE   0x13
> +#define PDU_SET_PLAYER_VALUE           0x14
> +#define PDU_GET_PLAYER_ATTRIBUTE_TEXT  0x15
> +#define PDU_GET_PLAYER_VALUE_TEXT      0x16
> +#define PDU_DISPLAYABLE_CHARSET                0x17
> +#define PDU_CT_BATTERY_STATUS          0x18
> +#define PDU_GET_ELEMENT_ATTRIBUTES     0x20
> +#define PDU_GET_PLAY_STATUS            0x30
> +#define PDU_REGISTER_NOTIFICATION      0x31
> +#define PDU_REQUEST_CONTINUING         0x40
> +#define PDU_ABORT_CONTINUING           0x41
> +#define PDU_SET_ABSOLUTE_VOLUME                0x50
> +#define PDU_SET_ADDRESSED_PLAYER       0x60
> +
> +/* Capabilities for PDU_GET_CAPABILITIES */
>  #define CAP_COMPANY_ID         0x02
>  #define CAP_EVENTS_SUPPORTED   0x03
>
> -#define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH 5
> +/* SDP records features */
> +#define FEATURE_CATEGORY_1     0x0001
> +#define FEATURE_CATEGORY_2     0x0002
> +#define FEATURE_CATEGORY_3     0x0004
> +#define FEATURE_CATEGORY_4     0x0008
> +#define FEATURE_PLAYER_SETTINGS        0x0010
>
> -#define AVRCP_FEATURE_CATEGORY_1       0x0001
> -#define AVRCP_FEATURE_CATEGORY_2       0x0002
> -#define AVRCP_FEATURE_CATEGORY_3       0x0004
> -#define AVRCP_FEATURE_CATEGORY_4       0x0008
> -#define AVRCP_FEATURE_PLAYER_SETTINGS  0x0010
> +/* Battery status */
> +#define BATTERY_STATUS_NORMAL          0x00
> +#define BATTERY_STATUS_WARNING         0x01
> +#define BATTERY_STATUS_CRITICAL                0x02
> +#define BATTERY_STATUS_EXTERNAL                0x03
> +#define BATTERY_STATUS_FULL_CHARGE     0x04
>
> -enum battery_status {
> -       BATTERY_STATUS_NORMAL =         0,
> -       BATTERY_STATUS_WARNING =        1,
> -       BATTERY_STATUS_CRITICAL =       2,
> -       BATTERY_STATUS_EXTERNAL =       3,
> -       BATTERY_STATUS_FULL_CHARGE =    4,
> -};
> +/* Profile versions */
> +#define VERSION_UNKNOWN        0x0000
> +#define VERSION_1_3    0x0103
> +#define VERSION_1_4    0x0104
> +
> +#define REGISTER_NOTIFICATION_PARAM_LENGTH     5
> +
> +#define AVRCP_HEADER_LENGTH    7
> +#define AVRCP_MTU              (AVC_MTU - AVC_HEADER_LENGTH)
> +#define AVRCP_PDU_MTU          (AVRCP_MTU - AVRCP_HEADER_LENGTH)
>
>  #if __BYTE_ORDER == __LITTLE_ENDIAN
>
> @@ -120,7 +133,6 @@ struct avrcp_header {
>         uint16_t params_len;
>         uint8_t params[0];
>  } __attribute__ ((packed));
> -#define AVRCP_HEADER_LENGTH 7
>
>  #elif __BYTE_ORDER == __BIG_ENDIAN
>
> @@ -132,15 +144,11 @@ struct avrcp_header {
>         uint16_t params_len;
>         uint8_t params[0];
>  } __attribute__ ((packed));
> -#define AVRCP_HEADER_LENGTH 7
>
>  #else
>  #error "Unknown byte order"
>  #endif
>
> -#define AVRCP_MTU      (AVC_MTU - AVC_HEADER_LENGTH)
> -#define AVRCP_PDU_MTU  (AVRCP_MTU - AVRCP_HEADER_LENGTH)
> -
>  struct avrcp_server {
>         bdaddr_t src;
>         uint32_t tg_record_id;
> @@ -190,10 +198,10 @@ static sdp_record_t *avrcp_ct_record(void)
>         sdp_data_t *psm, *version, *features;
>         uint16_t lp = AVCTP_PSM;
>         uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103;
> -       uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
> -                                               AVRCP_FEATURE_CATEGORY_2 |
> -                                               AVRCP_FEATURE_CATEGORY_3 |
> -                                               AVRCP_FEATURE_CATEGORY_4 );
> +       uint16_t feat = ( FEATURE_CATEGORY_1 |
> +                                               FEATURE_CATEGORY_2 |
> +                                               FEATURE_CATEGORY_3 |
> +                                               FEATURE_CATEGORY_4 );
>
>         record = sdp_record_alloc();
>         if (!record)
> @@ -258,11 +266,11 @@ static sdp_record_t *avrcp_tg_record(void)
>         sdp_data_t *psm, *version, *features;
>         uint16_t lp = AVCTP_PSM;
>         uint16_t avrcp_ver = 0x0104, avctp_ver = 0x0103;
> -       uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
> -                                       AVRCP_FEATURE_CATEGORY_2 |
> -                                       AVRCP_FEATURE_CATEGORY_3 |
> -                                       AVRCP_FEATURE_CATEGORY_4 |
> -                                       AVRCP_FEATURE_PLAYER_SETTINGS );
> +       uint16_t feat = ( FEATURE_CATEGORY_1 |
> +                                       FEATURE_CATEGORY_2 |
> +                                       FEATURE_CATEGORY_3 |
> +                                       FEATURE_CATEGORY_4 |
> +                                       FEATURE_PLAYER_SETTINGS );
>
>         record = sdp_record_alloc();
>         if (!record)
> @@ -333,7 +341,7 @@ static unsigned int attr_get_max_val(uint8_t attr)
>         return 0;
>  }
>
> -static const char *battery_status_to_str(enum battery_status status)
> +static const char *battery_status_to_str(uint8_t status)
>  {
>         switch (status) {
>         case BATTERY_STATUS_NORMAL:
> @@ -390,13 +398,13 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
>
>         set_company_id(pdu->company_id, IEEEID_BTSIG);
>
> -       pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
> +       pdu->pdu_id = PDU_REGISTER_NOTIFICATION;
>         pdu->params[0] = id;
>
>         DBG("id=%u", id);
>
>         switch (id) {
> -       case AVRCP_EVENT_STATUS_CHANGED:
> +       case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
>                 size = 2;
>                 pdu->params[1] = *((uint8_t *)data);
>
> @@ -581,7 +589,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
>                 return AVC_CTYPE_STABLE;
>         case CAP_EVENTS_SUPPORTED:
>                 pdu->params[1] = 4;
> -               pdu->params[2] = AVRCP_EVENT_STATUS_CHANGED;
> +               pdu->params[2] = AVRCP_EVENT_PLAYBACK_STATUS_CHANGED;
>                 pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
>                 pdu->params[4] = AVRCP_EVENT_TRACK_REACHED_START;
>                 pdu->params[5] = AVRCP_EVENT_TRACK_REACHED_END;
> @@ -592,7 +600,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
>
>  err:
>         pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>
>         return AVC_CTYPE_REJECTED;
>  }
> @@ -606,7 +614,7 @@ static uint8_t avrcp_handle_list_player_attributes(struct avrcp_player *player,
>
>         if (len != 0) {
>                 pdu->params_len = htons(1);
> -               pdu->params[0] = E_INVALID_PARAM;
> +               pdu->params[0] = STATUS_INVALID_PARAMETER;
>                 return AVC_CTYPE_REJECTED;
>         }
>
> @@ -653,7 +661,7 @@ static uint8_t avrcp_handle_list_player_values(struct avrcp_player *player,
>
>  err:
>         pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>         return AVC_CTYPE_REJECTED;
>  }
>
> @@ -715,7 +723,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
>         if (attr_ids != NULL) {
>                 player->pending_pdu = pending_pdu_new(pdu->pdu_id, attr_ids,
>                                                                 offset);
> -               pdu->packet_type = AVRCP_PACKET_TYPE_START;
> +               pdu->packet_type = PACKET_TYPE_START;
>         }
>
>         pdu->params[0] = len;
> @@ -724,7 +732,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
>         return AVC_CTYPE_STABLE;
>  err:
>         pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>         return AVC_CTYPE_REJECTED;
>  }
>
> @@ -781,7 +789,7 @@ static uint8_t avrcp_handle_get_current_player_value(struct avrcp_player *player
>
>  err:
>         pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>
>         return AVC_CTYPE_REJECTED;
>  }
> @@ -802,7 +810,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
>          * and set the existent ones. Sec. 5.2.4 is not clear however how to
>          * indicate that a certain ID was not accepted. If at least one
>          * attribute is valid, we respond with no parameters. Otherwise an
> -        * E_INVALID_PARAM is sent.
> +        * STATUS_INVALID_PARAMETER is sent.
>          */
>         for (len = 0, i = 0, param = &pdu->params[1]; i < pdu->params[0];
>                                                         i++, param += 2) {
> @@ -820,7 +828,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
>
>  err:
>         pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>         return AVC_CTYPE_REJECTED;
>  }
>
> @@ -832,7 +840,7 @@ static uint8_t avrcp_handle_displayable_charset(struct avrcp_player *player,
>
>         if (len < 3) {
>                 pdu->params_len = htons(1);
> -               pdu->params[0] = E_INVALID_PARAM;
> +               pdu->params[0] = STATUS_INVALID_PARAMETER;
>                 return AVC_CTYPE_REJECTED;
>         }
>
> @@ -864,7 +872,7 @@ static uint8_t avrcp_handle_ct_battery_status(struct avrcp_player *player,
>
>  err:
>         pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>         return AVC_CTYPE_REJECTED;
>  }
>
> @@ -879,7 +887,7 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp_player *player,
>
>         if (len != 0) {
>                 pdu->params_len = htons(1);
> -               pdu->params[0] = E_INVALID_PARAM;
> +               pdu->params[0] = STATUS_INVALID_PARAMETER;
>                 return AVC_CTYPE_REJECTED;
>         }
>
> @@ -918,7 +926,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
>                 goto err;
>
>         switch (pdu->params[0]) {
> -       case AVRCP_EVENT_STATUS_CHANGED:
> +       case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
>                 len = 2;
>                 pdu->params[1] = player->cb->get_status(player->user_data);
>
> @@ -948,7 +956,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
>
>  err:
>         pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>         return AVC_CTYPE_REJECTED;
>  }
>
> @@ -978,9 +986,9 @@ static uint8_t avrcp_handle_request_continuing(struct avrcp_player *player,
>         if (pending->attr_ids == NULL) {
>                 g_free(player->pending_pdu);
>                 player->pending_pdu = NULL;
> -               pdu->packet_type = AVRCP_PACKET_TYPE_END;
> +               pdu->packet_type = PACKET_TYPE_END;
>         } else {
> -               pdu->packet_type = AVRCP_PACKET_TYPE_CONTINUING;
> +               pdu->packet_type = PACKET_TYPE_CONTINUING;
>         }
>
>         pdu->params_len = htons(len);
> @@ -988,7 +996,7 @@ static uint8_t avrcp_handle_request_continuing(struct avrcp_player *player,
>         return AVC_CTYPE_STABLE;
>  err:
>         pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>         return AVC_CTYPE_REJECTED;
>  }
>
> @@ -1014,7 +1022,7 @@ static uint8_t avrcp_handle_abort_continuing(struct avrcp_player *player,
>
>  err:
>         pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>         return AVC_CTYPE_REJECTED;
>  }
>
> @@ -1025,33 +1033,33 @@ static struct pdu_handler {
>                                         struct avrcp_header *pdu,
>                                         uint8_t transaction);
>  } handlers[] = {
> -               { AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
> +               { PDU_GET_CAPABILITIES, AVC_CTYPE_STATUS,
>                                         avrcp_handle_get_capabilities },
> -               { AVRCP_LIST_PLAYER_ATTRIBUTES, AVC_CTYPE_STATUS,
> +               { PDU_LIST_PLAYER_ATTRIBUTES, AVC_CTYPE_STATUS,
>                                         avrcp_handle_list_player_attributes },
> -               { AVRCP_LIST_PLAYER_VALUES, AVC_CTYPE_STATUS,
> +               { PDU_LIST_PLAYER_VALUES, AVC_CTYPE_STATUS,
>                                         avrcp_handle_list_player_values },
> -               { AVRCP_GET_ELEMENT_ATTRIBUTES, AVC_CTYPE_STATUS,
> +               { PDU_GET_ELEMENT_ATTRIBUTES, AVC_CTYPE_STATUS,
>                                         avrcp_handle_get_element_attributes },
> -               { AVRCP_GET_CURRENT_PLAYER_VALUE, AVC_CTYPE_STATUS,
> +               { PDU_GET_CURRENT_PLAYER_VALUE, AVC_CTYPE_STATUS,
>                                         avrcp_handle_get_current_player_value },
> -               { AVRCP_SET_PLAYER_VALUE, AVC_CTYPE_CONTROL,
> +               { PDU_SET_PLAYER_VALUE, AVC_CTYPE_CONTROL,
>                                         avrcp_handle_set_player_value },
> -               { AVRCP_GET_PLAYER_ATTRIBUTE_TEXT, AVC_CTYPE_STATUS,
> +               { PDU_GET_PLAYER_ATTRIBUTE_TEXT, AVC_CTYPE_STATUS,
>                                         NULL },
> -               { AVRCP_GET_PLAYER_VALUE_TEXT, AVC_CTYPE_STATUS,
> +               { PDU_GET_PLAYER_VALUE_TEXT, AVC_CTYPE_STATUS,
>                                         NULL },
> -               { AVRCP_DISPLAYABLE_CHARSET, AVC_CTYPE_STATUS,
> +               { PDU_DISPLAYABLE_CHARSET, AVC_CTYPE_STATUS,
>                                         avrcp_handle_displayable_charset },
> -               { AVRCP_CT_BATTERY_STATUS, AVC_CTYPE_STATUS,
> +               { PDU_CT_BATTERY_STATUS, AVC_CTYPE_STATUS,
>                                         avrcp_handle_ct_battery_status },
> -               { AVRCP_GET_PLAY_STATUS, AVC_CTYPE_STATUS,
> +               { PDU_GET_PLAY_STATUS, AVC_CTYPE_STATUS,
>                                         avrcp_handle_get_play_status },
> -               { AVRCP_REGISTER_NOTIFICATION, AVC_CTYPE_NOTIFY,
> +               { PDU_REGISTER_NOTIFICATION, AVC_CTYPE_NOTIFY,
>                                         avrcp_handle_register_notification },
> -               { AVRCP_REQUEST_CONTINUING, AVC_CTYPE_CONTROL,
> +               { PDU_REQUEST_CONTINUING, AVC_CTYPE_CONTROL,
>                                         avrcp_handle_request_continuing },
> -               { AVRCP_ABORT_CONTINUING, AVC_CTYPE_CONTROL,
> +               { PDU_ABORT_CONTINUING, AVC_CTYPE_CONTROL,
>                                         avrcp_handle_abort_continuing },
>                 { },
>  };
> @@ -1079,7 +1087,7 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
>         pdu->rsvd = 0;
>
>         if (operand_count < AVRCP_HEADER_LENGTH) {
> -               pdu->params[0] = E_INVALID_COMMAND;
> +               pdu->params[0] = STATUS_INVALID_COMMAND;
>                 goto err_metadata;
>         }
>
> @@ -1089,21 +1097,21 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
>         }
>
>         if (!handler || handler->code != *code) {
> -               pdu->params[0] = E_INVALID_COMMAND;
> +               pdu->params[0] = STATUS_INVALID_COMMAND;
>                 goto err_metadata;
>         }
>
>         if (!handler->func) {
> -               pdu->params[0] = E_INVALID_PARAM;
> +               pdu->params[0] = STATUS_INVALID_PARAMETER;
>                 goto err_metadata;
>         }
>
>         *code = handler->func(player, pdu, transaction);
>
>         if (*code != AVC_CTYPE_REJECTED &&
> -                               pdu->pdu_id != AVRCP_GET_ELEMENT_ATTRIBUTES &&
> -                               pdu->pdu_id != AVRCP_REQUEST_CONTINUING &&
> -                               pdu->pdu_id != AVRCP_ABORT_CONTINUING)
> +                               pdu->pdu_id != PDU_GET_ELEMENT_ATTRIBUTES &&
> +                               pdu->pdu_id != PDU_REQUEST_CONTINUING &&
> +                               pdu->pdu_id != PDU_ABORT_CONTINUING)
>                 player_abort_pending_pdu(player);
>
>         return AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
> @@ -1122,7 +1130,7 @@ size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
>
>      *code = AVC_CTYPE_REJECTED;
>      pdu->params_len = htons(1);
> -    pdu->params[0] = E_INTERNAL;
> +    pdu->params[0] = STATUS_INTERNAL_ERROR;
>
>      DBG("rejecting AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
>              pdu->pdu_id, company_id, pdu->params_len);
> @@ -1168,17 +1176,17 @@ static gboolean avrcp_handle_volume_changed(struct avctp *session,
>
>  static void register_volume_notification(struct avrcp_player *player)
>  {
> -       uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH];
> +       uint8_t buf[AVRCP_HEADER_LENGTH + REGISTER_NOTIFICATION_PARAM_LENGTH];
>         struct avrcp_header *pdu = (void *) buf;
>         uint8_t length;
>
>         memset(buf, 0, sizeof(buf));
>
>         set_company_id(pdu->company_id, IEEEID_BTSIG);
> -       pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
> -       pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
> +       pdu->pdu_id = PDU_REGISTER_NOTIFICATION;
> +       pdu->packet_type = PACKET_TYPE_SINGLE;
>         pdu->params[0] = AVRCP_EVENT_VOLUME_CHANGED;
> -       pdu->params_len = htons(AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH);
> +       pdu->params_len = htons(REGISTER_NOTIFICATION_PARAM_LENGTH);
>
>         length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
>
> @@ -1236,7 +1244,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
>
>                 desc = list->data;
>
> -               if (desc && desc->version >= 0x0104)
> +               if (desc && desc->version >= VERSION_1_4)
>                         register_volume_notification(player);
>
>                 sdp_list_free(list, free);
> @@ -1456,7 +1464,7 @@ int avrcp_set_volume(struct audio_device *dev, uint8_t volume)
>
>         set_company_id(pdu->company_id, IEEEID_BTSIG);
>
> -       pdu->pdu_id = AVRCP_SET_ABSOLUTE_VOLUME;
> +       pdu->pdu_id = PDU_SET_ABSOLUTE_VOLUME;
>         pdu->params[0] = volume;
>         pdu->params_len = htons(1);
>
> diff --git a/audio/avrcp.h b/audio/avrcp.h
> index bf11a6c..95f69a5 100644
> --- a/audio/avrcp.h
> +++ b/audio/avrcp.h
> @@ -69,12 +69,17 @@
>  #define AVRCP_PLAY_STATUS_ERROR                0xFF
>
>  /* Notification events */
> -#define AVRCP_EVENT_STATUS_CHANGED     0x01
> -#define AVRCP_EVENT_TRACK_CHANGED      0x02
> -#define AVRCP_EVENT_TRACK_REACHED_END  0x03
> -#define AVRCP_EVENT_TRACK_REACHED_START        0x04
> -#define AVRCP_EVENT_VOLUME_CHANGED     0x0d
> -#define AVRCP_EVENT_LAST               AVRCP_EVENT_VOLUME_CHANGED
> +#define AVRCP_EVENT_PLAYBACK_STATUS_CHANGED    0x01
> +#define AVRCP_EVENT_TRACK_CHANGED              0x02
> +#define AVRCP_EVENT_TRACK_REACHED_END          0x03
> +#define AVRCP_EVENT_TRACK_REACHED_START                0x04
> +#define AVRCP_EVENT_PLAYBACK_POS_CHANGED       0x05
> +#define AVRCP_EVENT_PLAYER_SETTING_CHANGED     0x08
> +#define AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED        0x09
> +#define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED  0x0A
> +#define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED   0x0B
> +#define AVRCP_EVENT_VOLUME_CHANGED             0x0D
> +#define AVRCP_EVENT_LAST                       AVRCP_EVENT_VOLUME_CHANGED
>
>  struct avrcp_player_cb {
>         int (*get_setting) (uint8_t attr, void *user_data);
> diff --git a/audio/media.c b/audio/media.c
> index 1956653..4e23273 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -1414,7 +1414,7 @@ static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
>
>         mp->status = val;
>
> -       avrcp_player_event(mp->player, AVRCP_EVENT_STATUS_CHANGED, &val);
> +       avrcp_player_event(mp->player, AVRCP_EVENT_PLAYBACK_STATUS_CHANGED, &val);
>
>         return TRUE;
>  }
> --

Patches 1-4 are now applied, but I've changed this one quite a bit so
others need rebasing. The reason that I changed this is because I do
actually prefer to prefix when the define comes directly from the spec
and other files such as avdtp.c and avctp.c do already follow this so
no reason to start changing everything.

-- 
Luiz Augusto von Dentz
