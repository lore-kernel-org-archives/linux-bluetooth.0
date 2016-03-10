Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1457559367-5626-1-git-send-email-bimanpaul@yahoo.co.in>
References: <1457559367-5626-1-git-send-email-bimanpaul@yahoo.co.in>
Date: Thu, 10 Mar 2016 11:12:46 +0200
Message-ID: <CABBYNZK2WcZOyUJ7E5bNHNXuZw+6Y2Nfar9bHn75ViVjt_MLdg@mail.gmail.com>
Subject: Re: [PATCH 1/1] parser/sdp: parse MAS Instance ID and Message Type
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Biman Paul <bimanpaul@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Biman Paul <biman.paul@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paul,

On Wed, Mar 9, 2016 at 11:36 PM, Biman Paul <bimanpaul@gmail.com> wrote:
> From: Biman Paul <biman.paul@samsung.com>
>
> Parsing Support added in SDP record:
> 1. MAS Instance ID in MAP
> 2. Message Types supported by MAS


Can you please add the output of these changes, btw these parses are
deprecated in favor of monitor so perhaps you would want to add these
changes there as well.

> ---
>  tools/parser/sdp.c |    3 +++
>  tools/parser/sdp.h |    3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/tools/parser/sdp.c b/tools/parser/sdp.c
> index dba9a36..1f8d6c5 100644
> --- a/tools/parser/sdp.c
> +++ b/tools/parser/sdp.c
> @@ -211,6 +211,9 @@ static sdp_attr_id_nam_lookup_table_t sdp_attr_id_nam_lookup_table[] = {
>         { SDP_ATTR_ID_SUPPORTED_FUNCTIONS,               "SuppFunctions"      }, /* Imaging */
>         { SDP_ATTR_ID_TOTAL_IMAGING_DATA_CAPACITY,       "SuppTotalCapacity"  }, /* Imaging */
>         { SDP_ATTR_ID_SUPPORTED_REPOSITORIES,            "SuppRepositories"   }, /* PBAP */
> +       { SDP_ATTR_ID_MAS_INSTANCE_ID,                   "MASInstanceID"      }, /* MAS ID */
> +       { SDP_ATTR_ID_MAP_SUPPORTED_TYPES,               "SupportedMessageTypes" }, /* Message Types */
>  };
>
>  #define SDP_ATTR_ID_NAM_LOOKUP_TABLE_SIZE \
> diff --git a/tools/parser/sdp.h b/tools/parser/sdp.h
> index ed55a23..130da3f 100644
> --- a/tools/parser/sdp.h
> +++ b/tools/parser/sdp.h
> @@ -157,5 +157,8 @@
>  #define SDP_ATTR_ID_SUPPORTED_FUNCTIONS                0x0312 /* Imaging */
>  #define SDP_ATTR_ID_TOTAL_IMAGING_DATA_CAPACITY        0x0313 /* Imaging */
>  #define SDP_ATTR_ID_SUPPORTED_REPOSITORIES             0x0314 /* PBAP */
> +#define SDP_ATTR_ID_MAS_INSTANCE_ID                    0x0315 /* MAS ID */
> +#define SDP_ATTR_ID_MAP_SUPPORTED_TYPES                0x0316 /* Message Types */
>
>  #endif /* __SDP_H */
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
