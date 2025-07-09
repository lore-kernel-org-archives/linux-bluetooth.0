Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB82E0B44
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072988; cv=none; b=H4FY5OfqwEyLgVjMbtmKIAeTCQ+gIPG00GANygZ6RA/Icer+OBGTtHkQ0wGMKuDEr+a5pfFEsoqdJkAgEhHz6QTN8ihRnZ04nLcwyylGjyGhI+ClmfoyRPDa1JM0EKF5rlsCPWm7VZYd1kALzgXkCRuehObsEthPS0aUPW0kzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072988; c=relaxed/simple;
	bh=0R+cTsQDWzfzan9vuvraAxdEFAfSVcI02TDCOlf+PQ4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XqQyDKQ6QWaTGqQhSi8bgQcLY4/myFfpSLMGIx9v1EpC/ocCjOVuXbW1qncBiRoy1p2RjhI47QDI2Z+YUuzN4fLQEYkz4a8ubCm+ausDPgTCTfp8HzuxgIPb60gWQXDnR3ccYmpelxySkqnRYGNqi7QY9Zbp6FLFVSpTPwlKsxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaNOT8HE; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaNOT8HE"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-86cfc1b6dcaso1521439f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 07:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752072986; x=1752677786; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+nRzDm+i/v2xDPenC0gdjrQt0v3lgf4jCGcfxz7uGRM=;
        b=XaNOT8HE3HkR/ZRKltd92Px/mEejoBZu6HAWSuKF776/ftzc+O4T038RqlZzUb5tYF
         3wnhzCb/zSJxyCN/RshteDqCtF8FqfJQAgf4MvauOOS3F8gjEuE0uw2IkJdd/tJTMeez
         WdzsBeeN1PInoBu97lw+eelou6Ww7rq/G4859cG7Bxi7XarpxMQobEv4It4QHVxHovV4
         i7nnwvbAIXjgDG6qe/MyWIczJotVyLgLhOq6oVUQ/Fe6v74cvrQ58+SXuLUcXJhdCXow
         +pQwSC+OEcnMIx2uUQmhn+4liLT+ZW3lG+1mjkWFEUAmSu3DNr8OC/caG3/rhXBmhR63
         9Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072986; x=1752677786;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nRzDm+i/v2xDPenC0gdjrQt0v3lgf4jCGcfxz7uGRM=;
        b=ZiM0LIFhxnURJvw4UjVeqXtcjzlKyh35bI5XMig5dvNQGihucPBg5+qARsLkSan7E7
         2oeDCptKRc7FIgeC/Kit+1J0BU6dwcU3M9hR/YRxOP6x5G78NyhZPvCvz6rPruCSjkFN
         CQzRZct563dPBer9H+GnO0d/JLO+gH/P80tsRRDfroWdagKR8BADjV+FeNu7tz3BRLgP
         UWvU6v9jrZiO2g1oUYKeiUNm4GH4hfJZ9EAxrgta76JK2AwxWTzMXxXZfhwuiCRj44fl
         VNFWycb4YLboJVTXssfr1rMdr6pA5RYgXty1jf3QkIz61hPoMJUbRcOSFAmxwSdUVaX0
         5glg==
X-Gm-Message-State: AOJu0YwrPAj9UHtkLaaJ2jDOcAsd9HNwg/S02xqgBc3S0A9NDH9IcYOL
	1d4rCrtI9DCgotzCB2xszMrLE7CZCQVndGzG5pqP4SscWn91dDH0zHgVASsBAg==
X-Gm-Gg: ASbGnctsp+LqY5lcFh4COLXtcr5AOBqpROMUgbeaGakKQugY7DvciswJfgCh3Vrcdye
	2FjeFEdOUoowUzc9ubgq+SKKxMaF3byzDLPLNGXPKH1psB/RKFEjemQsiXDOBBITN3UxQ3dIu2F
	IOzUVJcYS9CYMis9rJKvNjCOcphuwfRT1+5yDfxB0+C3HbJPgcW096uV7qZ4oLOvgKJjvV2NzpE
	brkeuRtsb9aFk2f6UcWkFIc9PAYkpbyvEk/jlIikVo+cW/k7uiJb3bH3HG3eYGFo4226bkc2Mdl
	M6S/0F9mfgf8JRy5gba3EunMG2r1PGW83Yj/PCSWhnTLhO4HvZA3me9TSE8ar7XcZQEN
X-Google-Smtp-Source: AGHT+IF0HIecSjx/O8phMMbcClkvfoLm9ZYwKSssFlFXlamz3iRLnQNz0NPaT1bP7JlsWlDWyhId3g==
X-Received: by 2002:a05:6602:6d0f:b0:85d:b054:6eb9 with SMTP id ca18e2360f4ac-8795b4e0b43mr368647139f.14.1752072985701;
        Wed, 09 Jul 2025 07:56:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.180.70])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-876e07aa39esm304261239f.1.2025.07.09.07.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:56:25 -0700 (PDT)
Message-ID: <686e8319.050a0220.2e15ac.4169@mx.google.com>
Date: Wed, 09 Jul 2025 07:56:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4495176673106386800=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] shared/util: Introduce strnlenutf8
In-Reply-To: <20250709131453.3203903-1-luiz.dentz@gmail.com>
References: <20250709131453.3203903-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4495176673106386800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980525

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.10 seconds
BluezMake                     PASS      2673.54 seconds
MakeCheck                     PASS      19.93 seconds
MakeDistcheck                 PASS      183.65 seconds
CheckValgrind                 PASS      235.91 seconds
CheckSmatch                   PASS      304.57 seconds
bluezmakeextell               PASS      127.47 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      918.66 seconds

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


--===============4495176673106386800==--
