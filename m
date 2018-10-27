Return-Path: <SRS0=uhHz=NH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E84C46475
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Oct 2018 11:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C2E20856
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Oct 2018 11:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C2E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeJ0Uif (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 Oct 2018 16:38:35 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46781 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbeJ0Uie (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 Oct 2018 16:38:34 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E75141BF209;
        Sat, 27 Oct 2018 11:57:46 +0000 (UTC)
Message-ID: <14c31a9872ff1e4827eafac5a9b3aadb9434ce6a.camel@hadess.net>
Subject: Re: [PATCH 2/2] Bluetooth: hci_h5: Turn off RTL8723BS on suspend,
 reprobe on resume
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Jeremy Cline <jeremy@jcline.org>, linux-bluetooth@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Sat, 27 Oct 2018 13:57:46 +0200
In-Reply-To: <20181027113327.8182-2-hdegoede@redhat.com>
References: <20181027113327.8182-1-hdegoede@redhat.com>
         <20181027113327.8182-2-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, 2018-10-27 at 13:33 +0200, Hans de Goede wrote:
> On many devices the RTL8723BS device gets reset during
> suspend/resume,
> causing it to loose its firmware and all state.

"lose" (and in other places)

> Testing has shown it drops back to communicating at 115200 bps and
> sends
> sync-request packages, indicating it has been fully reset.
> 
> This commit fixes this by queueing a reprobe on resume.
> 
> This mirrors how USB RTL BT devices, which have the same problem, are
> handled in the btusb driver, there we set the USB_QUIRK_RESET_RESUME
> for
> all RTL devices, which also causes a reprobe on resume. The only
> difference
> is that here we need to do the reprobe ourselves.
> 
> Since we are doing a full reprobe on resume now, we can also turn of 

"off".

> the
> device on suspend to save power while suspended.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/bluetooth/hci_h5.c | 52
> ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index beddb89a00f2..654987b47051 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -931,6 +931,56 @@ static void h5_btrtl_close(struct h5 *h5)
>  	gpiod_set_value_cansleep(h5->enable_gpio, 0);
>  }
>  
> +/* Suspend/resume support. On many devices the RTL BT device looses
> power during
> + * suspend/resume, causing it to loose its firmware and all state.
> So we simply
> + * turn it off on suspend and reprobe on resume.  This mirrors how
> RTL devices
> + * are handled in the USB driver, where the USB_QUIRK_RESET_RESUME
> is used which
> + * also causes a reprobe on resume.
> + */
> +static int h5_btrtl_suspend(struct h5 *h5)
> +{
> +	serdev_device_set_flow_control(h5->hu->serdev, false);
> +	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
> +	gpiod_set_value_cansleep(h5->enable_gpio, 0);
> +	return 0;
> +}
> +
> +struct h5_btrtl_reprobe {
> +	struct device *dev;
> +	struct work_struct work;
> +};
> +
> +static void h5_btrtl_reprobe_worker(struct work_struct *work)
> +{
> +	struct h5_btrtl_reprobe *reprobe =
> +		container_of(work, struct h5_btrtl_reprobe, work);
> +	int ret;
> +
> +	ret = device_reprobe(reprobe->dev);
> +	if (ret && ret != -EPROBE_DEFER)
> +		dev_err(reprobe->dev, "Reprobe error %d\n", ret);
> +
> +	put_device(reprobe->dev);
> +	kfree(reprobe);
> +	module_put(THIS_MODULE);
> +}
> +
> +static int h5_btrtl_resume(struct h5 *h5)
> +{
> +	struct h5_btrtl_reprobe *reprobe;
> +
> +	reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
> +	if (!reprobe)
> +		return -ENOMEM;
> +
> +	__module_get(THIS_MODULE);
> +
> +	INIT_WORK(&reprobe->work, h5_btrtl_reprobe_worker);
> +	reprobe->dev = get_device(&h5->hu->serdev->dev);
> +	queue_work(system_long_wq, &reprobe->work);
> +	return 0;
> +}
> +
>  static const struct acpi_gpio_params btrtl_device_wake_gpios = { 0,
> 0, false };
>  static const struct acpi_gpio_params btrtl_enable_gpios = { 1, 0,
> false };
>  static const struct acpi_gpio_params btrtl_host_wake_gpios = { 2, 0,
> false };
> @@ -945,6 +995,8 @@ static struct h5_vnd rtl_vnd = {
>  	.setup		= h5_btrtl_setup,
>  	.open		= h5_btrtl_open,
>  	.close		= h5_btrtl_close,
> +	.suspend	= h5_btrtl_suspend,
> +	.resume		= h5_btrtl_resume,
>  	.acpi_gpio_map	= acpi_btrtl_gpios,
>  };
>  #endif

