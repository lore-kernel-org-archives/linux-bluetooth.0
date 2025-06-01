Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69C9460
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Jun 2025 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748749058; cv=none; b=Q6hkKjRVPTqcFPP5yxt6ouYQmuEpykNPOu0H0TuvPFnzkZ5efXlLpiidMeQf0El/k419HqTnvqSMKFmTHGHRt4ngT49sdfeHEl6cxWhMMgV43tRISCYCXWa0oOHpTSV4yiqlqjsHZYDKX/3BMIBUikuuJ7PadXKSNuuUFXbBHd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748749058; c=relaxed/simple;
	bh=Ldlv633dqdgB4Akon6TH29rnx+zDe26MYJqMCJrIY4w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rhhXxAwcr+WK5kVR2IiuYhGWdcIK8WO80kQW4N9M4U1Ku5DimCer77Lych+TA4HySFFtDnLdVD8jAJPat1j4ODE1IZX5UBDd9JRwbWtK4uRcLsBQzbqYuHugM24boyNmwUfNneXhga+mGeSQppVKIE1ZdmH+UI3CNAq04lkw20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Toxsfvu1; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Toxsfvu1"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f0c30a1ca3so33951726d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 31 May 2025 20:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748749055; x=1749353855; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/sVeHRk/K5y07RqXKdBuHIa0zqNgJyzx3C60NkRluDY=;
        b=Toxsfvu1sMBsKxABLOIpeDpk38Dt6ae9AuB6kdDRLq3AhPl+ZFagBQ5ZwupP16VVdy
         ccQn2APyZvLF1YbV2v352uIEgvc5XY0u5qpNKymTgHbUDz8OwONMEc8l+E+gtc33B+Mc
         KOTPdrkTBLQFX9iRdqCTW1HM6hszzL4FDkvUKvX4H/8EEF79fzhkjx9Ab+HHyh3I0mR3
         T6DxKsftuy97ZCSA7TPZsO52zLY2JVRBPtmTIpBjbVVJNIrde76InR61XNg37IWZxgTn
         3IBgnCwvBPVfubaJYFNcus1IVdL8hwm/TYvW2T2uAqMgNnchX5zu5T4+Mwzn50D0FZWL
         ouCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748749055; x=1749353855;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sVeHRk/K5y07RqXKdBuHIa0zqNgJyzx3C60NkRluDY=;
        b=vEv3ERuts0dS8RKCn5NvqdPBmlqsNHtJZtXsHCLUDyqwEWsiA4uaC2RiQV43zr8gb7
         x5RwYOWE+IvXoNPbSlj6bNkvlmkCBkhI8J0JVpQyp0VIM7U4wnmhDv/Fn2oqSwoFKFJU
         /3kGElki7Jaw4UojEwY4yVew77ZlbBHvSKTNYRZKsq59C6Ey5/AVrS3erWofDLUOpvu7
         FtYRN6NH+9Klvmve/Jmq76A/r1P4zUeslHj1C9d2KTTJwuRLmKOiO53H9e/STjfJsiR9
         kC7gtGxl3CjKK0CQ+2sqzc/TIx7ZuSSdSjENrRLZ6DdsS2pXURyaAOrfhPTp98RP8fDQ
         Kpyw==
X-Gm-Message-State: AOJu0YxhJfBX3Ax24kBSxnbDB59EcP7V4h5Qjf7qoVA6rzMV3NBLPjIl
	kDkVCg+eEwSTotHZRFFo2Ebu2KjmGX/Jze/MYnUDPMKVI8+cpJh9A3PsuW/ssw==
X-Gm-Gg: ASbGnctN+DHU5bCn1BPbdAtOudzeG/Edc1feT3VmXqIUgfFJIn0948EmS/3ZSYzeWFv
	8Z5mesHB/KjIm2fgA40MFNhJ309iRhP9jdoQqmES0pBZUsZyeuuB+okIQmPxn2XGAx3UCvPJwQI
	9HQCxgSupxaHngyDGp5V8XZ6r/IuwKA1bdq39IJldEE4lbjbMJXdKJjHREWOvUEocIsPr93h06l
	dMmOZ4kD6e7kRZuK5/YfR2OAYytHSB1IOk75zp86GzqcKhEpxr6TFUw/umZmb46kb0eQG4Rbqod
	GAst+72/F6aEZaQcaGwPhtkZJSSzS9YVqwtL7ftriGXhmMXKGLtBaQYAqSgyf6Kyjg==
X-Google-Smtp-Source: AGHT+IHvRP0KpprzJsMpjK9nrxMkA2V4CDwHWZ/VnQC/kUMy+66ctMJ8TdQtD/Yy0eAbmO5rReatgA==
X-Received: by 2002:a05:6214:27ec:b0:6f4:c824:9d4a with SMTP id 6a1803df08f44-6faceb8046amr160150096d6.13.1748749055399;
        Sat, 31 May 2025 20:37:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.14.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e01434sm43537136d6.81.2025.05.31.20.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 20:37:34 -0700 (PDT)
Message-ID: <683bcafe.050a0220.1816ba.f115@mx.google.com>
Date: Sat, 31 May 2025 20:37:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0888541376081897518=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/3] Bluetooth: btintel_pcie: Fix driver not posting maximum rx buffers
In-Reply-To: <20250601032824.572001-1-kiran.k@intel.com>
References: <20250601032824.572001-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0888541376081897518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=967825

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      24.36 seconds
CheckAllWarning               PASS      26.61 seconds
CheckSparse                   PASS      29.99 seconds
BuildKernel32                 PASS      23.87 seconds
TestRunnerSetup               PASS      453.04 seconds
TestRunner_l2cap-tester       PASS      24.98 seconds
TestRunner_iso-tester         PASS      43.65 seconds
TestRunner_bnep-tester        PASS      5.80 seconds
TestRunner_mgmt-tester        PASS      146.57 seconds
TestRunner_rfcomm-tester      PASS      9.35 seconds
TestRunner_sco-tester         PASS      14.55 seconds
TestRunner_ioctl-tester       PASS      9.70 seconds
TestRunner_mesh-tester        PASS      7.22 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.08 seconds
IncrementalBuild              PENDING   0.83 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0888541376081897518==--
