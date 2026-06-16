Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EAE3D6CB2
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589378; cv=none; b=WMmEPj+GTTwg/o/YxqJZNQoB2xZLtjmg4hMqet6uv8dMzNdRlN7pg9RXgcWHdxrDZZuDWNfpM3Hh1vpIgifxWes8ztUIPOTz2DAu9tcE0rxRsctjzlLLSgxtmjuVIJlH5CuCUk3uTZbgTgsKRXtx42rPhV54jX/31YS5v6lvAmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589378; c=relaxed/simple;
	bh=wi0yH/CPCdQ7bCBgX+KgD1APYToouujQA0Hme4vo8QY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HrTKMFrF78eWejxLJ4LUm9cS36jtPYMHSh8a09Sh7SOECGrDIYfalDDWf8+E5G1jOSJi/joMqtoKdBFUw43rvKYvbZnxFPU99IslqHcTEjM8a2uScfdPLLmgJ5OtWRVvsapetwMrR8GztMZKcR9q9fefjBbI8KX/RndxYkfrgpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwIbVq38; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwIbVq38"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1390f75d8bbso5832585c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 22:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781589377; x=1782194177; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5DqBKiACD2HO/7GmSwZsgCTUxSJ6fNM7m+h5FCbsMwU=;
        b=nwIbVq38bV71kvNv1rF/LFRyZO/Y4p52O/vNU9cCusiLI/d6W1RR3BTv3i5eAyXn6g
         ItDWi1WqGM45ULocIE3wV046Biu0mHYocAV82IDV4MPE8+EzU10nOfAIxM2R/HuHBXhR
         YR+Cfd+nnZ51TfT3fJQbLm+NbKP1Zz0f8l5wDIFvjhLWDcB8FcZAA1fubaHmEmyBHGOE
         +97g2ATCPbkvVOfE1wfzZs6I82Z9uSirxc08ajBGRMgBlqE4IxU393H6CK1JIeGowrfY
         i7Y+Z3PiSOSPcgv/04+YDCBYJTzGlEKgHn9VuUaWQ3Bt77jXClLKQckLgnnwurESmxfY
         DWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781589377; x=1782194177;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DqBKiACD2HO/7GmSwZsgCTUxSJ6fNM7m+h5FCbsMwU=;
        b=iAuYIxqcsn2lmCphL0/eKyty1qZo2nwkqpkn186FPFzjNp2+qgN4vwcUl3MGHYYdGH
         3TtccN8BHWdkBYP5dvlxUhLfjdZlZ11DhsQnQ7+KQoP8C9wZAyBgzSOae8NiUPMGmMDa
         5Wfh+3ZB+icM2ZBU4/2lkV5hsniIgdHIGhjaljQrHibK3eG9tuouCm2v7j2tOtBbnrtS
         v0QUkxn7YTtPMdorLjQqNe9/r2zuJMdq9liYKsr4tPxm90qap2xYY+JPCMdnLHCxcsIW
         45jEZqNSGQ9pAeEW6/zB6AYC2u4fAarrUQsSb8kq/ySATMA/dDr10EE7nJwAJOELdh2v
         1lbA==
X-Gm-Message-State: AOJu0YxjeUc2xaPkU2GsUlCwEhsF46x0AHYKAIbR+dsgzOLkVDB1diQM
	WMsQGNQBdd1XMbm/wV+6IJF5luRPQMST2dH+RVBLTkLPf66UVb2iPXNHjYNE2g==
X-Gm-Gg: Acq92OGkaXlJfG9x5q9TW8S1VNuLk96dxTAgwzG2jP6geh/BzXF11BR7PcjnSwy20RO
	qkx9ti1TPuZflBmUlgm67twSqafe8gJAfnAMQI3Rc8CDcesFxGe4WMQwn0Ivn/lXRlXgSOHWCbI
	aNrRNmc1GzXYSJM8rEsXHJdSwHnJktn+iRAt+4tY3ln49AML2VzbjOl8QvTc/8g/gjwDup75nSj
	OlKDHIlePRC+yBvxLLDzwz/nr9AmJVjsuoqzauQtGgFIwicswE2RXxtKCit2Ii5WAf8aSoQ6xx8
	YXxmxGL1SzKAtV+EnqQFtEqer0uAgnyd+y/Ty/EodZdGvD1kseQMZhu5LrZzC9gooWHdd0XOLe1
	YXzWk7XQI4NSXoJR0rD16ru39yD4yvfrCdR1KYEFBe7AxXb7OG26wd8v/xcChhn/zJSVBMs04l5
	79+4KnkLFYQe7mxr3ztNHNHUo22Yx8qA==
X-Received: by 2002:a05:7022:1004:b0:130:9b78:b17b with SMTP id a92af1059eb24-1384bbe2057mr7786291c88.38.1781589376704;
        Mon, 15 Jun 2026 22:56:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.118.80])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b9815a6sm12848955c88.15.2026.06.15.22.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:56:16 -0700 (PDT)
Message-ID: <6a30e580.bf38ae28.2d8f62.caf0@mx.google.com>
Date: Mon, 15 Jun 2026 22:56:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6498342107177916507=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v1] Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260616030132.532184-1-chris.lu@mediatek.com>
References: <20260616030132.532184-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6498342107177916507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1112034

---Test result---

Test Summary:
CheckPatch                    PASS      0.93 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.61 seconds
BuildKernel                   PASS      24.40 seconds
CheckAllWarning               PASS      26.47 seconds
CheckSparse                   PASS      25.22 seconds
BuildKernel32                 PASS      23.58 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      523.12 seconds
IncrementalBuild              PASS      22.61 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/319

---
Regards,
Linux Bluetooth


--===============6498342107177916507==--
