Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A63546EA
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727799; cv=none; b=IO6rgJyBlgrONP90uZcqpmdmreXVt8bZ51/LPVuCdZFkCbR2phQvzY7j48RRrMO4YxoAozlqOFPBkXRToW9qC9Wsc9senoQO9USsIDJ2QQCxytsUy00kUmpKFP9DAimbsVLOlwf6bQc3FTdmnh2qw29o76j/3tgQPINnSGE9v8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727799; c=relaxed/simple;
	bh=knt5fur7TMHfhDaNiacw5f5XaGL52IP2mQ3IxjiallU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eeAnsOJYWCuQJSlsfDPxhNrI1e374JkQADOnP9H0osmWk0RPbcOqsTTmZX/6wdCmByPLT7PSDs0jLq7+eS1dqkz0arNUjlnnhvD0jBRxAFsL7Zb81f9wNs0fCL9GeDmtSPntymes43yKkhitmFhpClOMgMZ4toKBaMhFyDwdWYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEI0p3Vq; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEI0p3Vq"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc52bd91929so377233a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789727797; x=1790332597; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8+pwYdNC3VCN+a2+7oSppdOeXRFWQYVln1yy/aWOmzc=;
        b=ZEI0p3Vq/w1nkrpBaDq16xiwrlyyhsiVFU5g/dKgEprl+nl1lMT26YITsYV3RAT8x9
         J8+qR43NuJjA9Uop0lPTIRyZl+0STBKJSgDxOk5mbkoXHqWqcoaIGJz+q6J3Pf0202rU
         aq1EAW4jTiKmuiOXIYkxeYX2FQsimcgTVDoVBxXb8fjeg1GnrAbkgvrckxKzpqtVzuRU
         s9PBq81o0yMHLKqgI6QhW27lIP1pBzLHFqpchEzW2qr0bUYoGw6yMIrRtdp5r6s5LlzB
         QkHmJsLxDsWNUjGDPfB4K2Jgwkk7JL4vZuU8NEhpSuUUzgf2yEL/936FkEYJW4xfur89
         +9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789727797; x=1790332597;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8+pwYdNC3VCN+a2+7oSppdOeXRFWQYVln1yy/aWOmzc=;
        b=qD6dhmZ3H0IdXAeDmnZ90wXBEY822dRoki2k9Jgiovc1kDpVN+UhqymHKfZ4ShZ4kz
         /hHqNb11mwq7qCUgXA46P8ffSmL+wlgy+4ha4ZGT6Ae3e5EX/i/VgjdT77bZppVXNvP8
         q0KhBHmWPMVJjiZGIRmD+U3l2lSbila2HdXhsA1ya/zhQyXtd02/C/2EoFYJy25Wzp4S
         LoatBUaiGPul++a8x/ZI/sTN/g1DHgTXPAVzHSEEVxO4gtT28wW0WiXSOxqg7okDRLDp
         JI/uBGRoAewyeSSXYVIZ9ID/zyZbIBSSRzuYz0V5VKOOLIN5eoHD+2dMNH10CqybGXRr
         g8hg==
X-Gm-Message-State: AFuF++lkuXMmbd5WaqP9EtVmL0AQRZVuowHMqZwO1oSZCvPlhdEIfytc
	pOJKN1oG5h1mepJjoBMdGKcRNFzZfn4u1STXfFiL2K6Smsa+Qrt4L4eOqPBNFg==
X-Gm-Gg: AYBFou37gMzDxi+TiVdYgAZZF4IdKdm6pOd1uB2+9ApM5q8n8KV5nBs5hoM5ZcxOI68
	Q9ln8Na2VHCfgEmuWaZXZW1JrFFCXOkpgJipjof7etSr1g/7xRBzoHhEqLYxDvzXPxq6OwGZv3G
	nx7izwki7D+MyrtDNRc+jf5+bKC0Fyb4SL4hgnmdkFyYutbyzx0mKitB6e9yIxXm9Fos4BmpiKS
	ONVRdHG5HkSCJKyPO2wMSDQ1pfTrANW1Cro/TKXdna+p+RTmI/GtpY4Jx4vn1xRPaUbY2C6wTK+
	zKSNiKfQFBWKMBlATg8ribn8A/wfFlypw86v6ZwbbvmVji58TZfl45vQE6PbaqQlfXayGqR1N7m
	gjxls2N4U3h2kvgAVNf50kMl5YRuhCzIWbSglkug9ikX3aY0qjCVSFvQlhVmSiDeK8FvpywB5/J
	nFtMhfJTovamxyBW5BR3ksQRN0EtRIk0cx0iY4cEKHV+6YegFveWPp6+PVAD0kioZgR1nDfS+Fk
	yN4Le0LTgzT8fG4+1w=
X-Received: by 2002:a17:90b:55c6:b0:39e:4c80:44b7 with SMTP id 98e67ed59e1d1-39e54dc70f7mr5063707a91.26.1789727796625;
        Fri, 18 Sep 2026 03:36:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.166.104])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287aab5fsm3311696eec.22.2026.09.18.03.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 03:36:36 -0700 (PDT)
Message-ID: <6aad1434.98a076dd.1114ed.2810@mx.google.com>
Date: Fri, 18 Sep 2026 03:36:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6121540085362406524=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ngocthang2710.1999@gmail.com
Subject: RE: [v2] Bluetooth: af_bluetooth: Fix double list_del and UAF in accept_q
In-Reply-To: <20260918075535.886816-1-ngocthang2710.1999@gmail.com>
References: <20260918075535.886816-1-ngocthang2710.1999@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6121540085362406524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1168407/

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       FAIL      0.18 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      21.71 seconds
CheckAllWarning               PASS      25.22 seconds
CheckSparse                   PASS      28.62 seconds
BuildKernel32                 PASS      27.86 seconds
CheckKernelLLVM               PASS      25.40 seconds
TestRunnerSetup               PASS      571.80 seconds
TestRunner_l2cap-tester       PASS      17.28 seconds
TestRunner_iso-tester         PASS      25.42 seconds
TestRunner_bnep-tester        PASS      2.77 seconds
TestRunner_mgmt-tester        FAIL      56.51 seconds
TestRunner_rfcomm-tester      PASS      4.01 seconds
TestRunner_sco-tester         PASS      7.07 seconds
TestRunner_ioctl-tester       PASS      4.15 seconds
TestRunner_mesh-tester        FAIL      7.63 seconds
TestRunner_smp-tester         PASS      3.93 seconds
TestRunner_userchan-tester    PASS      2.83 seconds
TestRunner_6lowpan-tester     PASS      3.94 seconds
IncrementalBuild              PASS      21.75 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: af_bluetooth: Fix double list_del and UAF in accept_q

28: B1 Line exceeds max length (106>80): " - Move sock_put() outside of the spinlock to avoid sleeping in atomic context (suggested by Paavo Helde)."
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.015 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.525 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds


https://github.com/bluez/bluetooth-next/pull/787

---
Regards,
Linux Bluetooth


--===============6121540085362406524==--
