Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5D01D5CD1
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356253; cv=none; b=Js68qkku4eMyGxw1ch1MnQjtNnxdIDjt9nI3bE31eEZNYnWbGPIMpbtV+hO2Q8Xb8n132Exogi3o8bkK3IuQ1X0R28k5R5+TmCezQM7z43ALKaAEBjIZdbH4/9lxpf2HPh2cS+g9nwRwi8HqlgEPM0kjOwb1UVnnsmBBXG5Bl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356253; c=relaxed/simple;
	bh=q4Hv9XF/VXY5UQcWKFr+1/YDcGKDIiuOy5apRi7OJuI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Cgq0xswirR7TawI+zUjyuxKUi2u8ob+Pu1fJt6U6WlgMr7hztHysPg82QUefeD8lDZnUWKzFfBm45BDD+BDkM01HvrLdKE30eKddcEjMCKlNFMYyMd6o5mPF49kcWgVnCiYii4mKB+BSk49ZcfoLpTHfcHm/W+iYyWeOulGeE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXrCDSPC; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXrCDSPC"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8954a050c19so56740326d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 11:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771356251; x=1771961051; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W/gC+I+gdW/klj3TJosUGQOyj8kxcM2x0PMF0PTm3ic=;
        b=WXrCDSPCVReSJzJ7ZuWc7KRj0diqiFF7SObpxBttogf9wgc7bHnq2qGNOTDkrNJdLd
         ohAl9uHyaRnA9mpS5/LW7sOduNJ4S/iIneoqVIkCVEkRNzxnowxoXUwDtEkMvPMQRr+F
         mTclHMdm6+sLD1zbGBhz1HGYNIRXuooBJUTE0QVlPXonwKwWY+dUA7ulAeFEgh4eHGOA
         yzjWS3W1tjEAIwgX0jJ9hjrDfTGpFCacWyIwdyp4hn0U3GrrE0gMYZ8QZUOVhuUvtkvG
         +X/9ZnINXmV8rdebWOQJ1x9FrmFbWasUfpMJvriDdzdv3Hit27PKQHDBs3TMeUiU+TLm
         LK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771356251; x=1771961051;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/gC+I+gdW/klj3TJosUGQOyj8kxcM2x0PMF0PTm3ic=;
        b=M/BJ+MbOnmCCNpNTT4oJmzQ84T7iTntvP7jVgfaEObHJVg3yn9yFJuP9pvkclHpJea
         KVnubnH/fWoI6vTe30EDjXzD9NHkTDUA70uGdSkYRnKPDCP0yaEtqZVt//DhlZWxBIGQ
         ifpZOE6Ej5n5XUlwxpGDh+bJRIS1Q8BApPJEjPNanAOSsRFXnP5xqGckeBezfm/mHRO9
         fm4RgovPoFwEBbM+t/iFEtwzns7mI1cZpbIKWWFLLqL2SzjGdVEfOgQlu1/z2KAb1O0s
         td+uDsp1it3wb62VgIdJ/ybXebrtYlUxzYHLzSSp/syynQHT1qbngpx1mwInfEn4QHr/
         G5bQ==
X-Gm-Message-State: AOJu0YyDWlAKdxgItJ4uZHLsXPn98FWSzYd9hV+4cktL7f08eCi7NNoI
	+0YYqrwO3/7A6cVEQbUzN23NFD0CbjBPQyfOKgs5I7U7rfm91IJW0Ar1lE45x9kd
X-Gm-Gg: AZuq6aIeWoLOQ+p9/j2mC0Hfk9HNjX6o5l7A/5GkSh7bC97M2MJ1JwZBb/HJQ8hz9BH
	SliykGeuRVVGjv5g3XP7vAWIod+iEPJT7yhbg3dU8yVnyMj4C5C7kiW50xmOIx9DTnYTLV9dQzk
	RhPVgG/dyCL82y5xapLi+bM+mnpwrLQwgGZleoGEu42rO4cU0DrNq5PmYe57MsN8esywCKqXZQR
	K6LjHiIKnwsBF8buC8XhnahwHwLgoSFvxhtWhgsHIgkOpYV6z1ySL1D5ez5PfRg6SVWccLuVPtF
	koiSvn9UM4nA89CqBsBeMMgM6YjQ+nw9rdvX8+jryX+j58z8c8L3eiMAWab1AiuYqZfuJysWOHO
	spGIatUiypl9DOTIFzoJ6cVO52W3s7ICZnByGKjz6VhZiqmlvoDMklAtSFCCKTYCy+wAO5Vrqwr
	WpaT0TYb3dh+89HYG+vn0Db1aDwTsf
X-Received: by 2002:a05:6214:1c09:b0:882:4be6:9ab9 with SMTP id 6a1803df08f44-89734948f9fmr230218646d6.54.1771356251108;
        Tue, 17 Feb 2026 11:24:11 -0800 (PST)
Received: from [172.17.0.2] ([20.109.95.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7f82csm171162456d6.4.2026.02.17.11.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 11:24:10 -0800 (PST)
Message-ID: <6994c05a.050a0220.11022b.e7d8@mx.google.com>
Date: Tue, 17 Feb 2026 11:24:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3337317528834187538=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix not checking output MTU is acceptable on L2CAP_ECRED_CONN_REQ
In-Reply-To: <20260217185620.2461151-1-luiz.dentz@gmail.com>
References: <20260217185620.2461151-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3337317528834187538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1054964

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.99 seconds
CheckAllWarning               PASS      29.44 seconds
CheckSparse                   WARNING   33.60 seconds
BuildKernel32                 PASS      26.34 seconds
TestRunnerSetup               PASS      576.09 seconds
TestRunner_l2cap-tester       PASS      29.66 seconds
TestRunner_iso-tester         FAIL      64.06 seconds
TestRunner_bnep-tester        PASS      6.49 seconds
TestRunner_mgmt-tester        FAIL      124.94 seconds
TestRunner_rfcomm-tester      PASS      9.83 seconds
TestRunner_sco-tester         FAIL      14.73 seconds
TestRunner_ioctl-tester       PASS      10.38 seconds
TestRunner_mesh-tester        FAIL      12.50 seconds
TestRunner_smp-tester         PASS      9.02 seconds
TestRunner_userchan-tester    PASS      6.78 seconds
IncrementalBuild              PENDING   0.87 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/l2cap_core.c:7773:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7774:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7776:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7777:1: error: bad constant expression
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.112 seconds
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
Mesh - Send cancel - 1                               Timed out    2.624 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3337317528834187538==--
