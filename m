Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE253365
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946968; cv=none; b=hmzQt8lpi8Ew2r68OSd8bsuI0TA//E1cr3t6zuLd+yUjdsx04onzz0yD3BClL4ocqGsiRRmDekmmgX0KX0zuZvBwOq2tIIb27z1SmFYYQzEyKGXTTtxRkSh7VmzkZX1NDspWhT5UKpld2F05dZW1Ksl5lBccPDfTKv2UIxuXUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946968; c=relaxed/simple;
	bh=Br88OiRGQfLexLbvfl00dzK6DgriFfpvE1RtRw+v3YA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rehjOCkyd7Zu3Mie37thWSNqDZ/M5uPo3H2KAySUGoMdV6MWK6d6rlKFRYcMtcZ6K7QZuD7lBkmQftkVk5Mlq5DA/Xw2hpnEJl6AviKyGjCVcCIWSa+JSxMbQX0XglmloA/W8on8lydFfvRQQeoisGe9jyuqbqemwCqL37IFHX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8erLlCc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8erLlCc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2351227b098so37152525ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jun 2025 03:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748946966; x=1749551766; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sctzupoV521hLnKqPdUUOCUVKYzN0qYOvyl9NfdLBpU=;
        b=i8erLlCcbRLjKq3pa28SeseM1vyogy/Labvn/Ime2L1AyEgU06+zJ3ang7nAzgucRd
         D4Ji6mZ+E1P0H28ploJLFwQztl7NbeKDT/4CCQdFDULfNaZrYrwrnxZ/ZER1OTzBwY/a
         XPHP5zDf7tFD8yXTMR9GHv0n0VbFp3dEe2R5oDzpvliJ6MwORLHTEnJU9qmAHsMn+SeP
         bJNXHnbO8Ug9z2EwLG+mrzTElqBH+/xRwiW3NrJURb0jJ0TWR7ByztWG26vVHwO6vL2Q
         MUNan4eFYjofFNt7L2/EV9PQPKOqqYccQJhR/4iNIQZWiYiLFbTNurefUxl23iZ2Sx4J
         q/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748946966; x=1749551766;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sctzupoV521hLnKqPdUUOCUVKYzN0qYOvyl9NfdLBpU=;
        b=ZPbzCKPl3oRn5LtJRjFQbz1aOJSydyY8xP23dwXEaGpeve9ezpdzknpgiaWD5OBTVw
         rkwxBIK9c9LOIgPBKgN/vFTK/NIOmsfXs5x7jcHUi5lFvMsFppYPUW4/4RCjfg+DMO/i
         nHW2d1Ik+2wYJ8bVRUgeRwX2m41WIPSfWAT8Wm5LeDcFpgYVzi4zsVzrkoppNE2PPiWx
         laLvcG3vbK4tzOBpEGxGTFG796MhGMe9mrLQJP2TdxaAMKh1LxIK8sD1GDemyLO5KWBg
         I8WlREhivtMAxKbU2OpG3SNUhCmM9NkgY+7iCCnpMJWGxGbkiMWJ1ml+VDwRQtzCnQ01
         osBw==
X-Gm-Message-State: AOJu0Yzp12Oml2QcUnyLnRWJzd3KAvS7bDfzJaZOMVOjX8WIQlt2fquO
	mI7IsewSo5noS96GgjB4NEWWEIe/3rkyygwy2DzRU8KS0e/EeFae9FEjnY/KCA==
X-Gm-Gg: ASbGncsqg4v2zs95W4tcy1sVZU7BXNdU8534D0CMYCbS6/SGX81uCB5kL3WhtQQ8rsk
	25x56Hu1Gm+8tUIFM6dJ3/8HMy1yrdfkre6luccoBn5ZT/FrBlqRSfeLpRKr6Pg/+ndu01YrhL+
	57M55fPEcqUJGh0leW0zywgVPFhAkCCyEXzVAAkZj/ZBeFL1yhadUxmYnKFVip1Ib6K7e4iEJMX
	2VFVJrWmvDxuAUsaH3OfXsTW6kn31LcAUu4pRGKkHVacQrsxF7xgheCg6AJbelzvq1Gptwp3sJi
	c+jaIxZnhKsXG0mzlWaxJN2MbXspqssHIbRML7XrsJQp+y72HSxyPjinYhkvUSLM72w=
X-Google-Smtp-Source: AGHT+IHZIHcOIaeRaAKbBCQiOZlUTwLIBjcy6RMqpec3R3gVpyUwYI85fRIoohcU3i4fjnXsPYvqrw==
X-Received: by 2002:a17:903:1c6:b0:234:ba37:879e with SMTP id d9443c01a7336-2355f781dadmr183782385ad.38.1748946966003;
        Tue, 03 Jun 2025 03:36:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.38.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf53cfsm84697055ad.181.2025.06.03.03.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 03:36:05 -0700 (PDT)
Message-ID: <683ed015.170a0220.399fa5.d1fa@mx.google.com>
Date: Tue, 03 Jun 2025 03:36:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5154991350271169694=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3,1/3] Bluetooth: btintel_pcie: Fix driver not posting maximum rx buffers
In-Reply-To: <20250603100440.600346-1-kiran.k@intel.com>
References: <20250603100440.600346-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5154991350271169694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=968236

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.50 seconds
CheckAllWarning               PASS      27.26 seconds
CheckSparse                   PASS      30.68 seconds
BuildKernel32                 PASS      24.40 seconds
TestRunnerSetup               PASS      460.82 seconds
TestRunner_l2cap-tester       PASS      25.20 seconds
TestRunner_iso-tester         PASS      41.49 seconds
TestRunner_bnep-tester        PASS      5.79 seconds
TestRunner_mgmt-tester        PASS      129.88 seconds
TestRunner_rfcomm-tester      PASS      9.46 seconds
TestRunner_sco-tester         PASS      14.80 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        PASS      7.33 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.35 seconds
IncrementalBuild              PENDING   0.63 seconds

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


--===============5154991350271169694==--
