Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427572441-31225-1-git-send-email-armansito@chromium.org>
References: <1427572441-31225-1-git-send-email-armansito@chromium.org>
Date: Sat, 28 Mar 2015 14:32:00 -0700
Message-ID: <CAHrH25SxyqyCncggnkQ3iUiGTjM2W_vJKGShEuL=H0BPNrDodw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] tools/mgmt-tester: Add new add-adv test cases
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> On Sat, Mar 28, 2015 at 12:53 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch adds new test cases for the Add Advertising command for the
> following conditions:
>
>   - ADV_SCAN_IND, ADV_NONCONN_IND, and ADV_IND correctly configured based on the
>     global "connectable" setting and the instance scan response length.
>   - ADV_IND is used when the global "connectable" setting is "on" and instance
>     flags is 0.
> ---
>  tools/mgmt-tester.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index 0721a64..b9be59e 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -4234,6 +4234,61 @@ static const struct generic_data add_advertising_success_12 = {
>         .expect_hci_len = sizeof(set_adv_data_8),
>  };
>
> +static uint16_t settings_powered_le_connectable[] = {
> +                                               MGMT_OP_SET_POWERED,
> +                                               MGMT_OP_SET_LE,
> +                                               MGMT_OP_SET_CONNECTABLE, 0 };
> +
> +static uint8_t set_connectable_off_scan_adv_param[] = {
> +               0x00, 0x08,                             /* min_interval */
> +               0x00, 0x08,                             /* max_interval */
> +               0x02,                                   /* type */
> +               0x01,                                   /* own_addr_type */
> +               0x00,                                   /* direct_addr_type */
> +               0x00, 0x00, 0x00, 0x00, 0x00, 0x00,     /* direct_addr */
> +               0x07,                                   /* channel_map */
> +               0x00,                                   /* filter_policy */
> +};
> +
> +static const struct generic_data add_advertising_success_13 = {
> +       .setup_settings = settings_powered_le,
> +       .send_opcode = MGMT_OP_ADD_ADVERTISING,
> +       .send_param = add_advertising_param_2,
> +       .send_len = sizeof(add_advertising_param_2),
> +       .expect_param = advertising_instance_param,
> +       .expect_len = sizeof(advertising_instance_param),
> +       .expect_status = MGMT_STATUS_SUCCESS,
> +       .expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
> +       .expect_hci_param = set_connectable_off_scan_adv_param,
> +       .expect_hci_len = sizeof(set_connectable_off_scan_adv_param),
> +};
> +
> +static const struct generic_data add_advertising_success_14 = {
> +       .setup_settings = settings_powered_le,
> +       .send_opcode = MGMT_OP_ADD_ADVERTISING,
> +       .send_param = add_advertising_param_1,
> +       .send_len = sizeof(add_advertising_param_1),
> +       .expect_param = advertising_instance_param,
> +       .expect_len = sizeof(advertising_instance_param),
> +       .expect_status = MGMT_STATUS_SUCCESS,
> +       .expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
> +       .expect_hci_param = set_connectable_off_adv_param,
> +       .expect_hci_len = sizeof(set_connectable_off_adv_param),
> +};
> +
> +static const struct generic_data add_advertising_success_15 = {
> +       .setup_settings = settings_powered_le_connectable,
> +       .send_opcode = MGMT_OP_ADD_ADVERTISING,
> +       .send_param = add_advertising_param_1,
> +       .send_len = sizeof(add_advertising_param_1),
> +       .expect_param = advertising_instance_param,
> +       .expect_len = sizeof(advertising_instance_param),
> +       .expect_status = MGMT_STATUS_SUCCESS,
> +       .expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
> +       .expect_hci_param = set_connectable_on_adv_param,
> +       .expect_hci_len = sizeof(set_connectable_on_adv_param),
> +};
> +
>  static const char set_powered_off_le_settings_param[] = {
>         0x80, 0x02, 0x00, 0x00
>  };
> @@ -6201,6 +6256,15 @@ int main(int argc, char *argv[])
>         test_bredrle("Add Advertising - Success 9 - Flag 4",
>                                         &add_advertising_success_12,
>                                         NULL, test_command_generic);
> +       test_bredrle("Add Advertising - Success 10 - ADV_SCAN_IND",
> +                                       &add_advertising_success_13,
> +                                       NULL, test_command_generic);
> +       test_bredrle("Add Advertising - Success 11 - ADV_NONCONN_IND",
> +                                       &add_advertising_success_14,
> +                                       NULL, test_command_generic);
> +       test_bredrle("Add Advertising - Success 12 - ADV_IND",
> +                                       &add_advertising_success_15,
> +                                       NULL, test_command_generic);
>
>         test_bredrle("Remove Advertising - Invalid Params 1",
>                                         &remove_advertising_fail_1,
> --
> 2.2.0.rc0.207.ga3a616c
>

The 3 patches in this series have been applied.

Thanks,
Arman
