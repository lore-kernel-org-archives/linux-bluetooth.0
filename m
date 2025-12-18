Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722A334692
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766062380; cv=none; b=iX069x300+Nb0OMam2DTuS7rcecXw2A4JQxHJJyjlvcPHBgSV/vlZXx7JbGx4WISlq3N9cWMIGvW2RXiwfMaJ26iG+Hp/5YWEl75AKHYVaF37fVLAL7+joSsftiZfUJSzK6zVRz9o1tQWDfrOQIisRwLbFXQKuGHh9ZhKmhLkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766062380; c=relaxed/simple;
	bh=WTVBe2NkjyEt02iOaRDaVzBImKJyWdyuVeHYe0i1xJI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a9dmNu6igKpPIZVEcqcu48KO5qWa7e6Q/NxDv91z3ggg7ZELNJEIAc78gMUDJbknwXNOdZBdGW6DgdOckJySGChs04hg0li5byJTQGwehHhXRAvw5XXXqfJF2UJgUOa6AyAMRS1L6jviF8ODjTaWnPgICRDh6r6ikuxJLAa2I2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGnRBmF6; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGnRBmF6"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a09757004cso6775765ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 04:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766062378; x=1766667178; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Met14qU8n3EDw5HZSLHQTHXnmiWAraWIa1yiuqf6jrI=;
        b=gGnRBmF6CzGa8vcyHW85MJo5gRYNBbpkOvirU2E2k6756/rspGCj8Z4gA0JFpBzhgr
         1g/TYwFM+eGo/R7zA0Z5x6Fy1dkeDZNxM7G3w5ekt9TwqXPVdYwJr/Fnx4KuFQRT+ST6
         R+6dLfTAS6gKnNgL7xtmQIGjq4bXIxf4EK22k5GkWDMzDluO7d+RLo90eS6nS9aj+kE2
         OQzMmXLwuvbsCZdoEf9OVAY8T4dTasvS9AlohPT7+Qn7lOXG90P/Pvp3GvGeA5cX1YsN
         oTGE/0l5CjZO6AIarjjYdygsfjjQsFWVPghFi3sBbGy/zevbVnWZpSO8HmVLyloliBSM
         BlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766062378; x=1766667178;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Met14qU8n3EDw5HZSLHQTHXnmiWAraWIa1yiuqf6jrI=;
        b=RaJCjlFTuIzsP84buSgUqUWflInqr7pLyXbU+jGmJBJx+N5VtWwilcE3vsjwgEpBeF
         aMkkrqJumcnC7bnJ0YL+vK0q3i9kW4EsjMM+qF6WZfsJS+RLEFjU0e4meAFvVcRN/9DM
         suocEDnNfitBviUUzwTJVUfPVy+P86LRBqvJOu4k1obTAplmFVTYde6ch6VnaVPyfUqt
         U0tFHRczi/wDoBAzqHbldt46pEifs9webgxd8Rpm6w7zh6gemJgWfNnvsmXEpxrKGFPO
         MHVGShafESR6gpcv4RONXBHlT0jvoGL/1f69hkY4kuy/sH3eSbuKBzIy0E2snvRMJAkA
         PtiQ==
X-Gm-Message-State: AOJu0Yycgv4zn846yGtJrzq4iPNhzOKl+/y0RZ4V7qQcvOrMWFK+cXXX
	2WAVNtetGTTvYNWQr2U0IK88c2Sd62UHEZcf2jRLG6ZArndA43+PQhoF7WhbukBK
X-Gm-Gg: AY/fxX4hSKdCuSX2rJd2MWHqvMLNvwvAtooEP4TQzDK/1QSyOHpF8ZqKO864IpOraNB
	ndNl9rOq6rg+RfrQ31eoFhHixTyfYQTu4awi9wwfZqEZAOCPn1GN5g7w5QRk2VVhB6xOovi1mxc
	NXsQkkCf1aTXfLXKxz51ZgGOecDGiHWNpxZ/17m1kO0nSTF51F1V4hWbFtGg2RLHJAjvpdSMNEQ
	hMmZh1+NOiIPP4JnU62OQJqU7ISePrhhi5cRLOwJJLygc5nkDKrNzBD7HJC8kEcbiUpJa573cqR
	UyiDrTKu6lG3rUNUE4EA4sZ2t1BqsZGbNaxAfRTkmuI1ZANvDXynC4MNMP9ZhLQXSrKTPy8CBx7
	N7aScEhGxvqYTqpsp/rnKYYVL1Uv6cUPvYC2htc0QrT+CBRe99k3EyFgA36rmGm82Z2S5tQZanX
	lQRdf7RfVWuOF9Jn/bWQ==
X-Google-Smtp-Source: AGHT+IGsU0/DdDAY+di3uiG9iCUw+PhzH5c9lxyk09pBYEBD+vgAO6JZuYAgT6xwn/kp+mmG3kWlXQ==
X-Received: by 2002:a05:7022:e1e:b0:11b:40b3:c621 with SMTP id a92af1059eb24-11f34c1c63bmr20528685c88.24.1766062378070;
        Thu, 18 Dec 2025 04:52:58 -0800 (PST)
Received: from [172.17.0.2] ([20.168.110.182])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061f473ebsm7720989c88.1.2025.12.18.04.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 04:52:57 -0800 (PST)
Message-ID: <6943f929.050a0220.5ca56.2e20@mx.google.com>
Date: Thu, 18 Dec 2025 04:52:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1376205110577099361=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ssorensen@roku.com
Subject: RE: Bluetooth: mgmt: Fix TLV parameter code type conversion
In-Reply-To: <20251218120826.533081-1-ssorensen@roku.com>
References: <20251218120826.533081-1-ssorensen@roku.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1376205110577099361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1034566

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.46 seconds
CheckAllWarning               PASS      26.47 seconds
CheckSparse                   PASS      29.47 seconds
BuildKernel32                 PASS      23.83 seconds
TestRunnerSetup               PASS      513.51 seconds
TestRunner_l2cap-tester       PASS      25.90 seconds
TestRunner_iso-tester         PASS      65.80 seconds
TestRunner_bnep-tester        PASS      6.32 seconds
TestRunner_mgmt-tester        FAIL      128.17 seconds
TestRunner_rfcomm-tester      PASS      9.56 seconds
TestRunner_sco-tester         FAIL      16.69 seconds
TestRunner_ioctl-tester       PASS      10.17 seconds
TestRunner_mesh-tester        FAIL      11.60 seconds
TestRunner_smp-tester         PASS      9.02 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
IncrementalBuild              PENDING   1.00 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.149 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.844 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1376205110577099361==--
