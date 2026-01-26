Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51C3EBF0D
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453463; cv=none; b=ltGKrqcWlntsPqyDy58lxHGtvPpoNORTuAwS+qDUXB+IHOp/4JNlqKjqkwSpilpj/Ilb7uztnyGwmkEIT/72p+b2sP2FNiBFe17mJVPDabmU3tDeOmhb6t6zBPmmQR7bl/bpvWfNNiHd2eE+kkNT56RzSU7Ub5d7owsiojc41O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453463; c=relaxed/simple;
	bh=CnF6HnILIq2OvhSRZLJVts5OcZYGzpmBxdZttKpbUgs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uPpV3akYl+CyBj9iWxD9Y0jt4aWnorUyZpr09ODIDHmoC0HVR0xno9JmiDb+qKWV+gUfLctSWHORXA8nnLv1/tKcCXceBBTDeBr03STleEi/B9l0s3YOeS/z6qk2STVbTynGyzNc+pOrR2p/wvVZYVhhicvX/Iqc7Q/bYqBVm80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqVAXrSN; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqVAXrSN"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-1233c155a42so6734895c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 10:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769453461; x=1770058261; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KTBo4ltsIja8rxV49BHbpqAwZ8XRnH5BT3rLgjALye4=;
        b=DqVAXrSN4Qx2M9T9rUuCi97jwD9bWiRE13WS3v43pgGyOuBNrjGf2sJimHYBo3wEew
         3Svx54T56zJxIgX0vmemX8pqauMdAhi9grdFH22+NdoCTqLERSefWlvHzws0SQCi9jMN
         Zw69zkrjT3ahrI2EbTc/kENQZmZY/to2vtqB5/0aEyFleQNtmd058TfZDYQKwGWccn5S
         axb9BPdxn6mfTJw8V8HNAS4nmgaEJwWCtfNcP/LyxmMymjp1KZ/11Cm24jZRfDUBXocm
         ATIx4CJboPaamefEpwrwGPJSD5bUO7PArPQPazlfnzApDFSeGC1aiVSTyz4orqEMWs+Q
         QVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769453461; x=1770058261;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTBo4ltsIja8rxV49BHbpqAwZ8XRnH5BT3rLgjALye4=;
        b=JvO5ddy4TvAxKFYsk61MIG/GHiOGdPiaSx6JYdOwMsa+55roaRNug3KQZU7B2iwjLP
         Oz758be601DhRJfb4DwhiM7wbo6BPJrlLh3FS1YjQcdRtewLZPApgT0M9oSCf3nFWUzh
         fhbZPPwZhVnlkJ2Z/N8wD04Mb9Y2UVECrE2TFjW+Hc+FLR1hDM20IKyfvSwtm1Uu6eXL
         9A+vjPUrW4NJDiFtim784/TviQ3wq8FH7ar67IzR49T6ekBG4dxPthsWuUFvi0aFATxn
         J7GDkgjFJuT9fq0cpLeutkPShzOkTnRmhoCRaf02Dd9qMqnn8mdSel376mh6Rwkx0JjX
         gvMA==
X-Gm-Message-State: AOJu0Yw/Rykw6D8Hm1udG+Z/qJ6nqq+3rSalGWcXMFxLJZ6aCuf26Wr2
	mVLvHoRpmbnDW0ORljzfIfGdOGzUHgxYVrXNYMGhKFI/zzN4+zcocjWxVCbvKZgW
X-Gm-Gg: AZuq6aKideAzXWcBxYVWJFXDdDtELNRxd3RH2qaJuP5VpXD8xIyLDo+0H4Q3+mpc1tn
	X8OoKzw2gUfLadakidW1097Gt0ZkuGWOIynQ5BIURfK+wPqi6LijduE6G+fwjZj+V0Ww2eM6YkH
	ffzrB1BqWQA9dMZUpgeVzsT8KJTOJ/r2g5aY5asXxxgluKEM5OfSBHc6/Yb6U8VbS48VUUlT1P2
	xuCELqeyTpxtph/623qrKRkm8wYOBdaFmh+MOcsYoxXaMvI8Bk78epQGL+SvY9iLt2MzOwMn8Jp
	BJoiYTGPkBe2dqRFWBsLpSELIOirBQalLFCAtOebDq4pTD+yz/J4XCuYT0pDtIO6hjc+bQEFAmN
	cVq/S4dfjoUmqC4GsxlC2BbQB7z/iWzWNMcf1x9yDed9JXu4IbIgcOMTZUnY47nyzdpDCqIYG9C
	jhXoma/XWCAfNFUbP2
X-Received: by 2002:a05:7022:43a4:b0:119:e56b:98a4 with SMTP id a92af1059eb24-1248ebf637bmr3340316c88.11.1769453460654;
        Mon, 26 Jan 2026 10:51:00 -0800 (PST)
Received: from [172.17.0.2] ([57.151.129.38])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90d13esm19021172c88.2.2026.01.26.10.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 10:50:59 -0800 (PST)
Message-ID: <6977b793.050a0220.313f2e.331f@mx.google.com>
Date: Mon, 26 Jan 2026 10:50:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1676706887175665523=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: L2CAP: Fix not tracking outstanding TX ident
In-Reply-To: <20260126175340.3576865-1-luiz.dentz@gmail.com>
References: <20260126175340.3576865-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1676706887175665523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047242

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.97 seconds
CheckAllWarning               PASS      27.39 seconds
CheckSparse                   PASS      30.86 seconds
BuildKernel32                 PASS      24.67 seconds
TestRunnerSetup               PASS      556.94 seconds
TestRunner_l2cap-tester       PASS      28.76 seconds
TestRunner_iso-tester         PASS      76.65 seconds
TestRunner_bnep-tester        PASS      6.66 seconds
TestRunner_mgmt-tester        FAIL      116.23 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         FAIL      14.44 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.58 seconds
IncrementalBuild              PENDING   0.61 seconds

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
Total: 494, Passed: 486 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.154 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.174 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.186 seconds
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
Mesh - Send cancel - 1                               Timed out    1.913 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1676706887175665523==--
