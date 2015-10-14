Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH 4/4] Bluetooth: btmrvl: change debug prints to btmrvl_dbg
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1444836883-14701-4-git-send-email-akarwar@marvell.com>
Date: Thu, 15 Oct 2015 01:08:52 +0200
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Cathy Luo <cluo@marvell.com>, Zhaoyang Liu <liuzy@marvell.com>
Message-Id: <E8748FA3-3F04-42F8-9B02-CF298DF734D3@holtmann.org>
References: <1444836883-14701-1-git-send-email-akarwar@marvell.com> <1444836883-14701-4-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> This patch changes all debug print from BT_INFO/BT_DBG/BT_ERR
> to marvell bluetooth driver specific debug functions.

so BT_INFO and BT_ERR are not debug prints. They are genuine valid information that should be printed when something goes wrong or is informational.

> 
> Signed-off-by: Zhaoyang Liu <liuzy@marvell.com>
> Signed-off-by: Cathy Luo <cluo@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_debugfs.c |   3 +-
> drivers/bluetooth/btmrvl_main.c    | 145 ++++++++++-------
> drivers/bluetooth/btmrvl_sdio.c    | 311 ++++++++++++++++++++++---------------
> 3 files changed, 275 insertions(+), 184 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
> index af52b03..7bbe3dc 100644
> --- a/drivers/bluetooth/btmrvl_debugfs.c
> +++ b/drivers/bluetooth/btmrvl_debugfs.c
> @@ -257,7 +257,8 @@ void btmrvl_debugfs_init(struct hci_dev *hdev)
> 	priv->debugfs_data = dbg;
> 
> 	if (!dbg) {
> -		BT_ERR("Can not allocate memory for btmrvl_debugfs_data.");
> +		btmrvl_dbg(priv->adapter, ERROR,
> +			   "Can not allocate memory for btmrvl_debugfs_data.");

Errors are not debug messages. The syntax for btmrvl_dbg is not correct. We can not have such a code merged upstream.

I am also feeling to see all this value with debug_mask and so on. The Linux kernel supports dynamic debug which is way more powerful than trying to invent your own mask based logging. And BT_DBG and other debug print functions are hooked into it. So why not use it.

If you prefer having some btmrvl_dev_info wrappers, then that seems reasonable, but they either map to BT_INFO or pr_dev_info or similar.

I would really prefer if this patch series gets re-thought and done the Linux kernel way.

Regards

Marcel

