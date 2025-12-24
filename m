Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D332D43B
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766561960; cv=none; b=PNOD/Pas25Z6ENKKookbAsHzeQirE5f0LMUSskF6O/KYK13iQ1uiBP/Z5JhdXHc4LZtEpJVL0xV+gIFh4Vm6WzQRmwXzWLVUm4eoP4Y3z9dUOmDSP05RbrtXYjTVU70GUA32vguEkPBM0qj0OzVgWEadzjxbinYXq6qYLJc5TCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766561960; c=relaxed/simple;
	bh=eW48Y86dlaidhbDzeFzdSoIoJQYtUB6iF4QN6ooE8DQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=r1T8+TVRfnZc1L0wDnA7ECGmeJEZKVSZkjOC2+lES0/N7iEiheHztqk9R/GtImSVUbkVxtf3RYZ0H29JWsd2BATawPmmNTz1QjG2mfktBRFu+zY55I5gx0mMUpOd2xonqwcVinl67GfD+YT7ljBaDxDPL9k4VBPVY8k8ZLoIPmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4epurnK; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4epurnK"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-4ee13dc0c52so46578801cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 23:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766561957; x=1767166757; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=knZ0M/if/QRhC13fkoA2kbT28zfYW1S0l1hyU1skYSw=;
        b=L4epurnKDdiLVtKgc6hYXJV9iMN3eEUcLJDjpJmwmBsYKl/wbFQkvi/ZU9F42BtoeG
         FFnTeBBq6/Ld8XykG1N4wpozB2CK4RY5F5xqMI+Of48mO8d1lJpOaXdqwCLBTesylwqN
         IQlEvge1ANzbJvCrXEqHGXldsk99OpC+j+cn8Iyi5yRF+nK6Tzdv3B1jeZyu6ud4xi3I
         8FbaD143YrPVm3YAG3oAf+l8SPqePY3Z5XXwvKaWV9NO3xoQnv+363R9rNr+4Fna47GY
         N3JFDgpUgJyGi9JSdKTtrFFfl5tOvopRNc++NCOdQUou8PAzPF2XmmWeZM7pIenVnvox
         wsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766561957; x=1767166757;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knZ0M/if/QRhC13fkoA2kbT28zfYW1S0l1hyU1skYSw=;
        b=Z47k9NeUgsIPU3Ehzy9ep9/z+VP07+XBisxeldEdf97XfC/aC+jLO8U1+MWFSuGjIB
         CNMqOmIbTsMh//pybeaw3rmrOaZyedqnAb/BEYsQ5Hh2GsxliMHXMamIqPZTU9+Xv0su
         FOt8SizECddV6w/ppJisK0m/pEf6nI6fiWZ94WQ2MWRXYvX+FATSryb4i7wGVNnGISf7
         7qJd77orn4+yugDsWKoP46wP3ItTuRjVU5wG+Pyk8I74EWEz6ukHcSQW9Jswb5VMPYxM
         NjkKh3lURv145N2Zz7wXX+SbzJElDK+6hxtPmhV1kLm+8mdL/I+kXzdq9TbzDkAK1GjH
         RPvA==
X-Gm-Message-State: AOJu0YxZZ7Uu6NdIhS/OX3add4ISphZpm005W/aEc6jlAcZqCL+RGgi6
	mK7K2gzqEwHbTptuUX+njmbG4nKsNVjCnfacLnexxsJ896yhdnKd0k7g0ekclWx/
X-Gm-Gg: AY/fxX7L0dwjbfzbBzwYxwN/Y/wIn2kIw/VyB1X8mswrcjwb5+18uc62rtJUC+Tgy4z
	lj92Wa1mdU6gelUbQbnKvuzs4WqSQxzghycso3gCgXQnC9uRF8ZJxm60y7kbYSwkR2cHT1zytf5
	TsHnuQnQFJ7rfGtilXOw+m1vExmPFop8ekBrUHxwcPQanf8W1lPA48db4mkOpV9S4QyF5NMzhzH
	iDB8kkSH+WD/3tBfiH+xh0zrtAPqgntsnzRCqxcJmv7SMmK/xAnLNRGzV0XOiGKqpGeh0gmxQ/7
	5pWq6JF7OZhDuK4IoFaA6Rzij2WWzxOgILL1Odju6DquTqWHEw9NQAVIa0TvraKui1dmUZnr+My
	HmmIz1jZUhBt4BMm//wI2TVEVz+2RHxi12yAf402e+y1K5/9oD3Swa3qcN0GMj5v799EToEwYYJ
	NbpaCmQh/rUwAJJQ/JI/kKgTrtlQ==
X-Google-Smtp-Source: AGHT+IHe+xX3LNIrw8yUFENK0W/1CNHTqdKfv8k+kWEEyac9vW2TWM3GPUqOgxfOzT8NMKYdVjjUhA==
X-Received: by 2002:a05:622a:1146:b0:4ee:3e74:43d8 with SMTP id d75a77b69052e-4f4abd752b8mr277270761cf.38.1766561957445;
        Tue, 23 Dec 2025 23:39:17 -0800 (PST)
Received: from [172.17.0.2] ([68.154.37.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4b6760a43sm100370631cf.22.2025.12.23.23.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 23:39:16 -0800 (PST)
Message-ID: <694b98a4.050a0220.1e7620.273f@mx.google.com>
Date: Tue, 23 Dec 2025 23:39:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0441183340331878322=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mahesh.talewad@nxp.com
Subject: RE: Support for Enhanced Accept Sync Connection Request command in BlueZ emulator
In-Reply-To: <20251224063439.2477969-2-mahesh.talewad@nxp.com>
References: <20251224063439.2477969-2-mahesh.talewad@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0441183340331878322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1036285

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.01 seconds
BluezMake                     PASS      637.42 seconds
MakeCheck                     PASS      21.73 seconds
MakeDistcheck                 PASS      241.63 seconds
CheckValgrind                 PASS      301.27 seconds
CheckSmatch                   WARNING   350.75 seconds
bluezmakeextell               PASS      182.10 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      1014.04 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:470:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0441183340331878322==--
