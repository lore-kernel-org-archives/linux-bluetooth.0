Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Nov 2013 14:15:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 4/9] android/hal-sock: Initial listen handle
Message-ID: <20131113121537.GA11291@x220.p-661hnu-f1>
References: <1384178627-25991-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1384178627-25991-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384178627-25991-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Nov 11, 2013, Andrei Emeltchenko wrote:
> Handle HAL socket listen call. Create RFCOMM socket and wait for events.
> ---
>  android/socket.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 92 insertions(+), 2 deletions(-)
> 
> diff --git a/android/socket.c b/android/socket.c
> index c283c5f..80cb39e 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -27,22 +27,112 @@
>  
>  #include <glib.h>
>  #include <stdbool.h>
> +#include <errno.h>
>  
>  #include "lib/bluetooth.h"
> +#include "btio/btio.h"
>  #include "log.h"
>  #include "hal-msg.h"
>  #include "hal-ipc.h"
>  #include "ipc.h"
> +#include "adapter.h"
>  #include "socket.h"
>  
> +/* Simple list of RFCOMM server sockets */
> +GList *rfcomm_srv_list = NULL;
> +/* Simple list of RFCOMM accepted sockets */
> +GList *rfcomm_accepted_list = NULL;

What are these lists needed for? When/how will their items be freed?
How about calling them "servers" and "connections"?

> +struct rfcomm_slot {
> +	int fd;
> +	int hal_fd;
> +	int real_sock;
> +	uint32_t channel;
> +};

You should really have comments here for what each struct member is used
for (you have this info in your cover letter but it should also be part
of the code). Why do you keep hal_fd here? Shouldn't we close it on our
side as soon as we've handed it over to the HAL? Why do you use uint32_t
for the channel? RFCOMM channels are uint8_t and have a range of 1-31.

> +static struct rfcomm_slot *create_rfslot(int sock)
>  {
> -	DBG("Not implemented");
> +	int fds[2] = {-1, -1};
> +	struct rfcomm_slot *rfslot;
> +
> +	if (socketpair(AF_LOCAL, SOCK_STREAM, 0, fds) < 0) {
> +		error("socketpair(): %s", strerror(errno));
> +		return NULL;
> +	}
> +
> +	rfslot = g_malloc0(sizeof(*rfslot));
> +	rfslot->fd = fds[0];
> +	rfslot->hal_fd = fds[1];
> +	rfslot->real_sock = sock;
> +
> +	return rfslot;
> +}
> +
> +static const uint8_t UUID_PBAP[] = {
> +	0x00, 0x00, 0x11, 0x2F, 0x00, 0x00, 0x10, 0x00,
> +	0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
> +};
> +#define RFCOMM_CHAN_PBAP 19
> +
> +static const uint8_t UUID_OPP[] = {
> +	0x00, 0x00, 0x11, 0x05, 0x00, 0x00, 0x10, 0x00,
> +	0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
> +};
> +#define RFCOMM_CHAN_OPP 12

A table would probably make more sense here. What about the SDP records
that need to be registered? Also, I'd stick to the assigned numbers from
our doc/assigned-numbers.txt.

> +static int handle_listen(void *buf)
> +{
> +	struct hal_cmd_sock_listen *cmd = buf;
> +	const bdaddr_t *src = bt_adapter_get_address();
> +	struct rfcomm_slot *rfslot;
> +	GIOChannel *io;
> +	GError *err = NULL;
> +	int ch;
> +
> +	DBG("");
> +
> +	ch = get_rfcomm_chan(cmd->uuid);
> +	if (ch < 0)
> +		return -1;
> +
> +	DBG("rfcomm channel %u", ch);
> +
> +	rfslot = create_rfslot(-1);
> +
> +	io = bt_io_listen(connect_cb, NULL, rfslot, NULL, &err,
> +				BT_IO_OPT_SOURCE_BDADDR, src,
> +				BT_IO_OPT_CHANNEL, ch,
> +				BT_IO_OPT_INVALID);

Might make sense to pass a proper GDestroyNotify callback here so that
once you finally implement proper freeing of data it can be done in a
clean way.

Johan
