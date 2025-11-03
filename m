Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC0C20E005
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Nov 2025 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196839; cv=none; b=SUzis+mkQtu8Dt2JCvePBPTufaJEUgxZRXJFN5aziluSjMGFSNOCRTghU60PUkuKx5Ao7EiCNZ8JyelHYOf72UyOOXOnS7UVDOgIfCjPDxCkKo1iwRUWZBuC2y/NZmVrgyR9hJFPb6x/SiifUclc6z0iHJfjaa83oYOVqAmnHew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196839; c=relaxed/simple;
	bh=lJr9GvQ+Ct7/v7qXf+cGS+ateNoBx5INfK1gp8A8NK4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pXGxczGS5lUAkEG8bZr4CREtIQS2DmCyI2yiBIHsX3H2cBu4wLo/Jvo7qsNJLBfbMQxni7h42AMqO+Y9KbiqmuCk22B4MqKRWxxzbAIltb3MwD0D1exe06W6XkTZC7EZFEonsigIKNDOOrjie4L93cwqOQ4F5RqAlyGWcTHdYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQa9Zc/u; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQa9Zc/u"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4332b4368ecso11590975ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Nov 2025 11:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196836; x=1762801636; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yIN+PCfbk+KucSw6+kCf6BLjpBCGRcfqfPxe9y3mi8w=;
        b=RQa9Zc/uSMSEXMCUgWxU+5Txs+cr/+JNW+9QOi6OjkQ5373zeG4OcW9fGa8lvxRuzc
         0J8LnfohejDxHNOU2hBrs0rG+WDAJYbHlzmGeU2uEslpL82Z4ROFQoF0X2i3qEOV8GRL
         Tx9erMybDLjzKURbNoA2AWoOxWAbCiJWOXsBmQYpwVRaE/bxdggMvhj+qY5I0+hA8PjL
         4vRVooXw2VPPJzn/mZXNocIIdbLQEY88LUvxoT1RV6wnfePBHwpAJEkyAnX+zDNVzoK0
         0eFHJjljxgrGgNDWJwtTqr6Vg8jllHJpyEUjKaf5E4Lb3mOvxoxNmM38cYyrcUWZ6oMM
         4MuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196836; x=1762801636;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIN+PCfbk+KucSw6+kCf6BLjpBCGRcfqfPxe9y3mi8w=;
        b=pRyggKHIlJBkBaHYvc3EJS40cZOHRK5SvDxI4ko1qM2WpvkwAq5exVKoJWLW3ol2Mk
         VmEP10cUwz3xaULpwLFiM197dkDb80t1GElY0jyueZA/GFwD1STUoO7Of8DDfA12tP3p
         HvO/tTdKFXKaxDp7Bvgbw96zHpS/ZljsmOBuNz/Q70VvAa47zL8iyiYR+zFt5Ta7LVAY
         OJM/5WK5QyMZPYNuOfw/0NIssJHbSY1u44ySHtFZ+MfIpV3mXQQb5wqjwWGRuA7wpWir
         mHFtqyG6IJErcfeDtfqp4X1tgxb3P7KsQxCLORjkZRTgOHjMpbgzA9AUvJmIL1fO4j2U
         DajQ==
X-Gm-Message-State: AOJu0YwI7TZw4VdlzSqNMb2gHOkehFrigbazzoMzN/wsnbqoDKh4vlFB
	cJ0rXSUinO22srBuJVQqqmMydxBEp8TQfFxTxHq9SnJlahup0LciByundOcR2w==
X-Gm-Gg: ASbGnctFJQuCOY4WnOmSNEPCWL86DPdpSO2nkk8hBwfQzDq9NiJiFxXbjJrRQD6O/TP
	kMOrvO/Yue5Wv4RaB14ugFzuEDoT+/7IZaYL1ZdFy9qPWaHfHf6edJttx5WUWxTTnSLJUUdb7Vh
	IXscYidqvQcf1vvkmPx0S8845EEwznZyS5+Y/llsjai9OOSGQara/CLWDLk4XKWrx+6MrsK4IQR
	wiT3bYedFKbp0mlQ4IzY1V5/hROykfOVeuyQ41PwWUy25X5NrAAxjuBmt5AHVKQHYHr6cTUe3PW
	MFzcLRQliTEd0AFamwooqCxriGhlWfHc+ilJqGzrrkNZtBOwQdawaf9LwAJPAFaf6IIRj43D4S7
	SZM/dK2HjoE5f+Vor+nn4v0r5GR6LeKj3p70VcrN94KBM1Zzf9XOXWENRVbH4yGMscRXcZ4GGSI
	ceELekGPtvSzVHuUSV4A==
X-Google-Smtp-Source: AGHT+IEe0X90Of733ewJu/UcbMgzS8ScxYfOeHlgLv+wKRzbS098IzzAWicIeUEPMzkjaQlhPJuA2A==
X-Received: by 2002:a05:6e02:1606:b0:430:ab80:66f9 with SMTP id e9e14a558f8ab-4330d1224c8mr101598295ab.1.1762196836455;
        Mon, 03 Nov 2025 11:07:16 -0800 (PST)
Received: from [172.17.0.2] ([52.165.250.244])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7226fbaf1sm446131173.64.2025.11.03.11.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:07:16 -0800 (PST)
Message-ID: <6908fd64.050a0220.12f98b.119c@mx.google.com>
Date: Mon, 03 Nov 2025 11:07:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6788352635890359615=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2,1/5] Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
In-Reply-To: <467024bf1ba60184bff304d23de33abb0ed2384f.1762194056.git.pav@iki.fi>
References: <467024bf1ba60184bff304d23de33abb0ed2384f.1762194056.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6788352635890359615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1019069

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.41 seconds
BuildKernel                   PASS      25.36 seconds
CheckAllWarning               PASS      28.27 seconds
CheckSparse                   PASS      31.47 seconds
BuildKernel32                 PASS      25.24 seconds
TestRunnerSetup               PASS      504.90 seconds
TestRunner_l2cap-tester       PASS      23.69 seconds
TestRunner_iso-tester         PASS      69.75 seconds
TestRunner_bnep-tester        PASS      6.06 seconds
TestRunner_mgmt-tester        FAIL      113.38 seconds
TestRunner_rfcomm-tester      PASS      9.23 seconds
TestRunner_sco-tester         PASS      14.26 seconds
TestRunner_ioctl-tester       PASS      9.89 seconds
TestRunner_mesh-tester        FAIL      11.56 seconds
TestRunner_smp-tester         PASS      8.39 seconds
TestRunner_userchan-tester    PASS      6.45 seconds
IncrementalBuild              PENDING   0.91 seconds

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
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.990 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6788352635890359615==--
