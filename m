Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787767;
	b=MVTsanZi9we+WtTerQmkONQiw3DzWMVNpRhb9n+nxr2hML9fA43LpYDwCaYntCSdOoOK
	 RaKW9fNSG/oXL9ePkpNoAU3mdufePOWddKL7wa3lEAPaUJALnRKFG/esYv5IKMg0BYyB3
	 fOnOwOPQuyqJbPk5BKpvmpaEVnC9d6o7FLombAEgZ8LReKEY5DMPUGDgl5rls+pq7v8fU
	 CbarTjds/EM1zFMBZRt0j+RokI56KJJnOHHp7JDLKfI54Z3+XJT8jteVNorzNpQOi9Yib
	 i/a7RwLfh2XAalaKA6UMPKguAIyafgGZm2trsGfIB5PWZEwcS5zfRcWxVyGWSR6ZjsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Jc67n1A66KDVhkCDP9mMXrkfPsJnF2d/z0nJmFfrZQQ=;
	b=lB8B5oTA+ie/hyhx8Dep4AwFdGliY2IC4mWUk8+QM/8ypb/wMm4xlRm375ViT3wm+v7A
	 Bm+LiWUB+pEgc12GQJ0YjKQlre9ExFghiFpj25KF25uw/SFXtKhIeTuuxebZeHMwom9af
	 MkkR7JXpDJ7LPulxD2qTVSDjCI7J0FHecpDvqVNHkPuxVPYZU7cVCeNSW67LSZL/8ResE
	 raSMDmIv2mffqONtRJ0Fis+azOCzByXkSoT2YzNa8WJGSZcLLH1atbudicdTRKlMmB1Fn
	 Vadj1KAtVD8kfjvP0ZDcwyGbFENT8c4ad4l646wLNWg//+75irn1Vjg8pDfu5uNWUxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gsx7tRFI;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A9606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 13:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F9A9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gsx7tRFI
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso4718211a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 05:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795787767; x=1796392567; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jc67n1A66KDVhkCDP9mMXrkfPsJnF2d/z0nJmFfrZQQ=;
        b=Gsx7tRFIeKzvxzZbdJpfX/jCgJFvY/8jICC5rO8820ysayQ/m2J/VEy3U9uRdAxrlG
         E4UVFswGxhLEP2umSaianBkboi31Fqwp3hqmw/5FgmkowDrJ9L/KUDmTR5gbHTP9sTpw
         xyqMIGmOQR62i5LVFfKfXq0obuzghVg11hxgmGk5d8bomLEW5LT6NFHD/kLTSnvWgEcw
         UK9ZOZn21NmEIhRuhAclbc5tMPLFcX1hy4nqC8bsoBje/CbNRUaEc4sL88YTHUuTQ/C3
         H2FzJPlZUh7gpfQDRqIEaUpcipz6bTsCD8KvK/yHg4KkO/PClylG6PySAZf1RMNbwWlt
         erlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795787767; x=1796392567;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jc67n1A66KDVhkCDP9mMXrkfPsJnF2d/z0nJmFfrZQQ=;
        b=kwayFMPWxs+Zn6o5p38hJ48So3V+bJxX6oawRICOoU/Oe4Et2k01gaZaZeAsg6SjWd
         iKLx4RS3sgJ+2HjQPhaOwLaVMBpz9fQVwfn9yNQNBBHkEgwHNelOuQWOUq1HY65OWGWU
         LkmPlFdtMfBi4RmJHUNdI83xl4/ZjlUbXVr6t0+vue0sUQH9pmbqmYXvZ1IXNeScBvIu
         E36/gwzloV3Sf2vlnMIcufuTDbs6HJPf9liFXW1TdWDqrAczaobQNzs0foSmyXHHr5H3
         Goi5+5jE0nCd2VyB6QU68hwHo/RYHBCDip/iUIc4zLiVvqzRFWHJUjJONS3iu5sHBBtv
         UDSw==
X-Gm-Message-State: APuU4Z9ZHDJ6YHFlIIsXH0MmpF4hMIuAkVDbtkHYq/lvicsXk+RYNkjk
	KpyAUlv2AmCWQX4Pkokad91u4WXaPP3so0y/i81R4GOkHax4k6AFkRJF6SUWdw==
X-Gm-Gg: AZFdTZdixV9SDwfWvPhUyn7sl87Q6avwSfvy6hQbR9b4KeXGMeO9+B67xnZlpLlP3qB
	7GHKx8A3Tuzc5SZg8tqjcegKN+9YV176RjcdQxjK54TR/2rNBbxqwPT3JmXFLBW1pyFQ4DZ67Wm
	wnw/08iHypa6BxjZDalwtrpfZIejmeCL02cCXv8nNpjvLV1vFi0SPy3L6WyZSFCUjdRPj49Np9h
	aqimPfemttxAHI33bMzn4+Kqq/NnxZYEr1SP2N4EdxqqpraiYQJbYmM28tV6Iz9NJtbbVvluUm6
	iEeH4IvybgcCvuBH7Q0l9YirWSnF5RMa1cJ1MuxtXfZJFshsDkwygKdztPZQCRGzQn+uyiBhli9
	bFGPRvGwod6KHqnDxV4uChyt5Zbp/9uW6e9UyYNYJ/N4Dax3EgoFHLPUycrNoIzYqgsvpVBAuei
	3fqrfr/L8+BXfOFNifVcM4h3noEFXLLUq22V2vnTY0Eqy8AL+j6EimyF8eJCxU19IExofwjS63g
	gGmkaJD/n85Dz/9mEL6KcMkLYTqI33O51AX87IgwvitZjQJlsbg/iwI9uSTIVo69X9AHuVHdLKA
	AycElVwi6avZWRgzpYDwIeLT5y+Zr/bRwH4p+H/s
X-Received: by 2002:a17:90b:2803:b0:3ac:ad90:7090 with SMTP id 98e67ed59e1d1-3b41c9830c4mr23485548a91.67.1795787766863;
        Fri, 27 Nov 2026 05:56:06 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-134.us-west-2.compute.amazonaws.com. [3.42.157.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b2156c2sm16998243a91.0.2026.11.27.05.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 05:56:06 -0800 (PST)
Message-ID: <6b098bf6.5ee1016f.3be66.3250@mx.google.com>
Date: Fri, 27 Nov 2026 05:56:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7976227404210619590=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, weihong.guan@gmail.com
Subject: RE: Bluetooth: hci_event: Use the fallback address when no Local RPA
In-Reply-To: <20261127054635.3146219-1-weihong.guan@gmail.com>
References: <20261127054635.3146219-1-weihong.guan@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7976227404210619590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1223970/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.39 seconds
VerifyFixes                   PASS      0.04 seconds
VerifySignedoff               PASS      0.04 seconds
GitLint                       PASS      0.15 seconds
SubjectPrefix                 PASS      0.04 seconds
BuildKernel                   PASS      20.45 seconds
CheckAllWarning               PASS      23.48 seconds
CheckSparse                   WARNING   24.71 seconds
BuildKernel32                 PASS      20.66 seconds
CheckKernelLLVM               PASS      22.41 seconds
TestRunnerSetup               PASS      487.25 seconds
TestRunner_l2cap-tester       PASS      14.24 seconds
TestRunner_iso-tester         PASS      15.83 seconds
TestRunner_bnep-tester        PASS      3.13 seconds
TestRunner_mgmt-tester        PASS      85.12 seconds
TestRunner_rfcomm-tester      PASS      4.37 seconds
TestRunner_sco-tester         PASS      5.43 seconds
TestRunner_ioctl-tester       PASS      4.49 seconds
TestRunner_mesh-tester        PASS      4.43 seconds
TestRunner_smp-tester         PASS      6.33 seconds
TestRunner_userchan-tester    PASS      3.17 seconds
TestRunner_6lowpan-tester     PASS      4.35 seconds
IncrementalBuild              PASS      19.48 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_event: Use the fallback address when no Local RPA
WARNING: Non-standard signature: Assisted-by:
#140: 
Assisted-by: Claude:claude-opus-5.5

ERROR: Unrecognized email address: 'Claude:claude-opus-5.5'
#140: 
Assisted-by: Claude:claude-opus-5.5

total: 1 errors, 1 warnings, 0 checks, 37 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15028061.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1239

---
Regards,
Linux Bluetooth


--===============7976227404210619590==--
