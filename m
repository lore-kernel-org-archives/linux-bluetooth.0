Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1358537120-7955-1-git-send-email-jprvita@openbossa.org>
References: <1358537120-7955-1-git-send-email-jprvita@openbossa.org>
Date: Tue, 22 Jan 2013 18:03:52 +0200
Message-ID: <CABBYNZ+Qi56=guBN9KJgz25JxzxQLHUTBOPKdsf_0PjV3yyHWQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] avrcp: Ignore MSB of Absolute Volume parameter
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao,

On Fri, Jan 18, 2013 at 9:25 PM, João Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> According to the Section 6.13.1 of the AVRCP 1.5 specification document,
> the most significant bit of the Absolute Volume parameter is reserved
> for future additions, so it should be ignored when parsing parameters of
> the SetAbsoluteVolume command. This is also necessary to pass PTS test
> TC_TG_VLH_BI_02_C.
> ---
>  profiles/audio/avrcp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 636d3e4..237f176 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1398,11 +1398,13 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
>  {
>         struct avrcp_player *player = session->player;
>         uint16_t len = ntohs(pdu->params_len);
> +       uint8_t volume;
>
>         if (len != 1)
>                 goto err;
>
> -       if (pdu->params[0] > 127)
> +       volume = pdu->params[0] & 0x7F;
> +       if (volume > 127)
>                 goto err;
>
>         if (!player)
> --
> 1.7.11.7


Patch applied, thanks.


--
Luiz Augusto von Dentz
