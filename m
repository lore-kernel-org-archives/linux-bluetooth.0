Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D0E6BFC2
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291273; cv=none; b=uYU92j58VfiS+2DxyyPtTCxGnylFNEzK8XEamGXbwmkKdYXl1IYeSG9sR46C15MdcKoZ3D21OjgG6y+ADInCj41xfXCivL08U4oupJPjZX1HETW2mJ6mllIxCiQlCIBDvq+0buL+vWepNzdTARjl1QdoJNntmmN55hxJ9UstfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291273; c=relaxed/simple;
	bh=DPAWIm/LmepvffLQnE2gbYi51zt2/JYyOEK2J3xmKW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VguUkyCglJcE3TdfrXRDQWbLASmuYCuQ8M5WIDymHb+6Fsy6REa7b3pUA6ttQXVoGIAaz4B0R5RA665JlDEP4C+LDGpjXXuJQ8UQRE9IWLmwB3Wd8X/RIPRQ4qFcxz0csdF+eJhDZrI/LobfoIpHzAmkStkF3q4IzPDxFi7Xhmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4EDB061E5FE01;
	Fri,  1 Mar 2024 12:07:30 +0100 (CET)
Message-ID: <c4f91a66-2890-4e76-bc01-42dd0c9a17dd@molgen.mpg.de>
Date: Fri, 1 Mar 2024 12:07:30 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel: Add support for downloading
 secondary boot loader image
Content-Language: en-US
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com
References: <20240301102412.11151-1-kiran.k@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240301102412.11151-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for your patch.


Am 01.03.24 um 11:24 schrieb Kiran K:
> Some variants of Intel controllers like BlazarI supports downloading of

support

In the diff you write Blazar-I.

> secondary bootloader. This patch adds the support to download secondary
> boot loader image before downloading operational firmware image.

What is the secondary bootloader needed for?

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> dmesg logs:
> [   16.537130] Bluetooth: Core ver 2.22
> [   16.537135] Bluetooth: Starting self testing
> [   16.540021] Bluetooth: ECDH test passed in 2818 usecs
> [   16.560666] Bluetooth: SMP test passed in 602 usecs
> [   16.560674] Bluetooth: Finished self testing
> [   16.560690] Bluetooth: HCI device and connection manager initialized
> [   16.560695] Bluetooth: HCI socket layer initialized
> [   16.560697] Bluetooth: L2CAP socket layer initialized
> [   16.560700] Bluetooth: SCO socket layer initialized
> [   16.571934] Bluetooth: hci0: Device revision is 0
> [   16.571940] Bluetooth: hci0: Secure boot is disabled
> [   16.571941] Bluetooth: hci0: OTP lock is disabled
> [   16.571942] Bluetooth: hci0: API lock is enabled
> [   16.571943] Bluetooth: hci0: Debug lock is disabled
> [   16.571943] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [   16.571945] Bluetooth: hci0: Bootloader timestamp 2022.46 buildtype 1 build 26590
> [   16.572189] Bluetooth: hci0: DSM reset method type: 0x00
> [   16.575002] Bluetooth: hci0: Found device firmware: intel/ibt-0090-0291-02.sfi
> [   16.575007] Bluetooth: hci0: Boot Address: 0x30099000
> [   16.575008] Bluetooth: hci0: Firmware Version: 200-10.24
> [   16.705698] Bluetooth: hci0: Waiting for firmware download to complete
> [   16.705927] Bluetooth: hci0: Firmware loaded in 127852 usecs

Unrelated,  but this is quite long.

> [   16.705952] Bluetooth: hci0: Waiting for device to boot
> [   16.708519] Bluetooth: hci0: Device booted in 2522 usecs
> [   16.708538] Bluetooth: hci0: Malformed MSFT vendor event: 0x02

(Unrelated, but this is shown on a lot of devices. One more time below.)

> [   16.710296] Bluetooth: hci0: No device address configured
> [   16.712483] Bluetooth: hci0: Found device firmware: intel/ibt-0090-0291.sfi
> [   16.712497] Bluetooth: hci0: Boot Address: 0x10000800
> [   16.712498] Bluetooth: hci0: Firmware Version: 211-10.24

It’s unclear from the logs, why two firmware files (with different 
versions) are loaded.

> [   16.930834] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   16.930840] Bluetooth: BNEP filters: protocol multicast
> [   16.930844] Bluetooth: BNEP socket layer initialized
> [   18.494137] Bluetooth: hci0: Waiting for firmware download to complete
> [   18.494897] Bluetooth: hci0: Firmware loaded in 1740634 usecs

Hmm, 1.7 seconds is very long.

> [   18.494972] Bluetooth: hci0: Waiting for device to boot
> [   18.529089] Bluetooth: hci0: Device booted in 33371 usecs
> [   18.529121] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> [   18.529914] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0090-0291.ddc
> [   18.532158] Bluetooth: hci0: Applying Intel DDC parameters completed
> [   18.532582] Bluetooth: hci0: Found Intel DDC parameters: intel/bdaddress.cfg
> [   18.534109] Bluetooth: hci0: Applying Intel DDC parameters completed
> [   18.537170] Bluetooth: hci0: Firmware timestamp 2024.9 buildtype 0 build 58067
> [   18.537177] Bluetooth: hci0: Firmware SHA1: 0x81abf1ea
> [   18.540985] Bluetooth: hci0: Fseq status: Success (0x00)
> [   18.540992] Bluetooth: hci0: Fseq executed: 00.00.00.00
> [   18.540993] Bluetooth: hci0: Fseq BT Top: 00.00.00.00
> [   18.631360] Bluetooth: MGMT ver 1.22
> [   18.673023] Bluetooth: RFCOMM TTY layer initialized
> [   18.673031] Bluetooth: RFCOMM socket layer initialized
> [   18.673039] Bluetooth: RFCOMM ver 1.11

Thank you for pasting this. It’d be great if you added it to the commit 
message, so above ---.

>   drivers/bluetooth/btintel.c | 38 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 6ba7f5d1b837..934aad89bbf1 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -521,6 +521,9 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
>   			    version->min_fw_build_nn, version->min_fw_build_cw,
>   			    2000 + version->min_fw_build_yy);
>   		break;
> +	case 0x02:
> +		variant = "IML";

What does IML mean?

> +		break;
>   	case 0x03:
>   		variant = "Firmware";
>   		break;
> @@ -2194,10 +2197,26 @@ static void btintel_get_fw_name_tlv(const struct intel_version_tlv *ver,
>   				    char *fw_name, size_t len,
>   				    const char *suffix)
>   {
> +	const char *format;
>   	/* The firmware file name for new generation controllers will be
>   	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
>   	 */
> -	snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
> +	switch (INTEL_HW_VARIANT(ver->cnvi_bt)) {
> +	/* Only Blazar-I (0x1e) product supports downloading of secondary boot
> +	 * loader image
> +	 */
> +	case 0x1e:

Should a macro be defined for 0x1e?

> +		if (ver->img_type == 1)

Below you write 0x0x. Should this be consistent?

> +			format = "intel/ibt-%04x-%04x-02.%s";
> +		else
> +			format = "intel/ibt-%04x-%04x.%s";
> +		break;
> +	default:
> +			format = "intel/ibt-%04x-%04x.%s";
> +		break;
> +	}
> +
> +	snprintf(fw_name, len, format,
>   		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvi_top),
>   					  INTEL_CNVX_TOP_STEP(ver->cnvi_top)),
>   		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvr_top),
> @@ -2607,6 +2626,23 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>   	if (err)
>   		return err;
>   
> +	err = btintel_read_version_tlv(hdev, ver);
> +	if (err)
> +		return err;
> +
> +    /* If image type returned is 0x02, then controller supports secondary
> +     * boot loader image
> +     */
> +	if (ver->img_type == 0x02) {

Could a macro be defined for 0x02?

> +		err = btintel_prepare_fw_download_tlv(hdev, ver, &boot_param);
> +		if (err)
> +			return err;
> +
> +		err = btintel_boot(hdev, boot_param);
> +		if (err)
> +			return err;
> +	}
> +
>   	btintel_clear_flag(hdev, INTEL_BOOTLOADER);
>   
>   	btintel_get_fw_name_tlv(ver, ddcname, sizeof(ddcname), "ddc");


Kind regards,

Paul
