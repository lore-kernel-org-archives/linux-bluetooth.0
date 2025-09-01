Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C252D5957
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Sep 2025 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746583; cv=none; b=XSDe48r5oJQaeTLO1qf4JaGfEx/H73isHXGxZ/ZkHqNq1syUhPzS2TITUOhFLoCGr94u1ZARDT2OtcmM2KBoAtcjaSe6ONVoPXNrYxaUyeqZHOqeiEelG+aXvOhg26KfuQTznM+pzIcdAda0qPwUsoya5pCiYme6xl6YeLI219o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746583; c=relaxed/simple;
	bh=E848ch0qDFyLCo951PnbH3BOxSNt6h36vkZeVBC/xDY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xc+eV44H35ZDutPIRoc7ZbHnmHUPh+2t0Cw4queNANDxgri2Za4FMK64HNPWOXMY726J1aGUO28ts7R7Du85i4O1OJZQDBjGm3WNnoxbZIBXAWl8GzO5qxys/xYVloG6FOaHomj++YCGdkUn/cTDeDoJsQYMW2dMTZGSjKdkCas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hqk4qAK5; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqk4qAK5"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3f3b00f738cso26652865ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Sep 2025 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756746580; x=1757351380; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w/6lRFNbANgvM+HjHq1TtPjQ13cDiiY69EchIKkDdbk=;
        b=Hqk4qAK5QG+lKlFuBZD9cvubuBT8E7M7iB6mqXbf5tnZdB7R/whCalpAaljQQkEWPT
         wlAq1QarWFg4V4G74FFB5kZDi8MW1yew3++iezYsiNdu9/gMoXp/RuOgcyLlnMFYsC5Y
         J1YVJFrZBTm2SOIcI/vAmPbUtYUxJP+z1exNJoEK+oYy0UYiTBnzdp0MHsHkEN1detAr
         puio8iDOkvVKmit802Ll6ncgdJ0ZVsBcvQtWNY+Ynjq4Cho5n+RLHdlPQ4ndPSlI+huh
         zzsTHx4uTFREfg7kLnZ79rAj62BfMk3yF1t4WNjXaCnbGgla2hZJLkFqjwjKNszQ6Hl1
         6HQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756746580; x=1757351380;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/6lRFNbANgvM+HjHq1TtPjQ13cDiiY69EchIKkDdbk=;
        b=nIhKjd9itPEuayM6q5htW1TYEELWe7cRofrZ2t/kMlb4f+/QqR/r1SLtHjbsIZNWBb
         ghCDrv8ZQYtKt6/eg1/M76pf3NCjCGYkt5DMU4bbUfTaIOmIGmktzfkxRfLl4FZ+W2ED
         ZFDRLF2uwfTx+9sAWFYlored0XkuObowgZqo5hzTLpcwkSx1ybXElYSOIKyFKXTgdJNm
         5px9Iigk8YJuRGfq6FIZPLU0SqhDQxdsEuJjjTgfMaLEkSO3lyNiK8f3P8qyjtrJjoxN
         AMUijeHy8tpEaVDc53q/wO4wltfkpNfRgdKEltlY2LbZDyHT3qN87EPhvFcu+2Up5zIw
         x55A==
X-Gm-Message-State: AOJu0YwN1OAac4xC9PVXPaFooiAeZ1TkG+WLeWJ8LN0yOPfGhVxjDYXr
	Q5rFvYzyndlhSr/M0fYu1k5m0E/RpbDH69TSY60mfCzHMoj8tG64ZpD+AD76og==
X-Gm-Gg: ASbGncsLgTOU/nMxnE17A+dIHdJWtDVhfbUYTQQR73uL55stWHEy9cFcb00sw90/ueg
	1Tw/CuZ15ZaJpznEsEjNOEP4dqixPLomBoTESVKgTL52fNvPfqdsp2kwDylFexLoCphYvQguE2U
	ParQvxE2XYPVEctoSnr4Nb7zvS0xTlDL1X//VXaHwDhTRzws3fi7ePCQ1WFGdXoWC6lxcRTYFe3
	PWPa/S6T5KrNavqbEJkeu+5+TwBv+HO1WIBqHdSO78F2hGUP/4MuCqgJBKseqBD4nRpugQmkpZy
	9W0LxRiArWpOINUTVfhz150Q/hoh0hL79CaDZpsv/nrvBwLXrPNrkKfc+yATbCcr9W7LVhB+G6w
	X3H46X7RMHJh3oeO50MvgWNIDBlnwTQ==
X-Google-Smtp-Source: AGHT+IFWrrF/iR0S6iU6zAXfIz5KxuPAZAQhYjD1Y+vfPf2lcK8fvON84RdCLL7eFlmCe7JUc7RSsA==
X-Received: by 2002:a05:6e02:19ce:b0:3ec:7e74:36bb with SMTP id e9e14a558f8ab-3f400287b34mr153960995ab.9.1756746580241;
        Mon, 01 Sep 2025 10:09:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.251.166])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f0d4605sm2399799173.21.2025.09.01.10.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 10:09:39 -0700 (PDT)
Message-ID: <68b5d353.050a0220.26f74c.3cfd@mx.google.com>
Date: Mon, 01 Sep 2025 10:09:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5256607445275724651=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/3] unit/test-hfp: Re-order TS tests in alphabetical order
In-Reply-To: <20250901154903.187038-1-frederic.danis@collabora.com>
References: <20250901154903.187038-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5256607445275724651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=997681

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      19.84 seconds
BluezMake                     PASS      2581.64 seconds
MakeCheck                     PASS      19.75 seconds
MakeDistcheck                 PASS      183.17 seconds
CheckValgrind                 PASS      235.06 seconds
CheckSmatch                   PASS      303.85 seconds
bluezmakeextell               PASS      126.71 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      908.11 seconds

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


--===============5256607445275724651==--
