Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E2C2EA172
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254327; cv=none; b=LKJxm9vuWKZGH25/2qskVyHVJFmhRztl11DO4NOIgJOrOYvjQHebqEUC4y1CZlQhiIXNw6KoTjBztXlwJAejVhaOlB9cNqFK2axJlzLY6lwyCXd3baStgAKn+J5c2YkdoVYy+a9MjP4qTKGdAf5Mb2D7oaJK3XhUvQSJSxDKzBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254327; c=relaxed/simple;
	bh=+h6ISUdkFhc9RPMegdmklOrXC540QHlePVLP9KxtvS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efBIjT5DGTdhwuLyZ4lbGEKxIfAVOxqFvVjvXUrcDFTfuPV36MQEoHdhSZtp2ntkziSKyQKDNpc1CozYmFg7tXgkC1Snf2KLnbyEASSpMV+AUDyZdFzGBpdDMZyF2pEoe9yVvrQxngJNHjFnkfA5xKpdZR3tbTigWyE/lpS5e0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E9BC06028825C;
	Wed, 18 Jun 2025 15:45:05 +0200 (CEST)
Message-ID: <1eaa30e8-3a4e-4ff4-8fc8-07e3a25aa443@molgen.mpg.de>
Date: Wed, 18 Jun 2025 15:45:05 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Add support for device 0x4d76
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 aluvala.sai.teja@intel.com
References: <20250618130251.774085-1-kiran.k@intel.com>
 <CABBYNZJf9wGcQSR9PPH9RfvrpRYtm_HScmVV6iBQOYwBowMk6A@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CABBYNZJf9wGcQSR9PPH9RfvrpRYtm_HScmVV6iBQOYwBowMk6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Luiz, dear Kiran,


Am 18.06.25 um 15:34 schrieb Luiz Augusto von Dentz:

> On Wed, Jun 18, 2025 at 8:46 AM Kiran K <kiran.k@intel.com> wrote:
>>
>> lspci -v -d  8086:4d76
>> 00:14.7 Bluetooth: Intel Corporation Device 4d76
>>          Subsystem: Intel Corporation Device 0011
>>          Flags: fast devsel, IRQ 255, IOMMU group 12
>>          Memory at 13013328000 (64-bit, non-prefetchable) [disabled] [size=16K]
>>          Capabilities: [c8] Power Management version 3
>>          Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
>>          Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>>          Capabilities: [80] MSI-X: Enable- Count=32 Masked-
>>          Capabilities: [100] Latency Tolerance Reporting
> 
> Isn't there something like /sys/kernel/debug/usb/devices that we can
> use? For instance lspci doesn't seem to show any information about the
> driver.

The switch `-k` should show the driver.

>> Signed-off-by: Kiran K <kiran.k@intel.com>
>> ---
>>   drivers/bluetooth/btintel_pcie.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
>> index cb3cf2b9acea..1113a6310bd0 100644
>> --- a/drivers/bluetooth/btintel_pcie.c
>> +++ b/drivers/bluetooth/btintel_pcie.c
>> @@ -35,6 +35,7 @@
>>
>>   /* Intel Bluetooth PCIe device id table */
>>   static const struct pci_device_id btintel_pcie_table[] = {
>> +       { BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) },
>>          { BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
>>          { BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) },
>>          { 0 }
>> --
>> 2.43.0

Kind regards,

Paul
