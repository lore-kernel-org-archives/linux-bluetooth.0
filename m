Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF36FBF
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755727247; cv=none; b=TSTtykQTSZ0qHJPpZ0ffXRnrnmCfZwr5JQM7vsIwOWqxPhC/SX6/v7CWv/qkjv1eHFPtEC0bpoLy0+8E4w8KuohtqNx/CToP3X+FApeFZi1g1uEv3mE4qNBlf7bW/zeWH1+sednhR0euvUg43L7KrwxwfeFfj+ezKTzyRWpvW7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755727247; c=relaxed/simple;
	bh=UHz1J7cGC++e1e6plyPq0jkzfJfLUvOrSkBqVJ8jwSM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MMYEBDrN2IBg7JzJlo6h9XS23uHL8maeNWXW/tduy01Xn3pefMCkalKR4/BJS5KB/MluIUbqKJ4eDNR0kVaG3K22GIGdeDBB69aFuwMdRh7nSPIuMyZs51QUYPOzCSjjfPsU4h8kCIjZfcSPiwBB1W4Br6yiBEAfcYqm5hRE15w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFiNwe0/; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFiNwe0/"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70bb007a821so5985666d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 15:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755727245; x=1756332045; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5eCPdXyOQN+8JjyvLZHHfrPIdXSwQ92gGiXEStoviFI=;
        b=fFiNwe0/gbMX6jbpuBI4t+D5z2mDFFdxnyaQctvuRm53eIOqQFNQR/XHD5F0xPxtIX
         4bqZ6RZaMbHRNdXYvkzP2eB1aamaFRlRAZo/rIwcuMmJw7jRxIh0QTlnVlviNmlPA+ol
         y3aoOuMve1dy0zwi/21pPiigArxe6P533AwLbTtw35PyV2CGHTA8FI1KQSJ97fFy55W1
         Pzhi8o0NZ1nMPGnjKDeL1Rh7SUYWCUEUEaa6SMP60nFxQ3v1z72/B1AxCdSRLo+p1hFJ
         vA5k5rvR71cijtZ3s17sxWz4695rgk16V3/4m8tn6ANjFuia+jGxbSHcahEHv2CpYm5z
         cgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755727245; x=1756332045;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eCPdXyOQN+8JjyvLZHHfrPIdXSwQ92gGiXEStoviFI=;
        b=gQP4fpm/yQtUYu50eRsZc6DyJLZAnOe1UEZvS1QZeoIVkOIvUqfEYzRou0tDZ0atnE
         FHUEyMeKNseIMcnyRcTiiz3v7c5FEDFLvGXO+SYHuLUg+x13UuPlGOmmyeVJC7Y+yOVr
         9VUM/o8Hx4x2vagdhC5kB5h0R51fHZ3NOB59T+PKQMzuxW0juDl28YxwDeGVdmkcv3/B
         tTNWPtgevVel7CItyl2PiW/dsLpWvlxJ6xFx5sWqGyVQrZVocnR54Jg+imPN9Pewx9Tu
         q0RSNcZO4VIqgF6qJNnIiE6FnHYXn3+8FtvEKuDCTKHN2od0WIG+UEwZaRRdFXgjyXbB
         0hyA==
X-Gm-Message-State: AOJu0YyBRLAnvz4Y8fNfzsv1MFsv+Mum58x3wnKwDmOw5MLVq6nrKznN
	Jhf56sgsdzhjTPJgdG/TBCubW+9xH3te0wmZsrCdHYi9Gqyfa4J4kLxgQuJJmA==
X-Gm-Gg: ASbGncsgh4m97ni5drJIfSBcbF7wJrS4E3r2OectEdSTFRfzm1DeKl4BRSZs0dTRAFA
	63TtpMbp0wqElvzU3Cw96ufSq/1FV40Q7DlB9PxFXSUiJifcicOnlSqq2wjueklt5rS5fWp5zLF
	o+gqfMCjaA/tikoeppF7PjU3C9/f8V5Ex5p3qY6DxFdj1zB15RG7luvZt04xZhy3zwzbJNs4eXn
	V6kZIb1ngr1dbF4YokovVUAbaEk/vHM8gZBrgjTw5EJ+7CZ2HM1edDVuAtkkDR5OEdC2v6UKNEf
	lKUyBNmrzg5uA1TnDUwEN5Li42hNytXs4HPznNV7TDuG7ZM7v+iGcmVMfRStBZ038vGBBn11jbB
	AoSMrVIEOzkKYk+cWtRSyi01EUmiSwA==
X-Google-Smtp-Source: AGHT+IH72miW5PWOgehHJZZbIauaXGp4FMwy3Z12p/bYtgdp3kE617bLq5sNrOam6q3Yt4mEN2YYwA==
X-Received: by 2002:ad4:5c88:0:b0:706:f753:6b14 with SMTP id 6a1803df08f44-70d88e3741emr2736726d6.4.1755727243636;
        Wed, 20 Aug 2025 15:00:43 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.235.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba902f4d7sm93981096d6.2.2025.08.20.15.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 15:00:43 -0700 (PDT)
Message-ID: <68a6458b.0c0a0220.266d65.cb3d@mx.google.com>
Date: Wed, 20 Aug 2025 15:00:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5142435533889959865=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor: Add support for -K/--kernel
In-Reply-To: <20250820204117.1905780-2-luiz.dentz@gmail.com>
References: <20250820204117.1905780-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5142435533889959865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=993679

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      2582.12 seconds
MakeCheck                     PASS      20.54 seconds
MakeDistcheck                 PASS      184.59 seconds
CheckValgrind                 PASS      235.83 seconds
CheckSmatch                   PASS      306.31 seconds
bluezmakeextell               PASS      128.33 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      911.89 seconds

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


--===============5142435533889959865==--
