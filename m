Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056FD28C2B2
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352345; cv=none; b=F9zkMQkYXid2aAqUxVBr6YGy67H6xCXmCdroYJRacQMREhhwRRhXtkxBgSzlpo0LDEqihxlbov7J5l6eUHBzhrGMYc41PloQimyL3Kt81qiH+p1gqMAG6HOGcY+LCCTZYxBmU9zWwNtKIB0QHOJcpn0oxuNKfbUNl79BXZUvsVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352345; c=relaxed/simple;
	bh=jNH1Ce/r69y0i62ywHUOruiQ+outIkHek9YviIr5oT4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K1IHoMj/yRD4cHD2yD5GSWtIIJHUNdy1RS7yoyEFqpilwKwFdt5Pbo0Ygfyf64pFMviOXfBibl+AKJqogDvoObLKaMXSAaF47+iKZik54twJNQvyyUYoTuz3eFcbGKi8rIrXGjVoxmZlKNwFU9nAUmuyPyc7Dru1rXzVVmrqxKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOBxG4KS; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOBxG4KS"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7cadd46ea9aso156238485a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 09:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750352343; x=1750957143; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2rK2VO8mUo+PdYHbKgiPP1QojdcA1hzWo/pCaa3dMoU=;
        b=UOBxG4KSpu84ySxJsxi2Ihk9gLW5bsEdsbgZ9CUysKLhZLK/ZkmlL64Pm/bRqWdWEL
         ncUf2oE/1y+Rf4D2SuGXLddE49xeQleKrcsZ00Sdrm2uF0WlFoq1ViQ1DvmqYQ323gju
         3mgnBLYJKddtjDzfzBGiLYvRexyJoy9XAvVwPHqO+N2bHMeFO+Xx4GY4qzHLEuTO2xjz
         q6C96szVobbLUgmfMGtXCjCHnGAr42l6HJeItfr85qMq10QOcU5aO9HaH/H7B+ymdg2e
         VkkVoFGWMPgPOvqlP7HSlb4MQxYySFLNVrxxEbKguHrCs4AsQ/l39o+xs07rlX10iH+G
         GV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750352343; x=1750957143;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rK2VO8mUo+PdYHbKgiPP1QojdcA1hzWo/pCaa3dMoU=;
        b=YWV2Ona/QlDTy3YNhcvXvr/DaCpPtgeHOkt3LPeVVCNR/izSQXR76MvqPCeJsxQxY5
         uriMdWV45JsdNxQJG5o11abHK8AJSW1Zkm9VgzbnwXoJ9OKzB31VqkP58V5xSHl0TZgt
         MTgoWiyj1rogcM9cyaCI8cNdpTJmh2t5FJVOqyGaPQrAY50X9Luzk0H2c09USsx+A6sb
         pTPWIpdCOi1fcbppzEqIdfzOosA4MvnkN65uI+cceFEAdnifhzKrfME3yH5hLigOIxtI
         rBkGTRFI6+ZgWkhDiH612iA7aLy+5TvwF+hrlDE0OkWhYoWNfCXEKfXcITUkTXNPoPdd
         Y+fw==
X-Gm-Message-State: AOJu0Yz5VDPpE7zoaj7FOGj26WkMb2U3JgzH7mpRLFZxWHSR/ZYkGaQN
	WwX+MMQybhY86AjWNnGLLijDQcsiwgNXhhRvJfGLMh5GCm7NPt6z+ToJOwGrMw==
X-Gm-Gg: ASbGncsAqVDkVk5Bo5Zl9c4hmLi0fvGz6SOD9wgyGocwX8ZlAzlwiegAXpQUBz0RAJn
	s1kD5l+sAREnD7UJdsYYwnR7mHwO07SA+wj9TXjABpMOjXf+ROZgE0cmUgsN74HJF2K5kVKIwjO
	jXerk0WopDsI0xSoSgRJZovJn6vEr/+hw9dbYPXicH/pYhMiJYQbeOkuonsSZjvBe1ZQ8Mgb0PG
	G4NVJrOQGb0W5SYR05oODeOL5yLZ04O9GuGfeB6QSU/yCC+Kmc/JtJswYBjVvG8Hi2U44DofmyH
	5X3pnwXwTYGQzB42tpCXkDL0Wz9j6VA0JTj+IUUDC0P0GKddHOkfMmI6PqS5YioNEXkON9HT8jy
	jiZw=
X-Google-Smtp-Source: AGHT+IExYFEhwy+Y4TyZtMEuUfKsp1sXnmInZh7VINCssODs50QCen2JBX3iP7kMSV53FwwR7e2q7w==
X-Received: by 2002:a05:620a:bd5:b0:7d3:9012:75c4 with SMTP id af79cd13be357-7d3c6ceedfamr3382274985a.44.1750352342391;
        Thu, 19 Jun 2025 09:59:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.16.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f8e4bd7fsm17759185a.76.2025.06.19.09.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 09:59:01 -0700 (PDT)
Message-ID: <685441d5.050a0220.471f7.0b0f@mx.google.com>
Date: Thu, 19 Jun 2025 09:59:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3974879725312727768=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, k.samburskiy@omp.ru
Subject: RE: test-vcp: Fix test failing in some environments
In-Reply-To: <20250619153120.126315-2-k.samburskiy@omp.ru>
References: <20250619153120.126315-2-k.samburskiy@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3974879725312727768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=973896

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      19.84 seconds
BluezMake                     PASS      2607.48 seconds
MakeCheck                     PASS      20.36 seconds
MakeDistcheck                 PASS      195.75 seconds
CheckValgrind                 PASS      273.20 seconds
CheckSmatch                   PASS      300.41 seconds
bluezmakeextell               PASS      126.51 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      890.92 seconds

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


--===============3974879725312727768==--
