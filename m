Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D1F21ABD0
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257546; cv=none; b=aXI+BAHFdcBzFiE6IcewRi+Gjqn4LhQCJzqFqoHOdxOOPgeOX3t37sswwk06jPVyNgGwmPLOqy+Lldqo6Lfl+pH3hECEoMOmIN8iWH3npuVgxVuW19EKj2ZyiRAXHmeRc/i2QHc6BZsqY8UB19kPpjTHqWvmHaSTVS18ifuEcJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257546; c=relaxed/simple;
	bh=mcLPlLn3UuSnalz5d1vDhA+tTEpK3RW960wdF3DmVtc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CPnOCE30+IJF/CoObO8kISkr7anAKn9MXdZvs02TnD5S7yj9e08Qy0/wWYSgd4Fv0VZTh3roDXMiLFJArKJ7a2r4pqO1BERMUBeDxcxIY4hY64I0jo8I8J2nUxOt8uv2GUv4taxM2jGhUu/oJMO9N+bNci4CNihXoD/yTNdQad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1V32tUI; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1V32tUI"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8804f840579so41604056d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Nov 2025 03:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762257543; x=1762862343; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VE+h8M88BLc8LDAnfx0MkFqDckGtcY2CeuVaudlD5p0=;
        b=E1V32tUIXGDKBdNqYbjl/s/ySdKzrOIsKOPzDndKm2V2nRfv9iazQ8ooLDVASV5Eqo
         L0A/piEC9zKjwXdiulhA27R7nBpGKcqf4QAIu7D9EKvgh1RzXUYOJavXMZCyGwgKnTjS
         MBmYnzXykSjlmwVC0IstDnF6sfgsnVt/FOcWFh41wayflrqIPdU4KbpwZtzzi1UoMw4O
         h2hD2ssKCl6UYvV7dniH0fTrc7REjBN8jWchldMSessmiETyBKjLEp79CMRNkG19VoAK
         9GQ+Q5KIEsS3TWP1/76ySt8baNiPf63RxMmE5P1Ag34ykzUCqM2bYOlVbaMAOj5KhfG/
         cs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257543; x=1762862343;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VE+h8M88BLc8LDAnfx0MkFqDckGtcY2CeuVaudlD5p0=;
        b=vR8bWT5EU6+Nn4OEnfPdd7xc4Eu+9xtG4fEGxMEOPVNzYzQx/PWM8Q7UE1PlCeHvcy
         4BXDTmp4Xfa7ySn8WjuWYFKJ3LJrtzTXekbBAA0zMgwV1WgxGcJKhbyp5qJXx81h272B
         L9y71CLqWrL4qJMtkQuOI3NG+r3xEb0RG5dhUH8A7NXMFWWrmM6z2SoZGJnqUUO+SyhX
         muTNxzNIqbRi7j7YP5IF2IAUQC++K8mpCV+U4DIjkw0zlxhid+H/in2ZNMrCfBbFTv7d
         85k4hxBxOSAlDbMYgD/aB/mouuYMN1ZSZIyKfqt5wXzEzrKFPW48d948Gef6Lde5FszX
         hfDQ==
X-Gm-Message-State: AOJu0YwX0efiLh5mq7Z802xAUuce7EA9CSL/F4uuvExSZLOo0BU766p1
	Xt1pXeieRR1K11HwkpRoayzxlGtBQ/g3tYoSp1pOqOA9GdxTzLv0y/kVX49pYw==
X-Gm-Gg: ASbGncsxrFmXI4uv6EBTMTFkpM8ETiG0xgkl9Y7ZwaRzCrQBSRiIB1MjttnO3psrz/u
	rFkwvRYiUtoI0fT7atiyyNXyRQfquF3vRof2OgD8AqqiXBXT0FIpufb6Td/u915LT2BjZaYZiBt
	CoFnb1Qz5HLtPU6g5aK8Jz2H/c+BQzYngCKqvE0VlWs7DFSE2ulAdIYZu7HiBAULy5uccMpHRs8
	RN9b3Rlh9X3RN+4IqGkN7hRerw8XtKOwyk30cFNFZDWijKqK1rt/+/SUFzOdVB1jfAdIeTCzDgC
	IzzPKQZSwKjRpBROLB2h+bPtPamO30YL3h9Q4r03D84ui20Vq60T933cUUpeDLeOdUptVMq9c/A
	qb2CpKQYkxMbkGoq8adboc7nVB6c06+s3Vr4xhz2Nlb08fYnidAy/QKu/G2fTkQhltTvCnUHvaq
	V7sOZP
X-Google-Smtp-Source: AGHT+IFDpow9UawvZxpcl7KEauyoVy8QU9IfvzKCcGy694a3GACUAwroRqT6xL7mgZA3Rq5h+qa7Xw==
X-Received: by 2002:a05:622a:34b:b0:4e7:2074:8621 with SMTP id d75a77b69052e-4ed30f86c3cmr206823541cf.48.1762257543039;
        Tue, 04 Nov 2025 03:59:03 -0800 (PST)
Received: from [172.17.0.2] ([20.161.60.19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fabaf94sm14670411cf.1.2025.11.04.03.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:59:02 -0800 (PST)
Message-ID: <6909ea86.c80a0220.1a0b77.46fe@mx.google.com>
Date: Tue, 04 Nov 2025 03:59:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6689161762458038943=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: Bluetooth: btusb: add default nvm file
In-Reply-To: <20251104112441.2667316-2-quic_shuaz@quicinc.com>
References: <20251104112441.2667316-2-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6689161762458038943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1019386

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.53 seconds
CheckAllWarning               PASS      27.66 seconds
CheckSparse                   PASS      34.26 seconds
BuildKernel32                 PASS      25.46 seconds
TestRunnerSetup               PASS      503.85 seconds
TestRunner_l2cap-tester       PASS      24.32 seconds
TestRunner_iso-tester         PASS      74.39 seconds
TestRunner_bnep-tester        PASS      6.24 seconds
TestRunner_mgmt-tester        FAIL      121.14 seconds
TestRunner_rfcomm-tester      PASS      9.35 seconds
TestRunner_sco-tester         PASS      14.57 seconds
TestRunner_ioctl-tester       PASS      10.24 seconds
TestRunner_mesh-tester        FAIL      11.53 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.64 seconds
IncrementalBuild              PENDING   0.49 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.158 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.146 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.925 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6689161762458038943==--
