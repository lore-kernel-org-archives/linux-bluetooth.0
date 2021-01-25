Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F75C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 15:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA4321707
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 15:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbhAYPvk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 10:51:40 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49980 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbhAYPvh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 10:51:37 -0500
Received: from marcel-macbook.holtmann.net (p4ff9f11c.dip0.t-ipconnect.de [79.249.241.28])
        by mail.holtmann.org (Postfix) with ESMTPSA id A0251CECCE;
        Mon, 25 Jan 2021 16:26:56 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH 1/3] Bluetooth: btusb: Refactor gpio reset
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210119124258.1.Ide97dd8adadf50af66738852c3c68861734cca1c@changeid>
Date:   Mon, 25 Jan 2021 16:19:31 +0100
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>, michaelfsun@google.com,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C17EF62B-CCCE-4C5F-90A7-247EB860608E@holtmann.org>
References: <20210119204315.2611811-1-abhishekpandit@chromium.org>
 <20210119124258.1.Ide97dd8adadf50af66738852c3c68861734cca1c@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> Refactor gpio reset to use a common gpio reset function.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> 
> drivers/bluetooth/btusb.c | 59 +++++++++++++--------------------------
> 1 file changed, 19 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b14102fba6018..03341e6cbf3ed 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -547,6 +547,7 @@ struct btusb_data {
> 	struct usb_endpoint_descriptor *diag_rx_ep;
> 
> 	struct gpio_desc *reset_gpio;
> +	unsigned int reset_duration_ms;
> 
> 	__u8 cmdreq_type;
> 	__u8 cmdreq;
> @@ -566,15 +567,21 @@ struct btusb_data {
> 	unsigned cmd_timeout_cnt;
> };
> 
> -static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
> +static void btusb_toggle_gpio(struct gpio_desc *desc, unsigned int duration)
> +{
> +	gpiod_set_value_cansleep(desc, 1);
> +	msleep(duration);
> +	gpiod_set_value_cansleep(desc, 0);
> +}
> +
> +static void btusb_gpio_cmd_timeout(struct hci_dev *hdev)
> {
> 	struct btusb_data *data = hci_get_drvdata(hdev);
> -	struct gpio_desc *reset_gpio = data->reset_gpio;
> 
> 	if (++data->cmd_timeout_cnt < 5)
> 		return;
> 
> -	if (!reset_gpio) {
> +	if (!data->reset_gpio) {
> 		bt_dev_err(hdev, "No way to reset. Ignoring and continuing");
> 		return;
> 	}
> @@ -592,39 +599,7 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
> 	}
> 
> 	bt_dev_err(hdev, "Initiating HW reset via gpio");
> -	gpiod_set_value_cansleep(reset_gpio, 1);
> -	msleep(100);
> -	gpiod_set_value_cansleep(reset_gpio, 0);
> -}
> -
> -static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
> -{
> -	struct btusb_data *data = hci_get_drvdata(hdev);
> -	struct gpio_desc *reset_gpio = data->reset_gpio;
> -
> -	if (++data->cmd_timeout_cnt < 5)
> -		return;
> -
> -	if (!reset_gpio) {
> -		bt_dev_err(hdev, "No gpio to reset Realtek device, ignoring");
> -		return;
> -	}
> -
> -	/* Toggle the hard reset line. The Realtek device is going to
> -	 * yank itself off the USB and then replug. The cleanup is handled
> -	 * correctly on the way out (standard USB disconnect), and the new
> -	 * device is detected cleanly and bound to the driver again like
> -	 * it should be.
> -	 */
> -	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
> -		bt_dev_err(hdev, "last reset failed? Not resetting again");
> -		return;
> -	}
> -
> -	bt_dev_err(hdev, "Reset Realtek device via gpio");
> -	gpiod_set_value_cansleep(reset_gpio, 1);
> -	msleep(200);
> -	gpiod_set_value_cansleep(reset_gpio, 0);
> +	btusb_toggle_gpio(data->reset_gpio, data->reset_duration_ms);
> }

You need to explain why this patch is correct. You are removing more code here. And there is an extra check in case of Realtek and a large comment.

Regards

Marcel

