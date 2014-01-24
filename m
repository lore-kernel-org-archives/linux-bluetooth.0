Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Jan 2014 13:22:48 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 6/8] android/AVRCP: Add implementation of SDP record
Message-ID: <20140124112245.GB1671@aemeltch-MOBL1>
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

Can we use the same name like in profiles?
AVCTP_CONTROL_PSM

Best regards 
Andrei Emeltchenko 

