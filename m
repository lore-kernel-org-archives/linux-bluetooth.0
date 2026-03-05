Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870D9246BD5
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720475; cv=none; b=FBvZqqh5lkhFZIGcuIbkkc6VOjTaDItVtzuEJkOgWQauTcUjLOQH3/LS0hzcSiuY74v6mRrFE5KKT9Y2GhFnvSI0/hG1Rlk6qrOcgLVwW7WnBdIvqvcbNPB9qsbprMUio/RGgpSIv002Xv9yD0Y0q2j0KldtjSgTbQ6j/VkpPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720475; c=relaxed/simple;
	bh=FX3UQtb9HtpWO3/OIjGMbNUuXFkCZCwsSIjgkPI9pHI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=O65o/LAgfiDChFAF2Dzs2SShaKaFiST90Ba7sLjNSg6DhgPHZOqnUwPV5oyUoGM3FA7nsryxFnQyvQBze9KtU5AlQvHe3K7iZ4PvNrbuk/1pVRxLr9MZKolzVs22RCy/2/sI0kE8vlXnyw2VKew0FZUyWBnp997hVeud7swJVXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLBQ5vvX; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLBQ5vvX"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506a93ba42dso84705061cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2026 06:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772720473; x=1773325273; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MAsEcGFmHO/26dfExwbOhQuvNXQqETJKRQHrc2b1PKw=;
        b=mLBQ5vvXjWCHmp0j0aKa866LTXUHazGIY/6zskMFfdgbZ5fVoKSG2OUmoxhxMPqRCt
         Fkb9XmM0C49XsU6gHF7pw5GmjN2k2W7kbKIr+H98FbcVtSRS5m3G4TscJWnQnzr+jUOt
         U8cGGTbmLcXaxuvcsWmTZPsDiO637jHTGr8d5nmQX6SMguV5zKaUGGc8zbvI+Kl3X+vC
         mozgrwVRmEhtRt7MDEhdN9/O4BkIM5GmMBAj4pDCJo78g2jPadwN+aBQx07DgTUy5+yD
         mkudkgUamRgywVCKO/lr9ZWtcafjbpEupjLPNFgovn41mXXu/RnsvRDZQVmEJ5k2slrk
         LgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772720473; x=1773325273;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAsEcGFmHO/26dfExwbOhQuvNXQqETJKRQHrc2b1PKw=;
        b=rm/jgiTM1WW3q5n3pni1LOTUGTLvfuEr0pnBzT/x9nPu0laDv8H25L8Ex99tLlEQVu
         TxMho5c98bc/8XgYmQFKvou/pxYlnXDduEPC8vpbz6O8omgKKfVgNz5PGjKIqddCYh5j
         AU54MPXoogqx173NaX/X+QOlKpZ43UvVVhS/tTP8s3qprbXoRUD5s5svffvYAj9k7K6Z
         G7bxXh+4w1ZIk4vE/koph5FutQX23IYN7pFRoWso/0CTtE2i3n9CMwhKTwA+cUSC5Xi4
         MoYG6QicwSkHpQvQz1bJkzl5oBse5syY67pQbXu1BbCoNPmjzuJcu/KoBGda2ch6uMJj
         Kn3A==
X-Gm-Message-State: AOJu0Yz4jlwDlmk+awF4Y+uYlhsQv6gOlFZlVCFIrpD/CYUweOFzgjz6
	4Svk7bchF4iluCm+nq//306I20TvOS2/0nnVCkrhunpYNuVtTra8nYUgglS3uA==
X-Gm-Gg: ATEYQzzqij71vDpQYsvZgP53eDRYM1NYqRceGTUC0YJnE0gOwxiin99KZrPAZdfx1RA
	4kcY737IjX/P7skrK0oERK+jSjjPPtKy/FWFXifqNrbYsYUs8V/3pPDrTo4HeAoPi+H1GbPKh8K
	NZVgc285de7KtpkR805GsWargRZ4Ktx0cL2zlho0r4QyYavU6QJwK211zMOFvVvOoFlb9rRSDhW
	MvXfYwGpQFgbxzdpQxf2Xj3gszIIJ6ipwo/IlqTRQgfj+7BFpOcsFCfTzv5jcKylbjT+lcxPhS6
	4ro1Ze118jftj9sHvs+1YEHjbC+az0WTOgMFBXTiIMMHUEeQD6NezfkucBZL4UcYdJEYmtu5cnw
	oWTTAWXav3XtYfGZhINvdn+4UJDvO83wsNi3haJQesGC4+w3EWDc5JNhAVAWFKydHPscYz516It
	QIIbBXch+7BYfnbYErTt/hH/QfdRYo
X-Received: by 2002:a05:622a:11cf:b0:502:f291:615e with SMTP id d75a77b69052e-508db383388mr73247521cf.52.1772720472965;
        Thu, 05 Mar 2026 06:21:12 -0800 (PST)
Received: from [172.17.0.2] ([68.154.54.100])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ad028esm180489601cf.25.2026.03.05.06.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:21:12 -0800 (PST)
Message-ID: <69a99158.c80a0220.22582f.37fd@mx.google.com>
Date: Thu, 05 Mar 2026 06:21:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6651500753454121456=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, m.grzeschik@pengutronix.de
Subject: RE: net: bluetooth: hci_sync: fix hci_le_create_conn_sync
In-Reply-To: <20260305-bluetooth-fixes-v1-1-43effb810fba@pengutronix.de>
References: <20260305-bluetooth-fixes-v1-1-43effb810fba@pengutronix.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6651500753454121456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1061995

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 FAIL      0.41 seconds
BuildKernel                   PASS      26.64 seconds
CheckAllWarning               PASS      29.31 seconds
CheckSparse                   PASS      33.22 seconds
BuildKernel32                 PASS      25.95 seconds
TestRunnerSetup               PASS      565.68 seconds
TestRunner_l2cap-tester       PASS      29.13 seconds
TestRunner_iso-tester         PASS      80.05 seconds
TestRunner_bnep-tester        PASS      6.92 seconds
TestRunner_mgmt-tester        FAIL      117.73 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         FAIL      14.71 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        FAIL      12.46 seconds
TestRunner_smp-tester         PASS      8.86 seconds
TestRunner_userchan-tester    PASS      6.72 seconds
IncrementalBuild              PENDING   0.85 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.116 seconds
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
Mesh - Send cancel - 1                               Timed out    2.763 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6651500753454121456==--
