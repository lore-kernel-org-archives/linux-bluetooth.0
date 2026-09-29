Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADF447043E
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665149; cv=none; b=OEMGB1e0FiUpqzlZKU8mvjAq0IeWQ5cJ1hAEowAGPKo2nNjX5bhPpW9DoUsy6uDTzUAvIbEw3cSe5+u6R9b7QEdgLA86fjpfZoiCThiF8wG1difipGnOJaEoe482woWUk9tqWqwjJPAmEIUHMrBete2eU6nUVaRdeYldVfrwtDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665149; c=relaxed/simple;
	bh=BXA8VF8ZkVXD+yceC+8y8pm7YzhoyOJ5LrwevgDrbuc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P+9sVzMlZKxDNeqnuJvpdve+vRI+SXWu21F8WZdAsacgHLoy64mCR252hxLLjw+0BfeYweDTOYoUMSaFggfpxJfHDOLlYPNOd6+cgZ/MDoL6O45eDQdBtWavsa8F1z2b8CtN/lKwTWUkB2R+ALkNQv56aTXpT8KsQu6+qgJ7z20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7ITf98M; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7ITf98M"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d5303884so2697469eec.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790665148; x=1791269948; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GPvuKApJB9KwaDNkCcSbrQPEOwJD/X5v7PYMkvjRbjU=;
        b=k7ITf98MnJpEXQQbM0d06LCMGRkcHFErU9VeWjYn5vPN40sIxs5cDgSmKq7jcO7Uxh
         h8/3uZXaCPwWNlczMuSklvVQ7+JjCa4WGjy+VsovwcCzJoctwRF1VlxMKX5d3EXH9UIl
         PFPPzZEbjfps7mxgz7Qu6KMrSrcQs8uWyHTVYr6kx6nYAnwpla0kg4TPq6VXoaZDthsh
         eV1e5APiY+MwhDqtDw8dwyPfCTHXlSc1NGo/cUkNHjQKKGaj5VePjZ5yt9Drvam7rmmH
         w3QR7zwIF23EWnUwDqTANb8fY9Pd1qLoQ59mqC0KDvaEOJ4BT134SMXHb2P5Tz7JvTGl
         HFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790665148; x=1791269948;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GPvuKApJB9KwaDNkCcSbrQPEOwJD/X5v7PYMkvjRbjU=;
        b=R5sQaKQbpGd3BCatvUVO+OFTDfrzoes3TBbFarr+mNgYpkJsxtuqo/ORleqYBP+DA3
         zpx9/mDg4NfWCSrI/JEDncDFqcj98lPRtmlqyDExEUySOPAo+sL6KQ/CwR+evndXB1rB
         gYbDlrWNpJsRqhy0LYZzoG+yyhOwgT9suchiVrBo9euytBZKR6FGJtjGEy7DbaD++LVh
         wHkXE3ZvRp86qE60voqirMS2qE9ZCNuJx1N1vhpMEzR4yfGXZ1qLpVFfr9U3sszT98To
         XgMn/kkc3fyTiCnlE5qq+xGiCRwccau+GB5PhbURKqZItw9zVFWOg/Lp9Ax5qZvaLJf8
         Hacw==
X-Gm-Message-State: AFq9FYKD51PQrAT5A+YO7iGAp6dhOM87aSglcRAOn2jwxnPzE9BNbAlS
	V0Ovx8AcwrE3dfLOOupLaG05cl05j8I9/dxmSVZReBTOhWmZd2qGcfHYdNiOdzFjb1Y=
X-Gm-Gg: AYBFou1Pz1u1oVVBnPSgyJHqke7kHV8kDenBv/2xY893x0+ar48a60Af7YMtSC1DXC6
	TNhaez/u5EFZNsS//u0B6BNzfnFDUjwYcBzqWBXtlUUTnOZsHy26dfKwFBJRWRK7J8qqA+nQrXA
	Ix9tAhaQt1uXRyBhNZAwMLRklPck5pWeYXZABbpIUcapQ3Vb3/HMqx037U4xpjEgJUHOzgfvyk0
	3vCElNRIPOjuQyCjDGMJQ4v0LAArTNZ0ZUPnt7r/nnKbFypVoNndnL70UTCKMucIu+QeMU1cqiV
	R6K+zhpQYLonLgU1C55twc7jtJ8yhzTXkMSuDq61eq5mC++tEynMuha1RoFn4Bt/tn2iOWvicL5
	AZZalYZu/jgezyp0/dWpBcdznvaLdPmCAv3rd04ea8QN9r93C+y7uD3ZYTpvHLx8zwzyVm94DRv
	UDQZU0fic2p1X+B65uOF0VQ6f0536a92OsSgaosWY8+m9r/bjMaQl0bwCwdSzVb3+VqtEQCBdnt
	35f
X-Received: by 2002:a05:693c:8014:b0:343:f791:1d84 with SMTP id 5a478bee46e88-343f7912e95mr8870944eec.37.1790665147490;
        Mon, 28 Sep 2026 23:59:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.56.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341463ec3ecsm34058798eec.31.2026.09.28.23.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 23:59:07 -0700 (PDT)
Message-ID: <6abb61bb.c21e2895.11c874.9a68@mx.google.com>
Date: Mon, 28 Sep 2026 23:59:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5511248439726836025=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel: load unlocker.sfi to allow unsigned firmware
In-Reply-To: <20260929021056.1396791-1-kiran.k@intel.com>
References: <20260929021056.1396791-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5511248439726836025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1175689/

---Test result---

Test Summary:
CheckPatch                    PASS      0.86 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      29.10 seconds
CheckAllWarning               PASS      33.15 seconds
CheckSparse                   PASS      35.38 seconds
BuildKernel32                 PASS      29.08 seconds
CheckKernelLLVM               PASS      36.56 seconds
TestRunnerSetup               PASS      715.39 seconds
IncrementalBuild              PASS      26.55 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btintel: load unlocker.sfi to allow unsigned firmware

35: B1 Line exceeds max length (82>80): "[  414.150089] Bluetooth: hci0: Firmware timestamp 2026.39 buildtype 3 build 86921"


https://github.com/bluez/bluetooth-next/pull/835

---
Regards,
Linux Bluetooth


--===============5511248439726836025==--
