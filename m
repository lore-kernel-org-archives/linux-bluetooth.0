Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7222636EAAA
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939033; cv=none; b=b8TgcJp4hnWo8/k474KAs5BUrXFdGZiu7Cn4mSz2g+r0fgXC2I8GFPzOa26wGljeIUfalb/bT8MJJYGlTqV82Qt+W11wgLd006jAP/is22Bfg57BqYVeCNf2zf1vqC2+WzHC9xdDCQLhS/vUgeCRkc+hXTAsTjQeNvf5c/mL4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939033; c=relaxed/simple;
	bh=IkEe3eZhFu2vzXoeokDo3jXl/htyFW7FUjMn+aCo3hg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TgtGR+S3tHY1Rep35TG5MihJ1qEIVSgmkOouK6lNrRySgGQ8tDAp11lhsYsS13llSDhjnwIR3dIkmQCz+dZYX7qi7DVgLr+NmFRz+m6P7GwqOj0O0E5JUAe0cBtpK5SYJD+jf9Tetzzge5hoyyfmS6UvUrM6KKXvhjoJTwd6eSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvfIYEVB; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvfIYEVB"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cd71fb9f06so320844185a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 23:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774939031; x=1775543831; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cccnExdY0ov7ywUk8V0JzCEl+rj1nJ603Rrx1E2z140=;
        b=XvfIYEVB+3z6s9hpoqsnhG7DtFrAY48BtlxJoCX+U3eCJhxVDs5kmJ+1SkGA+4x9K2
         LiE1Jl78O4zHUHvSIsEULo4h2PRprf2iyZGOgamGVL/eP7FbdDYJIPjkHyVu6ztgFQVq
         U9hr9Oc/ZXksIctCt/zb658mNVc5JjJI/XBzjArHmhWZszfyzC4/JLbxLuHgpObjfBWs
         xTC3GQdFbp/olIZw4Ftj6cOLQrMNXE6D+oQPNlLQMSjsa+al7wdGYIk0f3mB+gbqT8nK
         PpMRWxozVrN8lhokPLeabriKwvB3Uc/okcK/O3grbZ7nMGnePZzhQ6fsah7g/084r1K3
         7aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774939031; x=1775543831;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cccnExdY0ov7ywUk8V0JzCEl+rj1nJ603Rrx1E2z140=;
        b=F1G6qRvRKC7veRsyh2wqNeypkvPVfa7SAEO61D9Us+vJbWjdi9Rmjoa01VANTCPvco
         ne27MS/WJwBdi1AQcPM3HBw75XRuPv/XWcC5BxBPyA2XXiH3OdeEGihaBJyGkBmjFsp8
         5Hc7bxmld5fHP7poGEA8SHNkWX4XDxBHXTlytL1sy7OKfn0XLjzCbqfOiGebxmOQzJRl
         4B0mjdmbawu6Jimaab2PlUyOoDDV5KPLhClbKUs0GNlpFlC1oAw4BMSsW2tD7Gtrk53O
         C023lFIKEpMix0bAHnRa+3X+WOetQR0el4WxZJfnQQePfrpqJEd6pqBOZ6+lXWlZDeR7
         GBiw==
X-Gm-Message-State: AOJu0YzXRboBPiPJ/xIbKV9W8pPFX1bHhc95do9zYFvZXe5YeSshnGPa
	eMhtwh3kvC92MR7svHbJQyaWRT3KkhwYyWEOlarR4mNOgq19UvE6yATznJkMQQ==
X-Gm-Gg: ATEYQzzQfImIETj33ZA+eqjyIy4PLFRLvH6yea4ZNRJJOPC7UcG+7Qgylj4cq/+houQ
	se3w00NgkduoIgG7ilTiG3DF/D2wdVLOrOyWGLt0KAwWjStIYEn9depRu1+yCv2MIOe+J4A4gUi
	tNhGPaiwAvVKrcHHfIIU9OJ7jyNhPulX2AeydgNSLtTyePxbVUlQ/6jYX6zQRFS0I1hiIEHPzcQ
	AyEsHoMmtH8B6jvwppL+UPua8syEjAF8WpBqGP5cni9geDBEVmtRRsHaqq6O8UsqwUPClI7KDyK
	Vk39ZpYVvxjhR0PknyfcXhc5d7ogJaG7d7XpEmFXsxlQaI6W2n+c3I/YY9KkcUVPynp14PhPW5e
	SQzmb8LbR8zZf+oarKascSf5qgXJDK++SiPxpDTg7FYxBQhTt6TbEjchFe7GEOyEtgxDAu2oty1
	HnT4pxhbD67Fs2BnBWo3buFPO9g3xs
X-Received: by 2002:a05:620a:1722:b0:8cd:8e8c:208b with SMTP id af79cd13be357-8d01c7bed55mr2064057885a.38.1774939031176;
        Mon, 30 Mar 2026 23:37:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.117.39])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edb8e0sm930494185a.8.2026.03.30.23.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:37:10 -0700 (PDT)
Message-ID: <69cb6b96.050a0220.22606.8f4f@mx.google.com>
Date: Mon, 30 Mar 2026 23:37:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9055350528798615187=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hkbinbinbin@gmail.com
Subject: RE: Bluetooth: hci_event: fix OOB read and infinite loop in hci_le_create_big_complete_evt
In-Reply-To: <20260331055032.1883139-1-hkbinbinbin@gmail.com>
References: <20260331055032.1883139-1-hkbinbinbin@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9055350528798615187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074955

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.88 seconds
CheckAllWarning               PASS      28.00 seconds
CheckSparse                   PASS      26.93 seconds
BuildKernel32                 PASS      25.20 seconds
TestRunnerSetup               PASS      563.48 seconds
TestRunner_l2cap-tester       PASS      27.49 seconds
TestRunner_iso-tester         PASS      41.46 seconds
TestRunner_bnep-tester        PASS      6.28 seconds
TestRunner_mgmt-tester        FAIL      112.29 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         FAIL      14.09 seconds
TestRunner_ioctl-tester       PASS      9.95 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      10.67 seconds
TestRunner_userchan-tester    PASS      6.57 seconds
IncrementalBuild              PENDING   0.43 seconds

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
Read Exp Feature - Success                           Failed       0.104 seconds
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
Mesh - Send cancel - 1                               Timed out    1.936 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9055350528798615187==--
