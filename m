Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v2 2/2] Bluetooth: btqca: Add AR3002 rampatch support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1524728332-10093-2-git-send-email-loic.poulain@linaro.org>
Date: Thu, 26 Apr 2018 11:52:58 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        bgodavar@codeaurora.org
Message-Id: <1E4DE3D9-A8A7-4789-B6F1-C2CA4ED26EA8@holtmann.org>
References: <1524728332-10093-1-git-send-email-loic.poulain@linaro.org>
 <1524728332-10093-2-git-send-email-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> This patch adds rampatch download compatibility for ROME >= 3.2.
> Starting with ROME 3.2, the 'download mode' field of the rampatch
> header indicates if the controller acknowledges (or not) the received
> rampatch segments. If not, we need to send all the segments without
> expecting any event from the controller (except for the last segment).
> Goal is (I assume) to speed-up rampatch download.
> 
> This fixes BT on Dragonboard-600c P2 which includes the following BT
> controller:
> 
> hci0: ROME Patch Version Request
> hci0: Product:0x00000008
> hci0: Patch  :0x00000111
> hci0: ROM    :0x00000302
> hci0: SOC    :0x00000023
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
> v2: Do not check rome version, byte is reserved or dedicated to dnld mode
> 
> drivers/bluetooth/btqca.c | 105 ++++++++++++++++++++++------------------------
> drivers/bluetooth/btqca.h |  11 ++++-
> 2 files changed, 60 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 2793d41..857f219 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -127,28 +127,41 @@ static void rome_tlv_check_data(struct rome_config *config,
> 	BT_DBG("TLV Type\t\t : 0x%x", type_len & 0x000000ff);
> 	BT_DBG("Length\t\t : %d bytes", length);
> 
> +	config->dnld_mode = ROME_SKIP_EVT_NONE;
> +
> 	switch (config->type) {
> 	case TLV_TYPE_PATCH:
> 		tlv_patch = (struct tlv_type_patch *)tlv->data;
> -		BT_DBG("Total Length\t\t : %d bytes",
> +
> +		/* For Rome version 1.1 to 3.1, all segment commands
> +		 * are acked by a vendor specific event (VSE).
> +		 * For Rome >= 3.2, the download mode field indicates
> +		 * if VSE is skipped by the controller.
> +		 * In case VSE is skipped, only the last segment is acked.
> +		 */
> +		config->dnld_mode = tlv_patch->download_mode;
> +
> +		BT_DBG("Total Length           : %d bytes",
> 		       le32_to_cpu(tlv_patch->total_size));
> -		BT_DBG("Patch Data Length\t : %d bytes",
> +		BT_DBG("Patch Data Length      : %d bytes",
> 		       le32_to_cpu(tlv_patch->data_length));
> 		BT_DBG("Signing Format Version : 0x%x",
> 		       tlv_patch->format_version);
> -		BT_DBG("Signature Algorithm\t : 0x%x",
> +		BT_DBG("Signature Algorithm    : 0x%x",
> 		       tlv_patch->signature);
> -		BT_DBG("Reserved\t\t : 0x%x",
> -		       le16_to_cpu(tlv_patch->reserved1));
> -		BT_DBG("Product ID\t\t : 0x%04x",
> +		BT_DBG("Download mode          : 0x%x",
> +		       tlv_patch->download_mode);
> +		BT_DBG("Reserved               : 0x%x",
> +		       tlv_patch->reserved1);
> +		BT_DBG("Product ID             : 0x%04x",
> 		       le16_to_cpu(tlv_patch->product_id));
> -		BT_DBG("Rom Build Version\t : 0x%04x",
> +		BT_DBG("Rom Build Version      : 0x%04x",
> 		       le16_to_cpu(tlv_patch->rom_build));
> -		BT_DBG("Patch Version\t\t : 0x%04x",
> +		BT_DBG("Patch Version          : 0x%04x",
> 		       le16_to_cpu(tlv_patch->patch_version));
> -		BT_DBG("Reserved\t\t : 0x%x",
> +		BT_DBG("Reserved               : 0x%x",
> 		       le16_to_cpu(tlv_patch->reserved2));
> -		BT_DBG("Patch Entry Address\t : 0x%x",
> +		BT_DBG("Patch Entry Address    : 0x%x",
> 		       le32_to_cpu(tlv_patch->entry));
> 		break;
> 
> @@ -194,8 +207,8 @@ static void rome_tlv_check_data(struct rome_config *config,
> 	}
> }
> 
> -static int rome_tlv_send_segment(struct hci_dev *hdev, int idx, int seg_size,
> -				 const u8 *data)
> +static int rome_tlv_send_segment(struct hci_dev *hdev, int seg_size,
> +				 const u8 *data, enum rome_tlv_dnld_mode mode)
> {
> 	struct sk_buff *skb;
> 	struct edl_event_hdr *edl;
> @@ -203,12 +216,15 @@ static int rome_tlv_send_segment(struct hci_dev *hdev, int idx, int seg_size,
> 	u8 cmd[MAX_SIZE_PER_TLV_SEGMENT + 2];
> 	int err = 0;
> 
> -	BT_DBG("%s: Download segment #%d size %d", hdev->name, idx, seg_size);
> -
> 	cmd[0] = EDL_PATCH_TLV_REQ_CMD;
> 	cmd[1] = seg_size;
> 	memcpy(cmd + 2, data, seg_size);
> 
> +	if (mode == ROME_SKIP_EVT_VSE_CC || mode == ROME_SKIP_EVT_VSE) {
> +		return __hci_cmd_send(hdev, EDL_PATCH_CMD_OPCODE, seg_size + 2,
> +				      cmd);
> +	}
> +

any reason for these { } ?

Regards

Marcel

