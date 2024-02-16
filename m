Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EF43FC2
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044099; cv=none; b=FC97rWPvWNtDy/nsbpSxkVeQlJrRp6770dSGAJO+LgjUhf5UDXnrQUYHLDvl+jzY2uZbT2+ezvwGQg8zxylAXJOTJ9Cbu41emrJJwjUKUh0zkab2Hoatp3ZhJfhhYCWs3CGMBCgY+sxqpN2IXf8sp61bE/wcmGC7s0zkfh06Hzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044099; c=relaxed/simple;
	bh=9BlW/WKvupuxlq7xPkyaO2yvsKL1AWmgvgRwo+INBX8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Q/feQMoXZkrfG26Q4H7Qkr52RyF1NXRIFyAkD2NmrUn5OanL84hdmbf7lCjy2Dx3CRUTTYcJNJ3IeRq54aQYO6z0hrnE6zS7OrCDlSZ+wDQ84sTNIB+JAwVKFoouLDc4GLkaRdTvMtZBReBYNLMKwMWOyRyrUppX5ZmgbRQuvec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/HtCGcF; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/HtCGcF"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-296df89efd2so183210a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 16:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708044097; x=1708648897; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zGcaIooWd+t8wpUM6yMDtXoPOqcXFh/XS/FzoRz4b4I=;
        b=g/HtCGcFq0pehvpAW3ukmWUHDREHab/HQA4dJ9hDi+wviulLye2Eg2aZaLEfrRqj5X
         fc326r+ACQPJl6yYmMQm4JGIEbov+lKrD/pd38kpief4GKiblKPqivUYp6eJzg4bdDM/
         eLCoHWroy1Bw9sew/ElkGprDI1nrEP3+X1WC3Q2yso/ZzE7tFNXmtdzlD6ArR4rhFOEy
         ZJbsGhh3NwEIIVB4QqYHB79l4p0e20msm0PpSRPUHu0movWWJxGFFYPpe97rm/FFFjtE
         kvV7zjn3j9xLLI7fmumHUe5hjDHMnGC3UAyQcKLEzNpzsBwKg6TlCAw57f+inqbjnwfx
         M4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708044097; x=1708648897;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGcaIooWd+t8wpUM6yMDtXoPOqcXFh/XS/FzoRz4b4I=;
        b=Aa0ib8KAShCu/woSAhVVHCW/zHrQrSTLGAd2OAeZ+6gQL1t5mq4mBFRkbF0RybHzjW
         By+rspCW0QzvPxn4bCNeOciscYuta2WG8nRQxLlNxWX2q3p1SkZhRcPX1tLb2aB/oVqp
         mgqmSoh1jBImNtxabB/t4yKb4ZHpCAlB/QyMSZmkjpMxR13YryAuRYhslKCxxhncHmX3
         vKNa6isha53sdldQvP1uizUgftscT4GkTtLmPNGriyikQmLIUPYxWmcSU8ismzoCunSK
         qSFVgV4p85CFtfI3NZ835e9VEqudFBUd9wN7aB8CYdbizqO3B535LtJlVghVFhlZcCrm
         JeMw==
X-Gm-Message-State: AOJu0YxnGRvFCiN41LuZfsGfwF5XemcolaV68EijIC38GzD4oC49ZNbE
	7CVAIsH015YwW7T5F7VI9zygHvqROEi3oKgdjt9i1wNkun+vZUj67TV51+IR
X-Google-Smtp-Source: AGHT+IF9xrqZkbNSgnqzcaAzJ6sPm6yr11xCn3V9zeKVdHNxSlxGIIM54pZaaLo2lsVjLuw6qnne/g==
X-Received: by 2002:a17:90a:ec17:b0:299:174d:94d3 with SMTP id l23-20020a17090aec1700b00299174d94d3mr2416126pjy.28.1708044097336;
        Thu, 15 Feb 2024 16:41:37 -0800 (PST)
Received: from [172.17.0.2] ([52.238.25.56])
        by smtp.gmail.com with ESMTPSA id pd12-20020a17090b1dcc00b0029696f7f443sm4129412pjb.50.2024.02.15.16.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 16:41:37 -0800 (PST)
Message-ID: <65ceaf41.170a0220.9d896.fb97@mx.google.com>
Date: Thu, 15 Feb 2024 16:41:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4092176367705703639=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tjernlund@tjernlund.se
Subject: RE: [1/4] Replace @exec_prefix@ with @libexecdir@ in .service files.
In-Reply-To: <20240215225249.16242-1-Joakim.Tjernlund@infinera.com>
References: <20240215225249.16242-1-Joakim.Tjernlund@infinera.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4092176367705703639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826608

---Test result---

Test Summary:
CheckPatch                    PASS      0.93 seconds
GitLint                       FAIL      1.02 seconds
BuildEll                      PASS      24.14 seconds
BluezMake                     PASS      731.18 seconds
MakeCheck                     PASS      11.45 seconds
MakeDistcheck                 PASS      163.57 seconds
CheckValgrind                 PASS      227.16 seconds
CheckSmatch                   PASS      332.01 seconds
bluezmakeextell               PASS      107.61 seconds
IncrementalBuild              PASS      2701.27 seconds
ScanBuild                     PASS      970.94 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/4] Replace @exec_prefix@ with @libexecdir@ in .service files.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[1/4] Replace @exec_prefix@ with @libexecdir@ in .service files."


---
Regards,
Linux Bluetooth


--===============4092176367705703639==--
