Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1461226729-17372-2-git-send-email-beaufort.francois@gmail.com>
References: <1461226729-17372-1-git-send-email-beaufort.francois@gmail.com>
	<1461226729-17372-2-git-send-email-beaufort.francois@gmail.com>
Date: Fri, 22 Apr 2016 15:06:33 +0300
Message-ID: <CABBYNZKH3MvqYRJ56ssjbvWta16cUkeu3H7ZNb_ejPs71aL7CA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix bluez build break by initializing variable.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Francois Beaufort <beaufort.francois@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Francois,

On Thu, Apr 21, 2016 at 11:18 AM, Francois Beaufort
<beaufort.francois@gmail.com> wrote:
> ---
>  profiles/audio/avrcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 37bc291..70c184b 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3112,7 +3112,7 @@ static gboolean avrcp_get_total_numberofitems_rsp(struct avctp *conn,
>         struct avrcp *session = user_data;
>         struct avrcp_player *player = session->controller->player;
>         struct media_player *mp = player->user_data;
> -       uint32_t num_of_items;
> +       uint32_t num_of_items = 0;
>
>         if (pdu == NULL)
>                 return -ETIMEDOUT;
> --
> 2.7.0

Applied, thanks.

-- 
Luiz Augusto von Dentz
