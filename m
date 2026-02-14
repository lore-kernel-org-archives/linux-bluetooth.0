Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D21D5CFB
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771077776; cv=none; b=PAyStRI1wlTMDFktxUIDK9VS/YMFrcM+GpzxTDqQqHp1b1fdnF06p4kY6FayzitI3dTkLizXWI5k1nFB5UAjzDQL4rGLjwJnyaHW+SCP/rqPkjkGnSLWA11Zwz8lhHyO+F/5y9i0OzxUp1akku2p8OvwbNXKb7mUsuvTQJwZRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771077776; c=relaxed/simple;
	bh=9HniaGmtvJiAAvIJjtzrKNpBT6Gd+QE5z0Us542lH90=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H8ve32VWNDbzQOzIseJz4XNF8EhySag10Bc6Zs8bY+kx00jiq0W8uTuzKB9TXZcUxxozWDu/V8x5jFrvFhfMplqtg9oMQFBeKRHulcprD2IarKWe+FX1cM65020UTidXKTHlheMzqEcHc41s/Ny9wVr/RIhASDrUITE/hD5wwt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nhkabelm; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhkabelm"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-89549b2f538so45804886d6.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 06:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771077774; x=1771682574; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fl6+p4ZcyP2fse4bq87J5FGUJ5fb9SNLYftCeXt7b6U=;
        b=Nhkabelm/mHPg4pH9Op/obZzA/i3ivvqxeg2BneEh3aIXxBO5uGu2edxK6Dd8Brzwt
         wt4n7Podypi7mw/RoGNdiiuPgZFnW0BUeg4vafFIiID3wPwqWwXlenEgLVyCtNZ7t8mY
         mXybCyI0RSYNULe+he8Si4vow0p/127KWHr7gRjMTooWw+J0AcMkF6ZoXR3iL+9w02QW
         r586fb3Z57QyYDqRWThAH8C3/xTCutnBsAsydU9sAG3mNeV9MAGVL/V4yCvZkgoLbtKR
         C4f5mLa0EB9b6+1/w1wzdTZarOvqS1wGD4wKCVov0IAy8mKHA0M9qD8hMAfXXUpKvZUL
         EjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771077774; x=1771682574;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl6+p4ZcyP2fse4bq87J5FGUJ5fb9SNLYftCeXt7b6U=;
        b=Vh54CzGG48T8c7hnXypP81CqJN8hFTJzOoqT+pOdulJi9RB0OR3U6P0ZTyCGSoZr8i
         yRPnnq0BWyXlZC/r7+Pc1rhMATx4yiFrFIlyMOXvcD1Aq+q0IqdwQewMwvtNj4uI2h1v
         MZE8uJL5oRMEDT793rd1iGdjFL28PQh0DpWJrhJqOj50oeWC3lpZrPsm1QOcMwHPdCFi
         Nz+yfZ9n2KnpaczAiwNr0Lp6EBpu2E76Z7Kf8F1Kq/cOH7l8wYgV3HXMezy5JXRoOLdy
         nKK65vJuhsCnbzHqmpC6QfSXZVccino1JnNWSrOv1LP+MFjf4jmpKd9Di2NGnfKCvFuI
         pnMg==
X-Gm-Message-State: AOJu0YyQLDkN6RSwZ+l13T110esvxPcPY1tolA8zWq7d16/L0QUf9aZV
	UCQ4/ih0RAK3x2ZB+yfO0MCxStjlvDtu1lIKvaEHxy2xMzVg8ogqmxTNRundjMNo
X-Gm-Gg: AZuq6aKbiPB4hWRFpWP+KOwJ66qdLgmsRWBCHd/SSdEEdc+aTMgCudDNoXMuKnUGFQR
	4b04JGASxm1gluLk6vUWXtlYtjf8X1W5y4om1PPz01+AmVDAD29g5zokurUK3QnVfVfIhFksRat
	QCQZDdbQzEEHbPYlRueGzltzpnFOKvYXi2p2V+Otn29xvfr2NuHWag8MPH7rNb/msVVB0Lqp2YW
	LZ7R6/7ASwgQli7G7KuYRqP3zPUnwAjoEJOt9Bjc+X+HRDetc1Xu3x1v9b1fDQClrEz2ib5z7Ba
	YnrDnCg5BJev2xT45GKQwPIgQxQNC4Pa7bMPZ0g6GBftqrsOSdZFRAXFCzUOkubEYCF5vpXaS0q
	dLViIyl86bS5N9Ivtpaaf7BWG2ijMmjBIbY1H4GrEP0x2GZRZ9iZjYX0ziIzsN71upBFS/WjHSz
	wf+WUeLlFkRpl6Gbs4cemAz2ozvT8=
X-Received: by 2002:a05:622a:14cd:b0:502:9b1f:ca3f with SMTP id d75a77b69052e-506b401721amr37936081cf.56.1771077774331;
        Sat, 14 Feb 2026 06:02:54 -0800 (PST)
Received: from [172.17.0.2] ([9.234.151.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506bc1c3bfasm6719281cf.14.2026.02.14.06.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 06:02:53 -0800 (PST)
Message-ID: <6990808d.050a0220.ed9be.06c9@mx.google.com>
Date: Sat, 14 Feb 2026 06:02:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1558276098136531772=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, maiquelpaiva@gmail.com
Subject: RE: [v9] Bluetooth: mgmt: Fix race condition in mesh handling
In-Reply-To: <20260214130610.68236-1-maiquelpaiva@gmail.com>
References: <20260214130610.68236-1-maiquelpaiva@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1558276098136531772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1054169

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.27 seconds
CheckAllWarning               PASS      28.36 seconds
CheckSparse                   PASS      32.64 seconds
BuildKernel32                 PASS      25.68 seconds
TestRunnerSetup               PASS      564.35 seconds
TestRunner_l2cap-tester       PASS      29.19 seconds
TestRunner_iso-tester         PASS      86.52 seconds
TestRunner_bnep-tester        PASS      6.58 seconds
TestRunner_mgmt-tester        FAIL      129.21 seconds
TestRunner_rfcomm-tester      PASS      9.87 seconds
TestRunner_sco-tester         FAIL      14.96 seconds
TestRunner_ioctl-tester       PASS      10.59 seconds
TestRunner_mesh-tester        FAIL      12.74 seconds
TestRunner_smp-tester         PASS      9.04 seconds
TestRunner_userchan-tester    PASS      7.01 seconds
IncrementalBuild              PENDING   0.60 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.113 seconds
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
Mesh - Send cancel - 1                               Timed out    2.769 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1558276098136531772==--
