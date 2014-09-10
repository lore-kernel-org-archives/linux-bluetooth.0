Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1410292644-23497-5-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1410292644-23497-5-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 10 Sep 2014 10:24:51 +0300
Message-ID: <CABBYNZ+3L-=GyVBU92NFfi9BCs0d37RDPDAj+cZLk=p+Ec_Vww@mail.gmail.com>
Subject: Re: [PATCH 04/39] android/avrcp: Clean up command order
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Sep 9, 2014 at 10:56 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Idea about order in this file is that commands goes first and
> notifications in the end of file.
>
> This patch moves AVRCP commands up in the file

I guess you need to be consistent with the ID, so AVRCP should be in
between HEALTH and GATT, btw I have no idea why this is mixup in a
patch-set for HFP client.

> ---
>  android/hal-msg.h | 206 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 102 insertions(+), 104 deletions(-)
>
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 8adb9f1..5575d93 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -871,6 +871,108 @@ struct hal_cmd_gatt_server_send_response {
>         uint8_t data[0];
>  } __attribute__((packed));
>
> +#define HAL_AVRCP_PLAY_STATUS_STOPPED  0x00
> +#define HAL_AVRCP_PLAY_STATUS_PLAYING  0x01
> +#define HAL_AVRCP_PLAY_STATUS_PAUSED   0x02
> +#define HAL_AVRCP_PLAY_STATUS_FWD_SEEK 0x03
> +#define HAL_AVRCP_PLAY_STATUS_REV_SEEK 0x04
> +#define HAL_AVRCP_PLAY_STATUS_ERROR    0xff
> +
> +#define HAL_OP_AVRCP_GET_PLAY_STATUS   0x01
> +struct hal_cmd_avrcp_get_play_status {
> +       uint8_t status;
> +       uint32_t duration;
> +       uint32_t position;
> +} __attribute__((packed));
> +
> +#define HAL_AVRCP_PLAYER_ATTR_EQUALIZER        0x01
> +#define HAL_AVRCP_PLAYER_ATTR_REPEAT   0x02
> +#define HAL_AVRCP_PLAYER_ATTR_SHUFFLE  0x03
> +#define HAL_AVRCP_PLAYER_ATTR_SCAN     0x04
> +
> +#define HAL_OP_AVRCP_LIST_PLAYER_ATTRS 0x02
> +struct hal_cmd_avrcp_list_player_attrs {
> +       uint8_t number;
> +       uint8_t attrs[0];
> +} __attribute__((packed));
> +
> +#define HAL_OP_AVRCP_LIST_PLAYER_VALUES        0x03
> +struct hal_cmd_avrcp_list_player_values {
> +       uint8_t number;
> +       uint8_t values[0];
> +} __attribute__((packed));
> +
> +struct hal_avrcp_player_attr_value {
> +       uint8_t attr;
> +       uint8_t value;
> +} __attribute__((packed));
> +
> +#define HAL_OP_AVRCP_GET_PLAYER_ATTRS  0x04
> +struct hal_cmd_avrcp_get_player_attrs {
> +       uint8_t number;
> +       struct hal_avrcp_player_attr_value attrs[0];
> +} __attribute__((packed));
> +
> +struct hal_avrcp_player_setting_text {
> +       uint8_t id;
> +       uint8_t len;
> +       uint8_t text[0];
> +} __attribute__((packed));
> +
> +#define HAL_OP_AVRCP_GET_PLAYER_ATTRS_TEXT     0x05
> +struct hal_cmd_avrcp_get_player_attrs_text {
> +       uint8_t number;
> +       struct hal_avrcp_player_setting_text attrs[0];
> +} __attribute__((packed));
> +
> +#define HAL_OP_AVRCP_GET_PLAYER_VALUES_TEXT    0x06
> +struct hal_cmd_avrcp_get_player_values_text {
> +       uint8_t number;
> +       struct hal_avrcp_player_setting_text values[0];
> +} __attribute__((packed));
> +
> +#define HAL_AVRCP_MEDIA_ATTR_TITLE             0x01
> +#define HAL_AVRCP_MEDIA_ATTR_ARTIST            0x02
> +#define HAL_AVRCP_MEDIA_ATTR_ALBUM             0x03
> +#define HAL_AVRCP_MEDIA_ATTR_TRACK_NUM         0x04
> +#define HAL_AVRCP_MEDIA_ATTR_NUM_TRACKS                0x05
> +#define HAL_AVRCP_MEDIA_ATTR_GENRE             0x06
> +#define HAL_AVRCP_MEDIA_ATTR_DURATION          0x07
> +
> +#define HAL_OP_AVRCP_GET_ELEMENT_ATTRS_TEXT    0x07
> +struct hal_cmd_avrcp_get_element_attrs_text {
> +       uint8_t number;
> +       struct hal_avrcp_player_setting_text values[0];
> +} __attribute__((packed));
> +
> +#define HAL_OP_AVRCP_SET_PLAYER_ATTRS_VALUE    0x08
> +struct hal_cmd_avrcp_set_player_attrs_value {
> +       uint8_t status;
> +} __attribute__((packed));
> +
> +#define HAL_AVRCP_EVENT_STATUS_CHANGED         0x01
> +#define HAL_AVRCP_EVENT_TRACK_CHANGED          0x02
> +#define HAL_AVRCP_EVENT_TRACK_REACHED_END      0x03
> +#define HAL_AVRCP_EVENT_TRACK_REACHED_START    0x04
> +#define HAL_AVRCP_EVENT_POSITION_CHANGED       0x05
> +#define HAL_AVRCP_EVENT_SETTING_CHANGED                0x08
> +
> +#define HAL_AVRCP_EVENT_TYPE_INTERIM           0x00
> +#define HAL_AVRCP_EVENT_TYPE_CHANGED           0x01
> +
> +#define HAL_OP_AVRCP_REGISTER_NOTIFICATION     0x09
> +struct hal_cmd_avrcp_register_notification {
> +       uint8_t event;
> +       uint8_t type;
> +       uint8_t len;
> +       uint8_t data[0];
> +} __attribute__((packed));
> +
> +#define HAL_OP_AVRCP_SET_VOLUME                        0x0a
> +struct hal_cmd_avrcp_set_volume {
> +       uint8_t value;
> +} __attribute__((packed));
> +
>  /* Notifications and confirmations */
>
>  #define HAL_POWER_OFF                  0x00
> @@ -1174,110 +1276,6 @@ struct hal_ev_handsfree_unknown_at {
>
>  #define HAL_EV_HANDSFREE_HSP_KEY_PRESS 0x90
>
> -/* AVRCP HAL API */
> -
> -#define HAL_AVRCP_PLAY_STATUS_STOPPED  0x00
> -#define HAL_AVRCP_PLAY_STATUS_PLAYING  0x01
> -#define HAL_AVRCP_PLAY_STATUS_PAUSED   0x02
> -#define HAL_AVRCP_PLAY_STATUS_FWD_SEEK 0x03
> -#define HAL_AVRCP_PLAY_STATUS_REV_SEEK 0x04
> -#define HAL_AVRCP_PLAY_STATUS_ERROR    0xff
> -
> -#define HAL_OP_AVRCP_GET_PLAY_STATUS   0x01
> -struct hal_cmd_avrcp_get_play_status {
> -       uint8_t status;
> -       uint32_t duration;
> -       uint32_t position;
> -} __attribute__((packed));
> -
> -#define HAL_AVRCP_PLAYER_ATTR_EQUALIZER        0x01
> -#define HAL_AVRCP_PLAYER_ATTR_REPEAT   0x02
> -#define HAL_AVRCP_PLAYER_ATTR_SHUFFLE  0x03
> -#define HAL_AVRCP_PLAYER_ATTR_SCAN     0x04
> -
> -#define HAL_OP_AVRCP_LIST_PLAYER_ATTRS 0x02
> -struct hal_cmd_avrcp_list_player_attrs {
> -       uint8_t number;
> -       uint8_t attrs[0];
> -} __attribute__((packed));
> -
> -#define HAL_OP_AVRCP_LIST_PLAYER_VALUES        0x03
> -struct hal_cmd_avrcp_list_player_values {
> -       uint8_t number;
> -       uint8_t values[0];
> -} __attribute__((packed));
> -
> -struct hal_avrcp_player_attr_value {
> -       uint8_t attr;
> -       uint8_t value;
> -} __attribute__((packed));
> -
> -#define HAL_OP_AVRCP_GET_PLAYER_ATTRS  0x04
> -struct hal_cmd_avrcp_get_player_attrs {
> -       uint8_t number;
> -       struct hal_avrcp_player_attr_value attrs[0];
> -} __attribute__((packed));
> -
> -struct hal_avrcp_player_setting_text {
> -       uint8_t id;
> -       uint8_t len;
> -       uint8_t text[0];
> -} __attribute__((packed));
> -
> -#define HAL_OP_AVRCP_GET_PLAYER_ATTRS_TEXT     0x05
> -struct hal_cmd_avrcp_get_player_attrs_text {
> -       uint8_t number;
> -       struct hal_avrcp_player_setting_text attrs[0];
> -} __attribute__((packed));
> -
> -#define HAL_OP_AVRCP_GET_PLAYER_VALUES_TEXT    0x06
> -struct hal_cmd_avrcp_get_player_values_text {
> -       uint8_t number;
> -       struct hal_avrcp_player_setting_text values[0];
> -} __attribute__((packed));
> -
> -#define HAL_AVRCP_MEDIA_ATTR_TITLE             0x01
> -#define HAL_AVRCP_MEDIA_ATTR_ARTIST            0x02
> -#define HAL_AVRCP_MEDIA_ATTR_ALBUM             0x03
> -#define HAL_AVRCP_MEDIA_ATTR_TRACK_NUM         0x04
> -#define HAL_AVRCP_MEDIA_ATTR_NUM_TRACKS                0x05
> -#define HAL_AVRCP_MEDIA_ATTR_GENRE             0x06
> -#define HAL_AVRCP_MEDIA_ATTR_DURATION          0x07
> -
> -#define HAL_OP_AVRCP_GET_ELEMENT_ATTRS_TEXT    0x07
> -struct hal_cmd_avrcp_get_element_attrs_text {
> -       uint8_t number;
> -       struct hal_avrcp_player_setting_text values[0];
> -} __attribute__((packed));
> -
> -#define HAL_OP_AVRCP_SET_PLAYER_ATTRS_VALUE    0x08
> -struct hal_cmd_avrcp_set_player_attrs_value {
> -       uint8_t status;
> -} __attribute__((packed));
> -
> -#define HAL_AVRCP_EVENT_STATUS_CHANGED         0x01
> -#define HAL_AVRCP_EVENT_TRACK_CHANGED          0x02
> -#define HAL_AVRCP_EVENT_TRACK_REACHED_END      0x03
> -#define HAL_AVRCP_EVENT_TRACK_REACHED_START    0x04
> -#define HAL_AVRCP_EVENT_POSITION_CHANGED       0x05
> -#define HAL_AVRCP_EVENT_SETTING_CHANGED                0x08
> -
> -#define HAL_AVRCP_EVENT_TYPE_INTERIM           0x00
> -#define HAL_AVRCP_EVENT_TYPE_CHANGED           0x01
> -
> -#define HAL_OP_AVRCP_REGISTER_NOTIFICATION     0x09
> -struct hal_cmd_avrcp_register_notification {
> -       uint8_t event;
> -       uint8_t type;
> -       uint8_t len;
> -       uint8_t data[0];
> -} __attribute__((packed));
> -
> -#define HAL_OP_AVRCP_SET_VOLUME                        0x0a
> -struct hal_cmd_avrcp_set_volume {
> -       uint8_t value;
> -} __attribute__((packed));
> -
>  #define HAL_AVRCP_FEATURE_NONE                 0x00
>  #define HAL_AVRCP_FEATURE_METADATA             0x01
>  #define HAL_AVRCP_FEATURE_ABSOLUTE_VOLUME      0x02
> --
> 1.8.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
