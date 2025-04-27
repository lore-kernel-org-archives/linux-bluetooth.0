Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98117256D
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745755658; cv=none; b=AlcsJWMyphTkRKbO4d0IblliEQmk6aSWbF2wZeEzQfclu83Uv1eB2kyXyrH8jzBYV1RbIqqpZXQwTFk5H8O3ER1FoRodQfgeSW8mrSBgWT43V4IU2439ZiqYQ+0v0Vm2MCN+rIiE87PVcndGSjR3dSawzcNLuikJ4lqUkqvpZlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745755658; c=relaxed/simple;
	bh=DQ+ZYACzZS7CWxIipaEBGMmJA7xD6I+jBHekRJW614Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YSMxfjaV+WCqZ+IQ1MlMWQFvIk82OO5N4ZSJzu1udFG61ejIF/x77sCHbAVfKHYPSm1XGznue/2PWx8YIy0x5ObgIQJ6BiKhnePPIPgk1nJTCgWIzJ3D6CM/dT2rbOsnaBec1lcrwoMCWhTWlKxrpxBzOkqhA8S05BOWIKmNMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPRDRNul; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPRDRNul"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c33e5013aso46059605ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 05:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745755655; x=1746360455; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=53xf0LjZF/TYQQr509B4Rd7OKfM+zaZ+lWGRyE3grnY=;
        b=bPRDRNul/cuhjDN4Z6nwHCizZELJl2zEOn+815gjDxHIt8hHcKwaiCgrGAE23WW8/J
         q7hOpeA72CvcrA76fnl62PieTK2YsiG/mgZB52YHuae8npw0PVsGXDQ2A0GjuvM0rz0e
         hxFSHxIelbYJvO8q9/6BALE4wgEtvDZjUvf1HHfWbo3F20UD/EkyYknbv+aNL1av+Ss3
         NouwTj3SyThBmy1coNqKrBcz7effKjrqKO/raFFFb1F8QzsnkkrlnGupPSwPL3rFdlxX
         nGdFyhMDmp3A8g1Y1cnZ3re/zJOMyZuZWmUEh1p28PjDpzqcDlIEBX7esN2bsvRzrasH
         TuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745755655; x=1746360455;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53xf0LjZF/TYQQr509B4Rd7OKfM+zaZ+lWGRyE3grnY=;
        b=ssun0V0YdLBFy/RL+uoJfRPk92dM/TD+GSJ6RnsBzjAVhLAZnEws7brgqN8OStHt7V
         SEQn/cIXidOWoKksH+KNCxxwu224Llpl+ctUKDYsi5nMmjWq53TmPjXl0SWM6G6v3WNp
         TND6reXzxMHgPCEBCJ5c2RR1p0qqmXU68PZpRmG6KVzTTGXKpkR8WKX0HELq9cnW3uYt
         0P3KB5r3o6cVkd3r6cNoUDBv26oHGk+Oy3+EmCmrwB/kc6pdFSXRuT8ygH4XHn9atoe6
         hZGjUPO9rsq3gJuYIYPHNDc2Pq6EaZfPB7C+Y9TzOWMBjEReQv+BC9H/wSE34P8IRt33
         kn9Q==
X-Gm-Message-State: AOJu0Yw3+CL3NXldolxlXKib4RIcUVcdtXfKbzcmxE1GomsK0ME8/mfB
	yv7jbFkJntwXSuLaiWOBEBEKdz0bhAzO261u0u7pZb3z1rUpueA0yYNgjg==
X-Gm-Gg: ASbGncs8i+g0mDAlLX0PwnRK9ksPHjYU0b+tRvpQwPCymZ8dDG16MNPNLEVA1w01eVB
	BWOU1ZiwoNTsTTrJxO2IEcgFNlKHejVOIsZ2EVsyJ3mMF70DDw7hgTd9B4ffggSvsSiiRf2slCl
	+WhrHQ1OaZGqtgj71Ho3krd2Mr3ObredYSP8r7pxLzVJI/tAtlVIA74zBiSc4IXAkO9uxI89Da7
	MhJ8ka6VXBESGU8nZghhNi6O9BOYUbRiOcaDB1TgyIPQLTKDJ8Y/8BzLqlQttlTez6lKg+zYWDC
	m1Auiemlpc4oPTnDTCd6hSfzmytEmFj9G9yMNPpYi5WF/Mg=
X-Google-Smtp-Source: AGHT+IEltMyZFJAQ9f+Q3n7dgMr+0OkbEFqmbqRfpEF3ZUSEcuw/VnNhqroxy3hfppegHBwYQPq2fA==
X-Received: by 2002:a17:902:f689:b0:224:abb:92c with SMTP id d9443c01a7336-22dc6a8a9ddmr76708485ad.50.1745755655540;
        Sun, 27 Apr 2025 05:07:35 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.77.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f7eb7914sm5530034a12.20.2025.04.27.05.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 05:07:35 -0700 (PDT)
Message-ID: <680e1e07.630a0220.e9b0b.a13b@mx.google.com>
Date: Sun, 27 Apr 2025 05:07:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1170461369417856060=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/5] tools: add tests for RX timestamping
In-Reply-To: <b4a9c82f09efddcff2e604546c33e3737d8955c5.1745750626.git.pav@iki.fi>
References: <b4a9c82f09efddcff2e604546c33e3737d8955c5.1745750626.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1170461369417856060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957482

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.42 seconds
BluezMake                     PASS      2589.99 seconds
MakeCheck                     PASS      20.54 seconds
MakeDistcheck                 PASS      199.06 seconds
CheckValgrind                 PASS      275.68 seconds
CheckSmatch                   WARNING   303.73 seconds
bluezmakeextell               PASS      128.74 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      907.22 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:668:28: warning: Variable length array is used.emulator/bthost.c:669:32: warning: Variable length array is used.emulator/bthost.c:886:28: warning: Variable length array is used.emulator/bthost.c:920:28: warning: Variable length array is used.emulator/btdev.c:453:29: warning: Variable length array is used.emulator/bthost.c:668:28: warning: Variable length array is used.emulator/bthost.c:669:32: warning: Variable length array is used.emulator/bthost.c:886:28: warning: Variable length array is used.emulator/bthost.c:920:28: warning: Variable length array is used.tools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1170461369417856060==--
