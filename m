Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663AD18FC84
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670699; cv=none; b=UUs8WrjywLzDKqORWxXoqdwSpAIgk+ToaJbN+82rcDVH+YOguLEgYEcKvB4UZiX/xuzBjDZjbVBp7iJh+Piqs/EjlgEUkAc3xRiqqQ4wr3RAcSE4wdRs6QOyObFGourvmjpqExb9OEcnYI2EfdoF5mkdBv1KZ+lvoCt5z88odZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670699; c=relaxed/simple;
	bh=BeoGXbyEjAQXs/tRBcZIlzrYjSNFv/RBHDFi9IP1lHI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qPukFUJGDrlRCS8unjo1f9APA3uAvDZz1J1xzw9yVNeXNrOQxhqZkpIr+SlVzEhftMiTvs4ke0qRwrra9c8pS9bDzIocd1P4mIDZsVwPRJcvclPxe8UbFvX9QwAgxqlSNif5qZfSRlDVnSVpxb5SsD/2YvPcbvTl8Buu/zHwkx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuSmC7lz; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuSmC7lz"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460b16d4534so9342351cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 03:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731670697; x=1732275497; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CzfQk7o4gYpj8Pc8GMXyRW8Z4vOI3CcHIfCnLUniMtM=;
        b=ZuSmC7lz9BVlb9oNQJBb/C++EQykgF5EFRMK/gDP2IOrvcacBpzO+MTAGxvNK3cquP
         mCk7OG/AXht43pASV26n66H1H/3GxA9+bcTEKW1bFv5DE6Iu+t0qE4JUTXR5WXPwzpUP
         HtVjXH4zrROV2y3AqJ/zcAxCSm/8nfcG748Wqb60MpPr5iCgMvmmYyDsrN6ZJ6sL68aK
         R5mYCzip8rlePBFLPt8P6+An23eu4Uh43MSzSSgONnCpTjQZsA+zm6JusPaBqejDJz6s
         O5hQwyzaWgCfmxxeKusGXY/7ful79usFrM2Zetyjrcw8pX2edN2ABN/DxIuIKJ6672Ei
         E9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731670697; x=1732275497;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzfQk7o4gYpj8Pc8GMXyRW8Z4vOI3CcHIfCnLUniMtM=;
        b=sNZOzX0VVsZD/3UdYrfAHFCZCdbWTfkcYc67vTuXyVZfeplSQKeZ6fmpjV3HlT2ai+
         WPO4JzUv0hXOm9wC5XQvBHDqjSJnfWoxb4jinL+c4asOF9QZ2uI1LbvfDkPldJZMa96K
         GYoFdgvm2Li5lPceZRYMjHVChvHpNgitPNcFO3xY/kGukOyBD1ApaiTAYkxknT+aLava
         T5oJoS6kaDUs25dlBD87t42vBgnABFDG2Jwbe8jFZdsRv9sIQns4UQQeMNq9/h0GzqBF
         GPrSn372VptzNpynmhr8joVgHcqU88cmADTGZwIRPQkAfBevX/kB/Y4yibDUCszwaxV4
         hTsA==
X-Gm-Message-State: AOJu0Yyx/E3jYW+EFnu0yNXce/a1SIpJninrJq9yfd/gVQvGF+aEVV53
	LPMFjUdN8qypUiWTKCdYTAj5p2fF7HDNyU4SgnyUK/QkfBnpBiTs1asREA==
X-Google-Smtp-Source: AGHT+IGHUqYTf3OLZvhrrV5w6RVwLXAEjqzAAO4eRGBllcHq27eWr1wFukyda5NaRTE/J9nuqRxGAA==
X-Received: by 2002:a05:622a:148d:b0:460:8fa0:5acf with SMTP id d75a77b69052e-46363e0cbb6mr31471591cf.13.1731670696894;
        Fri, 15 Nov 2024 03:38:16 -0800 (PST)
Received: from [172.17.0.2] ([20.161.77.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635aa35dadsm17806861cf.52.2024.11.15.03.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:38:16 -0800 (PST)
Message-ID: <673732a8.c80a0220.78873.5d1f@mx.google.com>
Date: Fri, 15 Nov 2024 03:38:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4466291135584881684=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bass: Rework Scan Delegator
In-Reply-To: <20241115103825.19761-2-iulia.tanasescu@nxp.com>
References: <20241115103825.19761-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4466291135584881684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=909927

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.94 seconds
BluezMake                     PASS      1609.42 seconds
MakeCheck                     PASS      13.61 seconds
MakeDistcheck                 PASS      163.07 seconds
CheckValgrind                 PASS      215.70 seconds
CheckSmatch                   PASS      280.57 seconds
bluezmakeextell               PASS      100.12 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      846.73 seconds

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


--===============4466291135584881684==--
