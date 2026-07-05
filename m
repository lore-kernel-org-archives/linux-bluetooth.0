Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6008184
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783209872; cv=none; b=i6xXUoOUgpvGScvcj/gNdeTjg/v7V2p/Vs6N+E9m6x2djtZtahoApRw4B3h2Uk8sfORinSPRtLKsmXTx2qFan6//9FJecksS6W+acDXhXgIpziZ079HHCbT5sWMDgKlfnXEoVJIHGFfGb96JulspVedmCUcJeqXE99NRXNkyAcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783209872; c=relaxed/simple;
	bh=PdgLfzlE7y7tjcQAQNVmbckUaXBERzvZhfxO3xffUxs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ADiZnhMA7nCqeM4KIiWwwASvCIFHeJ3tVX+Nro/jzedBBoN8wfE3yp9Q0u00JZVUuCaUEemGyGGiR75AmRAy7nFpgNjOm0kg+S81znR2949n2+LSSZDZbJJPIcGhOgAwoxw4fLqFLIVDVuD6Ov7BI5Pi2NUVbdtkuPDxmG+gz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0+EmkYO; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0+EmkYO"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8efec2c28f8so10598506d6.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Jul 2026 17:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783209870; x=1783814670; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qb7EH9qC4fCP75AtlPKGY26I3CRaLJXW1Mc7xJEGmJo=;
        b=A0+EmkYOPQiCxDz0woyHgI12GJLbgAElHy4R9w8sKI26QQ2fXGFYW35CTIN1+paPF6
         YeRmv8Bjrjd2GcwTteuQ8bjqvOfcOzLMAVEzm9Z+CXWUskyqrIGzmSsPk2mtEgTNCRcu
         tSNHxUn1zgOUSGSLQsbmzpQxXrR46ahl8seYATJAGkQ96yvpKbK4tZrxLsiYWBvGU/c7
         Bl3BVJpbmb/ybaXL9LW3uTen7aGo/AUqdurmVuC/9qP9FmWRhkJkNXLl5D5faRBQrmCg
         xA91LQhtpZFw2o+/+/GkPYhntsCOg3feMHyyJglm6MQHKvqGdrllMLC5Ki10texGfKgp
         O0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783209870; x=1783814670;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qb7EH9qC4fCP75AtlPKGY26I3CRaLJXW1Mc7xJEGmJo=;
        b=JU7Q1BcIpbkSeA07wn3Jf+27PHCwxV38L3WDduz4SBogjscslUz762+G47FNOoEp5P
         n6BVhy9EcZTJloxjTpyuXsC94cgRKQ6/Kn5VbNz2CbBGBDtY6zuoZgGDhpFZryqHnkVR
         AQXHgV+Pz/eG0yfXwQID1rRfzVjnsfgsg1n6S1sJkR5pkPo5y5N/23ezYvSzTbdi2/MC
         DxQXZOFcqWj0EGoNpQWaxNuWJd2OMB2f956YxTdKGMUEBwUUAqaNdER8f6r179odjKUf
         jZ9tenM+M7Uu1NhfvgKaeaRbmhvwRtARqZp4vIvJsyy92EfmioaLAwNFUxjDY8Wo7ToI
         uq7A==
X-Gm-Message-State: AOJu0YywFZcGZrzCHLEBw87x1oGiGVj4ddgVxuWWvdz9IoHqce3Ft1Mu
	hY7NcFOAFFBOWZeFyG+MBRwJwUKGmzzc/kSICU+X8qeE2XByEoLI33J0nt+s6g==
X-Gm-Gg: AfdE7ckLKudnoSPU1TtzMOK4vXytabE54b0ZSK0vuGry5yL7yi+onFEitvIP5o7nl1Z
	OvjEsEt6nBPhgygUdgSVYR/JJcHYFVHGlJ7m0JIl8/TGO5NWXD5dO7LAi82RKBnvEC3bbASEyWJ
	TlFy1Gb7TZUDYNNAAkKvSF++aQ35CMoWMc3qQfGJ8Rvjn6Rko48cq9clNZATkyqucAsB9UNqNe1
	ehNRiLrVb2fnJt1RrwWkL6X87/JGf1wF0+VxcXUZ331c6TCuCNORUVzizc12y7B8VjuvCluctjs
	to22krqWovNpvFRIenatL/jl0SpeOuTcuwNIxkUOJnRa+EPmYsB3WiKHcSkXWh3Zkg/hxCpAW44
	djqs17Q4pBSN0ug7da1dHjJJQigTZY4cTzuucCM51QRCemlrs89hIBJ85xyoKb5qT9mEFzTmpBT
	Dq7wt+bbSpCd2HqJ0Mog==
X-Received: by 2002:a05:6214:328f:b0:8ef:76c:cb18 with SMTP id 6a1803df08f44-8f74a41ffd5mr81401416d6.11.1783209869707;
        Sat, 04 Jul 2026 17:04:29 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.158.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e27d137sm93759986d6.9.2026.07.04.17.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 17:04:29 -0700 (PDT)
Message-ID: <6a499f8d.36695ec4.2a7238.abf1@mx.google.com>
Date: Sat, 04 Jul 2026 17:04:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1650776807269233517=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xmei5@asu.edu
Subject: RE: Bluetooth: qca: fix NVM tag length underflow in TLV parser
In-Reply-To: <20260704231030.996390-1-xmei5@asu.edu>
References: <20260704231030.996390-1-xmei5@asu.edu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1650776807269233517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1121634

---Test result---

Test Summary:
CheckPatch                    FAIL      0.72 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.03 seconds
CheckAllWarning               PASS      30.07 seconds
CheckSparse                   PASS      28.11 seconds
BuildKernel32                 PASS      26.15 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      496.12 seconds
IncrementalBuild              PASS      30.35 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: qca: fix NVM tag length underflow in TLV parser
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#108: 
vmalloc'd firmware buffer (and the EDL_TAG_ID_* handlers can write past it).

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#133: 
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8

total: 0 errors, 2 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14664142.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: qca: fix NVM tag length underflow in TLV parser

15: B1 Line exceeds max length (99>80): "  BUG: KASAN: vmalloc-out-of-bounds in qca_download_firmware.isra.0 (drivers/bluetooth/btqca.c:421)"
21: B1 Line exceeds max length (93>80): "   qca_download_firmware.isra.0 (drivers/bluetooth/btqca.c:421 drivers/bluetooth/btqca.c:617)"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/396

---
Regards,
Linux Bluetooth


--===============1650776807269233517==--
