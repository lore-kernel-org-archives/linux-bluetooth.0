Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DAB23ABA0
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Aug 2025 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756071830; cv=none; b=PZ7DKE3lZoJe2STFS7WLcNX/X2958IXl8YCAByITyTjw9rQ5KFzb8lWN1ygKjTGDM2YOd+pIl7x8ue8sWkaeImPwqtJAPtfQQhowr5GMOn6c6Nf++ojDDD33wl3TGHjfpX1mkzSFtuyXwudJtfG23/Uol7+EBIfLmKPz1MPfWe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756071830; c=relaxed/simple;
	bh=3dp1yG5Zag+uwolHglWc0F6Cd1NIcn1FOu7IK42/Z1c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=c0ZClkhfgYsRuZYoeeLBzYt0w5N3+KZTrxhlLrpNT0H42gR+HF5FPVt/CWK4ojv+iroPCqex+/rWY3O4pTN2PKfQ0QUF955C303bH+D3ttLO7FmvLGBfM8yCTvrvSYaCtnhzEAJGFu23UX47iVC88R30W2/DsxT4eyweC0Af3n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U58ZPAxf; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U58ZPAxf"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70dbcf43dbfso6593376d6.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Aug 2025 14:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756071827; x=1756676627; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+QCM5Ota5PMmMM5owZefRwKWxm0joKlF0lrHfRYmsUA=;
        b=U58ZPAxfabB9a+w7sJMe9sGPvJFarGi1OsCrwZrBT5Eks993B/fYlP1bOP7c/5LLsq
         BWWjZfPH8gHnQUDQWibl4DyoSsXld8Rua2m8JQ4OxpkP+sRfuT/HWhNkIEFmNmxjeNeM
         FJYkwiwmrXq4Le2qnEN3pWDyMU5D6Lbu/PTl6Lb6Gm/9HWckkwSKM0X2K3xK9bhEUF3P
         OSAm5peXz0k9KiZEzPz0ccXhs23rdSfulaBxptYfo38wIbjCk/5ZNdxRxOaOz4+JzC59
         DWiMb5cWucuA+6fb3RSD5zpRXiqLqKo38QJbhzp/+ZMkgAMw3iXekQ/+xh/Pl44o1aMd
         A5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756071827; x=1756676627;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QCM5Ota5PMmMM5owZefRwKWxm0joKlF0lrHfRYmsUA=;
        b=GWaism5BSa7N5VlxjfpdShY1jJ9Kkoj7IlIo1WNqrb9QnNAeYVaqocxjYcEla48rkD
         jBZdCU7LUdODZ7SryxOri1Zo6+BBliRAHNhDpx5FNfJeBWEEmbPkHC08VbsvWWa34XKK
         /Ru8j8mcMuC4Va6OMUoa471EoOffVp+847eMZbfcSbJh8iMwx+Bv/bQep6ajS2qOcW9i
         s1enjp6ITmQdxRljEdgP3QL2/EacvxVAEQS9Ion01zuEErhJSEtIHVkxaJxja8yLek+e
         EH0qEIy1RPbUhTIB45ZGv3w7tLpGHhEhUK/a2aFVxnSYQOhmmeil72r9bhiBSU0u4DKd
         JNfA==
X-Gm-Message-State: AOJu0YytETlMruze+dDXUJsg1rP2iMvaOP1H3QYeAmXu7gRdY+Y6jF7H
	Wyt9ZMH4iPt2uD8coIZ9RiSmD/YPQ9VR3ol7fOztPtU5u7cQ1LxX0HsBwd56JemS
X-Gm-Gg: ASbGncuAUmOIUm8Fy4VsOZRNfLFbamspxAgcS4p/qqa/MN3CNi7CCzjG/X+vxPzXLZh
	B/BfL0n87sWmIXq8mDePNHPwbjI0DmnZ9IjzQmNoEpwPI1aQpkPrSBHpWVJsh1wgV8NOC6t/MQ+
	nXAQazFZyc5m1RWo6w6inGvG12XB1tgTkLHnv83eKLReDXyNjEM+fd7GRDoxupkwL1yhZ+DGyr3
	W+OzpsLxMF/2yi3Jcu86rcHRPRPM36i1NZOtW9DaQOLqLH+mQTG9NHcSKQcaIbJu5/ucF02kJqy
	I8BT2k17v5NUmVYQCr8eV34jmkePogpNzwFrjPfQfrJ6rRvzA61YHrvtCamNGT1hMvjBSmmGpZ4
	4PSgCYkB4lR2GhOUOtCli13gCD8zQxnlJjnQz/rA=
X-Google-Smtp-Source: AGHT+IEvPebXOgkJI1uR4HdLa4uDhj2jbgVG1jI13nA13G/LMpATJq14cn63hTVoJLJt4D2bHowmKA==
X-Received: by 2002:a05:6214:1256:b0:70d:a635:2c8 with SMTP id 6a1803df08f44-70da6350471mr94563556d6.28.1756071827472;
        Sun, 24 Aug 2025 14:43:47 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.54.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72d072bsm32986696d6.66.2025.08.24.14.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 14:43:46 -0700 (PDT)
Message-ID: <68ab8792.050a0220.15af80.d490@mx.google.com>
Date: Sun, 24 Aug 2025 14:43:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6775713275910309669=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ,1/2] lib: Fix out-of-bounds write when concatenating commands
In-Reply-To: <20250824200921.308503-1-arkadiusz.bokowy@gmail.com>
References: <20250824200921.308503-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6775713275910309669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=994977

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.00 seconds
BluezMake                     PASS      2575.78 seconds
MakeCheck                     PASS      20.03 seconds
MakeDistcheck                 PASS      183.79 seconds
CheckValgrind                 PASS      235.19 seconds
CheckSmatch                   PASS      305.52 seconds
bluezmakeextell               PASS      128.08 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      916.40 seconds

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


--===============6775713275910309669==--
