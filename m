Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411064C602
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472732; cv=none; b=TknuI3Q6gWxEh6mp5PpwsUfxXWFH26tq2AGWueMunRtJEvkrjVjD0NwfFlDB1dr2xTaZdyAHNFOnOgZN0Z1CDe5UCshbmETSL0Pwyw6NFW8/qUHxPm9nQJKSNQnzSnmT1zrSH16RC15BznjKaf5eVRQlgojBbdsVtwW2/RVfUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472732; c=relaxed/simple;
	bh=gQ/IyXUlrH/tvvGMaaglG6Ep0mPwQg07330sImHYuVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBaV+WiHE//OTotS2p8gfuoouhHTrAWccvvZlxDtpXFB7vmKXbteeMMONgL14GpwimHtaKVXrVdKgTaeZ6tYJdI7aNGN8LBLFJAvqdR1ty42Bw+3mZzyW89T9k/1WCQUI6BY8Dh1QbzHTZG8R2TjGMj915nyBLTXv8Hb9FlHK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aeffe.dynamic.kabel-deutschland.de [95.90.239.254])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C274461E5FE05;
	Thu, 27 Jun 2024 09:18:30 +0200 (CEST)
Message-ID: <5a5027f2-dbe0-41c6-abdd-c1ac9605cfd2@molgen.mpg.de>
Date: Thu, 27 Jun 2024 09:18:30 +0200
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
 Vijay Satija <vijay.satija@intel.com>, linux-bluetooth@vger.kernel.org
References: <20240626092801.2343844-1-kiran.k@intel.com>
 <390bb99a-55ce-4a97-b268-93ce62bedbac@molgen.mpg.de>
 <PH0PR11MB7585AD51482CA4FC1F1035A9F5D72@PH0PR11MB7585.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <PH0PR11MB7585AD51482CA4FC1F1035A9F5D72@PH0PR11MB7585.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for your reply.

Am 27.06.24 um 03:03 schrieb K, Kiran:

>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Wednesday, June 26, 2024 5:56 PM

[…]

>> Am 26.06.24 um 11:28 schrieb Kiran K:
>>> BRI (Bluetooth Radio Interface) traffic from CNVr to CNVi was found
>>> causing cross talk step errors to WiFi. As a workaround, driver needs
>>> to reduce the drive strength of BRI. During *setup*, driver reads the
>>> drive strength value from efi variable and passes it to the controller
>>> via vendor specific command with opcode 0xfc0a.
>>
>> I am still surprised this is done via an EFI variable. Could you please add a
>> reference to section in the UEFI(?) specification? Hopefully that explains who is
>> supposed to set the variable.
> 
> "UefiCnvCommonDSBR" efi  variable would be created by OEMs.

Isn’t that approach fundamentally broken? How do the OEMs know, what 
variable to set. It needs to be standardized somewhere (name and allowed 
values). Also, there are non-UEFI firmwares, like coreboot based, used, 
for example, with Google Chromebooks. Lastly, users can manipulate UEFI 
variables to my knowledge.


Kind regards,

Paul
