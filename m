Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1393379848-4031-11-git-send-email-lukasz.rymanowski@tieto.com>
References: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1393379848-4031-11-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 26 Feb 2014 11:32:06 +0100
Message-ID: <CAMudyAuuSjs8qgR__JTdVw57rZS_7y5CNnoS19+xDWt=ouPRdA@mail.gmail.com>
Subject: Re: [PATCH 10/17] emulator: Add handling inquiry_lenght from inquiry command
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 26 February 2014 02:57, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> ---
>  emulator/btdev.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index c74258b..bf0c9d2 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -129,8 +129,10 @@ struct btdev {
>  struct inquiry_data {
>         struct btdev *btdev;
>         int num_resp;
> +       int max_iter; /* Calculated from inquiry_lenght */
>
>         int sent_count;
> +       int iter;
>  };
>
>  #define DEFAULT_INQUIRY_INTERVAL 2 /* 2 miliseconds */
> @@ -778,8 +780,12 @@ static bool inquiry_callback(void *user_data)
>         if (data->num_resp && data->sent_count == data->num_resp)
>                 goto finish;
>
> +       /* Check if we already spent as much time as required */
> +       if (data->max_iter && data->iter++ == data->max_iter)
> +               goto finish;
> +
>         if (i == MAX_BTDEV_ENTRIES) {
> -               if (!data->num_resp)
> +               if (!data->max_iter && !data->num_resp)
>                         goto finish;
>
>                 /* Reset main iterator so we can start iterate btdev_list
> @@ -826,6 +832,7 @@ static void inquiry_cmd(struct btdev *btdev, const void *cmd)
>         const struct bt_hci_cmd_inquiry *inq_cmd = cmd;
>         struct inquiry_data *data;
>         struct bt_hci_evt_inquiry_complete ic;
> +       unsigned int inquiry_len_ms = 128 * inq_cmd->length;
>
>         if (btdev->inquiry_id)
>                 return;
> @@ -838,6 +845,9 @@ static void inquiry_cmd(struct btdev *btdev, const void *cmd)
>         data->btdev = btdev;
>         data->num_resp = inq_cmd->num_resp;
>
> +       if (inquiry_len_ms)
> +               data->max_iter = inquiry_len_ms / DEFAULT_INQUIRY_INTERVAL;
> +
>         btdev->inquiry_id = timeout_add(DEFAULT_INQUIRY_INTERVAL,
>                                 inquiry_callback, data, inquiry_destroy);
>         /* Return if success */
> --
> 1.8.4
>

Do not review this one, I will change the approach here

\Lukasz
