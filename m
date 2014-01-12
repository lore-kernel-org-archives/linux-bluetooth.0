Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389435216-29040-2-git-send-email-luiz.dentz@gmail.com>
References: <1389435216-29040-1-git-send-email-luiz.dentz@gmail.com>
	<1389435216-29040-2-git-send-email-luiz.dentz@gmail.com>
Date: Sun, 12 Jan 2014 23:36:53 +0100
Message-ID: <CAN_7+YaRwBG5Ji3jgyZ9Q0bg0Lgk8STZfXzSK4PhmPAbJ4f3=A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/6] audio/A2DP: Add implemention of audio Close command
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sat, Jan 11, 2014 at 11:13 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  android/a2dp.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/android/a2dp.c b/android/a2dp.c
> index 28b7406..8649cf3 100644
> --- a/android/a2dp.c
> +++ b/android/a2dp.c
> @@ -515,11 +515,37 @@ failed:
>         audio_ipc_send_rsp(AUDIO_OP_OPEN, AUDIO_STATUS_FAILED);
>  }
>
> +static struct a2dp_endpoint *find_endpoint(uint8_t id)
> +{
> +       GSList *l;
> +
> +       for (l = endpoints; l; l = g_slist_next(l)) {
> +               struct a2dp_endpoint *endpoint = l->data;
> +
> +               if (endpoint->id == id)
> +                       return endpoint;
> +       }
> +
> +       return NULL;
> +}
> +
>  static void bt_audio_close(const void *buf, uint16_t len)
>  {
> -       DBG("Not Implemented");
> +       const struct audio_cmd_close *cmd = buf;
> +       struct a2dp_endpoint *endpoint;
> +
> +       DBG("");
> +
> +       endpoint = find_endpoint(cmd->id);
> +       if (!endpoint) {
> +               error("Unable to find endpoint %u", cmd->id);
> +               audio_ipc_send_rsp(AUDIO_OP_CLOSE, HAL_STATUS_FAILED);

I think we should use AUDIO_STATUS_FAILED instead of HAL_STATUS_FAILED

> +               return;
> +       }
> +
> +       unregister_endpoint(endpoint);
>
> -       audio_ipc_send_rsp(AUDIO_OP_CLOSE, HAL_STATUS_FAILED);
> +       audio_ipc_send_rsp(AUDIO_OP_CLOSE, HAL_STATUS_SUCCESS);

Similar here.
>  }
>
>  static void bt_stream_open(const void *buf, uint16_t len)
> --
> 1.8.4.2
>
> --

\Lukasz

> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
