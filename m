Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391177929-31416-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391177929-31416-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1391177929-31416-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 31 Jan 2014 12:11:12 -0800
Message-ID: <CABBYNZ+i8voC8XSSfgjwo3VUOzimn6wA7mMNCLX6mFp+tc2PTg@mail.gmail.com>
Subject: Re: [PATCH 2/4] android/hal-audio: Do not allocate memory if fd < 0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jan 31, 2014 at 6:18 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Fixes memory leak when returning bad fd we still allocate memory which
> is not freed in the caller function audio_open_output_stream().
> ---
>  android/hal-audio.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index 35bafe7..4b80da8 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -713,8 +713,7 @@ static int ipc_open_stream_cmd(uint8_t endpoint_id, uint16_t *mtu, int *fd,
>
>         result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_OPEN_STREAM,
>                                 sizeof(cmd), &cmd, &rsp_len, rsp, fd);
> -
> -       if (result == AUDIO_STATUS_SUCCESS) {
> +       if (result == AUDIO_STATUS_SUCCESS && *fd >= 0) {
>                 size_t buf_len = sizeof(struct audio_preset) +
>                                         rsp->preset[0].len;
>                 *mtu = rsp->mtu;
> --
> 1.8.3.2

We should check if the fd is valid on audio_ipc_cmd.


-- 
Luiz Augusto von Dentz
