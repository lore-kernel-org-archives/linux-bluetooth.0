Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969B72D0C79
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005926; cv=none; b=ktcV5QzKfGO6+V8K2NRo/eNZ/ZiZc8Cx5cdboO6n6lhIksXuGUqfs7sI8WQ4wIzlQNBlK9pNTjVOk4wcGmr7UI2FIwzog5i6eLBjnimnC3zvjLOIW53tAKVaI8P75gmvY4K3pFAHqeVu/TsICRTfJemcfpOmtgZ0/b1l36rjWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005926; c=relaxed/simple;
	bh=ijQgoe6Og4DOwlinyI67jXLTZIzrxfLXhv26d1szp7g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=L78ny7nWPS5dyBE6Sez/Gwj3IlgWpy3mBd28k+gdt8RAXQGIYNP63Y32+a9sx5PWSIH1DVSJ5PE2DdQuSIojDYuph7JnNccWTHDVjwwDoDRFPU1Exymu/BwjYYmmlBYVLZVATSNFKTjlaIwfNcv2fAW7qsEUiky7/kWVZGDsZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vq3HigRd; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq3HigRd"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89a1d7cc7f0so16609356d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 04:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774005924; x=1774610724; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NxSAgPCzkkouLgWzqZW+LzlAswYwIm+K/ZkrR3nU7D4=;
        b=Vq3HigRdmLSg+ULK1KaMEBKM5CQYtvHLvc6WV0zUdptBKW/0gdoNo5RXsqeqYeK96H
         OJ37kee/8d2ltk/Bb3UCv846f7HvfVARBfJr5NPKu8Q8BaIT1TyY9q66ifpihG12hsIW
         yILbJn2CKPz2PNNao8vQIwLwtlTW8OhkejFZCuMdxgCykjxKHsdyYy198/s/DC1dMjjx
         Y2fq/M5BEGNQKCkFqPxbl4cZlNjat+Y9zvQoRotxW+bKmhasqHlLuLHJg9+Mccr3TSxQ
         li+piIqOdUcufuFyJUPsaxFTbTGRMnCZ3EoGAGqS59ey9vETlmXx0iLx2IjI0ckMlljP
         /uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774005924; x=1774610724;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxSAgPCzkkouLgWzqZW+LzlAswYwIm+K/ZkrR3nU7D4=;
        b=cI9bEPcCb/hvShkf6R0OjH10kBUvWh7wPgN3IrXjwaLDa3zp89q0q02rXQlrawqgvi
         DbKt6s6UhXxA92KRuJ6/jYMKNnwCyexyL2czONfkhaQ1kVBFGs3fUDCZZZmEYq0d107b
         RC1STlvi+r0n807tkFKVYKprTaVdI3bMyubIYOuwy9nOG68wdwiqYRq4L/gpHffAlMlJ
         F54PtlC1N/a+Dp4ISaWB/ExJ/Xp25aZjPcDNftcpDyHRRb4dp49uInoCX/P6oFCYU/4e
         MEw4kVv7TmAAwrSWhfJ3GxbqTr8qAs+X3FEiqRyXxThZFvBfd/2vEjo/GVpjfrBjpfvI
         f4aw==
X-Gm-Message-State: AOJu0YyOw7jwPHVWu57GmNcGev7yFst6heuDLIa2DsS2Dj7U64bdkFSc
	KDyE4yAS3CpyABgcyK3mxt3OnUup1ozpaiEtpR+hTJs3Gy/M/G4IIFEgCbEuSw==
X-Gm-Gg: ATEYQzz9wkL1RlMBYIfeD6n4wETec4xVsRPrmLVXj9i7A6axzdTQysntUCAJQ5xyI71
	zW2EV358YGmDo73cpsFLWvAaeFXHjRgZYso9fln1x7gEpkF36pESMpXZbgT3g9IWvMWRwGqQQCA
	EYssX8g7v5XAmYw+RhHE1XyT5GNCLwYuVDZW6z8CqppQU0RHGFv13QYDMsQ3+afb2tSojhuVnU3
	89oFvsVbqYOF1jKakfxRPJ18AQm8DYD2DsUAHuqF6hKlIzq6M+mrV28V4G+JytcT6pMUBcWPcnu
	n+N82KeVbs32an7/2L/4KuC9xFjYDz/k2iashVR/6MCxsvgA7tTMli4v8m/8TdbLQ5SewpovN2D
	GePMYocGSom3SJQVXtaHxndCOupKNiqnwixM2iU5mkY2OxBeA9WGbE28UdbH0bKyxfwOfM4Qjd4
	131xQT4SO0tPe81it+9f7R1QIT6BU=
X-Received: by 2002:a05:6214:328d:b0:899:ea9e:31c4 with SMTP id 6a1803df08f44-89c85ac828amr36796586d6.51.1774005924169;
        Fri, 20 Mar 2026 04:25:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.69.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c8525e195sm17633386d6.22.2026.03.20.04.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:25:23 -0700 (PDT)
Message-ID: <69bd2ea3.d40a0220.185537.e9a5@mx.google.com>
Date: Fri, 20 Mar 2026 04:25:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4590817555051851833=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
In-Reply-To: <ab0pBlGrvw_SHFwB@v4bel>
References: <ab0pBlGrvw_SHFwB@v4bel>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4590817555051851833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069844

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.71 seconds
CheckAllWarning               PASS      29.15 seconds
CheckSparse                   PASS      28.09 seconds
BuildKernel32                 PASS      25.78 seconds
TestRunnerSetup               PASS      573.72 seconds
TestRunner_l2cap-tester       PASS      27.99 seconds
TestRunner_iso-tester         FAIL      36.79 seconds
TestRunner_bnep-tester        PASS      6.48 seconds
TestRunner_mgmt-tester        FAIL      115.17 seconds
TestRunner_rfcomm-tester      PASS      9.64 seconds
TestRunner_sco-tester         FAIL      14.54 seconds
TestRunner_ioctl-tester       PASS      10.48 seconds
TestRunner_mesh-tester        FAIL      12.65 seconds
TestRunner_smp-tester         PASS      8.74 seconds
TestRunner_userchan-tester    PASS      6.88 seconds
IncrementalBuild              PENDING   0.46 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.758 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4590817555051851833==--
