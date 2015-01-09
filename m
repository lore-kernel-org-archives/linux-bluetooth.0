Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 3/6] btwilink: add minimal device tree support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420775239-24745-1-git-send-email-gigi.joseph@ti.com>
Date: Thu, 8 Jan 2015 23:07:01 -0800
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	devicetree@vger.kernel.org, Gigi Joseph <gigi.joseph@ti.com>,
	Eyal Reizer <eyalr@ti.com>, bvijay <bvijay@ti.com>
Message-Id: <C03A9F83-A4A3-424A-B50C-D6A9630705C8@holtmann.org>
References: <1420775239-24745-1-git-send-email-gigi.joseph@ti.com>
To: Gigi Joseph <gigi.joseph@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gigi,

> Add minimal device tree support to the btwilink driver that is used
> for binding bluetooth with the ti-st shared transport driver.
> 
> Signed-off-by: Eyal Reizer <eyalr@ti.com>
> Signed-off-by: bvijay <bvijay@ti.com>
> Signed-off-by: Gigi Joseph <gigi.joseph@ti.com>
> ---
> drivers/bluetooth/btwilink.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
> index 55c135b..95adec3 100644
> --- a/drivers/bluetooth/btwilink.c
> +++ b/drivers/bluetooth/btwilink.c
> @@ -30,6 +30,7 @@
> 
> #include <linux/ti_wilink_st.h>
> #include <linux/module.h>
> +#include <linux/of.h>
> 
> /* Bluetooth Driver Version */
> #define VERSION               "1.0"
> @@ -286,6 +287,14 @@ static int ti_st_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> 	return 0;
> }
> 
> +static const struct of_device_id btwilink_of_match[] = {
> +{
> +	.compatible = "btwilink",
> +	},
> +	{}
> +};

this formatting is bogus. Please construct it similar to what other drivers are doing.

static const struct .. = {
	{ .compatible = ".." },

	{ }	/* Terminating entry */
};

And add an extra empty line before MODULE_DEVICE_TABLE.

> +MODULE_DEVICE_TABLE(of, btwilink_of_match);
> +
> static int bt_ti_probe(struct platform_device *pdev)
> {
> 	static struct ti_st *hst;
> @@ -349,6 +358,8 @@ static struct platform_driver btwilink_driver = {
> 	.remove = bt_ti_remove,
> 	.driver = {
> 		.name = "btwilink",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(btwilink_of_match),
> 	},
> };

Regards

Marcel

