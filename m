Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280DA31E106
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882914; cv=none; b=CUZZnloUpGChPqZws19hNNy5IH9vmgLt0PARXS+tyfpxwvX9PHDwnEyEpRqJk1C3U5eXdCeYuwhBCo2D5U/BRrylaCZl0XFEp9Rvz30geeswgNteaTHmSLkITlxbtyNrx08VMkMwyg/xPNaQNcHsV+G+glteH0WN53tPFcPaZtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882914; c=relaxed/simple;
	bh=xeGmiiudWjtUJYnN3FGIAdIJNGj0Ku9id4Jpc6MvEeE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YYEnhxL08Wawunx8tfuXq7Gf0nxKgI/+xhV2q80O7BglS8mS85vtDWz573t1QBvMPY7pPAZjnW4TdSfs0+Scnr9I2ADMq1M9bTq6bbCPZ9iY80/Mmca0Cu6WS92Pxcp1O9n3mVZAKhM8eOFWbT4vqmlU46MS6axBHm7UmzFXDQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcJg0BLP; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcJg0BLP"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-88a2fe9e200so19689076d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 03:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765882912; x=1766487712; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3RnvcH9kVrwYKA3ZrN/G9Vhyptaaf/C8V7CvjUdeMek=;
        b=mcJg0BLPBt0RwUDjjghrlrEKBhtACCfNOk8oukJzsV9Wexpt7txMwLZ841Cl04zF92
         9g/IquhU541EM+iRWX/zPV13NNf7+jvtugOWhsVvQTYXBRWwVNUJboNZa+N+e6M2ovSt
         gGCjoBUEdSaov73xVZcS0zaAC79hN2JOe6p1Isvyj3JoEz7xWr498JB4m/Fq3qzYnFYJ
         t8u3LgNG/p5g7sRd3lFKmatZtdulIsp0MesqtJLMn2r+UcyY3B5GLXpFwie5nM4T33Fs
         F/MUnFjB8nYs3ptR6B7WWpvK6HSSVGQkVSpNIHgdzDNLgalr76MbFPRqPrgSzgOvmqHN
         t7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765882912; x=1766487712;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RnvcH9kVrwYKA3ZrN/G9Vhyptaaf/C8V7CvjUdeMek=;
        b=gWyDWUudHXEQNFt0jFhQ5kpseR2OXjH01AS4rB+eXhmWnv1bJqO6g+rN/ie8afvg8h
         HvuOeEQiG1TXo6uu7MlaftziapvLB9uog2HnOMHbWVrPMD/J8WTuEawAjKrVEJNDB3K4
         Rd4qmjZ2jkQZ7q0Cqyv5e0b28fpyDKDqcAMKgD2H3PzmB72RwieS5teinIf1J/mBb4IU
         oq8GRhtyCo2FrRo/kNwS5zxmBpsI928x2bgrFTnsGmKIQxra7lkaorIWStRA5/gHP3lD
         cW6hlTL3jaUIdhtEA4t9v4O7Px6wdgEOxCe1nodvDGlHjB7fMWBndEYu2rHax/M9xEEY
         1WNQ==
X-Gm-Message-State: AOJu0YwwEtSnOt/XuiGPh1jzJhMkafOy+EoClFJ8u5DU9Irm/d/kdXJc
	L+vm+wVv40KXzJHm2McbgpRxaWRAtkNUYfT6Cdwi84OhB4rZrDtEh6ETkE2k7slW
X-Gm-Gg: AY/fxX4D6s/F2AzdkfFwi/QyPvuXWO7WUrLXXs9twNs1uFNJEC7OXACyTWuh1CB3liQ
	mLztfZ7o6pYSCKjF7jtYofZrzlzdK/ds1zVLbsZZXMKhmBqJ1AOuoGh4YxvPxgopvoH2/PX8cma
	Jua9E4brhLBY7imnUeayBICRlRgpj5UdvhWIdPZCxKkkxyw41khUIR+fDAdPi5Y6C9IuY4V+5En
	GDAc81/PCC11p7oltNmq8BSFUMcFMyz4EuSMgQV6Yv0olfbcLDHBQOUnwnwP83bU1xaV6z93pY6
	fRI2gscbFtCZ4HZCRPca4mpYQV7c5tK9rV5kalYcAkAMLZvhGZcQaMmRaheDLsDiUwsA0Cvy/D3
	Z8yEtwTmEfLQS7OgGjqTftRqPROu3ecR+Jnu+tf3mlzKDJ7MGfKOdA0FCOOGxRtEdsK37rGO6vY
	RxC94SkgjoD7e9B6vdLg==
X-Google-Smtp-Source: AGHT+IEO3Iuzurw62op2h0yeUdGDVM1Vter0zbYiHVz2Zb6I5tshhv0j5IXGl1RuBz+T/KYA5K0/9g==
X-Received: by 2002:a05:6214:3d0d:b0:88a:2eeb:5004 with SMTP id 6a1803df08f44-88a2eeb516cmr116903566d6.54.1765882911490;
        Tue, 16 Dec 2025 03:01:51 -0800 (PST)
Received: from [172.17.0.2] ([145.132.103.72])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a85ea98csm72100246d6.41.2025.12.16.03.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:01:50 -0800 (PST)
Message-ID: <69413c1e.0c0a0220.d9f3.b4ab@mx.google.com>
Date: Tue, 16 Dec 2025 03:01:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2893776693954128630=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez] bap: add PA sync monitor timeout
In-Reply-To: <20251216-bap-pa-sync-v1-1-b1ada9e1a299@amlogic.com>
References: <20251216-bap-pa-sync-v1-1-b1ada9e1a299@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2893776693954128630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1033710

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.51 seconds
BluezMake                     PASS      653.41 seconds
MakeCheck                     PASS      22.26 seconds
MakeDistcheck                 PASS      243.82 seconds
CheckValgrind                 PASS      303.47 seconds
CheckSmatch                   PASS      350.59 seconds
bluezmakeextell               PASS      182.97 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      1031.24 seconds

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


--===============2893776693954128630==--
