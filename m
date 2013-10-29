Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1383040097-15475-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383040097-15475-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Tue, 29 Oct 2013 13:15:41 +0200
Message-ID: <CABBYNZLbiUKxQKmvOquUaxN8r1hz5LgThBDfcYo6fQ+6AhDLpA@mail.gmail.com>
Subject: Re: [PATCH_v3 1/2] android: Add initial HID connect implementation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Oct 29, 2013 at 11:48 AM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> Implemented basic HID connect method. Host connects to
> bt device at L2CAP level.
> ---
> v3: Updated patches as per Luiz comments (remove unnecessary
>     type cast and tabs)
>
> v2: Updated patches as per Luiz comments
>
> v1: Patchset adds hid connect and disconnect mechanisms at
>     L2CAP level. It opens the control channel and interrupt
>     channel and listens on io events. UHID, hid server and
> ---
>  Makefile.android   |    3 +-
>  android/Android.mk |    1 +
>  android/hid.c      |  245 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 248 insertions(+), 1 deletion(-)
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
> index f2da0d3..913dab4 100644
> --- a/android/hid.c
> +++ b/android/hid.c
> @@ -23,16 +23,260 @@
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
> +struct hid_device {
> +       bdaddr_t        dst;
> +       GIOChannel      *ctrl_io;
> +       GIOChannel      *intr_io;
> +       guint           ctrl_watch;
> +       guint           intr_watch;
> +};
> +
> +static int device_cmp(gconstpointer s, gconstpointer user_data)
> +{
> +       const struct hid_device *hdev = s;
> +       const bdaddr_t *dst = user_data;
> +
> +       return bacmp(&hdev->dst, dst);
> +}
> +
> +static void hid_device_free(struct hid_device *hdev)
> +{
> +       if (hdev->ctrl_watch > 0)
> +               g_source_remove(hdev->ctrl_watch);
> +
> +       if (hdev->intr_watch > 0)
> +               g_source_remove(hdev->intr_watch);
> +
> +       if (hdev->intr_io)
> +               g_io_channel_unref(hdev->intr_io);
> +
> +       if (hdev->ctrl_io)
> +               g_io_channel_unref(hdev->ctrl_io);
> +
> +       devices = g_slist_remove(devices, hdev);
> +       g_free(hdev);
> +}
> +
> +static gboolean intr_io_watch_cb(GIOChannel *chan, gpointer data)
> +{
> +       char buf[MAX_READ_BUFFER];
> +       int fd, bread;
> +
> +       fd = g_io_channel_unix_get_fd(chan);
> +       bread = read(fd, buf, sizeof(buf));
> +       if (bread < 0) {
> +               error("read: %s(%d)", strerror(errno), -errno);
> +               return TRUE;
> +       }
> +
> +       DBG("bytes read %d", bread);
> +
> +       /* TODO: At this moment only baseband is connected, i.e. mouse
> +        * movements keyboard events doesn't effect on UI. Have to send
> +        * this data to uhid fd for profile connection. */
> +
> +       return TRUE;
> +}
> +
> +static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond,
> +                                                               gpointer data)
> +{
> +       struct hid_device *hdev = data;
> +       char address[18];
> +
> +       if (cond & G_IO_IN)
> +               return intr_io_watch_cb(chan, data);
> +
> +       ba2str(&hdev->dst, address);
> +       DBG("Device %s disconnected", address);
> +
> +       /* Checking for ctrl_watch avoids a double g_io_channel_shutdown since
> +        * it's likely that ctrl_watch_cb has been queued for dispatching in
> +        * this mainloop iteration */
> +       if ((cond & (G_IO_HUP | G_IO_ERR)) && hdev->ctrl_watch)
> +               g_io_channel_shutdown(chan, TRUE, NULL);
> +
> +       hdev->intr_watch = 0;
> +
> +       if (hdev->intr_io) {
> +               g_io_channel_unref(hdev->intr_io);
> +               hdev->intr_io = NULL;
> +       }
> +
> +       /* Close control channel */
> +       if (hdev->ctrl_io && !(cond & G_IO_NVAL))
> +               g_io_channel_shutdown(hdev->ctrl_io, TRUE, NULL);
> +
> +       return FALSE;
> +}
> +
> +static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond,
> +                                                               gpointer data)
> +{
> +       struct hid_device *hdev = data;
> +       char address[18];
> +
> +       ba2str(&hdev->dst, address);
> +       DBG("Device %s disconnected", address);
> +
> +       /* Checking for intr_watch avoids a double g_io_channel_shutdown since
> +        * it's likely that intr_watch_cb has been queued for dispatching in
> +        * this mainloop iteration */
> +       if ((cond & (G_IO_HUP | G_IO_ERR)) && hdev->intr_watch)
> +               g_io_channel_shutdown(chan, TRUE, NULL);
> +
> +       hdev->ctrl_watch = 0;
> +
> +       if (hdev->ctrl_io) {
> +               g_io_channel_unref(hdev->ctrl_io);
> +               hdev->ctrl_io = NULL;
> +       }
> +
> +       if (hdev->intr_io && !(cond & G_IO_NVAL))
> +               g_io_channel_shutdown(hdev->intr_io, TRUE, NULL);
> +
> +       return FALSE;
> +}
> +
> +static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
> +                                                       gpointer user_data)
> +{
> +       struct hid_device *hdev = user_data;
> +
> +       DBG("");
> +
> +       if (conn_err)
> +               goto failed;
> +
> +       /*TODO: Get device details through SDP and create UHID fd and start
> +        * listening on uhid events */
> +       hdev->intr_watch = g_io_add_watch(hdev->intr_io,
> +                               G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +                               intr_watch_cb, hdev);
> +
> +       return;
> +
> +failed:
> +       /* So we guarantee the interrupt channel is closed before the
> +        * control channel (if we only do unref GLib will close it only
> +        * after returning control to the mainloop */
> +       if (!conn_err)
> +               g_io_channel_shutdown(hdev->intr_io, FALSE, NULL);
> +
> +       g_io_channel_unref(hdev->intr_io);
> +       hdev->intr_io = NULL;
> +
> +       if (hdev->ctrl_io) {
> +               g_io_channel_unref(hdev->ctrl_io);
> +               hdev->ctrl_io = NULL;
> +       }
> +}
> +
> +static void control_connect_cb(GIOChannel *chan, GError *conn_err,
> +                                                       gpointer user_data)
> +{
> +       struct hid_device *hdev = user_data;
> +       GError *err = NULL;
> +       const bdaddr_t *src = bt_adapter_get_address();
> +
> +       DBG("");
> +
> +       if (conn_err) {
> +               error("%s", conn_err->message);
> +               goto failed;
> +       }
> +
> +       /* Connect to the HID interrupt channel */
> +       hdev->intr_io = bt_io_connect(interrupt_connect_cb, hdev, NULL, &err,
> +                                       BT_IO_OPT_SOURCE_BDADDR, src,
> +                                       BT_IO_OPT_DEST_BDADDR, &hdev->dst,
> +                                       BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
> +                                       BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
> +                                       BT_IO_OPT_INVALID);
> +       if (!hdev->intr_io) {
> +               error("%s", err->message);
> +               g_error_free(err);
> +               goto failed;
> +       }
> +
> +       hdev->ctrl_watch = g_io_add_watch(hdev->ctrl_io,
> +                                       G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> +                                       ctrl_watch_cb, hdev);
> +
> +       return;
> +
> +failed:
> +       g_io_channel_unref(hdev->ctrl_io);
> +       hdev->ctrl_io = NULL;
> +}
> +
> +static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
> +{
> +       struct hid_device *hdev;
> +       char addr[18];
> +       bdaddr_t dst;
> +       GSList *l;
> +       GError *err = NULL;
> +       const bdaddr_t *src = bt_adapter_get_address();
> +
> +       DBG("");
> +
> +       if (len < sizeof(*cmd))
> +               return HAL_STATUS_INVALID;
> +
> +       android2bdaddr(&cmd->bdaddr, &dst);
> +
> +       l = g_slist_find_custom(devices, &dst, device_cmp);
> +       if (l)
> +               return HAL_STATUS_FAILED;
> +
> +       hdev = g_new0(struct hid_device, 1);
> +       android2bdaddr(&cmd->bdaddr, &hdev->dst);
> +       ba2str(&hdev->dst, addr);
> +
> +       DBG("connecting to %s", addr);
> +
> +       hdev->ctrl_io = bt_io_connect(control_connect_cb, hdev, NULL, &err,
> +                                       BT_IO_OPT_SOURCE_BDADDR, src,
> +                                       BT_IO_OPT_DEST_BDADDR, &hdev->dst,
> +                                       BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
> +                                       BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
> +                                       BT_IO_OPT_INVALID);
> +       if (err) {
> +               error("%s", err->message);
> +               g_error_free(err);
> +               hid_device_free(hdev);
> +               return HAL_STATUS_FAILED;
> +       }
> +
> +       devices = g_slist_append(devices, hdev);
> +
> +       return HAL_STATUS_SUCCESS;
> +}
>
>  void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
>  {
> @@ -40,6 +284,7 @@ void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
>
>         switch (opcode) {
>         case HAL_OP_HID_CONNECT:
> +               status = bt_hid_connect(buf, len);
>                 break;
>         case HAL_OP_HID_DISCONNECT:
>                 break;
> --
> 1.7.9.5

Pushed, thanks.


-- 
Luiz Augusto von Dentz
