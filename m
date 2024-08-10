Received: from se04.mfg.siteprotect.com (se04.mfg.siteprotect.com [64.26.60.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A04776A
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Aug 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.26.60.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723318034; cv=none; b=gBWCJGX3G8bdVopcjsvjwqAdqjoSVfERIzWTIWeSDQ4HAEsxfGZ4BuZ09iPuiewWyRgplVo9pqiuX/9DA/sE5xANTy9K8eLZaNShNTbVxa9wY4K09CukY/cKSZHCC6vUHVAahheoUFH2zWOENqa+5lC1JXDK6MoUO1X9QD4KfE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723318034; c=relaxed/simple;
	bh=/FppkCYGcsk/qEuIYuLAMVdJtJhAQNC0K4ATH+v5TE0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=J3cbvDNpJG0fw7imzU+cU/xQJ0mUNsUo3X1TFArY/0UNDHOzM2LB4FU5gn3Dr0SIVTsyhqG00ruXjhYIga+depF1gf9mV4ExZFfVGv0aUo3REEmsokBo/0NQBR+LVxz9ncuXMneji2ixtTn8c8Pf6A4nSIWZwg0rZbZXhybwVcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deater.net; spf=pass smtp.mailfrom=deater.net; arc=none smtp.client-ip=64.26.60.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deater.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deater.net
Received: from smtpauth02.mfg.siteprotect.com ([64.26.60.151])
	by se04.mfg.siteprotect.com with esmtp (Exim 4.92)
	(envelope-from <john@deater.net>)
	id 1scrEk-0084wn-2c
	for linux-bluetooth@vger.kernel.org; Sat, 10 Aug 2024 14:54:47 -0400
Received: from [192.168.8.126] (unknown [100.16.217.203])
	(Authenticated sender: clemej@deater.net)
	by smtpauth02.mfg.siteprotect.com (Postfix) with ESMTPSA id 4Wh91y0Dymz2YQR6D
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Aug 2024 14:54:42 -0400 (EDT)
Message-ID: <d5f953a4-24e0-4ad6-8ae0-7f0e3bcde9b2@deater.net>
Date: Sat, 10 Aug 2024 14:54:23 -0400
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
From: John Clemens <john@deater.net>
Subject: New Mediatek btusb device: 002: ID 13d3:3608 IMC Networks
 Wireless_Device
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: mfg.siteprotect.com; auth=pass smtp.auth=clemej@deater.net
X-SpamExperts-Domain: mfg.outbound
X-SpamExperts-Username: 64.26.60.150/31
Authentication-Results: mfg.siteprotect.com; auth=pass smtp.auth=64.26.60.150/31@mfg.outbound
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.10)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+xkjcF4yi0gqwXqq2f2swcPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wm48lgjrMJjS3WMShNNHhi/nqXT2xr6HqMZ+POH7czOqYG
 fxh2ENEODMHewZc4yyXikFgI0/6RKelFNcPKTH2ZIeebqmNzITIBQB6uQcT8T2u1MUcRmf1NIpBv
 dKbZcTrWG3oY6pNzt+xUyN3IyBnnBVisGv8MyVI5ms3guyJnGh5G31PMiKs3zRak+Ke2490UOled
 bu+r9+W9cDXvzL3SYbd2cLGRmWB3aU3sqlF7o3gSBQIyy8jPOgrZ1jeD95tNxaypTbp28NxghjNo
 pU/Oaqj4KISIRSJ5MfjE8OaunZEyYYf7TmlI3iEcqXK4A61ChHMQHCMEWTX9HEhwSP4/MSl+mev0
 M9cO0xP2892D0dINyegmOAE1PL2+VU47GrRWzMotJhi6xyLTp8GfDE+r3TQ3XNW75kcM0I7R0xJ3
 Qj3dKxLhoxcmaInYbR5vlqHoFu1Wj39VwqpRtLP9wHJtW5Yp8WMsNij0jzSVNljLySCv9TR+UxzL
 ZWL8hwGBjhoiDZaHjjUjL+gPrBh/8n4kpYzALSfDrtQHo6yRgtyrJWHpfx1GaPGwQwPfvoTrl4rZ
 s2q73eXis6/zllqRFFTqC54Le8QzY7aoJ8Yr6Jm/ZthzKcURE6yENJww12RgYdMVYwqzNFYdmRep
 5UACDGJwpbLwMaMYyNNf1jBpIt7T2pgn+NAz+31KXRj5A1Z2f9ALARd3M6pqX1NCSv/LkaPf72fn
 F2uEjzDLLyL0NObZ/JuYGAQyADCz6I+xLHb+XTQQxlORJ9clpYQibWCXiRddX9HHIETUSKPexyNR
 RCIVBWbjO41FyBEqIaDudcVplPEtt9W1gnxurANFwe55S0Sj5fEPIQ3tmgrgi1ih9kErEDQCUvKr
 xrnkq+NlF8Ob3D1rde0Vli9x4m1jLj3QjIrFJw3/w1ReFHLlZ9CxJS+Ek53NH+NQbPomg7sAiVvT
 REZ8K4EgtgsN2Ij6q4Ui0HC+N6mgRXwmhaF+5Wzan3Zps9lOlAelJocAmAzKnRSij1IXTIJFR5/H
 fFoWIZPfks/B
X-Report-Abuse-To: spam@se02.mfg.siteprotect.com


New USB ID for the Mediatek device in the Asus um5606wa laptop:

Bus 003 Device 002: ID 13d3:3608 IMC Networks Wireless_Device
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.10
   bDeviceClass          239 Miscellaneous Device
   bDeviceSubClass         2 [unknown]
   bDeviceProtocol         1 Interface Association
   bMaxPacketSize0        64
   idVendor           0x13d3 IMC Networks
   idProduct          0x3608 Wireless_Device
   bcdDevice            1.00
   iManufacturer           5 MediaTek Inc.
   iProduct                6 Wireless_Device
   iSerial                 7 000000000
   bNumConfigurations      1

I assume it's related to the wifi chipset, which is:

  c3:00.0 Network controller: MEDIATEK Corp. Device 7925

  mt7925e 0000:c3:00.0: ASIC revision: 79250000
  mt7925e 0000:c3:00.0: HW/SW Version: 0x8a108a10, Build Time: 
20231227093012a
  mt7925e 0000:c3:00.0: WM Firmware Version: ____000000, Build Time: 
20231227093232

I manually added it to btusb.c in 6.11.0-rc2 as below and it works fine 
with both my mouse and Bluetooth headset.  I'm just not sure where to 
place it in the list, I'll leave that to the maintainers.

{ USB_DEVICE(0x13d3, 0x3608), .driver_info = BTUSB_MEDIATEK |
                                              BTUSB_WIDEBAND_SPEECH |
                                              BTUSB_VALID_LE_STATES },

Thanks,
john.c



