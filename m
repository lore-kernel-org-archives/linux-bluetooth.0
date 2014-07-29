Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1406635292-30691-6-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1406635292-30691-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<1406635292-30691-6-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Tue, 29 Jul 2014 15:15:32 +0200
Message-ID: <CAMv5Gbeku6BQ4u_+6vJSuBjVV6c6O1rMhvhavVCqBn_fWvP-=A@mail.gmail.com>
Subject: Re: [PATCH 5/8] anrdroid/tester-ng: Add PAN Get Local Role test case
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

Please correct commit message, there is a typo "anrdroid".

Best regards,
Grzegorz

On 29 July 2014 14:01, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> ---
>  android/tester-pan.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/android/tester-pan.c b/android/tester-pan.c
> index 5048a43..1db4a85 100644
> --- a/android/tester-pan.c
> +++ b/android/tester-pan.c
> @@ -92,6 +92,25 @@ static void pan_disconnect_action(void)
>         schedule_action_verification(step);
>  }
>
> +static void pan_get_local_role_action(void)
> +{
> +       struct test_data *data = tester_get_data();
> +       const uint8_t *pan_addr = hciemu_get_client_bdaddr(data->hciemu);
> +       struct step *step = g_new0(struct step, 1);
> +       bt_bdaddr_t bdaddr;
> +       int role;
> +
> +       bdaddr2android((const bdaddr_t *) pan_addr, &bdaddr);
> +
> +       role = data->if_pan->get_local_role();
> +       if (role == BTPAN_ROLE_PANU)
> +               step->action_status = BT_STATUS_SUCCESS;
> +       else
> +               step->action_status = BT_STATUS_FAIL;
> +
> +       schedule_action_verification(step);
> +}
> +
>  static struct test_case test_cases[] = {
>         TEST_CASE_BREDRLE("PAN Init",
>                 ACTION_SUCCESS(dummy_action, NULL),
> @@ -125,6 +144,21 @@ static struct test_case test_cases[] = {
>                 ACTION_SUCCESS(bluetooth_disable_action, NULL),
>                 CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
>         ),
> +       TEST_CASE_BREDRLE("PAN GetLocalRole - Success",
> +               ACTION_SUCCESS(bluetooth_enable_action, NULL),
> +               CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
> +               ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
> +               ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
> +               ACTION_SUCCESS(emu_add_l2cap_server_action, &l2cap_setup_data),
> +               ACTION_SUCCESS(pan_connect_action, NULL),
> +               CALLBACK_STATE(CB_PAN_CONNECTION_STATE,
> +                                               BTPAN_STATE_CONNECTED),
> +               ACTION_SUCCESS(pan_get_local_role_action, NULL),
> +               ACTION_SUCCESS(bluetooth_disable_action, NULL),
> +               CALLBACK_STATE(CB_PAN_CONNECTION_STATE,
> +                                               BTPAN_STATE_DISCONNECTED),
> +               CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
> +       ),
>  };
>
>  struct queue *get_pan_tests(void)
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
