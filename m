Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568AC3009F1
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016220; cv=none; b=bCOu1cgtnDkEBN5XbRzC5hEsFlFc0SoSTA8H36nHr2x3YLSZunHT2ZYg/WzgQDn0mA5Hcdak8ixVsKms02SxLkMt+z18MwPY79uaMxmm+CTC+7uRpwGy/3N7T+uTIIB7XRgW8uAf1DCsdZLIo3D7h5hEwqEIE3BxhPsmujGrTCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016220; c=relaxed/simple;
	bh=OsQTqYYVM4WAr4cHCDUgFumszytYTe1y+LzB9QlbltU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oD1LpXGNHz7QpU5QK9rwlQT5MyAxSEVg+OK/14rpcf+yuHARIGrXqtFgoIBUASriL8TzPzu7wd80d08d3g1jfwtM2KFN/40ldIH9vcuBDO3U+GjkaGmJHZ/BY2DIF42FTGgU3J1A42eEx56QJnn/Iyrzh+sXSfUlt28V8eTafMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df1VpoWn; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df1VpoWn"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88059c28da1so4823716d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 22:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763016218; x=1763621018; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dOUYMCmuAn2uH5jGCBFpeUZ7eqOKFDZHCDhCT2PToHE=;
        b=df1VpoWnh3aV3icjFy5gRgO/fzYeissZIcfpyrRET4ZGvgmw4XDMI0vcLTzBLpLa6T
         isqqbBF9Dy9htghNLvd6cfekawjSckbt/IG4RplQmVgP0C1Mn0RD+0lxeLNtvAUxrzKE
         cShjgEqtOm5a/M39C2Mywb39FzqQpLJGv960MNDv4xZZqgc+fPvqjKP53ctMzmy52KWL
         ne+IB2vdCEgKzclYuk8nx0mFQMcFEOHQEa/IVMwdrKWSSvs2awrSNrlPj+dlGpRbnyda
         wE7rWyuXDuMdGzkWPveDNOYlM06/1GjxxOL37N+DnIlTeh5K1TyZvkS8GEbqZYCGf/+z
         W7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763016218; x=1763621018;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOUYMCmuAn2uH5jGCBFpeUZ7eqOKFDZHCDhCT2PToHE=;
        b=IRlfLfEal45jMc+ceVHQc9SU2IB2ahOD0nd51B6jar3Pd2H24nDMAm52asyf/CcFZJ
         jlQQ47cSWaCC01gk0acW+C1hY4EtxAH8V+GEy3RSt11WaNApoMjxWwbV0XA3fr50gIxW
         hbSWaLe2mJugZ0jx9EybsCIJNuMT0T7h8dUbWJTAjvjO5mjqQvs9hTd8yy+Y3Y53pE0N
         kJeODUg0gzs6EDA3w49thLLzl7wiftgO4eUDgG2Njs2ip0j0Juk98cDdjTz2p3TvcjAF
         9ZNQ7VUI6EVjjLoP2n5LABUzcGobMlVpTc2yHDi9+R3RFyQMmHRVOQUqGEiSOlX47plF
         /Y+Q==
X-Gm-Message-State: AOJu0YxSRzR9vhBIYFt4O8vedC1IjCizkWI1kfe2fndhgk7DZ6VlwEaw
	dehU4q695PlAes5rYsXbv9FoaIqJEfWejVMddOy8c9uc56hQLMCpg7FgBTtGIg==
X-Gm-Gg: ASbGncuvBaiqEDfdAmg12tMhwWT1uw4VCb+MFIEqas6QfwHmJKLeUKzh6/4h23dxLki
	SfZJEOtQA5mAhn49d/PjTIO6W+Jx2opbTH6AWQJDqC+9YzzAph6N3ID9GYxiWktVrtWzLacm8WQ
	0Lw8pTqrlvArEHZzTPSoddZAjZOFL1nZiD8rZnRfAkwDRAzWmAbNlyLG/7WUgAwUn4rlKMV+Kqk
	gp2/nzPocWMXVL/blPtY/yvpvtpEniwByU+J/yf1eR87ZVpaYMsAQvtIzgdruOF/mzOKlfLQARD
	rH/Xy8wsTt5GIvPiMprzEV3ifFBYEN9KE0loSBAmM1mSfrgVWC2pdlA8+kqSgMgkxCpKZbd3Jbp
	koPWXUntSzbnolPTa/J5WKvlWZOdG3pU4q2/JoUvsId+H8/In/kI8H5XoZaFTxeYH/jsCesC25S
	HQ5dgCEjEkxjTFBi5oxWM=
X-Google-Smtp-Source: AGHT+IEKOqQ6E6JQutF/ovzTbGD7/fW2SqQwdDA0Ee2Upd+J7TVbTQkPySs1JYdJq0xeWys+R9Tfmg==
X-Received: by 2002:a05:6214:c4b:b0:87d:e32:81c4 with SMTP id 6a1803df08f44-88271a0d94amr91181996d6.48.1763016217831;
        Wed, 12 Nov 2025 22:43:37 -0800 (PST)
Received: from [172.17.0.2] ([135.119.238.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882865cff46sm6506116d6.57.2025.11.12.22.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:43:37 -0800 (PST)
Message-ID: <69157e19.050a0220.14e75e.1211@mx.google.com>
Date: Wed, 12 Nov 2025 22:43:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2160093643053671767=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 13875017792@163.com
Subject: RE: [v2,1/2] Bluetooth: Remove unused hcon->remote_id
In-Reply-To: <20251113061028.114218-1-13875017792@163.com>
References: <20251113061028.114218-1-13875017792@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2160093643053671767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1022795

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.38 seconds
CheckAllWarning               PASS      27.59 seconds
CheckSparse                   PASS      30.99 seconds
BuildKernel32                 PASS      25.10 seconds
TestRunnerSetup               PASS      499.35 seconds
TestRunner_l2cap-tester       PASS      23.83 seconds
TestRunner_iso-tester         PASS      58.80 seconds
TestRunner_bnep-tester        PASS      6.14 seconds
TestRunner_mgmt-tester        FAIL      115.08 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         PASS      14.59 seconds
TestRunner_ioctl-tester       PASS      10.10 seconds
TestRunner_mesh-tester        FAIL      11.46 seconds
TestRunner_smp-tester         PASS      9.57 seconds
TestRunner_userchan-tester    PASS      7.25 seconds
IncrementalBuild              PENDING   0.55 seconds

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
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.099 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.946 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2160093643053671767==--
