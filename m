Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993071754B
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654747; cv=none; b=nP8OQTA2Q8KBgmlMr3WllJK0eBn7JPeu95JaNPB1/4xLnhbg5gY+AMIWbrY7T98bhS9rBv2fiNXsC7tpVluPzlR/s9rJohY75OZugZRV+/Orf7bC03UDAj7pPtC6cV5mMW37bHxM8EWwftTIB48j5iy89pjjp8hn4AJ3YT71Bb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654747; c=relaxed/simple;
	bh=E0Tq5FPCJsHXbLnTAsrFokRTXK6Tef960aRABQocwjQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XiJLjYS7+IUwE7idE+MWlGfcnOgXGj8zOAPSA+eIb+LL5cuV6GLQx3PSMuD1hOcLQfGAfJWqM0G81rEFv8KYb8CvBWvyB80hGIZzwmYuoOqjVaNsi1Lk8ZYrwjoIY4LhKDu/opjK9VSGcIMJlqCNYoHwjja8ZKS9cRYD/NsAI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vn1Cb2uS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vn1Cb2uS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2156e078563so77121285ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Feb 2025 23:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738654744; x=1739259544; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ngbNHRSTw3GxlAj2FoJCCgcCuADidnYPFDmzrVXzHHE=;
        b=Vn1Cb2uSw8M6Pm3rogNSCD9n0MZTgTbH46wvOveIpE/mL4qHOd1ZMzoZMHN15jIn3t
         mivhjhbGdv1zKiZeGCTKMxjoRkPC6AplpjlX50A+FgNJgEfHEsTvTIcCLpVyrUnW2IXf
         hdh6n64n0eQ6+A1tF7KOtVn6OlJKAWwxs/JH4u1j+uq+OeLpmdTCuBNqyory3jextcLP
         4EinV0sTecH4fj79IBdlZn32SF25bD9Pu2jncgwTdhHTHTpphQ8RIDRd3AfoaYnLmBMp
         RZmyj+MM5TTbALmMZblsHgicoUecUBPVJTT6Floyu+mK8lEZkSMuBGzLAZMa0J24eKf7
         Tixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738654744; x=1739259544;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngbNHRSTw3GxlAj2FoJCCgcCuADidnYPFDmzrVXzHHE=;
        b=bX/qvctT+hdNJ6RtKl9DW1yyuOzoeBrB856Nve351eCXgYqTqKC/Sx9jTB4RLshKPR
         jhmIF0Jg4VCI3s1OXWfBXkGCIuQRcECE7A2iROHkI/CqyMRWXdxbga6hd6q0thgGb/yV
         /1MvAHXyhrR2Clb+qgkJ+cbWsblBetztwH0A0vY3+ery+80QkFP3GQj5GYf+3PgXf8FS
         bN64cpm4CFOLlHOCbIkRRQKRim/MxbOTq5Z3e3UPQfTSdZVwN3ipDl7SfytWlbixMh/k
         Ulxqs3jelaSUGEAxRWBlgT/wwNBe+TtAaR1nNQSXAsibhnYymCJ405I1k7ryMTldSgEa
         ogVw==
X-Gm-Message-State: AOJu0Yy73xbNkXI7X/C2infmxN610cJlBGJT5m9p+7ssSXRaRPx0EK9q
	ZWd8SmQZIqg8hYmL6lyjriP/du/WG3Y+4Q1ykaMPrdw+T+1OC26bi11PJw==
X-Gm-Gg: ASbGncsHcRFm2x+6oJ3k7+E8tKXG4/pOfNIcsrjc/iTk1UFEYxc3jA7S55sfVo1/i4H
	7E2A9zQCzFruJdOFHvieVxtJqGA4HXkVIFvvHEgP/wV954yelFDUPLAaLqc8lRUkqfoXQr4f6vK
	MVpZJBvw3DJlL3zbzU5PU4XjIpXIKeQpmJIfntMRGgWs2xUt+sgmaAb+Ro42/y48rDSVCEwktZQ
	xGlyjEpe4MCGD8qCFs4JcRuVA2p/J21/s+EzCZuvu+T9M1sP1dvdlmTFVe3eQMn3rFFWUN/Y2cw
	RSV+I0lp2BNUCt/Rqlg=
X-Google-Smtp-Source: AGHT+IGTHRZEdpE19tyH9nQZuvk1nP8LJGJIZGk7+1ZuZDBF+dB6iy7lmrfHrwsHY1VOramz+bSIVw==
X-Received: by 2002:a17:903:1c4:b0:21f:456:3afc with SMTP id d9443c01a7336-21f04564d3emr23976445ad.29.1738654744445;
        Mon, 03 Feb 2025 23:39:04 -0800 (PST)
Received: from [172.17.0.2] ([52.234.42.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21ee6b1c4basm54764765ad.82.2025.02.03.23.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 23:39:03 -0800 (PST)
Message-ID: <67a1c417.170a0220.22989d.7a4f@mx.google.com>
Date: Mon, 03 Feb 2025 23:39:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5533303392231326489=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sanchayan@asymptotic.io
Subject: RE: shared/asha: Add support for other side update
In-Reply-To: <20250204064103.672327-2-sanchayan@asymptotic.io>
References: <20250204064103.672327-2-sanchayan@asymptotic.io>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5533303392231326489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=930325

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      20.57 seconds
BluezMake                     PASS      1532.14 seconds
MakeCheck                     PASS      13.34 seconds
MakeDistcheck                 PASS      161.98 seconds
CheckValgrind                 PASS      217.89 seconds
CheckSmatch                   PASS      273.81 seconds
bluezmakeextell               PASS      100.40 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      880.84 seconds

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


--===============5533303392231326489==--
