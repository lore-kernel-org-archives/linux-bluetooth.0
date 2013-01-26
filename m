Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1359136498-18725-1-git-send-email-jprvita@openbossa.org>
References: <1359136498-18725-1-git-send-email-jprvita@openbossa.org>
Date: Sun, 27 Jan 2013 01:05:58 +0200
Message-ID: <CABBYNZ+nkASCspd_fb++2pGGn_BhfpEgFvqdRkXE45s-2uCcBw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] avctp: Handle Vol Up/Down operations
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao,

On Fri, Jan 25, 2013 at 7:54 PM, João Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> The AVRCP spec mandates to support 'volume up' and 'volume down'
> operations when claiming support for Category 2 TG.
> ---
>  profiles/audio/avctp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index d2dce3e..28c414d 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -213,6 +213,8 @@ static struct {
>         uint8_t avc;
>         uint16_t uinput;
>  } key_map[] = {
> +       { "VOLUME UP",          AVC_VOLUME_UP,          KEY_VOLUMEUP},
> +       { "VOLUME DOWN",        AVC_VOLUME_DOWN,        KEY_VOLUMEDOWN},
>         { "PLAY",               AVC_PLAY,               KEY_PLAYCD },
>         { "STOP",               AVC_STOP,               KEY_STOPCD },
>         { "PAUSE",              AVC_PAUSE,              KEY_PAUSECD },
> --
> 1.7.11.7
>

Applied, thanks.

--
Luiz Augusto von Dentz
