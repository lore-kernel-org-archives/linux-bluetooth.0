Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622B8472
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714144; cv=none; b=Tob+wHJP6UzsOrjFTzHXqqfMTvMHEbL9lC5o1G/JnmUeSv/EXzexgdDO54s3CaaMUydg+XDxLynC5+N+ogqObJOPt59FepoS4CC1eYPVhhIj/zHtFeJZy91IQ1saeTsmoTsZEL9Hftr9BK+CVKWsXkEPhDXDLuHxgf2I0gq69tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714144; c=relaxed/simple;
	bh=9Yg2oXlgy9KuAiFWHIdleQCwLf9T7UpSBmIJT/LL5ds=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ji8/A7tNiPcSjdpa4sCivirhSBdxLhjh3I3G4fOeKR5pzsDIS+pwwQ7VxPj3pPQkcNlgn/oxU/2gUn20GKk3wim8eQ+gO66ivqSjBeR6uW+31pcHjH2EdErW0497JTMN5o5PIP1MMMDGKLBvUiGPzzpviwWL62bRukFM8kt0O8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akxF47rz; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akxF47rz"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66fc2844f0eso2610437d50.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Sep 2026 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788714142; x=1789318942; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Pq22zrNCIPqdi5sxSqDeIHLLk3NfbxN/5T2dhSYb3yQ=;
        b=akxF47rzWqhAs5g2hNjWaeY+ZEfjekr7d+tw+cxSgXn2yYtR/yvq+FGihd37l7hYE1
         79/NvC/IsO9PAOiWaNXWk2lmJr/XW63hD2C5pwwj3tNNyAWxSugHytD4HDtonT0NFN0h
         LClswQTpfo6+gvV56qG98akJNXwgTBSho3GAuLFJnmHaKtxaj3nI0/CmuD6o6dBWWiS8
         c/Gj5B6vjoqem69LcVs2Qh13RRd648nmNV3Z4PaKexzRQAIHqved7hIxiSnqeWkp6A4W
         q1y7ilVq3oqOCxaEPosa8HChzK/b2PxFIsIpRN/83e5biJxrevxewmrgS6hBhzUtB5+P
         XVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788714142; x=1789318942;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pq22zrNCIPqdi5sxSqDeIHLLk3NfbxN/5T2dhSYb3yQ=;
        b=HP9lMCj8rgRJfPKyOl35M20+nnkctRwD/DOfi1ukkPTWnRvMOdVOOuHZcD2/PuLNiW
         ntyMnddc4/pyiYmLccRYOjRLCXrob7KlBCiuwdXzKBM94qoKqFOsfT+VUv/pz1cHXwEU
         mIsE5TvLyLiu9bNJ9p+0zWpTcKqf3j6Cmyk6xRw10VQ2QWv0Npo/CLSBhsfCfDp1VX5e
         psktf2xNJEnHC8YvLPYY213QiDl2UgW2AmZbxjToSAuY2vTO2enMI+5fVZwP17kdATA2
         ysn8gHudKQ1WROm9qrYba474wBbAYn/+nFLguvWH4HL1hGVa1Z7PTRHY4fBoH6CHGS2Y
         JjkQ==
X-Gm-Message-State: AFuF++k9EK4rQf8/GdNzcBwzUa2bXGjTn0L+hGb/fuPKwqUzWn30dGk9
	DKdxXqgmJ6oUgK5D7r6S8YUlF2/QkEdJdxuMCWohiVeLhVA0yEnwxclb0vuJnQ==
X-Gm-Gg: AYBFou0pp9n4NB8uHFOsN7RcMLX+0fKEdEFPFZyHN9wQSyBWDP5b3r7TZAXYypztR1Y
	ikAmTPBBp98vHpz5Lk62OtEVnX8oGiS+SSXFmE6SEHkDZEUBrTDnBsEjkVl7TSsz/LFsatWidRD
	j3+Lf6HEU6xpmiDhclsjbyQ6BlvGvjcIpJNutxuR/v91pTqUKhONW7obyUxqdUnHIhpHZ0n3Rer
	G9wm3fG+e/7PlTWzTNLy8scY3/C2APuyf09jH6XAVHWn0l3Ku7srDzaE6Y+/xBQussATEg0CrKA
	MQs/7ZY1i6tCITWeRogdrDuRJUSCBSLPrQxvkKhy+4X3zWXYQhmIkIdCtRWtrxvSvSpyOffW2nx
	Is4NAFXwY3pD8j5W0JiycPa4/R7WzTr1BwQD+Be7sIw1jeqYIT8sfqOXJc9o99y1M9z4iJgW5W6
	I2S5IPltnd3KpAK9B9Ezk8C81dR4GawNkRLAH8Y3p/NmhyQ3K5cKsIBMmXqmxq9p0vj1F+fKz90
	MVU3Q==
X-Received: by 2002:a05:690e:1207:b0:66e:564b:c4e9 with SMTP id 956f58d0204a3-66fb591ec36mr5379985d50.6.1788714142161;
        Sun, 06 Sep 2026 10:02:22 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.169.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040595f81sm72360576d6.2.2026.09.06.10.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:02:21 -0700 (PDT)
Message-ID: <6a9d9c9d.f8a8063e.18a22.cf37@mx.google.com>
Date: Sun, 06 Sep 2026 10:02:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3281254743340712671=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bestswngs@gmail.com
Subject: RE: [v3] Bluetooth: coredump: Quiesce dump work on unregister
In-Reply-To: <20260906154332.763402-1-bestswngs@gmail.com>
References: <20260906154332.763402-1-bestswngs@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3281254743340712671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1159097

---Test result---

Test Summary:
CheckPatch                    FAIL      1.23 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.18 seconds
CheckAllWarning               PASS      30.72 seconds
CheckSparse                   PASS      29.40 seconds
BuildKernel32                 PASS      26.96 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      506.11 seconds
TestRunner_l2cap-tester       PASS      65.94 seconds
TestRunner_iso-tester         PASS      105.72 seconds
TestRunner_bnep-tester        PASS      19.19 seconds
TestRunner_mgmt-tester        FAIL      223.27 seconds
TestRunner_rfcomm-tester      PASS      25.81 seconds
TestRunner_sco-tester         PASS      32.26 seconds
TestRunner_ioctl-tester       PASS      26.88 seconds
TestRunner_mesh-tester        FAIL      25.95 seconds
TestRunner_smp-tester         PASS      23.57 seconds
TestRunner_userchan-tester    PASS      19.89 seconds
TestRunner_6lowpan-tester     PASS      23.18 seconds
IncrementalBuild              PASS      26.22 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: coredump: Quiesce dump work on unregister
WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#130: 
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: OpenAI Codex:gpt-5

WARNING: Assisted-by expects 'AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]' format
#131: 
Assisted-by: OpenAI Codex:gpt-5

total: 0 errors, 2 warnings, 0 checks, 128 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14794291.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.249 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.249 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds


https://github.com/bluez/bluetooth-next/pull/712

---
Regards,
Linux Bluetooth


--===============3281254743340712671==--
