Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EAA244670
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919662; cv=none; b=RA0SWD4EcjM5nGKFfL61ANteF/I0ZaysDXXM93qQhfsLXfeNwEUEwslBoj0lp1p396GSzHGTouR9vaeyeGItEDBSAdxpu+IGGbhJt9haSlE1Pw74bp3L6mMiZfAZjSC9YTcDMrXbRS1aoKESQZBIrwlV9/EJOBwWBNeDo3XqRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919662; c=relaxed/simple;
	bh=DPNbG/hraJvQjl1AvsI49vaQETET9v+UHfZvTAfE0LQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=W3fuVmE0gJbRmk527mfcxQN0uUj8JK6wi32RtUAuRGvfzVPCbqB6k0qeaLQ/X0mkSByzj6wZOccj3+8+gkzL1oJsS6oEk5TAElSP4GrQFwOgbQi7JYDCuCZXlhT7cwLmhJTm503sJud8nFtldWp3eQbhPuxy9tmAmbRG4Onr/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoP3b3gf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoP3b3gf"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7841da939deso6756426b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Oct 2025 03:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759919660; x=1760524460; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qqf9swFePvOQR9D0KTEPjTrVUCcBV+E7Uerwx0FiyeY=;
        b=AoP3b3gfZnr773uDVklIIDosDw2xd+yke0abycYsINneXJyWjpB3+67BVmz5hrMJ/6
         niZgfqoXGgYt3vSzBkn71r9jYhWEzwLbVq1j+qxZWl5dUCNtJwRGcKNyLSJ17zdi9cN+
         mkPo7JGXPsX63mJyFZoiJS7dcuT140qELm76XJEXlvZLWY/TW+QCdxkF2kOKdYTuLOTg
         mXMVoekZNtJypQLfsDAGsA0Y/NTPJQxNBHEH5mXehOOXKlCQEkzFHOilm6CHIUCG4Ypb
         HHGlVx+3qbDtOViY8di3gzIN4k6p3wH65E+H904DuNryVec7XCCSWXe8+S+424ePHnT4
         JOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759919660; x=1760524460;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqf9swFePvOQR9D0KTEPjTrVUCcBV+E7Uerwx0FiyeY=;
        b=VRm5eXRz+Y3EppUB5mNF/+F2o3lu2ux1Y5zGeYfQA7+zkIxhi8DMxNvP+QFxtVSVMH
         ds6sufd2OBpVk8M0ONyxmhHYp4muAS8Dg4j67kJtzwUM5Rko80NquEBjNmCXxC9nVycw
         n+8Dt6efNsU7m34TZXI1oA3LRxDlQTldPjs1YvDl20I1Ds07rDry93yhvD5O7xHD7f3H
         XgsSR7GFRJ/mtdR0TC92UMDzr2ffJ76XMk2d13b1h2JCQfqWZ345xCa609SJ49v9xCe8
         39FT5kVn/CdkV/VEULvN7zSGgHw2AGlLr+zmcuZmeCcHjzUZGfYkSH6Dri0zJUZR/T+X
         3/LQ==
X-Gm-Message-State: AOJu0YytkL42UxRMcU7MOpMKRDmLDWr/F5VfkQLMST6/PfCILlKNcGlR
	euwX8jQYF5V+JmnKxCArgTqwIU5TRg3FUI1xF51sdYkSLxrnwfzPQTXYdLxI4A==
X-Gm-Gg: ASbGncs7TOVo4YegKHl3x+GP9aAYuvCnM8bSG0LpBznM4bkHj83ukI2ut/JyXi3BY1Y
	S3gi5Gve7ieH50pDLb3i+gkU05Pl3mCQ34czk3P/pVv/7VeU9IDhAjynFQbKSQmkJsVtCrMRD1Z
	PIHfX3LBLC1yNBsktmmx5pYKoT7CCCcsrggzvFDse/FRXiENFn+P3flE12vNnLz+QskLdJtSZ78
	S2WnQ2wCaSDD/UED8B93OgcPYKUhFgpIG5UzBVapeMXQbYDZtYCyOmyXrhLHcGjCcQDuQR3ffEo
	ORmVx6F3hdN1FddTp9UaRh/pOJ2Oex2MDmmyA0jhUyhtdjjvAr0/g1AG1zYtnmYAMUdx5FuZuKx
	8IcseUBxDjX5cI8dHKj4JIhbF2VQ0fBmA3OfUL39WbiWfniG5RsjO
X-Google-Smtp-Source: AGHT+IEaAczkecv1+tyI1OOKmEgjfRueA+q2M55IR8fZIQVvN32ePYmwspMPu0YAod9BNQBJoC451Q==
X-Received: by 2002:a05:6a00:391a:b0:782:ec0f:d273 with SMTP id d2e1a72fcca58-79385326060mr3608910b3a.1.1759919659633;
        Wed, 08 Oct 2025 03:34:19 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.59.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02053b84sm18395422b3a.53.2025.10.08.03.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 03:34:19 -0700 (PDT)
Message-ID: <68e63e2b.050a0220.1fc712.d98f@mx.google.com>
Date: Wed, 08 Oct 2025 03:34:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3468980643243457834=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: build: Add meson build system
In-Reply-To: <20251008085034.2178394-2-hadess@hadess.net>
References: <20251008085034.2178394-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3468980643243457834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1009311

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      20.38 seconds
BluezMake                     PASS      2817.42 seconds
MakeCheck                     PASS      20.71 seconds
MakeDistcheck                 PASS      188.96 seconds
CheckValgrind                 PASS      241.60 seconds
CheckSmatch                   PASS      313.19 seconds
bluezmakeextell               PASS      132.31 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      948.15 seconds

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


--===============3468980643243457834==--
