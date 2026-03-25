Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3A2874FA
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454723; cv=none; b=lnkofET39oZGiwPla9XwLKtzV6+prJ+goZac8GFZI983QAi+7eIEAZm+XAWnfxDURBcp02O2C/8pZ9vBxJcQWm6LT554gu1LOX1CDX1QIpWrXIyE50vwi9qBES1FtBOZiM2317gM20FFJKLQKK1W0f7rD+S3lXzW0Z25Hp8f8Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454723; c=relaxed/simple;
	bh=SMBMbtsA6C2A0VQs3MCYBU5SehxFJaudmxthVuKlkzY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FkkceMZqw8ppuNHIiTpNLH7eOLVGeZcc6UxfpCWnhVu9F+PSwyFp0DPbzKB3/TRxXgICqTz5pq2fbSwVMk2a217iwTMAl5aeX6wHlG5VPZ+Mzc8b5WENOBXy8BH+yQR9SnNL+aAVPbr4ACFO2UUtQJ46KfJDhc5CenhC+dPHEkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyR2+6nq; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyR2+6nq"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899a9f445cbso75063306d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774454721; x=1775059521; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fBnc07HlTgVCk4i+HCLS7RH+3wu89zDBVTNQRDFqMew=;
        b=TyR2+6nqlbiQVTjL4cSgR2X4novCEtWdVD6USJjvfpRg3c0fNrYxiLeYQojeplbVQ9
         7k5jaSLO5ycQM6DvDNFpwgU+IqwyaAiQJfuIV9NCOAxV1/7+pGmONJtuop1h0RobJ3lf
         wh0MhwmgMWLJInUSWndo/OycyRHx8WVJuHXMg4EPxxGJNp2zR2W3zFrGyY3e+LI7xNya
         +NajfJxu2VnRdjN79YHnpS5WiOu+N7JT3CzES1EHRiybGz1teseYg+oQQhlo63CeXcdH
         0ORwSpbBzx+54bOvntX5IZveMT82kAOb0wsv9DI/SGCdPEi28MZjodgU/jXwAsNWzWPf
         TmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774454721; x=1775059521;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBnc07HlTgVCk4i+HCLS7RH+3wu89zDBVTNQRDFqMew=;
        b=LtfMyyKJs1hQKLRCKrLB6EG8wMchPyvVKvyyIhgNpgjsxKbHpZACk3mCGiSBBQ7ePi
         BhOiGSs/nlaSex2IIUN3I503MGG7rNNDzkz/CnwY3Rk1Bf5YHBSkPCeizMkFn/Xj49E+
         Ho0UOKq3vqgAlD5zAm+g2ZzeQ1YrYoZ/jw2nhENv5CCRTEeV2+zh7M37/a/Z1PocV9zm
         MJMZVt144WkEd5r/cov0KdFCzPeSZXPjyXKgQKpgFn/UGJjFYfuyrXIf3u3e4F6SOfEA
         ZkwLP6h+QWzDeSgGCO9xdAenZedtz9RA+drOt7sXmquDx1+BOp2qqBZj9xVzwALjiYEB
         wLcw==
X-Gm-Message-State: AOJu0Yx+zmxhvHFpqtpG2xJfoDOXFNvO2b1ovWU3uHnHDo7XxOLMAQ3t
	MTOU/75+qea49puTgRFSnzY+5FSkp17Q1TyZIyePIbNwCqvZWybrr9kIUq+ZRw==
X-Gm-Gg: ATEYQzwiPbf5L6kz+ofNLKKiaboDau4yn6DnU2eCPy+wiovKHR05yWHJRGnDjHinqm4
	2ZuCRiupPGm8WhQawajfVgiV8MxxrhZB6ryxVxfKXVxNaO9Kl85xjdxViL13wRj8r3dZ6jHX+Dp
	YCadn8dzXR0bNgfsw5d3CNl6olN9w/sPQwQ5eBLvFurHmlRZxj98zSFF9pCSuMzGdmWauEXAlfA
	7u1yNJj/ku0FIDYzICwVMVS3/R7jdMX9nONuM21suZUXzNRQT75AqpvVC35jakTnNOuHe5/ysWh
	96uj6MzLZDIrGZPPnfXlROEIsvNVInXpDyDdzIXdXQVvpXm3YD6AQVMcA2EwEPUPt3/UGesSdb/
	rp1Y0YXbiEiYp6s7hAKHzeFG9cZyrN1cnCdWJrRHCoDUMCMn4jB1ToCQmGC/gi9fhoPRVYaLYIt
	h/jDaeDNW6nuEgnVKBFh3Gscv7CfWy
X-Received: by 2002:a05:6214:3214:b0:89c:3ff5:78de with SMTP id 6a1803df08f44-89cc4abf41amr59214546d6.51.1774454720841;
        Wed, 25 Mar 2026 09:05:20 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.44.10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5a24be0sm635126d6.24.2026.03.25.09.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:05:20 -0700 (PDT)
Message-ID: <69c407c0.050a0220.1b0ce1.e937@mx.google.com>
Date: Wed, 25 Mar 2026 09:05:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7178264927201570627=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix UAF in le_read_features_complete
In-Reply-To: <20260325151809.235680-1-luiz.dentz@gmail.com>
References: <20260325151809.235680-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7178264927201570627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1072392

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.76 seconds
CheckAllWarning               PASS      28.63 seconds
CheckSparse                   PASS      27.73 seconds
BuildKernel32                 PASS      25.46 seconds
TestRunnerSetup               PASS      569.47 seconds
TestRunner_l2cap-tester       PASS      27.56 seconds
TestRunner_iso-tester         PASS      42.16 seconds
TestRunner_bnep-tester        PASS      6.35 seconds
TestRunner_mgmt-tester        FAIL      112.16 seconds
TestRunner_rfcomm-tester      PASS      9.25 seconds
TestRunner_sco-tester         FAIL      14.23 seconds
TestRunner_ioctl-tester       PASS      13.19 seconds
TestRunner_mesh-tester        FAIL      11.56 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      6.56 seconds
IncrementalBuild              PENDING   0.66 seconds

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
Total: 494, Passed: 485 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Adv. connectable & connected (central) - Success     Failed       0.132 seconds
Adv. non-connectable & connected (central) - Success Failed       0.128 seconds
Ext Adv. connectable & connected (central)           Failed       0.174 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.178 seconds
Read Exp Feature - Success                           Failed       0.110 seconds
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
Mesh - Send cancel - 1                               Timed out    1.958 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7178264927201570627==--
