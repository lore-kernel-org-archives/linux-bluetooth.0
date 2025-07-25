Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8AF3BBF2
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461601; cv=none; b=exIiV9v6Oorc2wQ36iw1aCHv4gkWStt9LAESYlb5r8AP1DP21KTFdn6Km7Lj1awqO9sw5GeqZWF4SEuesQwWCcFSpjCaQQ+OQzIos5MwF5LJOiWQXsPujPTlCAx+KhuaiVZ6iyaFTv3pHockVSEoHvIcbfsayF0OlqBxsAgAkPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461601; c=relaxed/simple;
	bh=NKu2fU4vpUus/JleYn4W1nixiJT3e8FQ3/Z1zKNr0yQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a1rhYUw9sIcXK6XB78g/XQJTB2YEQTtkyTJzn2sGytnRxoWHqWm/YRDLW4t+Z+fBIxykVz4aW/yRagIg3xCiJrb+v3oFSmfR+MpKPWVXWuqLRST8QV8To5uxbEUOoS9kkbrwh1qRMd6wDw5FSjc4S7ENvRQP28M33QzFRDFFVGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jv+RpxI+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv+RpxI+"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23dea2e01e4so30434645ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753461598; x=1754066398; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GxZjhOdVcooMk/2EFjLMeBvkH656bfd6qe33yqZn+Bk=;
        b=Jv+RpxI+uCRGn+07ZO6UCHfyXpqh6XltwJL8v9GQRHu8jfIshBz1C4FLL8fBzY+1ME
         oCMXAmstabmTpfkHLVPqrNG+Q4stJ0Il0qEBBm9xX9/zDY7lmU5P34MSg7ZfuCjSuhM1
         cnAAvQEc8QbbO6ELpTsqrMSYQQG99ShFusLswLqHK164/DvxNuz5JXe0bEnUitZQp164
         yLy9dKqAIZ88qM2xTPEujbvj1PsNZTbWXsbPgPwuIsRiYlYWeohigHAk3ZivV4dcK5xf
         uxNKj8l1djfsthCdGkBAwfXkN7L4mScCjtBoPqcy+Hq9Z5k+X2MKhFgIOZr1+HuKdx2l
         cIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753461598; x=1754066398;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxZjhOdVcooMk/2EFjLMeBvkH656bfd6qe33yqZn+Bk=;
        b=UmSqdzb98ayZvJy0gVhBLSnQLlDPgvhx21T0qANciiuA27ZJh3W/+zGVOwz851LlIs
         Phsy2kiV2HOQOdJnC3P9BILvjy8LMSOcvBgCKCHYTqvXLJcYHR2mfi8R0Wbv/c6irr02
         17aOz8DO8Z8MJg3usLn9KgO+8kNCFYXA1rL7/iZ6OXN09cppaVN7XNsBkDHSMmGndrbD
         P82VZq1ukdUmi9P9PVUd/jKGOTL2XE7RX8091FrM4shiYjsj5mQqTpSSJYCiAxe2y+av
         5h9YYGkr2L24vj4sAmCIhabJG5O7Q5Ic5GyXqbTUZwAN0nc/MUIYRrgioM+E4kIoo4Vn
         PnJg==
X-Gm-Message-State: AOJu0Yxq17XZexFk0c+Q/vnCPuIXhNEA7CfIHS7DGhS86AODg6iEaqya
	FmdQCwj2qkFcgvpLqB5CO1m+Z2gueghXK0IXF0D1AN7eT6NDqlO0WHeyuuPGRQ==
X-Gm-Gg: ASbGnctgKxIYw7xHNgOwZP5JjNRg+d54xV9QyV8UPoPgcTH85yM5frowwcH1G5IHWiY
	Cpiv2jhcRiNXzkGWDeOXXjFaLCaGXFFJFNmkzJClwgv0AeolVIDFzHAZ4jEDEqHRQ/yEEBJPXBJ
	+NPgfsllRL6JxfVH7N1J4R2Hbf4g7essR/GP4l/pjcc8wtvk7dgcGWe8VbMfaQdjxtYG1aJdLCp
	0ahIER03mti1gixgTkGSknrdFqOQcgCxx2zq3ljsvubWkDFf8cEZw8FYOQIlzInmDUQkyeZbAzT
	BW10+MvNCk0ycxVFJX+15VvjNnYSEoPChyWutQCWtDaNvG0Ir6TjVZ71PQrr79F7+O4vXtq1Fx/
	1NVbEPQtsq9F6zWNRXJJweX6bSR6rxw0=
X-Google-Smtp-Source: AGHT+IHH0RIHpUPlLI0izaXUaBzio9MrZDYrNZ3FyRNMrcUD5mLJXs/Uu93LKyeBR7R/usuSiWnrEA==
X-Received: by 2002:a17:902:f690:b0:234:d679:72e9 with SMTP id d9443c01a7336-23fb2ffcf90mr42224325ad.12.1753461598363;
        Fri, 25 Jul 2025 09:39:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.225.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe343829sm1161205ad.75.2025.07.25.09.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:39:57 -0700 (PDT)
Message-ID: <6883b35d.170a0220.1ecd83.1f4e@mx.google.com>
Date: Fri, 25 Jul 2025 09:39:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2784315457707214753=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zenmchen@gmail.com
Subject: RE: Bluetooth: btusb: Add USB ID 2001:332a for D-Link AX9U rev. A1
In-Reply-To: <20250725161432.5401-1-zenmchen@gmail.com>
References: <20250725161432.5401-1-zenmchen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2784315457707214753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=985995

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.00 seconds
CheckAllWarning               PASS      26.86 seconds
CheckSparse                   PASS      30.06 seconds
BuildKernel32                 PASS      24.19 seconds
TestRunnerSetup               PASS      476.38 seconds
TestRunner_l2cap-tester       PASS      24.96 seconds
TestRunner_iso-tester         PASS      37.58 seconds
TestRunner_bnep-tester        PASS      5.89 seconds
TestRunner_mgmt-tester        PASS      128.23 seconds
TestRunner_rfcomm-tester      PASS      9.26 seconds
TestRunner_sco-tester         PASS      14.69 seconds
TestRunner_ioctl-tester       PASS      9.92 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.25 seconds
IncrementalBuild              PENDING   0.78 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.106 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2784315457707214753==--
