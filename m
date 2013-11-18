Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Nov 2013 10:55:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 04/16] android/socket: Define structs and implement
 listen
Message-ID: <20131118085535.GC30170@x220.p-661hnu-f1>
References: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1384763179-2218-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384763179-2218-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Nov 18, 2013, Andrei Emeltchenko wrote:
> This defines structures for socket HAL. We need to emulate Android
> sockets by sending connect/accept signals over file descriptor.
> Handle HAL socket listen call. Create RFCOMM socket and wait for events.
> ---
>  android/socket.c |  118 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 116 insertions(+), 2 deletions(-)
> 
> diff --git a/android/socket.c b/android/socket.c
> index e580036..276c78c 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -27,8 +27,12 @@
>  
>  #include <glib.h>
>  #include <stdbool.h>
> +#include <unistd.h>
> +#include <errno.h>
>  
>  #include "lib/bluetooth.h"
> +#include "btio/btio.h"
> +#include "lib/sdp.h"
>  #include "log.h"
>  #include "hal-msg.h"
>  #include "hal-ipc.h"
> @@ -37,13 +41,123 @@
>  
>  static bdaddr_t adapter_addr;
>  
> -static int handle_listen(void *buf)
> +/* Simple list of RFCOMM server sockets */
> +GList *rfcomm_srv_list = NULL;
> +
> +/* Simple list of RFCOMM connected sockets */
> +GList *rfcomm_connected_list = NULL;

Didn't I suggest "servers" and "connections" as names for these?

> +struct rfcomm_slot {

The term "slot" seems a bit confusing to me. You're using this struct as
context for both server sockets and connected sockets. Would the name
struct rfcomm_socket make more sense? Feel free to suggest something
else too.

> +
> +	rfslot = g_malloc0(sizeof(*rfslot));

rfslot = g_new0(struct rfcom_slot, 1);

> +static void cleanup_rfslot(struct rfcomm_slot *rfslot)
> +{
> +	DBG("Cleanup: rfslot: %p fd %d real_sock %d chan %u",
> +		rfslot, rfslot->fd, rfslot->real_sock, rfslot->channel);

Since DBG() will anyway print the function name having an explicit
"Cleanup:" in the log message seems redundant.

> +static struct {
> +	uint8_t uuid[16];
> +	uint8_t channel;
> +} uuid_to_chan[] = {
> +	{ .uuid = {
> +	0x00, 0x00, 0x11, 0x2F, 0x00, 0x00, 0x10, 0x00,
> +	0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
> +	},

Why doesn't this first entry have a channel? Please indent the stuff
between { and } with an extra tab.

> +#define PBAP_DEFAULT_CHANNEL	15

I'd rather have these default channel definitions in a separate place,
probably in the beginning of the C-file where you can quickly see them.
Having them inline like this doesn't really provide any value at all
compared to just hard-coding them in the places where you have
.channel = ...

> +	{ .uuid = {
> +	0x00, 0x00, 0x11, 0x05, 0x00, 0x00, 0x10, 0x00,
> +	0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
> +	},
> +#define OPP_DEFAULT_CHANNEL	9
> +	.channel = OPP_DEFAULT_CHANNEL },

Is this the missing channel from the first entry? Looks misplaced to me.

> +static int get_rfcomm_default_chan(const uint8_t *uuid)
> +{
> +	int i;
> +
> +	for (i = 0; uuid_to_chan[i].channel; i++) {
> +		if (!memcmp(uuid_to_chan[i].uuid, uuid, 16))
> +			return uuid_to_chan[i].channel;
> +	}
>  
>  	return -1;

Maybe return -ENOENT?

> +static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
> +{
> +}
> +
> +static int handle_listen(void *buf)
> +{
> +	struct hal_cmd_sock_listen *cmd = buf;
> +	struct rfcomm_slot *rfslot;
> +	GIOChannel *io;
> +	GError *err = NULL;
> +	int hal_fd = -1;

Why do you need to pre-initialize hal_fd? If create_rfslot() can fail
can won't you detect that?

> +	int chan;
> +
> +	DBG("");
> +
> +	chan = get_rfcomm_default_chan(cmd->uuid);
> +	if (chan < 0)
> +		return -1;

Maybe "return chan;"?

Johan
