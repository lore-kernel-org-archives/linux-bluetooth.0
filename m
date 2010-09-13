Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Sep 2010 16:21:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash on gstreamer plugin if device doesn't
 support sbc
Message-ID: <20100913132116.GA6381@jh-x301>
References: <1284381611-17203-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284381611-17203-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Sep 13, 2010, Luiz Augusto von Dentz wrote:
>  audio/gstavdtpsink.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
> index f0e5b76..b8c8832 100644
> --- a/audio/gstavdtpsink.c
> +++ b/audio/gstavdtpsink.c
> @@ -448,6 +448,9 @@ static GstStructure *gst_avdtp_sink_parse_sbc_caps(
>  	GValue *list;
>  	gboolean mono, stereo;
>  
> +	if (sbc == NULL)
> +		return NULL;
> +
>  	structure = gst_structure_empty_new("audio/x-sbc");
>  	value = g_value_init(g_new0(GValue, 1), G_TYPE_STRING);
>  

The patch has been pushed upstream. Thanks.

Johan
