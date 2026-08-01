Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F58EEA8
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785571425; cv=none; b=kCTOepPuwrkI676p381vtZW1ftP59qkeTPqHXCcln7dhcKmH6WQatXRbmU8O+kfyqjRVqiAovhPir4f8jIZBxSCgzNv+WmLiY+Cv+SkY9HZt+DjKvstdKInvQ0PZqT9eYMBoc83EQkTwgRweEs19V4jRrNfFsxtHzIxjr5T+5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785571425; c=relaxed/simple;
	bh=lvDydOKMjdabQEXfT5h0+WgHbx73/jNFkod/lqCfgcg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mCX5pVwVvK3h+giWxedR7f5PD7CCpFG0owIPtaZ3o4Eh8y70N2MiUlU1H65BMMcGdq3oFXRPA1CEOPApcAbKzRU7axlTYawb33/pcmta8GOIoLbb9gKpTp342yEGw9l7VlQxkhDHcZHcpjPiONDdfBgx5pGJwWk83es5yH9T52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfhIShzK; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfhIShzK"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c1372f84dso10123631cf.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785571423; x=1786176223; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PvIhtaAWNgtUpZy2kn7hTpCoIzywUpO/TRNd81bIPD8=;
        b=MfhIShzK2/QoZXNdOzHl/dDh62ILOU92RhMUe0vdC77niW4MKTGp554lK69vZTeoi2
         tmzQri6EEXm4vc8VEKMIeP0tcKKqHNQoaFGom06QKPVoQHpi+GJAR89hnsSiZlykdZUC
         SIfJIbTzMrDq+RRzvBeXsg9OmjwZiiPLRvq3iPs8f2DQA812FrLaejHL9YhwwF/eVooW
         /PXjIRTiVwyurAgjrGzZipdcPC52z4WzUA7WfBcLcCZLqekkowsOB72GW05fBeKcfO6o
         bjItf347efDaymuwEf0RCtmOErJHPTE8eCnfL7kXLZcRtYIZfxXA4cON49E644gQqisl
         IgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785571423; x=1786176223;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PvIhtaAWNgtUpZy2kn7hTpCoIzywUpO/TRNd81bIPD8=;
        b=fwGsXMjNPyTTgGfQeRxBn/msmFCE8iaZBjmaz8hWpkOUZIVHjYmfP5iPBJ9DXlf8SJ
         Vne2C3WWGjgLLIU4jmaf6HbvfRNtgbszs8lXl/GpYmqc2khGgo0mATSd4ReOXBnGURXA
         ku45K/3PKTXsIV1cqKrvV34D05P/X/4gtk2rAuWq2bFGXXKUaIYfXoUSRrKcOQYGtmjW
         E2V8kD/BYCX/M6YhlAzUpINrahhSHoMNrVm06UGAnwjDWQgEOLTTRCU5VPlcbetpfo/W
         rx8/u9cSg4k2a/ElwGrBRHWOKv/BNIGZz2C4XSYpJ9VxGTA6jc8niq8zTvWPffx/COwv
         bzWw==
X-Gm-Message-State: AOJu0YzUyqWiR0MFUdsgX+cFAvz6aGWuwduJKv0IOnofgRLigv8DJQm7
	b3khTIaijQMlA7D5gbVm/v0SsPaQzK9Yx+r5KHULO8uFkjqFT4klF/7pjOA3fg==
X-Gm-Gg: AR+sD10rBIngx+V900xuN5oGV5T+6x3CUka8WbhQQpKIQtImywD7OW3qyC4tLoN+nO4
	jYBV1ENJitSw0GNSEwE1klLkNt851GWtZsZNiy3O+VXTaKLKsqRna5SRIDC5rwOsd5B1pGOflQl
	X8SYqt2AD7s987XMPS1OaXn3N1chHfy7iTVoxLJ9ycH2hgWdElWD3zDCU+ATZyIrTk6TI6AKVFm
	wZiSjPaVhx/25m75thvxAERfl3F+rzabhKGcwgFTeiris0hPB4M6SO76QGcxf1/tPoQtqtwklc+
	ZhP31fFvZi5OuhcQ9zDkdqR4fx5IMSC4LNnKZZVFrwW98VXgevLiLVDJBt22nRynBwzRGVnqDym
	YMhSSyeTmNokfiFgI0jJ3V/TmyOc8jwX6AewCeIVVaAqbDmE+dx4PbPj4s70XpP5ESW5DuTCxGb
	YZDhTC3n/vg1CLku6zcX/+C8qmovQpFJnYOs8UbhXukLxEakp6+OCloE6piU3gvwM7hdc=
X-Received: by 2002:a05:622a:4d0f:b0:51a:ee21:d342 with SMTP id d75a77b69052e-52b567522acmr66406131cf.20.1785571423108;
        Sat, 01 Aug 2026 01:03:43 -0700 (PDT)
Received: from [172.17.0.2] ([9.234.149.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4ec01d54sm24167921cf.31.2026.08.01.01.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 01:03:42 -0700 (PDT)
Message-ID: <6a6da85e.95751058.2710c0.934f@mx.google.com>
Date: Sat, 01 Aug 2026 01:03:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4035672675889887547=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: Fix accept list UAF during suspend
In-Reply-To: <20260801070524.3547883-1-nicoyip.dev@gmail.com>
References: <20260801070524.3547883-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4035672675889887547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1138539

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.19 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.43 seconds
CheckAllWarning               PASS      27.69 seconds
CheckSparse                   PASS      34.47 seconds
BuildKernel32                 PASS      24.87 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      460.26 seconds
TestRunner_l2cap-tester       PASS      61.89 seconds
TestRunner_iso-tester         PASS      84.13 seconds
TestRunner_bnep-tester        PASS      18.74 seconds
TestRunner_mgmt-tester        FAIL      221.75 seconds
TestRunner_rfcomm-tester      PASS      25.75 seconds
TestRunner_sco-tester         PASS      31.88 seconds
TestRunner_ioctl-tester       PASS      27.15 seconds
TestRunner_mesh-tester        FAIL      25.98 seconds
TestRunner_smp-tester         PASS      23.62 seconds
TestRunner_userchan-tester    PASS      20.30 seconds
TestRunner_6lowpan-tester     PASS      23.37 seconds
IncrementalBuild              PASS      24.18 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 495 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.253 seconds
LL Privacy - Unpair 1                                Timed out    1.919 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.840 seconds
Mesh - Send cancel - 2                               Timed out    1.985 seconds


https://github.com/bluez/bluetooth-next/pull/523

---
Regards,
Linux Bluetooth


--===============4035672675889887547==--
