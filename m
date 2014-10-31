Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414590440-15101-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1414590440-15101-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Fri, 31 Oct 2014 15:29:53 +0200
Message-ID: <CABBYNZJxVZ79wUsv6Hv0-qrUeraEm2F7kt-qSaBm9+EdieA3UA@mail.gmail.com>
Subject: Re: [PATCH 1/2] android/tester: Add AVRCP RegNotifPlayPositionChanged
 test case
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Wed, Oct 29, 2014 at 3:47 PM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> ---
>  android/tester-avrcp.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  android/tester-main.h  |  5 ++++
>  2 files changed, 68 insertions(+)
>
> diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
> index 7c02ec2..2ff9fa0 100644
> --- a/android/tester-avrcp.c
> +++ b/android/tester-avrcp.c
> @@ -90,6 +90,15 @@ static struct emu_l2cap_cid_data sdp_data = {
>                         0x31, 0x00, 0x00, 0x09, 0x02, 0xFF, 0xFF, 0xFF, 0xFF, \
>                                                         0xFF, 0xFF, 0xFF, 0xFF
>
> +#define req_position_notif 0x00, 0x11, 0x0e, 0x03, 0x48, 0x00, 0x00, 0x19, \
> +                               0x58, 0x31, 0x00, 0x00, 0x05, 0x05, 0x00, \
> +                                                       0x00, 0x00, 0x00
> +
> +#define rsp_position_notif 0x00, 0x11, 0x0e, 0x0F, 0x48, 0x00, 0x00, 0x19, \
> +                               0x58, 0x31, 0x00, 0x00, 0x04, 0x05, 0xFF, \
> +                                                       0xFF, 0xFF, 0xFF
> +
> +
>  #define req_ele_attr 0x00, 0x11, 0x0e, 0x01, 0x48, 0x00, 0x00, 0x19, 0x58, \
>                         0x20, 0x00, 0x00, 0x0D, 0x00, 0x00, 0x00, 0x00, \
>                         0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x07
> @@ -162,6 +171,12 @@ static void avrcp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
>                         step->callback = CB_AVRCP_REG_NOTIF_RSP;
>                         step->callback_result.rc_index = get_be64(data + 14);
>                         schedule_callback_verification(step);
> +               } else if (event == 0x05) {
> +                       step = g_new0(struct step, 1);
> +                       step->callback = CB_AVRCP_REG_NOTIF_RSP;
> +                       step->callback_result.song_position =
> +                                                       get_be32(data + 14);
> +                       schedule_callback_verification(step);

I guess a switch I would be better in the code above and you can
probably use the defines here as well.

>                 }
>                 break;
>         case AVRCP_GET_ELEMENT_ATTRIBUTES:
> @@ -314,6 +329,32 @@ static void avrcp_reg_notif_track_changed_rsp(void)
>         schedule_action_verification(step);
>  }
>
> +static void avrcp_reg_notif_play_position_changed_req(void)
> +{
> +       struct test_data *data = tester_get_data();
> +       struct bthost *bthost = hciemu_client_get_host(data->hciemu);
> +       const struct iovec pdu = raw_pdu(req_position_notif);
> +       struct step *step = g_new0(struct step, 1);
> +
> +       bthost_send_cid_v(bthost, avrcp_data.handle, avrcp_data.cid, &pdu, 1);
> +       step->action_status = BT_STATUS_SUCCESS;
> +       schedule_action_verification(step);
> +}
> +
> +static void avrcp_reg_notif_play_position_changed_rsp(void)
> +{
> +       struct test_data *data = tester_get_data();
> +       struct step *step = g_new0(struct step, 1);
> +       btrc_register_notification_t reg;
> +
> +       reg.song_pos = 0xffffffff;
> +       step->action_status = data->if_avrcp->register_notification_rsp(
> +                                               BTRC_EVT_PLAY_POS_CHANGED,
> +                                       BTRC_NOTIFICATION_TYPE_INTERIM, &reg);
> +
> +       schedule_action_verification(step);
> +}
> +
>  static void avrcp_get_element_attributes_req(void)
>  {
>         struct test_data *data = tester_get_data();
> @@ -424,6 +465,28 @@ static struct test_case test_cases[] = {
>                 ACTION_SUCCESS(bluetooth_disable_action, NULL),
>                 CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
>         ),
> +       TEST_CASE_BREDRLE("AVRCP RegNotifPlayPositionChanged - Success",
> +               ACTION_SUCCESS(bluetooth_enable_action, NULL),
> +               CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
> +               ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
> +               ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
> +               ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
> +               ACTION_SUCCESS(emu_add_l2cap_server_action, &sdp_setup_data),
> +               ACTION_SUCCESS(emu_add_l2cap_server_action, &a2dp_setup_data),
> +               ACTION_SUCCESS(emu_add_l2cap_server_action, &avrcp_setup_data),
> +               ACTION_SUCCESS(avrcp_connect_action, NULL),
> +               CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
> +                                       BTAV_CONNECTION_STATE_CONNECTING),
> +               CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
> +                                       BTAV_CONNECTION_STATE_CONNECTED),
> +               ACTION_SUCCESS(avrcp_reg_notif_play_position_changed_req, NULL),
> +               CALLBACK(CB_AVRCP_REG_NOTIF_REQ),
> +               ACTION_SUCCESS(avrcp_reg_notif_play_position_changed_rsp, NULL),
> +               CALLBACK_RC_REG_NOTIF_POSITION_CHANGED(CB_AVRCP_REG_NOTIF_RSP,
> +                                                               0xffffffff),
> +               ACTION_SUCCESS(bluetooth_disable_action, NULL),
> +               CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
> +       ),
>         TEST_CASE_BREDRLE("AVRCP GetElementAttributes - Success",
>                 ACTION_SUCCESS(bluetooth_enable_action, NULL),
>                 CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
> diff --git a/android/tester-main.h b/android/tester-main.h
> index ac310a3..1a779a2 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -409,6 +409,11 @@ struct pdu_set {
>                 .callback_result.rc_index = cb_index, \
>         }
>
> +#define CALLBACK_RC_REG_NOTIF_POSITION_CHANGED(cb, cb_position) { \
> +               .callback = cb, \
> +               .callback_result.song_position = cb_position, \
> +       }
> +
>  #define CALLBACK_RC_GET_ELEMENT_ATTRIBUTES(cb, cb_num_of_attrs, cb_attrs) { \
>                 .callback = cb, \
>                 .callback_result.num_of_attrs = cb_num_of_attrs, \
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
