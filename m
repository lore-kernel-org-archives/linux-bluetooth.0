Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389886700-21480-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389886700-21480-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Thu, 16 Jan 2014 17:54:05 +0200
Message-ID: <CABBYNZKhPRdgbS2nXxRwnYckyEgsZ0gPX5hWvT-=w=SJ3=DzzA@mail.gmail.com>
Subject: Re: [PATCH] android/a2dp: Fix typo in condition
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Jan 16, 2014 at 5:38 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> ---
>  android/a2dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/android/a2dp.c b/android/a2dp.c
> index 9b168ed..2288912 100644
> --- a/android/a2dp.c
> +++ b/android/a2dp.c
> @@ -1262,7 +1262,7 @@ static void bt_stream_open(const void *buf, uint16_t len)
>                 return;
>         }
>
> -       if (avdtp_stream_get_transport(setup->stream, &fd, NULL, NULL, NULL)) {
> +       if (!avdtp_stream_get_transport(setup->stream, &fd, NULL, NULL, NULL)) {
>                 error("avdtp_stream_get_transport: failed");
>                 audio_ipc_send_rsp(AUDIO_OP_OPEN_STREAM, AUDIO_STATUS_FAILED);
>                 return;
> --
> 1.8.5.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
