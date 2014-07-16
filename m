Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/2] Bluetooth: btmrvl: add public address configuration support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405538486-23533-2-git-send-email-bzhao@marvell.com>
Date: Wed, 16 Jul 2014 23:34:41 +0200
Cc: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Avinash Patil <patila@marvell.com>,
	Chin-Ran Lo <crlo@marvell.com>, Xinming Hu <huxm@marvell.com>
Message-Id: <A5D7B02F-3913-4501-A007-B11A3E7FA7EB@holtmann.org>
References: <1405538486-23533-1-git-send-email-bzhao@marvell.com> <1405538486-23533-2-git-send-email-bzhao@marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> .set_bdaddr handler is implemented for public address configuration.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
> drivers/bluetooth/btmrvl_drv.h  |  1 +
> drivers/bluetooth/btmrvl_main.c | 15 +++++++++++++++
> 2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
> index caf6841..38ad662 100644
> --- a/drivers/bluetooth/btmrvl_drv.h
> +++ b/drivers/bluetooth/btmrvl_drv.h
> @@ -91,6 +91,7 @@ struct btmrvl_private {
> 
> /* Vendor specific Bluetooth commands */
> #define BT_CMD_PSCAN_WIN_REPORT_ENABLE	0xFC03
> +#define BT_CMD_SET_BDADDR		0xFC22
> #define BT_CMD_AUTO_SLEEP_MODE		0xFC23
> #define BT_CMD_HOST_SLEEP_CONFIG	0xFC59
> #define BT_CMD_HOST_SLEEP_ENABLE	0xFC5A
> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
> index cc65fd2..1a325fe 100644
> --- a/drivers/bluetooth/btmrvl_main.c
> +++ b/drivers/bluetooth/btmrvl_main.c
> @@ -539,6 +539,20 @@ static int btmrvl_setup(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static int btmrvl_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> +{
> +	struct btmrvl_private *priv = hci_get_drvdata(hdev);
> +	long ret;
> +	u8 buf[8];
> +
> +	buf[0] = MRVL_VENDOR_PKT;
> +	buf[1] = sizeof(bdaddr_t);
> +	bacpy((bdaddr_t *)&buf[2], bdaddr);

same thing here. Just use a memcpy.

> +	ret = btmrvl_send_sync_cmd(priv, BT_CMD_SET_BDADDR, buf, sizeof(buf));

So I keep wondering why you need the btmrvl_send_sync_cmd here. The HCI transport is up and running at this stage and sending vendor command should do the right thing. Similar to what you do in btusb driver.

You might have explained this to, but I must have clearly not understood it.

Regards

Marcel

