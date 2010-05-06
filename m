Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 May 2010 23:51:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH] Changed MDP profile name and macros to HDP
Message-ID: <20100506205120.GA10204@jh-x301>
References: <1273178318-10490-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1273178318-10490-1-git-send-email-epx@signove.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Thu, May 06, 2010, Elvis Pfützenreuter wrote:
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
> +#define HDP_SINK_PROFILE_ID		HDP_SINK_SVCLASS_ID
>  #define APPLE_AGENT_PROFILE_ID		APPLE_AGENT_SVCLASS_ID

Thanks for the patch!

Since this essentially breaks the library API we should probably
consider leaving the MDP defines there as "synonyms" and then just add
the HDP defines with the same values. However I'll leave it for Marcel
to decide how important this non-breakage is.

Btw, the commit message summary line should be in the form "Change ..."
or "Fix ..." (not "Changed ...") to be consistent with the rest of the
commit history.

Johan
