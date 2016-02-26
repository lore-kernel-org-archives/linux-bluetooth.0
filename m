Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1456322258-28742-1-git-send-email-john@metanate.com>
References: <1456322258-28742-1-git-send-email-john@metanate.com>
Date: Fri, 26 Feb 2016 14:03:51 +0200
Message-ID: <CABBYNZJtyHLv-WR4P3Hda+A3=BT6rttK6GJCKZ2LieXarwmbew@mail.gmail.com>
Subject: Re: [PATCH] tools/avinfo: fix big endian build
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: John Keeping <john@metanate.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Wed, Feb 24, 2016 at 3:57 PM, John Keeping <john@metanate.com> wrote:
> Commit 101b439 (tools/avinfo: Add partial support for Sony LDAC) added a
> new a2dp_ldac_t structure but only inside a little endian ifdef.  Add
> the same structure in the big endian code.
>
> The structure definition doesn't differ for the big/little endian cases
> but if the unknown fields are discovered in the future it might, so a
> copy is added rather than pulling the existing definition below the
> endif.
> ---
>  profiles/audio/a2dp-codecs.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
> index e9da0bf..4fb5c0c 100644
> --- a/profiles/audio/a2dp-codecs.h
> +++ b/profiles/audio/a2dp-codecs.h
> @@ -234,6 +234,11 @@ typedef struct {
>         uint8_t channel_mode:4;
>  } __attribute__ ((packed)) a2dp_aptx_t;
>
> +typedef struct {
> +       a2dp_vendor_codec_t info;
> +       uint8_t unknown[2];
> +} __attribute__ ((packed)) a2dp_ldac_t;
> +
>  #else
>  #error "Unknown byte order"
>  #endif
> --
> 2.7.0.226.gfe986fe

Applied, thanks.

-- 
Luiz Augusto von Dentz
