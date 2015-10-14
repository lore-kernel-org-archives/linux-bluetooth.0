Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1444642132-19224-1-git-send-email-luiz.dentz@gmail.com>
References: <1444642132-19224-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 14 Oct 2015 11:08:30 +0300
Message-ID: <CABBYNZLDuJUDgt4-qPz0Qg6cUg7bZbDVO8RTs3KtOGvUvkQyOw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/avrcp: Fix ctype code of PlayItem and AddToNowPlaying
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 12, 2015 at 12:28 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Both PlayItem and AddToNowPlaying should use control type not status.
> ---
>  profiles/audio/avrcp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 44f8929..7b60012 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3030,7 +3030,7 @@ static void avrcp_play_item(struct avrcp *session, uint64_t uid)
>
>         length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
>
> -       avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
> +       avctp_send_vendordep_req(session->conn, AVC_CTYPE_CONTROL,
>                                         AVC_SUBUNIT_PANEL, buf, length,
>                                         NULL, session);
>  }
> @@ -3076,7 +3076,7 @@ static void avrcp_add_to_nowplaying(struct avrcp *session, uint64_t uid)
>
>         length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
>
> -       avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
> +       avctp_send_vendordep_req(session->conn, AVC_CTYPE_CONTROL,
>                                         AVC_SUBUNIT_PANEL, buf, length,
>                                         NULL, session);
>  }
> --
> 2.4.3

Applied.


-- 
Luiz Augusto von Dentz
