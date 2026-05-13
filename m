Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E4E37756C
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668306; cv=none; b=GrNrmMSr9xEBiiNni+nt0qzxHRLs5Nq10/xFaYJ+kNjvXXNqv+dEcuuJ8btWCnFQ4plYYyfkIunUnr3Miw5DnFUK+rHZ8Kg4IodIST/pzFxMZaaKuzZVg8PI8YrOdWNG80v5+lTZKlfdOFMZsbQ6yWQsK/d8frc4YYOVByL8V7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668306; c=relaxed/simple;
	bh=9MaFF2uYmoXLCQhd6m8YvwZdU+q/7Um9fiiRsItTH5Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ji9zL89UADocAB4UFCtEPcWLIb/vDvQeQ4mqh/ZSiGuqb+NI6GnQhK4/BYRCn2HOhNN7bqGscaRH/1hB9qVHIDyN9P1P+crcKblc4aC/3YTaC7S5goKgJ5pFIvZF71hjHijCMvpXZe/4UOKQTKxS/zYya9nLifbxGrK00IYSATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhCSnJ58; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhCSnJ58"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b4eb1fd5d0so63644986d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778668303; x=1779273103; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kQyqW85ZoE8kp/80aAq/z/7n3vPH2/nTeN+ZYKe5kYg=;
        b=DhCSnJ58SYO6XP5zBLcN5NuzD4PLNSl8+cy3HwqQaDytUM+LwWLHrPJfqDJyqRcCSo
         +9e/KThQgjF1e0wPN1euswoPozDy90Lw0gpmK10Tc+T4hAV63NR0qgZoWslgdd3m6gad
         zKdzaNYuIO7FSWibUn6uVM77kB7lzZTudVD86miPaK7wqdiInrevyJOIcsh5m/YOdtQM
         6MuOkTIHaxCdQ6DidW+gHYR+ZMG62Wcs3aP8xORkOXdqrdg9PB/ei+eggwVmoaAks5ju
         A/zvHYxFEcNvaUeCOunI5MmPHf02ODEwXGwj5Estjsl6rZbVx3A61aVLPjjwsgaBJBiF
         3l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778668303; x=1779273103;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQyqW85ZoE8kp/80aAq/z/7n3vPH2/nTeN+ZYKe5kYg=;
        b=n2RqtlAS5mk84cgaqrRDaAZQxCQMeokki/Sr10oGhR6BAs9hwfus31hF7lXZTCbUcH
         yAstuAAZpnMxL4bC/gAaOShq9oqk3VJCK3+hUnkrTUeENYtRYvXbvM7yhWDiRJ1V/FQb
         B4WuTHanjKCvAbwFonebYuv3D+tUz2DM6p6I0jVtClKeZ+C4xRwolTHbjRXufhDsPad6
         TCzLS8lj36NGKXPBLMdJec810ONiMuG4fbTIGmpXeZ+5p0FCRVWOCXoo9C3QJ9wjm38w
         ZxzRFNkRacs9dppzZWlhZ3tmoac5SatLR7co9DKmu4zf/zQKR8Tn15rc60gce51cBhLV
         U6XA==
X-Gm-Message-State: AOJu0YzGlOPnrJdYHnV5EAVKoEwJG2p/bHPwJKofwFnBPQioVWj+urWq
	mGNqX+MU7gad4nOkKuCpW9mvRjz1Zp6lOdmPFEM/H+Nj+7Qe65P2YyLuP3v4kh5r
X-Gm-Gg: Acq92OE62hGA3aluoNY/aDo3nvdVKZXfcqdbXgbb/oQmTsy4lqq/wtfYoKJRJ2BA7xj
	4VBpEy32JyKP8zad0pVlR5drj3n1eG/WWB0Z5XGPcrkSUyr9EybUCGZYq7QDGpnj/qRYYDmDyMo
	v3PvrdIhHTGLWI+kyC/Zv6rRegfPZoENatNqhmfNG0N+FhQiQ5MYY2l0mHnXIx4IGrRL3xd112z
	mdjIdZU+iM9Ul+dtn8A73fvv2kP3Y6fKvuoowZspq20f3Wxn8VBwFZdLf0jKLD6oNog5wbag8QA
	8mdBmjnlBWt2skBd1tiqDJwWBuOA01bGrAMV+8SSc1IkiqidbjO2ZJfjKxsWGiaR2fiiyVNzUYX
	PQpVFlC8tXy2louRpwaxM0pcQrrcWJH0Ec5DVw+rOR2jLqIBF4mV1uH3wJhNuC4inCtYpbD3Uk6
	vC9Hboc+A80cHoduvejYonCW1wQaCXYEPu5fLK0D75
X-Received: by 2002:ad4:5ca7:0:b0:8a0:7c8:409b with SMTP id 6a1803df08f44-8c7bbe60caemr43166126d6.33.1778668303497;
        Wed, 13 May 2026 03:31:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.183.57])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53cd827c5sm421563986d6.40.2026.05.13.03.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:31:42 -0700 (PDT)
Message-ID: <6a04530e.050a0220.16f250.d561@mx.google.com>
Date: Wed, 13 May 2026 03:31:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8428583220050465257=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v5] Bluetooth: btrtl: Add firmware format v3 support
In-Reply-To: <20260513092423.2789433-1-hildawu@realtek.com>
References: <20260513092423.2789433-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8428583220050465257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1094070

---Test result---

Test Summary:
CheckPatch                    PASS      1.75 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.61 seconds
CheckAllWarning               PASS      27.06 seconds
CheckSparse                   PASS      25.95 seconds
BuildKernel32                 PASS      24.65 seconds
TestRunnerSetup               PASS      519.47 seconds
IncrementalBuild              PASS      23.66 seconds



https://github.com/bluez/bluetooth-next/pull/183

---
Regards,
Linux Bluetooth


--===============8428583220050465257==--
