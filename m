Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A7155C82
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766003463; cv=none; b=AVFhNRMD9w8bceJRKNc6YDrbqxBwDiTSpyTfqvZ4PkEs/d/7z4ADh0zIweAeCcNnQhZYQNtsdjfflL42uuM26LRD6/O67rnkSW2IaKyvby7lgeM3rhfwkgVXOx+XoJClHwgvHUKceVSDVuN9b4ZaJ3H0h+HRRf8NOGq4w2xREZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766003463; c=relaxed/simple;
	bh=aW458C0YXzzhTO9v20YCM2W2QZ7+P9shCaajbzCDU40=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sWkkP/nJEilA9MSA/VkLydFaUZugZ6i9IOaiCpILt2L772HBmwA1HSQ6erDMi4i3KHCMMW4UkdrUM+GwkgYo3fNbZZnc7SAEpKfEDJC3wzhfEy6J7+Zqu7gyY9vWziLKf/bcTHoSU8HsjfGHI64UvFkbIGb0mkxSt9apTLt2Lyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hew+I054; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hew+I054"
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-657044fea68so540958eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 12:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766003459; x=1766608259; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=276aglpefDhpLEPLZE7zRE4d5cO5Al9QUAMMKwvtcs0=;
        b=Hew+I054auq8FRUjW1MsFmGNKmsya2ndBSRik1xyU60CFkYOkNDAGatPvztepdHF4l
         22hqdZkIBJOdAj3BcNqM1kzCZC1bRJ/lif0zzt3UjufMx9q2pE+Z/0eL3CwTjlcr/kpB
         mEdKArV8Ypf+jojmCPphWlw6dQlutTwV/KMF0ByUfPS7C7Q70ktrJSAklO/e1pCORwYC
         rQCWWEjw5I2uICysgh7mpXSb9c4iz3cPVYPkPx1jMptvuFpjmHZPNwudYHp+SYLAuoHo
         i+dh6fxU3IWiviK07LTsvRTuhj+K4e9S5ALXV7QiE7foAG0vCB6VJlfp7SbSRlzaj4m5
         CbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766003459; x=1766608259;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=276aglpefDhpLEPLZE7zRE4d5cO5Al9QUAMMKwvtcs0=;
        b=WafvUYC68Vsxg0ZcuyP1Sow1Ef3KrWpD+INc6WgZAVRSNn9Kam2ZFQTFL54Tv/fjPE
         3a+UXOUSyB0Efr+lvGtCyU9lE8f1evB+OahzA+ZVM2zxakhockd3Ye4psx40LRpjHBlJ
         WLKvjJ+FQZpBMKaVuO2KBJPNNCWzCqsowbju0yD+Pcy+mRX6JVifZ2tEofthAQfE3hNb
         E9NFy9LuG5TzDfOmcnEL+fPVZ8O7svz/2pmNHzgex+SqvZ3uF6kKxeouoBsJ+7vBw/Hn
         Rh7mTj3a/HzM/LNgyyZhz5vyfiJZWj86rWH4EnZYIN4cOwPwfqphvPk4EW7X8DdBsWhC
         bxCQ==
X-Gm-Message-State: AOJu0YyNCYbPAXwhPS0maE2OVYgppQPVCG73YTH08Co0H5ZgEYLVdP0r
	kPsJTZw+4i6eUpGFdED4FCiCtZzktNVUw3ia4PwZRKIDIMqNwYSKHtPeJgsbVlTL
X-Gm-Gg: AY/fxX6FEUUIiLmmrQbraESAU4eXzdInBKlKSqIicbVUwlk2DNIDvsEHMMDFb8/th4a
	oM7IuMFDGpWJW1qrerdZaAhz31Js5tzUZohaKdymwQ+8s+6yJlKCp70RTf8zUTxIMfh3w4hyzSk
	CgSpR5Q8r1hYTzTM7kRJzxtNS+jpK9fJ3xu6ehiYUrMuHWF9FY1UiHsucET9rGgtCUZj2XU3bT5
	iUFT0PCs182mIDJITH08J7Tn1bsXyOPV41qkpwEMD+YpJ5jElRUq8wK+27XHAUSzgfWXAsS28fQ
	oKPDM4NPtWJustTJB1AwaSCFzU3IeSEvcGlLfZ2devyf++4vCzlxPFX2vS2YeyBYoKx5gSc0qP8
	xIuAEi9VCWm03Bf3mzpqavtNkjZRPkJBlymD7by0tRpRaDe1olXZECWrSdSjumhnuDfKeUDH1Mi
	oPI317t8TRl+fd6ddd
X-Google-Smtp-Source: AGHT+IEpuilg6LHO//z0bEhnTnPEgFmWhnQ5ccs9S59mA14ujSN0Xkg/0k5T5JwyYdIfyOrhef4bJw==
X-Received: by 2002:a05:6820:810:b0:65c:f70e:ddb2 with SMTP id 006d021491bc7-65cfe6e6c63mr318937eaf.14.1766003458939;
        Wed, 17 Dec 2025 12:30:58 -0800 (PST)
Received: from [172.17.0.2] ([132.196.19.21])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17cfe8a4sm287817fac.3.2025.12.17.12.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 12:30:58 -0800 (PST)
Message-ID: <69431302.050a0220.90c2e.68d6@mx.google.com>
Date: Wed, 17 Dec 2025 12:30:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0202044990207661489=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ssorensen@roku.com
Subject: RE: [BlueZ,1/4] doc: Sync default system parameter list with kernel
In-Reply-To: <20251217160256.441737-2-ssorensen@roku.com>
References: <20251217160256.441737-2-ssorensen@roku.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0202044990207661489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1034329

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.41 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      647.22 seconds
MakeCheck                     PASS      22.03 seconds
MakeDistcheck                 PASS      246.23 seconds
CheckValgrind                 PASS      305.40 seconds
CheckSmatch                   PASS      354.38 seconds
bluezmakeextell               PASS      183.85 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      1052.98 seconds

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


--===============0202044990207661489==--
