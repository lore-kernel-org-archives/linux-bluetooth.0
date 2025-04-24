Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F02857F7
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514410; cv=none; b=AMgTzKXRYqZZaO1J+Qn6EcEVXv16nnf4NNW3lRyOUZzKz699j31GKcr7EFYH5dg9r7M6DHMzhzIT27y/3JLsmXjOYGEXEnh0iBznwAbR7PmCzxdhem1rWSmxyZ6V1JRRfzYD5jPAA/eWisWqqRsSaLCaxrSHVqOYsWm1cVk2we4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514410; c=relaxed/simple;
	bh=1n9cCpoJFHrEgMoxOXHvAr/rokXoMb3mpc8lLyLwjiE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E5+xHHuxiRCPTGuPWTvzxGnxFS0QcS7GrLB1tNZteFj32wMVMjZPEQQot4SCqw5naUMiz3d8CBQkeuA/kVvyOCFsUMPdVernY9Kzh9a0jS6nKQAqOS4LZDVTlPJylYY8mn+tnB9CaiP2njgwZyqNqjf1DRtgeL/NR4GDSHqVRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNm4w1Ey; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNm4w1Ey"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2295d78b433so15620465ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745514408; x=1746119208; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QW86283uRMdy7g+AppO7DsJAjLSXaAonEwtcZkA5l3s=;
        b=BNm4w1EyIsEVEIPk4WmizJoGrJ0rY7sTPCUrriBtRPt013yEp0GNciblSwgOUdnKNl
         qQtYKnbC05HXtioIh6GEKKvc8Bov5znbsg1Iq4Uw4gwMa9cBuSAXWD+EHUo3EU8qQzMw
         zAn+VedP+i9N0WDBxCHzAO1f3ZV3Q9gIhJWA/up3lt9pM8t5CJDo88YNKC4jgt2+R8BG
         +wldbCGrZx+c8Q/YrEyA7UZB7YUUUXw0QqrNtzLDBK1LtR2oOPgTT3c2OIWTApl1BZ/E
         ESPHy2efUSw2Lo3KAQjEP4vlcZ/NKevLNDk7/Mh60oglcrsRSkY0e7nEjaHRzxSR6DyZ
         zi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514408; x=1746119208;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QW86283uRMdy7g+AppO7DsJAjLSXaAonEwtcZkA5l3s=;
        b=q3pw0B8sD9Z4DLhIw95XP76EoBABuy1q/b23713yMwFBbNCKc0szvZ5DfpmD2np0aG
         /+UX2pxK1C0CJwnBtVRq5J09lFj/v3HlTAtra9N7l9w8XRb7q/xLKw9KYBLbta7/SNub
         rm50SuikscZU+oKqh1tcTa6sTXMCy/JP6n4O59dyO6rFJR2XoNz2fop9fqagr9PmZW22
         nJvFm2dbkOqq2RkO/Ww1DWDKRsHVto7CZLEqd21LIc/TMu3/ceTqL3MEP3ucEEf5jjVd
         onfLn1wIMGmNhjTT15xU7NTEw0/TXdrKkrShCNtjC5wao61s+EI9dK+qESUjiujwU9Zc
         I9NA==
X-Gm-Message-State: AOJu0YxLp4DlW5HaVfq7bSElmIcpHN5eKFsQ4p/c8VWzimjBURyYO2LI
	k5NakQo5lt4vR4L0u4oSZ/tuLJ2dnUvkN0bH2q+EmpeW6nyzIAD9YhLPfQ==
X-Gm-Gg: ASbGncsh8DWwjxpB5VSRgdsBaduvtOWX+v9Ze5dr6VdEmDSoSRqtUiNrJsnKBp9jKeM
	14W1tCTvGE4hwh9+n/9Vao5Fj/1LJzaYW6ld9doS6tmgJSo2+fCHlOkAzGXKae61CZ1u4/ytn+W
	SRT+ApC1yeKWaJEBDdUyXrJIqQb+BahCQNkOX3cUcq62bOBG+rpuILcK/BUzmxGl8kEZq1yhapg
	+onp07euDJyaeHYMTFVKLEfldvVAXPJVha0aX9EbCsaCp3cf3Okl2UqP5BFHrhBy9zjpDTz6XlG
	fctPBKw0igGHSp/64vZnW0x33R5TWu7+6LBXv59uRPD8/g==
X-Google-Smtp-Source: AGHT+IEHsrt+foSS/xg/30qlFYOJ6phB5mpEqFBi1PIVeZ9V3kzM24kXOwgrVdJIylU6zks9P0+9DA==
X-Received: by 2002:a17:902:d2cd:b0:224:d72:920d with SMTP id d9443c01a7336-22dbd460e06mr2634055ad.37.1745514408161;
        Thu, 24 Apr 2025 10:06:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.29.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d74cc7sm16137305ad.34.2025.04.24.10.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:06:47 -0700 (PDT)
Message-ID: <680a6fa7.170a0220.106a8f.3440@mx.google.com>
Date: Thu, 24 Apr 2025 10:06:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1050106823801188463=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/2] device: Reset svc_resolved on device_discover_services() request
In-Reply-To: <20250416155503.250763-1-frederic.danis@collabora.com>
References: <20250416155503.250763-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1050106823801188463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=954076

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      21.15 seconds
BluezMake                     PASS      2909.56 seconds
MakeCheck                     PASS      20.10 seconds
MakeDistcheck                 PASS      208.79 seconds
CheckValgrind                 PASS      288.10 seconds
CheckSmatch                   PASS      319.67 seconds
bluezmakeextell               PASS      133.32 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      956.83 seconds

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


--===============1050106823801188463==--
