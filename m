Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CD154BF0
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547166; cv=none; b=A/7uBCkipHIDOnud2eQLwp6KE1TtXVqrXyafBQ3WC1EN490Sk9n3SBfTjCLZFBZA5I5WHhJ5MfaicoLFUfG4L9IJ/8N9kLdVGGC3I7algqKPvSm8hhEp8CvqFiTBF2CX1IxAO7jcFIwtTqGIWAbjU0Z4UQHfvsPBn2JUhWf5y7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547166; c=relaxed/simple;
	bh=1uCd2qHD6gRi8+kesMzlMqRCyUdH11hX6CMdkVNEOqA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jxSPB5zirgOTm71G++a7HizR7QT/nvmASMIV08HySPiWhP5RNF+Mg5DHI4iYB6ZtBmVoF9XFC0nhkrKwmuHxcc2l8dsgyltx4MahSb09kwjMBxmtlIx1I07Sf5k9LioYFJTYIP3LGSHN2v1mfem0h1d6QFFtsfesI6A4GAqyB3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od+BMkWY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od+BMkWY"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6da202aa138so1907134b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 08:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706547164; x=1707151964; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=icssnp2e8pOdPXx0joTiMgcmuns48vkxNU8uspDCDcE=;
        b=Od+BMkWYY7CCUhLL6aT2/1LDnLe/Mkh06RAX223NNLRARxeUDgfKG6TAHEkC0AfH/V
         b+DR16Bp08/OeJNUSKXXan9fHQolsa6HsRvb8oRNKYnT/DiIdyo50w7ENmEfH/U3MJz6
         NcJ15sQMXq/BCI9l2RYIBIvkbwWIrMKnTqZFP9k/TQ/LokRfz8BITPjuwzUPFQ3ZMQkd
         1gg9l4P8cw/8ufIXzQaxLVEefAkbqthrQU43vRE9dP2tPcInNL0DnSa4IC0YjMbWua17
         k7y+Hr2WIbZEjnSQvn+k7kdoyKHQpjS8y+EXE8RYXgdS4m+yud9CjrfrRqhOmPTtDory
         wKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706547164; x=1707151964;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icssnp2e8pOdPXx0joTiMgcmuns48vkxNU8uspDCDcE=;
        b=lWNnE8zzwWVVS/FN/YSB6JHxdNgOc7Co/TRn50PbgN+tXrraSWpqjZwyaXl7DW2V1+
         F9znO/l0xTH/7oZwtxvfD5cu2u651ib9LxvpKqiazwyHRXnlXQl+4qr8wvSVISiX/HVj
         SBGSwVhyPGIG8oyWXpWxnWTLTjqDaehzSI89DrP9HE6pqylgSsTflWaGl8G0gMGEztLm
         PotpbNfgpP11nR7HvVIvIFFWZBQQ54G9SWU393J6355bq/N7uDMwSnvgVl8BeIJJOk+o
         NdMLYs9tbb720ubipD8LCNRy3BN7mFGQviIHbxX5gDA6q8VSyO0/S0hElcJSFP8pmVKM
         8O1A==
X-Gm-Message-State: AOJu0YxLDi1r+6DC+D6xg1if4SkFiNYcksLySXkwSBqxsWApdymKCtLZ
	/1sBBPJQ0++Es1IOYST/MQ6kLUHGyKHuX2fC94KHrqdsWsIM6RswnYjBUG3F
X-Google-Smtp-Source: AGHT+IGebWX2oQPNdmHsFONjpIG8KmkV4qF/nuRkYFbnr5jL3HJqWxFl5NCVavEGXnfF5s294UZdsQ==
X-Received: by 2002:a05:6a20:3ca1:b0:19a:28c3:ee0c with SMTP id b33-20020a056a203ca100b0019a28c3ee0cmr6192891pzj.26.1706547164500;
        Mon, 29 Jan 2024 08:52:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVXYjPHXCMUqDui63sGK57UW5k4MhQ8JksLT/1j/SzsdwlwwxQx03EcSmk1lHQg3OzmkovkK4D1KM//8QAmsnduQinfuX2BsQ==
Received: from [172.17.0.2] ([4.227.115.10])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902ee4200b001d8f5560503sm1128347plo.222.2024.01.29.08.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 08:52:44 -0800 (PST)
Message-ID: <65b7d7dc.170a0220.6c48d.3bc2@mx.google.com>
Date: Mon, 29 Jan 2024 08:52:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3402526460624211253=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Update bcast ep register and config props
In-Reply-To: <20240129152928.3904-2-iulia.tanasescu@nxp.com>
References: <20240129152928.3904-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3402526460624211253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=820948

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       PASS      0.68 seconds
BuildEll                      PASS      24.02 seconds
BluezMake                     PASS      709.31 seconds
MakeCheck                     PASS      15.43 seconds
MakeDistcheck                 PASS      163.99 seconds
CheckValgrind                 PASS      226.10 seconds
CheckSmatch                   PASS      327.51 seconds
bluezmakeextell               PASS      107.31 seconds
IncrementalBuild              PASS      2007.50 seconds
ScanBuild                     PASS      944.40 seconds



---
Regards,
Linux Bluetooth


--===============3402526460624211253==--
