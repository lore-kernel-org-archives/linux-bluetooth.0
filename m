Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353FE846D
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613258; cv=none; b=Ov//IHqMtVCDf2RPEU/Tk/QJmiI7nX0bJzEI/GRIZ5Rxn45v7FmhSEvCLMk0vU34SwSCbb91NWDmJeMPDgpc+hpqOM/tZH4XeRQWO2ioMxVijM7Ouv/hfjMjnzg4A+4NuTowmF++Hs2SdHLzDCyv6v/uDD3gzJGOl8NBM56UQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613258; c=relaxed/simple;
	bh=HAciBWEPj/yi1nBE7A4Fa9x33wwQDP1uuQmW1fushJ4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rUfjJLDYlTpFGCCgjaQVg91TTZyRZ1QCE2+V06tOw61GwSIbt4kKcImDNFzXLhVZcgTgA8qAYt1rLSBOk0TYKuEWIK9AbMxCdmBYKElfZGxAw/5R+SZUVptIPOjYOMkWfARb7vVobAjR9cOPY8OsU/YpTUbvyjI1yQfpwJ857zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4zVoBdU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4zVoBdU"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22548a28d0cso6789295ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 06:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741613256; x=1742218056; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HGTRuIDnk99BeUqXRP2kZ+FgyZNQcTSaEBnXRHx/wOs=;
        b=Z4zVoBdUVaR4etVyyq3K9sRSV/oMjTYzlU/d1TvVHIzwfetn3vOoyK5CRI90eOWgl2
         Ky7QyR2MWmHUvkm1DjZjFe2hovA7VCcTvuQR5tev7Ag2GN/iMM4zlgKL4PshnmDbsymt
         foPHTogZ7vx2yCL4Li/mh+6HtUOkYOSbE5bWdhBN3x3kJKlSZvYYMAxTu4QeaVoE50SO
         Pv+/IHiNcazFihZGs63GF3i95q+sQrQEtrXZFwfQzvq4t8U3y8rOYtw4DFr6nu8cuWHo
         wsPpsMaE0AbArMOXnxlOqY2HY3Fe0xZPa00IRLOl6BAsvcxpSbnCJ2xIPZSkinfoSBAg
         H7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741613256; x=1742218056;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGTRuIDnk99BeUqXRP2kZ+FgyZNQcTSaEBnXRHx/wOs=;
        b=cJwwkF1p9HTC6oDVV6j2mRKYvWbGM6LwreD8luphJ0F2HZoxc53AyxfhygEZL/ZBXe
         O1twsLFBl4YFimdqxOcPZdIuayaLls5JCVuRtL6p9iX/USME1FRKjZHJu6+suM2ZcwAt
         oFHGy3R5ZkWkhmqYD5oDFIjwVhH+ZM+jzuFNC/t/5P1Je6x9KXj4MnUlyRY7Y3wGMsGZ
         yC/NQljiEHKzCpewS0b3OmpGbFuTOfazOi/0dWHMwfbnQa9SCK4NmFXbgNoq5VXwSm6Q
         H7Qmx4WSzIKbED/2Yl76I3HOFqhjEDC05fA+Z2AkjBWvG03OmkbOLmcbDtzaiD9sK8TA
         3Mow==
X-Gm-Message-State: AOJu0YwueHE5xJ3SdpfO+T3Z6kpSkfUgXRw0JLD8wWCT3zNFyMNCWVTT
	5gqg7ay/v7HTfuM+qS1k90oFXuEOIxhubqvFiOjggY4/q0LlQTh/MXW/jg==
X-Gm-Gg: ASbGncs2YIhK6NFh4BX5iRQSzyiZRNhKssGHkYQoucyneWhD5wakka/p6os2fefsCQC
	34fyS3xbK6XUeRfCrPVhtQO5jYlUA1UaP9GaW/8pn4+PozdxqnpEskeJQKU19HpeIN/gDvLsDdg
	4FzY2tXrRJLZCdplf9tNiLAtGW38UeVcq+73fkswAX2Nq60lcBCD4Oel9iY/aECCmtYfZO62Ptv
	EWv6E1q+UiDr9TkQp0ByKi6gyfDSIvH/i2tHAwrca2tM4Pq1GJGYotKrvF0dUr2DZZGdAphJ1a8
	FeHVzUrT5m66nAU3g5YZdtivu5tVDa/BvLAfTnQs18Df7t0=
X-Google-Smtp-Source: AGHT+IG576/U8Nsrj9NDxqv6OcwgtRl12LDQRSuejeo9IoIEtiLibTVYovYgtB1NDnO33x90siH+sQ==
X-Received: by 2002:a17:903:2782:b0:223:f408:c3f7 with SMTP id d9443c01a7336-22428895af7mr174002205ad.16.1741613256141;
        Mon, 10 Mar 2025 06:27:36 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.7.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a811c2sm77313955ad.126.2025.03.10.06.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:27:35 -0700 (PDT)
Message-ID: <67cee8c7.170a0220.10ffbd.94cf@mx.google.com>
Date: Mon, 10 Mar 2025 06:27:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5144153272000274509=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kernel.org@pileofstuff.org
Subject: RE: [BlueZ] Fix typo: s/registery/registry/
In-Reply-To: <20250310105218.4127627-1-kernel.org@pileofstuff.org>
References: <20250310105218.4127627-1-kernel.org@pileofstuff.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5144153272000274509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=942218

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.40 seconds
BluezMake                     PASS      1505.62 seconds
MakeCheck                     PASS      13.24 seconds
MakeDistcheck                 PASS      158.43 seconds
CheckValgrind                 PASS      214.21 seconds
CheckSmatch                   PASS      284.85 seconds
bluezmakeextell               PASS      98.04 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      864.31 seconds

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


--===============5144153272000274509==--
