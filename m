Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v7 1/6] Bluetooth: btbcm: Move request/release_firmware()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432805106-25719-2-git-send-email-frederic.danis@linux.intel.com>
Date: Sat, 6 Jun 2015 07:41:46 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <76A581F5-12B9-45EB-B4DA-79A7B5B74980@holtmann.org>
References: <1432805106-25719-1-git-send-email-frederic.danis@linux.intel.com> <1432805106-25719-2-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Move request/release_firmware() out of btbcm_patchram().
> This allows a better error management, if request_firmware() returns an
> error then the controller will be used without firmware loading and 0 is
> returned.
> This will imply to change btbcm_patchram() to accept a firmware instead
> of firmware name.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/btbcm.c | 26 ++++++++++++--------------
> drivers/bluetooth/btbcm.h |  6 ++++--
> 2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 728fce3..c7aec97 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -89,21 +89,14 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> }
> EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
> 
> -int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
> +int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
> {
> 	const struct hci_command_hdr *cmd;
> -	const struct firmware *fw;
> 	const u8 *fw_ptr;
> 	size_t fw_size;
> 	struct sk_buff *skb;
> 	u16 opcode;
> -	int err;
> -
> -	err = request_firmware(&fw, firmware, &hdev->dev);
> -	if (err < 0) {
> -		BT_INFO("%s: BCM: Patch %s not found", hdev->name, firmware);
> -		return err;
> -	}
> +	int err = 0;
> 
> 	/* Start Download */
> 	skb = __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEOUT);
> @@ -129,8 +122,7 @@ int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
> 		fw_size -= sizeof(*cmd);
> 
> 		if (fw_size < cmd->plen) {
> -			BT_ERR("%s: BCM: Patch %s is corrupted", hdev->name,
> -			       firmware);
> +			BT_ERR("%s: BCM: Patch is corrupted", hdev->name);
> 			err = -EINVAL;
> 			goto done;
> 		}
> @@ -156,7 +148,6 @@ int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
> 	msleep(250);
> 
> done:
> -	release_firmware(fw);
> 	return err;
> }
> EXPORT_SYMBOL(btbcm_patchram);
> @@ -265,6 +256,7 @@ static const struct {
> int btbcm_setup_patchram(struct hci_dev *hdev)
> {
> 	char fw_name[64];
> +	const struct firmware *fw;
> 	u16 subver, rev, pid, vid;
> 	const char *hw_name = NULL;
> 	struct sk_buff *skb;
> @@ -335,9 +327,15 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
> 		hw_name ? : "BCM", (subver & 0x7000) >> 13,
> 		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
> 
> -	err = btbcm_patchram(hdev, fw_name);
> -	if (err == -ENOENT)
> +	err = request_firmware(&fw, fw_name, &hdev->dev);
> +	if (err < 0) {
> +		BT_INFO("%s: BCM: Patch %s not found", hdev->name, fw_name);
> 		return 0;
> +	}
> +
> +	btbcm_patchram(hdev, fw);
> +
> +	release_firmware(fw);
> 
> 	/* Reset */
> 	err = btbcm_reset(hdev);
> diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
> index eb6ab5f..de11ace 100644
> --- a/drivers/bluetooth/btbcm.h
> +++ b/drivers/bluetooth/btbcm.h
> @@ -21,11 +21,13 @@
>  *
>  */
> 
> +#include <linux/firmware.h>
> +

I removed this include and put it into the files that reference this.

Regards

Marcel

