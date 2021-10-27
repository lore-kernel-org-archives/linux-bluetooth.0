Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8D8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C34C610CA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhJ0WdL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:33:11 -0400
Received: from vps.xff.cz ([195.181.215.36]:41328 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhJ0WdK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 18:33:10 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2021 18:33:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1635373406; bh=9vZuw7eTYePN9jDmWt4gVywf52t/rJWV75uAd7GRWPc=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=Q3hcUdGIx58W1vDxd9f3TKlU+oFhOLY5O2vqgtHHpgId3FSjwb9bSfXLSyt4DlZ0H
         F6U4Z3S730+HtWJCDwnib1tQr0anL1wS5mNhxUw51HIwkZXToGpWS6YwDx/EpoJ39I
         pMKdeloMCtTLYUrAS7zqO+JMOGuuIcXxRwD/St8M=
Date:   Thu, 28 Oct 2021 00:23:26 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] Bluetooth: hci_h5: Add runtime suspend
Message-ID: <20211027222326.e55g26ezaxpk7kkm@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Archie Pusaka <apusaka@google.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20210723193137.v3.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
 <20210723193137.v3.3.I4b323d2adf1dca62777c41de344a7d2f79b7f908@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723193137.v3.3.I4b323d2adf1dca62777c41de344a7d2f79b7f908@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Archie,

On Fri, Jul 23, 2021 at 07:31:57PM +0800, Archie Pusaka wrote:
> From: Archie Pusaka <apusaka@chromium.org>
> 
> This patch allows the controller to suspend after a short period of
> inactivity.

I see this pattern in dmesg after this patch: (I've added printks
to many hci_h5 functions to see what's going on)

[  493.150325] h5_dequeue
[  493.150332] h5_dequeue
[  493.150336] h5_dequeue
[  493.150340] h5_dequeue
[  493.150370] h5_dequeue
[  493.150547] h5_recv
[  493.150863] h5_recv
[  493.150878] h5_dequeue
[  493.150885] h5_dequeue
[  493.150888] h5_dequeue
[  493.151315] h5_enqueue
[  493.151328] h5_dequeue
[  493.151350] h5_dequeue
[  493.151447] h5_dequeue
[  493.151612] h5_recv
[  493.151945] h5_recv
[  493.151961] h5_dequeue
[  493.151967] h5_dequeue
[  493.151970] h5_dequeue
[  495.171812] h5_flush
[  495.171845] h5_flush
[  499.267473] h5_serdev_suspend
[  499.267490] h5_btrtl_suspend
[  499.273784] h5_recv
[  499.273828] h5_serdev_resume
[  499.273833] h5_btrtl_resume
[  499.273837] h5_btrtl_resume / reprobe
[  499.273855] h5_btrtl_reprobe_worker
[  499.273913] h5_serdev_remove
[  499.274997] h5_close
[  499.275010] h5_btrtl_close
[  499.275624] h5_serdev_probe
[  499.276126] h5_open
[  499.276132] h5_btrtl_open
[  499.915820] h5_dequeue
[  499.915857] h5_dequeue
[  499.915863] h5_dequeue
[  499.916212] h5_dequeue
[  499.919643] h5_recv
[  499.919675] h5_dequeue
[  499.919682] h5_dequeue
[  499.919687] h5_dequeue
[  499.919692] h5_dequeue

repeating ad nauseam every 6s.

Basically bluetooth device reprobes every 6s. Looks like h5_recv call
after h5_btrtl_suspend wakes the device immediately after suspend.

(there are no users of bluetooth in my userspace) I'd expect the
device to stay suspended after suspend.

I have some extra patches to support 8723cs but nothing that
would affect this codepath. https://megous.com/git/linux/log/?h=bt-5.15

I assume it will have the same behavior with 8723bs which is already
mainline. I guess this issue is specific to devices with H5_INFO_WAKEUP_DISABLE
flag set.

Do you have any ideas?

kind regards,
	o.


> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Hilda Wu <hildawu@realtek.com>
> 
> ---
> 
> Changes in v3:
> * Reordering #include
> 
>  drivers/bluetooth/hci_h5.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index cbc63b057f33..0c0dedece59c 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/serdev.h>
>  #include <linux/skbuff.h>
>  
> @@ -21,6 +22,8 @@
>  #include "btrtl.h"
>  #include "hci_uart.h"
>  
> +#define SUSPEND_TIMEOUT_MS	6000
> +
>  #define HCI_3WIRE_ACK_PKT	0
>  #define HCI_3WIRE_LINK_PKT	15
>  
> @@ -584,6 +587,10 @@ static int h5_recv(struct hci_uart *hu, const void *data, int count)
>  		count -= processed;
>  	}
>  
> +	pm_runtime_get(&hu->serdev->dev);
> +	pm_runtime_mark_last_busy(&hu->serdev->dev);
> +	pm_runtime_put_autosuspend(&hu->serdev->dev);
> +
>  	return 0;
>  }
>  
> @@ -620,6 +627,10 @@ static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>  		break;
>  	}
>  
> +	pm_runtime_get_sync(&hu->serdev->dev);
> +	pm_runtime_mark_last_busy(&hu->serdev->dev);
> +	pm_runtime_put_autosuspend(&hu->serdev->dev);
> +
>  	return 0;
>  }
>  
> @@ -951,6 +962,12 @@ static void h5_btrtl_open(struct h5 *h5)
>  	serdev_device_set_parity(h5->hu->serdev, SERDEV_PARITY_EVEN);
>  	serdev_device_set_baudrate(h5->hu->serdev, 115200);
>  
> +	pm_runtime_set_active(&h5->hu->serdev->dev);
> +	pm_runtime_use_autosuspend(&h5->hu->serdev->dev);
> +	pm_runtime_set_autosuspend_delay(&h5->hu->serdev->dev,
> +					 SUSPEND_TIMEOUT_MS);
> +	pm_runtime_enable(&h5->hu->serdev->dev);
> +
>  	/* The controller needs up to 500ms to wakeup */
>  	gpiod_set_value_cansleep(h5->enable_gpio, 1);
>  	gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
> @@ -959,6 +976,8 @@ static void h5_btrtl_open(struct h5 *h5)
>  
>  static void h5_btrtl_close(struct h5 *h5)
>  {
> +	pm_runtime_disable(&h5->hu->serdev->dev);
> +
>  	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
>  	gpiod_set_value_cansleep(h5->enable_gpio, 0);
>  }
> @@ -1066,6 +1085,7 @@ MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
>  
>  static const struct dev_pm_ops h5_serdev_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
> +	SET_RUNTIME_PM_OPS(h5_serdev_suspend, h5_serdev_resume, NULL)
>  };
>  
>  static const struct of_device_id rtl_bluetooth_of_match[] = {
> -- 
> 2.32.0.432.gabb21c7263-goog
> 
