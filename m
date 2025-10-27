Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1242D24A7
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554506; cv=none; b=d7zh2/vTFMZCMGI9c/BkA0ZDKb1wCL8mqEgMbwXcx/4QipsfZa2AZ3YMATyIkllzWDOIPsMFAZNWON4LDixuoIEpUvqDuDuiG+JW4fp0AcoLnJVb7qUi0jKNa5er/vF3X38FrZZAERwugYLmxExjB03cG7CKoVgBHGIQ/B1IpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554506; c=relaxed/simple;
	bh=3mpJXernIW0AHIgOJwNxHUyTBrcyw4mbMdmm3oTC7Cg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sMpKfQ7okq0G+2Z7p1lnN1EyjoKGr2dxCpd3w7OQJQJniwtv9bKvHUwjwbbzjOfiwVIbrB0Fle2S6rO/gcmOXWkfCWdEVs+Op0pAIlJztcXUa3jbwpfamOXQcaI8OwxCB70PXx1L6Fgk12xz/F5Hdw6mSxK3+wicLr/W9MeWMN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxdpE/iB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxdpE/iB"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a28226dd13so3127046b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554504; x=1762159304; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=waVIV+XSzpiiscSBVMAm/ShX/0TxrQHgqwGfq9bK+8A=;
        b=kxdpE/iBVVDQEZVoGVg0DFZW0fCoGZwMkonhHLnYjdps0MjtN82uQj27q8rstLi2wy
         IwGrghHYVFtyDErUAPiUOFxCXi0BL2EO4Auu/4aFb1VLpN1RlFrXI+jAOd/Y9Q755LDQ
         rG/9QclUkz7x3Quj27eVETRxn3yn6oIMrtTf/8gcFokbcuGilwjNHW1Q+vvbYyJFe3TK
         gX5gs1f6r2y4Hd4Sa7pICi2Gme2Ot6EEWFBtbEPGpf0HaEjJkpypsX0QZL8zrhnd+fbO
         V9MU6Q/J35slWys9MIuYSo/0RwkxfffFFvxAXfJTWLATF2U3Vm4V8VfJ2HyiBg4v1iaD
         vMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554504; x=1762159304;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waVIV+XSzpiiscSBVMAm/ShX/0TxrQHgqwGfq9bK+8A=;
        b=Bp41Sj7mVLlaVo45/oc/rThZ4bYutY9F6huJm1ptml5EAmm9++Fv5zEEF/SCb3KLlE
         +c3fnHw7MNM19LSKrgMa8PtuUeRc/SmxUL963A/TmnGJ1JvtfRkwLwpl3U8PdfWnlKLw
         v5PTaZ10cMsERwrKmYecQPLXAMB7+4+7vYeZEvqkJ6YtY2zkdCmW/Xgyil4EXywF8NdW
         9eW2F6R4mGWLfXfcWXn4obx6Z3WA8jyoZaV0ZfF55Oakm3+hoUdMxM6h19iQn2MyGpI7
         bU8UsbMKgojYd1XFb0U86wgZpckutpf8oM2bSya53u0VUwvgbbNbhkTwGE3tKcD1X+po
         WVng==
X-Gm-Message-State: AOJu0YxsrPB3uC1i8l50NNFVqHnhy8MecqcVGiVD8tGoG6SwfX5cd7it
	+MF3VBJMc0nAKlqu8aD89GvRQ8wh/qu/OBf6K9o/H/lM4ArQd/OSeCcK0/M22g==
X-Gm-Gg: ASbGncuR8YTmHtJdu3MUgP7XFZt8CLlPiNUVz/46cmlFhy3T46Xi1Q9gMtBPWUl2G/O
	SSo+pzyLGyK9wZPBEkrvrG5Nt8NyMnO4CKm7TWPRBesNCpgx4+bv/wZNY9O/lAoMC8o8zdtcLgD
	Qrlx/8lg5jw7UbI4wwiACtdL7yud9RWHmXJbg9h9RYg1sCHybWjUps12J//hSjfFiWCrUsMC+4W
	cRWlwHCLsnVkfo0XaRg+WHXzD6wa6fIcW+gp8haXnhxJwaogCuxsVpDMxCTkSmAIh79BCyVYlMB
	27ZrtxmOfKRnLdgr2OjmFcCZqvsZIwt2GHootT7XLGJq3d5R6qGQZ5yhKlk0AWvwnevHVLIx14r
	iiPso+s+Ye4GYGZiFBHInvUu/t1+z3WbvY/UXroF8uvOk97NpyP3+xFuUdfBbos+ROKdo3pwn6v
	ce4PNZstk=
X-Google-Smtp-Source: AGHT+IE1VctIL4oND/EjNrYy+V9bRFYbWczMlXEu7u3lsc12k94u/gx8tUkRtUV2CeLxCq7iUiqUIQ==
X-Received: by 2002:a05:6a00:22d4:b0:7a2:1bfe:ac75 with SMTP id d2e1a72fcca58-7a220b1995cmr42421945b3a.16.1761554503603;
        Mon, 27 Oct 2025 01:41:43 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.211.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049c01sm7237963b3a.37.2025.10.27.01.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:41:43 -0700 (PDT)
Message-ID: <68ff3047.050a0220.c12d5.291b@mx.google.com>
Date: Mon, 27 Oct 2025 01:41:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0722570742126107336=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: Bluetooth: btrtl: Add the support for RTL8761CUV
In-Reply-To: <20251027081044.11158-1-max.chou@realtek.com>
References: <20251027081044.11158-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0722570742126107336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1016089

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.77 seconds
CheckAllWarning               PASS      27.18 seconds
CheckSparse                   PASS      30.85 seconds
BuildKernel32                 PASS      24.55 seconds
TestRunnerSetup               PASS      492.90 seconds
TestRunner_l2cap-tester       PASS      23.58 seconds
TestRunner_iso-tester         FAIL      47.56 seconds
TestRunner_bnep-tester        PASS      6.04 seconds
TestRunner_mgmt-tester        FAIL      114.33 seconds
TestRunner_rfcomm-tester      PASS      9.22 seconds
TestRunner_sco-tester         PASS      14.30 seconds
TestRunner_ioctl-tester       PASS      9.97 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         PASS      8.47 seconds
TestRunner_userchan-tester    PASS      6.44 seconds
IncrementalBuild              PENDING   0.55 seconds

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
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.102 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.107 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0722570742126107336==--
