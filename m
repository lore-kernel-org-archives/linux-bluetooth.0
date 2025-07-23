Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AD02E62CF
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280078; cv=none; b=otPrjxoVFg0fCHisXNt48dTekUcPooATtfTc8ZqAeraL7SITP/+NpN92bckELwmeEB4sbXgd6omSULaS5cwWsuhipIspUpa5SJNcjuTtfcfxEmlU1fT9A+rygoKdaxj4jNteFZ0bB4pxavhdA8Vr/P1i6zY77b/hBy1DPH3hzBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280078; c=relaxed/simple;
	bh=jIFMqOMHRQd0IFHeb268uK5OGPHHv+Sm1U7pJlbCYsY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CQbOocxasWQp0nbSRhYCaUUEoHW+bk55H662REZbs5toQ6awVcfHggyic4FWCKZQsrUiAhyy1nE7raFuta2whahMhRhsXwwNB7tRIriXLVaTQYYDXI3tu871Fk0WD0KTMVIPxLrz5WEUfJ4nhWElNUVbJLAOzMBuPgx3v/jLn90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMR4CB8M; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMR4CB8M"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e2c1dc6567so411228185a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753280073; x=1753884873; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SNPmTaF8acoKOqYf4XpeXQqKI91eFoHg/XJig47TFJY=;
        b=ZMR4CB8Mv2mxVZwpyM1UnefsTaBXl0ivppmNn2FkPmSz1dvgPAPgL/A1ODXmosJBZg
         bklwbZAakvUKP5ncC0pBLEgOjTCtBIrxy3UXhCg2IqBCaOyJWu0RkVDMP4hYiUNQIjgR
         g1UQ5FIsw17xQvMHClsSibUztx4geKNMppM/wJLM1+pWHdaIcLrSXyakPA36d3at/5yd
         oNIBxpGbHhlGVd63SWV3g9GPvAEQRlBKvPcDRpqAHHtc6qSufdaGYUtM8FePddGnMFxL
         9xVcy3xB/rqPIxIcML1lj4Kr4xui06tJjEqv9YS+jemPdK0FZIfh2hUTr17aeu7Bu5NG
         F87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753280073; x=1753884873;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNPmTaF8acoKOqYf4XpeXQqKI91eFoHg/XJig47TFJY=;
        b=RHq2i6iVjZnQ61D9IPQUUbqCR3dtqKwHLlP3cJGm0AKmDzafwqoHb+iEafh/OzZ2cf
         5gxSJv2SEe+ffkLmpZMl+tf0YjZPF7BkkAhfo739I4m8iw7UrlRomKsZfd5NHAiC10JT
         6CmNmE9U7AaEXMr8Xx8RhojkX/DylJXsU09AwBbiV5S6XU9l9gfYXD1FewxTc91NgAlf
         K0ZyVZXTgpV88v0nr0zw7unT8qEimn3ddGxiJBzcncUv0fGhMloIw1wM0XB6CQcYsXXe
         3YQaSdt1krr/8pUolszE0lkLjZt+TIjoM1mXadilvnVwwRyzBQUX4sr6cQ6imymVckMp
         wRNg==
X-Gm-Message-State: AOJu0YxVlJwz46g03JyzSUdbRwLNxicoJqsLZy0hzWzR9s/3AK4FleKC
	4CHXmifw3C0JJZh+sBhU94LFPO32IObrLdZrKw6xGK7GlLEtJ8lV2Qt/GH2hwg==
X-Gm-Gg: ASbGncvr0vXdqe2E88Sx8IX50Bzkte4hNsMIijuNT2qHj0R4h7fVs2VABSwIr9bevWF
	5ZRf2PdJwZrmgTHk0vQaJh1iHSjBtvjQbnlKnDuXrchCvoclYEivGpcvQzHg5HaFUBDwALLB3Sw
	lN/flDnGB+VO4i+xUQ1Sz/cHnI27v9Y+/bZwd9/3E0P15ZxJFTUy6+tz1xOqFoXT2FFNp+3ObjE
	dtf6/ZINy2tytnhGYHDIL1f3bL3gGJXD8H1Kb2JBMfotKyOCKMsK1x5U8abY7WimeZCn6qCRwnZ
	3YiMuAZ20mVYTtInPwOC61Ai7rDkOuwj4p7MiOHU6UuZPerEYNF4Su3fk6nbO7uDpHetgWCZe6G
	JC05NiSSti67lEzgr+WlwWbg41AuG
X-Google-Smtp-Source: AGHT+IHJdke7Hj5SdMXUOnEAlO0gBRj+0SXEShqzxaGoOx3JWBdc0rDVto8XpFlmIS49x/QoksG+6Q==
X-Received: by 2002:ad4:5ce5:0:b0:705:b2c:9816 with SMTP id 6a1803df08f44-707005046e1mr49255936d6.11.1753280073159;
        Wed, 23 Jul 2025 07:14:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.70.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-706f443b3ffsm18403216d6.28.2025.07.23.07.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:14:32 -0700 (PDT)
Message-ID: <6880ee48.050a0220.1dae46.8215@mx.google.com>
Date: Wed, 23 Jul 2025 07:14:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7230396019184877946=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Add support for BlazarIW core
In-Reply-To: <20250723134453.1301750-1-kiran.k@intel.com>
References: <20250723134453.1301750-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7230396019184877946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=985135

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.18 seconds
CheckAllWarning               PASS      29.81 seconds
CheckSparse                   PASS      29.90 seconds
BuildKernel32                 PASS      24.30 seconds
TestRunnerSetup               PASS      473.54 seconds
TestRunner_l2cap-tester       PASS      25.30 seconds
TestRunner_iso-tester         PASS      42.63 seconds
TestRunner_bnep-tester        PASS      6.19 seconds
TestRunner_mgmt-tester        FAIL      135.30 seconds
TestRunner_rfcomm-tester      PASS      9.46 seconds
TestRunner_sco-tester         PASS      14.88 seconds
TestRunner_ioctl-tester       PASS      10.33 seconds
TestRunner_mesh-tester        FAIL      11.63 seconds
TestRunner_smp-tester         PASS      8.84 seconds
TestRunner_userchan-tester    PASS      6.45 seconds
IncrementalBuild              PENDING   0.64 seconds

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
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.186 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.072 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7230396019184877946==--
