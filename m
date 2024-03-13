Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B30B12E4E
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 05:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710309319; cv=none; b=ak0oocWz5NZiBLx9/qbIZU0e/MpNbMlXkI7ze3WQeInVebABj7Q9fnbEfkIIlL9fuxVgFoHvapByu0YzoVbryA/2BJDhRHHyrJk/2OgR7o1OnSPyeaNyHFEi3Cf/WCkFoSJ4nti1E6JyY3zKUZNGSlZ54Lt4AY2gavSJQ0frx5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710309319; c=relaxed/simple;
	bh=7aoCvY8EUNVsvvUMIdj3S7UhigssqqSEGEApLKni5wg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CW+wD7FfMIfxLYJfYJlUuzwG5jIQupGVWEFoDt5EEfL7+AAgViRIrthXbq4hv53TxsrqC4G6c4n7/ctZoSgyqnY79Wco9rsnr+0icImwg3OE0HoW+SHY5e3CcL6mQAjMOLplQs97RY/tRR7AWmeKb1BU5ly2CBaqglMLK0F7pQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cajAXGF5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cajAXGF5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dd916ad172so25403425ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 22:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710309317; x=1710914117; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zyNuQ34Dl/FmbPfkdPMdxtbdv10eLZe8T50NIPwMuuA=;
        b=cajAXGF5QPlpCKJkAQn1QZpGlBHuEWzTS94ZlGE83H7g+I1sup8l0SVGZCbceRSY6F
         bzCGGa83Czb2ep0VAb30utikGcJ9Dt6naX/fsnuo1bBfEMSRYSNu5wqIruGdJmLn93Mz
         rInUQnxB9XV4efM51ygifXfzF1EpFbqtI6d5+WaI/6FOfJgQunAoPpVVfH8Xg446GMfz
         /sU4RHtz51yclCM8n3DfRgPnQc+I6vnamglwP74W9eD8hIIMaVNm6SdxChizq9mHfjOu
         8XmOHCoc+gInkiwEnY3AGu24WvTuG7CErvrGzzBUz9eE7ZzRgDotjj+semaibjKoua1h
         CE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710309317; x=1710914117;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyNuQ34Dl/FmbPfkdPMdxtbdv10eLZe8T50NIPwMuuA=;
        b=rELszvAZftMMCkyZfQcWiJoAHzY9jtXVfdUPaU/V5m6WG2Ei90cPlqCWqPm5Qw7jby
         UQqNaqh50SXWQQkU0Rizvfpz0E8xXKFsdndBt+cViajDaOwyWk8Dez5WoRrFftT0VEvx
         iSpZDxDhePQPUZuj6w9MdUID5WzYh/6hQmuo8l0SvC5zmIKuaT6nUrNjxXym09vesFQj
         SGXf9lKu0OeWQarxFZ40oC2NXdv+bU53rSB4Qu4XXWA1A7RQpCaHfrfa5URhdGA0bTCS
         ulCT9O9aNTjujbfT3YGLoDdIW9rpKu+q8QZDVI2qYBEkOprc3ATrv7pJFNO11Sux9CHh
         R5EA==
X-Gm-Message-State: AOJu0YyEqdwljdxVCGo41ko162eLTRH2gqQlzErFTnGezwy8EOiFeSWy
	0N+r7jTzQiK2ooWMXMBdEDMhrJdejxiDo51eU2TG5weQTrG2r48Z6eE44Nqr
X-Google-Smtp-Source: AGHT+IG0AVXaxzkE655dOpyhmclRszEjJBt3Wj+3VOCpMGAsaJdXu86qf92XijLCH2+kVgR/rta0Rw==
X-Received: by 2002:a17:903:24c:b0:1dd:7926:e35b with SMTP id j12-20020a170903024c00b001dd7926e35bmr2913747plh.62.1710309317455;
        Tue, 12 Mar 2024 22:55:17 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.100.237])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709027b9400b001db3361bc1dsm7718308pll.102.2024.03.12.22.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 22:55:17 -0700 (PDT)
Message-ID: <65f13fc5.170a0220.4d9aa.774a@mx.google.com>
Date: Tue, 12 Mar 2024 22:55:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7844267973822015390=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, youwan@nfschina.com
Subject: RE: [V1] Bluetooth: btusb: Add return error code
In-Reply-To: <20240313051102.424926-1-youwan@nfschina.com>
References: <20240313051102.424926-1-youwan@nfschina.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7844267973822015390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834847

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.18 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      25.80 seconds
CheckAllWarning               PASS      28.46 seconds
CheckSparse                   PASS      33.44 seconds
CheckSmatch                   PASS      92.12 seconds
BuildKernel32                 PASS      25.18 seconds
TestRunnerSetup               PASS      474.74 seconds
TestRunner_l2cap-tester       PASS      17.45 seconds
TestRunner_iso-tester         FAIL      29.03 seconds
TestRunner_bnep-tester        PASS      4.48 seconds
TestRunner_mgmt-tester        PASS      105.73 seconds
TestRunner_rfcomm-tester      PASS      6.90 seconds
TestRunner_sco-tester         PASS      14.49 seconds
TestRunner_ioctl-tester       PASS      7.21 seconds
TestRunner_mesh-tester        PASS      5.41 seconds
TestRunner_smp-tester         PASS      6.46 seconds
TestRunner_userchan-tester    PASS      4.62 seconds
IncrementalBuild              PASS      24.31 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.154 seconds


---
Regards,
Linux Bluetooth


--===============7844267973822015390==--
