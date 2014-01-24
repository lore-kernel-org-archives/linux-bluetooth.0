Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Jan 2014 13:27:41 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 6/8] android/AVRCP: Add implementation of SDP record
Message-ID: <20140124112703.GC1671@aemeltch-MOBL1>
References: <1390495198-28400-1-git-send-email-luiz.dentz@gmail.com>
 <1390495198-28400-6-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390495198-28400-6-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jan 23, 2014 at 06:39:56PM +0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds the following record:
> 
> Service Name: AVRCP TG
> Service RecHandle: 0x10002
> Service Class ID List:
>   "AV Remote Target" (0x110c)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>     PSM: 23
>   "AVCTP" (0x0017)
>     uint16: 0x103
> Profile Descriptor List:
>   "AV Remote" (0x110e)
>     Version: 0x0100
> ---
>  android/avrcp.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/android/avrcp.c b/android/avrcp.c
> index 707506b..02dbb68 100644
> --- a/android/avrcp.c
> +++ b/android/avrcp.c
> @@ -29,22 +29,116 @@
>  #include <glib.h>
>  
>  #include "lib/bluetooth.h"
> +#include "lib/sdp.h"
> +#include "lib/sdp_lib.h"
>  #include "log.h"
> +#include "bluetooth.h"
>  #include "avrcp.h"
>  #include "hal-msg.h"
>  #include "ipc.h"
>  
> +#define L2CAP_PSM_AVCTP 0x17
> +
> +#define AVRCP_FEATURE_CATEGORY_1	0x0001
> +#define AVRCP_FEATURE_CATEGORY_2	0x0002
> +#define AVRCP_FEATURE_CATEGORY_3	0x0004
> +#define AVRCP_FEATURE_CATEGORY_4	0x0008
> +
>  static bdaddr_t adapter_addr;
> +static uint32_t record_id = 0;
>  
>  static const struct ipc_handler cmd_handlers[] = {
>  };
>  
> +static sdp_record_t *avrcp_record(void)
> +{
> +	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> +	uuid_t root_uuid, l2cap, avctp, avrtg;
> +	sdp_profile_desc_t profile[1];
> +	sdp_list_t *aproto_control, *proto_control[2];
> +	sdp_record_t *record;
> +	sdp_data_t *psm, *version, *features;
> +	uint16_t lp = L2CAP_PSM_AVCTP;
> +	uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103;
> +	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
> +					AVRCP_FEATURE_CATEGORY_2 |
> +					AVRCP_FEATURE_CATEGORY_3 |
> +					AVRCP_FEATURE_CATEGORY_4);
> +
> +	record = sdp_record_alloc();
> +	if (!record)
> +		return NULL;
> +
> +	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
> +	root = sdp_list_append(0, &root_uuid);

Should be NULL here and below.

Best regards 
Andrei Emeltchenko 

