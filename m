Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99851078F
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739586836; cv=none; b=ht47n/MKogotLCWRTdnFkciECeDrAMMfdAIMzF70qNZgmD/hDiEGbdIYdNI2Wwz0HAb2KN9I+/dw3vYU8lfMb6JaowlNXrRW1xI0WSPHAX5Blum9bGfzUnWf+TajoXTJJMtZljHgt3knOoYGSecI6ZmTJxtiwgmg5WGeZ537Js4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739586836; c=relaxed/simple;
	bh=H6ZioZfLmwsvVptbALb/654cmzUBe+gx07lMDgQr31c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KogI0fbB8D5NBtyI3DcBaKQ8lEwWfay3uTaK5WrjLl8nTPsY34dvQv3UxYbU5unyyhb81bosLtpiEx9pMOT9YfYoD9rdUTQVWvrFBA+IGzW9L0JQk28pPrMs3tOBTqSnzgwyWlFYs6pQ7ZuOIEDxgX7HZ3kDeG4fRVarEH3DNM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fk3p2d1x; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk3p2d1x"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dd420f82e2so37632506d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 18:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739586833; x=1740191633; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JhwKgEQ7rcgwp+mYKvPZFnBHAGxiQmuI9S4Cnsuzoro=;
        b=Fk3p2d1xPOZsxTjwxmC1X0NrAAqY64QJ6FlVrbpxOgSkQYsJOUN3p9mHtTAgf50R1I
         isNNxmUVpqolH5PWqh7lLxhME56B6xmSeMAlLo5cQERcn2aZBk7ZpNnOfNTlrqV8xWb+
         9cBISegJ3TrFPcrhxhcLu6YFV0VK7dyHgZJIPEMANmlD5nEqGr4Kr34viyR7aV5NibRP
         eg1Wzis+/clujiE5VF5oSc7Nsx68hAXBJ+p4THn48X6bRTRrKRouFAnqnw5zur1NWzNu
         mFJqassB6CU7hjzke64BVwpCSodvB2urYRcfhjkUEJ370mFqgNIyL8Rv9+SBolQ0xsaj
         FlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739586833; x=1740191633;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhwKgEQ7rcgwp+mYKvPZFnBHAGxiQmuI9S4Cnsuzoro=;
        b=s3V6895T7wwNbR2GDUaOHeiRACVskpovcfcj8Q5qhk7oJTXKogTpDzkAmCokUeWzPb
         vHICOeC7NQer0VJ+pqnvU0OLKgG475I4OZgzv5HcuDcXzif42ppPGi033HUbL7vkXTXH
         YlmCxCMmzLz8xLk8ApuE/CerpVdv10196BEt4nhGDe4Qdf/XZUFM0mxSOl/Ijap6nqIp
         PAp/G3FDglUEXywnmXaOIoXYgyHydV+Ayn7gNrpVuZbgLc6JI+Dq1FptfMB+FQkG2dGP
         tJuF8pJH/oII1kLlCFxNOn1CNAQdiDP9bEKBZEkRPANZ1nx1BBgdmTK5gWtWfCfBEq4i
         cQvA==
X-Gm-Message-State: AOJu0Yy9wBxVheOryrj7qWHmQbEL43pbJdoEFKUua6dubotTEtOQ7m71
	2zDnYJm4oFJzdmlR8Laqg/ESrRY54toiiWU4UZgqFHpiFBoIt6iEFls47Q==
X-Gm-Gg: ASbGnctasYD7TToA52r4OtbxqX+rWDmAN/g1CNdBSGiZpif4dsq4S/Vm5OWPeLEhW6E
	drS2UFZpm5Z98V7HZyVQmTh6B+CLQFo3oiWYWWpHq1axbsQZZA0veAFmJ8CEuBB/vEoNZU20q4V
	wIDdGaygP7ewqT03VJ1nCw3mrBIQCc0dEgB6D5i45dP16TmVxydtj6ewEakESdf1sEwI4JxbE1E
	/hx4t7MsqOOouWK32aJNV2550Hh4zpIO+JYt+kwfkt6H8aWRc+EZwRkPs/AOkiK4FXgnzzW6W1f
	urC32QvUC3u96NOHRu0=
X-Google-Smtp-Source: AGHT+IGEXDQT4cEkdMTpfxbiSb/OYD2yUOZXdJIl0eSkb/m439VrXdpzGJE0u6x2ommpexPHzRytNA==
X-Received: by 2002:a05:6214:2421:b0:6d4:c6d:17fe with SMTP id 6a1803df08f44-6e66cce7260mr25478916d6.25.1739586833360;
        Fri, 14 Feb 2025 18:33:53 -0800 (PST)
Received: from [172.17.0.2] ([20.57.79.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65dcf9645sm27844906d6.123.2025.02.14.18.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 18:33:52 -0800 (PST)
Message-ID: <67affd10.0c0a0220.123f3.aef9@mx.google.com>
Date: Fri, 14 Feb 2025 18:33:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7581945050579313788=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v1] Bluetooth: hci_qca: fix SSR unable to wake up bug
In-Reply-To: <20250215015558.1043074-1-quic_shuaz@quicinc.com>
References: <20250215015558.1043074-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7581945050579313788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=934242

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.16 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.21 seconds
CheckAllWarning               PASS      26.38 seconds
CheckSparse                   PASS      29.73 seconds
BuildKernel32                 PASS      23.69 seconds
TestRunnerSetup               PASS      428.11 seconds
TestRunner_l2cap-tester       PASS      21.04 seconds
TestRunner_iso-tester         FAIL      148.83 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      126.25 seconds
TestRunner_rfcomm-tester      PASS      7.86 seconds
TestRunner_sco-tester         PASS      9.54 seconds
TestRunner_ioctl-tester       PASS      8.36 seconds
TestRunner_mesh-tester        FAIL      6.23 seconds
TestRunner_smp-tester         PASS      7.16 seconds
TestRunner_userchan-tester    PASS      5.11 seconds
IncrementalBuild              PENDING   0.36 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 125, Passed: 108 (86.4%), Failed: 13, Not Run: 4

Failed Test Cases
ISO Connect2 CIG 0x01 - Success                      Timed out    2.688 seconds
ISO Defer Connect2 CIG 0x01 - Success                Timed out    2.278 seconds
ISO Connected2 Suspend - Success                     Timed out    2.738 seconds
ISO AC 6(ii) - Success                               Timed out    1.902 seconds
ISO AC 7(ii) - Success                               Timed out    2.505 seconds
ISO AC 8(ii) - Success                               Timed out    2.518 seconds
ISO AC 9(ii) - Success                               Timed out    2.522 seconds
ISO AC 11(ii) - Success                              Timed out    2.512 seconds
ISO AC 1 + 2 - Success                               Timed out    1.968 seconds
ISO AC 1 + 2 CIG 0x01/0x02 - Success                 Timed out    2.001 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.027 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    1.996 seconds
ISO AC 6(ii) CIS 0xEF/auto - Success                 Timed out    1.996 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.170 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.107 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7581945050579313788==--
