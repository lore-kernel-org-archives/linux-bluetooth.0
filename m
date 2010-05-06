Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Changed MDP profile name and macros to HDP
From: Nathan Holstein <ngh@isomerica.net>
Reply-To: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
In-Reply-To: <1273178318-10490-1-git-send-email-epx@signove.com>
References: <1273178318-10490-1-git-send-email-epx@signove.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 06 May 2010 16:51:30 -0400
Message-Id: <1273179090.8329.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2010-05-06 at 17:38 -0300, Elvis Pfützenreuter wrote:
> ---
>  lib/sdp.c       |    6 +++---
>  lib/sdp.h       |   12 ++++++------
>  tools/sdptool.c |    6 +++---
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/sdp.c b/lib/sdp.c
> index aa22c63..ca3b4c4 100644
> --- a/lib/sdp.c
> +++ b/lib/sdp.c
> @@ -201,9 +201,9 @@ static struct tupla ServiceClass[] = {
>  	{ VIDEO_SOURCE_SVCLASS_ID,		"Video Source"			},
>  	{ VIDEO_SINK_SVCLASS_ID,		"Video Sink"			},
>  	{ VIDEO_DISTRIBUTION_SVCLASS_ID,	"Video Distribution"		},
> -	{ MDP_SVCLASS_ID,			"MDP"				},
> -	{ MDP_SOURCE_SVCLASS_ID,		"MDP Source"			},
> -	{ MDP_SINK_SVCLASS_ID,			"MDP Sink"			},
> +	{ HDP_SVCLASS_ID,			"HDP"				},
> +	{ HDP_SOURCE_SVCLASS_ID,		"HDP Source"			},
> +	{ HDP_SINK_SVCLASS_ID,			"HDP Sink"			},
>  	{ APPLE_AGENT_SVCLASS_ID,		"Apple Agent"			},
>  	{ 0 }
>  };
> diff --git a/lib/sdp.h b/lib/sdp.h
> index 5b2901f..9c15ace 100644
> --- a/lib/sdp.h
> +++ b/lib/sdp.h
> @@ -140,9 +140,9 @@ extern "C" {
>  #define VIDEO_SOURCE_SVCLASS_ID		0x1303
>  #define VIDEO_SINK_SVCLASS_ID		0x1304
>  #define VIDEO_DISTRIBUTION_SVCLASS_ID	0x1305
> -#define MDP_SVCLASS_ID			0x1400
> -#define MDP_SOURCE_SVCLASS_ID		0x1401
> -#define MDP_SINK_SVCLASS_ID		0x1402
> +#define HDP_SVCLASS_ID			0x1400
> +#define HDP_SOURCE_SVCLASS_ID		0x1401
> +#define HDP_SINK_SVCLASS_ID		0x1402
>  #define APPLE_AGENT_SVCLASS_ID		0x2112
>  
>  /*
> @@ -212,9 +212,9 @@ extern "C" {
>  #define VIDEO_SOURCE_PROFILE_ID		VIDEO_SOURCE_SVCLASS_ID
>  #define VIDEO_SINK_PROFILE_ID		VIDEO_SINK_SVCLASS_ID
>  #define VIDEO_DISTRIBUTION_PROFILE_ID	VIDEO_DISTRIBUTION_SVCLASS_ID
> -#define MDP_PROFILE_ID			MDP_SVCLASS_ID
> -#define MDP_SOURCE_PROFILE_ID		MDP_SROUCE_SVCLASS_ID
> -#define MDP_SINK_PROFILE_ID		MDP_SINK_SVCLASS_ID
> +#define HDP_PROFILE_ID			HDP_SVCLASS_ID
> +#define HDP_SOURCE_PROFILE_ID		HDP_SROUCE_SVCLASS_ID

Careful...there's a typo here from old versions of Bluez.  This should
be "HDP_SOURCE_SVCLASS_ID" not "HDP_SROUCE_SVCLASS_ID".

> +#define HDP_SINK_PROFILE_ID		HDP_SINK_SVCLASS_ID
>  #define APPLE_AGENT_PROFILE_ID		APPLE_AGENT_SVCLASS_ID
>  
>  /*
> diff --git a/tools/sdptool.c b/tools/sdptool.c
> index 89166ae..1de53e8 100644
> --- a/tools/sdptool.c
> +++ b/tools/sdptool.c
> @@ -322,9 +322,9 @@ static struct uuid_def uuid16_names[] = {
>  	{ 0x1303, "VideoSource", NULL, 0 },
>  	{ 0x1304, "VideoSink", NULL, 0 },
>  	{ 0x1305, "VideoDistribution", NULL, 0 },
> -	{ 0x1400, "MDP", NULL, 0 },
> -	{ 0x1401, "MDPSource", NULL, 0 },
> -	{ 0x1402, "MDPSink", NULL, 0 },
> +	{ 0x1400, "HDP", NULL, 0 },
> +	{ 0x1401, "HDPSource", NULL, 0 },
> +	{ 0x1402, "HDPSink", NULL, 0 },
>  	{ 0x2112, "AppleAgent", NULL, 0 },
>  };



    --nathan

