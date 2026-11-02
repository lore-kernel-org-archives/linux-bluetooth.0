Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610486;
	b=Kbi2D44D0MsNDIHjzJf3RmPINFnLD/ZUpoN86VPfjjW2tgMPsDbZvy9dkIB06TMfeA36
	 eILle8Ocw1nMhDMadfHmk181pz306Jz1iAns3VQnhuvf1DcoX8UsrKfXt62f69uwYiiN5
	 1Py1A61tiU7DLb53GSl6UCZ1UrlZ7uessRBV5w4fgf+q7nC14fEJigVlaZxwqwJDl3Nzl
	 OfQXqBNAbxeP3m+4lH8nAz2lJPnZSQL0F5tcylVFh03t1b3YNZWhAlLLhnkmYiDd9S1kW
	 nAmp9XJ59IbzqIZltot5FdHDnAsuJ7hN9G35yA8VeZ1UT4dZCtuLYDZMneOzsAhz5EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=sprFlcXfVCyoRFyVc0i5CR6tTtfxq5e1dCiCfIw2NEA=;
	b=LjErM5OpFFwyFmfw36/7trhEg3UB7mU/++imwWjpdeETgbDvE1+7sf9t6UuQinyrtU5b
	 oW2EiP3PBbRtoBJkWKoIsuGypvjOKYchKDGKvrZ4x9PjBUVNeoY6vQLSiCgtpYOxDiOHE
	 kUOd34sXP/eeQFbQ27DMfrvGtcMGXINXNPaRpUfIayHU6viDX0zcYYne9G6na40o6qgfF
	 NOs3ic3pRxBHLYOO52cp6meKo/JGrF9l/XzZlbAsUskyjuBvS8ysHoU3oTYElotVDZExp
	 RGERDceXpz2ocv+O7cA+PG1oyTX2xqlrE8tsUZ21liaABaQNusN86zmme8vDKd//lbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vmOlSfGf;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE53F606A324
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 09:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE53F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vmOlSfGf
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-85c1135c286so1766745a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 01:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793610485; x=1794215285; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sprFlcXfVCyoRFyVc0i5CR6tTtfxq5e1dCiCfIw2NEA=;
        b=vmOlSfGfEwpDAXlBbnSzYcHqmtV8TAzZluvsvspZGKWlNH3Ruo/vofWND7LirIYXy4
         ThC8JTzcpbm0gnzU05rvUIIoMG5mPt2D37EAVA558uWBUuinb3C3x76FAuul2/bcSpZB
         ECfVx89xSgyfT6auMvhM9f+voy6+ukMXcm7+LC0qfJ39tHTfNuUAj9C3+xiU4KOijr11
         yrQvrNYNM5WmCOTucMxRXyyXOfGIGMr4KBOWuIJGE0356q0Wp3rD3xdRvNgNag+qFUjC
         ZYv08qg4tjzhFe3ddhpOXQY34hMM45L5gRQxK/UOTjSymYT+2pGgtuQc7MgPxOqqg4jR
         VNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793610485; x=1794215285;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sprFlcXfVCyoRFyVc0i5CR6tTtfxq5e1dCiCfIw2NEA=;
        b=pk2ikqqCmYMzbnSMcWCq4s2tieaeLpVrVnQhyX6t0IbPwJwN0mnv+vJq9IyotOGcTN
         m8CXr2i2y+/Vy4zv0Mj4F/jH9Nt8sbWbP5WPM8jUjoBN0/4Hd9nOwJ92JqyF9BHnZEa0
         j4ve9oMdaxSgJY53xyOwNgvwfaXDP+ElHGd8XFb9mx85tYshbj5rXLGYe83SQvYAvuOH
         1fwUNTS2zPJSCctS5/tVagSYMN1cZp4xuoQ+Hc7paWKQ4V0C+pcSItFEK+9CIr9LYnRQ
         KNyJ1vqWzVc7ZA8TyEQR5/nk33rIxkzzCNU/Vx2MKY0D00Yb7llIH70Q1dsHR3QTtERz
         BXXQ==
X-Gm-Message-State: AFq9FYLyJ1qSO+LOj9T/w3WI7R/tgyqm3fvis/VFVwGDN9LVkwvdKgK0
	4fhmiejzavIDr0zVdLzYDSGQ66FUivNjDgVQeNershb/BzK5qF3/NlPs6XJXlQ==
X-Gm-Gg: AYBFou2nYjyNMAm5XM++3gRajwYP8OmRCkQELsFcZho040h1emsLrfVzOTseTx+KCIu
	LBIX5E8LqHcu6OqhaznP9LzH9fAqK827KIjWXC8ZPaq/GHyqCypPK2LsbX1KEGSY1Qqtz5IuRBD
	+DZKWMumL+xotnxQE/qAqF+gd6T4jdWtwvVCA28cRZavzbQhDzcAF2imqRRQ4Bnx3qgRIX7xeVi
	ZyxBD71/6/Dr19Dq/bVX+/oO+wvNFTUYZBgevt0+47v6GX5T6DKV64K33NXReZOH46C7JTQRXUh
	+Mxz5+siZzTa2QRAWzag2YeeYTEQwBf04XYKoJ5/s7a0+wh+omBIbpogXdYqyT3u8QeBimQ3iLH
	W34faxz6CNm9hIf0oSuX45POEozx5x5toFL1fLBB03iNIBI/kQZe6IZLu40szxxo4WzFZv/toXr
	aV2tKyP2KAwgk4mXqzuPMnGlt8F6RJs4OBamUbMXXeBNQxKWNPkHQtFNtjqg1mxQAWAkgOCYumV
	W8p4ghLBPFA69YPGUyCXjHnwKz9ArPsDGyvTeFEKV3ZLEleLiLqPKugvGY8HNnp
X-Received: by 2002:a05:6830:2709:b0:844:ec25:c7e9 with SMTP id 46e09a7af769-85d362fc927mr7828297a34.3.1793610484828;
        Mon, 02 Nov 2026 01:08:04 -0800 (PST)
Received: from [172.17.0.2] ([52.183.221.246])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d355295fbsm8829452a34.25.2026.11.02.01.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:08:04 -0800 (PST)
Message-ID: <6ae852f4.d643d4e7.f723c.a651@mx.google.com>
Date: Mon, 02 Nov 2026 01:08:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8551121075342478611=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com
Subject: RE: Channel Sounding and RAP fixes
In-Reply-To: <20261102081913.1623864-2-cheng.jiang@oss.qualcomm.com>
References: <20261102081913.1623864-2-cheng.jiang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8551121075342478611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1198568/

---Test result---

Test Summary:
CheckPatch                    PASS      7.35 seconds
GitLint                       FAIL      4.51 seconds
BuildEll                      PASS      13.67 seconds
BluezMake                     PASS      179.90 seconds
MakeCheck                     PASS      13.01 seconds
MakeDistcheck                 PASS      99.32 seconds
CheckValgrind                 PASS      157.65 seconds
CheckSmatch                   PASS      179.66 seconds
bluezmakeextell               PASS      63.53 seconds
TestFunctional                PASS      845.97 seconds
IncrementalBuild              PASS      317.45 seconds
ScanBuild                     PASS      637.91 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,08/15] profiles/ranging: Let StartMeasurement() pick the Initiator for Both

1: T1 Title exceeds max length (82>80): "[BlueZ,08/15] profiles/ranging: Let StartMeasurement() pick the Initiator for Both"
[BlueZ,12/15] profiles/ranging: Defer CS Security Enable until the link is encrypted

1: T1 Title exceeds max length (84>80): "[BlueZ,12/15] profiles/ranging: Defer CS Security Enable until the link is encrypted"
[BlueZ,13/15] profiles/ranging: Choose the CS antenna configuration from both ends

1: T1 Title exceeds max length (82>80): "[BlueZ,13/15] profiles/ranging: Choose the CS antenna configuration from both ends"


https://github.com/bluez/bluez/pull/2747

---
Regards,
Linux Bluetooth


--===============8551121075342478611==--
