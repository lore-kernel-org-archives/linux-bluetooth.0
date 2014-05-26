Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/4] lib/sdp: Add attributes and service class for MPS
Date: Mon, 26 May 2014 11:11:11 +0200
Message-ID: <4902369.Ihp58TOQrg@uw000953>
In-Reply-To: <1400857882-3298-1-git-send-email-szymon.janc@tieto.com>
References: <1400857882-3298-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 23 of May 2014 17:11:19 Szymon Janc wrote:
> ---
>  lib/sdp.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/sdp.h b/lib/sdp.h
> index 34adf9a..cc10e9f 100644
> --- a/lib/sdp.h
> +++ b/lib/sdp.h
> @@ -134,6 +134,8 @@ extern "C" {
>  #define MAP_SVCLASS_ID			0x1134
>  #define GNSS_SVCLASS_ID			0x1135
>  #define GNSS_SERVER_SVCLASS_ID		0x1136
> +#define MPS_SC_SVCLASS_ID		0x113A
> +#define MPS_SVCLASS_ID			0x113B
>  #define PNP_INFO_SVCLASS_ID		0x1200
>  #define GENERIC_NETWORKING_SVCLASS_ID	0x1201
>  #define GENERIC_FILETRANS_SVCLASS_ID	0x1202
> @@ -228,6 +230,7 @@ extern "C" {
>  #define GENERIC_ACCESS_PROFILE_ID	GENERIC_ACCESS_SVCLASS_ID
>  #define GENERIC_ATTRIB_PROFILE_ID	GENERIC_ATTRIB_SVCLASS_ID
>  #define APPLE_AGENT_PROFILE_ID		APPLE_AGENT_SVCLASS_ID
> +#define MPS_PROFILE_ID			MPS_SC_SVCLASS_ID
>  
>  /*
>   * Compatibility macros for the old MDP acronym
> @@ -270,6 +273,10 @@ extern "C" {
>  #define SDP_ATTR_GOEP_L2CAP_PSM			0x0200
>  #define SDP_ATTR_SVCDB_STATE			0x0201
>  
> +#define SDP_ATTR_MPSD_SCENARIOS			0x0200
> +#define SDP_ATTR_MPMD_SCENARIOS			0x0201
> +#define SDP_ATTR_MPS_DEPENDENCIES		0x0202
> +
>  #define SDP_ATTR_SERVICE_VERSION		0x0300
>  #define SDP_ATTR_EXTERNAL_NETWORK		0x0301
>  #define SDP_ATTR_SUPPORTED_DATA_STORES_LIST	0x0301
> 

Pushed.

-- 
Best regards, 
Szymon Janc
