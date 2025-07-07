Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C223259CB1
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 03:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751859062; cv=none; b=pzqTKik0Cp6HVeLMO5NM2KgCoA2+LOw+8VWdjWhoOUhotezyrfegC7Ei+Afx4Mn+v2bTmpAS8DBP7OWpGA/D0EIDWUwUlzbo+MhDuybTvQodzNyvZ/arN1jW0655PSTDyxOuU4vx46Gxq8WeaC3jTjJ+8nkGE36cjxWkU5hKrWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751859062; c=relaxed/simple;
	bh=V79zvSb5gbNnsO9n7ojaiPPJ2H5nr0DR1ssbcne/Vkg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FB/iwnMvZCQzMN6MZoDiE9eBmF1gclW91CjxekbWAPF1sOkSd0enQGIt1q5QDmIibSTt+n6Ea8eE0ByaXiEVuqEaqcLdMdh6ve4qsL7MANjCYw1siqKZDGOIOBoiXLISLwiI9Jw+oTFP9m2NdYPk3E+fLToMWpBx763COh5Nel4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa8yturo; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa8yturo"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d5d1feca18so329491985a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Jul 2025 20:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751859059; x=1752463859; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AkJHGMevQNJ1Y+R7TMIE32RNWIZU5TKUsNj3ivBMOA8=;
        b=Wa8yturod9Z9CEAbKlLmlYYqBykIJ+SKxc9X/iiYvpNW/pBVa2WpnAhnTRxLtu4y7V
         SL89d9tu8rs+dMiX+Q+/sKd7bfngCtYfHJu2gtlwJ9L3ooqMII0TZ7z40mTmtVl5s50H
         ZW7Inktl8cNy0t7NI2e0w+Dk7+5u3VWcdIh7DXwmL++lzxavtx068BYTApEn8L0wj40h
         xbhD3xORWoKePReEJjxbeiQywGFHGXg+37/a2sY1teNeO1VFM95LeEdf0maj9EuRUP7I
         NC9YOvi3cDlkitLCXeniQBQSxFhcDodgvZZMXzmzJ3kQVb1WD5szdNjO73NJQhYPIz1e
         pTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751859059; x=1752463859;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkJHGMevQNJ1Y+R7TMIE32RNWIZU5TKUsNj3ivBMOA8=;
        b=WriQkAo6X7QsAvxHgjnWCQpkuyXy+shoC/9xabNcFCmJcxltAIhY4bU6s7g0p3t/xe
         bTpgSxAa3xNjD6u8JxIxxcWFC4dIGEgM3+Dd0Q4NYbsvcjt7SG19cyaal9tGJlhwXosu
         yogBdQaUfvPoMOjVU4gGBysIix8v5rU5P1RwD98lSVLrJoSr9UdJXHPzXsbI4sMdEfu+
         MQqcPamR+Tbd/iniuZZkcNTnrS22SnFMYjrg6q3md5rzqQT9YGELrnRQET/Gx32Hl2C1
         r5MW7vsnF3F8dgrqhw3w02zd3E9YRAueFGEoSPtFHy6SoBJ9yvrGB2u1npYLaQa39Z+7
         rGmw==
X-Gm-Message-State: AOJu0Yy8J05rTwy8nwJGYIy9hxI0YXfyT3W4hPzWSJYyzOha0sX0QKLZ
	T3YV1jvBy4/SekcdNCx15VffiFx3W9ZQ5CX2QNm8uUBHVqJY9PsLt6zDBWUtig==
X-Gm-Gg: ASbGnctlR34bWNcaTfD0sVkiAQ5/h3Aa3VYejc0J2FWcT+QyVqdNePangaJ++BQu8RX
	zWQaMDbW5EaSsJNEek/t/nwoAVcHn7YXOQlH0gpOhqnlzRGCvJAiHDGK5WhgAv0MFtpnR13AVtB
	bz8+Y6pwHKo8elG7heJvKyOtqI/JFPFqsE/9E1E3nKp947l4vwfvwA4Mipikc5tD79GEBhdS/Lg
	8qeuMGpAPr8HuBgB2xTMwvgjzcPSmmm12Rd/57OzXyLvB8Ru3v0vK1d3BwaNuzHOaidIsHswnme
	uFbFp0xQN+ZyBUwfyNLEqEdMc/w5MWNkpzyMWoVRJTwf638SueCWhzoB+OGfIaCv2JX5
X-Google-Smtp-Source: AGHT+IHRQbFF2zTvwFVviLwjQQcBH/ZBh7IHh+KD6e0gRUwk+T5Lr+PZg9sTaYGsSrRptJwdVsGaww==
X-Received: by 2002:a05:620a:a916:b0:7d5:e30f:ba06 with SMTP id af79cd13be357-7d5e30fba27mr1487460685a.9.1751859058754;
        Sun, 06 Jul 2025 20:30:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.93.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a8e1ebsm55262261cf.59.2025.07.06.20.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 20:30:58 -0700 (PDT)
Message-ID: <686b3f72.050a0220.7ef41.eb51@mx.google.com>
Date: Sun, 06 Jul 2025 20:30:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1306232811136654919=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [v4] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
In-Reply-To: <20250707-iso_ts-v4-1-0f0bb162a182@amlogic.com>
References: <20250707-iso_ts-v4-1-0f0bb162a182@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1306232811136654919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979522

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      24.65 seconds
CheckAllWarning               PASS      27.47 seconds
CheckSparse                   PASS      30.94 seconds
BuildKernel32                 PASS      25.04 seconds
TestRunnerSetup               PASS      475.90 seconds
TestRunner_l2cap-tester       PASS      25.44 seconds
TestRunner_iso-tester         PASS      40.61 seconds
TestRunner_bnep-tester        PASS      6.01 seconds
TestRunner_mgmt-tester        FAIL      132.02 seconds
TestRunner_rfcomm-tester      PASS      9.62 seconds
TestRunner_sco-tester         PASS      14.98 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.72 seconds
TestRunner_userchan-tester    PASS      6.41 seconds
IncrementalBuild              PENDING   0.71 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.229 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.159 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.203 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.044 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1306232811136654919==--
