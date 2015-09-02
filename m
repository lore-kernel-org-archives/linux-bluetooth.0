Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1441022765-28899-1-git-send-email-luiz.dentz@gmail.com>
References: <1441022765-28899-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 2 Sep 2015 14:41:12 +0300
Message-ID: <CABBYNZLqo1qtzzMsBcyBWOXkcC2BES9FD3Dq6eMA8y4+dgsjNg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/avrcp: Fix not listing all players
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 31, 2015 at 3:06 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> To list the available player GetFolderItems with scope 0x00 is used but
> the code currently don't set the range which means only the first player
> is returned.
> ---
>  profiles/audio/avrcp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index d2b0065..48c302a 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3247,6 +3247,8 @@ static void avrcp_get_media_player_list(struct avrcp *session)
>         memset(buf, 0, sizeof(buf));
>
>         pdu->pdu_id = AVRCP_GET_FOLDER_ITEMS;
> +       put_be32(0, &pdu->params[1]);
> +       put_be32(UINT32_MAX, &pdu->params[5]);
>         pdu->param_len = htons(10);
>
>         avctp_send_browsing_req(session->conn, buf, sizeof(buf),
> --
> 2.4.3

Applied.


-- 
Luiz Augusto von Dentz
