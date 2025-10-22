Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0B2D0C8B
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155098; cv=none; b=YuUxlPzpzjTaipuBvhrqSs5b4A2vMvjImON+Hzt89P9BE2iGCo627CdxGig+t+OaX+5ECvJ+DgcMSdecHLceN8oOsQlk/2hlWUqvIl/Q1iYDT2U6flwzcrNL3/IUcmiewdRZoA+wGOszi2gfCD6NSl4u9BffFqwDOBiep2E9AKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155098; c=relaxed/simple;
	bh=NtZaxz5UQ7c4DM1AZTcbjMc0DpDP9CHldamwNPh4Mbg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m1zdvsKrbqdJizOiDwpGqodLvNUpDO+UCVorqLd+WHfhosbuR9iYZHmF6+kt/gxMm3viTy+raTOnZc2lQGXm+ZTSww4rquLES1dkLIPQsp7Gx5zVaF9ROJykBKscBJqiPyY3CfXe7LUQ09exv4bcOTQK8Y5K6lImUfHTD6ncXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPtwGk5r; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPtwGk5r"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a26b04bfc8so921693b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761155096; x=1761759896; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IgrtTRSyT+392cxZmoPUBt2dEkrfO756C6QZqZUf2rQ=;
        b=MPtwGk5rn7tnz4n41c8beJN8KNVJReNFV/4K9/VYKAt8+4aoSwa75fCL/Ow7nRJCaS
         k3dk9lESS9pI4uhAGWkXYmmOZEqyrkqE8a0aSN746ge1T8asEOjg7HcIRK2Yw5Rwz3mr
         05bWEGmVF0B1qSoDVwBkUQFokR/eMfp+6lwEmD6IHFmd7kINW0VFuwg0yGjF3yZQ7ZPJ
         bM54+w/RYcRJy8trebwQSavwcr2XYdaKggpmWhFiSTMOb15vzZSB4J3C1Wu0jYCzKLy6
         fvhpcGe0qK716uNJd3vomNS7URMaag9+0o97yHhezhnoy58R3lr3B7yyMbcJ3Z3lBZXj
         y+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155096; x=1761759896;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgrtTRSyT+392cxZmoPUBt2dEkrfO756C6QZqZUf2rQ=;
        b=U24AbiT2du7ZZzlnd/Ia38ptbXyij5zJxUT69I1ce+wGZcphr40qyu00wjRXyuk5po
         LokfafwJeyj/hm0AndPGWCpCG9/nFRo5gHkbhVknZp5h1BV2jDQGDGn2zhLxWjHyvYEX
         IZswCXYyL6oRAp4HkMczu81SqU4C2eo81UmUvu6RVOS+NvUUD4LPizz+v6FjZ5pltT7x
         WnmkD8LocmnFSSeasRvbUempmMq8MGwq9ao/KdPRkvfwPRl3w1T0SfeRMi+A0lsWu50t
         cJNXXfPzAKaP3clbWpVk8ydoaqYZJ0FO2rF1vTuM4MJPH1un8aYvEW8dsxmMxBLCjv7Z
         YqjQ==
X-Gm-Message-State: AOJu0YyxeCLh9r1SV/GeFEyKM6PUUmXc6RGhhlMmD6BFAPr1VlzK4P7N
	qOcGyedqEb9oEW+sL9ZtoKOjBQ8HZ9nmJiW59j/kvfLd91IwvrQUAHcCY3ORog==
X-Gm-Gg: ASbGncvNhW+2kH//rSUEYLoUiY/0Jv0bIXy1ucPe9vHvKRu+LJPVYzrQr1duwlHWX0w
	jswJWztwr/OWsmbNh/5OZ25eKG8pX0Q0LLvxaKmZIg2HzGy4xf0iSCcgcqlu24BZFERnXGrNjnh
	bYFMbCQRo0rqQpNqrHdg+PhxOBepqIanh9IVZC907zGBDUVh/s7aNZyTXQA+YDqiHQzDX/6Smak
	/TQWo94Kp/I4WaSrmfRViR/0DqywWMyCpeyfCaS/fKjDtIS3G85rkhfjQ32d+Wx8zZX/a+5Pidl
	Gsz4ctMuE+WGe16wniz+btXoxOpfPP1kB385gLYoo9O5rNGAeimQVnOfuCQDPR9ljpd6g1B7FHG
	sVJGXykryTD4T7mkVCFXa3WR1yC4IygnDCYNIGuSSDFQv6G8Q7xa2VHo7NQuz2/jobExE7N66E3
	1/coKei3w4wKnF5QSwKQ==
X-Google-Smtp-Source: AGHT+IFKh5PrGeJaIWPRsSstciwVerhh3isM+dkFwBQce624vR5e3MTK6GlQECAFvbqrTWrwjP8ngg==
X-Received: by 2002:a17:903:19e5:b0:265:89c:251b with SMTP id d9443c01a7336-290caf8519dmr294487085ad.29.1761155095542;
        Wed, 22 Oct 2025 10:44:55 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.247.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5874sm144635055ad.54.2025.10.22.10.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:44:55 -0700 (PDT)
Message-ID: <68f91817.170a0220.142f5f.5419@mx.google.com>
Date: Wed, 22 Oct 2025 10:44:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7956209814083947258=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ] battery: improve the display of the charge level
In-Reply-To: <20251022155822.88438-1-r.smirnov@omp.ru>
References: <20251022155822.88438-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7956209814083947258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1014597

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      2763.28 seconds
MakeCheck                     PASS      20.13 seconds
MakeDistcheck                 PASS      193.56 seconds
CheckValgrind                 PASS      245.36 seconds
CheckSmatch                   PASS      315.53 seconds
bluezmakeextell               PASS      131.63 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      973.58 seconds

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


--===============7956209814083947258==--
