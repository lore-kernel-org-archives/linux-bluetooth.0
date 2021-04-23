Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC26C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 06:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C35BE611ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 06:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhDWGzg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 02:55:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52445 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhDWGzf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 02:55:35 -0400
Received: from marcel-macbook.holtmann.net (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1BE12CECFA;
        Fri, 23 Apr 2021 09:02:45 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v3 2/2] Bluetooth: hci_h5: Add flag for keep power during
 suspend/resume
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210423035229.27513-3-hildawu@realtek.com>
Date:   Fri, 23 Apr 2021 08:54:57 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, apusaka@chromium.org,
        tientzu@chromium.org, max.chou@realtek.com, alex_lu@realsil.com.cn,
        kidman@realtek.com
Content-Transfer-Encoding: 8BIT
Message-Id: <698B6653-F1C9-4250-86A3-1780CC1D5DAD@holtmann.org>
References: <20210423035229.27513-1-hildawu@realtek.com>
 <20210423035229.27513-3-hildawu@realtek.com>
To:     Hilda Wu <hildawu@realtek.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hilda,

> RTL8822C and RTL8852A devices support BT wakeup Host. Add a flag
> for these specific devices did not power off during suspend and resume.
> By this change, if the Host support that received BT device signal then
> it can wake Host up.
> 
> Signed-off-by: hildawu <hildawu@realtek.com>
> ---
> Changed in v3:
> - Reworked to use UART flag, refer to Maintainer's suggestion.
> - Split into two patches for different purpose.
> 
> Changes in v2:
> - Add the missing struct member
> - Modify title length
> ---
> ---
> drivers/bluetooth/hci_h5.c    | 34 ++++++++++++++++++++++++----------
> drivers/bluetooth/hci_ldisc.c |  3 ++-
> drivers/bluetooth/hci_uart.h  |  1 +
> 3 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 27e96681d583..9cacc4cdc928 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -911,6 +911,15 @@ static int h5_btrtl_setup(struct h5 *h5)
> 	 */
> 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->quirks);
> 
> +	switch (btrtl_dev->project_id) {
> +	case CHIP_ID_8822C:
> +	case CHIP_ID_8852A:
> +		set_bit(HCI_UART_WAKEUP_ENABLE, &h5->hu->hdev_flags);
> +		break;
> +	default:
> +		break;
> +	}
> +
> out_free:
> 	btrtl_free(btrtl_dev);
> 
> @@ -945,8 +954,11 @@ static void h5_btrtl_close(struct h5 *h5)
> static int h5_btrtl_suspend(struct h5 *h5)
> {
> 	serdev_device_set_flow_control(h5->hu->serdev, false);
> -	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
> -	gpiod_set_value_cansleep(h5->enable_gpio, 0);
> +
> +	if (!test_bit(HCI_UART_WAKEUP_ENABLE, &h5->hu->hdev_flags)) {
> +		gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
> +		gpiod_set_value_cansleep(h5->enable_gpio, 0);
> +	}
> 	return 0;
> }
> 
> @@ -972,17 +984,19 @@ static void h5_btrtl_reprobe_worker(struct work_struct *work)
> 
> static int h5_btrtl_resume(struct h5 *h5)
> {
> -	struct h5_btrtl_reprobe *reprobe;
> +	if (!test_bit(HCI_UART_WAKEUP_ENABLE, &h5->hu->hdev_flags)) {
> +		struct h5_btrtl_reprobe *reprobe;
> 
> -	reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
> -	if (!reprobe)
> -		return -ENOMEM;
> +		reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
> +		if (!reprobe)
> +			return -ENOMEM;
> 
> -	__module_get(THIS_MODULE);
> +		__module_get(THIS_MODULE);
> 
> -	INIT_WORK(&reprobe->work, h5_btrtl_reprobe_worker);
> -	reprobe->dev = get_device(&h5->hu->serdev->dev);
> -	queue_work(system_long_wq, &reprobe->work);
> +		INIT_WORK(&reprobe->work, h5_btrtl_reprobe_worker);
> +		reprobe->dev = get_device(&h5->hu->serdev->dev);
> +		queue_work(system_long_wq, &reprobe->work);
> +	}
> 	return 0;
> }
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 637c5b8c2aa1..3a1038e9dc6a 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -719,7 +719,8 @@ static int hci_uart_set_flags(struct hci_uart *hu, unsigned long flags)
> 				    BIT(HCI_UART_CREATE_AMP) |
> 				    BIT(HCI_UART_INIT_PENDING) |
> 				    BIT(HCI_UART_EXT_CONFIG) |
> -				    BIT(HCI_UART_VND_DETECT);
> +				    BIT(HCI_UART_VND_DETECT) |
> +				    BIT(HCI_UART_WAKEUP_ENABLE);
> 
> 	if (flags & ~valid_flags)
> 		return -EINVAL;
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 4e039d7a16f8..25f5e5c7544c 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -41,6 +41,7 @@
> #define HCI_UART_INIT_PENDING	3
> #define HCI_UART_EXT_CONFIG	4
> #define HCI_UART_VND_DETECT	5
> +#define HCI_UART_WAKEUP_ENABLE	6

don’t use these flags since they are an ioctl API.

Regards

Marcel

