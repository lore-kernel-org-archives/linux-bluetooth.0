Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503620;
	b=5VOwusuBEox8ZitO6zboBI9KBrMPglOoSj8CxonR6RCKAu4RtU/GQUBhV/S/RojS2ElA
	 tsulMIiIIeQL57z27b6UUlN5B3ewxP+5DVtBReS1j8X1EReR54p0DxP5FLBF4q43rmZhz
	 TB7P9g1BHJ9Hk+8Fg98hOhvH1rqfV4m8z4WPUMwhL4jnDgi6WhCujczJg0RGmHYnPudU0
	 Sbb/3XT/RrxtVmXtghj+hhQn+Y/AOFuJ2ssO7B8u/BzESP3jwDZNxsV2Y6IVIADY6QiPQ
	 iAM5/HWxdutxGJb+hQdbcP00GQOQ9onjmWUfXc8gFVgSNNJhXZopGXRizEC2HcwdDkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=T2VKUlRDrMTOwZ+Jg2wfV+ZKu4eNEdbc8g2FNf1kkHM=;
	b=VMvGjGbNBAfi5u/rUDfC3FqN8RZpFLjZKaKEexYdP6aDxKgov9CqADMtvj3TGDcA+76J
	 8Q5thHo0pzXf/xROoZ2LnigxVXtZeIWWioRGK84CdFQOTcAZWyr6uqcqb2AeNJPsHmfWy
	 f/hcKY70PiCEw8ryNt5Csc2VPIegZ7x512CsygWwbayp6Ljk5jY9UMfIBNq8f0cOBUbOF
	 z5r+2v3/n0SvjhMQAAGfC87efm1yi0EsoHpocVFcyPA2lCaOWtH20Mqb7cYbyIgJpTHzK
	 7df1bkUaiyD9cwbV/puQSJSdoA3/T2hoa4G27N6sFnT6sy/JX4z9zsA9Wn5AuAruExg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hF75Pexr;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E5C606A331
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1E5C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hF75Pexr
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a07078200fso2086897b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 23:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795503610; x=1796108410; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T2VKUlRDrMTOwZ+Jg2wfV+ZKu4eNEdbc8g2FNf1kkHM=;
        b=hF75PexrKbfxo+Nt6a0MuPbrig12XBrwwUjzU6JKGavikgJ0MeMHqEFI+eJIevFRUT
         By4zX9XwX/c259S9K4CPgEgdAa/ZOmnIEfasHAPwqPAMXoWe4SrK9r9XjxiJHlNfXjDs
         3fNecLhrMNvoNJ/z9VR/FJZELIrOpZYAJOA9m2QnsOAPescWNs4wknfNPttvFNz8dfaX
         H5OkCzvy/1pZTfTbvx3bvvsaaJtWWHoUQGEFzPHn3a5rJC8HaRenZXZ9xRTFlvXb6TuO
         uwvHj6QlE+xpnfjdfWMNNxrN1bI/TdwFhtz3q+jRgZ+FN/ag+ntQ6fJN3BApLMCsTEEl
         IwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795503610; x=1796108410;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T2VKUlRDrMTOwZ+Jg2wfV+ZKu4eNEdbc8g2FNf1kkHM=;
        b=Svy6mTA7jp8w3c4ihYhsbPcK7NDLJCHmpeGbfD08qs8sENGUYAkyjJsKvfZNmyCivE
         AHkS/gXF1vLj/BKJFJBKV8Pfrn2c5piG4w4IDAhaTqthR/h3D9+S12UtDNd3b9DNzhju
         uF+bgiMPX0KQM4chVBOyi7RmG3oyiZ1E7vrsdZWQLkB4JVSCvgMM7njh3NOCqyNYKlPg
         WxiXD2e/uD9yczF5ARhBLb/40Wp18CnCjsntC5XEm/6wo0SvKj462XejhYL9tRNm3erY
         B/0ocafSqNP/YoXgNzGyK774hVNCXm9a3TYMQuSRTLslVN8bxHqLAD3D4hiBf3zVhMMC
         MNpw==
X-Gm-Message-State: APuU4Z9rdA7Y13NRZQtfrf1fddiOR6IYMqJdAjrRzS8IN/I7kINlRMC/
	xGnMmp9ZRw41woSlqQDjyuDT81aBUO8q63fDqE8FPUU9zEEmM9Z/woq4bMCA7w==
X-Gm-Gg: AZFdTZcrGKXVl2bKbeEs+iTNIyRc5a9knEJGoAl4uK6ZMgeNwG32fhgNZpi466aL960
	NNGkMhGV4OwfY2Vbi3XY3XZBQlgbApzwi6R5NwTMWLGpqIWBaNN+qTuNmnk688eEE4LH52PM0fJ
	zIDAXN+fW2Kv2tDglaprSg2o3HwbvEoQlfGyYRVgGDOFAlN1jf4W4yKk9xGueZqZmSHBaLxhVnA
	e9g/V9DH0vsjMufQZvzb2FBS9LHcJIVWWdWaOAO58eOVCX0gG7Pzi7H5zHGLEZZS7SPzQB3WIT3
	wYentxP9ciTaHAfColgWMd+blFCUS7DDvIIM6N5Y94gOVUKagvK70YhBP/b1WX3gPAm9F4ZTZNz
	cFiUvWkusbllMu99KSDEWtFj9yxeg82nDk7McRFJA0/LT9eBZcGgXYv6HB8fB48UMZ+WWOce+LY
	V86AnvMi8YzXUFSibC8mJbKq0VS+ZjnDNe++dp2DBH14QOo8aN6flLtJ5y/UJxLd7Gu3MGSu28J
	y/vzICHnDJEC2C3WvhYt4bZM5nkfVsJHEI3BEGxQyEzOgyOwMJXG4mTjZRhPrRHHcOrQ45ePu+A
	bOxK1k9oRabD8gfUcSqC3GNML4i9QdJhfDiONi7L
X-Received: by 2002:a05:6a00:a02:b0:874:708d:b620 with SMTP id d2e1a72fcca58-8c87c484301mr13302214b3a.30.1795503610169;
        Mon, 23 Nov 2026 23:00:10 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-166.us-west-2.compute.amazonaws.com. [3.42.157.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c05fsm6768077b3a.17.2026.11.23.23.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:00:09 -0800 (PST)
Message-ID: <6b0535f9.ec30f6be.c0b1f.d284@mx.google.com>
Date: Mon, 23 Nov 2026 23:00:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7958831423140072986=="
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
Subject: RE: [v1] Bluetooth: btintel_pcie: Fix RX hdev publication race
In-Reply-To: <20261124005939.2981368-1-kiran.k@intel.com>
References: <20261124005939.2981368-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7958831423140072986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220224/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.38 seconds
VerifyFixes                   PASS      0.04 seconds
VerifySignedoff               PASS      0.04 seconds
GitLint                       FAIL      0.15 seconds
SubjectPrefix                 PASS      0.04 seconds
BuildKernel                   PASS      19.86 seconds
CheckAllWarning               PASS      22.51 seconds
CheckSparse                   PASS      23.83 seconds
BuildKernel32                 PASS      20.00 seconds
CheckKernelLLVM               PASS      21.54 seconds
TestRunnerSetup               PASS      470.23 seconds
IncrementalBuild              PASS      18.48 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] Bluetooth: btintel_pcie: Fix RX hdev publication race
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#105: 
  Oops: general protection fault, kernel NULL pointer dereference 0xc28: 0000 [#1] SMP NOPTI

WARNING: Non-standard signature: Assisted-by:
#124: 
Assisted-by: Copilot:claude-sonnet-5.5

ERROR: Unrecognized email address: 'Copilot:claude-sonnet-5.5'
#124: 
Assisted-by: Copilot:claude-sonnet-5.5

total: 1 errors, 2 warnings, 54 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15014915.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth: btintel_pcie: Fix RX hdev publication race

13: B1 Line exceeds max length (92>80): "  Oops: general protection fault, kernel NULL pointer dereference 0xc28: 0000 [#1] SMP NOPTI"
14: B1 Line exceeds max length (97>80): "  CPU: 0 UID: 0 PID: 904 Comm: kworker/u35:1 Tainted: G C OE 7.3.0-nvl-ww44-2bkc #2 PREEMPT(lazy)"
15: B1 Line exceeds max length (141>80): "  Hardware name: Intel Corporation Nova Lake Client Platform/NVL UPH/UL LP5X T3 MEMSKT RVP5, BIOS NVLPFWR1.R00.3414.D22.2610141025 10/14/2026"


https://github.com/bluez/bluetooth-next/pull/1207

---
Regards,
Linux Bluetooth


--===============7958831423140072986==--
