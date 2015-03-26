Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427339794-6970-1-git-send-email-armansito@chromium.org>
References: <1427339794-6970-1-git-send-email-armansito@chromium.org>
Date: Thu, 26 Mar 2015 14:44:34 -0700
Message-ID: <CAHrH25QNTVRdF_o4uMt=57qiNsvM03QpxhcEs0YzgXgydgW81w@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/mgmt-tester: Add test cases for AD flags 0-4
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> On Wed, Mar 25, 2015 at 8:16 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch adds unit test cases for the Add Advertising flags 0-4.
> ---
>  tools/mgmt-tester.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 144 insertions(+)
>
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index 5de9967..0721a64 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -797,6 +797,12 @@ static const struct generic_data set_connectable_off_le_test_2 = {
>         .expect_hci_len = sizeof(set_connectable_off_adv_param),
>  };
>
> +static uint16_t settings_powered_le_discoverable[] = {
> +                                       MGMT_OP_SET_LE,
> +                                       MGMT_OP_SET_CONNECTABLE,
> +                                       MGMT_OP_SET_POWERED,
> +                                       MGMT_OP_SET_DISCOVERABLE, 0 };
> +
>  static uint16_t settings_powered_le_discoverable_advertising[] = {
>                                         MGMT_OP_SET_LE,
>                                         MGMT_OP_SET_CONNECTABLE,
> @@ -3800,6 +3806,36 @@ static const uint8_t add_advertising_param_3[] = {
>         0x04, 0xff, 0x01, 0x02, 0x03,
>  };
>
> +static const uint8_t add_advertising_param_4[] = {
> +       0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
> +       0x03, 0x02, 0x0d, 0x18,
> +       0x04, 0xff, 0x01, 0x02, 0x03,
> +};
> +
> +static const uint8_t add_advertising_param_5[] = {
> +       0x01, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
> +       0x03, 0x02, 0x0d, 0x18,
> +       0x04, 0xff, 0x01, 0x02, 0x03,
> +};
> +
> +static const uint8_t add_advertising_param_6[] = {
> +       0x01, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
> +       0x03, 0x02, 0x0d, 0x18,
> +       0x04, 0xff, 0x01, 0x02, 0x03,
> +};
> +
> +static const uint8_t add_advertising_param_7[] = {
> +       0x01, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
> +       0x03, 0x02, 0x0d, 0x18,
> +       0x04, 0xff, 0x01, 0x02, 0x03,
> +};
> +
> +static const uint8_t add_advertising_param_8[] = {
> +       0x01, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
> +       0x03, 0x02, 0x0d, 0x18,
> +       0x04, 0xff, 0x01, 0x02, 0x03,
> +};
> +
>  static const uint8_t advertising_instance_param[] = {
>         0x01,
>  };
> @@ -3832,6 +3868,34 @@ static const uint8_t set_adv_data_4[] = {
>         0x00, 0x00,
>  };
>
> +static const uint8_t set_adv_data_5[] = {
> +       0x0c, 0x02, 0x01, 0x02, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff,
> +       0x01, 0x02, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +       0x00, 0x00,
> +};
> +
> +static const uint8_t set_adv_data_6[] = {
> +       0x0c, 0x02, 0x01, 0x01, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff,
> +       0x01, 0x02, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +       0x00, 0x00,
> +};
> +
> +static const uint8_t set_adv_data_7[] = {
> +       0x0c, 0x02, 0x01, 0x02, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff,
> +       0x01, 0x02, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +       0x00, 0x00,
> +};
> +
> +static const uint8_t set_adv_data_8[] = {
> +       0x0c, 0x02, 0x0a, 0x00, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff,
> +       0x01, 0x02, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +       0x00, 0x00,
> +};
> +
>  static const uint8_t set_scan_rsp_1[] = {
>         0x0a, 0x03, 0x19, 0x40, 0x03, 0x05, 0x03, 0x0d, 0x18, 0x0f,
>         0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> @@ -4105,6 +4169,71 @@ static const struct generic_data add_advertising_success_7 = {
>         .expect_hci_len = sizeof(set_scan_rsp_1),
>  };
>
> +static const struct generic_data add_advertising_success_8 = {
> +       .setup_settings = settings_powered_le,
> +       .send_opcode = MGMT_OP_ADD_ADVERTISING,
> +       .send_param = add_advertising_param_4,
> +       .send_len = sizeof(add_advertising_param_4),
> +       .expect_param = advertising_instance_param,
> +       .expect_len = sizeof(advertising_instance_param),
> +       .expect_status = MGMT_STATUS_SUCCESS,
> +       .expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
> +       .expect_hci_param = set_connectable_on_adv_param,
> +       .expect_hci_len = sizeof(set_connectable_on_adv_param),
> +};
> +
> +static const struct generic_data add_advertising_success_9 = {
> +       .setup_settings = settings_powered_le,
> +       .send_opcode = MGMT_OP_ADD_ADVERTISING,
> +       .send_param = add_advertising_param_5,
> +       .send_len = sizeof(add_advertising_param_5),
> +       .expect_param = advertising_instance_param,
> +       .expect_len = sizeof(advertising_instance_param),
> +       .expect_status = MGMT_STATUS_SUCCESS,
> +       .expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
> +       .expect_hci_param = set_adv_data_5,
> +       .expect_hci_len = sizeof(set_adv_data_5),
> +};
> +
> +static const struct generic_data add_advertising_success_10 = {
> +       .setup_settings = settings_powered_le,
> +       .send_opcode = MGMT_OP_ADD_ADVERTISING,
> +       .send_param = add_advertising_param_6,
> +       .send_len = sizeof(add_advertising_param_6),
> +       .expect_param = advertising_instance_param,
> +       .expect_len = sizeof(advertising_instance_param),
> +       .expect_status = MGMT_STATUS_SUCCESS,
> +       .expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
> +       .expect_hci_param = set_adv_data_6,
> +       .expect_hci_len = sizeof(set_adv_data_6),
> +};
> +
> +static const struct generic_data add_advertising_success_11 = {
> +       .setup_settings = settings_powered_le_discoverable,
> +       .send_opcode = MGMT_OP_ADD_ADVERTISING,
> +       .send_param = add_advertising_param_7,
> +       .send_len = sizeof(add_advertising_param_7),
> +       .expect_param = advertising_instance_param,
> +       .expect_len = sizeof(advertising_instance_param),
> +       .expect_status = MGMT_STATUS_SUCCESS,
> +       .expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
> +       .expect_hci_param = set_adv_data_7,
> +       .expect_hci_len = sizeof(set_adv_data_7),
> +};
> +
> +static const struct generic_data add_advertising_success_12 = {
> +       .setup_settings = settings_powered_le_discoverable,
> +       .send_opcode = MGMT_OP_ADD_ADVERTISING,
> +       .send_param = add_advertising_param_8,
> +       .send_len = sizeof(add_advertising_param_8),
> +       .expect_param = advertising_instance_param,
> +       .expect_len = sizeof(advertising_instance_param),
> +       .expect_status = MGMT_STATUS_SUCCESS,
> +       .expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
> +       .expect_hci_param = set_adv_data_8,
> +       .expect_hci_len = sizeof(set_adv_data_8),
> +};
> +
>  static const char set_powered_off_le_settings_param[] = {
>         0x80, 0x02, 0x00, 0x00
>  };
> @@ -6057,6 +6186,21 @@ int main(int argc, char *argv[])
>         test_bredrle("Add Advertising - Success 5",
>                                         &add_advertising_success_7,
>                                         NULL, test_command_generic);
> +       test_bredrle("Add Advertising - Success 6 - Flag 0",
> +                                       &add_advertising_success_8,
> +                                       NULL, test_command_generic);
> +       test_bredrle("Add Advertising - Success 7 - Flag 1",
> +                                       &add_advertising_success_9,
> +                                       NULL, test_command_generic);
> +       test_bredrle("Add Advertising - Success 8 - Flag 2",
> +                                       &add_advertising_success_10,
> +                                       NULL, test_command_generic);
> +       test_bredrle("Add Advertising - Success 8 - Flag 3",
> +                                       &add_advertising_success_11,
> +                                       NULL, test_command_generic);
> +       test_bredrle("Add Advertising - Success 9 - Flag 4",
> +                                       &add_advertising_success_12,
> +                                       NULL, test_command_generic);
>
>         test_bredrle("Remove Advertising - Invalid Params 1",
>                                         &remove_advertising_fail_1,
> --
> 2.2.0.rc0.207.ga3a616c
>

Both patches in this series have been applied.

Thanks,
Arman
