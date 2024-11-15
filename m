Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA97818FDCE
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666977; cv=none; b=JhXlSxRL4LqGtP8eDu6GXfAemHCM4DUJRHdlhg9S0hDt75l1arH3kHfdx1Qb3gk/iFnG5MU1+SnjbzkqiVMKn76vMzGkepU1mUsTYhfcHU/3G1foNMS15N+Mg3ZRHIIKa92bmCFfPHUaKxVfzomEafOh7X1BJW8XLlRKNVvZCvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666977; c=relaxed/simple;
	bh=KMF1HtlANQWvkG5Hd8tjoUcOalpdLPlg9olUxNr9YJ0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ajmWwHhOOT3Yr/XbHrc9sGVV1UL88xqjs8Yq9t1VIOjRUMvnpJo6OPp1YKio1opa+B4cl5ehmC7y/oBTsNcfbeZLg7b6c8D9gkCPE0CETXso4EWCgmqVVW2tEJpOHg+ZzXx9Q+SlnF0LWd6ChqINYK+I7ww+nQpNZg2tj49Dfe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpYb6Knq; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpYb6Knq"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e38261653aaso603931276.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 02:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731666974; x=1732271774; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wq2ENe9wmtiBle5Azuug0KiTj/Gel3TNiC2CxdDjVtA=;
        b=gpYb6Knq0vF5KSZmCgF22MWtMvBNafVgh1OZnatF3w4/yR/c9tZ3WbflA8rbc70e9C
         mUGvJtX7vjxsUfuEH+ygTWvzJl5FearRwmoHvjT5TctHj8wdOUek0EzzEs5HaTbtaIiA
         dEKd6O1NQf0W6XaEvYvXMgHmq5pAmneyzJY0YwGcL6hfTmluVj9NqF4g4Qb2HrlAhQXh
         L+ZlqxlPuRY2bxvE8m5/hjF7f0dbO0of1/vC6ioRpPoDbJJDpBiJS5P7ePmmOD2W9kjF
         2/mKFKbMiA9ZG5p/r6mMCTOBiivEKGNocWIjQJ+3UyjHFrbAsckwrVfbIp8+j+9OcmvA
         2XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731666974; x=1732271774;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wq2ENe9wmtiBle5Azuug0KiTj/Gel3TNiC2CxdDjVtA=;
        b=Gw/foztj2igpx1Wh6rY1pVJLe9p5uAKyMcMbt4ijy1pX7hpgGUCgFlZS/ID2J6gzZw
         LjLjREWP3T1MVgd3Aqv3pmzZSoFOlOhLcfuiPeGoGBBx3iP7EW/pBjF6seG99yjcUgBp
         bIbvHoEOonJQibqgGJzt2U7/kVcLqgnFHbq5rhCSHnDcAVCt18c1YxV8dty7NW2KR0U2
         6HIBcnE15Cj2y6LIjf+2e/cwT3zBbSxVmlvE0XDupv1mzr6QIuiGNunAG2DQLYuAV28G
         /4HR8eT0EuQs7YCGsv/3adUJFZNbQVkEO13S7+qxbV3qbZaeUhs3vIgRZuxXOrZ9Ifr+
         zxNQ==
X-Gm-Message-State: AOJu0Yx9wod0HsWlKRaJulRYYZbJ99QhEuRWtNMSqtPROW9Ylswuh8Ex
	5RV1W4g6uttUyo8oUJw4M43xZbIPFz+HmAM+qrFm2vw1nlRJsO/6lcaWqQ==
X-Google-Smtp-Source: AGHT+IGx8acCCTwdsq9XnFrra9Z/8jaIc1pTmSt5iZM3Aak1AJIp+Fln6r9B+7oyEcun0zlPaSKT/g==
X-Received: by 2002:a05:6902:b1d:b0:e2b:d852:e739 with SMTP id 3f1490d57ef6-e38263db81emr1431795276.49.1731666974553;
        Fri, 15 Nov 2024 02:36:14 -0800 (PST)
Received: from [172.17.0.2] ([172.183.154.251])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38152fe53dsm852421276.34.2024.11.15.02.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 02:36:14 -0800 (PST)
Message-ID: <6737241e.250a0220.47f73.35b1@mx.google.com>
Date: Fri, 15 Nov 2024 02:36:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7178641160702015193=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_dgangire@quicinc.com
Subject: RE: [BlueZ,v4] tools/obexctl: Add support for system/session bus
In-Reply-To: <20241115091907.1674294-1-quic_dgangire@quicinc.com>
References: <20241115091907.1674294-1-quic_dgangire@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7178641160702015193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=909892

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      21.11 seconds
BluezMake                     PASS      1688.94 seconds
MakeCheck                     PASS      13.64 seconds
MakeDistcheck                 PASS      164.01 seconds
CheckValgrind                 PASS      219.90 seconds
CheckSmatch                   PASS      282.10 seconds
bluezmakeextell               PASS      102.01 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      885.18 seconds

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


--===============7178641160702015193==--
