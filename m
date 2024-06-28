Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0421514E0
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719572430; cv=none; b=mDIUinM+qquQjyI1n+X/pwA0CNiafxHjSubhgmp6o0STvtrFw6rrnAuFewV+f+l5bmHTa650yreEqQMpcIXxiTKCmqEk3SjQJVe671+4VO1CczOe6xwqB2QOW3ExFEwT7tW0iS7lCAL1sPrrCT8UmBXTESI8Oig87ltf9edUNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719572430; c=relaxed/simple;
	bh=ZLje4Wfh5D6aYBDBmQ5zBjNfBGQhCq54tyLFlmTzF8U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YApZ88KdRhZ2B6gXXSxx9FwPKkxX2RUswyTfP8Ky9LyrqAW7OYnFikr1oJqNViPN0Raptc/VKqTD1uRBl/+aGg96vqcvyXcHtoBmSb8gqDhbtZvBEsT7+r9+GJRg5gKKwLa9Rfa4lNLGGYPU09lGVAKpIwthqIjwEamjHjAL6h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9lnUo0d; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9lnUo0d"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fab03d2f23so3513605ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 04:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719572429; x=1720177229; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gfm1E82J099PRttLLIb6fZtP3BM2bCHcY9W1YmAKrUY=;
        b=m9lnUo0dxUwjjAdXWEajCLZu6N5suNKRLObO44OH/gclzRJrtGfRQi2KDrHlOEga6/
         +Vxbei4EQflh597+YcMBQlP+FMeOWgixf2uPXCLHDiBDwuTsd2bCptvTb+2wzfsIoD26
         liESwiy4WJoGROSiArHXBJsdDWjg/R3w6gQH4p4fVHNl9l8JJODOUdn9t67sbpQDpB1X
         bWx+HMWcyMmNfxRvtLCBicaLnz5shbgpBmX4OS4F+6Rvziuba5vFP14Y2JRY9IZ5ZXjp
         a4C3U0P4MMK61Pxcv9Lok5tOI2FnQyrRN6vKp/LyfB1kdLCBrQbLS1vTvQ69ii7X6psV
         mTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719572429; x=1720177229;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfm1E82J099PRttLLIb6fZtP3BM2bCHcY9W1YmAKrUY=;
        b=aVX6Y220ifutmLuW2+cYui/xAJlasRovagMjc/KWXfRVDCZ4DhlD6zWg0ovmNy1OOE
         QX1vWj3gggyQr6cfnB3D6zBlAwtbD9+7x4jOVGlSjjmW4ui6jSBZjjDBflVTQ8puUt+U
         ++NOAjwKy2lTQwDN2fRwh+nwmb5Lq64iPu5pwYEnwPXl0Hp0sed4gKmDjTZggj3vb8F4
         bh3G6Au0M+HnUMvc4cr1l5jDCFE9I86uoFAFtu1k/NbJmXGvvoWVLt3CcAFsQD1AwvUN
         xy326glZo3BdcrqxBjSB4ElOpTVra50kF/BT3IMohxQgCTifDv8EOAK5C4EPPDZHlNur
         Jn5w==
X-Gm-Message-State: AOJu0Yxokpy8sZD5WO1LKdCH9aIZ99WLYcSBvgxwiNsvFLmcigA82ab/
	uwnS/ngLGLH2hrR74gTrWsSuVTpgUTMZ3BgOGrXM7Wn+fFsRSw69KQ/Vbw==
X-Google-Smtp-Source: AGHT+IF9eAwngPf2xZJw5M2+Oi/uYemNtZIKEnA6Hny0B9qa484GA6LYP0jKVbuLr2zUwvelhZwjwg==
X-Received: by 2002:a17:902:dac9:b0:1fa:781:bb38 with SMTP id d9443c01a7336-1fa15937c43mr143953215ad.51.1719572428791;
        Fri, 28 Jun 2024 04:00:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.17.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15388d3sm12519305ad.181.2024.06.28.04.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:00:28 -0700 (PDT)
Message-ID: <667e97cc.170a0220.afb8a.3818@mx.google.com>
Date: Fri, 28 Jun 2024 04:00:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5689809969845342314=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: btrtl: fix duplicate SCO packet
In-Reply-To: <20240628101624.3470355-1-hildawu@realtek.com>
References: <20240628101624.3470355-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5689809969845342314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866520

---Test result---

Test Summary:
CheckPatch                    PASS      0.93 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      29.76 seconds
CheckAllWarning               PASS      32.09 seconds
CheckSparse                   WARNING   37.14 seconds
CheckSmatch                   PASS      106.62 seconds
BuildKernel32                 PASS      28.64 seconds
TestRunnerSetup               PASS      523.80 seconds
TestRunner_l2cap-tester       PASS      23.82 seconds
TestRunner_iso-tester         PASS      32.67 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        PASS      113.49 seconds
TestRunner_rfcomm-tester      PASS      7.39 seconds
TestRunner_sco-tester         PASS      14.96 seconds
TestRunner_ioctl-tester       PASS      7.75 seconds
TestRunner_mesh-tester        PASS      5.90 seconds
TestRunner_smp-tester         PASS      6.90 seconds
TestRunner_userchan-tester    PASS      4.94 seconds
IncrementalBuild              PASS      27.69 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btusb.c:1326:61: warning: restricted __le16 degrades to integerdrivers/bluetooth/btusb.c:1327:70: warning: incorrect type in argument 1 (different base types)drivers/bluetooth/btusb.c:1327:70:    expected unsigned short [usertype] mpsdrivers/bluetooth/btusb.c:1327:70:    got restricted __le16 [usertype] wMaxPacketSize


---
Regards,
Linux Bluetooth


--===============5689809969845342314==--
