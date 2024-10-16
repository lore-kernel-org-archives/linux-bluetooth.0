Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A560187855
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 05:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055578; cv=none; b=RS4HqWDsPhT6f1+mm4ClGoSTny4yqcjXK4i6wxdkgqOko844huYB4lcdcrqAV2iM2aCgWOFH+l82d7aLjMVdwRRDM/YhI3F9RJ9f8v1y4jsAU8t1ZEQXqHpaZjVsSYstJciJ4WnJWBWwY/YoU5q5T6637D9OjRJbHAHu84dPgn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055578; c=relaxed/simple;
	bh=QgioZlMoxbFbzXpSKENqC416TIvL8bHE9aSuk7mOjds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LobcYmL6mKDRV8WwW26RrACHuO7dPwxcW/aHWqRQXdV/f6FtYrIqDB0i1g40ioHQTzlFWWY469wW0Wp8EbP9mbNgeCVrMX3rgj7p+2FSrNj2Pj6CGdaLhRCmmp/b/1kVab6ZtrkndGyZcK1rVLRUziFgdjEKSPBVbKr614sz7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae84f.dynamic.kabel-deutschland.de [95.90.232.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3D26761E5FE05;
	Wed, 16 Oct 2024 07:12:33 +0200 (CEST)
Message-ID: <36e9550a-3b45-4489-8370-afdc4f2fa6b5@molgen.mpg.de>
Date: Wed, 16 Oct 2024 07:12:32 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btusb: Fix not being able to reconnect
 after suspend
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Kenneth Crudup <kenny@panix.com>
References: <20241014202326.381559-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241014202326.381559-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for the patch.


Am 14.10.24 um 22:23 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Calls to hci_suspend_dev assumes the system-suspend which doesn't work
> well when just the device is being suspended because wakeup flag is only
> set for remote devices that can wakeup the system.

Please mention that you revert most parts of the problematic commit.

> Reported-by: Rafael J. Wysocki <rafael@kernel.org>
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reported-by: Kenneth Crudup <kenny@panix.com>
> Fixes: 81b3e33bb054 ("Bluetooth: btusb: Don't fail external suspend requests")

That commit is not in the master branch, 
610712298b11b2914be00b35abe9326b5dbb62c8 is.

> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   drivers/bluetooth/btusb.c | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d14b941bfde8..c0b6ef8ee5da 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4075,7 +4075,6 @@ static void btusb_disconnect(struct usb_interface *intf)
>   static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>   {
>   	struct btusb_data *data = usb_get_intfdata(intf);
> -	int err;
>   
>   	BT_DBG("intf %p", intf);
>   
> @@ -4088,16 +4087,6 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>   	if (data->suspend_count++)
>   		return 0;
>   
> -	/* Notify Host stack to suspend; this has to be done before stopping
> -	 * the traffic since the hci_suspend_dev itself may generate some
> -	 * traffic.
> -	 */
> -	err = hci_suspend_dev(data->hdev);
> -	if (err) {
> -		data->suspend_count--;
> -		return err;
> -	}
> -
>   	spin_lock_irq(&data->txlock);
>   	if (!(PMSG_IS_AUTO(message) && data->tx_in_flight)) {
>   		set_bit(BTUSB_SUSPENDING, &data->flags);
> @@ -4105,7 +4094,6 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>   	} else {
>   		spin_unlock_irq(&data->txlock);
>   		data->suspend_count--;
> -		hci_resume_dev(data->hdev);
>   		return -EBUSY;
>   	}
>   
> @@ -4226,8 +4214,6 @@ static int btusb_resume(struct usb_interface *intf)
>   	spin_unlock_irq(&data->txlock);
>   	schedule_work(&data->work);
>   
> -	hci_resume_dev(data->hdev);
> -
>   	return 0;
>   
>   failed:


Kind regards,

Paul
