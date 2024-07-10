Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821F18FC62
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607887; cv=none; b=uVrIhKrP4+LMmiAepYf41/PTx0PPP70CWpISseOGNP3MCiMWCaV5MjHWtrWFi9bXHSWqhNkT3lEze5/EyLX4bPCHFplGkb2aCxa59YP3xG9SFphjDxg9xVlQ9sBAePE9vs46Rp36OJaoumzld1yC0o/hNAgs1vQlw7MfhnucTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607887; c=relaxed/simple;
	bh=BjLvA7ARJMCp5j/fZSfRH9CMmMIMxeJu+Oj5Rf6Dlgo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=G4YwSGJJFfVoSxR0Gh7ME1E4DTFGsf77ri/fqT2+D+d+GRycmUymCAOa1hKcFC8mbjAKvoQj5B6eM4AVrwGu8iVnEX504cbg5w8UYlfJEopvrmBtMdCxQmuXJSUpTuLupYOjydFoEDsDD/U9GgIFfKudG8DZwRSdLbQiRGWGE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVI8youp; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVI8youp"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70af8128081so3945576b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 03:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720607885; x=1721212685; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p9byN+DaiLsdYt3NF2mczGUKEX26Ojm6Hm77SP2Kgpc=;
        b=KVI8youpyROQrRB14/jXygLXmOCdqdw8EpQ+OQZnSZcMtAoYoF3m5DxRZEudMjMAyy
         gYD1fjC9oB6Px0svRbAsvg7x0e2x/YxVeHzzH1j20r814x492z4kXQ/OMpw7csxCTU/m
         aopXnt+m2esf2Xku8p6uu2696C3J3ViuDiC+CYDcNTnjWQHIPc6qBuyzD0u9lPb5Ggan
         q4RYakW8drwkAYwsuKrEkmH0h38/eZBVJQQSokkS589vp3HDZ2QvYzsQOPoclSLt3g2D
         rXoya1gSIeBybZpOj7qEOOm6PHvAZptMvg9gEf72kJ9j4OvRBV5lBh+iJrdXAP42+SeW
         aVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607885; x=1721212685;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9byN+DaiLsdYt3NF2mczGUKEX26Ojm6Hm77SP2Kgpc=;
        b=cmesXmReE7R4JNpDWZymkNwlgKuL+4jtGRcbJ8UE27b9i2HnsFZyizWXWLH7YCap31
         oovhQK7BztGHXvOY8Jom0V7ty5P/HaSCChTHJg2d6BgC8d2k0i+intx4lmyNXXR7ygGM
         VX/dHMQHmpMWLlHjc/LKLp7NaqyePrurHr2hVCE2J2+neARp4KaBItPmDgubFMN3XP55
         wHHhbbwfYm01ZLKmPtsZ7m3FftgN+abnmQFZfgOxkGrYFKumSvhis9eit59HUKC9Gqi8
         vscQ5poDHmuALo0bypvAIdWH9nfRC1jut1GAyhe4neK1HbjZbDs5uRh6aOY78p625gy+
         H8QA==
X-Gm-Message-State: AOJu0YweeIRvGZoJlzduXx6XujUvsOYAUSwrU8qXpz0dap9A8A9W0qfd
	hBG+z2kQ8gQqu6DkEIIbEjJ2X92NZeVFJOQTJad4l/DUgtPqjRa4ypUlkQ==
X-Google-Smtp-Source: AGHT+IH8lPmjdOr4UUbnazbJJ8tsDfcIlREM/ivri5ZLbr9H5n8r2RCHilT6K07cYKFcD21WT59lPw==
X-Received: by 2002:a05:6a00:198a:b0:70a:f007:468c with SMTP id d2e1a72fcca58-70b435106b4mr5774788b3a.2.1720607884934;
        Wed, 10 Jul 2024 03:38:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.40.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c0996sm3436105b3a.60.2024.07.10.03.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:38:04 -0700 (PDT)
Message-ID: <668e648c.050a0220.f0bbc.dedf@mx.google.com>
Date: Wed, 10 Jul 2024 03:38:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1829379554686490366=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: Add transport.select method
In-Reply-To: <20240710081338.17262-2-vlad.pruteanu@nxp.com>
References: <20240710081338.17262-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1829379554686490366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=870003

---Test result---

Test Summary:
CheckPatch                    FAIL      1.26 seconds
GitLint                       PASS      0.64 seconds
BuildEll                      PASS      24.52 seconds
BluezMake                     PASS      1739.85 seconds
MakeCheck                     PASS      13.02 seconds
MakeDistcheck                 PASS      178.35 seconds
CheckValgrind                 PASS      257.44 seconds
CheckSmatch                   PASS      356.38 seconds
bluezmakeextell               PASS      120.24 seconds
IncrementalBuild              PASS      4541.04 seconds
ScanBuild                     PASS      998.06 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/3] transport: Add "select" method
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#127: FILE: profiles/audio/transport.c:966:
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
                    ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#127: FILE: profiles/audio/transport.c:966:
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
                                                     ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#127: FILE: profiles/audio/transport.c:966:
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
                                                                        ^

/github/workspace/src/src/13728985.patch total: 3 errors, 0 warnings, 42 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13728985.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1829379554686490366==--
