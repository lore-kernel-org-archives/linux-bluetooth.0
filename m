Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v3 1/4] android/pan: Register Network Access Point
Date: Wed, 08 Jan 2014 10:18:27 +0100
Message-ID: <1697122.rgbbQeg154@uw000953>
In-Reply-To: <1389097880-14783-2-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389097880-14783-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1389097880-14783-2-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

> Register NAP server and adds bnep bridge. Removes bridge
> on destroy call. Bridge mechanism is needed when device acting
> as a server and listen for incoming connections.
> ---
>  android/pan.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 108 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pan.c b/android/pan.c
> index 38e353d..93078ba 100644
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
> @@ -45,11 +50,11 @@
>  #include "bluetooth.h"
>  
>  #define SVC_HINT_NETWORKING 0x02
> +#define BNEP_BRIDGE	"bnep"
>  
>  static bdaddr_t adapter_addr;
>  GSList *devices = NULL;
>  uint8_t local_role = HAL_PAN_ROLE_NONE;
> -static uint32_t record_id = 0;
>  
>  struct pan_device {
>  	char		iface[16];
> @@ -60,6 +65,12 @@ struct pan_device {
>  	struct bnep	*session;
>  };
>  
> +static struct {
> +	uint32_t	record_id;
> +} nap_dev = {
> +	.record_id = 0,
> +};
> +
>  static int device_cmp(gconstpointer s, gconstpointer user_data)
>  {
>  	const struct pan_device *dev = s;
> @@ -297,6 +308,91 @@ failed:
>  	ipc_send_rsp(HAL_SERVICE_ID_PAN, HAL_OP_PAN_DISCONNECT, status);
>  }
>  
> +static int set_forward_delay(void)
> +{
> +	int fd, ret;
> +	char path[41];
> +
> +	sprintf(path, "/sys/class/net/%s/bridge/forward_delay", BNEP_BRIDGE);
> +
> +	fd = open(path, O_RDWR);
> +	if (fd < 0)
> +		return -errno;
> +
> +	ret = write(fd, "0", sizeof("0"));
> +	close(fd);
> +
> +	return ret;
> +}
> +
> +static int nap_create_bridge(void)
> +{
> +	int sk, err;
> +
> +	DBG("%s", BNEP_BRIDGE);
> +
> +	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
> +	if (sk < 0)
> +		return -EOPNOTSUPP;
> +
> +	if (ioctl(sk, SIOCBRADDBR, BNEP_BRIDGE) < 0) {
> +		err = -errno;
> +		if (err != -EEXIST) {
> +			close(sk);
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	err = set_forward_delay();
> +	if (err < 0)
> +		ioctl(sk, SIOCBRDELBR, BNEP_BRIDGE);
> +
> +	close(sk);
> +
> +	return err;
> +}
> +
> +static int nap_remove_bridge(void)
> +{
> +	int sk, err;
> +
> +	DBG("%s", BNEP_BRIDGE);
> +
> +	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
> +	if (sk < 0)
> +		return -EOPNOTSUPP;
> +
> +	err = ioctl(sk, SIOCBRDELBR, BNEP_BRIDGE);
> +	close(sk);
> +
> +	if (err < 0)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +static void destroy_nap_device(void)
> +{
> +	DBG("");
> +
> +	nap_remove_bridge();
> +
> +	nap_dev.record_id = 0;
> +}
> +
> +static int register_nap_server(void)
> +{
> +	int err;
> +
> +	DBG("");
> +
> +	err = nap_create_bridge();
> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}
> +
>  static void bt_pan_enable(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_pan_enable *cmd = buf;
> @@ -441,7 +537,15 @@ bool bt_pan_register(const bdaddr_t *addr)
>  		return false;
>  	}
>  
> -	record_id = rec->handle;
> +	err = register_nap_server();
> +	if (err < 0) {
> +		bt_adapter_remove_record(rec->handle);
> +		sdp_record_free(rec);
> +		bnep_cleanup();
> +		return false;
> +	}
> +
> +	nap_dev.record_id = rec->handle;
>  	ipc_register(HAL_SERVICE_ID_PAN, cmd_handlers,
>  						G_N_ELEMENTS(cmd_handlers));
>  
> @@ -455,6 +559,6 @@ void bt_pan_unregister(void)
>  	bnep_cleanup();
>  
>  	ipc_unregister(HAL_SERVICE_ID_PAN);
> -	bt_adapter_remove_record(record_id);
> -	record_id = 0;
> +	bt_adapter_remove_record(nap_dev.record_id);
> +	destroy_nap_device();

I would either zero nap_dev.record_id right after removing record or move
removing record to destroy_nap_device().

-- 
BR
Szymon Janc

