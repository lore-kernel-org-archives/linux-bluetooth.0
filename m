Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ECF1E47A9
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511569; cv=none; b=Z+dX8Cw5LR14e6/U1SFss4WswJCJWlOp07KHUGJEsn47IAfnYia4U3dzgvdWG2LAXmwOjb0EfdRBmJyz+EMRpHubuo4MvhY7uJwP4FkagznTIHJD3l4TT2oJuYU0/aOidGtvGjGRi1qxo+KPX1RrQ6ZL7DoawnEv5rBCiXFHvN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511569; c=relaxed/simple;
	bh=H10HH82ssMlvyTk4QTvXKELyHcyGzH86p8rgm8RUaLM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XT1DmpkqV5e5K6tgGrZ2qjMmbUZSTVdfJgxiAQxbBQT4FezMpWxvkCVA/fcunkuPrOZZGENhp24pyMJboWTGRPsC6jLxnXLzUSjTFI0mJdzekyOyaNIrgZ6wMrlyInY5KzJGxMi8eHWtTAW4H4hwWj21+PmetUOwk/q49n8qGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koUW6tL5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koUW6tL5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22435603572so102194105ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Apr 2025 05:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743511565; x=1744116365; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=37MHhP+o4Eswy/VlSlxjLBOCZzOxw540ZhZo5Zi/1Hw=;
        b=koUW6tL5nruOjSK122fW2hGGQh3AFflfOLT9z09F4saaWdllNXb6MogUps8bG84A3X
         m1lru+hhj0dmELSWmbJ7nHOZWhPnOkDXxVSSIOBjnavunjLZhTf+pw26HDFtgnrMbz0b
         OCoIw3ueOGYhd4JumgUDrC7BKfHJAwd/WB175izuHb0UaKfIhHC2hD4bssIV5BSJAKbm
         mr935QJvl6tLOlPL0WqPOCiAclhDRwkGu3OBjCH3PuuRVQPhFK+E84/dk2qzUSgA7CGC
         qrHaXRG2K8ClXWE8fdmGhMbbwOcG8Sfo/RHT5/5MfBV6d1J/8aBAQzN0f4S9BkFy2v2J
         tINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743511565; x=1744116365;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37MHhP+o4Eswy/VlSlxjLBOCZzOxw540ZhZo5Zi/1Hw=;
        b=IEv+38msHECMmRdcwifWP6jcEMdAmawluZvP9Z3TKp2Ba34mUFMNLHQ9w5eTZS83Kd
         7aQ1Yjf2x36Mc4yQk2Q/0tfOzRmoKaUfRs+/Ng8jA1GLdTnc+fT/ISHY6jf/G0kmBfoO
         6phq7/70fU3Xh0omakOn8x4lztbi7Y5Hqu0FBqpgJmeSrqfJhv3ivRZFa6RoJkUhL1Bg
         qU8zfz3xBfTrp2q2irTEJs+iFOPkIZ2oCJI05ZwWIwKmf5d3xAzSKFHXcG2W2h0rXOpn
         kr9j6URWIQLghDA6eWrSz55UcVKbbzsFW2V1hp7s+Jlg/k+AYfrM4pbKcNv3L3qNggnJ
         I7Dg==
X-Gm-Message-State: AOJu0YzIu7BPXDnfB/vYqjaWHBrjypn4F7JLzNmz5gJIfqObIG5VrRfL
	wSLYKDc6rO6k8rABsmozvXOxhhjX6syK0Mg7lE6yeNTK/6sAyIL6+PPdSQ==
X-Gm-Gg: ASbGncusesAa+IgSN5qo81UP8KOyC4App01fGwTzTyOmS16mDyTK+ikphAMXH5jJz3g
	mCHmVwfp+GLGmH5z1ERmSmwcCa49GcljSjlZFqfL0m0oIM5gObXrRfXAmCXdRTnVZvLYpvpH4DY
	mNhNijGHyrw5jV75gtYaQNvgGfQ9XovOi0YmER5uNmdPOfQ0l1jLVJH4Fat8yWt2U/sWI1z6Tpf
	G3t2R+8nKJPvgwAb/F6QJ+97yyw/JYrTzLd/8g4X32OjtNd0hnxH9ZUKrcJojgn9VhFjretpz5C
	M9YgHqR480Q6PsONQyPeIi4d8ncF4PtyIPGbvblg63U/UlJuIA==
X-Google-Smtp-Source: AGHT+IEIsvQGc/NteHogxqGkfchNu5J6QE97E4HvjXlwZMe+VfSsCbEJqpijnutkVo06m4O3meNl4w==
X-Received: by 2002:a17:902:cf10:b0:224:216e:3342 with SMTP id d9443c01a7336-2292f9f40bamr203709085ad.43.1743511565197;
        Tue, 01 Apr 2025 05:46:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.1.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f69desm87184555ad.253.2025.04.01.05.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 05:46:04 -0700 (PDT)
Message-ID: <67ebe00c.170a0220.154e33.f894@mx.google.com>
Date: Tue, 01 Apr 2025 05:46:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7326506941724618729=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, youn@melois.dev
Subject: RE: Bluetooth: btusb: Add new VID/PID 13d3/3613 for MT7925
In-Reply-To: <TV5EwAth53CPjyEfnDT-hesfQb45wew-qCxhVuZeUL6oUcviiJ9nz83ctko6izmh6X1-O0pphWqltS2XToK2Pj2skYkWLPJ5a210TtQbYJ8=@melois.dev>
References: <TV5EwAth53CPjyEfnDT-hesfQb45wew-qCxhVuZeUL6oUcviiJ9nz83ctko6izmh6X1-O0pphWqltS2XToK2Pj2skYkWLPJ5a210TtQbYJ8=@melois.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7326506941724618729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=948918

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      23.98 seconds
CheckAllWarning               PASS      27.86 seconds
CheckSparse                   PASS      30.05 seconds
BuildKernel32                 PASS      23.64 seconds
TestRunnerSetup               PASS      430.35 seconds
TestRunner_l2cap-tester       PASS      20.95 seconds
TestRunner_iso-tester         PASS      32.82 seconds
TestRunner_bnep-tester        PASS      5.13 seconds
TestRunner_mgmt-tester        FAIL      121.83 seconds
TestRunner_rfcomm-tester      PASS      7.78 seconds
TestRunner_sco-tester         PASS      13.11 seconds
TestRunner_ioctl-tester       PASS      8.32 seconds
TestRunner_mesh-tester        PASS      6.14 seconds
TestRunner_smp-tester         PASS      7.18 seconds
TestRunner_userchan-tester    PASS      4.89 seconds
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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.182 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.218 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.158 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.185 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7326506941724618729==--
