Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: btintel: remove extraneous semicolon
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180126130652.3499127-1-arnd@arndb.de>
Date: Fri, 26 Jan 2018 16:22:39 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Tedd Ho-Jeong An <tedd.an@linux.intel.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <EBF0FA29-819E-4419-84D1-9CE22E8AE0A5@holtmann.org>
References: <20180126130652.3499127-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arnd,

> The newly added btintel_download_firmware() dummy helper definition is
> incorrect, causing a build error when CONFIG_BT_INTEL is disabled:
> 
> In file included from drivers/bluetooth/hci_ldisc.c:49:0:
> drivers/bluetooth/btintel.h:196:1: error: expected identifier or '(' before '{' token
> drivers/bluetooth/btintel.h:193:19: error: 'btintel_download_firmware' declared 'static' but never defined [-Werror=unused-function]
> 
> Removing the semicolon makes it work again.
> 
> Fixes: 0bd4ded3287d ("Bluetooth: btintel: Create common function for firmware download")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> drivers/bluetooth/btintel.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 01728e212267..41c642cc523f 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -192,7 +192,7 @@ static inline int btintel_read_boot_params(struct hci_dev *hdev,
> 
> static inline int btintel_download_firmware(struct hci_dev *dev,
> 					    const struct firmware *fw,
> -					    u32 *boot_param);
> +					    u32 *boot_param)
> {
> 	return -EOPNOTSUPP;
> }

didn’t I fix this before sending the pull request? Can you check against net-next tree that this is still an issue?

Regards

Marcel
