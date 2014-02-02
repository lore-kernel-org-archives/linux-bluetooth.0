Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391123008-26767-1-git-send-email-luiz.dentz@gmail.com>
References: <1391123008-26767-1-git-send-email-luiz.dentz@gmail.com>
Date: Sun, 2 Feb 2014 07:40:18 -0800
Message-ID: <CABBYNZ+JxRFpYnuv65XbT82vs41swzpLRrjsRoRwjMwU2pF60A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] audio/player: Fix using invalid end index
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jan 30, 2014 at 3:03 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> When the End index is not set in ListItems the code automatically pick
> the number of items as end index but the start index start with 0 so
> the correct is to use number of items - 1.
> ---
>  profiles/audio/player.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/player.c b/profiles/audio/player.c
> index e6d24eb..2bd2d6e 100644
> --- a/profiles/audio/player.c
> +++ b/profiles/audio/player.c
> @@ -808,7 +808,8 @@ static int parse_filters(struct media_player *player, DBusMessageIter *iter,
>         int ctype;
>
>         *start = 0;
> -       *end = folder->number_of_items ? folder->number_of_items : UINT32_MAX;
> +       *end = folder->number_of_items ? folder->number_of_items - 1 :
> +                                                               UINT32_MAX;
>
>         ctype = dbus_message_iter_get_arg_type(iter);
>         if (ctype != DBUS_TYPE_ARRAY)
> --
> 1.8.4.2

Pushed after fixing patch 4/4.


-- 
Luiz Augusto von Dentz
