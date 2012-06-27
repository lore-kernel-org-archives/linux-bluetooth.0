Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
References: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
Date: Wed, 27 Jun 2012 16:32:39 +0300
Message-ID: <CABBYNZ+QhVLY+Yr6qH92HO0k0SYGtWiGaEfmAnuou_05g7XqDQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] AVRCP: Update constants
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, lucas.demarchi@profusion.mob,
	johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Wed, Jun 27, 2012 at 4:27 PM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> Change all specification constants to enum type.
> Also add constants for addressed player feature.
> ---
>  audio/avrcp.c |  151 ++++++++++++++++++++++++++++++++-------------------------
>  audio/avrcp.h |  107 ++++++++++++++++++++++------------------
>  audio/media.c |    2 +-
>  3 files changed, 146 insertions(+), 114 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 89ee112..da102b2 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -58,56 +58,73 @@
>  #include "sdpd.h"
>  #include "dbus-common.h"
>
> -/* Company IDs for vendor dependent commands */
> -#define IEEEID_BTSIG           0x001958
> -
> -/* Error codes for metadata transfer */
> -#define E_INVALID_COMMAND      0x00
> -#define E_INVALID_PARAM                0x01
> -#define E_PARAM_NOT_FOUND      0x02
> -#define E_INTERNAL             0x03
> -
> -/* Packet types */
> -#define AVRCP_PACKET_TYPE_SINGLE       0x00
> -#define AVRCP_PACKET_TYPE_START                0x01
> -#define AVRCP_PACKET_TYPE_CONTINUING   0x02
> -#define AVRCP_PACKET_TYPE_END          0x03
> -
> -/* PDU types for metadata transfer */
> -#define AVRCP_GET_CAPABILITIES         0x10
> -#define AVRCP_LIST_PLAYER_ATTRIBUTES   0X11
> -#define AVRCP_LIST_PLAYER_VALUES       0x12
> -#define AVRCP_GET_CURRENT_PLAYER_VALUE 0x13
> -#define AVRCP_SET_PLAYER_VALUE         0x14
> -#define AVRCP_GET_PLAYER_ATTRIBUTE_TEXT        0x15
> -#define AVRCP_GET_PLAYER_VALUE_TEXT    0x16
> -#define AVRCP_DISPLAYABLE_CHARSET      0x17
> -#define AVRCP_CT_BATTERY_STATUS                0x18
> -#define AVRCP_GET_ELEMENT_ATTRIBUTES   0x20
> -#define AVRCP_GET_PLAY_STATUS          0x30
> -#define AVRCP_REGISTER_NOTIFICATION    0x31
> -#define AVRCP_REQUEST_CONTINUING       0x40
> -#define AVRCP_ABORT_CONTINUING         0x41
> -#define AVRCP_SET_ABSOLUTE_VOLUME      0x50
> -
> -/* Capabilities for AVRCP_GET_CAPABILITIES pdu */
> -#define CAP_COMPANY_ID         0x02
> -#define CAP_EVENTS_SUPPORTED   0x03
> -
>  #define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH 5
>
> -#define AVRCP_FEATURE_CATEGORY_1       0x0001
> -#define AVRCP_FEATURE_CATEGORY_2       0x0002
> -#define AVRCP_FEATURE_CATEGORY_3       0x0004
> -#define AVRCP_FEATURE_CATEGORY_4       0x0008
> -#define AVRCP_FEATURE_PLAYER_SETTINGS  0x0010
> +enum company_id {
> +       IEEEID_BTSIG     = 0x001958
> +};
> +
> +enum status_code {
> +       STATUS_INVALID_COMMAND          = 0x00,
> +       STATUS_INVALID_PARAMETER        = 0x01,
> +       STATUS_INTERNAL_ERROR           = 0x03,
> +       STATUS_OK                       = 0x04,
> +       STATUS_INVALID_PLAYER_ID        = 0x11,
> +       STATUS_NO_AVAILABLE_PLAYERS     = 0x15,
> +       STATUS_ADDRESSED_PLAYER_CHANGED = 0x16
> +};
> +
> +enum packet_type {
> +       AVRCP_PACKET_TYPE_SINGLE        = 0x00,
> +       AVRCP_PACKET_TYPE_START         = 0x01,
> +       AVRCP_PACKET_TYPE_CONTINUING    = 0x02,
> +       AVRCP_PACKET_TYPE_END           = 0x03
> +};
> +
> +enum control_pdu_ieeeid_btsig {
> +       AVRCP_GET_CAPABILITIES          = 0x10,
> +       AVRCP_LIST_PLAYER_ATTRIBUTES    = 0X11,
> +       AVRCP_LIST_PLAYER_VALUES        = 0x12,
> +       AVRCP_GET_CURRENT_PLAYER_VALUE  = 0x13,
> +       AVRCP_SET_PLAYER_VALUE          = 0x14,
> +       AVRCP_GET_PLAYER_ATTRIBUTE_TEXT = 0x15,
> +       AVRCP_GET_PLAYER_VALUE_TEXT     = 0x16,
> +       AVRCP_DISPLAYABLE_CHARSET       = 0x17,
> +       AVRCP_CT_BATTERY_STATUS         = 0x18,
> +       AVRCP_GET_ELEMENT_ATTRIBUTES    = 0x20,
> +       AVRCP_GET_PLAY_STATUS           = 0x30,
> +       AVRCP_REGISTER_NOTIFICATION     = 0x31,
> +       AVRCP_REQUEST_CONTINUING        = 0x40,
> +       AVRCP_ABORT_CONTINUING          = 0x41,
> +       AVRCP_SET_ABSOLUTE_VOLUME       = 0x50,
> +       AVRCP_SET_ADDRESSED_PLAYER      = 0x60,
> +};
> +
> +enum capability {
> +       CAP_COMPANY_ID          = 0x02,
> +       CAP_EVENTS_SUPPORTED    = 0x03
> +};
> +
> +enum sdp_feature {
> +       AVRCP_FEATURE_CATEGORY_1        = 0x0001,
> +       AVRCP_FEATURE_CATEGORY_2        = 0x0002,
> +       AVRCP_FEATURE_CATEGORY_3        = 0x0004,
> +       AVRCP_FEATURE_CATEGORY_4        = 0x0008,
> +       AVRCP_FEATURE_PLAYER_SETTINGS   = 0x0010,
> +};
>
>  enum battery_status {
> -       BATTERY_STATUS_NORMAL =         0,
> -       BATTERY_STATUS_WARNING =        1,
> -       BATTERY_STATUS_CRITICAL =       2,
> -       BATTERY_STATUS_EXTERNAL =       3,
> -       BATTERY_STATUS_FULL_CHARGE =    4,
> +       BATTERY_STATUS_NORMAL           = 0,
> +       BATTERY_STATUS_WARNING          = 1,
> +       BATTERY_STATUS_CRITICAL         = 2,
> +       BATTERY_STATUS_EXTERNAL         = 3,
> +       BATTERY_STATUS_FULL_CHARGE      = 4
> +};
> +
> +enum avrcp_version {
> +       AVRCP_VERSION_UNKNOWN   = 0x0000,
> +       AVRCP_VERSION_1_3       = 0x0103,
> +       AVRCP_VERSION_1_4       = 0x0104
>  };
>
>  #if __BYTE_ORDER == __LITTLE_ENDIAN
> @@ -396,7 +413,7 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
>        DBG("id=%u", id);
>
>        switch (id) {
> -       case AVRCP_EVENT_STATUS_CHANGED:
> +       case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
>                size = 2;
>                pdu->params[1] = *((uint8_t *)data);
>
> @@ -581,7 +598,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
>                return AVC_CTYPE_STABLE;
>        case CAP_EVENTS_SUPPORTED:
>                pdu->params[1] = 4;
> -               pdu->params[2] = AVRCP_EVENT_STATUS_CHANGED;
> +               pdu->params[2] = AVRCP_EVENT_PLAYBACK_STATUS_CHANGED;
>                pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
>                pdu->params[4] = AVRCP_EVENT_TRACK_REACHED_START;
>                pdu->params[5] = AVRCP_EVENT_TRACK_REACHED_END;
> @@ -592,7 +609,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
>
>  err:
>        pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>
>        return AVC_CTYPE_REJECTED;
>  }
> @@ -606,7 +623,7 @@ static uint8_t avrcp_handle_list_player_attributes(struct avrcp_player *player,
>
>        if (len != 0) {
>                pdu->params_len = htons(1);
> -               pdu->params[0] = E_INVALID_PARAM;
> +               pdu->params[0] = STATUS_INVALID_PARAMETER;
>                return AVC_CTYPE_REJECTED;
>        }
>
> @@ -653,7 +670,7 @@ static uint8_t avrcp_handle_list_player_values(struct avrcp_player *player,
>
>  err:
>        pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>        return AVC_CTYPE_REJECTED;
>  }
>
> @@ -724,7 +741,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
>        return AVC_CTYPE_STABLE;
>  err:
>        pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>        return AVC_CTYPE_REJECTED;
>  }
>
> @@ -781,7 +798,7 @@ static uint8_t avrcp_handle_get_current_player_value(struct avrcp_player *player
>
>  err:
>        pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>
>        return AVC_CTYPE_REJECTED;
>  }
> @@ -802,7 +819,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
>         * and set the existent ones. Sec. 5.2.4 is not clear however how to
>         * indicate that a certain ID was not accepted. If at least one
>         * attribute is valid, we respond with no parameters. Otherwise an
> -        * E_INVALID_PARAM is sent.
> +        * STATUS_INVALID_PARAMETER is sent.
>         */
>        for (len = 0, i = 0, param = &pdu->params[1]; i < pdu->params[0];
>                                                        i++, param += 2) {
> @@ -820,7 +837,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp_player *player,
>
>  err:
>        pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>        return AVC_CTYPE_REJECTED;
>  }
>
> @@ -832,7 +849,7 @@ static uint8_t avrcp_handle_displayable_charset(struct avrcp_player *player,
>
>        if (len < 3) {
>                pdu->params_len = htons(1);
> -               pdu->params[0] = E_INVALID_PARAM;
> +               pdu->params[0] = STATUS_INVALID_PARAMETER;
>                return AVC_CTYPE_REJECTED;
>        }
>
> @@ -864,7 +881,7 @@ static uint8_t avrcp_handle_ct_battery_status(struct avrcp_player *player,
>
>  err:
>        pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>        return AVC_CTYPE_REJECTED;
>  }
>
> @@ -879,7 +896,7 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp_player *player,
>
>        if (len != 0) {
>                pdu->params_len = htons(1);
> -               pdu->params[0] = E_INVALID_PARAM;
> +               pdu->params[0] = STATUS_INVALID_PARAMETER;
>                return AVC_CTYPE_REJECTED;
>        }
>
> @@ -918,7 +935,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
>                goto err;
>
>        switch (pdu->params[0]) {
> -       case AVRCP_EVENT_STATUS_CHANGED:
> +       case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
>                len = 2;
>                pdu->params[1] = player->cb->get_status(player->user_data);
>
> @@ -948,7 +965,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
>
>  err:
>        pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>        return AVC_CTYPE_REJECTED;
>  }
>
> @@ -988,7 +1005,7 @@ static uint8_t avrcp_handle_request_continuing(struct avrcp_player *player,
>        return AVC_CTYPE_STABLE;
>  err:
>        pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>        return AVC_CTYPE_REJECTED;
>  }
>
> @@ -1014,7 +1031,7 @@ static uint8_t avrcp_handle_abort_continuing(struct avrcp_player *player,
>
>  err:
>        pdu->params_len = htons(1);
> -       pdu->params[0] = E_INVALID_PARAM;
> +       pdu->params[0] = STATUS_INVALID_PARAMETER;
>        return AVC_CTYPE_REJECTED;
>  }
>
> @@ -1079,7 +1096,7 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
>        pdu->rsvd = 0;
>
>        if (operand_count < AVRCP_HEADER_LENGTH) {
> -               pdu->params[0] = E_INVALID_COMMAND;
> +               pdu->params[0] = STATUS_INVALID_COMMAND;
>                goto err_metadata;
>        }
>
> @@ -1089,12 +1106,12 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
>        }
>
>        if (!handler || handler->code != *code) {
> -               pdu->params[0] = E_INVALID_COMMAND;
> +               pdu->params[0] = STATUS_INVALID_COMMAND;
>                goto err_metadata;
>        }
>
>        if (!handler->func) {
> -               pdu->params[0] = E_INVALID_PARAM;
> +               pdu->params[0] = STATUS_INVALID_PARAMETER;
>                goto err_metadata;
>        }
>
> @@ -1122,7 +1139,7 @@ size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
>
>     *code = AVC_CTYPE_REJECTED;
>     pdu->params_len = htons(1);
> -    pdu->params[0] = E_INTERNAL;
> +    pdu->params[0] = STATUS_INTERNAL_ERROR;
>
>     DBG("rejecting AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
>             pdu->pdu_id, company_id, pdu->params_len);
> @@ -1236,7 +1253,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
>
>                desc = list->data;
>
> -               if (desc && desc->version >= 0x0104)
> +               if (desc && desc->version >= AVRCP_VERSION_1_4)
>                        register_volume_notification(player);
>
>                sdp_list_free(list, free);
> diff --git a/audio/avrcp.h b/audio/avrcp.h
> index bf11a6c..dcc67f6 100644
> --- a/audio/avrcp.h
> +++ b/audio/avrcp.h
> @@ -22,59 +22,74 @@
>  *
>  */
>
> -/* player attributes */
> -#define AVRCP_ATTRIBUTE_ILEGAL         0x00
> -#define AVRCP_ATTRIBUTE_EQUALIZER      0x01
> -#define AVRCP_ATTRIBUTE_REPEAT_MODE    0x02
> -#define AVRCP_ATTRIBUTE_SHUFFLE                0x03
> -#define AVRCP_ATTRIBUTE_SCAN           0x04
> +enum player_attribute {
> +       AVRCP_ATTRIBUTE_ILEGAL          = 0x00,
> +       AVRCP_ATTRIBUTE_EQUALIZER       = 0x01,
> +       AVRCP_ATTRIBUTE_REPEAT_MODE     = 0x02,
> +       AVRCP_ATTRIBUTE_SHUFFLE         = 0x03,
> +       AVRCP_ATTRIBUTE_SCAN            = 0x04
> +};
>
> -/* equalizer values */
> -#define AVRCP_EQUALIZER_OFF            0x01
> -#define AVRCP_EQUALIZER_ON             0x02
> +enum equalizer_value {
> +       AVRCP_EQUALIZER_OFF             = 0x01,
> +       AVRCP_EQUALIZER_ON              = 0x02
> +};
>
> -/* repeat mode values */
> -#define AVRCP_REPEAT_MODE_OFF          0x01
> -#define AVRCP_REPEAT_MODE_SINGLE       0x02
> -#define AVRCP_REPEAT_MODE_ALL          0x03
> -#define AVRCP_REPEAT_MODE_GROUP                0x04
> +enum repeat_mode_value {
> +       AVRCP_REPEAT_MODE_OFF           = 0x01,
> +       AVRCP_REPEAT_MODE_SINGLE        = 0x02,
> +       AVRCP_REPEAT_MODE_ALL           = 0x03,
> +       AVRCP_REPEAT_MODE_GROUP         = 0x04
> +};
>
> -/* shuffle values */
> -#define AVRCP_SHUFFLE_OFF              0x01
> -#define AVRCP_SHUFFLE_ALL              0x02
> -#define AVRCP_SHUFFLE_GROUP            0x03
> +enum shuffle_value {
> +       AVRCP_SHUFFLE_OFF               = 0x01,
> +       AVRCP_SHUFFLE_ALL               = 0x02,
> +       AVRCP_SHUFFLE_GROUP             = 0x03
> +};
>
> -/* scan values */
> -#define AVRCP_SCAN_OFF                 0x01
> -#define AVRCP_SCAN_ALL                 0x02
> -#define AVRCP_SCAN_GROUP               0x03
> +enum scan_value {
> +       AVRCP_SCAN_OFF                  = 0x01,
> +       AVRCP_SCAN_ALL                  = 0x02,
> +       AVRCP_SCAN_GROUP                = 0x03
> +};
>
> -/* media attributes */
> -#define AVRCP_MEDIA_ATTRIBUTE_ILLEGAL  0x00
> -#define AVRCP_MEDIA_ATTRIBUTE_TITLE    0x01
> -#define AVRCP_MEDIA_ATTRIBUTE_ARTIST   0x02
> -#define AVRCP_MEDIA_ATTRIBUTE_ALBUM    0x03
> -#define AVRCP_MEDIA_ATTRIBUTE_TRACK    0x04
> -#define AVRCP_MEDIA_ATTRIBUTE_N_TRACKS 0x05
> -#define AVRCP_MEDIA_ATTRIBUTE_GENRE    0x06
> -#define AVRCP_MEDIA_ATTRIBUTE_DURATION 0x07
> -#define AVRCP_MEDIA_ATTRIBUTE_LAST     AVRCP_MEDIA_ATTRIBUTE_DURATION
> +enum media_attribute {
> +       AVRCP_MEDIA_ATTRIBUTE_ILLEGAL   = 0x00,
> +       AVRCP_MEDIA_ATTRIBUTE_TITLE     = 0x01,
> +       AVRCP_MEDIA_ATTRIBUTE_ARTIST    = 0x02,
> +       AVRCP_MEDIA_ATTRIBUTE_ALBUM     = 0x03,
> +       AVRCP_MEDIA_ATTRIBUTE_TRACK     = 0x04,
> +       AVRCP_MEDIA_ATTRIBUTE_N_TRACKS  = 0x05,
> +       AVRCP_MEDIA_ATTRIBUTE_GENRE     = 0x06,
> +       AVRCP_MEDIA_ATTRIBUTE_DURATION  = 0x07,
> +       AVRCP_MEDIA_ATTRIBUTE_LAST      = AVRCP_MEDIA_ATTRIBUTE_DURATION
> +};
>
> -/* play status */
> -#define AVRCP_PLAY_STATUS_STOPPED      0x00
> -#define AVRCP_PLAY_STATUS_PLAYING      0x01
> -#define AVRCP_PLAY_STATUS_PAUSED       0x02
> -#define AVRCP_PLAY_STATUS_FWD_SEEK     0x03
> -#define AVRCP_PLAY_STATUS_REV_SEEK     0x04
> -#define AVRCP_PLAY_STATUS_ERROR                0xFF
> +enum play_status {
> +       AVRCP_PLAY_STATUS_STOPPED       = 0x00,
> +       AVRCP_PLAY_STATUS_PLAYING       = 0x01,
> +       AVRCP_PLAY_STATUS_PAUSED        = 0x02,
> +       AVRCP_PLAY_STATUS_FWD_SEEK      = 0x03,
> +       AVRCP_PLAY_STATUS_REV_SEEK      = 0x04,
> +       AVRCP_PLAY_STATUS_ERROR         = 0xFF
> +};
>
> -/* Notification events */
> -#define AVRCP_EVENT_STATUS_CHANGED     0x01
> -#define AVRCP_EVENT_TRACK_CHANGED      0x02
> -#define AVRCP_EVENT_TRACK_REACHED_END  0x03
> -#define AVRCP_EVENT_TRACK_REACHED_START        0x04
> -#define AVRCP_EVENT_VOLUME_CHANGED     0x0d
> -#define AVRCP_EVENT_LAST               AVRCP_EVENT_VOLUME_CHANGED
> +enum notification_event {
> +       AVRCP_EVENT_PLAYBACK_STATUS_CHANGED             = 0x01,
> +       AVRCP_EVENT_TRACK_CHANGED                       = 0x02,
> +       AVRCP_EVENT_TRACK_REACHED_END                   = 0x03,
> +       AVRCP_EVENT_TRACK_REACHED_START                 = 0x04,
> +       AVRCP_EVENT_PLAYBACK_POS_CHANGED                = 0x05,
> +       AVRCP_EVENT_BATT_STATUS_CHANGED                 = 0x06,
> +       AVRCP_EVENT_SYSTEM_STATUS_CHANGED               = 0x07,
> +       AVRCP_EVENT_PLAYER_APPLICATION_SETTING_CHANGED  = 0x08,
> +       AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED         = 0x09,
> +       AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED           = 0x0A,
> +       AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED            = 0x0B,
> +       AVRCP_EVENT_VOLUME_CHANGED                      = 0x0D,
> +       AVRCP_EVENT_LAST                                = AVRCP_EVENT_VOLUME_CHANGED
> +};
>
>  struct avrcp_player_cb {
>        int (*get_setting) (uint8_t attr, void *user_data);
> diff --git a/audio/media.c b/audio/media.c
> index 1956653..4e23273 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -1414,7 +1414,7 @@ static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
>
>        mp->status = val;
>
> -       avrcp_player_event(mp->player, AVRCP_EVENT_STATUS_CHANGED, &val);
> +       avrcp_player_event(mp->player, AVRCP_EVENT_PLAYBACK_STATUS_CHANGED, &val);
>
>        return TRUE;
>  }
> --
> on behalf of ST-Ericsson
>

Haven't I nak the changes to enum before? What have you changed in v2?

-- 
Luiz Augusto von Dentz
