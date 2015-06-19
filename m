Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] tools/btproxy: Add -o option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434710024-1122-1-git-send-email-szymon.janc@tieto.com>
Date: Fri, 19 Jun 2015 12:49:54 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <06C609BB-B6A9-471C-B979-2B38556C05EB@holtmann.org>
References: <1434710024-1122-1-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This option allows to power off adapter before opening user channel.
> ---
> tools/btproxy.c | 36 ++++++++++++++++++++++++++++++------
> 1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/btproxy.c b/tools/btproxy.c
> index 43de037..962abe8 100644
> --- a/tools/btproxy.c
> +++ b/tools/btproxy.c
> @@ -40,10 +40,13 @@
> #include <sys/stat.h>
> #include <sys/socket.h>
> #include <sys/un.h>
> +#include <sys/ioctl.h>
> 
> #include <netdb.h>
> #include <arpa/inet.h>
> 
> +#include "lib/bluetooth.h"
> +#include "lib/hci.h"

I am not in favor of this since I want to start cleaning up the tools to not depend in libbluetooth. Instead this increases the dependencies.

> #include "src/shared/util.h"
> #include "src/shared/mainloop.h"
> #include "src/shared/ecc.h"
> @@ -53,17 +56,13 @@
> #define HCI_AMP		0x01
> 
> #define BTPROTO_HCI	1
> -struct sockaddr_hci {
> -	sa_family_t	hci_family;
> -	unsigned short	hci_dev;
> -	unsigned short  hci_channel;
> -};
> #define HCI_CHANNEL_USER	1
> 
> static uint16_t hci_index = 0;
> static bool client_active = false;
> static bool debug_enabled = false;
> static bool emulate_ecc = false;
> +static bool power_off = false;
> 
> static void hexdump_print(const char *str, void *user_data)
> {
> @@ -515,11 +514,31 @@ static bool setup_proxy(int host_fd, bool host_shutdown,
> 	return true;
> }
> 
> +static int power_off_controler(int index)
> +{
> +	int fd, ret;
> +
> +	fd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
> +	if (fd < 0)
> +		return -1;
> +
> +	ret = ioctl(fd, HCIDEVDOWN, index);
> +
> +	close(fd);
> +
> +	return ret;
> +}
> +

This is pretty brute-force operation. I am not sure this is actually a good idea. What is wrong that you bring down the adapter first manually before you start btproxy?

Regards

Marcel


--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
