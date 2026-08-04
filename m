Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA89833A9EB
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845788; cv=none; b=c20g+/5KxhRA8aQFCl2c9+yAAUyozZgsghzLG2PjhYlqlPtAFq6r5ZJp4lBT/qCugu51scxG0HdOUiGhOa6qhBHTdzl7ynKFA9hB3s1XE1I5lIpSYleh5+riBp8zan8qcExIvTjgK7UNgmMfScPf2xpvDnSEDJhWP8bAoeb/WAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845788; c=relaxed/simple;
	bh=LdN1eJ7/Pa5Pj9jKO4OuPcbJ85s8A4vQuDnji4S6A9Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UPHxY4ZFadAeJmL/VYiO+8MYAjCcV3LFDegfN7G+vsMJsi5sdMQuLlcAE0Su0Zhw+ftLUnA3A+cWSnJ5Bfsic66N8xb7r9aNteO9itbTvzI50/85z4wF5Na/XI6tEXVJC7HOcKpVQwQZmIre2Q4g96mjGPED1KSY3+vKurV1pfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hM8eVKEG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM8eVKEG"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so3921455a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785845786; x=1786450586; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2+NxcIs8VJbR+ZYRt2M1WI0E+zN0ZmyvCpozPzrjpdQ=;
        b=hM8eVKEGY1GaWP+/jTnmsmMmMvFbrxYMVKUaHWLufgDnu2yzgUuPYbxBNJ24+bx6Ve
         /iBIxjxdKsqGtlrBIr4xe5BK7FXtobVSrcceKPr3Q9r7HAK8OlmmkQdAF8T6EW8DBPrc
         zOXVaNxP9xdTh9I60Ozyj8Z0f3CuscrbSKkMbur2z/LSve1skEax4evTWcf/dgERCNrH
         uV2Q76gM5JmJMn+AziY3G5VrId30GpaKtjtaD5wo7n4ApOoOhpODfExN+3WE9yYp/M4/
         W2K323c3PxBiMrRR8NgdDzSjdxu5dW4ppt8s9s+Lw1/gFyNr2GtGkuZpbN1C+ihEgxAN
         a5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785845786; x=1786450586;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2+NxcIs8VJbR+ZYRt2M1WI0E+zN0ZmyvCpozPzrjpdQ=;
        b=nZBNcxldOLGKpMgOuK1Csn64QosOgJPX66mzDgGiSeFVdtKpRGvzvRsX3wDPMrUvtB
         t7epbMSgU+TOUoKH1G09l5mc8VNyilq7bTXFL8YFbt5NpSTnZQbMi6SoI5oF+X8bMmyr
         jb43s9p8F5g7LItJ2LaqmV+x7VMIL1G5I14mD7lvns+UAdmeG6nojSo3rcv6dZkDvi+6
         C7trzySxEa5oar33fOdjDVpU6E9AkZn1IwnKAGscn/b53RWtrMVmkeaMj5rToKGRr4nn
         /lCmsGW6aN8G3qW0MiwSJsR1VDLWPYPv6peo9jUtXqvNBJtWIwad+rCVE7zuEWiY6oNn
         lhtQ==
X-Gm-Message-State: AOJu0YzISKVBJmTQM1C+MIJss3zPnrBCdBMtv++toHRNuwCwcJe3BblA
	B+sWsK5kTGqeC6lQRSyzCiT6hhAogOL1ac2AGTH+ap+iDOq5Di6vhQzVhh6bfw==
X-Gm-Gg: AR+sD10JEEmUV/rx5oFcATe0Agi8IYDD/3FM6tqajx5whV7bsu0gQsYA3ZYzJtugkXh
	0v+5mfvrpSWVZ6+GVt7HBSoYeN32qElzCnNoT4duJkrGaAbN/EgB+2JIfbO3/CKcD2Rm5mxSoLS
	0QXA6Im4B525qqnzQpqoTjGujS8QF182W3LAT7q6ZsFL1vASUmNABJxj6eAhoL82LJUNNUu02CB
	uM7CFG//MfnYaYeKn7Mu3OaLk7nV8oNlQjgt5wqKfyZRUtVTNoqvtW9iZevQcgEsDrLpy5QSfsI
	2F6p9sFCzN8UBg0Eu1prLui6qR9rz9z6fOZ3wkG9EzwX/j4PQwuuOl+9zZ52kl6VkdIzZdhlvSV
	0HM9Hy/6Q/As8NPM5Hdpgn/8Rxv9vMIOA0P8TgmnVjrcAGv+3fMg5z5JIqv0xAtG8iHeAI6ZxR8
	kVd9Oqb3GuNcqvVYo9AmbGEfovTG6Ks0BRjqFa4KKeaBf0yflc0okGu0S786++xSFhYw==
X-Received: by 2002:a17:90b:3a10:b0:389:8f6c:4d70 with SMTP id 98e67ed59e1d1-38fbc4d2fd6mr12214927a91.28.1785845786062;
        Tue, 04 Aug 2026 05:16:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.93.88])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca926c0bsm3034097c88.14.2026.08.04.05.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:16:25 -0700 (PDT)
Message-ID: <6a71d819.dbb26164.10167b.15c9@mx.google.com>
Date: Tue, 04 Aug 2026 05:16:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5729516095126780825=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, m.szyprowski@samsung.com
Subject: RE: Bluetooth: btmrvl: fix event packet length validation
In-Reply-To: <20260804094632.87581-1-m.szyprowski@samsung.com>
References: <20260804094632.87581-1-m.szyprowski@samsung.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5729516095126780825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1139978

---Test result---

Test Summary:
CheckPatch                    FAIL      0.53 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      20.71 seconds
CheckAllWarning               PASS      22.75 seconds
CheckSparse                   PASS      21.66 seconds
BuildKernel32                 PASS      20.41 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      378.27 seconds
IncrementalBuild              PASS      19.10 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btmrvl: fix event packet length validation
ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 75e574f6a212 ("Bluetooth: btmrvl: validate event packet lengths")'
#80: 
The event length validation added by 75e574f6a212 commit used a single

total: 1 errors, 0 warnings, 48 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14729543.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/531

---
Regards,
Linux Bluetooth


--===============5729516095126780825==--
