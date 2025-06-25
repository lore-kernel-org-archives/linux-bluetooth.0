Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC452586FE
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858255; cv=none; b=qwEUTyzc+KNT67EgUq0tcnBu97Y2campIsFw9Nx4D/ulJltRMLB5kLgol6JfT7Jpmdf3xbREESlE2OhOkHOSfQNu/o5ZlJdM+Cl+Qoh2gZhiQtNBX/tDL3csrDFyCRasQWL7ml7/yWegAFr0ImOsr6H10NYw/bibja7bCAZGo/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858255; c=relaxed/simple;
	bh=Hy1pd7q+lq/+JPl5a5oWVEgjcwmikixj2yY6zhpJwho=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tmSvkGFZsLCVukr0xBLUZXAZDtufq8NWuV5kpM+WBVOXnwBUj5xJ8xNwgniFGlGf3o5XkbGfJ8vtnP5SJEgkIh4SZEmBQqO5xLgzV2aEdyI8quv8t635fGyjD4OzpuV1z2sJpjsO/1ppWmGkIw4AuOdNgTSSq2UD+RfCydsVppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hO78JNAr; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO78JNAr"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fada2dd785so83671526d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750858252; x=1751463052; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iNk5HiGfYw5tDiIM0eOuR+zpkmdMKQlUMmbGLhCbpFk=;
        b=hO78JNArJAsDRl7taKwPDjUGyNpoltPCT9Qd56mk18GWV7u0AgUFyJg5KBIsWI76Ka
         VXlIrtg8l0yw16oNnbfvkXp4vJ302IRlaRey6xNrD9rR3k1YY6+6jlo+/fAYR7M0VRSy
         vw2YmOYgB/PFAePDud1bsJjfqDe6JRaPIa8L1RGIGqk1lb/ThjdQwdewCZS5LkjrCMZG
         4U87cvG0haIN9rBsvPRXf5JoJDO85p9RgCphh2VGJvWmetLiPQW9jPIq7FesiOcFzaVR
         IdGmMamg17nPAoGFKLzM5gSkkOeMoTvgvnh/9Km1gOzJPeRSqrnOK/ff9Z+OwoCX0Ffi
         1GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750858252; x=1751463052;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNk5HiGfYw5tDiIM0eOuR+zpkmdMKQlUMmbGLhCbpFk=;
        b=M7RM6ICcazM9CivQ98QaB7io9Xp6inggmvdMQQkgHqPqF2jKPo84fFuSatG+SGiFPs
         wAI5LONkb2kZnQxvWAigHLL+ZW8nA2/ZyoQpZ2KzekBzryEmXOL8YbZy7dhN8BH62ZM6
         tKg5f7CY7BKXuAT7gV0iTqbrLokTvPeDd2e3hLxD0U1M/IpINxUVnfguUaVfQ70sULoz
         /DYBc23dWVxR8/V2FQ13JLHP7noWMq+u+YBvuKv0O+v2y2r7Nwds0Y1RpQru6mGBojnC
         E+RS1fwyTXZTx4w5+5FvUtCyQEszFMxe0UGoGbKzMC58yCRoxrXFHfskIuwvTINQwEHH
         fxYg==
X-Gm-Message-State: AOJu0Yw7ycHzcLMirMFJ2C/O3VuqXuhtcjxHKm6vPNHGhL1dUzyJBtEu
	De4kUB/XpsIdZCYRlcTbjIwE6kpO0HRuB7nd1wKn9zY7Bxaz6URF3QS2vAED7A==
X-Gm-Gg: ASbGnctfXORm/D4OIqFQQehSGpc8Fq3sa35zCVT8qXv9IDGuC3ScXilJVrs+MLryB33
	/sS1GID717SWhfTzPfDods++VVQSzpGP6oTtKecVT7wo/dMfayBDcHNXOe8/607ymtPQkUTNsWD
	Lq64/6kjqx3R4L4HQqeqnoWETheo3ihMzR8YiQsSbu++nFOTu5efaEQVMTY0AgV3bxeM2NCg+QV
	y1A+hiohp6ucBNKW/DBkPFY0dl8QMM8iX0CQkQOBomRMeqcqy8ImU/lZ3aj4dUd4UO85gmySimv
	2j8O6II9mDKizj2pxePVBqeF6ZV+maEvuUDXDmqZYxpULNp0/x/37OiPetAUiPbXAEDw2Tg=
X-Google-Smtp-Source: AGHT+IH1upEUpFPJ+YhCCaD3749G/km+n6W69v3US7hCMrbWyYiZL8hpTNAyLDUXbImubRhi+6/e4A==
X-Received: by 2002:a05:6214:2f92:b0:6fa:c5be:dad6 with SMTP id 6a1803df08f44-6fd5ef2fae0mr53391206d6.6.1750858251594;
        Wed, 25 Jun 2025 06:30:51 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.181.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd0954430dsm67892536d6.65.2025.06.25.06.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:30:51 -0700 (PDT)
Message-ID: <685bfa0b.050a0220.31dee7.89c6@mx.google.com>
Date: Wed, 25 Jun 2025 06:30:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1933173252395580358=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: Bluetooth: HCI: Fix HCI command order for extended advertising
In-Reply-To: <20250625130510.18382-1-ceggers@arri.de>
References: <20250625130510.18382-1-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1933173252395580358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=975790

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.54 seconds
CheckAllWarning               PASS      26.81 seconds
CheckSparse                   WARNING   30.41 seconds
BuildKernel32                 PASS      24.20 seconds
TestRunnerSetup               PASS      470.86 seconds
TestRunner_l2cap-tester       PASS      25.32 seconds
TestRunner_iso-tester         PASS      38.29 seconds
TestRunner_bnep-tester        PASS      5.94 seconds
TestRunner_mgmt-tester        FAIL      132.36 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      10.11 seconds
TestRunner_mesh-tester        PASS      7.43 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.21 seconds
IncrementalBuild              PENDING   0.80 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Add Ext Advertising - Success 5 (Set Adv off override) Timed out    2.208 seconds
LL Privacy - Advertising 1 (Scan Result)             Failed       1.124 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1933173252395580358==--
