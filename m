Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7F2E36E7
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753252999; cv=none; b=HxLAknAumGjNTB8/ZmGW5ZEu5lOTYI65NMPXChhEcXxcu64XgOuJWvjBfiw4jriskKoaWBwisMlTPgW+GxNUWgG9DLKEHQLo7Sl8ZHmfpH3wOW9ZVqwMzryz/p8CgN7tfnXsGLYrsHHvMTKY+Ba75UhUa1oB1FRv91e9Iw2EA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753252999; c=relaxed/simple;
	bh=bRTeRPLGJmjl/vfX2Yi+pJdQHERegoXbdlPiNuPbssI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jnt4sVvZvGLDlKUDnPZzMcoHVxtqSpHwKSzgdDuTaAA7hM3ZVflk0+S3VlGv+wX2YeGZtfLj1zheOdS7iEZ0NRllym57FPx/1V62+tTrpMbxMwqk0ZCRY7Z5Th8vxhqSCMq0+YD1u2wvVJJGa/lz85t2Pe1KDigioNlNANVxFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTVeHNTe; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTVeHNTe"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fd0a7d3949so84080306d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 23:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753252997; x=1753857797; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jl3Y4Zz8spNGb9yvJUiMj1Rm0r2sPHWbmkCm53WGYzc=;
        b=ZTVeHNTefrSBizvLV0dDKej72RtrzGBcXNIj+2hKPmb8mXNVZ5IDdYD4pvpm4z0W4c
         YgPExmaW71i3xgFTUCaA9j7DXbJnhv1tFayB8C5AiCiMjAxDmZ497NGDembj0N6LAQQt
         TR3onGX0eHwt02VdR/VVJbOr4RhyzjkqgTp1UiELfqfHxuRh9Gi87ETIJJveWPmep2Su
         S69Js1w2HFH1QRCg8OafBXgCYVjdvP6ffLbFbmp8enH3D7uv5qoOM469L2/RfEOL/nbk
         YJb/rSAtl570acOGN4QJv9GEvytGn8RFqZAuIEv32Ssp9xlYZ+SwDBgC0Y5Qm+NqvvSU
         PORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753252997; x=1753857797;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl3Y4Zz8spNGb9yvJUiMj1Rm0r2sPHWbmkCm53WGYzc=;
        b=bIzE1shHJOc70bHQ5VE9UNHs3Ox8g/KMVorXs/MxrT06/oNuYgqj6jZDvsrMlUrq/2
         RLPmxHWNY0AMtuDPy+HY8B2hjJ6eTzO45bz8bD06TV2VnbW+YXt9KAxkL1n3vVYy1Xtn
         RnTcmcZXR0nrIfk+L19AnqBS1ZZsOrvmB+PNSatttl8yNHwIE9aw6ro+4sQ76xzj7WYK
         KyE/RpoK8LTGfULAoTp4vrrMYYdKN9MVowIRSuhnyM/qY/4MERQxBLVv84mzsOYMdnZ7
         ugHqysdfzDds4SVf6hyVnwbS+GxnZIckKp8eY17Y3ureuEYJgtxUyhjVZ6ZOKTobqt+o
         4TQw==
X-Gm-Message-State: AOJu0YxHf3y63ClA0M0lAd4BsEpav+ljCp1vMbGB4uE8Ts15ijsq44dN
	lL0nFhMGNqlXd78t39ICOg23YjHf0jQan4RRnEn4YIwQIpQuJhucLMlx5Xn0yw==
X-Gm-Gg: ASbGncve45KSXaa8jd1kTBXNyTmaFdZ7CaVRp9i7taKGzyyoPc9LW6UEelnXrCafUxE
	dho/S2vOwqk+m2NkMIyUDOsB8TL+GIgJlQ49msw8zK+eXmr0P09nuscAWrFiVXl7D6PGXpb/MT7
	1Uo3tLf0X71mSq+N1e8Oif4oYIqVO6buAId55ntCxzXdi5vhceTMOTLkpdG4JZzPIqPAbtsatb0
	I3PCn9j8/p+6WTPaVmhOlyoPa6QwBHfPPmwqGLnpna4+F93ikp/Tm44wCit8mAe6J2mzYeriQRG
	nHwTzrnnsPAtUE5imFuvTSSYJGxAtsYHORHWc4IySeXawkTqEEAiEAGFw0jV+GmAUx/JGkH5IXJ
	rykJjznWSQmJMAzxswtWLxh9J
X-Google-Smtp-Source: AGHT+IEgnKQEN8EALuCUbn7P1e55T7Nv0enL3fhXbF45wjqtaA1q6nvmVZ4qqs7gf1fV0wJefecNMQ==
X-Received: by 2002:a05:6214:21aa:b0:6fb:35fa:7802 with SMTP id 6a1803df08f44-7070077a62amr28452086d6.36.1753252996846;
        Tue, 22 Jul 2025 23:43:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.15.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b90616asm60675716d6.35.2025.07.22.23.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 23:43:16 -0700 (PDT)
Message-ID: <68808484.d40a0220.632d5.3eb4@mx.google.com>
Date: Tue, 22 Jul 2025 23:43:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3086266776025510904=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Add support for BlazarIW core
In-Reply-To: <20250723062644.1296860-1-kiran.k@intel.com>
References: <20250723062644.1296860-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3086266776025510904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=984974

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.06 seconds
CheckAllWarning               PASS      26.65 seconds
CheckSparse                   PASS      30.00 seconds
BuildKernel32                 PASS      24.11 seconds
TestRunnerSetup               PASS      471.66 seconds
TestRunner_l2cap-tester       PASS      25.25 seconds
TestRunner_iso-tester         PASS      40.21 seconds
TestRunner_bnep-tester        PASS      6.16 seconds
TestRunner_mgmt-tester        FAIL      133.14 seconds
TestRunner_rfcomm-tester      PASS      9.54 seconds
TestRunner_sco-tester         PASS      14.99 seconds
TestRunner_ioctl-tester       PASS      10.14 seconds
TestRunner_mesh-tester        FAIL      11.69 seconds
TestRunner_smp-tester         PASS      8.65 seconds
TestRunner_userchan-tester    PASS      6.42 seconds
IncrementalBuild              PENDING   0.95 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.156 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.160 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3086266776025510904==--
