Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E539C658
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2026 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271636; cv=none; b=X30efdSAXhNHWry++1Mzw2K2bp4lUjL6ZZMDGYywk8k7pgcrBViGKC2y9AK6/L875VO7HVhWDc3MiGI1tAZCkO+n05xTKNxJdWwLlUedhkbx6Aib7NBsTUYOoBc0OTq5X9nrqjuZo7yK0bmk9ZL0Nir6eCEEFXVR9fPPgJ806y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271636; c=relaxed/simple;
	bh=kVCmKa2NkeSjUhAFh0MSdYUXNkqEA4MAGjCSB7SEWAw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jjL83JEx5W59Kg6YndZQnBzylkRSTJU1wMT0lJsmEoIHM4o036am2UVUHiVqhj53GhAJIExYoTai5sG0fvVGU1uOnDJk1q0O2RAJtjG3E56Y6SOXY/IIWdAZjw5cZ5VOzf2Cy8Gre7pRNpZ/Yi5Dgj9ge9XTv8Ru6MBBpau/m8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBY9ONVk; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBY9ONVk"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb20bcff5aso366492085a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2026 06:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774271634; x=1774876434; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkdFEtfxP4qWkTPzBS9G4J5vP0E41cXVRKFue30WnLw=;
        b=SBY9ONVks3XHeB0rPtsuCJ8mZBkFhEvdNLohFwsEPyrQ1704LGydaTIiS1nchSLwtJ
         4QbGG9pa8xWy1eO3o8l2R+h9Z8imgr8CzWGakot51DOlKiQTlKuq+EseQefYzjAm7hnD
         yyBjjjyptDKdiOKyP00DDtybTvXAPYyeytYzKHrDLsrRlN5uGrJwBgHfqBtpo4PCgOQH
         SmBT8r+jyPP2AQ3zxQgUUy0Ms8ncDBiga8a8UUAyigjJmEA/RpZyvzSa04WV41wKD8qg
         /J091Eg2B3r0EhRFPA+7hCQ/ishTXiPDFx1/trIJD7o3S4ePZR4zKgvG0DVfiXl5VBjw
         Lw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774271634; x=1774876434;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkdFEtfxP4qWkTPzBS9G4J5vP0E41cXVRKFue30WnLw=;
        b=SCiFqUzGmVznFCIANjzOgVlVV5wugC99VO7NahwBS/NkDydqZYG5A2LWcE/NilmQGx
         ROlwQv3EbmnGmplKVlpRoGw1DSoBN6l7BM6b/0We8oZ0ZikfVp/wL0OsslokQLR7iHUA
         TYMAgivZsDkfFxV7thxn6VlO+YyotakBtsGfZmAnb4g76Z/XrDNKgo+v1ve231vmTiyL
         RfwJtlGQA7X+ZJbR3Tc5bJA84EESpcFyELRFGQ0qba8blOxsQiJqiJAiyYDduexCiG50
         /HRvMp44sI/C9jYX4ELP92Iw3WjUd2VB/WRf6LO499JIkKAZW9bYUn+jcydBW0nwpdkI
         r+Iw==
X-Gm-Message-State: AOJu0Yxj7Bhfi7nQvKAykfSPtERIyjqgYOHCJoGcbV/8oSOuEG2kxOH8
	fEXN99Y1cRNHkuqFqa5XwtY2uXkE7paYImY6jCF0dLRUAzqAVyAyjs9eq0qFNg==
X-Gm-Gg: ATEYQzy5lQGTasBq+fbZa+DtHQTM11oH/cfpZOepaELJyxkHVfkBzW6QkrCMtGYbccn
	GFebCxyxStzdeuveLjCGu4yN1l3cpXleqpunIrlpl+Tf8/Ma68I0+a1P0pToNk2HMCXGYCrc2jm
	29QF/bv+PaW9OVX4c3411Dd86FrX/F04EBuMEbJMfffVZu9+BPOMo+1eTZ9Gjv4MMLafivK2KoR
	FSovc/mukxwYTRHs1oa5T9/UgG+Vw79AhFpKVMMubEEApq43IHbgWqr47Muo6Ul04zxsxGAQ+mH
	ctu4CfbI81xmBsRFlCHRnMvaHw6WehNnbzwyU9liX825z2RuIy8GQHbxBK38qOCaW2X1UqBr2+u
	NDzxtpnqm0dHHVP8Iaukwiq7/hAh7+QmvaYT6v7Y2AIjEhP+jVoR2ZJSD/BevfqW4wuXJSJdXeh
	HcETn3PGigNVmEQRqxfRmMor05poJJHkrmPHAha7ba
X-Received: by 2002:a05:620a:2982:b0:8cd:cd30:779e with SMTP id af79cd13be357-8cfc7f4d0d4mr1861382085a.42.1774271633842;
        Mon, 23 Mar 2026 06:13:53 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8e1fa4esm794097585a.0.2026.03.23.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:13:53 -0700 (PDT)
Message-ID: <69c13c91.050a0220.2b7263.6b19@mx.google.com>
Date: Mon, 23 Mar 2026 06:13:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4647935409966248659=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: RE: Bluetooth: btintel_pcie: validate RX buffer tags
In-Reply-To: <20260323121730.75256-1-pengpeng@iscas.ac.cn>
References: <20260323121730.75256-1-pengpeng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4647935409966248659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1070881

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.11 seconds
CheckAllWarning               PASS      26.65 seconds
CheckSparse                   PASS      25.90 seconds
BuildKernel32                 PASS      23.75 seconds
TestRunnerSetup               PASS      529.10 seconds
TestRunner_l2cap-tester       PASS      27.84 seconds
TestRunner_iso-tester         FAIL      30.53 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        FAIL      113.89 seconds
TestRunner_rfcomm-tester      PASS      9.49 seconds
TestRunner_sco-tester         FAIL      14.54 seconds
TestRunner_ioctl-tester       PASS      10.18 seconds
TestRunner_mesh-tester        FAIL      12.48 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.60 seconds

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
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    2.755 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4647935409966248659==--
