Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EC52874F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308518; cv=none; b=j6X1hl/E6f43zogTz/5H4Q1u6O9erva3GIieL0wDyFNEfIyoMS83lJ/R6t0MT+0benPbvd+LbWpUlog678eyrrdkH4wPiStx8mKECRAY5mJ0im1Od7IUz/4e5QFOfmCYXrrrX7wMH4qf5bjTM6o7PaGDqNYl0U8Xe8G4WFNFkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308518; c=relaxed/simple;
	bh=m+yqNXgvowDfapOT1Z+NWsMMpWw7C2ZOCTvkPe2zMMQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nzdh9se14Q4dpPXT6eFdEqZRb+3YQ+Z7azvn1+GLjes7luXz4DCOrt4HWPtUSWjNba0mMFehOWNvwzDbTOY8NW+HqnTKvqU3FR9hI+3iFxeKrW/iWBJw+Kg4m+yQIOHO/55t4EwJSXduIDCwAiQdkEBpp0Rix7NvzjzXT3g52zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1uwLHvr; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1uwLHvr"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e566327065so4957405ab.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308516; x=1756913316; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gORT5ZGj6+yPpU0H7Xg50gLNUo0VtH4fhePzszCmZwc=;
        b=M1uwLHvrZlCJIAploXigQ7I0OyYRhPt42bh9NS+Ox8wOdTAyIjFgoSjoetHs/IVcPg
         PGQXGAWMyX/I1crZ5n+SPUEES19YdWRei0W+tYZSdwRvsmYcYKb0ihsYQGVQhEMEd94+
         FEMgWAiGPMFc8E/BPupW33E/jwl0upK9OWvM+9NOq5p/tUHYY59qf3KSu0jnrVB4GzkX
         xdvNICXzGeULHwlXYFL78XxBihULVM1vvL/EvnIC/hBf6rmsHP1WdrX3+wcP4oY8Gj6w
         xyuADuyd6GWndcXpP5G335xdP4dbEG+A+MC4YvNcf/2staMjQQ9IybQ/Jx/2BMhGwqpz
         XRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308516; x=1756913316;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gORT5ZGj6+yPpU0H7Xg50gLNUo0VtH4fhePzszCmZwc=;
        b=VWGKp0en4FBfJ0O7j2loUW0yTj1UF/t3I9TRevF/o/qb3e/VKPao/iM4PgfoFCX1vt
         OfmVVEob0hLcQcvwCnSVamgzZ/jTTW+n9FD3aYOTmiejMK6d/ersgpPEqGhvw3aANaAZ
         4CE6HADoZXP1muHY8tETEHfpA5qYu8rPISLNT/D7IB1pCTg4XBYnJ2SRXDJndsPRWqe7
         r/SrsF/OXREzTR8Ip2CT8AUKlZLgKVPQ5/V68XreGhrhPl2zcNLxiFfMhAvb4HJD697m
         7hcANwzP/jFD17JKA06CJJMilNd2MuSX0p08sYA0fMJuXi0OMeTmJ1lwnda0CJJ6Kuns
         8YZQ==
X-Gm-Message-State: AOJu0YxSj2r06SCMGdag5l+8c8h70oY2zpn9feAANsg6oqF/13L05+Mz
	zM3LXxSkpLUrHd+KNxqdKRE8KyVtN3R7A4Dg+56Nbuer7FPdSNtmC+yJ48Azrw==
X-Gm-Gg: ASbGncvOGBUmpiGtg4eMOCorbrsppn/NOgCnUZZAJXtZQvrYb/mD07T5qmnE56wcQ0f
	19W1XDdGEqV5Om2hsevfV7mrRI2Q7tJ4TtiVJtlhFFEEXoopI1ArQFyx/E6Feyhf58swpBGxjkj
	mjt5Dzgl/IpHUxUUKLqKY+3g2nJ5JvkXdRhNzH0jWRMK8mGkWifqoVCJVZP7GJjB9LhVXLWOcLo
	ga6SdgK4bM1uBd29QjsD1r2AkhUWW/673GzUFZjccEG2gnvrLO7aYZL1R0XN0s4mhyaR+kWlszc
	jNLSOJt+MfPqhJiLPymUFs32QK+5r5oOASUjhrHtDglbTMRnpfAgVdxV2PF3+CqICWcc/X39LGs
	G8/uqyfkLB0htDd6Holv5RTq3066ZEVAJAUfaRBjB
X-Google-Smtp-Source: AGHT+IFkxHwoJCAzIKLU9MpBy1ijopW6V9okGpJfyXy3pHtiDIg8HblX/X5oiL5vJyhHu/LnkAmUQQ==
X-Received: by 2002:a05:6e02:4719:b0:3ec:4b19:1cff with SMTP id e9e14a558f8ab-3ef0894d170mr87884805ab.7.1756308513899;
        Wed, 27 Aug 2025 08:28:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.178.218])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ecbc25c924sm59379755ab.10.2025.08.27.08.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:28:33 -0700 (PDT)
Message-ID: <68af2421.050a0220.532f.c82e@mx.google.com>
Date: Wed, 27 Aug 2025 08:28:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6697209589355605025=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client: Fix transport.acquire not doing anything
In-Reply-To: <20250827140416.1338566-1-luiz.dentz@gmail.com>
References: <20250827140416.1338566-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6697209589355605025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=996079

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      20.01 seconds
BluezMake                     PASS      2657.70 seconds
MakeCheck                     PASS      20.46 seconds
MakeDistcheck                 PASS      185.78 seconds
CheckValgrind                 PASS      236.97 seconds
CheckSmatch                   PASS      306.68 seconds
bluezmakeextell               PASS      129.75 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      928.25 seconds

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


--===============6697209589355605025==--
