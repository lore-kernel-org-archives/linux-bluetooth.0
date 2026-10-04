Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8973F65EA
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Oct 2026 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791139769; cv=none; b=BxMVJpcrJMhDjGiirWeiedJ1p2pafpFTRewg18hgMwLyIeC0UR8yMPGTyIWG9SvpN7R1yX2miHTKWTpTANdQiixRK405opn+md8O/bfq//0Q8FwZI7B4ABhXjMRo59/ReObnDLNspNCUsaQPURGJUUqu/nWmFcWI2F75DqDWBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791139769; c=relaxed/simple;
	bh=imA4YJU97dAA+uJgBIqI4i7eyTypnRZyGTzXQFdWd8k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bAO/N/Nvijs5RkcmL8InxO9yhSEcFa+pZJ7eUo+R1exjfTBcARME9QtsYB9L0dpziFZkIPyoPaULrr+PDLNzTBKoxzDu37etg3emm35t0weHMiHCWLPT0z7L6tBmLMqUo8gc8jRePiQpbQE0iiLm5EC/POTjMvSSZ//EDPQKryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ro5OmtC7; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro5OmtC7"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3512f0ac09bso159675eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Oct 2026 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791139767; x=1791744567; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qeMMgMbwjmH8dJ7fCjdJ2QF0A2feCCSUHZV1dUOq6OQ=;
        b=Ro5OmtC7WJ30p7lKEBLg6mzswXZOMKk/CWwJTJsdMqvWcPxwa7rf19Tu2SqAeVejgq
         iM+0wbbWN6Xv+cF/w6nYssQAaiRF0RjpMI+1cI/rIs8oFRxcEuUmjefTrprV1aUdt5O/
         Y4Q6rY3lf97ucQULXEFMcKuO1RExp0s5GTi9tl4LFJMwA6mC+nJ6lCPhpKHS9W7Gp4iZ
         UFK8fkImuGAv/IV9BbhKtRzABPM0nnzTI+GmOiGmf+yGvdPUUntb4l6Fks2uffRHlxRy
         2n73H6f6EVUZxbjHv/sjqmshmJ8NDj3qKvDmeetRTGTr1gfr5ebkYRa7ex/5/Bpiu5IW
         wjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791139767; x=1791744567;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qeMMgMbwjmH8dJ7fCjdJ2QF0A2feCCSUHZV1dUOq6OQ=;
        b=09Fx1H9DkzeY1P9qyNxw9LAgNfOhx4Rfp87F4NS99/u4elpKf72IElIBJkzIOOk2Qc
         Obd9QcrLPXWIcMe3MiIgceZMafl81Nj/Y0RJPLFc9oCe3t+84jzSQZgtkB1ZdbtRF2xe
         y5xelqK2IFoaBUUBUo0hO4M+B29yrDtNbgBL5Thj7pslrSGJZSG9yKx3FmsT7UsFXPNZ
         W9UlN6+KUq9ufo+NBqaWg6F2SBbDBZkrBiVO6bngahWOldIf8bfPgcNwtg1lYJbd1ezk
         N0pEykTLuj1sp52GrdeYdGft9qipvHhVisQgKJAnnTl/pVtrFcRAoOJjH5WWgI9Rw03g
         Zouw==
X-Gm-Message-State: AFuF++nGvbaiGHJiTTOT583rVs/xdCeyymOKCrgs4poUgEXI/ERj21jD
	4Rw75S9HD1fCVAQCVA4SYYTlvy+sRdz5E2z72AYXdeZ6picGD+nwMSMAcJSZ3Q==
X-Gm-Gg: AYBFou0c8RCiMtoW/PzKjdkJD7A/ftiD0morVSM0KhVG5KpVpCkNwLTtKx59kzKtvwV
	aDnFi6wrhd8av5hRSt5jkM3lJVYkaek+N8T8WSlCNbCgUIyhuQ3IT1LFc6vrgxP0a1LL7vL1jAU
	SbyYrxjXPePfbebDC57VYxrSexNcRDlPj1w6qtCrkG3WLpIES0xrk0C7yB2UOf2UT/cU9fdTbPh
	p84WmD02P+lwGD6IRPoGhY1vrZoXIC5bChT5eGz0v2P2hyPNPntVQNo21FjRJxMhnblRTNUdfJh
	cjV/0ABOBhLtp+F8ycen3LJU8JWtA8uoXe+YtyFs9EGAKyKhsKKVNkyVPz8Jgpy+89AfbXPXw8J
	qM7KVy5RnKFED5hBmcWyMBO/T11Jj+gAuOCbAG2oaUjp4SxW7/TR/xs0o2K9UuTfzADOB6MvZit
	WbP4pPxQ/SRqbZkr3Jw7ASbxri0bdz4PhlCZLlWkXdEp7Sbka9j/QEOtUzrwY/7JuGusZ9jPq+y
	W8=
X-Received: by 2002:a05:701b:2310:b0:151:2e62:fe54 with SMTP id a92af1059eb24-1512e6307e3mr7953806c88.20.1791139767076;
        Sun, 04 Oct 2026 11:49:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.53.39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fa74fa1csm16885356c88.1.2026.10.04.11.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 11:49:26 -0700 (PDT)
Message-ID: <6ac29fb6.54e42a5c.2f6ded.5119@mx.google.com>
Date: Sun, 04 Oct 2026 11:49:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7686244634588424487=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix command skb lifetime during scan setup
In-Reply-To: <20261004162612.3968831-1-nicoyip.dev@gmail.com>
References: <20261004162612.3968831-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7686244634588424487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1179171/

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      18.41 seconds
CheckAllWarning               PASS      21.25 seconds
CheckSparse                   PASS      21.98 seconds
BuildKernel32                 PASS      18.26 seconds
CheckKernelLLVM               PASS      20.64 seconds
TestRunnerSetup               PASS      442.44 seconds
TestRunner_l2cap-tester       PASS      12.86 seconds
TestRunner_iso-tester         PASS      8.80 seconds
TestRunner_bnep-tester        PASS      2.69 seconds
TestRunner_mgmt-tester        PASS      54.09 seconds
TestRunner_rfcomm-tester      PASS      3.94 seconds
TestRunner_sco-tester         PASS      4.87 seconds
TestRunner_ioctl-tester       PASS      3.99 seconds
TestRunner_mesh-tester        FAIL      8.09 seconds
TestRunner_smp-tester         PASS      3.91 seconds
TestRunner_userchan-tester    PASS      2.78 seconds
TestRunner_6lowpan-tester     PASS      3.94 seconds
IncrementalBuild              PASS      20.61 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.698 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/858

---
Regards,
Linux Bluetooth


--===============7686244634588424487==--
