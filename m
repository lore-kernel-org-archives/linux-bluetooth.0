Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1510171164.3313.10.camel@hadess.net>
Subject: Re: [PATCH v2 2/2] plugins/sixaxis: Provide DualShock 3 SDP record
 while adding new device
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Wed, 08 Nov 2017 20:59:24 +0100
In-Reply-To: <20171108193828.5471-2-hadess@hadess.net>
References: <20171108193828.5471-1-hadess@hadess.net>
         <20171108193828.5471-2-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-11-08 at 20:38 +0100, Bastien Nocera wrote:
> This allows to skip SDP search for DualShock 3 devices, since some
> DS3 clones do not provide any SDP record. This allows them to operate
> nonetheless.
> 
> The HID SDP record is lifted straight off an original DualShock 3
> controller. The PNPID SDP record is not set as not required to
> provide
> a working device.
> 
> Tested with a "SHANWAN" clone controller.
> ---
>  plugins/sixaxis.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index 22e4bb537..c5f90498d 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -40,6 +40,8 @@
>  
>  #include "lib/bluetooth.h"
>  #include "lib/sdp.h"
> +#include "lib/sdp_lib.h"
> +#include "lib/sdp.h"

If whoever pushes this could remove this hunk of the patch, or I can
spin a v3, let me know.
