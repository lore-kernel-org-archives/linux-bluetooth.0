Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382971653-11727-2-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1382971653-11727-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<1382971653-11727-2-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Mon, 28 Oct 2013 17:06:45 +0200
Message-ID: <CABBYNZ+zGc3axki4Je+R5bR_UVa0NrV216R6_6eH9gkPGVLfoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] android: Add initial HID connect implementation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Mon, Oct 28, 2013 at 4:47 PM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> Implemented basic HID connect method. Host connects to
> bt device at L2CAP level.
> ---
>  Makefile.android   |    3 +-
>  android/Android.mk |    1 +
>  android/hid.c      |  237 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 240 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile.android b/Makefile.android
> index 2b57daa..22002be 100644
> --- a/Makefile.android
> +++ b/Makefile.android
> @@ -12,7 +12,8 @@ android_bluetoothd_SOURCES =  android/main.c \
>                                 android/adapter.h android/adapter.c \
>                                 android/hid.h android/hid.c \
>                                 android/ipc.h android/ipc.c \
> -                               android/socket.h android/socket.c
> +                               android/socket.h android/socket.c \
> +                               btio/btio.h btio/btio.c
>
>  android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
>
> diff --git a/android/Android.mk b/android/Android.mk
> index 22208e0..28ec465 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -28,6 +28,7 @@ LOCAL_SRC_FILES := \
>         ../lib/sdp.c \
>         ../lib/bluetooth.c \
>         ../lib/hci.c \
> +       ../btio/btio.c
>
>  LOCAL_C_INCLUDES := \
>         $(call include-path-for, glib) \
> diff --git a/android/hid.c b/android/hid.c
> index f2da0d3..b7bdc07 100644
> --- a/android/hid.c
> +++ b/android/hid.c
> @@ -23,16 +23,252 @@
>
>  #include <stdint.h>
>  #include <stdbool.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <fcntl.h>
>
>  #include <glib.h>
>
> +#include "btio/btio.h"
>  #include "lib/bluetooth.h"
> +#include "src/shared/mgmt.h"
> +
>  #include "log.h"
>  #include "hal-msg.h"
>  #include "ipc.h"
>  #include "hid.h"
> +#include "adapter.h"
> +#include "utils.h"
> +
> +#define L2CAP_PSM_HIDP_CTRL    0x11
> +#define L2CAP_PSM_HIDP_INTR    0x13
> +#define MAX_READ_BUFFER                4096
>
>  static GIOChannel *notification_io = NULL;
> +static GSList *devices = NULL;
> +
> +struct input_device {
> +       bdaddr_t        src;
> +       bdaddr_t        dst;
> +       GIOChannel      *ctrl_io;
> +       GIOChannel      *intr_io;
> +       guint           ctrl_watch;
> +       guint           intr_watch;
> +};


You probably don't need the address of the adapter as there could be
only one in android you can always query its value via
bt_adapter_get_address.

> +static uint8_t dev_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
> +{
> +       struct input_device *idev;
> +       char addr[18];
> +       GError *err = NULL;
> +
> +       DBG("");
> +
> +       if (len < sizeof(*cmd))
> +               return HAL_STATUS_INVALID;
> +
> +       idev = g_new0(struct input_device, 1);
> +       bacpy(&idev->src, bt_adapter_get_address());
> +       android2bdaddr((bdaddr_t *)&cmd->bdaddr, &idev->dst);
> +       ba2str(&idev->dst, addr);

Might be worth checking if there a connection ongoing before you
create a new data, I would also avoid having the same struct names
from our input plugin, just use something else like hid_data.

> +
> +       DBG("connecting to %s", addr);
> +
> +       idev->ctrl_io = bt_io_connect(control_connect_cb, idev, NULL, &err,
> +                                       BT_IO_OPT_SOURCE_BDADDR, &idev->src,
> +                                       BT_IO_OPT_DEST_BDADDR, &idev->dst,
> +                                       BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
> +                                       BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
> +                                       BT_IO_OPT_INVALID);
> +       if (err) {
> +               error("%s", err->message);
> +               g_error_free(err);
> +               input_device_free(idev);
> +               return HAL_STATUS_FAILED;
> +       }
> +
> +       devices = g_slist_append(devices, idev);
> +
> +       return HAL_STATUS_SUCCESS;
> +}
>
>  void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
>  {
> @@ -40,6 +276,7 @@ void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
>
>         switch (opcode) {
>         case HAL_OP_HID_CONNECT:
> +               status = dev_connect((struct hal_cmd_hid_connect *) buf, len);

Call it hid_connect or bt_hid_connect.



-- 
Luiz Augusto von Dentz
