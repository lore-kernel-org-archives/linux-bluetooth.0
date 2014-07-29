Return-Path: <cyrus@holtmann.org>
Message-ID: <53D79C90.9050008@tieto.com>
Date: Tue, 29 Jul 2014 15:07:28 +0200
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/8] android/tester-ng: Add PAN init test case
References: <1406635292-30691-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1406635292-30691-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1406635292-30691-3-git-send-email-ravikumar.veeramally@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On 07/29/2014 02:01 PM, Ravi kumar Veeramally wrote:
> ---
>   android/Makefile.am   |  1 +
>   android/tester-main.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   android/tester-main.h |  8 ++++++
>   android/tester-pan.c  | 48 +++++++++++++++++++++++++++++++
>   4 files changed, 137 insertions(+)
>   create mode 100644 android/tester-pan.c
>
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 84a05a8..66cb8c1 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -181,6 +181,7 @@ android_android_tester_ng_SOURCES = emulator/btdev.h emulator/btdev.c \
>   				android/tester-bluetooth.c \
>   				android/tester-socket.c \
>   				android/tester-hidhost.c \
> +				android/tester-pan.c \
>   				android/tester-gatt.c \
>   				android/tester-main.h android/tester-main.c
>
> diff --git a/android/tester-main.c b/android/tester-main.c
> index 91a79ba..5e71809 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -783,6 +783,37 @@ static bthh_callbacks_t bthh_callbacks = {
>   	.virtual_unplug_cb = NULL
>   };
>
> +static void pan_control_state_cb(btpan_control_state_t state,
> +					bt_status_t error, int local_role,
> +							const char *ifname)
> +{
> +	struct step *step = g_new0(struct step, 1);
> +
> +	step->callback = CB_PAN_CONTROL_STATE;
> +	step->callback_result.state = state;
> +
> +	schedule_callback_call(step);
> +}
> +
> +static void pan_connection_state_cb(btpan_connection_state_t state,
> +					bt_status_t error,
> +					const bt_bdaddr_t *bd_addr,
> +					int local_role, int remote_role)
> +{
> +	struct step *step = g_new0(struct step, 1);
> +
> +	step->callback = CB_PAN_CONNECTION_STATE;
> +	step->callback_result.state = state;
> +
> +	schedule_callback_call(step);
> +}

It would be nice to verify more than one callback parameter.
Fortunately PAN has only 2 callbacks.

Just saying. :) I know that this also applies to some HID cases (there 
is 'TODO' somewhere).

Regards,
Jakub
