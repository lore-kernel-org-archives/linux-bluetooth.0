Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F523F417
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453176; cv=none; b=jNinlBci8DPJTZbW5IwnchFIvm6S2gysvwoXAeyW3lcOCMWWRKIV5oNyIeGjSwTNb+C/DRBJBQ8111JBn+0l0SObjMH02e2Xyq9XUSWtDbl98RZUAltvhQRXo/XC5Hsly1uoLs1ycQ6TWaJgOCL2AKfyhfPwQhsGkFZkSuBeprk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453176; c=relaxed/simple;
	bh=SPJicy0G+ZRF7N/TjXF/GTo3/Vjd/YLby07KG1r5PlA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GZWGMu4X5QSk374oAg7Oa/XVTzGBemVzl/mjB5qf81v1Dd9bTyL7SarYIjEKcKfxLZz6C1sLtySnGLWlSLuL82TUPtIoYKc3nb4bLKVT6t5BU4g1R8oWVweAn1fJ8s4LFTOHv1DZcNhXZzEnza5Xy6AhirHkiAxeJwW5MbMgA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKn9UUG4; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKn9UUG4"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e44f9db46bso9625806d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 05:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739453173; x=1740057973; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=es4IpzqyuRTFr49EU9OBzkcSRGHdlmk9G48otOt7Sa4=;
        b=PKn9UUG4oJ0pgjmylKHPvB/E0ykd2jU+jjaXuR06Vi2rNvi05KZdj2aNxF92NxdJlh
         DfsKRBuEVul9qnnyxEarc1tKMX89Sz9e9qrZR7FWnBrv+sP43x6ju9sKDCP8edCIqsyi
         vxfCjRH5bShBNaKeUa8Ff355X2Q8i8kET7zAm+dMBMYCmB051Y1ritQCzYvFpqpz3VeY
         m8nT8fiA0mm1uEKh0wqjyqP/JHved/1b0OA9xfjCaKH1Obe0KdIModENILVYT85Vm/2n
         6h5tgbFgmkWmf/UShO/kf2LsNoRSKbSXG3MmAdOr/V0mjq+rcRE0droiAUXPiWMWbt75
         pnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739453173; x=1740057973;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=es4IpzqyuRTFr49EU9OBzkcSRGHdlmk9G48otOt7Sa4=;
        b=dxVD79XqRchz2SKcOiHHyPIa8e1s9ys6xSALZ6vuxaR5x89YrMWJUjVgeV9B0GY7Ru
         NgJwFlsJ8OLY4BMVWbPzU5hGKwwwcSbMLltEZ9XEDrZFmSyIRTAaaD6qrQvnCzsQHWBN
         1ezJ9RKOGRV9XYOvwl1xoCAgojRyjiSEjTbbPvdvWfdkbgVYIM0BncqaFHuf4ajwIYJQ
         sNFFYz+lxuavJ/W54zCTwJ4M+D3Q+YWZVKbBrDt08m6qrXBXUSQG1vGbJE2RZu+ltmMg
         xpzy1/TAlRtGLFPuUt+v5q36EuSG/aZNjtG85dpWKaPOyhMnRSRgKQZd3aVWYvveaaUB
         Mynw==
X-Gm-Message-State: AOJu0YzUBI9LRWhFz5pSOtZpNm23BUN6P26aj7kWuFbKhT1oHNzqHinD
	i5fx91LofxsR652V5mUp0xdQRz034LmJRDgWhzSD8fEiLZO5v8Gaj0dHzw==
X-Gm-Gg: ASbGncvDiUCITHI2ZVRfvHRCiVzVN7RG8giBtx9yFrO7JyIsAsdFWDyFJUOEwiBjkg1
	pTZJ12O27A39XfZpMeBUY+SIwpMWO6myL6ZZN0/IopyGMAElN2ql2Z+IZA0xt5KoS8XVt1N1Y+o
	y1GwkQI2bvsut+6Z/Ho5wpEepnNiVs59nFGh3kMOnS06fzq6m15iTv/ZrxVCuqkDODNb4RbKXe+
	BtvL9hLOilexyMLo4NfnRc9YGsteexETlyQkt/aTLXq7oQvOD5PL8mbtejn/KyS9fEv5X99uQz5
	FcC7r3G5SsmQsjLjE5FuXRWe
X-Google-Smtp-Source: AGHT+IFYmcnqTz/WK/2qPJ9S+XZ4mbHSP51cX7Kg+qFS2TJ5ATYwkpDmSf4AabCAdlaSTki/v7FqEA==
X-Received: by 2002:a05:6214:c46:b0:6e1:afcf:8711 with SMTP id 6a1803df08f44-6e46ed77a9amr129192926d6.8.1739453172702;
        Thu, 13 Feb 2025 05:26:12 -0800 (PST)
Received: from [172.17.0.2] ([172.183.215.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d77917dsm9332076d6.23.2025.02.13.05.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 05:26:12 -0800 (PST)
Message-ID: <67adf2f4.d40a0220.3c1029.1d16@mx.google.com>
Date: Thu, 13 Feb 2025 05:26:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5389550415331455811=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [v4] btdev: Broadcast EXT_ADV packets based on its interval
In-Reply-To: <20250213122952.138986-1-arkadiusz.bokowy@gmail.com>
References: <20250213122952.138986-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5389550415331455811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933592

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      20.41 seconds
BluezMake                     PASS      1526.03 seconds
MakeCheck                     PASS      13.37 seconds
MakeDistcheck                 PASS      161.06 seconds
CheckValgrind                 PASS      220.16 seconds
CheckSmatch                   WARNING   287.40 seconds
bluezmakeextell               PASS      100.78 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      886.89 seconds

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
emulator/btdev.c:450:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5389550415331455811==--
