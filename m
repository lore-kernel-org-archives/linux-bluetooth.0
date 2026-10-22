Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693235;
	b=eRC8DXgXjFb6MgIpuM1vd5nm+Iy0CO/xsjGs5jY+pLLwClNwsbJptWFkBF0Nnmgi+F4h
	 0JzuNc2F7i4bNuPuB0a009Yqt9KPIvJZZXu65siYkRapgwwwqe+2YKwnCvgWPeazcTy0h
	 ghtkFDDgxUa4sEhPTx6SL2eE5jEt1ZDacM0PJB+JvjmX3lIh9GqHskcFNZJRfWFyHTGZD
	 mnoNh3jDgme6wYufZ55md6Lsilru1oGBOxUZF5Fc147LNljD/yvD4FWFKXeu7ebQqdU8n
	 dYQU/rp1KJ4nRU74CoiIkJi9QmLpT90RFGe/zMa5jS9RR09NSXyqv6L/5+7wlWU09fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=HXArK6vKF3FE6ngbhmpAboU9OS/6otkBAoP135bC0FI=;
	b=tBg7i/cjuowiPeYRAFKmSMsz5hB5+tpVC1m+nctdAi16/L+ve37/UICUUxclX8JrlFhd
	 ziAw1LFlPiqtnprf1ebIQu49KG9fJ7oTg0F3qONoQLVQy0DqwhCksC+XYPqrkEAR5fzAo
	 THgjn6I+4a4Y1MwT3bE42V7BPq9uE1L0dQ2lNDzBC9bl/mI3UdGIVtWtEJskBIbGLQYaG
	 oa+kg6ZivzBvxV9zat9rKlgz7yJ8KS4nfwbgQdjFxKPJaw8v03O6MuE6SDg9kPA0KrL+J
	 qg9yoP0eEt1DAkQGFXY9Gyo8EexjRI3hb+tZ+WEb8x7Y625vtdfOyg7BynWNHBNHg2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YHyNr1P0;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD43606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 18:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CD43606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YHyNr1P0
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15943c9c005so44015c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 11:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792693234; x=1793298034; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HXArK6vKF3FE6ngbhmpAboU9OS/6otkBAoP135bC0FI=;
        b=YHyNr1P0TineAkRwZURHCfp5s89njTmRCE0B6EQxcUjkz9ltss4GP3H0UuKH1q4xWw
         TwDTH0ywDt1Fm90EUtiLwBI+oNtR9YXt7WAFhEwPna9vR+30CJOCdtlu+mWP8WfyVGye
         nDHNv6NREcWBQzy0eW33JH5ty3x1mpQYbE94PTR1y5W9EgSnJXv34w2MjkcMF0X3Z5lZ
         ZEQoL3eBiSbC0BgbPSAOnPsNksGT2gXQfHU2O64O/AWwQTM/7n3A6vHjDGQY8AcP3Aey
         r6h1Lpdxm8mNQkFVNIrbkGtEpJejRk2HjsRePLlFDhxCXaxy5U3OpeIULOB9ESeyYcBQ
         F8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792693234; x=1793298034;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HXArK6vKF3FE6ngbhmpAboU9OS/6otkBAoP135bC0FI=;
        b=xiQfDvW9hJkg5k4UiM8/1LGdJcab30MnIGvqwAmmb9D85mkEjrNmsM6XbvataZhw2C
         uBjRKmgSUkWcR2Bzuk7Nh4uTwIABzqu2BMdEmHX9actIvE7E6NBRTILFhSCgIN+o/2kn
         lFwdWU2YfDYPbH6Bny9MtXWaYiwC1TxgKyF55kpJbwR1OpfCPZXjQ+iFfU/4QQwNmI+U
         NSNhYUj+wc54EDVsZr02qDCFjwtYI1C+vpON0PLK77WAyraaAswb4m7wePm0sqCTVX0I
         VK8RKp+f2w7rN2z+rMc59qzs9suESAnzx9F1CDk4n5KIjFxE3lZ3eLFADljfn0jFK5m5
         8ogA==
X-Gm-Message-State: AFq9FYKKTt0mdFLqfR+G+zQPVZN1IVSm/coThoIyaGoWXgLkYR2rzeG3
	5DuCoJY2RBQqWjrRysnaieX8O3CyVSFG+QR/VpdpagMYbwldF/oL45V6yWiTFQ==
X-Gm-Gg: AYBFou1VN0f+l7EcPYD+0L8y5JmLSXgPtwyKvjBfzOg418CdEHcjYXOUP+QKHS2b9g2
	ygwCK+Rm8SkEMgTA2FhDLgeh+QOZg+ilVCyKBjLiQreG/kBcZiTwxOwnkejgC+SqmnAn0se25Nq
	r/VDJMYkD7DUcWx2M2/vfm8enz9G7IUfZYHytPd8N/BQvH9B23M5oOsfbbSZw6Sdx1ou8UlmMqN
	b24K6UYpo/0SxJa5HlVOySnitZvAdKt+GeC87+SptRyItov4TMTFAO19yJkfmf7uD0CEzDg0hvM
	NXlA9kJZ/bhFGjR50G+7xAdrzmo3tbt6/GvMXq8kb3Aq6MZI+bU/o+na96JujZkcJdri5lJnp8x
	ep6R1ZmkSsK3TdIqykneGRzrku1yRZ1xIFN569+Jvv8wVeBAq820kupajm5rU+yQbq4LGmpLSIB
	bV2O0LTU9KCYCvBI+s0DZQtzw0CRh2C8Ds4Q7ytOWMZijbZEZ1aLEMgeAxw2Qutwllnq8Ul+Zq2
	UC95KqLuWisTMbU4NAC9ti3v5CVeQgrtAdZVOBypGWbAJO2ma1D63HaGXy9MHOjM4TFFWHmYU7U
	Z5pemz/TdWI=
X-Received: by 2002:a05:701b:2712:b0:150:c9c5:1ca1 with SMTP id a92af1059eb24-195c52302afmr37112c88.18.1792693233885;
        Thu, 22 Oct 2026 11:20:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.152.218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-195a8caf348sm259205c88.10.2026.10.22.11.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:20:32 -0700 (PDT)
Message-ID: <6ada53f0.b97a138d.1a50af.8cc9@mx.google.com>
Date: Thu, 22 Oct 2026 11:20:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8669586337698189280=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Hold incoming data until encryption key size is known
In-Reply-To: <20261022154621.3958803-2-luiz.dentz@gmail.com>
References: <20261022154621.3958803-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8669586337698189280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1191411/

---Test result---

Test Summary:
CheckPatch                    PASS      1.20 seconds
VerifyFixes                   PASS      0.31 seconds
VerifySignedoff               PASS      0.77 seconds
GitLint                       PASS      2.28 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      28.74 seconds
CheckAllWarning               PASS      33.22 seconds
CheckSparse                   WARNING   35.84 seconds
BuildKernel32                 PASS      28.98 seconds
CheckKernelLLVM               PASS      44.09 seconds
TestRunnerSetup               PASS      693.46 seconds
TestRunner_l2cap-tester       PASS      12.69 seconds
TestRunner_iso-tester         PASS      12.76 seconds
TestRunner_bnep-tester        PASS      3.09 seconds
TestRunner_mgmt-tester        PASS      87.58 seconds
TestRunner_rfcomm-tester      PASS      4.44 seconds
TestRunner_sco-tester         PASS      9.46 seconds
TestRunner_ioctl-tester       PASS      4.62 seconds
TestRunner_mesh-tester        PASS      5.67 seconds
TestRunner_smp-tester         PASS      4.70 seconds
TestRunner_userchan-tester    PASS      3.15 seconds
TestRunner_6lowpan-tester     PASS      4.38 seconds
IncrementalBuild              PASS      26.99 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/984

---
Regards,
Linux Bluetooth


--===============8669586337698189280==--
