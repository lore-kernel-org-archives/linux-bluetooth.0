Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04C315D23
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168868; cv=none; b=IW5nt5Zkm7hGUsPK9I4eD39G+0Vf2W68xyBWHaDwfkchkpudnK1Uk4Euh7FmH9OixYfh0copW6+UtrwLxQQ6wHiakGPd5SduDU34yh7uaIeXBofj/iQ5hCdshvxY81B/Zi4GuDFDe9bPpp5XIc8wGhuxdhXW8OwBQB33lmb43VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168868; c=relaxed/simple;
	bh=9fIPxmSu2WAfk4bqyqf4Z5A5ZLwqMRPXX8W8L4msK1g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ARlERONJw2BhcSc4hpfZq3ImaAWSr749ntzA/UR+fdIc8kbCrBWFU4dyB/5cce6entL472co/lELFMSkSZA1dn5MeUf/Fk/2GotUBeFH6fGASDkT8//NteoH2sifMPf+RJUfVxkoiC8/J9Kle10WdU5vrAu+/FfynuNi3EGr/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXv3AIx+; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXv3AIx+"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-894770e34afso38417466d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 03:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769168866; x=1769773666; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h23qiXyTYJ0QkNC2sl2RNU0CO9Oyrq4lq81pdbGsG8M=;
        b=gXv3AIx+QzzXdI7akZ2YU0yeo3D7lVPundOcpsBgP9F4AyGnAvCuAFzdy43zLbQR61
         bbkqVcIwye2g512xCrn5f+6YvTYgraM/fS3sSNVgjNj2Z43sXntbx3/KHAbYCLpbEOSH
         oywmW60tXyGVGDqeibFTvsJuHRKEpebdp8GoaojoOdWbP4K4sq989s3YEgNBXRxpydth
         RmU57/NdOfYksDoP27Og3Aw9iRTJ2d8dgdChXlTQPjYadVum2Zt6oj5EZInBR66L/dXV
         cLsOEPG06Bgsf1UjlI1QY7W0uw8IDQhmR3FXG9kVGlOgX0e1cykXsjv4Wa6tuXxn1wr4
         IAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769168866; x=1769773666;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h23qiXyTYJ0QkNC2sl2RNU0CO9Oyrq4lq81pdbGsG8M=;
        b=WTsl/XoMjym9nosMhCuPtx6Kv07xeDTDHnnJzTiFmrpWrOqA6BYGNr8voYrjQE9Qqt
         5FMnqdOXGcrGadhYzQf9tTdy0oo+/nMOYqwIxlQI91uwybavuyBwylG0blN5Oo9/u8dZ
         mrwCgbgGCTZAEpaW/0l6qPulOOzLVk1WzPz4wCxkh5gFgZUfC/XeCb7RWtZNSl6+I22v
         YqEJFiCEF9fn5tagygCEbF9Mfjvfa+8IrWPtxEwKS3EeD9/UrUkGRPH2M1Kg6/ot2ccU
         EEb50FHWNBsPdY7aAW/4VWxsS6z0fFNtm5ACLRCkQhfEgO4fUCrCG3PFeDHwM64PJ1yW
         eiNg==
X-Gm-Message-State: AOJu0YwSn41CFEexW8dATKC3Jw0SD43tlxL/EcRCOIVj9AM3jz8OdHWp
	k3i7U6mpixLh8RK4PLtRVgQx+5gz/lS5ibLctnnKKljceK1fBiatVChlBppS8muL
X-Gm-Gg: AZuq6aIauFob93VTt+cAdStfvwtLwVmR0vLMFqu62yH/8d1LjntY4kIjtjw3sfXtfOu
	Yl2cVLSrPjZDAIrwEKacGVJ8sqGSPGeyvxxLwfs4ktknWpPlVVkJ/HuC36//T8S8X1qRfEln60q
	sfAMo2zZ1KoXhtGSS0MuKPCyIApmcYvByAHTvMW1YbvuRyIcnq+5nXbD69yt+g37NHUnkURTxs5
	93lx7x2thNBn5a7AGLnXVxJ++gKzmRpG0taVC4osMYeS4/2rYbNuH0yLnthv3GbDemFFvHSmqyg
	ah/63OZQMjs08sy2KdZhFIpOg+IY1ZRYDJj8LVnBt8QU54glNGoN8bNh0anAZOtmpCVMdAFDcBU
	fe5U3zQcSfonPjFRWhYW3e8LfpV049tibqJAyFWwf9jTlwo15AlKH+eM+TgrUlzErMmygp+h/yx
	YMBb0oDB0Dczv3nII4GUM=
X-Received: by 2002:ad4:5de5:0:b0:890:33cd:eea1 with SMTP id 6a1803df08f44-894901ce314mr38332246d6.17.1769168866165;
        Fri, 23 Jan 2026 03:47:46 -0800 (PST)
Received: from [172.17.0.2] ([135.232.177.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89491933510sm15385566d6.42.2026.01.23.03.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 03:47:45 -0800 (PST)
Message-ID: <69735fe1.050a0220.15d80.b8f2@mx.google.com>
Date: Fri, 23 Jan 2026 03:47:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3079996182772885484=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Add PICS and howto for the SM qualification
In-Reply-To: <20260123105149.676695-1-frederic.danis@collabora.com>
References: <20260123105149.676695-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3079996182772885484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1046201

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      653.57 seconds
MakeCheck                     PASS      18.50 seconds
MakeDistcheck                 PASS      243.71 seconds
CheckValgrind                 PASS      291.54 seconds
CheckSmatch                   PASS      348.34 seconds
bluezmakeextell               PASS      181.21 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      1017.71 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3079996182772885484==--
