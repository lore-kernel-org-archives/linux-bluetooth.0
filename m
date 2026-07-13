Received: from mail.johnrowley.me (mail.johnrowley.me [195.201.26.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C613546EA;
	Mon, 13 Jul 2026 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.201.26.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955229; cv=pass; b=es/7y05CGpq3oeNUAXd/+p5iNyQA4WpC83OuTWQix30WMfGVkevfu/TsFsTR9R+hHM9p/Qaheg5ehsbXAtSVe2NKZAmrYXskkhk4l9061ruZWuR3AM1uivG5i7ns/k2sUQeChdyN2vbbNcO4PXiNiy7i9S7MXQ4swMJSTZRQGIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955229; c=relaxed/simple;
	bh=EKhZqF/AF2BS0BGhtDNohH+z0IraCXHAQz+Y5A+hWMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcZQIb7dT+/OoYE65hxVZF55+W2EvxkEOoqcpJd1bek0OawfuiSfUGbOAWqGxl/vW6O9UYWEvVW1CLWhLnS0zsEK0cVsrAiouSCB5qrBDQIEZbgk2yI18xVJjqOKISEMGx/7XHNylqaLDitCugKSd+sRqjVFtlA2oVQZWrv7ZpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnrowley.me; spf=pass smtp.mailfrom=johnrowley.me; dkim=pass (2048-bit key) header.d=johnrowley.me header.i=@johnrowley.me header.b=dJ+Bi7b1; arc=pass smtp.client-ip=195.201.26.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnrowley.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnrowley.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johnrowley.me header.i=@johnrowley.me header.b="dJ+Bi7b1"
Date: Mon, 13 Jul 2026 16:06:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnrowley.me;
	s=2025; t=1783955218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fXxhFfbYr3w5rbgwzN2JGMTwJIyyfVDjWt5wyNfuQ7k=;
	b=dJ+Bi7b1OSx056zO9okB04asZHpEcQf0OM/37R+tZ/MYu0BqwblHA4FRT8RGzb74cel35N
	9agc8yXIDPZ2WhTvO4pIvlm+2NQpOEFnSUNC5A3gj7+Lr0YogBSoJnNXtGvaYB11l1JvR/
	Y+klw4EeSbxl6vnd30n4JJHxyA4IZRBylxkvfCb8fg3WbhkKU0A9Vuk4OIzqx56/RHjNbw
	ZDpZbD0qwiXsg1kk3Qp5bstoBhYk/NdtdD7Fo4h0agYY1Yq8Xo3ZiOlSOLi5aJHc9LDYwG
	K4zQKl//kNl2lrr185xzeYa5RhogGFah3dRrKxowv7HaOBBKiaYhvl1MYftCqw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=user smtp.mailfrom=hey@johnrowley.me
ARC-Seal: i=1; a=rsa-sha256; d=johnrowley.me; s=2025; cv=none; t=1783955218;
	b=A9P0hWGcbbmS4+dTyIoBAku6p/DuINfKFYKpIqSsfwkGet7qQS7mHtxv0JTGEzrIjH58+y
	FZZGiLyYSEoh8ADjRHZQrrXmCMSFfZIWxRJ13StjEFkEciKyI98nDHsXkkZjHF7aPUoL/d
	fVBGwkH5A9rPbd+5p+SzwN87EHbn2nn8mG/lFE7BhVgBTUUkD61ghc7iinMklAqXG/p8O+
	3jARppBXpL6weHuipFVp0+03MPpeM9IcpDuuSnfN068OjJ2Asif6dB1z2mLMup9pSD9ZSz
	K/6Y1XnOUC7h/SzhrbGY5fi5D0gCGOLhzpWw1+6Z0wLdGYjtzfm7DhqbkkbNzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=johnrowley.me;
	s=2025; t=1783955218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fXxhFfbYr3w5rbgwzN2JGMTwJIyyfVDjWt5wyNfuQ7k=;
	b=eUvLFgfyiIngKqwdIy7oQeU/jDQJk6CYMsal9ZHBr6IzFaL48qYy5+UxJm9uqyp52UUG8q
	XstxYYS3DTndj+gyu7mbmKkcp+aRHaYnu6nC2TejuOIWVjPDE+0K0cc7itSVC65i1dWDFM
	NWNcPfuxM9Qa0C9vFAv2EUO8VbM9qryxWEHoYcWsKSHENPlEGBt6ZtvvbopGTKces9ZijG
	X2aWLyTgnn7o/yQQkRz1IIdhWQlNgGklpdcaQs8zj9Q0ttxQM91nOmx4CfEPtVmSuEz6rM
	qdhnpOQWDLTM6WPr4PoF6OhJ2gNH3AaJcSVyg15dRATXpZLPJ0ioWWkWd1kS4A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=user smtp.mailfrom=hey@johnrowley.me
From: John Rowley <hey@johnrowley.me>
To: Rong Zhang <i@rong.moe>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	Chris Lu =?utf-8?B?KOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>, 
	Will-CY Lee =?utf-8?B?KOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>, SS Wu =?utf-8?B?KOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] Bluetooth: Properly disable remote wakeup for
 MT7922/MT7925 on Ryzen platform
Message-ID: <alT767DjNf3bD5V0@localhost.localdomain>
References: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe>

On Wed, Jul 01, 2026 at 11:43:01PM +0800, Rong Zhang wrote:
> It is reported that a remote wakeup could cause MT7922/MT7925's btusb
> interface completely unresponsive. Resetting the xHCI root hub doesn't
> help at all, and recovering from such a state needs a power cycle.
> 
> All reports seen to be relevant to Ryzen-based laptops. These NICs are
> usually used as OEM components thanks to some sort of reference designs.
> Their popularity on other platforms is unclear. While there is still a
> chance that the quirk may exist on other platforms, be cautious and only
> apply the quirk to direct children of Ryzen platforms's root hubs for
> the time being. In most cases the root hub is on the SoC or PCH, which
> needs the quirk. Unfortunately, this can't distinguish root hubs on PCIe
> add-in cards. Such roughness should be acceptable, as PCIe USB
> controller add-in cards are less commonly used nowadays. On the other
> hand, applying the quirk doesn't hurt any functionalities either, as the
> device can still be used as a wakeup source if desired. Theoretically,
> we could retrieve the root hub's PCI vendor ID with some hierarchy
> magic, but that's too intrusive...
> 
> Meanwhile, though device_set_wakeup_capable(false) is the correct fix
> for other NICs with fake remote wakeup capabilities, doing so for
> MT7922/MT7925 effectively prevents it from being used as wakeup
> sources as per userspace requests. Hence, return -EBUSY on runtime
> suspend to prevent the interface from being autosuspended while it's
> still opened, which has the same effect as
> device_set_wakeup_capable(false), since disabling remote wakeup simply
> causes the USB core to gate runtime autosuspend as well due to
> needs_remote_wakeup == 1. The interface can be safely autosuspended as
> long as remote wakeup is disabled, i.e., after closing the HCI device.
> 
> Specifically, the interface may still take the advantage of remote
> wakeup in order to wake up the system from sleep if userspace has
> enabled it as a wakeup source.

Hi Rong,

I'm experiencing xHCI hub freezing issues when bringing my AMD Framework
13 laptop out of suspend mode. Sometimes, the wifi controller will
freeze up, and dmesg will show:

[ 7238.147897] PM: suspend exit
[ 7239.423823] usb 1-4: reset full-speed USB device number 3 using xhci_hcd
[ 7239.692328] usb 1-4: reset full-speed USB device number 3 using xhci_hcd
...and so on...

Any attempt to access the wireless interface, e.g. `ip addr show`, will
hang the system. Only a power cycle fixes it.

This has only started since 7.2-rc1. Here's my USB bus tree (1- only):

/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/5p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 001: Dev 002, 12M
        ID 32ac:0002  
    |__ Port 004: Dev 003, If 0, Class=Vendor Specific Class, Driver=[none], 12M
        ID 27c6:609c Shenzhen Goodix Technology Co.,Ltd. 
    |__ Port 005: Dev 004, If 0, Class=Wireless, Driver=[none], 480M
        ID 0e8d:e616 MediaTek Inc. 
    |__ Port 005: Dev 004, If 1, Class=Wireless, Driver=[none], 480M
        ID 0e8d:e616 MediaTek Inc. 
    |__ Port 005: Dev 004, If 2, Class=Wireless, Driver=[none], 480M
        ID 0e8d:e616 MediaTek Inc.

Seeing as I have a MT7922 that is providing both wireless and Bluetooth
functionality, I'm wondering if I'm hitting this bug also? Perhaps it's
my fingerprint reader that's the problem, but your description above
sounds very similar to what I'm seeing.

I have applied your patch, which I thought had fixed the problem, but I
had a freeze again earlier today after resuming my machine fron standby.

I keep the bluetooth/btusb/bt* modules blacklisted, but that apparently
hasn't made a difference.

> 
> Fixes: e31d761628ad ("Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925")
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
> Changes in v2:
> - Only apply the quirk to to direct children of Ryzen platforms's root
>   hubs
>   - Theoretically, we could retrieve the root hub's PCI vendor ID with
>     some hierarchy magic to further limit the range down to only root
>     hubs on the SoC or PCH, but that's too intrusive -- the hierarchy
>     magic really made me nervous once I saw what I have wrote, so I gave
>     it up
> - Link to v1: https://patch.msgid.link/20260629-btmtk-ryzen-remote-wakeup-v1-1-1d2f1cee6d22@rong.moe
> ---
>  drivers/bluetooth/btmtk.c | 10 -------
>  drivers/bluetooth/btusb.c | 73 ++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 69 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 02a96342e964..4614434dd57b 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -1381,16 +1381,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>  		break;
>  	case 0x7922:
>  	case 0x7925:
> -		/*
> -		 * A remote wakeup could cause the device completely unresponsive, and
> -		 * recovering from such a state needs a power cycle.
> -		 *
> -		 * Since the remote wakeup capability is super broken, just disable it
> -		 * to get rid of the troubles. The device can still be autosuspended
> -		 * when the bluetooth interface is closed.
> -		 */
> -		device_set_wakeup_capable(&btmtk_data->udev->dev, false);
> -		fallthrough;
>  	case 0x7961:
>  	case 0x7902:
>  	case 0x6639:
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 08c0a99a62c5..eef6e3b43bf9 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -6,6 +6,7 @@
>   *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
>   */
>  
> +#include <linux/cpufeature.h>
>  #include <linux/dmi.h>
>  #include <linux/module.h>
>  #include <linux/usb.h>
> @@ -957,6 +958,7 @@ struct qca_dump_info {
>  #define BTUSB_USE_ALT3_FOR_WBS	15
>  #define BTUSB_ALT6_CONTINUOUS_TX	16
>  #define BTUSB_HW_SSR_ACTIVE	17
> +#define BTUSB_WAKEUP_BROKEN	18
>  
>  struct btusb_data {
>  	struct hci_dev       *hdev;
> @@ -2936,10 +2938,25 @@ static int btusb_send_frame_mtk(struct hci_dev *hdev, struct sk_buff *skb)
>  	}
>  }
>  
> +static inline bool platform_is_ryzen(void)
> +{
> +#ifdef CONFIG_X86
> +	return boot_cpu_has(X86_FEATURE_ZEN);
> +#else
> +	return false;
> +#endif
> +}
> +
> +static inline bool is_direct_child_of_root_hub(struct usb_device *udev)
> +{
> +	return udev->parent == udev->bus->root_hub;
> +}
> +
>  static int btusb_mtk_setup(struct hci_dev *hdev)
>  {
>  	struct btusb_data *data = hci_get_drvdata(hdev);
>  	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
> +	int err;
>  
>  	/* MediaTek WMT vendor cmd requiring below USB resources to
>  	 * complete the handshake.
> @@ -2956,7 +2973,40 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>  		btusb_mtk_claim_iso_intf(data);
>  	}
>  
> -	return btmtk_usb_setup(hdev);
> +	err = btmtk_usb_setup(hdev);
> +	if (err)
> +		return err;
> +
> +	switch (btmtk_data->dev_id) {
> +	case 0x7922:
> +	case 0x7925:
> +		/*
> +		 * All reports seen to be relevant to Ryzen-based laptops. These
> +		 * NICs are usually used as OEM components thanks to some sort
> +		 * of reference designs.
> +		 *
> +		 * Their popularity on other platforms is unclear. While there
> +		 * is still a chance that the quirk may exist on other
> +		 * platforms, be cautious and only apply the quirk to direct
> +		 * children of Ryzen platforms's root hubs for the time being.
> +		 *
> +		 * In most cases the root hub is on the SoC or PCH, which needs
> +		 * the quirk. Unfortunately, this can't distinguish root hubs on
> +		 * PCIe add-in cards. Such roughness should be acceptable, as
> +		 * PCIe USB controller add-in cards are less commonly used
> +		 * nowadays. On the other hand, applying the quirk doesn't hurt
> +		 * any functionalities either, as the device can still be used
> +		 * as a wakeup source if desired.
> +		 *
> +		 * Theoretically, we could retrieve the root hub's PCI vendor ID
> +		 * with some hierarchy magic, but that's too intrusive...
> +		 */
> +		if (platform_is_ryzen() && is_direct_child_of_root_hub(data->udev))
> +			set_bit(BTUSB_WAKEUP_BROKEN, &data->flags);
> +		break;
> +	}
> +
> +	return 0;
>  }
>  
>  static int btusb_mtk_shutdown(struct hci_dev *hdev)
> @@ -4532,11 +4582,26 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>  
>  	BT_DBG("intf %p", intf);
>  
> -	/* Don't auto-suspend if there are connections or discovery in
> -	 * progress; external suspend calls shall never fail.
> +	/*
> +	 * It is reported that remote wakeup events could sometimes cause some
> +	 * adapters completely unresponsive. Resetting the xHCI root hub doesn't
> +	 * help at all, and recovering from such a state needs a power cycle.
> +	 * Since disabling remote wakeup simply causes the USB core to gate
> +	 * runtime autosuspend as well due to needs_remote_wakeup == 1, let's do
> +	 * this ourselves to make our life easier. The interface can be safely
> +	 * autosuspended as long as remote wakeup is disabled, i.e., after
> +	 * closing the HCI device.
> +	 *
> +	 * Don't auto-suspend if there are connections or discovery in progress.
> +	 *
> +	 * External suspend calls shall never fail. Specifically, a device with
> +	 * broken remote wakeup may still take the advantage of remote wakeup in
> +	 * order to wake up the system from sleep if userspace has enabled it as
> +	 * a wakeup source.
>  	 */
>  	if (PMSG_IS_AUTO(message) &&
> -	    (hci_conn_count(data->hdev) || hci_discovery_active(data->hdev)))
> +	    ((test_bit(BTUSB_WAKEUP_BROKEN, &data->flags) && data->intf->needs_remote_wakeup) ||
> +	     hci_conn_count(data->hdev) || hci_discovery_active(data->hdev)))
>  		return -EBUSY;
>  
>  	if (data->suspend_count++)
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 230ba8c9-btmtk-ryzen-remote-wakeup-055a407682ef
> 
> Thanks,
> Rong
> 
