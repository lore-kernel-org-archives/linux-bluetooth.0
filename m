Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C321103
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569876; cv=none; b=qGg8wvjSWFSpnXM3NM2AsLm6ar45UwjALk/2pHczCORlQFPe49yw/cuewdRxyCULib73YZmOXrsLJGV3QdZVaBIG4FR19LcwY3wQEaxEEH0/v2YGzHPnOnv687JJkgErIwsOXEi8+/+hSvG6S3z4D9L1mx15U2RHcj/vn+mbnuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569876; c=relaxed/simple;
	bh=i2cr2ua9vfUbYNixw0XRjRc+n7rfMAx/eSCk7lsSqm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFJk3z8+D91omSuCAUSdfzfsXox42hfx7k//T9Kjif89ImoWbeAMn61Zd1ElGUXTCU4w1z2hb0ZoPzuxp6lnf8kdxHKwUtJDPcBxqEXDU7vLEBZUG9w3jDrSMI0xwyBNN+M7TR/jvpo0pHAvuPrimxzGKmpn87n73iIKfGzRu3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 675D561E5FE35;
	Fri, 28 Jun 2024 12:17:11 +0200 (CEST)
Message-ID: <a1857259-79e7-46d5-92e2-08ba41f79eb6@molgen.mpg.de>
Date: Fri, 28 Jun 2024 12:17:11 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: btintel: Allow lowering of drive strength
 of BRI
To: Kiran K <kiran.k@intel.com>
Cc: Ravishankar Srivatsa <ravishankar.srivatsa@intel.com>,
 Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 Vijay Satija <vijay.satija@intel.com>, linux-bluetooth@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Archie Pusaka <apusaka@chromium.org>,
 Doug Anderson <dianders@chromium.org>
References: <20240626092801.2343844-1-kiran.k@intel.com>
 <390bb99a-55ce-4a97-b268-93ce62bedbac@molgen.mpg.de>
 <PH0PR11MB7585AD51482CA4FC1F1035A9F5D72@PH0PR11MB7585.namprd11.prod.outlook.com>
 <5a5027f2-dbe0-41c6-abdd-c1ac9605cfd2@molgen.mpg.de>
 <PH0PR11MB758565928C5A66E618BF38EDF5D02@PH0PR11MB7585.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <PH0PR11MB758565928C5A66E618BF38EDF5D02@PH0PR11MB7585.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +Guenter to get a Chromium person in the loop]

Dear Kiran,


Thank you for your reply.


Am 28.06.24 um 11:37 schrieb K, Kiran:

[…]

>> Am 27.06.24 um 03:03 schrieb K, Kiran:
>>
>>>> -----Original Message-----
>>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>>> Sent: Wednesday, June 26, 2024 5:56 PM
>>
>> […]
>>
>>>> Am 26.06.24 um 11:28 schrieb Kiran K:
>>>>> BRI (Bluetooth Radio Interface) traffic from CNVr to CNVi was found
>>>>> causing cross talk step errors to WiFi. As a workaround, driver
>>>>> needs to reduce the drive strength of BRI. During *setup*, driver
>>>>> reads the drive strength value from efi variable and passes it to
>>>>> the controller via vendor specific command with opcode 0xfc0a.
>>>>
>>>> I am still surprised this is done via an EFI variable. Could you
>>>> please add a reference to section in the UEFI(?) specification?
>>>> Hopefully that explains who is supposed to set the variable.
>>>
>>> "UefiCnvCommonDSBR" efi  variable would be created by OEMs.
>>
>> Isn’t that approach fundamentally broken? How do the OEMs know, what
>> variable to set. It needs to be standardized somewhere (name and allowed
>> values). Also, there are non-UEFI firmwares, like coreboot based, used, for
>> example, with Google Chromebooks. Lastly, users can manipulate UEFI
>> variables to my knowledge.
> 
> Intel shares the information about the UEFI variables to customers
> (via confidential documents). OEMs may modify these variables based
> on the platform / re-work / BT NIC etc. Also these variables are
> locked in BIOS, so I believe its not possible to modify these values
> later.
> 
> For non-UEFI firmwares, driver would fetch the data from BIOS from
> ACPI table.

Why can’t ACPI tables be used for all? I strongly oppose to add such an 
undocumented feature to the Linux kernel. Intel should oppose the 
current practice.

> Currently we don’t have requirement to support coreboot.
> I would submit patches for the same if it comes in future :)

Kind regards,

Paul
