Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C63E928D
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935649; cv=none; b=JQg08jgSIQuYH8sL0ObCZG3FBZzdkYEl+fTdl3b3JMX2oU2sURU7Dl17thNFCjbsTkc4PcJLXPXiFbZydHM1otegDOQ8+DI2M6yE/svKeocCiohk7S9Zd+KceADLB3KKiP6aS0wCX97QrgTt0Ewm1yu+ANQIU9FxnM114uaT1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935649; c=relaxed/simple;
	bh=2OwAB2zlDzQOY4mZKttDY5bGXE1s8Xhlf2Rx2TuVNjI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Aa4tOFzWg39+ev7qHQcoaTLyd9G8BIqNYGtnNq59o2dhFNmMPWfKcnt1bHYbCLYmkCRSF34GxdYMiA8XzauOtc8hceHemunKYXNBoshb2vp+3b6XmyUg4fIIzj2IHyO108xmI3BFFENi/nKlbEHwC2hSXGhw8JpJVIsgURQ/zdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnfFFMl2; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnfFFMl2"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899ed41208fso17780246d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773935647; x=1774540447; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uI/bFSFP8VKEkzzcVyHjpsCVmBN88yqBtwwhFMTDaVk=;
        b=AnfFFMl2smy60Jsja0chRqBngmhEQHc0HsVrSrF41fAMS/X6Hpj0Y/nKgmZOrY/xVC
         bCwpweKkzEq6DBqXxMr76SKwY2irxrYXBZF5DyQnk8SrNDK62eB/pUA2LRGR4RnVVDU1
         G49Sxqb8qwOT75WqQ+TpecXLk7e44EUoMCJAXBFOfkyEVUZ+qE6wjuCT+NTpPeiHdlR3
         azEk7qU6d3ThFVcfL9ZKaTAUkrIRxEkwuwGFS2gz8ZIb2XbmIoHvl+1QVEwfPjxsdAz5
         j9c03QQ/nuKwRWXhVXh6HAEUs7CttQnuu/LhzUEMvsgngq16RTEjFvheSnFvJexExvGX
         I72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935647; x=1774540447;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uI/bFSFP8VKEkzzcVyHjpsCVmBN88yqBtwwhFMTDaVk=;
        b=l3ycrGD9Hdlh9hag7pFWdnw1tlSAEm8yrITgTxQ+4BSKX9FA/NqdhPBBxELN07lrhv
         HsQgRR7rZFQ7t8n9L9mpkHQQEl/UVNTsPGqVmuQrx3MPFODI66RHuHdd1CwiXW74C+yk
         2BSBPvMQc07pG1Arcsse0G8FIyTJvgti2+pcbaBHYKkmQ78EG2vFMrDKrAZyPy52+HZk
         j+4zmsWG/xlf1k9b8XtU2yVWckHCO5alaAAvIQOtWKSuf8sLHv0FTX0evNxUFlaTLOq7
         w1ie5AZKTa9yoI6fo7dK+QvBPiJkpnqBl1wI3g2CJEN2tY03dmyWrF6QtjJ2hk7fB1US
         6qSQ==
X-Gm-Message-State: AOJu0YzY4g7SkIqC9gAn9irsWpBQoDjS8ILNNakLeelCJuiWJ51k+9gU
	5I1h5H65QJe26bxXNhd0I7M4lpIRcKWMCh1lQxt+YR4LCJPisaDYK+XuJY5zhg==
X-Gm-Gg: ATEYQzwuyCNu5MHiLUVZsIOT5Rk76svl8vGGBkdZrrA385kUZ5xUrcbS4kbu9rsnE5G
	ByRK2dgH9O4so1BDOFBvZnW9LZNovj+7KT9IstfRhcGJn0yUgIGhijT8/kjkE1dEDvaA5GT4zpS
	UtW802jUztIcIl/6ZbAniunsiqsktKC7oUQNpCG1ufab/TpvWaD8zMPpAE9HpLlfIzt+uUICe9J
	JkU/MMEd64mRRxEJuoxEBVkTAEx9F9LCvJfK6ijuEvvvS22NzldQRatngCx2y+176dAqMHHG7qQ
	riD+CrzF1sNgaGhZw2kJ9cbIqDPXWMmzrSLMitxADBpVfC0gQ+yJSkULVCBOGp7knffAT5GjuI6
	yPdAeTnGYfcPyqnMbsNVi1Ff5pym7TkXtp1/ExPetYoSvsa6ukMbKv5la1/ADKuhfX9+dmi1odX
	Yi0234oNVbaF73hJxAkpBndWRBSVizrg==
X-Received: by 2002:a05:6214:3a86:b0:89a:a0a:c0fa with SMTP id 6a1803df08f44-89c6b700f74mr121454956d6.63.1773935646912;
        Thu, 19 Mar 2026 08:54:06 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.216.51])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b8e2382sm50944736d6.2.2026.03.19.08.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:54:06 -0700 (PDT)
Message-ID: <69bc1c1e.050a0220.13f04b.79a5@mx.google.com>
Date: Thu, 19 Mar 2026 08:54:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1535755900845336050=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wouter@xesxen.nl
Subject: RE: shared/shell: Fix SIGSEGV on invalid input
In-Reply-To: <20260319141435.83060-2-wouter@xesxen.nl>
References: <20260319141435.83060-2-wouter@xesxen.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1535755900845336050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069318

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.42 seconds
BuildEll                      PASS      21.16 seconds
BluezMake                     PASS      643.79 seconds
MakeCheck                     PASS      18.66 seconds
MakeDistcheck                 PASS      250.30 seconds
CheckValgrind                 PASS      294.96 seconds
CheckSmatch                   WARNING   354.79 seconds
bluezmakeextell               PASS      183.27 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      1032.91 seconds

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
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/1975/checks

---
Regards,
Linux Bluetooth


--===============1535755900845336050==--
