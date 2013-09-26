Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: acelan@gmail.com
In-Reply-To: <1380171766-21845-1-git-send-email-acelan.kao@canonical.com>
References: <1380171766-21845-1-git-send-email-acelan.kao@canonical.com>
Date: Thu, 26 Sep 2013 17:27:08 +0800
Message-ID: <CAMz9Wg-fekAJNGsYr_tO0zvX4NOx3H9bTrjgMuN3cRO_rUjb6Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ath3k: enlarge the usb urb timeout
From: AceLan Kao <acelan.kao@canonical.com>
To: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Sorry, please ignore this patch.
This is not the root cause, and it didn't fix the issue.

Best regards,
AceLan Kao.


2013/9/26 AceLan Kao <acelan.kao@canonical.com>:
> We encountered a issue that the time is not sufficient to load the firmware.
>
> [   14.646698] Bluetooth: Error in firmware loading err = -110,len = 448, size = 4096
> [   14.646710] Bluetooth: Loading patch file failed
> [   14.646719] ath3k: probe of 3-4:1.0 failed with error -110
>
> And according to the log, it needs 10 times time to finish the transfer,
> so, enlarge the timeout 10 times to overcome it.
>
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/bluetooth/ath3k.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index a12b923..2047deb 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -49,6 +49,8 @@
>  #define ATH3K_XTAL_FREQ_19P2                   0x02
>  #define ATH3K_NAME_LEN                         0xFF
>
> +#define USB_URB_TIMEOUT                                30000
> +
>  struct ath3k_version {
>         unsigned int    rom_version;
>         unsigned int    build_version;
> @@ -182,7 +184,7 @@ static int ath3k_load_firmware(struct usb_device *udev,
>                 memcpy(send_buf, firmware->data + sent, size);
>
>                 err = usb_bulk_msg(udev, pipe, send_buf, size,
> -                                       &len, 3000);
> +                                       &len, USB_URB_TIMEOUT);
>
>                 if (err || (len != size)) {
>                         BT_ERR("Error in firmware loading err = %d,"
> @@ -279,7 +281,7 @@ static int ath3k_load_fwfile(struct usb_device *udev,
>                 memcpy(send_buf, firmware->data + sent, size);
>
>                 err = usb_bulk_msg(udev, pipe, send_buf, size,
> -                                       &len, 3000);
> +                                       &len, USB_URB_TIMEOUT);
>                 if (err || (len != size)) {
>                         BT_ERR("Error in firmware loading err = %d,"
>                                 "len = %d, size = %d", err, len, size);
> --
> 1.8.3.2
>



-- 
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
