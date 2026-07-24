Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5AB3546EA
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915979; cv=none; b=ogsuPpJJTM6z9nnrExMX34FJKabuRCwOZ6epNjgec37pHKOXYn0t7VUx4+5hJE9L68EPvkfC2VRjNPOJtUQMyjOe+D9iWl0R/SwgdWlcVfmEMhUW+Nc7DLxZ9T9HZXpie1Ba3lER6GewUl8ubM64KT5U1bSPRsAsRcup7PwyENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915979; c=relaxed/simple;
	bh=/uOoDL4PXfkb6iRMNq10Y7sX0aEB8LEfMB/acqBbN1g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kRZqsNPOB0QLGsq54d9SG22lpbYuOOsy8ZBoR9s/M7rqu/so1iYi7LViXjn/5NGe/3NOdPTmiXDBHpBdJwZls1RcbIH0HcbhCl9LOE7iyderoDdAqNAl8BUFzd9Nx71+jjw2jwxWoQIHDYaKz2grgVVwfNfd7EaNMaGGQNbfOBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYoWJ8F9; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYoWJ8F9"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e5d6f35c1so63454985a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784915977; x=1785520777; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SFDC6jPE0ZfYrDUGIibbJeNj5i2InBP75yW15/YDRaI=;
        b=KYoWJ8F9HxlNksGnpoHbPgmPXCVK0Y2qk8ikrKdxfnY6sjCJMR9XXvxoVIJ+qXz1Q2
         AJImBzjkbGTHHOCxJSd1VDccBQ6/7sfOgQe7+jfXRQyon1LcOmzwys4sZWd3zeOvCQ/u
         /8/cAOmU9BTTRh1kCP7qXEvPNwNDwotR/GnA6dvfnGbvRr3eGRaNS11NuEjiOg0+UNjA
         Nx/WwsRBZkkokwNukwLe6b2I77T4GJ1GK3EgAeByWEWKCO8j8kg2j/hTe/DpNMlVkD/W
         E1WpxsMVX02vN6QNb/8MmBJJU58moAhm17CwrYQr6UmBsl4czA7c6szcFwrfDjlRB8/K
         0pXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784915977; x=1785520777;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SFDC6jPE0ZfYrDUGIibbJeNj5i2InBP75yW15/YDRaI=;
        b=Zie6s8HNHfwspvGV4ic9svXJrXcCs6yLAPC4ZusIJinlIX/LLMynPakPbG2eNDhhMp
         079+8gX66RBaVG6V45aO9df7QIm5y9KjBmPbgglqoaZHruVrnfm5RBuVKNPwyACpFW3W
         mWvYiKgCNnhCd/QlGCl2Occ4LzojiS2jXW9eBjT2HTaMv3RS8UZgOZcAuuLhG1EHY29+
         7SnZHMi83kiPVVy8kTxGUAjlZqXYsSL8Wxz5u2jb/HE0bPuDmo0BQb0L8ztw/oDNcqi8
         r5DQVtjsIH6EGO3xQlVIKwEfKo2ARs91Am5sEigKt7Bp+DNoU4r9Q56EHAPkONpMhZfN
         KZLA==
X-Gm-Message-State: AOJu0Yxa+4XtQ9Ft708zA9FZjj342ShXuZPOwPw0FshiL9BAxqT9TKUE
	7yz2vSgepAgXzsnJ1EZFmiOvF8L6oiCGoHStMy92Lsf6NhGz8pQvsUaVJ9rDoQ==
X-Gm-Gg: AR+sD12w24eoiXmLSf7EnOeqLV77Dq8jHUFuzx6hlcRG5r7kyZv5p8qxw/4yIe1Ebu/
	fFfL0SzrIDO5dhErDn4puC0u34x3hI8xG/QhqirtsVChFW+F/vj05sAwWSDUU+TAZ2YBmcrJysX
	/cagrGRpaKA0Ex1kFNxbh2thu5ULBj7ADWX/5WJ3VlOfuA4Ualrs0IHYgDNWPxsQI8UaiK2BXjN
	kJ8lFgSDspmR+LatNTnNoyGCdzBHUtOeA7yGtuWotHukOUV82zQymFiT6kDsv9fnaNZozmDSayv
	AtiJyGsHr5lQq2ktTNt63S5byoQErrgmfthy/yM/9l51h8VCTQhmTJekNc4b7bx7xvWpU/NM1QX
	SeIw4uPEOOis1AYck1Ytz8aZLspl6ceJKwi63suk6lygSWj0r8zEQollXjtUET2cZ2hizLGHw8J
	Lmhc+RiHLIAQ==
X-Received: by 2002:a05:620a:371d:b0:926:e8e6:3c34 with SMTP id af79cd13be357-93103a56716mr875441385a.21.1784915976532;
        Fri, 24 Jul 2026 10:59:36 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.127.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a7f937sm704858385a.40.2026.07.24.10.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 10:59:36 -0700 (PDT)
Message-ID: <6a63a808.0ea1c686.1201c2.95d6@mx.google.com>
Date: Fri, 24 Jul 2026 10:59:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1389548750797440913=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/3] Bluetooth: Add support for Shorter Connection Interval (SCI) feature
In-Reply-To: <20260724163511.1737044-1-luiz.dentz@gmail.com>
References: <20260724163511.1737044-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1389548750797440913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1134097

---Test result---

Test Summary:
CheckPatch                    FAIL      4.45 seconds
VerifyFixes                   PASS      0.15 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      1.04 seconds
SubjectPrefix                 PASS      0.42 seconds
BuildKernel                   PASS      27.19 seconds
CheckAllWarning               PASS      29.86 seconds
CheckSparse                   PASS      29.21 seconds
BuildKernel32                 PASS      26.32 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      505.63 seconds
TestRunner_l2cap-tester       PASS      62.58 seconds
TestRunner_iso-tester         PASS      88.30 seconds
TestRunner_bnep-tester        PASS      19.73 seconds
TestRunner_mgmt-tester        FAIL      227.58 seconds
TestRunner_rfcomm-tester      PASS      26.33 seconds
TestRunner_sco-tester         PASS      32.97 seconds
TestRunner_ioctl-tester       PASS      27.62 seconds
TestRunner_mesh-tester        FAIL      27.10 seconds
TestRunner_smp-tester         PASS      31.48 seconds
TestRunner_userchan-tester    PASS      21.04 seconds
TestRunner_6lowpan-tester     PASS      23.86 seconds
IncrementalBuild              PASS      62.57 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1,3/3] Bluetooth: Add MGMT Load Connection Subrate command
WARNING: Prefer using '"%s...", __func__' to using 'load_conn_subrate', this function's name, in a string
#350: FILE: net/bluetooth/mgmt.c:8178:
+		bt_dev_err(hdev, "load_conn_subrate: too big param_count value %u",

WARNING: Prefer using '"%s...", __func__' to using 'load_conn_subrate', this function's name, in a string
#358: FILE: net/bluetooth/mgmt.c:8186:
+		bt_dev_err(hdev, "load_conn_subrate: expected %u bytes, got %u bytes",

total: 0 errors, 2 warnings, 0 checks, 308 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14709292.patch has style problems, please review.

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.254 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.537 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/488

---
Regards,
Linux Bluetooth


--===============1389548750797440913==--
