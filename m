Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1627602B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357817; cv=none; b=i5dhwcr1Z28cnWn3fDjubEQVr6eVLqQtWvza4Pv2nbgzVJKKlyouk5fMN+lSNP0WqadUWphqAzhdX72G7P67SrUmA1JPdlW9lxH3BrqiTihTvRSILXVULZIRDfX0xS/gXycmeKbvgqkdZ/g/G3jxm5E7jHsXqWNlhTygVSsMi4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357817; c=relaxed/simple;
	bh=T0hWpOqM9g6gBLoU8h1O4D0wniKPnG9MWi9W5YmF3lw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UpCgLsYTjwCUhNCAvDDT+vo8d6s3f/0ZsanPbw1WTQkqmQMVXvQTzzm1n3GlXxH5Fdks8Kf77+O1PM5Kgr7Yp5UOQXDpXsx3warBIfvN19jMIrVxipgcy8xCjx+TRaM6zRNXfKX7B+zT2DMYtoRdms3L1FTk5Apgl1z2Z0Kbvpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcyxnHaI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcyxnHaI"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2343ea60430so28427895ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748357815; x=1748962615; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0kdsCN36KZ9TwfVWrFa810G/vRs0up2lQrVd31qw26Y=;
        b=mcyxnHaIp9qHqzWqSjy+ATQ0Ev2P7CLcYGWtHc40+r+LmbPcbfeU+rmzRS2D++4nJx
         hyHj9He0z99Me9fO62DiN8D+b679+av7t47urmYYtMCt+Xn+NR/LJNNcbkIIZrx7l9NF
         bgGcYjIXtyWsyTSzEiWcVTuLVHVdbLRuHccUoAzQ1Z3SaDAdiHAL6PKLk/0iq2Ip3CiJ
         q9K3vjG2dXTOrA3tY1s/Z2Bk0I7teMYmcuZnqlCL/ymLd2WOebs/9SWBgIjIgcGfPe9x
         NwZ+/FOtQEhN1kXuG0yRYwaVvocZZF5khR78EpvqOlTL5THVTOBSgF2JJC0ORMCrRvTI
         mlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748357815; x=1748962615;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kdsCN36KZ9TwfVWrFa810G/vRs0up2lQrVd31qw26Y=;
        b=jMNXVt2cuXFrUBfalXG0xVMDUV3j/SreZxuh8IqfRy8+x5Iq4HcHW0235BudsLA8PF
         jS1yOnKjdM4rNoGPbAA6I/EwUxIZQh06Mc7Y6GfTgr8UFqrWoxfJJ2BHMiLIwDw74Kmr
         uq3YmBLzs2uz7JaydvNPwh4uWfPmmOpaCaxVcqHwvKaQBGXHWYAuhshINGMttI58FS93
         VAaynFx/BXtwrqOc89AnYgvYE2aUgq120swr9FCT1UgWeqi3HVG+2miPUx/yFdkf/8KR
         83PFlEj2GS2v5VY0Pt1aaEgZmTsw9UhMoWc18ULipa6S+XutZwLPExSSVt38MIaoggTK
         nJUA==
X-Gm-Message-State: AOJu0Yw+PoV5t510p6H7i3EoX4lSmhjvNoAV4vTgm1/UeE1uutP0BgjM
	+4cgOIjzfXiyKMFSuPCnt3wvWPC3YzFNo7kqXT1RCi5dfFRsP6nO0Xe5grXbpg==
X-Gm-Gg: ASbGncvsJK6T+5w5K2pRxQl7RsZhqgHRuvQILyEgqMjjWz0DXzK9KCuCp+5JwYRY0d9
	9N1yFSlT5DXLrkTi7dzW3bRluM0qbdvbS8uKZBBnv8fv0PxNgRZZP55zILgxZ7NmFWvTurXUpkN
	t6GuQCDMbn+/jKWEgBSJuwBCvSv6/Lo3oYcf7X7mbMRzeL9Wa1bQ3v2gd93brKvjX3n1jaaYPi5
	PQ4BGJ7wz6eihR1vs/U165RHI7FJm78FNYnZJABToEKCe9/VEYOZazy7y6IoteQwEiO9yFuA/b6
	IbItS1wiSr7SIIEZGdQ/uBdGscfIG8ay00N/yQV2ox0xO6ZOKIetFqeO
X-Google-Smtp-Source: AGHT+IFIpwJkg2aKATM7n43hfxzRBRKax9sMyWk+IMFz4h6dC4XwNvSIiatvi77HwvZrEd+y8jnSRA==
X-Received: by 2002:a17:902:fc47:b0:232:11e7:47c4 with SMTP id d9443c01a7336-23414f8410bmr219451735ad.15.1748357814804;
        Tue, 27 May 2025 07:56:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.18.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234018ac5desm68605215ad.158.2025.05.27.07.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 07:56:54 -0700 (PDT)
Message-ID: <6835d2b6.170a0220.3495d3.a3d0@mx.google.com>
Date: Tue, 27 May 2025 07:56:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0043366485871305352=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/bap: Fix not handling read offset
In-Reply-To: <20250527132831.232633-1-luiz.dentz@gmail.com>
References: <20250527132831.232633-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0043366485871305352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=966677

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.32 seconds
BluezMake                     PASS      2679.68 seconds
MakeCheck                     PASS      20.51 seconds
MakeDistcheck                 PASS      201.13 seconds
CheckValgrind                 PASS      274.93 seconds
CheckSmatch                   WARNING   301.75 seconds
bluezmakeextell               PASS      128.23 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      914.91 seconds

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
src/shared/bap.c:315:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:315:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:315:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0043366485871305352==--
