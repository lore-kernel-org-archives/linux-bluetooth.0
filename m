Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCA9361DCB
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961201; cv=none; b=sT1dzObJ7G0KUdF3AbfV71FFtNdAO2BUJrQ7vGOy+Hec/8NPxx7E7QAFVr9bu3Y5TzpwF7H9xzA4J7pDMhnHVnRMFhQ16Sh6um3bhkCXPSNvUltK7zsLefgHIDF+zxQKLq3aI/2ToBaX+vb9TzVkc3i/JmMAOSfyVoSPZMd1g0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961201; c=relaxed/simple;
	bh=CmrYyCCneubeSX79KXjBKyi90Rn50VqYgtjaNizWMTs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cpxbAB+hVZ5ssbc9yMPoUC3wfnghyAWaFf/MrLIXgTfllavhRhAj7U1P9hafQ0E6iU41aG/peAK4WNO2iM83EAFavh3meiDpSkLrPUuSaE2AdDwLw/A8nRGjYlOka63IJ+EuU7RG7YhLPWVOhCh07NQhiGWuZ7hTvtmUrqM/HDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7/ymbmr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7/ymbmr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e86dce4510so18960115ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 23:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791961199; x=1792565999; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BpFUZfS0VWspDQ2YjLol8C5et9hO9p4JmpWcYsLeo/k=;
        b=i7/ymbmrJUEPAbUNtBUkIi2ZexAfsk6f2USOQGthCv71vMfFq60PZbfSep+eGP9wKr
         jNCPtTgZ9m2zyiPCMhi6O50q9vBodjFZMwcuuIWniUW9G9jbsdtOJw6bSi6illMQOouH
         mlhHNu+jxPlfleEOxXG/sJiZN1MyE/OES4J0ThoAD5VvxiRypVz3ICcJYen/9c97UW2q
         ZVxQG8O1lOFt/W7NjW26CIlFncx4kgSzND5QVu00HvIm6rwMDBn8rlNgjH4PcQejKv/A
         R4wXj4W/gipjy3I9FYBCBI62cX/nOFH3KyniwcFSGjPQQI8D/JyM8ZsoCjvzjeNu8hhw
         xgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791961199; x=1792565999;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BpFUZfS0VWspDQ2YjLol8C5et9hO9p4JmpWcYsLeo/k=;
        b=XScEm+aCbhYJMfUwC1QAXZydFayjXM1YU75JMqISIoLWjYxKe2jRHVBSWiQZRf+mki
         66gjjL2uqZZyWz688YuUbl/1Hbp8zmlnyBPcINF4b5tP3Z6+P5zngWZekKp4m/TYmd9I
         GCDISMt3GfsDqtb+14qXwptLkD2hwu2Khyh7BWVP3FGtz7LbbZ4SkDAHDPGj5c1cKSjs
         /7ybDuAuDQicwbFK19WI+OSuGw1rLtJkGR3VQPk2yug65v8D5XEjJ/WwDFBr9AYNjhJ7
         QnNdUdABJ4Izs21TZxzspWft6jPUUkAfq2XW+8FkIjC8SGHgeV+1PT9bD6beVS52sxpq
         /2Gw==
X-Gm-Message-State: AFq9FYItucRQkfAt83S2LrVzyO7KCUa30cn+DMBTaMgntkT0bz+vY1Dn
	GQ6ZQJJCAKN/9lX38MFuyUg6bdovx5YrCmnHaR8hquBffaT4OLkF6xLt6qM6cwen
X-Gm-Gg: AYBFou2QVqekk0SEhjXlKRGh3GknxXSEio313NmtPW6CWOTlLkFCspM/vnM/0rRAPce
	BIe5rmzMf/x+ycCb9JPXDfUhI1A02rB0anja5GwT6UB4emkqFy7KSvZFDDNxO3hogvdXHeR9uu/
	mv/RpB4yQlYNEjpsF7ZnO1fGzEkBghAcBffo2IahhVYSRuaOxbWyK2EOsVPrqmWaLA7+LpqsRQN
	NLI/Jtb+cSflqgDVAB6l+TYcAoZAmgTp8CiSZIFk6dB04YP0tsPEqgxqrIfCDTBO6Y/kKQiAbcb
	Pjvh8Y7A8aN6IWTZI3RZewCGOgpFshxS7wtew54Nei28JHI8p0hRt5A7cIt4sbNxn//aq9VS6TP
	j8y0hyjNputjvFGMW9t/lOWTiUQoNMMEkQ8zEFM395Sw81UxV416ikvdgPNwNCZj/u7f8LqOHPa
	KfGdL59G3yldZ4BaBukkpUSkydW22mHEM5wcUSu7Mt2GrZjApgQuhkpgSEtW2G168xqzyg/PFh8
	65h
X-Received: by 2002:a17:902:ef4c:b0:2dd:ad73:c97f with SMTP id d9443c01a7336-2e842ab68bamr120515035ad.23.1791961199377;
        Tue, 13 Oct 2026 23:59:59 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.155.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421ae999sm65526455ad.31.2026.10.13.23.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:59:58 -0700 (PDT)
Message-ID: <6acf286e.6be3a7c2.2b75ce.4b04@mx.google.com>
Date: Tue, 13 Oct 2026 23:59:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3733028167230119520=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [v2] Bluetooth: hci_sync: scan unfiltered for host-resolved RPAs
In-Reply-To: <20261014051600.408746-1-cochcoder@proton.me>
References: <20261014051600.408746-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3733028167230119520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185253/

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
VerifyFixes                   PASS      0.05 seconds
VerifySignedoff               PASS      0.05 seconds
GitLint                       PASS      0.16 seconds
SubjectPrefix                 PASS      0.43 seconds
BuildKernel                   PASS      16.98 seconds
CheckAllWarning               PASS      20.72 seconds
CheckSparse                   PASS      21.42 seconds
BuildKernel32                 PASS      18.06 seconds
CheckKernelLLVM               PASS      20.43 seconds
TestRunnerSetup               PASS      398.16 seconds
TestRunner_l2cap-tester       PASS      12.66 seconds
TestRunner_iso-tester         PASS      8.56 seconds
TestRunner_bnep-tester        PASS      2.64 seconds
TestRunner_mgmt-tester        PASS      79.86 seconds
TestRunner_rfcomm-tester      PASS      3.84 seconds
TestRunner_sco-tester         PASS      4.76 seconds
TestRunner_ioctl-tester       PASS      3.97 seconds
TestRunner_mesh-tester        PASS      4.85 seconds
TestRunner_smp-tester         PASS      3.81 seconds
TestRunner_userchan-tester    PASS      2.64 seconds
TestRunner_6lowpan-tester     PASS      3.80 seconds
IncrementalBuild              PASS      17.09 seconds



https://github.com/bluez/bluetooth-next/pull/927

---
Regards,
Linux Bluetooth


--===============3733028167230119520==--
