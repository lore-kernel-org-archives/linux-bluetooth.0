Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416827503-17260-1-git-send-email-yes@samsung.com>
References: <yes@samsung.com>
	<1416827503-17260-1-git-send-email-yes@samsung.com>
Date: Mon, 24 Nov 2014 15:33:50 +0200
Message-ID: <CABBYNZL5Bk6JkuSCe2QM=7wSib-X83tX-mhE1QwnrbGwWXOzbw@mail.gmail.com>
Subject: Re: [PATCH 1/1] audio/avrcp: Fix set absolute volume
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: yes@samsung.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Anurag Biradar <biradar.a@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 24, 2014 at 1:11 PM,  <yes@samsung.com> wrote:
> From: Anurag Biradar <biradar.a@samsung.com>
>
> Player object should be getting from target not from controller
> ---
>  profiles/audio/avrcp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 5c3c4f9..be9cb56 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1588,7 +1588,7 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
>                                                 struct avrcp_header *pdu,
>                                                 uint8_t transaction)
>  {
> -       struct avrcp_player *player = session->controller->player;
> +       struct avrcp_player *player = target_get_player(session);
>         uint16_t len = ntohs(pdu->params_len);
>         uint8_t volume;
>
> --
> 1.7.9.5

Absolute volume control works the opposite way, it is the phone/target
that sends it since it want the volume in the headset/controller to
change, this is actually the reason why by enabling volume control PTS
requires to have a controller record since the tests related to
sending commands are tied to controller role for some reason.



-- 
Luiz Augusto von Dentz
