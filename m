Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382971653-11727-3-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1382971653-11727-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<1382971653-11727-3-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Mon, 28 Oct 2013 16:53:18 +0200
Message-ID: <CABBYNZKeZCLfz+jf_9tubvxAw9hPc0pCVuskY4vNKo3heZA_JA@mail.gmail.com>
Subject: Re: [PATCH 2/2] android: Add initial HID disconnect implementation.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Mon, Oct 28, 2013 at 4:47 PM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> Implemented basic HID disconnect method. Host disconnects
> with bt device at L2CAP level.
> ---
>  android/hid.c |   23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/android/hid.c b/android/hid.c
> index b7bdc07..3e7ac0d 100644
> --- a/android/hid.c
> +++ b/android/hid.c
> @@ -270,6 +270,27 @@ static uint8_t dev_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
>         return HAL_STATUS_SUCCESS;
>  }
>
> +static uint8_t dev_disconnect(struct hal_cmd_hid_disconnect *cmd, uint16_t len)
> +{
> +       GSList *l;
> +       bdaddr_t dst;
> +
> +       DBG("");
> +
> +       if (len < sizeof(*cmd))
> +               return HAL_STATUS_INVALID;
> +
> +       android2bdaddr((bdaddr_t *)&cmd->bdaddr, &dst);
> +
> +       l = g_slist_find_custom(devices, &dst, device_cmp);
> +       if (!l)
> +               return HAL_STATUS_FAILED;
> +
> +       input_device_free(l->data);
> +
> +       return HAL_STATUS_SUCCESS;
> +}
> +
>  void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
>  {
>         uint8_t status = HAL_STATUS_FAILED;
> @@ -279,6 +300,8 @@ void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
>                 status = dev_connect((struct hal_cmd_hid_connect *) buf, len);
>                 break;
>         case HAL_OP_HID_DISCONNECT:
> +               status = dev_disconnect((struct hal_cmd_hid_disconnect *) buf,
> +                                                                       len);

Look at the other files, we are not doing the casts upfront but in the
function itself.


-- 
Luiz Augusto von Dentz
