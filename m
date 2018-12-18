Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C08C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 23:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B7921873
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 23:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeLRXlQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:41:16 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47829 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeLRXlQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 18:41:16 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id E8C62CEE81;
        Wed, 19 Dec 2018 00:48:53 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [Patch v1] Bluetooth: btusb: Add support for Intel bluetooth
 device 8087:0029
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1543316964-4596-1-git-send-email-raghuram.hegde@intel.com>
Date:   Wed, 19 Dec 2018 00:41:14 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <D6B43E78-EB99-47C0-8FDA-BA661AE235D0@holtmann.org>
References: <1543316964-4596-1-git-send-email-raghuram.hegde@intel.com>
To:     Raghuram Hegde <raghuram.hegde@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Raghuram,

> Include the new USB product ID for Intel Bluetooth device 22260
> family(CcPeak)
> 
> The /sys/kernel/debug/usb/devices portion for this device is:
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=02 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=8087 ProdID=0029 Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> 
> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> ---
> drivers/bluetooth/btusb.c | 83 +++++++++++++++++++++++++++--------------------
> 1 file changed, 48 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 7439a7eb50ac..14931cf7afd4 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -344,6 +344,7 @@ static const struct usb_device_id blacklist_table[] = {
> 	/* Intel Bluetooth devices */
> 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW },
> 	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW },
> +	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW },
> 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
> 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
> 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
> @@ -2055,6 +2056,46 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
> 	return -EILSEQ;
> }
> 
> +static int btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
> +					     struct intel_boot_params *params,
> +					     char *fw_name, size_t len,
> +					     bool is_sfi)
> +{
> +	switch (ver->hw_variant) {
> +	case 0x0b:	/* SfP */
> +	case 0x0c:	/* WsP */
> +		if (is_sfi) {
> +			snprintf(fw_name, len, "intel/ibt-%u-%u.sfi",
> +				le16_to_cpu(ver->hw_variant),
> +				le16_to_cpu(params->dev_revid));
> +		} else {
> +			snprintf(fw_name, len, "intel/ibt-%u-%u.ddc",
> +				le16_to_cpu(ver->hw_variant),
> +				le16_to_cpu(params->dev_revid));
> +		}
> +		break;
> +	case 0x11:	/* JfP */
> +	case 0x12:	/* ThP */
> +	case 0x13:	/* HrP */
> +	case 0x14:	/* CcP */
> +		if (is_sfi) {
> +			snprintf(fw_name, len, "intel/ibt-%u-%u-%u.sfi",
> +				le16_to_cpu(ver->hw_variant),
> +				le16_to_cpu(ver->hw_revision),
> +				le16_to_cpu(ver->fw_revision));
> +		} else {
> +			snprintf(fw_name, len, "intel/ibt-%u-%u-%u.ddc",
> +				le16_to_cpu(ver->hw_variant),
> +				le16_to_cpu(ver->hw_revision),
> +				le16_to_cpu(ver->fw_revision));
> +		}
> +		break;
> +	default:
> +		return -1;
> +	}
> +	return 0;
> +}

can we just make this bool and return either false or true.

The is_sfi part is useless to me. Just allow providing the suffix as const char *suffix into this function.

> +
> static int btusb_setup_intel_new(struct hci_dev *hdev)
> {
> 	struct btusb_data *data = hci_get_drvdata(hdev);
> @@ -2106,7 +2147,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 	case 0x11:	/* JfP */
> 	case 0x12:	/* ThP */
> 	case 0x13:	/* HrP */
> -	case 0x14:	/* QnJ, IcP */
> +	case 0x14:	/* CcP */
> 		break;
> 	default:
> 		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
> @@ -2190,23 +2231,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
> 	 *
> 	 */
> -	switch (ver.hw_variant) {
> -	case 0x0b:	/* SfP */
> -	case 0x0c:	/* WsP */
> -		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.sfi",
> -			 le16_to_cpu(ver.hw_variant),
> -			 le16_to_cpu(params.dev_revid));
> -		break;
> -	case 0x11:	/* JfP */
> -	case 0x12:	/* ThP */
> -	case 0x13:	/* HrP */
> -	case 0x14:	/* QnJ, IcP */
> -		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.sfi",
> -			 le16_to_cpu(ver.hw_variant),
> -			 le16_to_cpu(ver.hw_revision),
> -			 le16_to_cpu(ver.fw_revision));
> -		break;
> -	default:
> +	err = btusb_setup_intel_new_get_fw_name(&ver, &params, fwname,
> +						sizeof(fwname), true);
> +	if (err < 0) {
> 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
> 		return -EINVAL;
> 	}
> @@ -2222,23 +2249,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 	/* Save the DDC file name for later use to apply once the firmware
> 	 * downloading is done.
> 	 */
> -	switch (ver.hw_variant) {
> -	case 0x0b:	/* SfP */
> -	case 0x0c:	/* WsP */
> -		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u.ddc",
> -			 le16_to_cpu(ver.hw_variant),
> -			 le16_to_cpu(params.dev_revid));
> -		break;
> -	case 0x11:	/* JfP */
> -	case 0x12:	/* ThP */
> -	case 0x13:	/* HrP */
> -	case 0x14:	/* QnJ, IcP */
> -		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.ddc",
> -			 le16_to_cpu(ver.hw_variant),
> -			 le16_to_cpu(ver.hw_revision),
> -			 le16_to_cpu(ver.fw_revision));
> -		break;
> -	default:
> +	err = btusb_setup_intel_new_get_fw_name(&ver, &params, fwname,
> +						sizeof(fwname), false);
> +	if (err < 0) {
> 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
> 		return -EINVAL;
> 	}

Regards

Marcel

