Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDCC1BDEE
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541897; cv=none; b=lP1fTVHppPySA9+7TS1RM2yckUNdoQcZCVOjOEfnPN3nXYdlb8D4Uk/MIFWkstwHWedhFUrw03c9D247ah8IHk7p/8CXWJsTVbG7sUVYFAvt7Cd3bgf4MXsHdk2H3QZChxBDF8hIJoWoCxPs/QSm0jgoqNREPmc+LBxQpDOi+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541897; c=relaxed/simple;
	bh=8kwsH9lzK2PeC6O0taHggdb4zNyjJYv43CHTjPZAedw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxhMoN+L4z6xd3Pedu8YPDwDQyCAapBkKnNjc5Rz4d89yfRAyemSpCHWlOy2F2VrJ1YI32/jQv6N3TW/uyTjLUnIU9bwFTq3o+uQneWshUqMIpUU5+2l5xvfiQ41UsYd40Q4xqoUemxp7CGGgGrhwuM9WCnc8Z8y+Ni1uY+Ibj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aeda0.dynamic.kabel-deutschland.de [95.90.237.160])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 51DF361E5FE01;
	Mon,  4 Mar 2024 09:44:32 +0100 (CET)
Message-ID: <6e2a8ae7-1685-4d13-9b6b-c28290caf8b8@molgen.mpg.de>
Date: Mon, 4 Mar 2024 09:44:31 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel: Add support for downloading
 secondary boot loader image
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
 Ravishankar Srivatsa <ravishankar.srivatsa@intel.com>,
 Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
References: <20240301102412.11151-1-kiran.k@intel.com>
 <c4f91a66-2890-4e76-bc01-42dd0c9a17dd@molgen.mpg.de>
 <PH0PR11MB7585A403D6FF95B34DF981B8F5232@PH0PR11MB7585.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <PH0PR11MB7585A403D6FF95B34DF981B8F5232@PH0PR11MB7585.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for your reply.

Am 04.03.24 um 09:21 schrieb K, Kiran:

>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Friday, March 1, 2024 4:38 PM

[…]

>> Am 01.03.24 um 11:24 schrieb Kiran K:
>>> Some variants of Intel controllers like BlazarI supports downloading
>>> of
>>
>> support
>>
>> In the diff you write Blazar-I.
> 
> Ok. I will fix it in the next patch.
>>
>>> secondary bootloader. This patch adds the support to download
>>> secondary boot loader image before downloading operational firmware image.
>>
>> What is the secondary bootloader needed for?
>
> Primary bootloader is flashed over ROM and any issues found once the
> product released to market is hard / impossible to fix. So idea is to
> keep primary bootloader minimal and have secondary bootloader.
Thank you. I think, that’d be good to have in the commit message.

>>> Signed-off-by: Kiran K <kiran.k@intel.com>
>>> ---
>>> dmesg logs:
>>> [   16.537130] Bluetooth: Core ver 2.22
>>> [   16.537135] Bluetooth: Starting self testing
>>> [   16.540021] Bluetooth: ECDH test passed in 2818 usecs
>>> [   16.560666] Bluetooth: SMP test passed in 602 usecs
>>> [   16.560674] Bluetooth: Finished self testing
>>> [   16.560690] Bluetooth: HCI device and connection manager initialized
>>> [   16.560695] Bluetooth: HCI socket layer initialized
>>> [   16.560697] Bluetooth: L2CAP socket layer initialized
>>> [   16.560700] Bluetooth: SCO socket layer initialized
>>> [   16.571934] Bluetooth: hci0: Device revision is 0
>>> [   16.571940] Bluetooth: hci0: Secure boot is disabled
>>> [   16.571941] Bluetooth: hci0: OTP lock is disabled
>>> [   16.571942] Bluetooth: hci0: API lock is enabled
>>> [   16.571943] Bluetooth: hci0: Debug lock is disabled
>>> [   16.571943] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
>>> [   16.571945] Bluetooth: hci0: Bootloader timestamp 2022.46 buildtype 1 build 26590
>>> [   16.572189] Bluetooth: hci0: DSM reset method type: 0x00
>>> [   16.575002] Bluetooth: hci0: Found device firmware: intel/ibt-0090-0291-02.sfi
>>> [   16.575007] Bluetooth: hci0: Boot Address: 0x30099000
>>> [   16.575008] Bluetooth: hci0: Firmware Version: 200-10.24
>>> [   16.705698] Bluetooth: hci0: Waiting for firmware download to complete
>>> [   16.705927] Bluetooth: hci0: Firmware loaded in 127852 usecs
>>
>> Unrelated,  but this is quite long.
> I can pass on this information to firmware. I feel this seems to be
> OK as the maximum timeout for firmware download is 5 seconds.

Starting my system, in an ideal world it’s ready after at most one 
second (system firmware 0.5 seconds, Linux kernel 0.2 seconds + 0.3 user 
space). ;-) Ideally, Bluetooth would be operational by then.

>>> [   16.705952] Bluetooth: hci0: Waiting for device to boot
>>> [   16.708519] Bluetooth: hci0: Device booted in 2522 usecs
>>> [   16.708538] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
>>
>> (Unrelated, but this is shown on a lot of devices. One more time below.)
>>
>>> [   16.710296] Bluetooth: hci0: No device address configured
>>> [   16.712483] Bluetooth: hci0: Found device firmware: intel/ibt-0090-0291.sfi
>>> [   16.712497] Bluetooth: hci0: Boot Address: 0x10000800
>>> [   16.712498] Bluetooth: hci0: Firmware Version: 211-10.24
> 
>> It’s unclear from the logs, why two firmware files (with different
>> versions) are loaded.
>
> One is secondary bootloader (ibt-0090-0291-02.sfi) and the other one
> is operational firmware (ibt-0090-0291.sfi) .  It's possible to have
> different version.
Understood. Could that be made more clear in the logging output?

>>> [   16.930834] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>>> [   16.930840] Bluetooth: BNEP filters: protocol multicast
>>> [   16.930844] Bluetooth: BNEP socket layer initialized
>>> [   18.494137] Bluetooth: hci0: Waiting for firmware download to complete
>>> [   18.494897] Bluetooth: hci0: Firmware loaded in 1740634 usecs
>>
>> Hmm, 1.7 seconds is very long.
>>
>>> [   18.494972] Bluetooth: hci0: Waiting for device to boot
>>> [   18.529089] Bluetooth: hci0: Device booted in 33371 usecs
>>> [   18.529121] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
>>> [   18.529914] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0090-0291.ddc
>>> [   18.532158] Bluetooth: hci0: Applying Intel DDC parameters completed
>>> [   18.532582] Bluetooth: hci0: Found Intel DDC parameters: intel/bdaddress.cfg
>>> [   18.534109] Bluetooth: hci0: Applying Intel DDC parameters completed
>>> [   18.537170] Bluetooth: hci0: Firmware timestamp 2024.9 buildtype 0 build 58067
>>> [   18.537177] Bluetooth: hci0: Firmware SHA1: 0x81abf1ea
>>> [   18.540985] Bluetooth: hci0: Fseq status: Success (0x00)
>>> [   18.540992] Bluetooth: hci0: Fseq executed: 00.00.00.00
>>> [   18.540993] Bluetooth: hci0: Fseq BT Top: 00.00.00.00
>>> [   18.631360] Bluetooth: MGMT ver 1.22
>>> [   18.673023] Bluetooth: RFCOMM TTY layer initialized
>>> [   18.673031] Bluetooth: RFCOMM socket layer initialized
>>> [   18.673039] Bluetooth: RFCOMM ver 1.11
>>
>> Thank you for pasting this. It’d be great if you added it to the commit
>> message, so above ---.
> 
> Ok. I will have it part of commit message.

Thank you.

By the way, I had written some more comments below. It looks like you 
overlooked them.

>>>    drivers/bluetooth/btintel.c | 38 ++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 37 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
>>> index 6ba7f5d1b837..934aad89bbf1 100644
>>> --- a/drivers/bluetooth/btintel.c
>>> +++ b/drivers/bluetooth/btintel.c
>>> @@ -521,6 +521,9 @@ static int btintel_version_info_tlv(struct hci_dev
>> *hdev,
>>>    			    version->min_fw_build_nn, version-
>>> min_fw_build_cw,
>>>    			    2000 + version->min_fw_build_yy);
>>>    		break;
>>> +	case 0x02:
>>> +		variant = "IML";
>>
>> What does IML mean?
>>
>>> +		break;
>>>    	case 0x03:
>>>    		variant = "Firmware";
>>>    		break;
>>> @@ -2194,10 +2197,26 @@ static void btintel_get_fw_name_tlv(const
>> struct intel_version_tlv *ver,
>>>    				    char *fw_name, size_t len,
>>>    				    const char *suffix)
>>>    {
>>> +	const char *format;
>>>    	/* The firmware file name for new generation controllers will be
>>>    	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
>>>    	 */
>>> -	snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
>>> +	switch (INTEL_HW_VARIANT(ver->cnvi_bt)) {
>>> +	/* Only Blazar-I (0x1e) product supports downloading of secondary boot
>>> +	 * loader image
>>> +	 */
>>> +	case 0x1e:
>>
>> Should a macro be defined for 0x1e?
>>
>>> +		if (ver->img_type == 1)
>>
>> Below you write 0x0x. Should this be consistent?
>>
>>> +			format = "intel/ibt-%04x-%04x-02.%s";
>>> +		else
>>> +			format = "intel/ibt-%04x-%04x.%s";
>>> +		break;
>>> +	default:
>>> +			format = "intel/ibt-%04x-%04x.%s";
>>> +		break;
>>> +	}
>>> +
>>> +	snprintf(fw_name, len, format,
>>>    		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver- cnvi_top),
>>>    					  INTEL_CNVX_TOP_STEP(ver- cnvi_top)),
>>>    		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver- cnvr_top),
>>> @@ -2607,6 +2626,23 @@ static int btintel_bootloader_setup_tlv(struct
>> hci_dev *hdev,
>>>    	if (err)
>>>    		return err;
>>>
>>> +	err = btintel_read_version_tlv(hdev, ver);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +    /* If image type returned is 0x02, then controller supports secondary
>>> +     * boot loader image
>>> +     */
>>> +	if (ver->img_type == 0x02) {
>>
>> Could a macro be defined for 0x02?
>>
>>> +		err = btintel_prepare_fw_download_tlv(hdev, ver, &boot_param);
>>> +		if (err)
>>> +			return err;
>>> +
>>> +		err = btintel_boot(hdev, boot_param);
>>> +		if (err)
>>> +			return err;
>>> +	}
>>> +
>>>    	btintel_clear_flag(hdev, INTEL_BOOTLOADER);
>>>
>>>    	btintel_get_fw_name_tlv(ver, ddcname, sizeof(ddcname), "ddc");


Kind regards,

Paul
