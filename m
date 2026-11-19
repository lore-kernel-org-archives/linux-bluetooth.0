Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049963;
	b=FtNmfrDB3i4ImBsdyrXlmxaewOOLsiRbxzrTLZGdGQFV5hTJb5NyBpNJGnIVkRdVkh/d
	 a5pvN95PoJlnP3QQUTuQl5XyWA7oH2LC3h3V4/zSUVYAxh74kz0bLdkBfErkK0mqYR7eg
	 9LmHxDRNGAKxVU5cC83u4SAZUN3Hz+LLIVaEJXZON1rJi/YqJkdsqPjon1vefW4Gm+GcS
	 tVAvonmVz924QJM5oR1VnYD36ejKhQPGuz/TvsDgULQbNPVQqUxLMi4o/bTlvhNxZX2mY
	 KUZLIwz3xdTEp2ZLS0PIyO3V5Nh8hXZQwc8qW4LvZFakDYAV49v4gmn1vHW1GyCNOVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=WetNOsMXju+ZIoeOepo3nLt6UbEd9w6P/NdVIrwMXqU=;
	b=NddIbGPcG7rCU6UMrjTAygKOw+bWZWALnKVQr8zh6+QhX8yH85uMCV55yuuVIDuAw87w
	 QnhheNiXAljhX3wfQWg79UtcfPER4qLGG1vUBsbL5qogkUq+JuRzW5icaItax7759ZhJK
	 3MiCCZV+nBI95lFVk8Z9kPrwhcU7iA+NlRZO05ipb8yidHgKpjhNtIAlsH/NAO2e/KyIK
	 rxwBlO8ver6cBM5g1NHYE20OG2za9p5ZQTYXS1dg8JXTwdrI6EdgZNHnCO2LqTeBB7PAg
	 +N7ke6UorqjYZgU3sYTKzCz39f9FInLmCvVHDNrxbpc/ovyvsbSHu+FOvpz7cnldGpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uDWV9Bm4;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C35606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1C35606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uDWV9Bm4
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-862df509d48so332515a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 16:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795049961; x=1795654761; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WetNOsMXju+ZIoeOepo3nLt6UbEd9w6P/NdVIrwMXqU=;
        b=uDWV9Bm46njNG0lxyUNRekVh+8z2r+hLlnrAB/WkaeCiZ90gLqv9hIYlryEKFU5ugI
         Cgwy71TnC5BxcC1J61F7lqKhbN/HizrCqY99TElZC+u99esePAgvY40UtOpOnncps7hb
         jaYA2C+S4ndfiZiLHqrbuaq8g2A+k7TInWKSjVDEr2kbkRAXUdji9ZqyesUkhvmrSwOe
         3w8FTKZKsQoG8J3k8TgtIiNt6a6k15ZIweBzZK441HQjC9bt4lGVZ3tJ1fuHjg4H6b8Q
         zurm3cufLWCBU56v3ciffrEdIfaXu1rJavrLPNA6/MI+sLP8cL+39MOi1dUyC7LDazj2
         bxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049961; x=1795654761;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WetNOsMXju+ZIoeOepo3nLt6UbEd9w6P/NdVIrwMXqU=;
        b=zZ0oNc7h5o+h/35fGNS4m5xkxyWSbMmDjXVlWkaEO/W853YiDIZ1aaiAV1FjC+WeFk
         rIIDkQkWziq7AIR1BBe/+o40V8iO6GbaRkBNaKJBqWhicmDSMRkFyPQ7wZzy9VYZR9vP
         3/BJY/E1FrbsddId39vBa26KM4GJm3bdBgTqagxP6O670/9pO7q0/efPZQ6+1bqDABG0
         s02iIIkbEzwM9PZXuOuQfvHCPCjtNq33scBGLvNEkzC3C96mKxStBmxWqr7chsQn4UDn
         FITchsDsLv6dVHmYNHnSKiTlkqc8N2F/PtAZwZCY2CDByXuvUSnTIt4eB0Ly1TepCCS4
         9jug==
X-Gm-Message-State: APuU4Z/FTA6TDROk/D2l8hsMMGyi4HtfxGms92eT1CJxxZIHgssty/ui
	8qhpWn/CeqPkhBzbbb9YaJgIp6Y8qYC8NWOkZ3NsJhm5b2OVmI+qFR0NHcBY6CvX
X-Gm-Gg: AYBFou2KPsgPuIWA25ZqTDMJTaFLsZfJ4yucY2bR84mxlqML4W9cPbkmfIRFkJk7J82
	JClq3pWiX89fzJEMqZ/ks6NbS864VgljPFoUTRvPZ5HIK0/EG0NHWx+SI2Ee2sCZVVDm29x3erM
	1Lxa0W/HfDB9HQ3SvmkJ0yTzTb7KaEBvlnpHfFqyNWf4uLC6ScBLiss8LKPUAB190KFOK0weUcq
	RVf99xcIDTw8cGWzVaIjnQiY1JZcw/BUcJFeC0LeXCu3LPcez4aWYSPF10CFw5hsr8OZd7wj3FF
	VE5Jx+gnRol9ZNlbspIZvO3oDvUT6rDOjEneRLqIEF3Wlf4rdVUPaWC/ouUDY6WggootRT6aRSQ
	R8ZtEySK3UihgE8w/Z6jwrBLMlgiF9vFqO3Kt255ja/OMg/D/0u6FbBLY2Q+kRGXUu4dV/mBfFW
	2so/B5D6njSOELXtJYg0fyp/8jBwTVoilMTyXRofMEHvTEs1jERgrLPfjppgVLZiajOF7lL14Li
	Oaf5AdYIY+xg06iBqW6ncH9CTIcoZ/6Zl2sGuQLg9VcyxHERAij9N1OHMVMBcAV
X-Received: by 2002:a05:6830:4c0b:b0:862:a6c5:8f12 with SMTP id 46e09a7af769-863040c117bmr221455a34.11.1795049960226;
        Wed, 18 Nov 2026 16:59:20 -0800 (PST)
Received: from [172.17.0.2] ([135.233.101.53])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f023a1c7sm3268883a34.23.2026.11.18.16.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:59:19 -0800 (PST)
Message-ID: <6afe49e7.98a28ad6.296de9.d3dc@mx.google.com>
Date: Wed, 18 Nov 2026 16:59:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8571525968925834933=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Reject user coredump until firmware is operational
In-Reply-To: <20261118232043.1987049-1-kiran.k@intel.com>
References: <20261118232043.1987049-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8571525968925834933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1215474/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.86 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.72 seconds
CheckAllWarning               PASS      29.37 seconds
CheckSparse                   PASS      30.34 seconds
BuildKernel32                 PASS      25.09 seconds
CheckKernelLLVM               PASS      27.35 seconds
TestRunnerSetup               PASS      585.68 seconds
IncrementalBuild              PASS      24.25 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] Bluetooth: btintel_pcie: Reject user coredump until firmware is operational
WARNING: Non-standard signature: Assisted-by:
#122: 
Assisted-by: Copilot:claude-opus-5.5

ERROR: Unrecognized email address: 'Copilot:claude-opus-5.5'
#122: 
Assisted-by: Copilot:claude-opus-5.5

total: 1 errors, 1 warnings, 142 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14999107.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1154

---
Regards,
Linux Bluetooth


--===============8571525968925834933==--
