Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE504334D0
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101944; cv=none; b=W+81UMMUDHYNUzSz9rUQ6Q9dvecz7IxjMdrBNHFOUl9zEdoWJ3DIk8XfYXPDX7Y4CVGfOURiA1rBYnQoWgfN+EC8w5pMJ83lil+fHPdUor2WtWOTUuR8oJutCKFRMaHnawIG4ZH3lO0BMl1r106r+uqlc4UdhXB5afuZlCosUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101944; c=relaxed/simple;
	bh=YklQkvuv4+/D0YjniNVjt2BdikKFj+s3/sbifH6rjPo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P5jjIo58yspYRF/IX06YJSXnJZXTYOB51yII/uCQpM0tjNg6i0YvzUClyOa3llerr4D+TF/I5cUdS0rlvC45rfYGnx1MqPJhAPYhPpdcgpJr/l0O++KN2SyYqv7ika7DvixGR9Rlc0g+ruFQVWKAqzRmrtVzUJxuHqgcFd9fgf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4AfyYIv; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4AfyYIv"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-497e6956acfso1379565b6e.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 04:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786101941; x=1786706741; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kSrUlOG5e6pDAx6i1puafC5q6VwMxWydexjkUGCxA8g=;
        b=o4AfyYIvqLYGGFz27B+B/6puOdfXV/IKYuOaqPDwsaBDxqEYmFHCL4L0DXNaMpFq9I
         QeDwjHYtDbDg/MycSK4QhNtDsTiMGv1MT2xcp0qQvCKDdDvV7Ta8fmdGTFYD5zc4jzgL
         8HzLvgHGjU4Rx5XfIZ4tWjwGe3olXhbfSWjEd9BRxD+cUst95qm04tFrhtDfBQ4wX7A0
         X+Jx+OTPdcuPvxjiDa4pyznUYyxZ6viSuXhzyOb3QVWlrw2nkcaitG70RTp1oD7A9htP
         1dFihVZ4GLnRVUvPu/HujGlxLTxQ6KeNlU0mvEi8Q5jmkBVlSuDzw2C94h2sui/Xx8C/
         ymwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786101941; x=1786706741;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kSrUlOG5e6pDAx6i1puafC5q6VwMxWydexjkUGCxA8g=;
        b=sWyFs4DDn22RbPrqWY9E61j9HrkYxsfAbrkK96D2fODHegAOj9WqdCCtECPFx3hcWn
         i7ofi4jMPZTj3qYzVMJKKpIbaGUSIEbrfID71C0BSLErftmk3UDA3UxX3QrSUrjhTnh4
         zEORjUN2c7WpySdRRDo6rhoPbpcaC4RRvxNnCQilptrMVfvsWSdYFc0tdrc4l7CYboch
         6SpEJaCoCJC2b2qkV9I3tho3supbUQ1sroKAXTYL3V0APElj6M+NWX0MXPvi0Q+bwCfk
         9kKPIsuWqO0F/xUjKNcOjsomdOgfOrjR/nprEYvZuhAjpqaNpUSJkkhRYzJwHHVhioSm
         KZGA==
X-Gm-Message-State: AOJu0Yzs7XpgDOZkB0Ao4wu9SMWcwD0utpJX/+yYh6JXKcExg97cx9yr
	E/56p7z0ZN686gUnOM/srNNUtdibarPA9O94aF6kfrujXMZiCo+FpdCkVxlM00vU
X-Gm-Gg: AR+sD10w+rN8OppuAomUdLT8CsV+PijqmId+lYTRKYGwSnmEcmMzn/5z9yGnU/5lHVo
	O2WNd2GQi62zjm4xmOxdr55OFI/rKBmR67ErSjv2NyqVY7/BB2wWPYTeJ75GPaj+g1MoyAyjYb9
	xd5rzc9GmwGNxdQVjvNfMEQFrEnEChAJttkTqMJaTa9OqyGSMj5BBqoFhE5JLZwCpOm7tRqR8pj
	LTGYG3f2K1FvdfEQeIP93kydSH1Q/3Kzlp/nF5L9q4LOk5cAqqT0UBfxhmSuTlJOJyXXOI0ZDCF
	vqWTAzHboKAQ0Dbh+c7OoLpQs1W9Xpr1RUneCfUsWrojEt9NgEryNsPreOHfQUejeiW5sLzFLjR
	92Lc6rEoTOxW8gV6BkO3LmyR0G/nf0lk5MpaYNZRUvUn6+Uy5EkmbT5oLeWfrcmOQlg1cg42gMm
	q29iB433kLnE4rvSVAPKt5qJOCAyusPZZbuY3+BewgTWxSqAocX/ouDtW5+X6NPHCT
X-Received: by 2002:a05:6808:ec9:b0:4a4:cedc:6859 with SMTP id 5614622812f47-4afc4df6419mr8006143b6e.4.1786101940751;
        Fri, 07 Aug 2026 04:25:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.29.60])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae75db20sm6582697b6e.14.2026.08.07.04.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 04:25:40 -0700 (PDT)
Message-ID: <6a75c0b4.7432213b.3d9d42.f5c5@mx.google.com>
Date: Fri, 07 Aug 2026 04:25:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8435938796387653922=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, baul.lee@xbow.com
Subject: RE: Bluetooth: MGMT: fix use-after-free of struct mgmt_mesh_tx
In-Reply-To: <20260807101529.17348-2-baul.lee@xbow.com>
References: <20260807101529.17348-2-baul.lee@xbow.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8435938796387653922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142102

---Test result---

Test Summary:
CheckPatch                    PASS      2.75 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.79 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      24.94 seconds
CheckAllWarning               PASS      26.93 seconds
CheckSparse                   PASS      25.80 seconds
BuildKernel32                 PASS      23.55 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      448.36 seconds
TestRunner_l2cap-tester       PASS      62.39 seconds
TestRunner_iso-tester         PASS      79.18 seconds
TestRunner_bnep-tester        PASS      18.40 seconds
TestRunner_mgmt-tester        FAIL      220.92 seconds
TestRunner_rfcomm-tester      PASS      30.69 seconds
TestRunner_sco-tester         PASS      31.03 seconds
TestRunner_ioctl-tester       PASS      26.35 seconds
TestRunner_mesh-tester        FAIL      25.85 seconds
TestRunner_smp-tester         PASS      23.28 seconds
TestRunner_userchan-tester    PASS      19.48 seconds
TestRunner_6lowpan-tester     PASS      22.70 seconds
IncrementalBuild              PASS      30.01 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,2/3] Bluetooth: MGMT: protect hdev->mesh_pending with hdev->lock

55: B1 Line exceeds max length (97>80): "[   78.211873] ffff00001b0340b8 (&hdev->lock){+.+.}-{4:4}, at: mesh_send_start_complete+0x88/0xf4"
57: B1 Line exceeds max length (105>80): "[   78.212596] ffff00001b0347c0 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}, at: hci_cmd_sync_clear+0x60/0xd4"
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
Read Exp Feature - Success                           Failed       0.253 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.644 seconds
Mesh - Send cancel - 2                               Timed out    1.984 seconds


https://github.com/bluez/bluetooth-next/pull/547

---
Regards,
Linux Bluetooth


--===============8435938796387653922==--
