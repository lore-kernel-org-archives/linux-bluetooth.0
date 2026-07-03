Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D520D4FC
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081886; cv=none; b=cBFmSDnMHkDo4RkboXecM7W7wgM6JL5HSfryPTcq6KxQf+bprCdhnRB7dr2hyjJcILCRstxPmlQmceYvHNo3DqAv3nguN0MVQUeJWVTAwA0Utt3/BNonxSpBu6DwJdzkFbT2W6TKGI7dsPuovIamkudtQ6euAtIfx9tl6aIfniU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081886; c=relaxed/simple;
	bh=Mppkkd/0a5BBOORMIS1TIE0ifVgR60REyZewd/uHWow=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AfpxfxV/CV6MlGZ/GN0gqXe81JS7paGoz2lfhG6fjt36SG7bm4XUOmH/8NHsCEw9YaoKEYPyxNrTiIm0NnqIze8tf/dWPF2s/GBd2jTYhvaRP3nVGnhfHPxsc76rdjUOkenNY4tIle9VqWbVBMbjPvAxPPScHe1+VSNQdnvSfRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPes0dkd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPes0dkd"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c9e89fded0so4181125ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 05:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783081878; x=1783686678; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tUQdLllcRSRQI9USJcXupRd4F5i8EdN4Mn3+qRN4YGE=;
        b=BPes0dkddhEFGkymUMTnFVpkc3nAqgX6FOnnDVAB7i4HusuqvMLZzgMg4X/yXKu+5/
         Bmazw3+VzPF3TRDBAun4+xK5Sd9E6y+8WlNc5F7c+mwCYs4bepzG7/as6h1gLZzMSo8Y
         Lk6Z29bIJeIGOLzscssacrJAA8ecNsFZxEAUtFuFLa419HLMbknv3qVhNZnIRZSKlUKG
         4X4/V1Ct39Ae16H604dDKK6BIuw7eDyfkAgJ4St1Fv10QihD1GS4suZKdk+fChRLiPdi
         XCF8TrQG0lSrsR+EDSB5ZWFPuvAiCTq5XKdGWy95oTKXuTNTu6a1Yb+O+FGhcQk3aOhP
         V+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081878; x=1783686678;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tUQdLllcRSRQI9USJcXupRd4F5i8EdN4Mn3+qRN4YGE=;
        b=YDSKCX4n0uhB9TcOLSQaRbOa0Lpcn15LvTd1UF/JIXUCvWZwtxIJhSKBdKjMXDqrR6
         0CC3Ydqoo/vVWK9Vm9mN8dnlTwGKMe5kDFGaIgeoxDjlD0egRvr1SZX6dSfwyd3e6Xlg
         pRRc+bJEZkmp2bIC2TFjeM2/Em2tiEZ4lXMaS6SSWhRpA7hDAbUNLOQJkCO0mrSpp9oI
         dYq+i0HzvE8bDDu87fZ4CbJSnT4DqBhSwiky33XVUqWw7oEaZcpLeAPyS6qbFtmBsoYB
         rDPcrbpd2LUntu7h43gvwC4xQONiVmoBlGuiZO3cLOFgJ39KUkdLbQ5sYQqeamRwOfNb
         Vkhg==
X-Gm-Message-State: AOJu0YzG4y/nFRmOWP5ne+WHFrdwP8BWVf6MAGcmdqmczPHDtBWuNWRm
	PME1rI5+WK9PkJ1kZqNxIkC9DS9Jvi9Me0jK8g6+KU8rQlfE5ohHrpFNL+yNcQ==
X-Gm-Gg: AfdE7cmDDYBq4GkYzjzDxkns5FIJnQBpRwz3Jx5tX8w76GqyFC4GOo2fYyhV5azv9Sw
	l1bnQLzzneH0sosoBlaUdp6ohxZ2u8EuA4UCw7vA7zMkvM8xJ+x/3wNJpqs854pxEt3AIGzKnax
	tT84Wy8u/6moMELH+5Q+mCAW8fUF8U2oU8WrX81WF9n+FEGRgVkmNtWeVCo+UAaq0DlSU1fpW+T
	oWby3VsQw/1F50ALkTL30EyB1nleBLEWe20853iZZheAWvRXikAG2ZGjA69CbcGp8y/suzid5Y/
	govHtrIOsbKwiKAMWNQnsKWD7ya50m6ynsygP91IpqQa/WKlgR3GEljNZB3Z7I39ybseKXGxt61
	evWrZZmrObxjjSdqG+hNbedwH7/wYqHoSmcrPZ7bep+VVd97T5TbYkwb9dmCcsqiPv0Lr8DzDi5
	/Uk0aagw2KcaRj9NPp
X-Received: by 2002:a17:902:d54c:b0:2c6:6424:c79f with SMTP id d9443c01a7336-2ca9112ccdamr98542675ad.8.1783081878063;
        Fri, 03 Jul 2026 05:31:18 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.55.39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3ececfe4sm21497205c88.8.2026.07.03.05.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:31:17 -0700 (PDT)
Message-ID: <6a47ab95.30759430.1908d3.dfd7@mx.google.com>
Date: Fri, 03 Jul 2026 05:31:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8646362403414104703=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [v3] Bluetooth: MGMT: Add management security level changed event
In-Reply-To: <20260703103524.536763-1-frederic.danis@collabora.com>
References: <20260703103524.536763-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8646362403414104703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1121066

---Test result---

Test Summary:
CheckPatch                    PASS      1.38 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.74 seconds
CheckAllWarning               PASS      30.16 seconds
CheckSparse                   PASS      28.12 seconds
BuildKernel32                 PASS      26.12 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      492.89 seconds
TestRunner_l2cap-tester       PASS      57.97 seconds
TestRunner_iso-tester         PASS      81.98 seconds
TestRunner_bnep-tester        PASS      18.58 seconds
TestRunner_mgmt-tester        FAIL      208.79 seconds
TestRunner_rfcomm-tester      PASS      24.85 seconds
TestRunner_sco-tester         PASS      32.27 seconds
TestRunner_ioctl-tester       PASS      25.16 seconds
TestRunner_mesh-tester        FAIL      25.84 seconds
TestRunner_smp-tester         PASS      22.91 seconds
TestRunner_userchan-tester    PASS      19.89 seconds
TestRunner_6lowpan-tester     PASS      24.16 seconds
IncrementalBuild              PASS      25.88 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.240 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.658 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds


https://github.com/bluez/bluetooth-next/pull/392

---
Regards,
Linux Bluetooth


--===============8646362403414104703==--
