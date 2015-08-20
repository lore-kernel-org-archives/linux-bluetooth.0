Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1440061390-32664-1-git-send-email-bharat.panda@samsung.com>
References: <1440061390-32664-1-git-send-email-bharat.panda@samsung.com>
Date: Thu, 20 Aug 2015 15:48:41 +0300
Message-ID: <CABBYNZLp+iCpdshMBSCD8ndCPbeGezgLKrCd8-sqsCWp4B8c0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] test: Add sample media player properties
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Thu, Aug 20, 2015 at 12:03 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Polulates media player properties with player name, type,
> sub-type and features with sample values.
> ---
>  test/simple-player | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/test/simple-player b/test/simple-player
> index a8ae0b1..a89767a 100755
> --- a/test/simple-player
> +++ b/test/simple-player
> @@ -43,6 +43,10 @@ class Player(dbus.service.Object):
>
>                         self.properties = dbus.Dictionary({
>                                         "PlaybackStatus" : "playing",
> +                                       "DisplayName" : "SimplePlayer",
> +                                       "Type" : "Audio",
> +                                       "SubType" : "Audio Book",
> +                                       "Features" : "0000000000b701ef0200000000000000",
>                                         "LoopStatus" : "None",
>                                         "Rate" : dbus.Double(1.0),
>                                         "Shuffle" : dbus.Boolean(False),
> --
> 1.9.1

This properties do not exist in MPRIS
http://specifications.freedesktop.org/mpris-spec/latest/Media_Player.html,
for DisplayName you can probably use Identity but for other we might
have to infer based on the available MPRIS properties.

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
