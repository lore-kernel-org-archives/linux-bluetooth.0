Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71DF312819
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583041; cv=none; b=XkokkBing8FqXtDM4li45mXQGCTGC+uEbF+thWDXwEMl9L4F3PBCGHz4e8/hx17BVfUQgrrKU733unwhgDrBKmCe7tXMHYyxx4UMEGCxlS4J3usjBKyNnA6244EAqWUqF9C/LbJcjDTJbEk5VSLlCu0xt45B2srsft4sVkRl05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583041; c=relaxed/simple;
	bh=XD5zdWCimRF1eElOJsjW9FzNVerXV3M8nHDK+zEQ76k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qgQDO7I0GWHyFputxhabd4z2mhimkw6RbW5rkvLGxO+xDhuv2NVvSscAmON2txG5vOGKPKI+V4x55hLEs/OY5MLZJ0MUKod1jeHDdDosFCRShNl7j4Y0UEqcobugVE3eONxmTbMfZd7xwtwH+IttgLtvN9n/qTuPZtPMm6ziqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXyvC7HI; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXyvC7HI"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso3684695a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761583039; x=1762187839; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KAeEiU67078Pvrt448f95j+D8/UVwRYVJ+KgltBIlUA=;
        b=hXyvC7HI6qFgN1OQ0nEQ0SUTal9uXcxQMRvXCGRUY/9D0I2aNQz2JneYpwTLPfhXVm
         RepW70KesyntsvbYnJzjs9PdJ5yAAFGyNyfUA7Tnqx2WdXb9k68Bbx9WpFfi0SOQGrdV
         IISGvzsXnt2rcm92KxElUY+ZdpxR0kt2sUoWI/wZ1N2UnGcz4XdK7/F7xGGgle6BwIcd
         2AZ8jQmlx5AYtyM/6DElQCknEJ/FZvj8bAIEwQQhyzG+H9ciRR5CXhzO3u9FFFFeDFoJ
         QOGCtKHL9M44Qc1hx+ag3X2jxHLGWsMn6bPGkeRuUvv0J5g2Jo2TUA+TL+eBPjZgei1T
         sPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583039; x=1762187839;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAeEiU67078Pvrt448f95j+D8/UVwRYVJ+KgltBIlUA=;
        b=jcOGZSy1UlWniCDIA6sE/vCqEVAB7feBgci5WDOB6HtFAz6bFjmwq+tTFDaIGCDWCY
         syg/bVozXDf/FD8bbyftYOL8TRAbPCubjoXVY84SqBCRKS9fM1Y22bOB9nsqlDOotXIB
         sF1a5Fr700lLmNgeVtr6DGOPsAMfyP0OeIfD/bX9v5CRZCjLxtMUC5J5i2T2M2EXkSX7
         RflSA1RkQjw4A2POAnXhOO82FUYgaJUpbnmn1asU+f+xFAaq4leufZyUAvY0IwuV0uEo
         B6fGtzFHk7fXf29dtYE+u4v4SN0tqjyOf13V2S+BI/YVlGxOUAPdEbnBWWNIOCJGknjR
         L2PQ==
X-Gm-Message-State: AOJu0YyMYeIJBwm8MDMFK60PNYCyOwgHvq5kTCa/7JX7EPHFbsUoXN0x
	JY3ec1LZZCPepH8F7Qr9xSVsVk9cC31hJeSiYa4Hu/i13hzTZRnosluAIBRh5Q==
X-Gm-Gg: ASbGnctoUsNNw/pCdrAJPpfbGnRnMFK90ZgTp44vAtLdLLJMH9eaw8MiDXvN0U/HsyJ
	/JBmZ+aelyGTf1+ZyuQQ9H2zfmX8pyyP35GReeGbtGKJsgxH8ZbnInjfeLW38zSEJOMg+0flOWJ
	QHZ0v+jN60WzEsclA021HyY+IGGZMQ869ZTYv+ZMEpkySIijdOGlR0Ndy2fDyiUu6XTLR4C3A8l
	yVUSHmMNQ55+3SQ70y3m04l6l8+LkGzouVKSXhpSUnSjYGKPb9zXzp+aPJw7bi3/LXWwSPJazmB
	oBeer69aGHDRxueYQ7MS11Bx4zhE9YDQs+4pE/axwhkOvrTY2JaZICJerf6VdJ8bbKwBLmmE9oQ
	TqXsx1JqjKneG3r1Mv/IszOYDcHUxITK5DDgrq7FCLyoAx6sfYIAqMGWlOrqjTR8G8jN7I2Ma5r
	a36T3C7Ny+L9ALSGHTRw==
X-Google-Smtp-Source: AGHT+IE/pGUxGFZ5JUW4IPTvKKxyCq/Duf64/ahvPs01Oj1frsSxLG9u+h8E+ZneDxzNECqK4MMdsQ==
X-Received: by 2002:a17:902:cec2:b0:290:ac36:2ece with SMTP id d9443c01a7336-294cb3c8f9amr6809015ad.18.1761583038540;
        Mon, 27 Oct 2025 09:37:18 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.140.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4b0csm86074575ad.10.2025.10.27.09.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:37:18 -0700 (PDT)
Message-ID: <68ff9fbe.170a0220.2d971e.b3a3@mx.google.com>
Date: Mon, 27 Oct 2025 09:37:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2414478129845938626=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v2] battery: improve the display of the charge level
In-Reply-To: <20251027151108.106713-1-r.smirnov@omp.ru>
References: <20251027151108.106713-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2414478129845938626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1016339

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      19.88 seconds
BluezMake                     PASS      2734.99 seconds
MakeCheck                     PASS      19.70 seconds
MakeDistcheck                 PASS      185.66 seconds
CheckValgrind                 PASS      237.78 seconds
CheckSmatch                   PASS      307.83 seconds
bluezmakeextell               PASS      128.50 seconds
IncrementalBuild              PENDING   0.40 seconds
ScanBuild                     PASS      916.66 seconds

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


--===============2414478129845938626==--
