Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] android/hid: Support handshake message
Date: Wed, 19 Nov 2014 20:37:19 +0100
Message-ID: <1526762.qfkgHaSOJK@leonov>
In-Reply-To: <1416233218-16456-3-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416233218-16456-1-git-send-email-jakub.tyszkowski@tieto.com> <1416233218-16456-3-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Monday 17 of November 2014 15:06:57 Jakub Tyszkowski wrote:
> ---
>  android/hidhost.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/android/hidhost.c b/android/hidhost.c
> index 657fa8f..ba44af0 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -80,6 +80,9 @@
>  /* HID Virtual Cable Unplug */
>  #define HID_VIRTUAL_CABLE_UNPLUG	0x05
> 
> +/* HID Max. Handshake status code */
> +#define HID_HANDSHAKE_ERROR	0x05

This should be specified in IPC document and headers (this is enum).

> +
>  #define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
> 
>  static bdaddr_t adapter_addr;
> @@ -391,6 +394,24 @@ send:
>  	g_free(ev);
>  }
> 
> +static void bt_hid_notify_handshake(struct hid_device *dev, uint8_t *buf,
> +									int len)
> +{
> +	struct hal_ev_hidhost_handshake ev;
> +	int ev_len;
> +
> +	ev_len = sizeof(ev);

ev_len is not needed, just pass sizeof() directly.

> +	bdaddr2android(&dev->dst, ev.bdaddr);
> +
> +	/* crop result code to HAL range */
> +	ev.status = buf[0];
> +	if (ev.status > HID_HANDSHAKE_ERROR)
> +		ev.status = HID_HANDSHAKE_ERROR;
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HIDHOST,
> +					HAL_EV_HIDHOST_HANDSHAKE, ev_len, &ev);
> +}
> +
>  static void bt_hid_notify_virtual_unplug(struct hid_device *dev,
>  							uint8_t *buf, int len)
>  {
> @@ -441,7 +462,9 @@ static gboolean ctrl_io_watch_cb(GIOChannel *chan,
> gpointer data) break;
>  	}
> 
> -	if (buf[0] == (HID_MSG_CONTROL | HID_VIRTUAL_CABLE_UNPLUG))
> +	if (buf[0] < HID_MSG_CONTROL)
> +		bt_hid_notify_handshake(dev, buf, bread);
> +	else if (buf[0] == (HID_MSG_CONTROL | HID_VIRTUAL_CABLE_UNPLUG))
>  		bt_hid_notify_virtual_unplug(dev, buf, bread);

This looks strange, is this value or bitmask?

> 
>  	/* reset msg type request */

-- 
BR
Szymon Janc
