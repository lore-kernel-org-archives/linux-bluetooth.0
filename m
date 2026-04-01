Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138E735F5EC
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056235; cv=none; b=iDRSe2ivppYfp8ZKE5MaVy1er2K2LQwlp/AuQxI8+h6MwFDnSlts2Igu2R4Yj19y3ytBwrdc/zZiG/6WdoW+p/w5Q5sLNQGjcE0T63TNO/IRtkgATjCLFJfh2+QWDe9vox1KNLPzVTP/Hhsa+kPOeXcqGyuXeAKjW23KWEeuOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056235; c=relaxed/simple;
	bh=O2urNwezq+xlf20ha+8K89JWEtLLzHRJzsxus4dP+SQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q2GRsAA/+Rbmq6NAYJWUvaF39oOcSDwDFqgITCXahRopMiZe+D+tcg61ojfLck9k8nrgfcKozh35DHYcfPGTHghtmns1qnBMIE74VBOvte9W4pYsz4WHH2TPjIRqosXXJNFXYNg1c1xf+oGjZGO191l0nATV6xoCQN1XLCQuSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHyiujwo; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHyiujwo"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cfc1aced74so1178432385a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775056233; x=1775661033; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AtxE/85WwzlBstdz1zX4DCRGs3T86haQNHiEi28IeaI=;
        b=JHyiujwoYwOOyYcYyUtrpBBAEOW5+FvAhsNyWjh6C5GYlWvguY79qgnuGge+9fcrPN
         BGdWCKQoLK8zdjlR95HuWmVSNTUjnH6u/xGsoQvwLFTQnm5f3uabUVp17YCSlk2xrxI4
         wLlm5Gp4MXEIGiCy85XZWldTOGA1OXzWnGM8EQmOMrwP6UI360tXWzj4kouC0vu90Dpz
         /S4vvzyD4Ah0SfDpbJ7qe3Ocdoe3RT2dcIvjwCALZRms61snmsCUUC1dx/JhNEAmycuY
         r4sgFnct24q+WlMUHV2nlw7UjtXaqMEY3pqZDWs1/Xn6ufVhjx+Zkd0qd/+hHwLvqq5l
         +Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775056233; x=1775661033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtxE/85WwzlBstdz1zX4DCRGs3T86haQNHiEi28IeaI=;
        b=hFdRaBChItpp7lN3g3kJQlZY68HPtgn7RjiuIKczyqOdiqVt2aGFlzipP4UDPDAtAV
         1/THFEz0frdgY/RchD2Q3zK8SYIFQn3IhtNg2xIQaoqn0EsmGVV0T/nwtEcu/QE9T4lQ
         HAWOZvM5yPIuLosFGxnRfa8feGLjbCqRmwxDDg4J7d7jVVm3b6OH7lCu6ccnCeUOXGzH
         LVaJTMUsWySyT9sbWV1Fhi29lf51DUoZ/MZezB7kt9LTuuH0mArLYg0+nnGEfjHISZpg
         g/iNVzVAJKhEbe/j6RnUirhSN+8ldTu/2OSRpxC1IH4rvhXPPPbID59kbB/jLPXrZ8+u
         dtrw==
X-Gm-Message-State: AOJu0YygrLhiS7UCm5/9gOamDk2b4w0YoNBAACn9fIKiOHNrxCBmqdnx
	R1EcH9hAP64Yy3weRhuaGY8n2bY4u6+KEg1//jYNndwzfXFETbs2VDJthg9uiw==
X-Gm-Gg: ATEYQzwYrbBRXQJ6I4qdEY4AaWP6KPRjqzx4avy52DJo+f0s3U50ClmIh76RHy3+0mJ
	cB97cJL0lNKNaEaHZ1ufQ/HwP01sZM2ibMVuXrFGo+caBopPEN2C53CNbmhODoiUEMCd52WiR8D
	cvgdHXhn6dzlBXu3AuecPttmzYuTkLbBoJBKSqa0ZSoIq72xlk6Vg+hocfAtif7RkfRfek6g6iA
	6TXfQFFNqy/79MHlgLLpBNZmOnydzxJMSqWSEXlm9MkPx50JwO0VSWDW4CllvBwLDQj3NES9eAC
	/1o+u6VBGQaNIDWmmbRQbtpLy9RQ486yTQUlAqHDida0bQBzpka2yT+DxHm/BDVEq+V1qgEbKuW
	GwiVfc70vRyR3hpi8/YAx1k3tks5fnw4FctROcCgsTFj0cM7fisYH45AnmBs/tBVYtWTqJqtjVQ
	r8mJsHYAxiII/VCCrjO2ZdQt/rKXv5
X-Received: by 2002:a05:620a:2916:b0:8ca:3c67:8925 with SMTP id af79cd13be357-8d1b5c0ac33mr634421685a.64.1775056232703;
        Wed, 01 Apr 2026 08:10:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028095f1csm1296580085a.47.2026.04.01.08.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 08:10:32 -0700 (PDT)
Message-ID: <69cd3568.050a0220.25ea36.f99c@mx.google.com>
Date: Wed, 01 Apr 2026 08:10:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6171160957909108290=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, keenanat2000@gmail.com
Subject: RE: [v2] Bluetooth: MGMT: validate mesh send advertising payload length
In-Reply-To: <20260401142532.332943-1-keenanat2000@gmail.com>
References: <20260401142532.332943-1-keenanat2000@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6171160957909108290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075891

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.00 seconds
CheckAllWarning               PASS      28.47 seconds
CheckSparse                   PASS      27.98 seconds
BuildKernel32                 PASS      25.31 seconds
TestRunnerSetup               PASS      569.07 seconds
TestRunner_l2cap-tester       PASS      27.62 seconds
TestRunner_iso-tester         PASS      43.34 seconds
TestRunner_bnep-tester        PASS      6.31 seconds
TestRunner_mgmt-tester        FAIL      120.35 seconds
TestRunner_rfcomm-tester      PASS      9.42 seconds
TestRunner_sco-tester         FAIL      14.24 seconds
TestRunner_ioctl-tester       PASS      10.18 seconds
TestRunner_mesh-tester        FAIL      12.49 seconds
TestRunner_smp-tester         PASS      8.65 seconds
TestRunner_userchan-tester    PASS      6.75 seconds
IncrementalBuild              PENDING   1.07 seconds

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
Read Exp Feature - Success                           Failed       0.112 seconds
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
Mesh - Send cancel - 1                               Timed out    2.736 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6171160957909108290==--
