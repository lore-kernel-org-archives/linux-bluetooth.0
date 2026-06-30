Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED631352A
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844529; cv=none; b=HVJH5N5iFEgyrAeoXPUbW9fK1coiVC1AaibOjG8qIhzD4VKWbMYcRRkzdgH5nNly87+7x+Mlhm+VddvRgPLhdOssLKbJLWI4o5c3hP9X/Sww+XXpTkJ+xjb3sbcYZzHYx+ilafW3MpykQbhiB+TKymgISytxdIioAviDesxMbH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844529; c=relaxed/simple;
	bh=b6YQJV2j8YeuWmYJBuV0rwadlyws9zaUynvTWbVzIVc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VPcw2BaD/QJ7DE2T2KyGasTLe1FjeCOrNVP2MyRwqDzf0a2qvDesoM2pi+Z21qVMRbbD4Cz07Dbx6ZgU2qhESeBrQT1sVOUe8rDNq1LINmFkEgPIEaX3VqKU+yU72C2Wwr4Uiqg2NoWGikKMiOluCeC4vIl0Vu72V76GgZv5UOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sbdw+BQa; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbdw+BQa"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30c965eab27so1247230eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844527; x=1783449327; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TcPNz6FW+dcQ+7i+EHkbv4zHLBvksHigcwUfcty6HQM=;
        b=sbdw+BQaxTIa6226TGr6cbXG3UjUvOy2Wz4tn8cpu7cd4/9Ozl688IRDAkKyQ2selR
         XVF7jW4lFer0MUjf8yvvIabGicek677pO94L0UcBqwuDS8cyKgWOxJz2McjA8KuSJOjw
         z2NZMfFw2uxonsgdjmLINqFzzAoHbJV6gLal/cfRYGARzuxwBM+h/wv3VynXxdebBkMT
         6hiu6OYNRUiuU9/UXGKEWLVFTss4yy6kZVrU2ta6qVbR1hZh0QGDj3/hI6zzvn3gxaa3
         ys/gliR2QFvErbrj4d1kIpgMhVTnR0EXMjqzNHC3c5M4CTeEM4LqojX2wDYCUGjqamVW
         fZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844527; x=1783449327;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcPNz6FW+dcQ+7i+EHkbv4zHLBvksHigcwUfcty6HQM=;
        b=V14GMVS3QROXkEItY3hIxY6sVLPDlrGXzfyuG6Fw+jJjLG7AfQEAgmVzrhZI6MjVV2
         t9TIlrwwyZidXNaNPeqS4bvAdThecHIZBs/jiXsmtDTSNXsa+nF+GpHkbV9hxib9hkP/
         N1NRsgYAnAph91ypqBLmgpS6KXYeQvgSinErAE78HSHAPSLp2ZbJEGxSBX+dMKrKk0WL
         rwvAjzTpT+LOsP+ppQ0TW0fdahpJiDzf/HOy/A4E/qz6WUUgdfbGFFgidZxNVSNE+EoO
         OvFt8dCIdegFqbLWwNdgt1e4k3xu99IgRfhDPGr2C2yqhdYnRIAylE315Lhf28nS3bTZ
         oTsA==
X-Gm-Message-State: AOJu0YxsJ0KjlkYZ9xakMDBtraDSxXuXimGF5CNwlJ+4pQMu9CY2aZ3L
	Ze69MVllrSu2B0agvuLf3ajgmerxfAoQepybp7GDxwLvQbAoZXH6ByeeyhZPpQ==
X-Gm-Gg: AfdE7cm7jHzdbQ5xEfRN5epO1SY/OIP25/xEPEDpfJi5MezmSRTGx9at1lDclSbkG5V
	TFCapkit79f1LzlJaGA0UQLEX0pmQOCxk/8jwaqh2N1Ek0xwNQsDIl/PCErEatCTKMZ6kIglVU9
	RmVqbAXvFAFX3GS8qTcfivk1wHrr2cQqgQYNU/gjJTyX9sLDZ5dz1qenNM0aWD5SZKt+TXRBhxS
	0mFULSLB/6gsfLpX2BUtPwAazkBDGoTVkIizirZbBTwCpPU/sXozSbsQ3XE7agNmoo97kq/mHlY
	DNVOJYTt4y1lg+2+xSdQePlhJa9+BtjxTLAnPJiFetfYGGfek43uYjt7pCFg2CH5MILz4MMvH15
	gA4U472vyuYa2/WA2ZvOvqSiZ0BpVUKhDlkSfxbX8rbu17ugjxQ3iQSHw4AKWOy7WuG+CW7ZFgB
	vTYweCVEZb+3pwmv22vpvvJlnK8nnVCnM=
X-Received: by 2002:a05:7301:600a:b0:30c:ab4f:46c3 with SMTP id 5a478bee46e88-30ef0a1ffd3mr1455191eec.41.1782844527321;
        Tue, 30 Jun 2026 11:35:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.107.213])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f584bdsm11169326eec.4.2026.06.30.11.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:35:26 -0700 (PDT)
Message-ID: <6a440c6e.481afadf.29a24b.2357@mx.google.com>
Date: Tue, 30 Jun 2026 11:35:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1601827691789905813=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Refactor FLR to use device_reprobe()
In-Reply-To: <20260630165919.102803-1-kiran.k@intel.com>
References: <20260630165919.102803-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1601827691789905813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1119161

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.59 seconds
CheckAllWarning               PASS      27.23 seconds
CheckSparse                   PASS      25.59 seconds
BuildKernel32                 PASS      23.84 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      459.08 seconds
IncrementalBuild              PASS      22.83 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/377

---
Regards,
Linux Bluetooth


--===============1601827691789905813==--
