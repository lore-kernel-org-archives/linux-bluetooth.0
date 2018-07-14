Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v3 4/9] Bluetooth: btrtl: add support for the RTL8723BS
 and RTL8723DS chips
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180710081117.25078-5-hdegoede@redhat.com>
Date: Sat, 14 Jul 2018 18:09:19 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
Message-Id: <6D5FE822-FF51-4502-956B-8993603021CC@holtmann.org>
References: <20180710081117.25078-1-hdegoede@redhat.com>
 <20180710081117.25078-5-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> The Realtek RTL8723BS and RTL8723DS chipsets are SDIO wifi chips. They
> also contain a Bluetooth module which is connected via UART to the host.
> 
> Realtek's userspace initialization tool (rtk_hciattach) differentiates
> these two via the HCI version and revision returned by the
> HCI_OP_READ_LOCAL_VERSION command.
> Additionally we apply these checks only the for UART devices. Everything
> else is assumed to be a "RTL8723B" which was originally supported by the
> driver (communicating via USB).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2 (Hans de Goede)
> -Fix some minor style issues / checkpatch warnings
> ---
> drivers/bluetooth/btrtl.c | 51 ++++++++++++++++++++++++++++++++++++---
> 1 file changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 6c0d88d23d6d..8dacca64fe41 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -38,6 +38,8 @@
> 
> #define IC_MATCH_FL_LMPSUBV	(1 << 0)
> #define IC_MATCH_FL_HCIREV	(1 << 1)
> +#define IC_MATCH_FL_HCIVER	(1 << 2)
> +#define IC_MATCH_FL_HCIBUS	(1 << 3)
> #define IC_INFO(lmps, hcir) \
> 	.match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV, \
> 	.lmp_subver = (lmps), \
> @@ -47,6 +49,8 @@ struct id_table {
> 	__u16 match_flags;
> 	__u16 lmp_subver;
> 	__u16 hci_rev;
> +	__u8 hci_ver;
> +	__u8 hci_bus;
> 	bool config_needed;
> 	bool has_rom_version;
> 	char *fw_name;
> @@ -75,6 +79,18 @@ static const struct id_table ic_id_table[] = {
> 	  .fw_name = "rtl_bt/rtl8723a_fw.bin",
> 	  .cfg_name = NULL },
> 
> +	/* 8723BS */
> +	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV |
> +			 IC_MATCH_FL_HCIVER | IC_MATCH_FL_HCIBUS,
> +	  .lmp_subver = RTL_ROM_LMP_8723B,
> +	  .hci_rev = 0xb,
> +	  .hci_ver = 6,
> +	  .hci_bus = HCI_UART,
> +	  .config_needed = true,
> +	  .has_rom_version = true,
> +	  .fw_name  = "rtl_bt/rtl8723bs_fw.bin",
> +	  .cfg_name = "rtl_bt/rtl8723bs_config.bin" },
> +
> 	/* 8723B */
> 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb),
> 	  .config_needed = false,
> @@ -89,6 +105,18 @@ static const struct id_table ic_id_table[] = {
> 	  .fw_name  = "rtl_bt/rtl8723d_fw.bin",
> 	  .cfg_name = "rtl_bt/rtl8723d_config.bin" },
> 
> +	/* 8723DS */
> +	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV |
> +			 IC_MATCH_FL_HCIVER | IC_MATCH_FL_HCIBUS,
> +	  .lmp_subver = RTL_ROM_LMP_8723B,
> +	  .hci_rev = 0xd,
> +	  .hci_ver = 8,
> +	  .hci_bus = HCI_UART,
> +	  .config_needed = true,
> +	  .has_rom_version = true,
> +	  .fw_name  = "rtl_bt/rtl8723ds_fw.bin",
> +	  .cfg_name = "rtl_bt/rtl8723ds_config.bin" },
> +
> 	/* 8821A */
> 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa),
> 	  .config_needed = false,
> @@ -118,7 +146,8 @@ static const struct id_table ic_id_table[] = {
> 	  .cfg_name = "rtl_bt/rtl8822b_config.bin" },
> 	};
> 
> -static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev)
> +static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
> +					     u8 hci_ver, u8 hci_bus)
> {
> 	int i;
> 
> @@ -129,6 +158,12 @@ static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev)
> 		if ((ic_id_table[i].match_flags & IC_MATCH_FL_HCIREV) &&
> 		    (ic_id_table[i].hci_rev != hci_rev))
> 			continue;
> +		if ((ic_id_table[i].match_flags & IC_MATCH_FL_HCIVER) &&
> +		    (ic_id_table[i].hci_ver != hci_ver))
> +			continue;
> +		if ((ic_id_table[i].match_flags & IC_MATCH_FL_HCIBUS) &&
> +		    (ic_id_table[i].hci_bus != hci_bus))
> +			continue;
> 
> 		break;
> 	}
> @@ -481,6 +516,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev)
> 	struct sk_buff *skb;
> 	struct hci_rp_read_local_version *resp;
> 	u16 hci_rev, lmp_subver;
> +	u8 hci_ver;
> 	int ret;
> 
> 	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
> @@ -501,14 +537,17 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev)
> 		    resp->hci_ver, resp->hci_rev,
> 		    resp->lmp_ver, resp->lmp_subver);
> 
> +	hci_ver = resp->hci_ver;
> 	hci_rev = le16_to_cpu(resp->hci_rev);
> 	lmp_subver = le16_to_cpu(resp->lmp_subver);
> 	kfree_skb(skb);
> 
> -	btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev);
> +	btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
> +					    hdev->bus);
> +

I am bit reluctant to let you use hdev->bus here since that should be essentially local to the core. I know you set it before calling hci_register_dev, but it was never really designed to be accessed again by the driver? Do you need access to it or can this be done internally in the driver?

Regards

Marcel

