Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E83EC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 17:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5949C225AB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 17:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbhAYRxQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:53:16 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33736 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731111AbhAYRwU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 12:52:20 -0500
Received: from marcel-macbook.holtmann.net (p4ff9f11c.dip0.t-ipconnect.de [79.249.241.28])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8080FCECC8;
        Mon, 25 Jan 2021 18:58:52 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH 3/3] Bluetooth: btusb: Expose reset gpio to debugfs
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210119124258.3.I7c6ae9b637f9a77f6e6f2e4256c6a0232476be43@changeid>
Date:   Mon, 25 Jan 2021 18:51:27 +0100
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>, michaelfsun@google.com,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <436E729B-B852-4238-AA42-6FFC2D2BE233@holtmann.org>
References: <20210119204315.2611811-1-abhishekpandit@chromium.org>
 <20210119124258.3.I7c6ae9b637f9a77f6e6f2e4256c6a0232476be43@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> If btusb has a reset gpio, expose it to userspace so we can toggle the
> reset gpio directly. This is useful for testing and error recovery.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> 
> drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 880e9cd4ee713..702be1871ed88 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -6,6 +6,7 @@
>  *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
>  */
> 
> +#include <linux/debugfs.h>
> #include <linux/dmi.h>
> #include <linux/module.h>
> #include <linux/usb.h>
> @@ -574,6 +575,46 @@ static void btusb_toggle_gpio(struct gpio_desc *desc, unsigned int duration)
> 	gpiod_set_value_cansleep(desc, 0);
> }
> 
> +#ifdef CONFIG_DEBUG_FS
> +static ssize_t btusb_debugfs_has_reset_gpio(struct file *file,
> +					    char __user *user_buf,
> +					    size_t count, loff_t *ppos)
> +{
> +	struct hci_dev *hdev = file->private_data;
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +	char buf[3];
> +
> +	buf[0] = data->reset_gpio ? 'Y' : 'N';
> +	buf[1] = '\n';
> +	buf[2] = '\0';
> +
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> +}
> +
> +static ssize_t btusb_debugfs_reset_gpio(struct file *file,
> +					const char __user *user_buf,
> +					size_t count, loff_t *ppos)
> +{
> +	struct hci_dev *hdev = file->private_data;
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +
> +	if (!data->reset_gpio)
> +		return -EOPNOTSUPP;
> +
> +	bt_dev_warn(hdev, "Debugfs triggering HW reset via gpio");
> +	btusb_toggle_gpio(data->reset_gpio, data->reset_duration_ms);
> +
> +	return count;
> +}
> +
> +static const struct file_operations reset_gpio_fops = {
> +	.open		= simple_open,
> +	.read		= btusb_debugfs_has_reset_gpio,
> +	.write		= btusb_debugfs_reset_gpio,
> +	.llseek		= default_llseek,
> +};
> +#endif

while I am not convinced that this is the right way, I am fine doing it temporarily. However, please lets create the debugfs file only when a reset GPIO is available and skip the read callback. Only the write one should be supported since there is no point to read the status. The pure existence of the debugfs should indicate support for a HW reset.

Regards

Marcel

