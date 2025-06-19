Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3A21D59F
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750348063; cv=none; b=bj+9G5p3Q5p6/iT6wFL4wjyCtgJcz9+jNXioS/cBUlqcLNoPQghB6LEDXHAFn2rm8bADyOs4CNScGdvyoB2guxyraBUcajSVCGi6PTrwNy0m+xZNj9ae84z+cxrHBH/szz56leEqIbvieav7jeZYeZw5I9+EyTFZarmBHh2Ss3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750348063; c=relaxed/simple;
	bh=tGZZb2y0KuOt9KUp2i9M7GQxKg10Lavj/QIC/riI6xA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QMtD6EQUCTEuVYmoEYfsiRnPLVx7EQV7wow8JTW4oqPRNGcq3Ci9ZQ1UH+8RLDJgoeYn9oDgsPqGYgSb1IyYj0M6O5lG8hcEycTuKPKGLJHFa9o58E5yxZtkGi5mztXlicilCasZ6pLvMA5zVf+6kmoRo+tBiPwodWmXJVytx08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYNHU3L5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYNHU3L5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-236377f00easo12497205ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750348061; x=1750952861; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3FgLLXUamWR7ZdWL+IWuj/W/3ZHOLqqVgQxgyii8MXA=;
        b=OYNHU3L5AbnafSRHfgos3sdwlLTdEZl3jsAC3hKbDIQTo+6zdL8eOVx8O6CQCVuzMD
         UiVchDyjBLGCp9jKzSh9uHdZtBf2kcQynLha33VuY+mhRF+e56eIfhSnI/vYwzmQsAM7
         4rhD19TPQAN///YdbmMH+i7AeLegPY6vUcUIqsenyOuO/1cpy9amNimnpGwHaYBdZTQg
         R1ANzgUxxfsM3Z5ggLLnEF/WnKuCSLK+UJoZuZi7e557NiKT0CQvjbMBXSk59HeXqBzL
         y8Ow8MQ7p9Uzyy33cGAWNzgnqjLyfKixH7bZh2jI62vXKTwiIjo0zRA5179PHku7basg
         Y9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750348061; x=1750952861;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FgLLXUamWR7ZdWL+IWuj/W/3ZHOLqqVgQxgyii8MXA=;
        b=f0DLT79PVnzkomJRAw54y5JhCwqOJ8KlyyEDhz4DG9POqhfBxzaQH1VfOahYY1FCkm
         s+KNRNSC+q7/W+pAjyb7XywCdyBkG9SAJyA1Ck53ryD2CB7srP/Wh3oGDSenQcQ69Iy4
         jsKLslKQj0dUvYFx7gpjnkCB/d2OYlJ5dkfPXkJeMlLoX+OQaSHf8jBtveirSKApsZyU
         Nbnr/c0pGOUBLKaaHr3FCqsnP6iLW2n1yE9M+/qvN4hJv8SyEGPv9advo17Ae9h00w54
         HByaWRJuTmO111cBs0XhJ8Jl8GEdYcZCxk9V8xeGz6ItD1VL+I1DeKiCw83dlJMSRrFO
         qPQw==
X-Gm-Message-State: AOJu0YzRiPPwFeTJsvRea9LmavKvDmH0mPc58ZAwQUeBLYsyAB8QFvB2
	YRG2kdcgtjl7kwLshVe0NwIivumJ4gjFbkjFMp1KFMHhrMT+lDN5hQsabyVUqw==
X-Gm-Gg: ASbGnctWNYH9V/4RTiz4gvVR/JA75kj+Lp6CcDU7jFAKAzDEWNj5KojAPq/mxghOMKL
	q2ouLVSwTNRvSS/kz6lDQB6B+mF+2QIP8v3QAVAX8rqj8Aok0d9uHl7rBqb5OT+77ExbcHTIW7V
	yBmVocBB2HFBa0Z3ijmYShf0Fx4CUpqODdufWbk9DU7VLYNQJZOgkE5nxOM92bMrGRYAgyS120P
	/fM7tdeeCjrmqfuxO5R/A80RUZxJsn3RHpEX2IvHB127zPgt0e1ro+wH0d1ma6KWK7MPVGR30SB
	qLciYsyriVcAOIBjZ1PCAugTi2+0spgRIw2D93OOKdwBEc6pdHQONfcDpDAvasFs0ZU=
X-Google-Smtp-Source: AGHT+IGsdXB3PqeBSLhzT5RsCVYMnIPe/n3i2xTlpC99pZYzomJYb/ZS3ETkrjjZwWENY4i6e4cMEQ==
X-Received: by 2002:a17:903:9c4:b0:236:6f5f:caa9 with SMTP id d9443c01a7336-2366f5fcdc0mr227178665ad.32.1750348060910;
        Thu, 19 Jun 2025 08:47:40 -0700 (PDT)
Received: from [172.17.0.2] ([40.85.144.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a183asm121537215ad.53.2025.06.19.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 08:47:40 -0700 (PDT)
Message-ID: <6854311c.170a0220.1e2eb8.7e03@mx.google.com>
Date: Thu, 19 Jun 2025 08:47:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4327669789699812382=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, adrian-constantin.dudau@nxp.com
Subject: RE: tools: Expose the raw advertising data available on D-bus to PTS tester
In-Reply-To: <20250619142459.7979-2-adrian-constantin.dudau@nxp.com>
References: <20250619142459.7979-2-adrian-constantin.dudau@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4327669789699812382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=973861

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.04 seconds
BluezMake                     PASS      2635.66 seconds
MakeCheck                     PASS      20.79 seconds
MakeDistcheck                 PASS      200.26 seconds
CheckValgrind                 PASS      274.98 seconds
CheckSmatch                   PASS      305.23 seconds
bluezmakeextell               PASS      127.92 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      915.46 seconds

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


--===============4327669789699812382==--
