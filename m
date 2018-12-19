Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00243C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 06:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAC621850
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 06:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeLSGIV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:08:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:11625 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbeLSGIU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 01:08:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 22:08:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,371,1539673200"; 
   d="scan'208";a="131166193"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2018 22:08:18 -0800
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 18 Dec 2018 22:08:17 -0800
Received: from bgsmsx151.gar.corp.intel.com (10.224.48.42) by
 fmsmsx122.amr.corp.intel.com (10.18.125.37) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 18 Dec 2018 22:08:17 -0800
Received: from bgsmsx102.gar.corp.intel.com ([169.254.2.166]) by
 BGSMSX151.gar.corp.intel.com ([169.254.3.166]) with mapi id 14.03.0415.000;
 Wed, 19 Dec 2018 11:38:14 +0530
From:   "Hegde, Raghuram" <raghuram.hegde@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [Patch v1] Bluetooth: btusb: Add support for Intel bluetooth
 device 8087:0029
Thread-Topic: [Patch v1] Bluetooth: btusb: Add support for Intel bluetooth
 device 8087:0029
Thread-Index: AQHUhkHlKCLp4eUgD06pXLWbSije6aWE7ZwAgADHs7A=
Date:   Wed, 19 Dec 2018 06:08:14 +0000
Message-ID: <E5FA71999F8E8845A748D0B68F0A4BDF2624C638@BGSMSX102.gar.corp.intel.com>
References: <1543316964-4596-1-git-send-email-raghuram.hegde@intel.com>
 <D6B43E78-EB99-47C0-8FDA-BA661AE235D0@holtmann.org>
In-Reply-To: <D6B43E78-EB99-47C0-8FDA-BA661AE235D0@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmU3NTI3MTAtOWU1NS00ZTYxLWJlZDgtYTk0OWE3Y2ZlY2IzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRjZ2TnlnYUVnQU1mYXpRMzZYTVY1bHJQTmJmSWtpWHJrWFBYY3lHdnc3TmpkQTJOc2J2REZEWDFCdnVtTjFDbCJ9
x-ctpclassification: CTP_NT
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Ack.
Will do the changes and submit new patch

Thanks
Raghuram

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org] 
Sent: Wednesday, December 19, 2018 5:11 AM
To: Hegde, Raghuram <raghuram.hegde@intel.com>
Cc: linux-bluetooth@vger.kernel.org; Tumkur Narayan, Chethan <chethan.tumkur.narayan@intel.com>
Subject: Re: [Patch v1] Bluetooth: btusb: Add support for Intel bluetooth device 8087:0029

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
> drivers/bluetooth/btusb.c | 83 
> +++++++++++++++++++++++++++--------------------
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
> 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL }, @@ 
> -2055,6 +2056,46 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
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
> static int btusb_setup_intel_new(struct hci_dev *hdev) {
> 	struct btusb_data *data = hci_get_drvdata(hdev); @@ -2106,7 +2147,7 
> @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 	case 0x11:	/* JfP */
> 	case 0x12:	/* ThP */
> 	case 0x13:	/* HrP */
> -	case 0x14:	/* QnJ, IcP */
> +	case 0x14:	/* CcP */
> 		break;
> 	default:
> 		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)", @@ 
> -2190,23 +2231,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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

