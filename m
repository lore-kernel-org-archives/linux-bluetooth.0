Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1408698180-23301-2-git-send-email-jakub.tyszkowski@tieto.com>
References: <1408698180-23301-1-git-send-email-jakub.tyszkowski@tieto.com>
	<1408698180-23301-2-git-send-email-jakub.tyszkowski@tieto.com>
Date: Mon, 25 Aug 2014 12:38:30 +0300
Message-ID: <CABBYNZ+5LPNFevacH4P6xXJhGjVLVgM98a10UyPo-iaMyg3UWg@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] android/hid: Reject connections from unknown devices
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Fri, Aug 22, 2014 at 12:02 PM, Jakub Tyszkowski
<jakub.tyszkowski@tieto.com> wrote:
> Don't accept input from not bonded devices.
> ---
>  android/hidhost.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/android/hidhost.c b/android/hidhost.c
> index da5f818..07985d8 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -1410,6 +1410,20 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>         ba2str(&dst, address);
>         DBG("Incoming connection from %s on PSM %d", address, psm);
>
> +       if (!bt_device_is_bonded(&dst)) {
> +               uint8_t hdr = (HID_MSG_CONTROL | HID_VIRTUAL_CABLE_UNPLUG);
> +               int sk = g_io_channel_unix_get_fd(chan);
> +
> +               warn("hidhost: Rejected connection from unknown device %s",
> +                                                               address);
> +
> +               if (write(sk, &hdr, sizeof(hdr)) < 0)
> +                       error("hidhost: Unable to send virtual cable unplug");
> +
> +               g_io_channel_shutdown(chan, TRUE, NULL);
> +               return;
> +       }
> +
>         switch (psm) {
>         case L2CAP_PSM_HIDP_CTRL:
>                 l = g_slist_find_custom(devices, &dst, device_cmp);
> --
> 1.9.1

I think we can a helper function to send HID_VIRTUAL_CABLE_UNPLUG,
that way we can share code with bt_hid_virtual_unplug


-- 
Luiz Augusto von Dentz
