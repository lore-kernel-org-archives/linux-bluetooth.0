Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC8413613
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543082; cv=none; b=fri0cLfcLXIDLZEaZwKy3jRSyZGi6jaWGfxaifQ8UX5HBV7mJb/VJ53dF+bohTf1PjbVkt+PmoVcCzaFhbeXBUEtsVSqYwzA87CZsHD9gpm/mowaBGYOWI1RnoRiigB4umkt06jvWHPy0a+sujqH+iCNP28TpjsoEGjMdRdiXvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543082; c=relaxed/simple;
	bh=jnbWROcw7C95hKk6GcsF3kqgQrH+TLTrfqLkSmQkCQc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bwcBfkqk4CKLUA10BTblj6LL2cMK1CL5NQEtFo9dxbX6sV8GY04BKqydouLz0VbXrbwf6IDjsrYXaV4Ite8DqOGhTA4I6SPkeLaJaXS/PBDqWZfEC8lCPVXXbaJvMn7rLHWXyG318MpRWjnpOYsx4XAiokxMd4fWOuUvn9NChD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=japm5pcI; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="japm5pcI"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1370417c01cso4639150c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781543080; x=1782147880; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4De+l5oUxOBGxpCYLzK6bCNObFtRm+SxyI56OFSWeNY=;
        b=japm5pcIivTo075UixuR9vzywTHkfj/fFiqfc6fHWFHFu5yVjoC7qb5Khg/ffnG3b7
         zOuVTicMdywpoGZatEp4657b7lvP/rWoxcCQ6GT8R0NwCNNyJjw+6JfsSBK9/WBW/AGy
         +aW5fQYoCJ2NG5IAKtfFCDEmTSRJlyi9CxRgU98P4RttL6zH41ZlLQ1O0Sm0f7rZodVs
         wxzxFQsNaHYnkTgItN08vIbQykjCm0i+9LLvPxwUXPtiwAHOB5uvwxstf91xIU1KmtQB
         vOi5TtiVYxlIHrPuFbBSk09u8hUSjSQyM0KizpmMRPfik+Agif+2s2QHmx/1RY1ezMsN
         nEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543080; x=1782147880;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4De+l5oUxOBGxpCYLzK6bCNObFtRm+SxyI56OFSWeNY=;
        b=ZxpXrwx165oCBPPoLZgesDjPjfCA285ItgsMv9H+4G3A0he0ECe2rhuu2fUkoVNfsG
         hlt1jjbwpcv/NLXJN1SXHtCUCLDLZ7MEwWfqJTfWlMwim7BB1ziqhJBa4Rsx34NhQvVL
         pUx9T/gftP5bKQd+UfO0C13hNaiHutVWCVgHv3RLTn9hNPDDq3T+FT69MgilTc/FWISy
         4YLwztB7yGA3Ok7Kkd0Y0zP10/bWsLCzHI/1OOvv/JL6H48450vhe1DHruHOukqBPeI4
         HLWaKjCN6p3DuIZBTMwsb2YvVInKeWVp0g34uRydtRoNdLzL/5z6bQ6K+X0c1CMmxZ9X
         ndTQ==
X-Gm-Message-State: AOJu0YyFtbXnBbPb9ka9B2uMTh6yJm2LqiTf0ViF+f8E2lJdrrhEWHE7
	XIHrhbRW6OJokkmZCZVoU0o0vcVF5TtpbRSoUK5z95hj2Eycyi7XB8L1RIKGrQ==
X-Gm-Gg: Acq92OGsUb8RQPwX8KGubnRFz1JG1qLRQD1NUIzgbNeLMhElMo7VKGmcOMggmrdS1Ji
	cjDERpf4XDGC6wER0VblI7kzjwcipCLotsG4ljAhIsQOV8zpmd+a8IShqv3IQuvRBP1JDzcZqSG
	HwhK4e6PCSRE7ZvAw3Hsyz7Mw/xwUYkr1Kwif9iYBuYhQGgR/XGuSEOqgkW9xHo2fQ8r8iemVAI
	MRdFby9OFDwal9QuuzpLva5ZmVIeb9lEoXNsd6CL4OZcw+bhCM4LDlhGMCsibekFHGANeJZ5KRX
	f2q/5Jbx+bnPtCo4E64QxFKZWNOmTP94Ef1PdbToMM+mdT8CceQ+ccNAqzZWucDEzKeZ1y+Q6K9
	pMfDB16ppL0WoDf9E9pmFamEjiaQTL6PPAAjnL2A6KXuoMCGAHVWgLhDP4M3itUc00X9Shns1Ik
	qLDJgq1MQFPzCaizRK+Pqkn2CMWxiigZ1b
X-Received: by 2002:a05:7300:a54c:b0:30b:9e70:5bf5 with SMTP id 5a478bee46e88-30ba5f125d5mr34775eec.17.1781543079954;
        Mon, 15 Jun 2026 10:04:39 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.209.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb8f8b2sm15655875eec.27.2026.06.15.10.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:04:39 -0700 (PDT)
Message-ID: <6a3030a7.f732ad81.18cf48.63cc@mx.google.com>
Date: Mon, 15 Jun 2026 10:04:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6671157589426588300=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: [v6,1/2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
In-Reply-To: <20260615153527.1583705-1-oss@fourdim.xyz>
References: <20260615153527.1583705-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6671157589426588300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1111791

---Test result---

Test Summary:
CheckPatch                    PASS      1.82 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      26.58 seconds
CheckAllWarning               PASS      28.89 seconds
CheckSparse                   PASS      27.60 seconds
BuildKernel32                 PASS      25.49 seconds
TestRunnerSetup               PASS      571.42 seconds
TestRunner_l2cap-tester       PASS      58.94 seconds
TestRunner_iso-tester         PASS      96.66 seconds
TestRunner_bnep-tester        PASS      30.75 seconds
TestRunner_mgmt-tester        FAIL      207.20 seconds
TestRunner_rfcomm-tester      PASS      30.92 seconds
TestRunner_sco-tester         PASS      31.50 seconds
TestRunner_ioctl-tester       PASS      26.69 seconds
TestRunner_mesh-tester        FAIL      25.83 seconds
TestRunner_smp-tester         PASS      22.80 seconds
TestRunner_userchan-tester    PASS      19.22 seconds
TestRunner_6lowpan-tester     FAIL      45.81 seconds
IncrementalBuild              PASS      43.45 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.234 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.808 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
Total: 8, Passed: 3 (37.5%), Failed: 5, Not Run: 0

Failed Test Cases
Client Connect - Disconnect                          Timed out    5.480 seconds
Client Recv Dgram - Success                          Timed out    4.991 seconds
Client Recv Raw - Success                            Timed out    4.993 seconds
Client Recv IPHC Dgram - Success                     Timed out    4.999 seconds
Client Recv IPHC Raw - Success                       Timed out    4.993 seconds


https://github.com/bluez/bluetooth-next/pull/318

---
Regards,
Linux Bluetooth


--===============6671157589426588300==--
