Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1387444404-6834-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387444404-6834-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 19 Dec 2013 15:18:45 +0200
Message-ID: <CABBYNZKy20DpByJGa+tAJrJr4s97R=eSh8Lzw9gB1fZsCzz8qA@mail.gmail.com>
Subject: Re: [PATCH] avrcp: Remove unneeded code
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Dec 19, 2013 at 11:13 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Checking (val & 0x7f) > 127 does not make any sense.
> ---
>  profiles/audio/avrcp.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index cd027c6..7731e88 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1577,15 +1577,10 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
>  {
>         struct avrcp_player *player = session->controller->player;
>         uint16_t len = ntohs(pdu->params_len);
> -       uint8_t volume;
>
>         if (len != 1)
>                 goto err;
>
> -       volume = pdu->params[0] & 0x7F;
> -       if (volume > 127)
> -               goto err;
> -
>         if (!player)
>                 goto err;
>
> --
> 1.8.3.2

Ive applied a proper fix, there was a real problem since we were not
passing the value stored in volume which does ignore the reserved bits
properly, Ive also removed the the check for > 127 since it will never
be the case after & 0x7F operation which was initially your idea but
we cannot just remove volume for the reasons stated above.


-- 
Luiz Augusto von Dentz
