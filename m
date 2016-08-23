Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1471524327-15455-1-git-send-email-luiz.dentz@gmail.com>
References: <1471524327-15455-1-git-send-email-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Aug 2016 13:19:23 +0300
Message-ID: <CABBYNZJs_=K2idLr-7PXOF3e6X2705u=PgL8yZ5PLa5ZLn3tKw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] audio/player: Fix checking wrong flag
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 18, 2016 at 3:45 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> media_player_set_searchable should check searchable flag not browsable.
> ---
>  profiles/audio/player.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/audio/player.c b/profiles/audio/player.c
> index 465bff5..9d638fc 100644
> --- a/profiles/audio/player.c
> +++ b/profiles/audio/player.c
> @@ -1406,7 +1406,7 @@ void media_player_set_browsable(struct media_player *mp, bool enabled)
>
>  void media_player_set_searchable(struct media_player *mp, bool enabled)
>  {
> -       if (mp->browsable == enabled)
> +       if (mp->searchable == enabled)
>                 return;
>
>         DBG("%s", enabled ? "true" : "false");
> --
> 2.7.4

Applied.


-- 
Luiz Augusto von Dentz
