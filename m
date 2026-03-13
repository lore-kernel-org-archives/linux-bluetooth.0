Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BA03D6470
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424490; cv=none; b=rzsj+cAxnxrvbPzD6BS61DcfckpLB7Vkd8eD+viMjUf2+FIKiM2a3XeYpdHCCJUQpv1lchfpdu/uPf+Xnf4Po+oMKphpZdbAii5ce+q7APioBwu3Jsi/DkKq2ANXlg2ImpddwlFC/yi3Em20ll8J709Lk+kZFj6g/INEqJSb/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424490; c=relaxed/simple;
	bh=5yhU5VPGvgm3WPeJrfmfStOq0mMvVWY7x45jF6hL1Q0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ClzylvaQOEKdMivtHY1vUx34zdY0tROgt+FIxv63ZW7807NbOHl+T1UQCFeTvsTD5ZfvhpYkhtuD8/lIMK5BQBKiJYNiQQ3aZwgmexA4j5X5xfc2Yt3k4ari5XFjA4HAr5aUWRcW0KPXs6qKzTucRngxcwFtDhAQhafgESkuJi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhYSeVNm; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhYSeVNm"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ca01dc7d40so249459285a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773424486; x=1774029286; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wKCWIzKiiO7KJ4Kkt5GTxL68zI5Hs4Psl+kUHoA+/wc=;
        b=AhYSeVNmCVrrm1Yi+i5smlFrt0eqzg1u1jxgz3V+izEWzUdTu7CbdZZ5gxExAmJFhj
         U7q+Tl8PpsFmXlSKpj5N+wDKBfUFo+dLDQe2iUOcWOJ13ncdk4ttYle28bc+kjq0cImp
         P1IS6X817BQgcZtG9urzABcveQl57J/i27uD3CWpwcFQX/HI3UjHDKgFjCtR6vxuZ6hX
         jXzKTYw7qTUZcgXHFN2o4sFHyfxrcc+cZcikYPTNUAADpWnlwphRDBb9bImEtHRKTXlF
         Ahx4j+SXGtaF261eNmobOuOTisvKix+4kS3gLxMRP3l4GDklCoRpc84IHr+kdB5gBzSO
         hKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773424486; x=1774029286;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKCWIzKiiO7KJ4Kkt5GTxL68zI5Hs4Psl+kUHoA+/wc=;
        b=pQO0+GR4rew1K1FKD/y3ghpGFYmX0zLHcjx+pJXqM8ImO/Ew5VxnPhB4KcoYQuHQTZ
         7rSSLGk9QGC6xQWScsKAy4VJliYTp5G0fxFcBeBBHP8ItFnTQvBCNblXRURgnsttBJ5Y
         YsmJRFcOkgNhnCDsl3/1+BSQ7xa71D0JDUG1Y5f4ObUyCn++z6N6XcR9fd9F7IeyPvZP
         dHeTiWTZAoQmdpPTP3yvYYOAcfg5zRBqyjTa1YhaVBQk6j/s/0sBNsaihr/CYrU70qWq
         gb5fh0gEjKrYYTdOpifBAaXRgOaQ9NT1xgDKVI3Vh4cEHY2naxMFQTnHii5IUJ9wA7gM
         n5GQ==
X-Gm-Message-State: AOJu0Yz2nSpbcOu0QQI3+x6WZ5tOtF2rObgRkD5aAnjveU08Y2vUDjuB
	i64n2fpy9Jbeugpef2Kqv/wWFWJc9LNGIEmQrbSmbkKXtD4CeMpTM1Go04l6wA==
X-Gm-Gg: ATEYQzxeOU5Y4YUYCNxEWuwUhfGL14qZJZ10PfNMUdntFArMgcEe6v/8aXfGGlpw7IZ
	8jeC0Bu4Pg2qVTynacDcf26NlvtpZVy69tDzPa7/65h6Y0tqcehwoaILht9aalzv0GvB9eHRkR/
	HvMS/R50BGHwdUMc2Fjz45EVFzLZtguOodMaQrPH1eJQ4hRYBm5pTCrsWxeZ8NowBY1+q2vV56R
	JPFopP5O9epRewtEwVp7TifJv5QQu2cFIQtuS82LdxTvPNKA/FfnaK8HzpLbmgJFGC5CRRTAW86
	o72iqaRqIbnkZ/v/O7ZQQMpkJFLCbI4oLMBCBSL8UGGkh8OXOG9n2G/kwYK6oKlp3SGK9OieUas
	1NVO2G0ewqu2SDQGM6SbOX8DVGhmJPiHqI+NNlM6/47rWoZ3gx4ky/rbjWxk+tV6lrfksev1tFP
	2uw1/l5RGOwBSBfFwfk+NDVI02cRIKFlUOTDvzUro=
X-Received: by 2002:ac8:5f0f:0:b0:509:2d7f:b867 with SMTP id d75a77b69052e-50957d19c09mr52346791cf.21.1773424486013;
        Fri, 13 Mar 2026 10:54:46 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.173.165])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-509400d018csm61929731cf.24.2026.03.13.10.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 10:54:45 -0700 (PDT)
Message-ID: <69b44f65.050a0220.89d12.038d@mx.google.com>
Date: Fri, 13 Mar 2026 10:54:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0894364028429242670=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rebootrequired42@gmail.com
Subject: RE: bluetooth: btusb: Fix whitespace in btusb.c
In-Reply-To: <20260313163914.20533-1-rebootrequired42@gmail.com>
References: <20260313163914.20533-1-rebootrequired42@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0894364028429242670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1066472

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 FAIL      0.38 seconds
BuildKernel                   PASS      26.62 seconds
CheckAllWarning               PASS      29.33 seconds
CheckSparse                   WARNING   32.82 seconds
BuildKernel32                 PASS      26.12 seconds
TestRunnerSetup               PASS      571.75 seconds
TestRunner_l2cap-tester       PASS      28.87 seconds
TestRunner_iso-tester         PASS      110.36 seconds
TestRunner_bnep-tester        PASS      6.56 seconds
TestRunner_mgmt-tester        FAIL      117.25 seconds
TestRunner_rfcomm-tester      PASS      9.82 seconds
TestRunner_sco-tester         FAIL      15.17 seconds
TestRunner_ioctl-tester       PASS      10.46 seconds
TestRunner_mesh-tester        FAIL      12.49 seconds
TestRunner_smp-tester         PASS      9.05 seconds
TestRunner_userchan-tester    PASS      6.88 seconds
IncrementalBuild              PENDING   0.49 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btusb.c:4672:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4673:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4675:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4676:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4678:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4679:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4681:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4682:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4684:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4685:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4686:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4687:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4687:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.114 seconds
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
Mesh - Send cancel - 1                               Timed out    2.492 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0894364028429242670==--
