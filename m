Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500712;
	b=3Qgw5arjzOh0OMkK76kcSvtvMPoudde0TzX+YGUK2rMOcYN41NYJsvlEU/R9pRPO33n5
	 Wm8WDfOygHfTgqF1AM8okPf4XLiX9ZK670dUQI6/GdNUAfNAojtmLBKPZJx7HSFq22dod
	 KxdjHzrkfS49asMJSmXLQjJ+OoX98GtpcucVP/++uHuvtMYkqaOJvSTUxEMjuo7g3WvuY
	 kdHnluAlcYN7fUSFfI2c7DNyvOxrW7/RedLB0p9gBZV32W+POnxZBcaNzttJYNuooMrlo
	 NtRpQVWFvZ/U9uGMRFgNqMatVT44q+ITa6AS9sojr2uKH9AquxnVUq8TrzYClIy7J8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=vyqSXXPNW9QLVVN8l4pvx7x38LrynPTo1SZNHtiHHJs=;
	b=5Pc+yX50+0oHIBvmv7zlvdA+PR2B/BeAOmTUtD0XJTMMsKQ0Gu+FhG/FPVGFZDSk+HDY
	 Gd5y3w9S3qJ/ByEUoOXjqT/Qh3w+6LXnF+h7VGFGsDsxyaC2LlJDWVLbwiewoKCpjCgne
	 Djn6QneVLm8NVy0Mvsv47TDXPHttlUTMHOltm1581CzQsT3uqyCvrwa5/ruzJSPZEh1y9
	 7un5G7iaraA0250TVmoWhIjpJGzMUZYQ+Km/Gb4EIwoXpsryIcUb2SrVUMD9Hwk5oVSrf
	 KPmk8H7zip9DvnGff+KC3jt5h9T5dUdA+M0euTCM3RGKrTzS9NCCne8ucAJi4Z9Z36Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PwDxaDug;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C81606A319
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 12:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11C81606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PwDxaDug
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-53ec9237600so1244150b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 05:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792500711; x=1793105511; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vyqSXXPNW9QLVVN8l4pvx7x38LrynPTo1SZNHtiHHJs=;
        b=PwDxaDugi9VWo1Z/9rcUtwHpy18cTM3vPVrujd8QjTMxZp8K3z6Bpf2BH1uvvicTYs
         NBTBKt7w6PeHTqBiWH7zdOzCruf30rjagoeEI7dQlDpsP4xh+YWZKEI8EptWBJczLF4I
         uR85EdGPoWwT8ZZsAMiaPEAOQYCePO8FFDzc7naN8qn2I8rAiue6uTUGdmT2UZAewxrI
         EsojKEx5F7woURmBc1s9pbqX2og/6MlClCHCIxRsH1mRCXlJVFTg9APqlHrcG9JMZ9IF
         W9xTR+ZzGcdoL9Ltg+FupXGqyD3R2Ck0CIwku2FtjG5i9QWPIq7UDnaZR0wSQqZ9vd27
         uIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500711; x=1793105511;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vyqSXXPNW9QLVVN8l4pvx7x38LrynPTo1SZNHtiHHJs=;
        b=2gNmt4dpo79xvzkExRfWUe2OyhsN7w/IccAuomvCwj8amPKDwmlX0EnEDKkpziZ2iu
         G8IzsYli4xls0EVtIkMt40QfZKItkwvoZ7+LiEGgPfocTsQ6M8/UtJ4P41nCFPKvgng9
         PaHd42jPbnRE/WmKnGnXcUsAWR4Ut3YkI7fWKYsVm0Je4buTPucLH8QPRsuLPFTUb50a
         jem50GcSp3sPgKVl52Dcu4jCs/ghhABWYGqMk6Ztmi/eYLtxpmwyWsu1XMfnLfmVKvG7
         7IlogH4/J0qeYxeT9nFVse2WRF/VOl5SpPOBf5Zt2fl0Csi/5bxUmdJMXgalnGXWhs+H
         KD1A==
X-Gm-Message-State: AFq9FYLZCQP8Av/9yLs8RCOixLGiOxZZ8j0TvH1xhThB4g6AIDfhThzz
	zqtvuaKw8MLpypBraIXh2x8gNjMTS8Bzfops/JkEx3YD779HXVy9HYj2gUuTsOrj
X-Gm-Gg: AYBFou1WbCMns0r8Uq/NPJ5ZIhGV2fogul1GIAKoa5VJzWT1GL53KzlNUDeRUS5GmKG
	ROCRBFN4DN4PBVzwUegO5dLSAH7B32sCYjXs8TC9lfczihvZ2eKJau4MuirufO/WZgGCUU2HxQk
	0XrumRf+1a6xG9YcuCs2bmV9fP0wdZsZSVYO5vuxtWfb2Dq7T3qcHwI61zwVucjZGkABsPRfkak
	LwBRRnSnmxUckzlY2sITR9LmqNVKbqV82HEHTI9cLKwq1SSSTPwSyJ/EnabJdNbFiMNC2WrLuO1
	bcj+k63pSeXWDjTszqCxvMEN70sg04fu7xGmhjkxGMQrn0LXlDXj0DBcHpH7anhh1aqvRji8JDr
	ZQ61Vu91Pyv3tK/Z3cZs/6g6WIuFIYcO9tBCvPWBdqgrkj2EgoIjAv2p7fuFp7cKs4xXTBWeAcl
	61sfAHzmL3AJJSSxoGhjpygWoYuRW3OKm7QJX1jCps789uqbyloV+aXJJElBwW52r8h5DKV7MrX
	ggsT5Q=
X-Received: by 2002:a05:6809:191:20b0:54c:7bef:90d6 with SMTP id 5614622812f47-54c7bef90e6mr1648834b6e.4.1792500710852;
        Tue, 20 Oct 2026 05:51:50 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.215.84])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b5b2e59sm10576058fac.3.2026.10.20.05.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:51:49 -0700 (PDT)
Message-ID: <6ad763e5.efea58c9.1b422d.41d7@mx.google.com>
Date: Tue, 20 Oct 2026 05:51:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0389630855671462193=="
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
To: linux-bluetooth@vger.kernel.org, valentin.kindschi@fiveco.ch
Subject: RE: [v8,1/2] Bluetooth: hci_sync: re-enable legacy advertising on resume
In-Reply-To: <20261020105150.2863631-1-valentin.kindschi@fiveco.ch>
References: <20261020105150.2863631-1-valentin.kindschi@fiveco.ch>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0389630855671462193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1189654/

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.55 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      19.53 seconds
CheckAllWarning               PASS      22.69 seconds
CheckSparse                   PASS      24.50 seconds
BuildKernel32                 PASS      19.81 seconds
CheckKernelLLVM               PASS      21.35 seconds
TestRunnerSetup               PASS      426.57 seconds
TestRunner_l2cap-tester       PASS      15.02 seconds
TestRunner_iso-tester         PASS      8.99 seconds
TestRunner_bnep-tester        PASS      3.50 seconds
TestRunner_mgmt-tester        PASS      80.87 seconds
TestRunner_rfcomm-tester      PASS      3.99 seconds
TestRunner_sco-tester         PASS      5.06 seconds
TestRunner_ioctl-tester       PASS      4.22 seconds
TestRunner_mesh-tester        PASS      5.13 seconds
TestRunner_smp-tester         PASS      3.97 seconds
TestRunner_userchan-tester    PASS      2.88 seconds
TestRunner_6lowpan-tester     PASS      4.07 seconds
IncrementalBuild              PASS      24.39 seconds



https://github.com/bluez/bluetooth-next/pull/967

---
Regards,
Linux Bluetooth


--===============0389630855671462193==--
