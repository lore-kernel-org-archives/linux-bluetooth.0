Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1483012139.2308.9.camel@hadess.net>
Subject: Re: [PATCH v2 4/4] Add new DS4 controller PID into special case
 handler
From: Bastien Nocera <hadess@hadess.net>
To: Juha Kuikka <juha.kuikka@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@synapse.com, frank.praznik@gmail.com,
        roderick.colenbrander@sony.com
Date: Thu, 29 Dec 2016 12:48:59 +0100
In-Reply-To: <1482971563-15745-5-git-send-email-juha.kuikka@gmail.com>
References: <1482971563-15745-1-git-send-email-juha.kuikka@gmail.com>
         <1482971563-15745-5-git-send-email-juha.kuikka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2016-12-28 at 16:32 -0800, Juha Kuikka wrote:
> There is a special path for various game controllers where they
> connect
> to the hid service before bluetoothd knows what they are.
> 
> This patch adds another PID for the Dualshock4 controller. This new
> PID
> matches with the model number CUH-ZCT2U.
> ---
>  profiles/input/server.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/profiles/input/server.c b/profiles/input/server.c
> index eb3fcf8..3576f2b 100644
> --- a/profiles/input/server.c
> +++ b/profiles/input/server.c
> @@ -135,8 +135,10 @@ static bool dev_is_sixaxis(const bdaddr_t *src,
> const bdaddr_t *dst)
>  	if (vid == 0x054c && pid == 0x0268)
>  		return true;
>  
> -	/* DualShock 4 */
> -	if (vid == 0x054c && pid == 0x05c4)
> +	/* DualShock 4 CUH-ZCT1U (PID 0x05c4)
> +	 * DualShock 4 CUH-ZCT2U (PID 0x09cc) (slim/pro)
> +	 */
> +	if (vid == 0x054c && (pid == 0x05c4 || pid == 0x09cc))
>  		return true;
>  
>  	/* Navigation Controller */

Might be nice to have the struct you currently have in the sixaxis
plugin in a shared header, so we don't need to open code this function.
For example:

typedef enum {
  CABLE_PAIRING_SIXAXIS,
  CABLE_PAIRING_DS4
} CablePairingType;

static struct {
  int vid;
  int pid;
  CablePairingType type;
} cable_pairing_devices[] = {
  ...
};

The sixaxis plugin would know which functions to use from the type, the
input/server.c code would loop over the array to see whether it's a
cable pairing.

Looks fine otherwise.
