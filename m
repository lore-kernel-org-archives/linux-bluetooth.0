Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119E24EF6E
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744189572; cv=none; b=dKbNtUlbcPoiIJdDPSgn5U/yZ7Wtq9UBEFpgeJMKXteK+l+UmaGOWZYb2WHxiZi9/MEG/7SmTHfqg7cjJn2D06n/fzEC2ojBTlpOu4Ti+sVGKydp58+051b7Elix07HsIxtvwSVBBGfCRCTAl8I8CPu1LAX0EU5OLIXnNFzUegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744189572; c=relaxed/simple;
	bh=SexMe4m8mcO2fDKV9ITIEXIo4d2kUJWZkMC/7FIe3pU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aFzMMtuk4dQozCy1ei7kPHZ0WU0NHXf5Abnri54HsO62gMZtbEgflqVIwdUEIvzrTF4QcfpFRfMEqZHi7tAuIBrno30pVC2wrErr/8l4spGnlUdYJjnO/uwIMZWFCynFaYQfrJu8/s5QcXJzZqfEq9LbqDur0UFZlUAfNpH60JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSfXxuTp; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSfXxuTp"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ecfc7fb2aaso58462146d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Apr 2025 02:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744189569; x=1744794369; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1mQTfaK7iUOgiRkjUoGDuRzAjnRWuRXAlQiWlW8EeVo=;
        b=KSfXxuTpTmVuuPVEtarSyj5PS2k9mQIW0E0uxVRNYgroyEyuUzAAY1+H5N99cobOca
         rXAxlOK/gKSGzzzZxNlhOb9TUR6d5HRpHJwonLgSHC5HeJtDH7fOMiaXtMuDtFFnrVn6
         iDK+qNnEVPAYE2l9/AgXKd4oOlrdD4DFpEoa3qYMRZ7CkTBcnnmlEpO6kP/KQ/qVUY/E
         eP3RrddLI0gYgtBQ2OEhW42lMGszBzy2FCojFkCGSi0E9SlZ17sPhp4FAZ4xRNxXXM31
         26Rb1ikpiZNB75aTAp2pre6Oc0WSYSiGsyiiMyNwXmJMYABvgbq8q7m5WAA6j6WJdBgx
         spMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744189569; x=1744794369;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mQTfaK7iUOgiRkjUoGDuRzAjnRWuRXAlQiWlW8EeVo=;
        b=dxqOouYF9nLCnu5T2LcCaNctQQg+Ksvm9d6xv3bZkaeC0HIQiyRoPjmODqVYTCTaOA
         ZptLsHa+LiZvqBkKaiut+rpoMXZA0xBo3ZNN8YQcapCZ9sNIEcNoHodlrapCAhG+5cHC
         C8CI5ONCS6hqYXO2+BDh4RVYHjtrrF4t5j/X2iBmv2bXwIFxSanjsd7IfYv1CB1yK9+Q
         /yNusfZRDlohzUjHF1wlWXtiftRZk9O2nfVJ4ebGu3YKASyH5Tj+iNSYnqDYe7MQqnq5
         xRdT+RSwa5SfGqoOpHqMFb2bBF1TS6VSVv7Z9dK5SwuyTM9xXSTwsFziUd5p5fmv1ro8
         /Acw==
X-Gm-Message-State: AOJu0YyM7QpMulDnegJMFWzneMdjoBPTUDQfrTRe+7dJE47qwEC+6mHR
	YkVsZa5uQecHMQrYaw0ix4gZVkyiTJlJ+WvRdz53GbOTPDeahb5EQQAbfA==
X-Gm-Gg: ASbGncvrzm0ah0F+p8xutOmq6+4hS1semtTl+D8XgNTHU4WSyxbWRJFESFDkFPGZ9Dy
	zFcIsRwJiORkip1E98XpMMTwOImtu6ocycOqzGhSEp8JIjC+Ar9fFlzMU+Slz2cSIHziCpOj6s6
	j3l9bAn3pZYlEQrBBvAtyGZ6X0KGEmwGrTBzfR/KoyW2mL9QlXbNtcROt4SXcZpJUTiGoClWGJb
	8rDHx64POV07pdpV6dCIi2m8e3lJYBz+t+GLJXDebbR0ZC2/nVbKrioegQYFh0OkD1JIFTTD7c9
	+MBB53CiOxU0uTG1QDUM9tizzsRGX8eNXYrM8m0xvCuH
X-Google-Smtp-Source: AGHT+IGCYAXXAi29E3O3z/AV1ZTLMxd6+ZnJrRZmvZVG4rBcgqoRxbBQjVW2dFDnPJchs/J6JtqYwA==
X-Received: by 2002:a05:6214:1c4b:b0:6e6:6505:ceb2 with SMTP id 6a1803df08f44-6f0dbc5e34bmr40478036d6.36.1744189569063;
        Wed, 09 Apr 2025 02:06:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.14.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea1068csm5027406d6.102.2025.04.09.02.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 02:06:08 -0700 (PDT)
Message-ID: <67f63880.050a0220.299321.0e4e@mx.google.com>
Date: Wed, 09 Apr 2025 02:06:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1707458541054610994=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, catalin.popescu@leica-geosystems.com
Subject: RE: [next,v3,1/2] dt-bindings: net: bluetooth: nxp: add support for supply and reset
In-Reply-To: <20250409083921.3701280-1-catalin.popescu@leica-geosystems.com>
References: <20250409083921.3701280-1-catalin.popescu@leica-geosystems.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1707458541054610994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=951453

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 FAIL      0.48 seconds
BuildKernel                   PASS      26.33 seconds
CheckAllWarning               PASS      27.07 seconds
CheckSparse                   PASS      30.42 seconds
BuildKernel32                 PASS      24.15 seconds
TestRunnerSetup               PASS      480.91 seconds
TestRunner_l2cap-tester       PASS      21.70 seconds
TestRunner_iso-tester         PASS      35.19 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        FAIL      122.22 seconds
TestRunner_rfcomm-tester      PASS      7.98 seconds
TestRunner_sco-tester         PASS      13.21 seconds
TestRunner_ioctl-tester       PASS      8.97 seconds
TestRunner_mesh-tester        PASS      6.13 seconds
TestRunner_smp-tester         PASS      7.28 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PENDING   0.56 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.190 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1707458541054610994==--
