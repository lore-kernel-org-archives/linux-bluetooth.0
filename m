Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571356;
	b=2DILsMoJxKUdkHp2TtESRPvIt0qaEDVwwpgXn/Vnmch8zFyBsVHxpqxC/cNFUnqManFN
	 SjrHHUwrKwq98PMN9q3CiTonUzUjsjEOjQ2Zi/9+bvAiyGHeuYiZ/GoRJiVUANZARWIlg
	 hLT+cZXjbjRymsvgTwm/dPo/LqXLDwSq30lLKyao6rnS07/r58Etc7qRW83cPbWq7DrsZ
	 G3MBMez4ZUq5Cb9Q/NpsXCORNDMFTkgx3lKu0gZq1wcaWTgryuJ74vteobAqwAf6quHU9
	 1M1LaS62OnClrcrovwPs9H91DY18gg8hnhxf/6BnyMvcpCJwCfS7i3N39uzOEHQm8kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=5gOgirTaU5Wm/5O7k25kYGdyrZLSbc8ZPeqTsQlvllo=;
	b=ClqSGaVvfWaRNNwOhRzvIuMSQAfsuojn0iYLNHiM271PoRosfgM1IEuJxGa1tdqclnEU
	 9D2PTsRNrNy1pBcW3+Bcmz2nSmAZra5cdrjmXGdgRcP3wGJ4pbFM6LO/eVO1XFir+9auv
	 v8B4CkN4zpTOAXAI1ZKGHVZIc50oYcE/7BkXqxQYjECVjuA8ZfwzIo+U0In5W1QiWIZ+f
	 PvR68e/IlU3OHvSQjenyTGVjDJCOeAknZ7sHkA00l7RrYZjiTtQCEC5vSbHJS23mKQRrd
	 E0wv++IZnZdwx1DaXfo0+CpPVRkZwutd4Fb1oW5+DTjy2dvvADyrm6kHh/eCOvN+2wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pNa0AnNN;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1251606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 08:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1251606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pNa0AnNN
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5366ae57896so5347541cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 01:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571355; x=1793176155; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5gOgirTaU5Wm/5O7k25kYGdyrZLSbc8ZPeqTsQlvllo=;
        b=pNa0AnNNenHwP8wc+YTX4k31n9BojK0AlellFEM1luQbb2z5FfxUcXrJGjDD6MoBJP
         kdJ67I2nW42kMvYftm6IabaOm+cCg8VNasjBk1lXa2sKyM6gwqVyrONjOGRDjtcBIufK
         QP3juHpuM9k6Qmxlq4i6C+g9Fs4DdkW4/eYB8++fn4tf9QxM5qvRymfsTBtWJQfMV/hp
         pl4O3/CetttUb6qIgixQOLFnNfwMGXiwZxY7L4y9T2OYqt5prKOh4Cez7LLAs7viAFNj
         2VIezsc0l/M1g3DW3PRTiRFNZfDhBIbQamZpYYDwXqLnCBTya5xK/KY/1dPKU0PBQuPJ
         F0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571355; x=1793176155;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5gOgirTaU5Wm/5O7k25kYGdyrZLSbc8ZPeqTsQlvllo=;
        b=R+351MIlo8YUN9DcVJEjt5P7qfmloMrlJy8n/+z/zkN8Y0zCZ3wZn3Q4mcjjhu21+f
         zs0Km6vP8+qpizQS3hbLEqnK/9Aoe8WXxPIL+82GHLlhWHiRq9N7LSEDxk/fw/RcX2sC
         V10GZ6tlov4pml0JhGecc8J2BMyiANwCztv3nl3A/RjWfsua7dNFC0HxEj/emhi/5EYr
         l/XhcDF1isZvq5ceW0FUNNioekeP3HqnYmnbEt3m5apeVIK0EvS40qB6nGccpfWqczok
         m+6Ilbng2CFs/Pq7j3kF22GKDWXNCUI6nnn3To90yh9SWtdaDK2QcMdrvWJ8Sn2+5qew
         QDog==
X-Gm-Message-State: AFq9FYIXTr5rwJHyJ1FyfQL/aXIX+fiMFdyX/XbofC+0ZLaZ5jOo+51l
	oiORJKUCgi/ugkguHEXeqJ2SlE/cUgaLYePFeli0zx3NI7+U5/3uZvMTR/tXEA==
X-Gm-Gg: AYBFou1nGgE6e58/g6yEd8aLjdDgjJBeoLzVEUpz+lLntK0fM+xqAKghGRoy9g9N7ju
	KXflqgUhNr/7zWlJbKfwFe3mmW5NafkQWVjpG/YRd/1ceG2awFfdaaGJ7NH8dsj4jINx5XqrPTC
	viBMcMeTaFi/K0Rh+XXceejMMP3RI1icAMSKgUs4v1CFZuo3NYRiHk7QMf6fMv/aLVpErbawhJS
	eXVaBEFg3D3xUfKrrGttur0r3Wo37nTE9wrl/QuNirslGC43JDYWRdz9jsJPnrePIYQzz4NzH3t
	QE9ABZg6gdXJffSp8Q2S9hAiKqYDRzCrd4ftb3RLK90YY636Ew2x/pFe72eNm9nGv+a9S1dN5WU
	yoQj3XicIFB0A2oKot3tzuK50Ybr+S2UbXYG6T4XRkwUMZBvWLuspHgWJsZeyeZ0xTIS7fD2hT3
	q4B7c2ueZDFlvbOC1QyJ54bCQ7twjhYfZiFOPYkXGvi/6CMFBvA5iMPs9wE1MWnCon6O5JcjIF9
	CMd1I0/SbAhI87iazqL2Fty/zf2LTIdMnYjjNvV54OsFvFMU68EoNwpxMJm6Kko
X-Received: by 2002:a05:622a:5a15:b0:535:a5fb:67fd with SMTP id d75a77b69052e-5369b8d4adfmr20667651cf.73.1792571354837;
        Wed, 21 Oct 2026 01:29:14 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.118.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53698b7584csm14337921cf.17.2026.10.21.01.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:29:14 -0700 (PDT)
Message-ID: <6ad877da.8830561e.23e72d.761e@mx.google.com>
Date: Wed, 21 Oct 2026 01:29:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7484627526658439052=="
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
To: linux-bluetooth@vger.kernel.org, tooangel@tooangel.de
Subject: RE: [BlueZ,1/2] doc: Add CONFIG_RFKILL to the tester kernel config
In-Reply-To: <20261021072133.136948-1-tooangel@tooangel.de>
References: <20261021072133.136948-1-tooangel@tooangel.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7484627526658439052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1190272/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.03 seconds
GitLint                       FAIL      0.68 seconds
BuildEll                      PASS      21.67 seconds
BluezMake                     PASS      297.51 seconds
MakeCheck                     PASS      14.61 seconds
MakeDistcheck                 PASS      144.71 seconds
CheckValgrind                 PASS      237.01 seconds
CheckSmatch                   PASS      296.29 seconds
bluezmakeextell               PASS      99.64 seconds
TestFunctional                PASS      1160.57 seconds
IncrementalBuild              PASS      326.55 seconds
ScanBuild                     PASS      1154.43 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/2] mgmt-tester: Add Set Powered test for rfkill block
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'cf75ad8b41d2', maybe rebased or not pulled?
#126: 
Kernels since Linux commit cf75ad8b41d2 ("Bluetooth: hci_sync: Convert

/home/runner/work/bluez/bluez/src/patch/14904693.patch total: 0 errors, 1 warnings, 112 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14904693.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,2/2] mgmt-tester: Add Set Powered test for rfkill block

20: B2 Line has trailing whitespace: "    "
25: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluez/pull/2698

---
Regards,
Linux Bluetooth


--===============7484627526658439052==--
