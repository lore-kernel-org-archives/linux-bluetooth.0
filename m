Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1410431535-27232-1-git-send-email-luiz.dentz@gmail.com>
References: <1410431535-27232-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 12 Sep 2014 15:46:16 +0300
Message-ID: <CABBYNZLb5v+HE-6g+Or8Qt28vCN6JXY6ejiJd2iVhZQn80LD9A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] doc/media-api: Remove obsolete properties
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Sep 11, 2014 at 1:32 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Properties related to HFP/HSP are no longer available since BlueZ has
> no native support of those profiles.
> ---
>  doc/media-api.txt | 40 ----------------------------------------
>  1 file changed, 40 deletions(-)
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index ae49dfa..e9c4ba1 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -593,28 +593,6 @@ Properties object Device [readonly]
>                         property is only writeable when the transport was
>                         acquired by the sender.
>
> -               boolean NREC [readwrite]
> -
> -                       Optional and HFP specific (external to BlueZ).
> -                       Indicates if echo cancelling and noise reduction
> -                       functions are active in the transport, this
> -                       property is only writeable when the transport
> -                       was acquired by the sender.
> -
> -               boolean InbandRingtone [readwrite]
> -
> -                       Optional and HFP specific (external to BlueZ).
> -                       Indicates if the transport support sending
> -                       ringtones, this property is only writeable when
> -                       the transport was acquired by the sender.
> -
> -               string Routing [readonly]
> -
> -                       Optional and HFP specific (external to BlueZ).
> -                       Indicates where is the transport being routed.
> -
> -                       Possible Values: "HCI" or "PCM"
> -
>                 uint16 Volume [readwrite]
>
>                         Optional. Indicates volume level of the transport,
> @@ -626,21 +604,3 @@ Properties object Device [readonly]
>                         used instead.
>
>                         Possible Values: 0-127
> -
> -               byte MicrophoneGain [readwrite]
> -
> -                       Optional. Indicates volume level of the transport's
> -                       incoming audio stream for HSP/HFP transports. This
> -                       property is only writeable when the transport was
> -                       acquired by the sender.
> -
> -                       Possible Values: 0-15
> -
> -               byte SpeakerGain [readwrite]
> -
> -                       Optional. Indicates volume level of the transport's
> -                       outgoing audio stream for HSP/HFP transports. This
> -                       property is only writeable when the transport was
> -                       acquired by the sender.
> -
> -                       Possible Values: 0-15
> --
> 1.9.3

Applied


-- 
Luiz Augusto von Dentz
