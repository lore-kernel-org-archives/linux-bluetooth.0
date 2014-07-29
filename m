Return-Path: <cyrus@holtmann.org>
Message-ID: <53D79E72.5000303@tieto.com>
Date: Tue, 29 Jul 2014 15:15:30 +0200
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/8] android/tester-ng: Add PAN Enable NAP test case
References: <1406635292-30691-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1406635292-30691-8-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1406635292-30691-8-git-send-email-ravikumar.veeramally@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On 07/29/2014 02:01 PM, Ravi kumar Veeramally wrote:
> ---
>   android/tester-pan.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/android/tester-pan.c b/android/tester-pan.c
> index 7b013cc..1acc460 100644
> --- a/android/tester-pan.c
> +++ b/android/tester-pan.c
> @@ -121,6 +121,16 @@ static void pan_enable_panu_action(void)
>   	schedule_action_verification(step);
>   }
>
> +static void pan_enable_nap_action(void)
> +{
> +	struct test_data *data = tester_get_data();
> +	struct step *step = g_new0(struct step, 1);
> +
> +	step->action_status = data->if_pan->enable(BTPAN_ROLE_PANNAP);
> +
> +	schedule_action_verification(step);
> +}
> +
>   static struct test_case test_cases[] = {
>   	TEST_CASE_BREDRLE("PAN Init",
>   		ACTION_SUCCESS(dummy_action, NULL),
> @@ -172,6 +182,9 @@ static struct test_case test_cases[] = {
>   	TEST_CASE_BREDRLE("PAN Enable PANU - Success",
>   		ACTION(BT_STATUS_UNSUPPORTED, pan_enable_panu_action, NULL),
>   	),
> +	TEST_CASE_BREDRLE("PAN Enable NAP - Success",
> +		ACTION_SUCCESS(pan_enable_nap_action, NULL),
> +	),

Shouldn't btpan_control_state_callback be verified after the enable?

Snipped from hardware/bt_pan.h:
"The result state of enabl will be returned by 
btpan_control_state_callback."

Same applies to the previous case (enable PANU).

>   };
>
>   struct queue *get_pan_tests(void)
>

Regards,
Jakub
