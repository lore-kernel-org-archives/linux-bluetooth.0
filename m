Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1387796839-8164-1-git-send-email-szymon.janc@tieto.com>
References: <1387796839-8164-1-git-send-email-szymon.janc@tieto.com>
Date: Mon, 23 Dec 2013 14:48:36 +0200
Message-ID: <CABBYNZ+NaBUAMxRUJL=Z_MWVUuj4jqWEiqtC1ofs7JXtReVn0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] android/bluetooth: Add support for DUT mode
 configure command
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 23, 2013 at 1:07 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> This allows to enable and disable DUT mode. This is special mode so
> adding more info from related kernel commit:
>
> "The Device Under Test (DUT) mode is useful for doing certification
> testing and so expose this as debugfs option.
>
> This mode is actually special since you can only enter it. Restoring
> normal operation means that a HCI Reset is required. The current mode
> value gets tracked as a new device flag and when disabling it, the
> correct command to reset the controller is sent."
> ---
>  android/bluetooth.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 2e75864..59f0810 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -50,6 +50,8 @@
>  #include "utils.h"
>  #include "bluetooth.h"
>
> +#define DUT_MODE_FILE "/sys/kernel/debug/bluetooth/hci%u/dut_mode"
> +
>  #define DEVICE_ID_SOURCE       0x0002  /* USB */
>  #define DEVICE_ID_VENDOR       0x1d6b  /* Linux Foundation */
>  #define DEVICE_ID_PRODUCT      0x0247  /* BlueZ for Android */
> @@ -2872,13 +2874,34 @@ failed:
>  static void handle_dut_mode_conf_cmd(const void *buf, uint16_t len)
>  {
>         const struct hal_cmd_dut_mode_conf *cmd = buf;
> +       char path[FILENAME_MAX];
> +       uint8_t status;
> +       int fd, ret;
>
>         DBG("enable %u", cmd->enable);
>
> -       /* TODO */
> +       snprintf(path, sizeof(path), DUT_MODE_FILE, adapter.index);
>
> -       ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_CONF,
> -                                                       HAL_STATUS_FAILED);
> +       fd = open(path, O_WRONLY);
> +       if (fd < 0) {
> +               status = HAL_STATUS_FAILED;
> +               goto failed;
> +       }
> +
> +       if (cmd->enable)
> +               ret = write(fd, "1", sizeof("1"));
> +       else
> +               ret = write(fd, "0", sizeof("0"));
> +
> +       if (ret < 0)
> +               status = HAL_STATUS_FAILED;
> +       else
> +               status = HAL_STATUS_SUCCESS;
> +
> +       close(fd);
> +
> +failed:
> +       ipc_send_rsp(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_CONF, status);
>  }
>
>  static void handle_dut_mode_send_cmd(const void *buf, uint16_t len)
> --
> 1.8.3.2

Pushed, thanks.


-- 
Luiz Augusto von Dentz
