Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B031326A
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767170702; cv=none; b=pHv8p6+vdBpb9vb18IY+h6xsc5tiKTR+daR7j0l/kyAI/yJ1RQPyHmySaWQuNzxQ70CC91VR8RNJyN82lHdNAdr8lfTyX0dVI7Vn4HNZI18Qf9ZybBLknjCOkIvfwvIa7YyEL3Iq44K9wu+U/OmudBitDMFkmVLExQcZvh53bfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767170702; c=relaxed/simple;
	bh=+ZqbXSEYC1vsVpOp5unT5pYcmRv6J7llOo8NWnTfuqo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BYVlmYgH6Mf+E4N7I/Zy0pHY7ANclrCAJxk5q1dzGG3MXZHxFqaMiXU/R+fRZCaMkREmz4duuayVeu4GKNtbQk257+536UcA62h9ljaRmIBdjMKhL96XcvoiysCdxYkiYgtoXtUI5sYX5H90As/r7c7s9vQFU8IhHW1viNuqTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFgqZLsa; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFgqZLsa"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-4558f9682efso6940136b6e.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 00:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767170699; x=1767775499; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wys+ggUvPozJyFk6S+bucLNFGKm4aTfRwQT4zGGHFlg=;
        b=TFgqZLsalsTtrwtYxQuyFQrbjt5joUNfqwERqx8t8lm+NF65hEcSdf9MTWIti76yEP
         JxbMk9x2FR2lFBcdBbGoJ5TpCDxISdP+RutbsUus4qIlyXJP5uUYsah+p62mMrypA23U
         aK5UPaRIF23QnjOGb5QEXbeMIh1v277TFeM6zb8WsDoIczI1BLdp36EbW3RBEOzfJdm2
         3wgJ8FwPU66kRIbl+eUflgwDKmYEh7JvBY1GTT9XCkiwW9dBgXSfJOSmezd0Pm1b87mu
         YS9xIT5RmPMwUalxGJ6Cny+zODU7uRYywlkvSCIX8bxAOc+Y29NGEjDILuWW3NKODr75
         N8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767170699; x=1767775499;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wys+ggUvPozJyFk6S+bucLNFGKm4aTfRwQT4zGGHFlg=;
        b=lZD283q6PDapoyPMAjk90hiFJvNzqtkQj6Qcqh2dyXwkXZn/PBuNklu3bPXnXoQY2M
         mwVUOqUlCHrZpAPMErm0GUvLZUwrnsNLSCWZLnXtlTVk8UojlxFGt8D42hyM2324xnv+
         DEYq2fMIz2rFOZb9E7h/sJDAGyn1c6h8z/uUXKqB/ue9s52Cju+W+FhAufzCSr4CZFb1
         tdRQ5MuHjly3T54V18SmWakkVEk5ZiLaexS54G1pKCvZdIONewVNCiLlBBi8H5bDmRq7
         dhnuKjCMwhKo2q8R7FHikbiy1x3XYDAhK41lCslq4tITsroA6KGlofClxbo+urJ4coFQ
         /YdA==
X-Gm-Message-State: AOJu0Ywsw3SIL6+lrSEadlZcsTo7THZynTMdsK9+X6h0cHRy0/rq34yi
	4z8KS6NuyxYL1JY4/p9S4SPm+3kbEgH9Jy8OeEj8S6BvzDwdyZfPeCMXN6BGI9ub
X-Gm-Gg: AY/fxX6lHrkobt465guaMN2AFoLJ2U8o0ltavfGyzo7AccHWUyV26ac8lewcbE/mU+d
	GQo1RwlHnAEsNfkMWTehAQIHWmoa9kiSqrhKh184D0QND4KpXs7iStmyLDasfIbcQyKsu1UAko8
	/PLLRof1w1EhX6NQ5mR3+q8yKpqp5ocKsti8yKTVL13OGEgZTOVFOE3CfsXfeS3Veic0R508+so
	7jTKHwueRX/uNE4aASo8aliap0OSADRHwf0OZvcplnI8dEs36yW+7LC5X+Vs7nac0PqK1i6/+0F
	xQRTGLJ5pduScv9IzeYsBbV75G7//HTqlPFFK8trCXwnWQbKmK6fiBo4qLYJh4xcSwMCQBet/9b
	fdi7VtxOFOcF9flGIHvQWx6ybGtB6kzK0nJf46nqWdrxQcUbkY9+Ms7g27cwXzW+O6ogaPx1mQU
	S/BOdPO6yVC6R4gg5/
X-Google-Smtp-Source: AGHT+IE3HNK8EXNO9fPfsnbLch5SgOvf7Kc9xT1XeHUqC6MuJtSxxXTk1UvGo7joCr2SdVorPnfjKg==
X-Received: by 2002:a05:6808:2f0c:b0:450:d833:6bb9 with SMTP id 5614622812f47-457b2127481mr17174774b6e.60.1767170699387;
        Wed, 31 Dec 2025 00:44:59 -0800 (PST)
Received: from [172.17.0.2] ([132.196.32.53])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-459f23f612csm1981591b6e.7.2025.12.31.00.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 00:44:58 -0800 (PST)
Message-ID: <6954e28a.050a0220.2fc7e3.7131@mx.google.com>
Date: Wed, 31 Dec 2025 00:44:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0113856104532525466=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: Bluetooth: btqca: move WCN7850 WA and add WCN6855 firmware priority selection feature
In-Reply-To: <20251231075817.2611848-2-shuai.zhang@oss.qualcomm.com>
References: <20251231075817.2611848-2-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0113856104532525466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1037566

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      25.68 seconds
CheckAllWarning               PASS      27.96 seconds
CheckSparse                   PASS      31.85 seconds
BuildKernel32                 PASS      25.56 seconds
TestRunnerSetup               PASS      564.34 seconds
TestRunner_l2cap-tester       PASS      28.23 seconds
TestRunner_iso-tester         PASS      71.91 seconds
TestRunner_bnep-tester        PASS      6.26 seconds
TestRunner_mgmt-tester        FAIL      124.44 seconds
TestRunner_rfcomm-tester      PASS      9.48 seconds
TestRunner_sco-tester         FAIL      16.60 seconds
TestRunner_ioctl-tester       PASS      10.33 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      8.68 seconds
TestRunner_userchan-tester    PASS      6.66 seconds
IncrementalBuild              PENDING   0.80 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.205 seconds
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
Mesh - Send cancel - 1                               Timed out    1.826 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0113856104532525466==--
