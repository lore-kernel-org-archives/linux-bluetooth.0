Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185403;
	b=Q8d6FK9mEpqxH+MP4yprjdBcWuFgnN/Sr4YGWB0dzaDd9bmrua7NybEEgOUlWM7a2osK
	 d4x1MOW78IhxfF7AP95Mz9W8c8e2dnW78QewyNM+4jw9SfXBZz9c9dT/rLbi2XnlTdIAy
	 M4Yn+50Q9pputqqz4tPyFp/3I4BMkVoZJ0nTk+4k7MFYqsJ1qx8QVp94jU1WCGE7gKUpb
	 17NEV79tULPfG219Kdm7Y7l4oS+TJu/B2HrYuLg64961yoAsy+EpmqBKmj9dIeYWULsAA
	 Akjyb+FMMzYKKgm/f3MxVJnngHzsSVTsGUXmABqHefabI5NikwcT0VRJ7Ag+EGeZ+6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=W8I8TGsWcKeU26KtkMkayxjmI/q+7uT4HLlad8vyFJY=;
	b=Xm4NTQ6+/1CD49DbWi3zf5p2lul17BSFY1x2ovh8Hbe5jKHeVWlKCok3U5Sv2hXgfyvx
	 Efq5WXnE4lDIYHWyTHrtmxjoQcXmzDYGo3kYg4lMmlLEYmziWT+ALqm60IBV2vmMqYgLb
	 nAStEAQmoeSfeBv1Uj5yUJ5KloJE7P+uSsloEESSKkY3lwxNVpvSoVJ6nYL6ZuD9jCko6
	 HkX9StJF4BxtAEr4Weg9COysjwreFDWr1i89TmHMqVL8nvlOe1pacy6qjefjOFE+avDAW
	 N7eXgIISCyYXVEO8LgsZi8GgbpSwz4stXlKgEEz3Xo60RTByJiBLTHrgvUuNrWG1lgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kHLaRqxQ;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741EF606A320
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 14:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 741EF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kHLaRqxQ
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4b5138f0991so1171613fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 06:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795185402; x=1795790202; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W8I8TGsWcKeU26KtkMkayxjmI/q+7uT4HLlad8vyFJY=;
        b=kHLaRqxQSh/MnQUIu5oNOvfFL7X6oc9dnYL81kNuqonbfsu2ggXKRKWrQxCC67Ov7o
         qR4Z4QtWi1Q+y3pPJtCnBo/NeRjoNmmkleszSth/vKfvNVDB4QN5QJWQMWh37NZjfSuQ
         oO3G7zSP+ISWJbr/MhsJj5MH2On+fz/qBR+f2EL5fPYyrvnF3PdeD2gdN1xnPYWfT/M5
         JXf+ddbciN9Zf3AhnuaEAR9CzlyEw+mAuuPmWroVGBXkU1otkuat3cDU0Sh+nThTnaMj
         Hck2c6LS4OFCT955J5wFdEuqqyEeS+JZ+k/IBkNNG+nzcTX5cMUahltG+56QSlBNi24P
         8hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795185402; x=1795790202;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W8I8TGsWcKeU26KtkMkayxjmI/q+7uT4HLlad8vyFJY=;
        b=dud3QN0r0RgWXY5z3BLJd6vu+9m4a7FXotqWSh/BPsxAalqk7/ZPlmec/4x0dl7fm3
         9NQ8cNVgHD4zvg0yKDjbe9rJlRewIKxWvE9E/xMBdYpc5wIN3aBFOjWqkvzIAwHpCYaz
         L7UJnG9gPpiBB98WMfOp69RUK4IaeVmJqtuIxUsC3o01+Ri0SfyED/AhyIFbO5Gp4juK
         1IW7A/49nhJkPA2yAzoOdaBRda6Bfs4VbdbotQMYMahEyYToGsvrIjsNA2rM+9wYbUAF
         6myybId/m3nGaV5NZa3vAFwXz+e0Ghm3nZ1muW+wqojr4C4jWP/9ru249/qOMUUzDPTp
         lizA==
X-Gm-Message-State: APuU4Z8l31fr41nztr8tMJcdlJ6FznWPCYFdByqzONTwqvZCI6S6N3wo
	8jfS7GLjzbOa95fvzWwZ1ITyUK2xwtuUjkXyr8fUd4CVFOYBVhQ87gbq73SV/g==
X-Gm-Gg: AZFdTZdBUb2unDjVRNYPzOuawA79cbozTSBCifKYTI68RTOBg/uVqaOksKOiVGfkZ3x
	9p1sM1CuDf+/x8FbYo2GI4aEgEbooYTShrCNLLr11KI+xZYpfJdKunrwky30tMxkig8PPdE01BO
	1nBHxU86XTV21quFomPD3/FnqZCFKAgNxaUGfzR+7VnOgrvRl2XDI1iioZnpLKWL+sBftCFMcly
	1QXC9lN4uIrhgeOJ6ABAaRC8mllKBY9dgPfcjp4GtYXuUTULneyho99clNH0uX5JkGhaN3Ng/RY
	0W/bStaVsMpIEEzlr423ie0gerxyNzRgD9zHbGT1JtTLGBHJZncjbi3UBrnu4Qj4OdTRO280Ku1
	oFeG6SKVXyPShClZT6rndVCCPjcGuDasI7UOjC//aF4TePA+qKoALXGPMem8a0vbCIItbbFVqxn
	r7S8KuJfinXX6fg3P3frD5rpuKU69wL9xQNYKO1nL26z2rdIgLn4iWPMR0x1dBMg4H1HQKSTJm4
	pzJS/TGXK/McOxUCRvOR8SwYkSv58hsnibakkUWIKLYEGbRyHFh3AN7UZqQ6i0=
X-Received: by 2002:a05:6808:199f:b0:568:2782:d1b4 with SMTP id 5614622812f47-57a0bd95bcemr2886007b6e.32.1795185402440;
        Fri, 20 Nov 2026 06:36:42 -0800 (PST)
Received: from [172.17.0.2] ([132.196.84.24])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a34250ef2sm2463166b6e.3.2026.11.20.06.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:36:41 -0800 (PST)
Message-ID: <6b005af9.24a8470f.69082.5255@mx.google.com>
Date: Fri, 20 Nov 2026 06:36:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6684603334981386739=="
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
To: linux-bluetooth@vger.kernel.org, noplatinumfound@protonmail.com
Subject: RE: [BlueZ] main.conf: Add SecureSimplePairing option
In-Reply-To: <20261120105609.94042-1-noplatinumfound@protonmail.com>
References: <20261120105609.94042-1-noplatinumfound@protonmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6684603334981386739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217210/

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       FAIL      0.26 seconds
BuildEll                      PASS      14.00 seconds
BluezMake                     PASS      176.57 seconds
CheckSmatch                   WARNING   187.48 seconds
bluezmakeextell               PASS      63.59 seconds
TestFunctional                PASS      899.30 seconds
IncrementalBuild              PASS      193.18 seconds
ScanBuild                     PASS      681.59 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] main.conf: Add SecureSimplePairing option

27: B2 Line has trailing whitespace: "    "
32: B2 Line has trailing whitespace: "    "
39: B2 Line has trailing whitespace: "    "
42: B2 Line has trailing whitespace: "    "
51: B2 Line has trailing whitespace: "    "
60: B2 Line has trailing whitespace: "    "
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2857

---
Regards,
Linux Bluetooth


--===============6684603334981386739==--
