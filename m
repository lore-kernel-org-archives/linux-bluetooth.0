Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91365225764
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741737242; cv=none; b=b7qUlJN6LUUgg7BZbKjZKb+X/qWl8og8MSXcmhJQ+gx1rGh/E2pq8H/8OBXPtil1YyifSP4iNKXKSPxuN5nnYqk799Sr82xG6+mkd8te9o8avUA7wm7mMUmeUZvURkHK04OQq36raTYqTqQmD8T7X8R11rv2ISuscd29uUPDsFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741737242; c=relaxed/simple;
	bh=e1DAyFF3QdMAIfVHsail4Qz7JEBQx7gvrRKFDtHY+W4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GcO+YT4o5Y/YSafRZEDXoVOi2uCPSX1e7Jz5KJLRoVksCsUQ8eaYlEByAkMOdhjwWiaKccAacfOcD2DtPKqtrNX5X8mT2qrI3Mg7xpaVvfteXbI6L5LDO6R2KpI+BDCQ8/LCjRIgv+CFB1H3Xb9fGbkGInd6xpuJyandt5rpgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkpFPbox; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkpFPbox"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7be8f28172dso397259085a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 16:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741737239; x=1742342039; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M+jUWSLGlU/IuIhVfIGgpzucjlgInepmFjqSZ86Ho6I=;
        b=ZkpFPboxCmUnqolfoT2ngOIsjutkGSZw2RiFUeCdu8eCQSozUbGMs2KWvV3Ru+lXij
         vJznDTWsae/9TUHrYoP/q5IngI0pulQyzEqMr5/9QLzMUZ6UBxmm2rLFPwK+TVqtoWBs
         KfIj6S51q6NVrPhjs5yjt388LSp/uPwCeSS02jfs8g3vHk6p895c9j/U5MUC4lO2h/e+
         u7j+1rqxr2Z5suWPrO6pZSl6L4p/v8lXCHQX7/ZbnTcOrSzqT5DN/9VdndgskzGsi3DR
         Fri6PG1Q4LQeJVeRGOnUjfQAOGXEkIWWSFMvWfFESiZD1DTn0BFGfvV39Vy7c6wmNn3P
         jpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741737239; x=1742342039;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+jUWSLGlU/IuIhVfIGgpzucjlgInepmFjqSZ86Ho6I=;
        b=cZhjeZ/fsmAk8w1mE5hEdiJmbvbDlx+muhrCPzSSTisy1oDHbtjgop/cf4xXMvtQCE
         goxlcnj8mxS3txAaD6J/tXKpKo582ltsd/tmRtEXmzkivR55ynZbHGmVN0PD7PMKIQW9
         Pmnh3TFy+kdHqUrGk50/H64SGXRl/tkU+Haj6XVxm0EC3ZwVP91TppbfhGCE+wmFYIKG
         YxULaCXdFN/jrFEEiTPUvI3TShGaXrXqo0loKX+yuNVyMW48DEnkVnqFOUdzqyWCoRSL
         3gofc6rkM+xwjUk5gc1JHAbIvD/vrAZ+Ve3gXvojR1unC4yn8CFLXM6JUXcsCNeMLfTu
         Xo/g==
X-Gm-Message-State: AOJu0YwP6vmTGMq0vb+l7dm+iIdPt7iyuv8BKtuxwOeEU7AEUwXX1kng
	OSB+Ti4l3aFFnbH/p3V7dQiVuT7dz9pXvH336/dUwwjorP5eu5fpXevIhg==
X-Gm-Gg: ASbGncv8KD6Arbd1eZsVFws6Oj+fB7Ws83PMGn17+mDSwb7XMMcixpQUWjjeYcnjQEp
	bL9DjXG4yl3j5UH6WihskjYylPFLPBAtaGDOYNHvkU3/Bqz88iK11QLt0qPp1zIXwO9uS0UBG4k
	yon+0DUSg59/2DhijO9UQNULQAlyR96VhPmvXmhWTsAjy6ggAiYEi5n9SD1vJU63WqG5pkf0+QO
	xrWg3t3hZ/DQ4NmS+QvWtpoN5Je9ns9vDuNnngyMJ9+NOBbq9NVe5VpDayAEfE4OQG48Gn5ATye
	BzUZw/OfHwCrncllfELkFvTrhktfN/1du2ZrLrHvOvYJYgzVqtFFxHLMVJ8=
X-Google-Smtp-Source: AGHT+IF2fZTAETQYHSsxXV76ZnTkGaLA8/8VZA5y2ebzelDyNShj91gYumxy51rTTyRPhoTKBavuUw==
X-Received: by 2002:a05:620a:271a:b0:7c5:4088:e48c with SMTP id af79cd13be357-7c54088e708mr1802107685a.29.1741737239171;
        Tue, 11 Mar 2025 16:53:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707bf47sm78631656d6.25.2025.03.11.16.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 16:53:58 -0700 (PDT)
Message-ID: <67d0cd16.d40a0220.3c5a1.ba68@mx.google.com>
Date: Tue, 11 Mar 2025 16:53:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5717317814279417831=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean.wang@kernel.org
Subject: RE: Bluetooth: btmtk: delay usb_autopm_put_interface until WMT event received
In-Reply-To: <20250311231630.35255-1-sean.wang@kernel.org>
References: <20250311231630.35255-1-sean.wang@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5717317814279417831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=942888

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      23.82 seconds
CheckAllWarning               PASS      26.19 seconds
CheckSparse                   PASS      29.48 seconds
BuildKernel32                 PASS      23.39 seconds
TestRunnerSetup               PASS      430.18 seconds
TestRunner_l2cap-tester       PASS      20.38 seconds
TestRunner_iso-tester         PASS      32.54 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        FAIL      122.41 seconds
TestRunner_rfcomm-tester      PASS      7.81 seconds
TestRunner_sco-tester         PASS      16.29 seconds
TestRunner_ioctl-tester       PASS      8.22 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.14 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PENDING   0.51 seconds

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
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.194 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5717317814279417831==--
