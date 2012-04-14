Return-Path: <cyrus@holtmann.org>
Message-ID: <1334419155.16897.148.camel@aeonflux>
Subject: Re: [PATCH 1/1] Add sbc cap null case while GST AVDTP Signaling.
From: Marcel Holtmann <marcel@holtmann.org>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org, hocheol.seo@samsung.com
Date: Sat, 14 Apr 2012 17:59:15 +0200
In-Reply-To: <1334383556-18480-1-git-send-email-chanyeol.park@samsung.com>
References: <1334383556-18480-1-git-send-email-chanyeol.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

> Due to RF condition or headset malfunctioning, gst audio plug-in
> could not get sbc(mandatory codec) information.
> ---
>  audio/gstavdtpsink.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
> index b448d57..1d50914 100644
> --- a/audio/gstavdtpsink.c
> +++ b/audio/gstavdtpsink.c
> @@ -1121,6 +1121,11 @@ static gboolean gst_avdtp_sink_update_caps(GstAvdtpSink *self)
>  	sbc = (void *) gst_avdtp_find_caps(self, BT_A2DP_SBC_SINK);
>  	mpeg = (void *) gst_avdtp_find_caps(self, BT_A2DP_MPEG12_SINK);
>  
> +	if(!sbc) {

space before brackets are not not option. Please follow the coding style
and fix this.

> +		GST_ERROR_OBJECT(self, "Failed to find sbc(mandatory codec)");

And please use proper error messages aka "Failed to find mandatory SBC
sink".

> +		return FALSE;
> +	}
> +
>  	sbc_structure = gst_avdtp_sink_parse_sbc_caps(self, sbc);
>  	mpeg_structure = gst_avdtp_sink_parse_mpeg_caps(self, mpeg);
>  

Regards

Marcel


