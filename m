Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794683319;
	b=vgEE7XY2oEvNXvM1PsHts+JSi97NB52eYOG2nwWHANrPahbfyO1waky3pgukLy/DZvTL
	 JqrCsQmXrqvDhsH/LSe+khBXdNqWpJU0/jWbZFT6QkZO58McGS9iMUkKVU5O1Tgn5Yk1u
	 9wNIMODMIAEvK1njCM/kw0U0cxyu42HNrAxz53I/ku02Y9jSzC/y3QAb5Bbp1Eg3oBMtS
	 u54buWgqIccZtBbyjrkexDXeFvAOgBwbYj5rkHYvOC1s2wbdn8qukG6drptwgvVA+6cv0
	 vWcHfWHrmKAVdk5X3Ycc2aZyNlJPUp8zEJndFF/QewbkRDQU4hjrcxbI6mFRo8nCXUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794683319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=YFY9UjkgPNWIThF5om5ocDuaJ8JTncts2TfstW4AnDs=;
	b=GZuL+2LiQmo4y34ugDdsbVNzzXHyJuwAKRp0q/PV3e5uJtJBnvoyVAJX3qRNC6SA08z9
	 1uxXZRUvPyeGKsSla76XKJkgOpf4wccWziblkWeVhs9096mEdQvLlr55rrBw2whJSSrrw
	 Br2tmC5OIbAwnbcDRjzkTlp1vy7ZPk/adHjt2GjI1D3jTPpBVzkbNscCq9c9wRF0lenps
	 Qg5R1VM6WglD3h9zTzpFZmZuB9n2c2UBqgSvPH4DWKTDXxjoD8Ov0uwnGxCnnNKQMSv2F
	 JrKHk7c8yKxdw4RGqhas2Jjw/RRDU3FHChV6IcGhOmPRyGGvoT/UgYS0lEs/ziLJz7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="C/cPstZA";
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF0606A329
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 19:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89FF0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C/cPstZA
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e3b22e971so1001742f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 11:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794683318; x=1795288118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YFY9UjkgPNWIThF5om5ocDuaJ8JTncts2TfstW4AnDs=;
        b=C/cPstZAMhpmrf06eEdBXU+0EWtzh695hoeijM4QgtGPU72KEuxLOWIJuWD/yNdWpD
         crZiKbdbGiCayMU3YuH1SFNTScqL85UwJF3n/UEmQzhytSigdYvWeMsvtFegl/uQL3UE
         lLy4vJZzt78nTb/IpJ+m72sdsvVfr5Tuy4/RGue7xYnE0+GGn8SiO4LiUBtIv/K9xxVl
         TBTAUbqY8cxABrAfAJNPxOpyf17v6D7SwqHBRv70F0jusO9MWo2IsAMTsbeEI1j2hqty
         I4q5YhVcq831GMm5KRRcW+Vv4MSr/UadWfPggVgf00Oye8Abj5DbXwCkNPV82WJFZG3g
         Ec6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794683318; x=1795288118;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFY9UjkgPNWIThF5om5ocDuaJ8JTncts2TfstW4AnDs=;
        b=R1ZH/2D0q9yXlhoAW+Yh/6w1GdVJS5H6N0hIOOZy1YMUyMcTXg6jZg5ohVThbHGbz+
         aVLZhCjLKkvZ7jMah57HchJgFApsacNhyCCww8Cd8kwn7eMrHFzv4VPVli9IJvfTmCe0
         i31qjR1JZGW4Y7nHO7t9GSDKSbW/ChoTxB3l3aKz/6+6ohMYQmUYb1nnGN29x+qRdkAH
         owCVtwptKIoqE8UjAIqgPXZOVuDoYrObjzCm0lo7xqPqQGt0q/y1AZ1aoeJu1UAPUfv+
         xt4B1Ehmzp2re+0eBikLfcgHLivfnBfQO/YgbmAEQLIXxXW8NkJ7jtVPcYlvwYB7a4Hj
         wCxA==
X-Gm-Message-State: APuU4Z8AdUqik+WdjgC92FJBBBp0leMtKle7MiUwcJQ7CRb0BSx6gKjh
	2HcJY5bJzVd+mT3K0vf698ehR7i6njkE4NVsjYaKPbjDR/iUbjhS1dbSZIOUp+hVrSbSJw==
X-Gm-Gg: AYBFou1kzgQryymKWpZ6OFKC+i3Sbg60uUIu0CaEs0n9/3vgt+iCmLBi5Wa2ge1Tq3b
	6J0KswYKV45jHt2jDTZ1nCTK5vQ5p3N9fvIK+YyMXsCAGolprvTouXAZjE5P0t67K0nEBfLtbCA
	IYD6rXCGrsC++6VMlzUqjKQiSwVKDLMHa7P7Po1TFg23NMeFc3MFe57I5LZuGUKCYqHStzIVc4E
	YP5w1zOkC/qpQP6K/uNN0a3yTi3zb02j0gaSdFGmBk79JHDPp08Uf52Z56b6KSeCbDszwm81MYk
	iRxwB+W0tILVv0CIoHWUI+d+jKxbtlBUsTO1Fv25/xot7JVdQd43Y27GxhbsPyz7MGA658L3m7J
	nwXZuyVMV/hBV5LajG+XManePbN3CDciurVkzHxTLSJA3vkel0c4VpXcjxgn+2+t4Bd7nRTH3hT
	DDKE5zk5wLXCpK5UmD/c5CAjaVRdcn+63xLHpFe48DHn/M/NrSq4e3VOy1YnEn1s7DoLwhef73p
	1VPeW3+CiA/4LExgxlVXGq1poqU+orPy6AjzOa6g4L4RCM8Qgb0OqHfapOkD60rG0Fuz0nwIv7H
	WHztYG8zg4LNG8yuXX7Llrsf8DF9Ur7iHZUYWPI+Gvnc2Z/Ne6ZU2GXMZIpHIcE=
X-Received: by 2002:a05:600c:34d2:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb55ac6cabmr128983315e9.34.1794683317505;
        Sat, 14 Nov 2026 11:08:37 -0800 (PST)
Received: from [100.96.103.10] (vmi3588025.contaboserver.net. [169.58.107.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2901sm152411795e9.13.2026.11.14.11.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 11:08:37 -0800 (PST)
Message-ID: <99f9a7d5-d0c7-4a86-9be2-ca0ec70c4f41@gmail.com>
Date: Sat, 14 Nov 2026 22:08:34 +0300
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, kiran.k@intel.com
From: Vovan Nikolaevich <vov4ik533@gmail.com>
Subject: Hi,,,I am investigating a reproducible Bluetooth SAR initialization
 warning on an Intel AX201 controller in an ASUS ExpertBook B5402CBA running
 Gentoo Linux.,,The warning occurs during firmware initialization on both
 Linux 7.3.3 and 7.3.4:,,```,Bluetooth: hci0: Applying legacy Bluetooth
 SAR,Bluetooth: hci0: Failed to send sar ddc id:0x0137 (-22),```,,I captured
 the initial firmware initialization with btmon and confirmed that the
 controller explicitly rejects Intel DDC Config Write (0xfc8b), ID 0x0137,
 with HCI status 0x12.,,**Environment**,,- Hardware: Intel AX201 (USB
 8087:0026),- Laptop: ASUS ExpertBook B5402CBA,- Kernel: Gentoo Linux
 7.3.4-bdsm (also observed on 7.3.3-bdsm),- Bluetooth firmware: 2026.29, build
 82200,- Firmware SHA1 reported by controller: 0xd3d4fa22,- CNVi TOP:
 0x00080400,- CNVr TOP: 0x01300504,- Intel DDC file: intel/ibt-0040-4150.ddc
 (symlink to ibt-0040-0041.ddc),,**Confirmed HCI sequence**,,```,DDC ID
 Payload HCI status,0x0128 18 Success (0x00),0x0129 03 00 Success
 (0x00),0x0131 06 Success (0x00),0x0132 06 Success (0x00),0x0133 07 Success
 (0x00),0x0137 06 08 08 Invalid HCI Command Parameters (0x12),```,,The initial
 DDC configuration file contains only IDs 0x0128 and 0x0129, and both are
 applied successfully.,,The legacy SAR parameters come from the ACPI BRDS
 method at:,,```,\_SB.PC00.XHCI.RHUB.HS10,```,,The method reads the Bluetooth
 SAR values from the ASUS GNVS SystemMemory region. The controller
 initialization takes the legacy SAR path.,,In `btintel_set_legacy_sar()`, the
 first three SAR commands succeed. The next command, ID 0x0137 with payload
 `06 08 08`, is rejected. The function then returns without sending the
 remaining legacy SAR commands.,,**Questions**,,1. Is legacy SAR DDC ID 0x0137
 with a three-byte BR/EDR payload expected to be supported by this AX201
 firmware and hardware generation?,2. Are the payload values `06 08 08` valid
 for this command, or could the rejection indicate incompatible ACPI-provided
 SAR values?,3. If this rejection is expected for some Intel controllers,
 should `btintel` check capability or handle the unsupported command
 differently, while preserving the required radio power restrictions?,4. Could
 this result in only partial application of the platform's Bluetooth SAR
 settings?,,The controller finishes initialization and Bluetooth remains
 usable. I am not claiming that this warning causes the separate intermittent
 hardware error 0x0c observed on the system.,,I can provide a sanitized btmon
 capture, relevant DSDT/BRDS excerpts, and kernel initialization logs if
 useful.,,Thanks for looking into this.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am investigating a reproducible Bluetooth SAR initialization warning 
on an Intel AX201 controller in an ASUS ExpertBook B5402CBA running 
Gentoo Linux.

The warning occurs during firmware initialization on both Linux 7.3.3 
and 7.3.4:

Bluetooth: hci0: Applying legacy Bluetooth SAR
Bluetooth: hci0: Failed to send sar ddc id:0x0137 (-22)

I captured the initial firmware initialization with btmon and confirmed 
that the controller explicitly rejects Intel DDC Config Write (0xfc8b), 
ID 0x0137, with HCI status 0x12.

Environment

Hardware: Intel AX201 (USB 8087:0026)

Laptop: ASUS ExpertBook B5402CBA

Kernel: Gentoo Linux 7.3.4-bdsm (also observed on 7.3.3-bdsm)

Bluetooth firmware: 2026.29, build 82200

Firmware SHA1 reported by controller: 0xd3d4fa22

CNVi TOP: 0x00080400

CNVr TOP: 0x01300504

Intel DDC file: intel/ibt-0040-4150.ddc (symlink to ibt-0040-0041.ddc)

Confirmed HCI sequence

DDC ID   Payload    HCI status
0x0128   18         Success (0x00)
0x0129   03 00      Success (0x00)
0x0131   06         Success (0x00)
0x0132   06         Success (0x00)
0x0133   07         Success (0x00)
0x0137   06 08 08   Invalid HCI Command Parameters (0x12)

The initial DDC configuration file contains only IDs 0x0128 and 0x0129, 
and both are applied successfully.

The legacy SAR parameters come from the ACPI BRDS method at:

\_SB.PC00.XHCI.RHUB.HS10

The method reads the Bluetooth SAR values from the ASUS GNVS 
SystemMemory region. The controller initialization takes the legacy SAR 
path.

In btintel_set_legacy_sar(), the first three SAR commands succeed. The 
next command, ID 0x0137 with payload 06 08 08, is rejected. The function 
then returns without sending the remaining legacy SAR commands.

Questions

Is legacy SAR DDC ID 0x0137 with a three-byte BR/EDR payload expected to 
be supported by this AX201 firmware and hardware generation?

Are the payload values 06 08 08 valid for this command, or could the 
rejection indicate incompatible ACPI-provided SAR values?

If this rejection is expected for some Intel controllers, should btintel 
check capability or handle the unsupported command differently, while 
preserving the required radio power restrictions?

Could this result in only partial application of the platform's 
Bluetooth SAR settings?

The controller finishes initialization and Bluetooth remains usable. I 
am not claiming that this warning causes the separate intermittent 
hardware error 0x0c observed on the system.

I can provide a sanitized btmon capture, relevant DSDT/BRDS excerpts, 
and kernel initialization logs if useful.

Thanks for looking into this.
