Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83E1B4141
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514144; cv=none; b=ChwArElv2I7Vi88BrK3ndWBmnAT+vBMD0y/2Qq2ZqOpxUdvBn7CeU2JG1D0XwLF18KiKHxh/Xaq6ZZnmyeXXVr9cdfECsgHkyMrpHJ9DnjUUwLj5GLNs9mZE636M4N9FMfgvHHme4EFyfzxpdKcenWF3m4kSFtCR2U8vYJpKGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514144; c=relaxed/simple;
	bh=ickRWdXEaUAYd8Uot4yRhU4w2Z0djkNBd6+80p3vyuQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ODG8zWKtviK3UrqDM3qRIFcljgbdc0iCiR0NDVJgRvEqmlRpqNDXMdqrQ5od4cuKI/+XYlv+kHkIRU8bwhP7bgKs3GoXyHASY4PwdLUu3e5ctZSDjzQGBZP/B5QHMHPKAwCCzzCsVBBSsTqRi6KASZj3pacHidoQF4C5VkvxrsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdYOgbI4; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdYOgbI4"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c2504fa876so309266fac.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745514142; x=1746118942; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aLn05QzNwJ+spw6XJ1vqYwlFcc+wFOzuEzpFmOzj9ts=;
        b=hdYOgbI45yWhjiXKicTpQvGl2PoUgLIPeWE5GYdSoITuBqAxZmASM/T4ZNiULjuOKK
         8UPX8fkpitWNouun0gy4L6QBRpa8umuW3kT0I6G1ZpAUFUiziIqTSQGo2uzp1XJTVkcS
         NFiE3UUCjbreDLAh68ADGCTHEc09E7ZZUjmdGIM0Mn/Gr04cnFa3AP9+oK359KTTqpgy
         EMQKc4qfcuQOT+G3h/rSSqlRP5E7XeI8fPz93gqde5JaS/GBMIb1QG6M4eVNO9xriLiM
         124IJuWuIepaDYqOS1CdHRlhGfzbS7DVouHLMXV3fwtfSRkmF4nZUKok23wcpmDWnsPP
         jlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514142; x=1746118942;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLn05QzNwJ+spw6XJ1vqYwlFcc+wFOzuEzpFmOzj9ts=;
        b=LKGp55RtJGIdJuJwym8XlUqs081sbpm2EKh1Dtok20etckYXH7gprl2xARDYTV7IR2
         WvgFUSsGx6xtMD5LzZyC9hcwezNNR8opQJI/AZLYZ2pc2lBd6bw4KGlD+bIQytdZ2zCg
         QRNsExRw758j4z5nwL1uE0o0N/taLf711IJ6gA+C/MPWZVCGZqUAkEA60Nsbr3HP6o7i
         nFC80umgPpsppxfYlqA1ahwUtKucrwWJi1d6ej2qgtFZBGifl+3fqlNTvAYAqw3TLVZf
         8tkRicbZLzlMPbocgDqMjCD3OQDWDcgmbjeGVux8+++ZuQhIcKKLUyXRViv966W/00Jg
         6DYA==
X-Gm-Message-State: AOJu0Yzo8xAXKjMwX9Z6JC3rBbYUSqFvTUCAB3ojfTxsi37GV6SsCC1E
	UbI00dHwRRF36aebmoV5MVFQ2NjZSEE5GWuchDCbAtvxrdRSz/1aVoiZ2Q==
X-Gm-Gg: ASbGncvp7OT83toHX/0mJ7bzWBg5PwDMvTaftQRPIn0lTwvAUdl9hl6wiWuZdvqlTwO
	uZb8eGu/8v0QhrwV5yygmiBO6joC/sekEzcNAzH8ygyWhiD235dtmowF38vAgylQgIBeyo6pLj1
	e8uSqjcKSvMvn8NepELaLp87P9j9nLhZAjVHWpYfi92pNErFANoh460Oj3F851lOfyzWFto1aYz
	UPy8q4pSrC8b9iifDIIt8syiX+cAMULsMQnWluDCKTjiQDrYgVCmVgAukQUZCZkAqy9DyQQUsUb
	0/FV0WSLkqDA2GOJ7V2X3IMqEZ5OZnbQm49nj8/a2VbVAGs=
X-Google-Smtp-Source: AGHT+IEkzYpa3n9uUNNbsS54E9x+HhtnTxt51K+YpYt1SlpWBzjwHCq2QDIYMhXHOXVxjNZrUjl9FA==
X-Received: by 2002:a05:6871:582b:b0:2d6:6677:f311 with SMTP id 586e51a60fabf-2d99415fdffmr370039fac.3.1745514141723;
        Thu, 24 Apr 2025 10:02:21 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.188.230])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d9736508casm375198fac.5.2025.04.24.10.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:02:21 -0700 (PDT)
Message-ID: <680a6e9d.050a0220.380332.3df7@mx.google.com>
Date: Thu, 24 Apr 2025 10:02:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4160466891133781315=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez] bass: remove the device of BIS source when modify operation.
In-Reply-To: <20250416-bass_modify-v1-1-6f4a85c2c7e4@amlogic.com>
References: <20250416-bass_modify-v1-1-6f4a85c2c7e4@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4160466891133781315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=953925

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.55 seconds
BluezMake                     PASS      2706.46 seconds
MakeCheck                     PASS      20.40 seconds
MakeDistcheck                 PASS      201.34 seconds
CheckValgrind                 PASS      279.30 seconds
CheckSmatch                   PASS      305.80 seconds
bluezmakeextell               PASS      130.10 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      923.39 seconds

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


--===============4160466891133781315==--
