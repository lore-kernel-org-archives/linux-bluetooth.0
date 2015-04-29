Return-Path: <cyrus@holtmann.org>
Message-ID: <1430322403.2268.13.camel@gmail.com>
Subject: Re: [RFCv1 14/20] android/avdtp: Add set vendor codec function
From: chanten <chanyeol.park@gmail.com>
To: luiz.von.dentz@intel.com
Cc: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 30 Apr 2015 00:46:43 +0900
In-Reply-To: <1425049388-18333-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1425049388-18333-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 
On Fri, 2015-02-27 at 17:03 +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  profiles/audio/avdtp.c | 22 ++++++++++++++++++++++
>  profiles/audio/avdtp.h |  2 ++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 6132c13..c396e8f 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -49,6 +49,7 @@
>  #include "src/adapter.h"
>  #include "src/device.h"
>  
> +#include "../profiles/audio/a2dp-codecs.h"
>  #include "avdtp.h"
>  #include "a2dp.h"
>  #include "sink.h"
> @@ -330,6 +331,8 @@ struct avdtp_local_sep {
>  	struct avdtp_stream *stream;
>  	struct seid_info info;
>  	uint8_t codec;
> +	uint32_t vndcodec_vendor;
> +	uint16_t vndcodec_codec;
>  	gboolean delay_reporting;
>  	GSList *caps;
>  	struct avdtp_sep_ind *ind;
> @@ -1274,6 +1277,18 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
>  		if (codec_data->media_codec_type != lsep->codec)
>  			continue;
>  
> +		/* FIXME: Add Vendor Specific Codec match to SEP callback */
> +		if (lsep->codec == A2DP_CODEC_VENDOR) {
> +			a2dp_vendor_codec_t *vndcodec =
> +						(void *) codec_data->data;
> +
> +			if (btohl(vndcodec->vendor_id) != lsep->vndcodec_vendor)
> +				continue;
> +
> +			if (btohs(vndcodec->codec_id) != lsep->vndcodec_codec)
> +				continue;
> +		}
> +
>  		if (sep->stream == NULL)
>  			return sep;
>  	}
> @@ -3753,6 +3768,13 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
>  	return sep;
>  }
>  
> +void avdtp_sep_set_vendor_codec(struct avdtp_local_sep *sep, uint32_t vendor_id,
> +							uint16_t codec_id)
> +{
> +	sep->vndcodec_vendor = vendor_id;
> +	sep->vndcodec_codec = codec_id;
> +}
> +
>  int avdtp_unregister_sep(struct queue *lseps, struct avdtp_local_sep *sep)
>  {
>  	if (!sep)
> diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
> index af55f76..0fc8fe2 100644
> --- a/profiles/audio/avdtp.h
> +++ b/profiles/audio/avdtp.h
> @@ -282,6 +282,8 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
>  						struct avdtp_sep_ind *ind,
>  						struct avdtp_sep_cfm *cfm,
>  						void *user_data);
> +void avdtp_sep_set_vendor_codec(struct avdtp_local_sep *sep, uint32_t vendor_id,
> +							uint16_t codec_id);
>  
>  /* Find a matching pair of local and remote SEP ID's */
>  struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,

I find out that bluez a2dp also do not work fine in case of multiple
vendor codecs in remote. So I think bluez also needs this android bluez
patch.

Originally I consider to use check_vendor(profile/audio/a2dp.c)function
from avdtp_find_remote_sep. but it does not seem good to me.

Could you give us the guidance?

Thanks
Chanyeol


