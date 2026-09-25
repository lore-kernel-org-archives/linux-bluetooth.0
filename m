Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6285112C534
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350470; cv=none; b=bEDI5kEhVPoxtWjSNRIiSCYK4Wsg9A9C/RAWiXAecgbHfMAQPjqcXhvayfCjQixVus6vVgAUFt0Tal+j+sNhby4bvydaIJK47gAOAHfKXXnVacNbifFcdp8O2Bzta+TrSAqEuFx6QsheVRiJse/kS5UrPBVilQcjhVy+IZxmZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350470; c=relaxed/simple;
	bh=ah/03ZNbJWpY+tpS8yBRootKr9ak6RDtEGq5zdgNO4w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MwZXwl2DP0s2X2vbJiaM12q2gkpWcDefWG27iYwhOR5ER8Sg4E7RbuOD0wge2dQNHTkG0yiEbq+th45ei5NlXPOKOjgJn4fYo4UWzI7Wfjmb2Efgy6fMMWuadtd9RteemOi4FNVGmkA1mkB1CdiaLUD6FyWNPPqnx8/KiuMqseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pNV60Ebm; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNV60Ebm"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb769ca02so12142111cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 08:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790350468; x=1790955268; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jy6j8lAuZdwExP3jMuEW6Vm9MF5DmhDi4IyMlSK8TDE=;
        b=pNV60Ebmp/08Wv6YIPPbpKuiiStdIaFrfltEzzpdRgScUSz8LfzlHxZDfxpnYgTZh+
         OEqZngzOCvUoEe84t89s9XvC3tdljz4akJNIm4m7yqp8JZ6lGlBM/ad7u5odx90VRniH
         4Ex3EBD1GnGvt29+EC1yecls7I7wfCl/693XBweRw5IubRirY248ixkEnsmyYuUsIjfB
         fT/GaNFoH46In/PtOyxzGMKm9IKtlsi2X9grYftCoinXD6p+x4moFOVj/ljvZjwZWj60
         /O7nUooZu/5mOX1nrolzfqKW7BER3SaxAlSN85E1Qh2RPhdzmORuQ9s89CNWyR2P5gB8
         6XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790350468; x=1790955268;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jy6j8lAuZdwExP3jMuEW6Vm9MF5DmhDi4IyMlSK8TDE=;
        b=Mf6PdaQZXBHn2rdg+9LS/wDDQqQbB7b7AP4E/6/geMtn3EfpfLAmyrPYrUMD87Ykq9
         QPuMYG4OJ3Jyii7GDwdK9+Wc05ae2KwQIO5195rObTTuxsYyaiPB+2PU5P8ZA6bdituE
         onVDMfUlhXi7HTz2v8RtynJD0WWIDMwPb5Sk/N6hDd6jETsqY6bClwY6Hn0WoUaG5fo0
         YKcsknS9f2GG4jNTZaj0cnMwsFkBTwj2+q/o3AE1wwZLSOjSGSm0WK+kNsK49WnIp6LF
         BL/dCPVUmJ5/vvTjuhMeDdNIj4ZfwvR6zbFeunsueHqIJdouhhnezGh5TIMKqbXJeoHm
         I3IQ==
X-Gm-Message-State: AFuF++kiG8l4RRD/GHCXlMVrpRF1/O4qdA0hAgV4a5InWYtVVlaEGTvQ
	KiEC0a84b17u9AdBvMAqrU8yhbu0VSUj6XQR86LRKYrq95lklBb0wPbBbC1qMaHM
X-Gm-Gg: AYBFou1tKSU9lSu3RqJB496V5gdd7gDsuE2fxxH8hIpaFXawcy8J/0Vjxf5L0e2n6eb
	AMnHPOxsxiFn5Z1kH3PNhoyb6Sc4IN5Moic8AOvrjNp75K1QZoWCPJqXqJUDrmfy3L07ADK2jIn
	hGM6h23KShnDC6uv0M0hdlBRSNp3mq9fLQGeDeq0aohb7orAZqMdV7SFV61gjnSdzYxDNkVU/Fj
	87tplMZcWzLLS/AZP8bZtjFWnh8kzWL7IOSeWawNI5IUcXGlkuW4VkginAts4hZGn+CSlV5a5Sg
	uvXmpkJTOHNiNjduKioSxcEkiYdfKvRfD0Kvn8A0RfldsktOxL+qA0UL59y7rtiOvPyahfFXGpd
	YoTOiHeoCjaX18Qz7BoXgqbdkEiqs99j4hEVI89zJR9d+izTRTC4HX9Q1IykYAYkolFccmk4PTM
	9YmHfAbUUyTJBxMaaxOXMm0p1q50knoZK7jDhrYSVgTNJB0n3z/yD7g1wtVNbRKNrs4snF0HMgs
	1a1
X-Received: by 2002:a05:622a:5c9:b0:532:8063:69aa with SMTP id d75a77b69052e-5330b5a417fmr54909021cf.6.1790350468066;
        Fri, 25 Sep 2026 08:34:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.199.60])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5330c0452e8sm17239361cf.18.2026.09.25.08.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:34:27 -0700 (PDT)
Message-ID: <6ab69483.24304cfb.18cbc8.2597@mx.google.com>
Date: Fri, 25 Sep 2026 08:34:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8362243718409649651=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [v4,RESEND] Bluetooth: MGMT: Add management security level changed event
In-Reply-To: <20260925101853.3278769-1-frederic.danis@collabora.com>
References: <20260925101853.3278769-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8362243718409649651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1173701/

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.62 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      21.70 seconds
CheckAllWarning               PASS      24.95 seconds
CheckSparse                   WARNING   27.36 seconds
BuildKernel32                 PASS      22.03 seconds
CheckKernelLLVM               PASS      24.47 seconds
TestRunnerSetup               PASS      573.52 seconds
TestRunner_l2cap-tester       PASS      17.08 seconds
TestRunner_iso-tester         PASS      25.72 seconds
TestRunner_bnep-tester        PASS      2.87 seconds
TestRunner_mgmt-tester        PASS      57.04 seconds
TestRunner_rfcomm-tester      PASS      4.09 seconds
TestRunner_sco-tester         PASS      7.16 seconds
TestRunner_ioctl-tester       PASS      4.26 seconds
TestRunner_mesh-tester        FAIL      7.73 seconds
TestRunner_smp-tester         PASS      4.05 seconds
TestRunner_userchan-tester    PASS      2.94 seconds
TestRunner_6lowpan-tester     PASS      4.07 seconds
IncrementalBuild              PASS      21.14 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.620 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/820

---
Regards,
Linux Bluetooth


--===============8362243718409649651==--
