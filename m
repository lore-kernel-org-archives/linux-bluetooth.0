Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E423DAAC8
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630996; cv=none; b=L/b9UlMq38AXf7FRiMbyo0H9/6OkYvBYIoD1UxS+5XiZ4HhvWsKVQGGWnRvwbrekgK7IPXQlJv+dNV/LmOFhMh1uVXFJKYT+fLknJZX+dQ625Jdp1KnUXOZ85x4azn/H+6UaDGgwH2wQDt9IZVmKIN9d57HgLiR4AH3d5SXrsTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630996; c=relaxed/simple;
	bh=+X3+/9z5KVE5rnwxXNmjwJAK/N1+uuAEtCtLX+/5ekU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E1ZPaLLzlMCdLtKh0Xqk+LrHD1wiCAoEP7JxmosaI3Q8pCf9BmzH+m8YlCgIXAvevsgpiUBZJxm0Va6a+F9GIJ9QJWNSUxqqlChOdaH5Wt9Chqtfrx5B07swAbR6zlAnZmxsP/vObeII7QGkM62d4GsdklhJiRJ6dum0G/VVZio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/WKUK2Y; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/WKUK2Y"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6c24d19ebcfso1952748eaf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 14:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790630993; x=1791235793; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o0HVfo1flGmQ2POi7e0NHE5Ih9avjOMAxKaON0tY/sU=;
        b=P/WKUK2YLFc50rR/TrX/h4CuDYG5WaPGW3Z2vmBXy34rvagNXpL7bQdLVS9OZeSjwy
         TwgD1pmh6ekSbhZMc1P9DmgzTDw6Zpe43ELkyxnwcFyf8CJF1NJW/v2HRG+Btoc5aAmP
         BUX1ZFsa41d1LXtganv0bHmYfr8vxX9d9Pe7CnTgkwIcWOhUk33hGxR+qTwJVskQwjGa
         fCVRcDyTn2/EfaqxzMn7RHjTeGHr8WnQ5N4/hCMgW84/CZXq5LGR7HwdXOiXIQd60R5d
         EwZfFi4kD4YfACKGCsPtZm5BtufWJZjtjR4mCnlMbGUaMQp43CWrkyQGS0IQKgl1BQH3
         keMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790630993; x=1791235793;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o0HVfo1flGmQ2POi7e0NHE5Ih9avjOMAxKaON0tY/sU=;
        b=zLZ0GYAQN6yDl9/6OPPPdFCQS/bcAiR4o/PDWpLiHPty7qOwnG6/+O7mxF8gM6lgZx
         nTBlKTGkNDb4MeuWmJhYmGjEJCd6jrhJNGHu4lk070ZK4rT6FFMO0+qTgwga1qw1WCCl
         yzQgZBkKynNNNrB/Z3F6gcixzPmOxBEGtVw5HJAqJDXbbM0O8whoXsWZS+5B1q/uOSuo
         Xkx0HxD/Cw9RhecSLE4F9Rr7V3Sl8wpCTUrczangAAgs85HPFJeZ8bgYdqW4CJQB/OBi
         7t9JPdhXn9xTHZTcVH+F2/FdCF23ib5wk8T+tGay8Sd1R8Hg60ww6yypdT1bYjgZLYPV
         IQ7Q==
X-Gm-Message-State: AFuF++kLQsPWBDhO+8GVzfNtJ1P7ZGRJUHrZzqZ1TgbK+X+W36q/OCUo
	TrL+h535us3FzlWKitotJHCd/QfbY6h6g0LA/Y6JS5WiZBjgVSF/Hj1sEnAckbt2
X-Gm-Gg: AYBFou0EFQlzc+ka3s9WBL0nv6QbFmNBFodyh1r6NzbXF1zoLpLbRtjc+Dq4Z0+wgw6
	2BeBxpUJI8RJgG3sO7gRdr8Q9mkoj2kg8BqHzspV5jYttZuMeybXK3apBx8wN1SUNXMaas3GE5B
	HHiamRRkFzYdxAtfq8Px99eOozNUKRKs0T/Inljkd2agbLVe8xYHpuySf7GS/xxyyHi1xuGIGcS
	5bN2GyuIrzSh2HGH8c/8JWEEmwujg1v6HvYNykgOQIpiBxzeY1BqyKntagBF7C5LXe/XPOPwvSz
	vOLfafD8y2boPUWrdNuvV56Dgl2jxWh5/yp1vPqOPjyyG47KCMqYyw1b/K2pBCk4bgxAC8FFwUS
	CKgFF0oUcd2vrPpIK3WRC8iJMWqmd3YAMWVmXpDQWTqWqN0SlOAWskkZNUGS0Z7nodiHLCOXedG
	8CJK1I2h9kRi2Zgw/rByW/X3R/shJkuRbCZ/LY7VTwZ28bjHr0Eas5HmigUgEqFbeswmtd1sRcH
	Q4S
X-Received: by 2002:a05:6820:80c8:b0:6cd:3fdc:5ff6 with SMTP id 006d021491bc7-6d4415b5b06mr14004049eaf.71.1790630993414;
        Mon, 28 Sep 2026 14:29:53 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.29.166])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d883395632sm6010109eaf.12.2026.09.28.14.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 14:29:52 -0700 (PDT)
Message-ID: <6abadc50.7406aef7.f2df2.5d62@mx.google.com>
Date: Mon, 28 Sep 2026 14:29:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2463465956708415457=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: Bluetooth: btintel_pcie: fix D-state transitions and PM flows
In-Reply-To: <20260928171003.2925480-2-ravindra@intel.com>
References: <20260928171003.2925480-2-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2463465956708415457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1175428/

---Test result---

Test Summary:
CheckPatch                    FAIL      4.04 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      1.09 seconds
SubjectPrefix                 PASS      0.43 seconds
BuildKernel                   PASS      20.10 seconds
CheckAllWarning               PASS      24.77 seconds
CheckSparse                   PASS      25.41 seconds
BuildKernel32                 PASS      20.70 seconds
CheckKernelLLVM               PASS      20.40 seconds
TestRunnerSetup               PASS      494.06 seconds
IncrementalBuild              PASS      23.04 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v6,1/4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#94: 
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 0

total: 0 errors, 1 warnings, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14852808.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v6,1/4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check

9: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 0"
10: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 1"
11: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 2"
12: B1 Line exceeds max length (98>80): "  btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend [btintel_pcie] returns -16"


https://github.com/bluez/bluetooth-next/pull/834

---
Regards,
Linux Bluetooth


--===============2463465956708415457==--
