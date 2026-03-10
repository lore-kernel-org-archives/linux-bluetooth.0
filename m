Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657DA40DFD6
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 22:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182631; cv=none; b=nKY6Lt0D7A9t5UTPUUGhViytaxx8DHrcfAyDu12fX/d4vXpV3GmluCL5Pu77X5wlrk1ueeCuPZR4E8tICLwSp82MLxKIMFrzIX5ZEYrCYrhzgx60EoaDPxsPCGoKNHfa4fDvEMdrmWSLmc9bdUos3avFFiy5uq1gyEtOuRI6EPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182631; c=relaxed/simple;
	bh=IdbMuJE+Yufo86V35c4S8HGUo/CK3Wf0W8q0M3DNc0o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S2DOF+D7sLsjkQXcnMddimiZOtYaqtmTH/Q4zcv8bVrItjPQwLPIeeQKLMTVbEzAPtWPnKYLPWRCvsw9YBgKrNZeaF77ND4XpyKk3JTXK/4Z28SAWNG+aNfn5ctiRdLWwC6QK4mSq2ef5El+tRGHUaKV13ra9COKzYXfXJsM8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9CIaeoF; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9CIaeoF"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50915e14cf6so24364801cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 15:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773182629; x=1773787429; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dB9+Tl2fK1+VY3+LTKWO4F9AO8ZmeZNytr0TjrsI/o8=;
        b=j9CIaeoFtjvzElhQSfjDRYE0b0UB45RSAJkoyJ4WgxmKmKaEBR1H6j2PltCwWDLP5M
         PvsV2pbSGj8qTBM9utdJYNySEdkoEFmB4WomYJtI3GPomhSkD3wcBObzYXjevwHvoMY6
         SYTvS073huJqNDvSOBD8WwmhOXrlv01l9EvMCprz2Q4tpCaqTc8Po0knCgCHazLZmjYS
         kjvq3P/XspgHRQDsvOjhU6/QQAVu7LwzDle0DZeeqj4BVquHlRsjm5z9YMW0rgnVTr4f
         42gVFoxasUAf1KF6BQmJxsOMVdylQ++BPykYWI81WLUu5g3H1a96x7aPa+mN4+8W9SPW
         ZIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773182629; x=1773787429;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dB9+Tl2fK1+VY3+LTKWO4F9AO8ZmeZNytr0TjrsI/o8=;
        b=XkQTkzPqqLYgfCzBEh1TUAAnJ2FMS6HpGAdBpEjQiI6s1x1I97n8uNgMQzaakvgd5C
         h/driQ6w1gP7XN5zGw4aeuWhGwas8cbzrPZAExryxDEH/5qG7VH0i5fXky+oN/KPQ32Z
         WjWXgZbHk+JjJRtzWio2AgansEgpcMHKaFNWf8HxQi6QH3eQLbsYoj0Prl2f21A5sgoN
         k7Pw2j6wzVCqOuNbbZcSlzX8ss+pqT2uNnP3+3pysbyIvJNoVFuIncPdWrhXO4RvZDTt
         dphAQFY1sQw6w96IvVoTMQJ/xtB7PfN1COUygX8+X7I5GBjtm8+HdbBMuO3Wef79iUQM
         dilA==
X-Gm-Message-State: AOJu0YzXgqeTWZWCFniGJ5nCEG26xGVKuWtKtfoO7yJ/+upPoF5s/Qmi
	w3jtkHpJ1DjYEKI8o6FvJ2Howzq7DBEGKF7nwa24+XuuhqmBL1ccEtdrS2VZsg==
X-Gm-Gg: ATEYQzy96aOQ7j+sntCsNM+uhfC2QPYKU8f1djKp/nnkU7KXVnKh6JxtceVcXEgpTkW
	0VgglUoXYf5DL2cNBuptIZxSuDjADIJxWDU4eoto7mfsvBPXyuCWxNKIQqm8+Knm9MRcGUYOFsX
	Iz9kx59sGAZ5caNKsycoGj8MpjMvNd/N4+c1UdqJ4llUi+Kzt6cTBB4nSq+lArDHmASwK+ruTIG
	D77c2rN7sOCc9/qiJRQb6pvwTupzXEz2yJGl0M6zqFjVKB+ah5CNZc1xXDvXQn0kNuqLD7QGq1t
	H/kBJkAUf1m4CFvFP3tS4hhOYdQS2hB9DmoWo6s20whBoOjS4yymDgkKPIjy0tmEsTGZeQes/G6
	94ddPgRpIDyi6hGjxkqp/1EAh41b7HLv0O3ZkLrCCHE9iZBnqV4MPMBeNTTy31yAuPsR5OJX4C5
	h5I+gGbL0LAqveQVQaLcESk0YpuxG0NA==
X-Received: by 2002:ac8:7e85:0:b0:509:820:58d7 with SMTP id d75a77b69052e-5093a19d504mr5035331cf.52.1773182628975;
        Tue, 10 Mar 2026 15:43:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.223.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a116484sm1847021cf.25.2026.03.10.15.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 15:43:48 -0700 (PDT)
Message-ID: <69b09ea4.c80a0220.3b638b.865b@mx.google.com>
Date: Tue, 10 Mar 2026 15:43:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6963172283867747300=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, research@johannes-moeller.dev
Subject: RE: [1/2] Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
In-Reply-To: <20260310215947.35756-1-research@johannes-moeller.dev>
References: <20260310215947.35756-1-research@johannes-moeller.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6963172283867747300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1064667

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      23.53 seconds
CheckAllWarning               PASS      25.59 seconds
CheckSparse                   WARNING   28.86 seconds
BuildKernel32                 PASS      25.94 seconds
TestRunnerSetup               PASS      510.44 seconds
TestRunner_l2cap-tester       PASS      28.69 seconds
TestRunner_iso-tester         PASS      71.54 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        FAIL      116.08 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.38 seconds
TestRunner_ioctl-tester       PASS      10.47 seconds
TestRunner_mesh-tester        FAIL      11.41 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.71 seconds
IncrementalBuild              PENDING   0.74 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/l2cap_core.c:7790:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7791:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7793:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7794:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7790:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7791:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7793:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7794:1: error: bad constant expression
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
Mesh - Send cancel - 1                               Timed out    1.931 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6963172283867747300==--
