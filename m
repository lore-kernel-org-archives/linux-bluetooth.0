Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4DFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 20:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbiAFU1p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 15:27:45 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52934 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiAFU1p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 15:27:45 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 466E9CECDD;
        Thu,  6 Jan 2022 21:27:44 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Add the Asus TF103C to the
 bcm_broken_irq_dmi_table
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211231115055.115988-1-hdegoede@redhat.com>
Date:   Thu, 6 Jan 2022 21:27:43 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <FE6FDB9A-2188-45EE-9605-CF5A5B7E43A1@holtmann.org>
References: <20211231115055.115988-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

> The DSDT for the Asus TF103C specifies a IOAPIC IRQ for the HCI -> host IRQ
> but this is not correct. Unlike the previous entries in the table, this
> time the correct GPIO to use instead is known; and the TF103C is battery
> powered making runtime-pm support more important.
> 
> Extend the bcm_broken_irq_dmi_table mechanism to allow specifying the right
> GPIO instead of just always disabling runtime-pm and add an entry to it for
> the Asus TF103C.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_bcm.c | 44 ++++++++++++++++++++++++++++++-------
> 1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index ef54afa29357..c6ac4aa994af 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -20,6 +20,7 @@
> #include <linux/regulator/consumer.h>
> #include <linux/clk.h>
> #include <linux/gpio/consumer.h>
> +#include <linux/gpio/machine.h>
> #include <linux/tty.h>
> #include <linux/interrupt.h>
> #include <linux/dmi.h>
> @@ -870,7 +871,23 @@ static int bcm_resume(struct device *dev)
> #endif
> 
> /* Some firmware reports an IRQ which does not work (wrong pin in fw table?) */
> +static struct gpiod_lookup_table asus_tf103c_irq_gpios = {
> +	.dev_id = "serial0-0",

do you need this one? I assume it could be easily enumerated as serial1-0 if you are unlucky.

> +	.table = {
> +		GPIO_LOOKUP("INT33FC:02", 17, "host-wakeup-alt", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
> static const struct dmi_system_id bcm_broken_irq_dmi_table[] = {
> +	{
> +		.ident = "Asus TF103C",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TF103C"),
> +		},
> +		.driver_data = &asus_tf103c_irq_gpios,
> +	},
> 	{
> 		.ident = "Meegopad T08",
> 		.matches = {

Regards

Marcel

