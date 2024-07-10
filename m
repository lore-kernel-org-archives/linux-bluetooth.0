Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B317FD;
	Wed, 10 Jul 2024 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609280; cv=none; b=f6YzkNrVVmIo3w67fuM6lh55JO3yQCm19l/fso1TcBaw2lc/5XQg9b5iKOjFNodHivIEn9LqDjTI2LypQ2AKU0gxSXrP6R+7q8jeYO4dctWefRVsiXJ2GXYmO0WY9orArUuf4GwF7Y/foehOhSNflze9EUMg6FkYWIMfMgtAT2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609280; c=relaxed/simple;
	bh=CTVf2zX3BBwBZucezxV+16F9kjB4D6ihhIVLyeOxcQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdKuSqm1H4ztsH33EefuiZOtp36RpuH2/SSxrbKcUbzxBWYkSIoEu4swHQ27IHQPR4b/6vT1xmoOnEAu/rpoOuyVR5RwPp+Ob/w9hHUznErZHkwBdw+ZqUaDcrGL0xNYBdJc/NK/EDa8lAbvjYK+uhdeeDwzN7AIGeX5Cs+EPuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 406A061E64862;
	Wed, 10 Jul 2024 13:00:39 +0200 (CEST)
Message-ID: <261d8aad-5188-4c08-8c3d-34c2e00db2e6@molgen.mpg.de>
Date: Wed, 10 Jul 2024 13:00:38 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btmtk: Fix btmtk.c undefined reference
 build error
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240710092614.7297-1-chris.lu@mediatek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240710092614.7297-1-chris.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chris,


Am 10.07.24 um 11:26 schrieb Chris Lu:
> MediaTek move some usb interface related function to btmtk.c which

move*d*

Maybe add … in commit XXX ("yyy") … in that sentence.

> may cause build failed if BT USB Kconfig wasn't enabled.

Is not enabling BT USB Kconfig when using btmtk a valid use-case?

> Fix undefined reference by adding config check.
> 
> btmtk.c:(.text+0x89c): undefined reference to `usb_alloc_urb'
> btmtk.c:(.text+0x8e3): undefined reference to `usb_free_urb'
> btmtk.c:(.text+0x956): undefined reference to `usb_free_urb'
> btmtk.c:(.text+0xa0e): undefined reference to `usb_anchor_urb'
> btmtk.c:(.text+0xb43): undefined reference to `usb_autopm_get_interface'
> btmtk.c:(.text+0xb7e): undefined reference to `usb_autopm_put_interface'
> btmtk.c:(.text+0xf70): undefined reference to `usb_disable_autosuspend'
> btmtk.c:(.text+0x133a): undefined reference to `usb_control_msg'
> 
> Fixes: 39a9e1c69e74 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407091928.AH0aGZnx-lkp@intel.com/
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
> Change from v1 to v2:
> -fix and update commit message warning
> ---
>   drivers/bluetooth/btmtk.c | 2 ++
>   drivers/bluetooth/btmtk.h | 4 ++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index b7c348687a77..9789296ad4f6 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -437,6 +437,7 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
>   }
>   EXPORT_SYMBOL_GPL(btmtk_process_coredump);
>   
> +#if IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK)
>   static void btmtk_usb_wmt_recv(struct urb *urb)
>   {
>   	struct hci_dev *hdev = urb->context;
> @@ -1487,6 +1488,7 @@ int btmtk_usb_shutdown(struct hci_dev *hdev)
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(btmtk_usb_shutdown);
> +#endif
>   
>   MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
>   MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 453ed5131a37..890dbe9beff8 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -165,6 +165,7 @@ struct btmtk_data {
>   	btmtk_reset_sync_func_t reset_sync;
>   	struct btmtk_coredump_info cd_info;
>   
> +#if IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK)
>   	struct usb_device *udev;
>   	struct usb_interface *intf;
>   	struct usb_anchor *ctrl_anchor;
> @@ -177,6 +178,7 @@ struct btmtk_data {
>   
>   	/* spinlock for ISO data transmission */
>   	spinlock_t isorxlock;
> +#endif
>   };
>   
>   typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
> @@ -202,6 +204,7 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
>   void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
>   			   u32 fw_flavor);
>   
> +#if IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK)
>   int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id);
>   
>   int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb);
> @@ -216,6 +219,7 @@ int btmtk_usb_suspend(struct hci_dev *hdev);
>   int btmtk_usb_setup(struct hci_dev *hdev);
>   
>   int btmtk_usb_shutdown(struct hci_dev *hdev);
> +#endif
>   #else
>   
>   static inline int btmtk_set_bdaddr(struct hci_dev *hdev,


Kind regards,

Paul
