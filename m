Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868C429CEB;
	Tue, 11 Nov 2025 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852344; cv=none; b=ZM4eoPjkKfCAij0s/XM9zvpw84vrNGr3Mp9GCOAXZXcsyM/bLFAx7qZgiXldJzQ+qJwDwtpF05SZs0pOGZzOB0Ft84OuRpQJhTetoF7/5p8HHxYR9R5u3Id/dnoHGcT+OzCmcmDT7kBQ5LZL6PrJARDhMx10D+jcFftgNA1kum8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852344; c=relaxed/simple;
	bh=qkDWonWLbSZwhF8OLcBhudBMpXCbcTT+1PwDeGeJf+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwwOHsInMJD+aVpNZR9P8x1AaJbol7W9RRRE6q7JDKvjUGM7viMADRsetJ1GaW09+4NQtDSl+4cJbdIyDFKvEzy6CbQhDwRD1zFh9CnXINbIlyDHhOXZjPp82IzT257AHjRzvoomhOurvkCi/iLR+5V2l9IEQT8bIlBNAPsEQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de [141.14.13.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2E68D61B4847C;
	Tue, 11 Nov 2025 10:12:05 +0100 (CET)
Message-ID: <2c938b9d-6a11-47ed-9995-cd576d9088f6@molgen.mpg.de>
Date: Tue, 11 Nov 2025 10:12:03 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btrtl: Avoid loading the config file on
 security chips
To: Max Chou <max.chou@realtek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hilda Wu <hildawu@realtek.com>, alex_lu@realsil.com.cn,
 niall_ni@realsil.com.cn, Kidman Lee <kidman@realtek.com>
References: <20251105063736.456618-1-max.chou@realtek.com>
 <08601ca9-e038-45a7-bd98-4ab24013a84f@molgen.mpg.de>
 <acb85eada47f40d4ab6bfd4ae42f5861@realtek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <acb85eada47f40d4ab6bfd4ae42f5861@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Max,


Thank you for your reply, and thank you for sending out v2.

Am 05.11.25 um 10:19 schrieb Max Chou:

[…]

>> -----Original Message-----
>> From: Paul Menzel [mailto:pmenzel@molgen.mpg.de]
>> Sent: Wednesday, November 5, 2025 3:58 PM

>> Am 05.11.25 um 07:37 schrieb Max Chou:
>>> For chips with security enabled, it's only possible to load firmware
>>> with a valid signature pattern.
>>
>> How can security be enabled?
>>
>> What is currently logged? An error?
> 
> The security chips will be shipped to specific brand customers and
> are managed by an eFuse, which is programmed during manufacturing.> Currently, loading the config file causes initialization to fail on 
security chips.
> The security chips can only load firmware files that contain a valid signature.
> 
>> Please go into the changes. What is the vendor command 0xAD over 0x0D?
> 
> Actually, the current value is incorrect. The correct value for the
> parameters of the vendor command is 0xAD.
Understood. You should have mentioned in the commit message of v2, and 
maybe explain how that typo happened, and where that command is documented.

>>> - Example log for a security chip.
>>>
>>> Bluetooth: hci0: RTL: examining hci_ver=0c hci_rev=000a
>>>     lmp_ver=0c lmp_subver=8922
>>> Bluetooth: hci0: RTL: rom_version status=0 version=1
>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8922au_fw.bin
>>> Bluetooth: hci0: RTL: cfg_sz 0, total sz 71301
>>> Bluetooth: hci0: RTL: fw version 0x41c0c905
>>>
>>> - Example log for a normal chip.
>>>
>>> Bluetooth: hci0: RTL: examining hci_ver=0c hci_rev=000a
>>>     lmp_ver=0c lmp_subver=8922
>>> Bluetooth: hci0: RTL: rom_version status=0 version=1
>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8922au_fw.bin
>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8922au_config.bin
>>> Bluetooth: hci0: RTL: cfg_sz 6, total sz 71307
>>> Bluetooth: hci0: RTL: fw version 0x41c0c905
>>>
>>> Tested-by: Hilda Wu <hildawu@realtek.com>
>>> Signed-off-by: Nial Ni <niall_ni@realsil.com.cn>
>>> Signed-off-by: Max Chou <max.chou@realtek.com>
>>> ---
>>>    drivers/bluetooth/btrtl.c | 24 +++++++++++++-----------
>>>    1 file changed, 13 insertions(+), 11 deletions(-)

[…]


Kind regards,

Paul
