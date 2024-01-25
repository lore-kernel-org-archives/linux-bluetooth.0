Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C3F23774
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182322; cv=none; b=Amy/j79iEoXr/zwRHvXpejvJkDIW/gLZJBPdUdNwi/kXozFQOTFoGDieluR185rTV75YBFR0ljUzZZIJYftw8wojvRbUxzPRZCWAJ3krLjjKCCObF1okXKJlz620YoghU4X0iObM2hlPS/eigoT8Css9MXqTgPasMNDkY+i+7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182322; c=relaxed/simple;
	bh=WAvXLU+mW0Ngr/dM7aCoMRK7MdE97ebYdg/UuxpP0SY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LwbT/PmOSHbg0ejcrtVT9TCIu43PTzE6Kz6BWxujnCW7JukGPzxAUsjuXiFp8J1r+RMMtuzdbBb8jLHLc/EdnQwhJHVBZz4DqrEUrs4xpHioGWD3TwoDLm8P6LY3MOR9KK3RFNmAgL05+LU2b9W3QlwIVTePHz1hWe36MjBG/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eh0e5H/C; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh0e5H/C"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a49d42d17so20533131cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 03:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706182320; x=1706787120; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U3MN/+80E+rBvJoTWDCsezbWhK6PkzPcBQfL5NC+6BU=;
        b=Eh0e5H/CAdpjySuyvzR6EalDZV6VAhz3YSEgM8U5MHOrO9MVmCLkFBDSlYOcOd4DG+
         g0TnG624h/Py+zzjjTZQM+UKRXQI0mYPBoUDFZ+fwc9UOykipxhLNvOe0aTiiTmJnl/K
         /SfKqakEu1kyC0QsoR3RBjEvvLxIj9T0u/nKcuMks4+tVqs8wg1tD9tHB4qM8zHz6URL
         +8+WFBOX7D/qL4zGFkhtRKs39T592LayoLAI0730do5EarPpczoIAYt1rLOdSQV5v2+k
         O8//KFLM/j79S6hc7CUqtxBrnUGDTVjPEigvrXDp/i7s+ujR5LVxEpvVtCnMu5OFfgLa
         6auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182320; x=1706787120;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3MN/+80E+rBvJoTWDCsezbWhK6PkzPcBQfL5NC+6BU=;
        b=q7wnR5MlS54vfdeB/HVPFM32nLJcY8z8EPVxKPo+ko91d6fmkByN9Z12CsELbDBS/z
         S/pAySCqoJq+1++emfO6MzsZJw+CaBYG6EDlasEaeud0vK/oAzikxcVSgRsLZXc/EP/6
         AiSMZEOJOT7wlYI0TglIn5BEITixwzoDNeCRwR5R91hQvLs9H/H6GEOtaoSzDuPoN3Xj
         ocHKJx6WTW1/uuTYfbdYO/VQj/UZ8eVjJQvIlcwd70HvpAI+LUGgSR9tfj/6D/tE8e14
         EdxSGkdDBgHQBos0XCh3SVobjkJ5v0rM2PWn710Dbr9bVfRc+BCu9DFdfySc3f+GrSbC
         qkFQ==
X-Gm-Message-State: AOJu0Ywkmzojodma8CmVkXTrS/H4P9p1lbYWj3DQtSGH4SbNNU2OHP3C
	Oscb0AozJD5Zw1w8F0oWGhMWaTX0sYjEtWb4B+i1crFnq+spLVLQW/Z4WaFs
X-Google-Smtp-Source: AGHT+IHHFRJyLhbU7D33OgmFMNSMhzXmOG81YoS+PnUxxlD9BPE2u73B2DASwHFAJ/Hlyqf52VZf6g==
X-Received: by 2002:ac8:5e47:0:b0:42a:3227:7f73 with SMTP id i7-20020ac85e47000000b0042a32277f73mr875099qtx.33.1706182320212;
        Thu, 25 Jan 2024 03:32:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUvC0NYqEetshglZeBBVUwWOwgqOLlNd8doglJAjYejNftb4viA2ow0w8kP4uczez7xgWoYvjAgXN/9PuxOC06uSCnKJg==
Received: from [172.17.0.2] ([20.185.156.197])
        by smtp.gmail.com with ESMTPSA id cf12-20020a05622a400c00b00427f375c329sm5277324qtb.26.2024.01.25.03.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 03:32:00 -0800 (PST)
Message-ID: <65b246b0.050a0220.c1958.6661@mx.google.com>
Date: Thu, 25 Jan 2024 03:32:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5766577973965773494=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, clancy_shang@163.com
Subject: RE: Bluetooth: mgmt: Fix wrong param be used
In-Reply-To: <20240125105752.3144840-1-clancy_shang@163.com>
References: <20240125105752.3144840-1-clancy_shang@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5766577973965773494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819819

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.33 seconds
CheckAllWarning               PASS      31.01 seconds
CheckSparse                   PASS      36.94 seconds
CheckSmatch                   PASS      101.71 seconds
BuildKernel32                 PASS      27.53 seconds
TestRunnerSetup               PASS      447.28 seconds
TestRunner_l2cap-tester       PASS      23.03 seconds
TestRunner_iso-tester         PASS      41.21 seconds
TestRunner_bnep-tester        PASS      6.94 seconds
TestRunner_mgmt-tester        PASS      155.34 seconds
TestRunner_rfcomm-tester      PASS      11.01 seconds
TestRunner_sco-tester         PASS      14.51 seconds
TestRunner_ioctl-tester       PASS      12.28 seconds
TestRunner_mesh-tester        PASS      9.04 seconds
TestRunner_smp-tester         PASS      9.94 seconds
TestRunner_userchan-tester    PASS      7.37 seconds
IncrementalBuild              PASS      26.91 seconds



---
Regards,
Linux Bluetooth


--===============5766577973965773494==--
