Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Jan 2014 10:59:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/pan: Register Network Access Point
Message-ID: <20140107085930.GB9155@x220.p-661hnu-f1>
References: <1389043592-5616-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1389043592-5616-2-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389043592-5616-2-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Mon, Jan 06, 2014, Ravi kumar Veeramally wrote:
> Register NAP server and adds bnep bridge. Removes bridge
> on destroy call. Bridge mechanism is needed when device acting
> as a server and listen for incoming connections.
> ---
>  android/pan.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 112 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pan.c b/android/pan.c
> index 38e353d..93f712f 100644
> --- a/android/pan.c
> +++ b/android/pan.c
> @@ -28,6 +28,11 @@
>  #include <unistd.h>
>  #include <fcntl.h>
>  #include <glib.h>
> +#include <sys/ioctl.h>
> +#include <sys/socket.h>
> +#include <sys/wait.h>
> +#include <net/if.h>
> +#include <linux/sockios.h>
>  
>  #include "btio/btio.h"
>  #include "lib/bluetooth.h"
> @@ -49,7 +54,7 @@
>  static bdaddr_t adapter_addr;
>  GSList *devices = NULL;
>  uint8_t local_role = HAL_PAN_ROLE_NONE;
> -static uint32_t record_id = 0;
> +char bridge[5] = "bnep\0";

This last line raises several questions. Firstly, C-strings have an
implicit nul-character at the end so no need to explicitly try to add
one there. You also don't need to have an explicit size between the
square brackets since this is automatically calculated if you do
initialization upon declaration. Why isn't this static? Why isn't it
const? Would a simple define make more sense instead of a dedicated
variable?

Johan
