Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC31922E7
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040261; cv=none; b=L7G2L6RvAZtAIN68tR4jh+Yy32u/ecO9TZebeSyA8/j0fYkjylLM5XPi7QTPwZNpNzfAID5RGP/Tl+39a0A8HUAP4bXz1WQbdWSsclTZRQwEJgifHYe8ZtR5DdyZ21raaMTLmh0eWYLbcauC1wRO6mSTKcMRWyleGKlaWcKvmDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040261; c=relaxed/simple;
	bh=vQcrkeN4eer6moOB5aNZYDiXHWfjkGjQEjGSaaoAfqs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nBI2SBgFiZyJ1xvpxgltvt+chGAo/rIdpZeDs/CO5wshWVCRPN1RaqaNbJ47Mj41dz6moUp8oZQfQRW6TsJbjaXM7F5QevGrZdRPF/vRE7GdPUUVWW0IWws38Im8zSRgSG6mbACV3f5CBc/hdGV6GQVr/sLaPdeHFHUHNSqowvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMqc7WWq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMqc7WWq"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22100006bc8so10148995ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 00:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740040259; x=1740645059; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TWfr/7PuSU1eKUnHQBOrT3lxvRMT6dzOAvHFPrwCFqo=;
        b=MMqc7WWq4FIjg/tR79uzTdZm9oaSkIs8kGZeSrf9RprhL5pZa3v8YJGxAjDPBSnUaA
         rBISuC5s3ROiqIy2n5dnRb1mE88bN8+XpDAF2spreOtXHp4qvpMgxxD8XcVkXaiY1YSo
         Jnr5DiU//j81A8QlhirvoNh5PD0jKWyC460ejvdTDvjWPDUOSvQCVtlOxgmN77JOLTZF
         5Adon3PNGX18i3M9+MEKw+wTjUegj+zAfwCbSXOenKX1voBaPT+WyhqRtOEnxLVXgUlk
         gNIbCNEpglH/DbS/fOCYftRaNOhNpvXYA/HJoQIzERCR85rR2uBHWL0/3cOfL+pGZJpQ
         C4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040259; x=1740645059;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWfr/7PuSU1eKUnHQBOrT3lxvRMT6dzOAvHFPrwCFqo=;
        b=KdfMFUVWxMC3aefcsgHruDjWzNpTTgLoiTk5N/b+4No3IszVwNm5yQBfcDGEoMuVVM
         QlRlhqCPE3mZTfd5mt4jgnwMH1il/YIHU0RKmL2HSd9p6GATEQ9S9IbzDaKlCqJ8Dnzl
         acr3pPiV87tnQFdtbQLkE4m1Qr1oHnYU3kUu6UFsMPryJkPNNzKYMbexxEcoLzTU+U3I
         1f15iWsuyIzkhY455h+TyJ+aUe+CAkv3Hoq/da+gO3wET+1FqEkID60Xyis1Is9ab4Ss
         wy1sOUy8gHXWRfpc+0QCmsi8511a1/9ndOiT9RMpudUbBYqyqAd12c1+OrY2lXy55ka9
         MIiw==
X-Gm-Message-State: AOJu0YyLWLueJer5WviKrmhokh1VYB+y24O0nZtJTqxLr5tw/OW6ImYl
	nfk4ij5ELrz64izVLaRZNhAfQYnS0+OOdlffqDU1TDFLCkGA4j1Rc/x6JQ==
X-Gm-Gg: ASbGncsBy/GHpmSIM9mK+McYPP/OiJBgPzd+fJ7JlZICvNDEPsQVc0PuVgNnpZjB/GR
	ZJVz9IhUqquXjAnudyKNWl1DCrRwTenbLfgYx30B5zqSPZHxcWYGZKhjPIfYVn6W7yZY3ri9/+Q
	mh7FFyrJY9VaNbzIelNSAtTbz4SBhTkdl4Jx3Z7NX8n3Jz8C78NQrU8AfZDc0UsvxEy1xE2czWf
	5VdinXF37X3KPP0XXKVG0IPa40ol2xEELg2sUiENMN+ctiNFVS/isnoYS8h704rb5EXpVRpCgQv
	UZhDTCAnyD/FP0b+GafpWg==
X-Google-Smtp-Source: AGHT+IH8t8OjOH2KhTldIp/8ZoBY4mXXXwiGXI4nMPp0pBTeAqGA9HABDd7anwGHhRjH7SPergjT0g==
X-Received: by 2002:a05:6a21:32a3:b0:1ee:c75c:beda with SMTP id adf61e73a8af0-1eec75cc2c3mr19511347637.35.1740040259077;
        Thu, 20 Feb 2025 00:30:59 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.166])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-add540f75f7sm9518125a12.46.2025.02.20.00.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:30:58 -0800 (PST)
Message-ID: <67b6e842.630a0220.80ad5.1633@mx.google.com>
Date: Thu, 20 Feb 2025 00:30:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8820025888401361615=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] tools/avtest: Add AAC configuration
In-Reply-To: <20250220072235.189814-1-frederic.danis@collabora.com>
References: <20250220072235.189814-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8820025888401361615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935871

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.55 seconds
BluezMake                     PASS      1544.66 seconds
MakeCheck                     PASS      12.93 seconds
MakeDistcheck                 PASS      158.77 seconds
CheckValgrind                 PASS      213.74 seconds
CheckSmatch                   PASS      287.60 seconds
bluezmakeextell               PASS      98.18 seconds
IncrementalBuild              PENDING   0.39 seconds
ScanBuild                     PASS      870.44 seconds

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


--===============8820025888401361615==--
