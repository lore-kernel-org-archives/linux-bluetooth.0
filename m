Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7C79B7F
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143070; cv=none; b=LkRAEmi2iJG6BijW6HZ28LWOE0MIWnXyIxAhe9fM7iisM0rU3PiZF5rXuRKoRBYrcnSJhH0uOs4phEUXXtZJGGcmVjXwE7Ij1SVpmdKcUVpVjWq/PkZehwK5bCI5l+k+DDkeYzpv2qpELbBMBRs+tR+EFiNHRSg38MBdFssoulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143070; c=relaxed/simple;
	bh=yfR/n8puktcvPefRiHa36yhiDyC9Mw5926diMt6fUqU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=snqd1+YXnksK67cdMmdWhBHShuspesFv2IephB4gZXAeCwrWgw/2wb8BXx9vGlBmRiFML1Plghjw6dEGujMH92QIMreLQLUWMqojvopxq4iC9y8UedRhuqzDEL9q7ANG5dfLGyrM1E9dJG011Uj8fJ6EsTpKdA+1st9Gh8PGdkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWR1MJDd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWR1MJDd"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e5629d5237so738737b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 09:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709143068; x=1709747868; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=li2W3eOygfc41d1tIcDXpRzEyS5ZUpwBKDOGLx4QFpQ=;
        b=MWR1MJDdrkJXmn0k7f3zFekEVU1F7J25xs05JJlqgFx9eUcnDmukWJKBhG+T+f7aBB
         ITtVGGlKbK8IBov41uOhsDdmwLjawVCzgvMsoJ13Z5CH6oRgAtdYChVSziZVxxF0lrYx
         gJIhAWT3iM8RI9yC8OA0Zut/KoiSdlRHhGJ4G9OUlPaaK8lj104PtyPUlkmxlbXVNOK6
         qYR2cRDljdPZErEteXoWE/FBYF02yydC4+0GX54eVjyK3ynzw1u/EHP0Lla2fQU79rpU
         qsm3xZ+bnRHHfdkqOr4GKFA/zSHg2tUHVUT8iudEKhBFUbV+5g2lCP6sibkou2bmaYSc
         eWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143068; x=1709747868;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=li2W3eOygfc41d1tIcDXpRzEyS5ZUpwBKDOGLx4QFpQ=;
        b=ZSg/bWf37cq+e2VJrBWsv1nISobL+ThiE6RA2tksOaRAGf0h6qo+j+Kzll5LDthYiK
         ncbkUCdylZKGDDxUuXGB6QQbHqsG9Wd5VTM0KOLoxDDO+S7AwNezJXvV90qPRI7QZCTo
         Nx0kWi1+UDGTuBh9Ma0tEnMvgmp+d/M6lv/sFnnj3xUqDtrymlqWmAbJeMdxCiaTdJlM
         fMqFL5FHtu0dkQHNRdxNdFpMxKuDDq9sW9OQLH44tu/rNQ5x4Rd2MzW15+tAbAmkGyrq
         jRp05+yNd5DJ/ihR2+97MZkiSbxw/kJpAPrFXaCQjmbiihf8yG+JjuTptEvrSTvYOEfA
         cNBQ==
X-Gm-Message-State: AOJu0YwMEyM/6WwnAPJ2b0Ejp9LzfoovUiozjVKEkr/1m7RW2DWku0ln
	TipvWiEtCwyBgowdyT0HEdb6mhn/mnlxXdAgdRevvz2INP7QhCnyiS1+KXCA
X-Google-Smtp-Source: AGHT+IEWNTiPKlC3VoUX8y5NoUr3jsrjED5Vdyh/H2spwHNiM0cRjUA7GzJOW+tijbLHq+xqNmVEqw==
X-Received: by 2002:a05:6a00:2d15:b0:6e4:c481:ca9 with SMTP id fa21-20020a056a002d1500b006e4c4810ca9mr353278pfb.33.1709143068107;
        Wed, 28 Feb 2024 09:57:48 -0800 (PST)
Received: from [172.17.0.2] ([52.225.77.109])
        by smtp.gmail.com with ESMTPSA id d10-20020a63d64a000000b005cd835182c5sm5170pgj.79.2024.02.28.09.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:57:47 -0800 (PST)
Message-ID: <65df741b.630a0220.ffd36.008e@mx.google.com>
Date: Wed, 28 Feb 2024 09:57:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0817282423790851626=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/4] Bluetooth: hci_core: Fix possible buffer overflow
In-Reply-To: <20240228171838.2414532-1-luiz.dentz@gmail.com>
References: <20240228171838.2414532-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0817282423790851626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=830790

---Test result---

Test Summary:
CheckPatch                    PASS      1.98 seconds
GitLint                       PASS      0.78 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      27.62 seconds
CheckAllWarning               PASS      30.48 seconds
CheckSparse                   PASS      36.06 seconds
CheckSmatch                   PASS      99.43 seconds
BuildKernel32                 PASS      26.97 seconds
TestRunnerSetup               PASS      494.99 seconds
TestRunner_l2cap-tester       PASS      18.05 seconds
TestRunner_iso-tester         PASS      28.19 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        PASS      111.81 seconds
TestRunner_rfcomm-tester      PASS      7.28 seconds
TestRunner_sco-tester         PASS      14.85 seconds
TestRunner_ioctl-tester       PASS      7.76 seconds
TestRunner_mesh-tester        PASS      5.79 seconds
TestRunner_smp-tester         PASS      6.81 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PASS      39.12 seconds



---
Regards,
Linux Bluetooth


--===============0817282423790851626==--
