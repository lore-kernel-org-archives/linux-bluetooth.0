Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1353926791-8769-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1353926791-8769-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Mon, 26 Nov 2012 13:40:14 +0200
Message-ID: <CABBYNZKqKYocn48dNMACddq+a6SfS7pddo2eLRc9Fy3FBUJoug@mail.gmail.com>
Subject: Re: [RFC] doc: Split media transport volume into two parts
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Nov 26, 2012 at 12:46 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Separate the input and output audio volumes in two independent
> properties in order to control both speaker and microphone gains while
> doing HSP/HFP.
> ---
> This property was introduced quite recently but never implemented. Shouldn't we split it into two separate properties?
>
> It wouldn't do much harm for the A2DP transports and it would be needed for HSP/HFP.
>
>  doc/media-api.txt | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index b4f2fc6..6515e5f 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -375,10 +375,18 @@ Properties        object Device [readonly]
>
>                         Possible Values: "HCI" or "PCM"
>
> -               uint16 Volume [readwrite]
> +               uint16 InputVolume [readwrite] [optional]
>
> -                       Optional. Indicates volume level of the transport,
> -                       this property is only writeable when the transport was
> -                       acquired by the sender.
> +                       Indicates volume level of the transport's incoming
> +                       audio stream, if any. This property is only writeable
> +                       when the transport was acquired by the sender.
> +
> +                       Possible Values: 0-127
> +
> +               uint16 OutputVolume [readwrite] [optional]
> +
> +                       Indicates volume level of the transport's outgoing
> +                       audio stream, if any. This property is only writeable
> +                       when the transport was acquired by the sender.
>
>                         Possible Values: 0-127
> --
> 1.7.11.7

We could do this way or have specific property for each profile, e.g.
SpeakerGain/MicrophoneGain for HFP, because the scale is different
(0-15). If we do this generic then I think the value should be a
percentage (0-100%), iirc companies have some table mapping the volume
level to percentage due to volume not being linear but I guess we can
came up with something similar.


--
Luiz Augusto von Dentz
