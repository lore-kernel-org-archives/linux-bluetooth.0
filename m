Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420E62DF6F8
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774729; cv=none; b=JB1+NMy23xzU50JEBO4ZAHe6R73QMv83HbUWCVeRIl5QXBk1yAXjXncvmpHNMug/esAgI/3HkHQYPuS3qdSiwIcyl1oJ1u91NAjW10rNMS9rM+g4WKtq8PALOG+DlQ/M5B125oNGbghaZtrHTK5n5GRSrKt7g+Gmzov0Q2mmKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774729; c=relaxed/simple;
	bh=8O+qn3YibUmwlaL0hb99GxWvbRqr+h2GIe3yrjf9kiQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dF1+MtPtEzwSunTrlCXVNIrHqtBlwihgQMrUk0bpot76anyX3n96XpaNZKWx01cQmBMzBBrJdt6BOUmt5O61Udr0NI9DutqCJpEe1/9DspExZ/D2+vYNqVxLWpEGfrFb/8x1Q6el/oLeAVhmrjPIdFzvQDEuheQlqKDkf7UCmfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKds1LYw; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKds1LYw"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-432107e48deso1104835ab.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 14:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761774724; x=1762379524; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HuOxGmnLX5cZ9Xsv+3AsA3/3dpYl1jqMREed796qI2s=;
        b=iKds1LYwfwV144Iqo2ZmJcr50AsL7dTx4uDXiKMJ3p+rkYyLtyZb+4F80mCj1JEDcv
         WLXX/U4bN16gaH0+xfwQUGPwpdgCoKanrP4xraK57p2xLwSrZYEA60qGz23wrMSaP+kp
         BvDpd8uaCgHE5x4Uvb6ei1sbBgWw+Xyrv6og7tbkti7u8RV2tm6dgHu3jlpemJSf/PS3
         jqoD58JUy8qw3qdJubf85yz+dVpqgAYhvRlCCdOIv0xZCUC4D+ndUrrwqRjPWG3kRZxr
         1Pe9DNplg8qlz3IvBDj+4FZCk2LtNBNhR7NsGmw6G921GTyY/KAoq0T4HD3d+krzcCHr
         CXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761774724; x=1762379524;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuOxGmnLX5cZ9Xsv+3AsA3/3dpYl1jqMREed796qI2s=;
        b=npLLek7yBU/v/IzUttw0lW8gd4JpFrYabAL9N0GP/W3gKdWoZDsGsrsh0rLOy1SG2W
         Uw/9Pp4czjhXHq/EY/WK8PEpYb3I+zqPEPIgC3Y+SzP991sedlv4mLKecA4nA9wZN0/A
         RbyluLYHjdTOG9ViDmpHEfZAK1YU4HaHsUkyXaFmKcYF5YrDtan5TtwSmoMY/nUcmufz
         5Af63XCc0QBQu9HfhABM+zXvwMNrltqh6AYZxrHbpdsiRNW9GdhiEsSEOu5zGe/RVSPH
         v2O8Ort+ViFpFLs+MLBKhCH5bUKrNh402W6w3clgrwipn8De3a9D9gD91a3ONOK0jB2y
         0riQ==
X-Gm-Message-State: AOJu0YxdTrPjWsDifRlBuwqpOguYWHtFOCBxV1Se7Tgj/guij8A6ONHT
	rr8rLlESiKEDUy5afqe+ES6er+BdNtUhQKEXwn/jvN15IuovVrau28gmvP6Pjw==
X-Gm-Gg: ASbGncsh9DYFMtSgTA8BiQqD/a6ZlhDOK5rDJmORfZk76Syg7qKpiGhE8YvT2IqOeB7
	P9TkcClAwk73q8BNv7W/0AnrfPDcuxHOy+ZNSN0olHzf8MCco3dtZxA1Sj9vyYXvOrEPY/jU+EU
	ZRa0j4zB0ynxz76dVzuMRY3YGvMKCvCVs0cNa7AXthWqa/R9JQhNcdYP47smqJmpaO7n8pGKiZK
	eo7hpnnGtTZtxAsPQRZGtZuXQm7EtTtFWVKmxJy7Uh0Zs77fiysC4dU69saBkntchg354sopnIA
	YBZzR18VWETo+gNatM26xvTVpnb/0NKxw5NyEy1eSKvKEbHNaxCU15iYVNgoBG9eMflLvnJEq5l
	e6dTmbaeD/ML4ekFC9q42qjJ3sXuppO9/BHrtDLj9aytwrdMQ3J+N5aZaTO9NCLDwKuF+HwGrhu
	xa9np+
X-Google-Smtp-Source: AGHT+IEKcMWfIo8uxI2bS5DkXr8XRF4SLiffc5Ul/UPTZWPScRBNeNuVzq4BZLN33F0wLAZsGxHaqA==
X-Received: by 2002:a05:6e02:97:b0:431:d864:364a with SMTP id e9e14a558f8ab-4330153dd7cmr12611505ab.17.1761774723815;
        Wed, 29 Oct 2025 14:52:03 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.20.53])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e1abesm5880643173.24.2025.10.29.14.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:52:03 -0700 (PDT)
Message-ID: <69028c83.020a0220.b5d6b.9d3a@mx.google.com>
Date: Wed, 29 Oct 2025 14:52:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0420985110027353786=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor: Add decoding support for LL Extended Feature Set
In-Reply-To: <20251029201624.75933-1-luiz.dentz@gmail.com>
References: <20251029201624.75933-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0420985110027353786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1017464

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.22 seconds
BluezMake                     PASS      2757.45 seconds
MakeCheck                     PASS      20.90 seconds
MakeDistcheck                 PASS      185.78 seconds
CheckValgrind                 PASS      244.36 seconds
CheckSmatch                   WARNING   311.73 seconds
bluezmakeextell               PASS      130.06 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      922.94 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3852:52: warning: array of flexible structuresmonitor/bt.h:3840:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0420985110027353786==--
