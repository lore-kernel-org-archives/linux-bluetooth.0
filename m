Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ED7311583
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777137960; cv=none; b=dKAHpXcBQfa5zJ6wQl/SkBT+ftP3maYx4iL6FlQ2RAk1AvnjTDqIGhlELJMZbjLFz0ZYKWFq2/yo0tEyPz3QWbK/Xr67aHSlvgd1eKL+pnG/huEzTm9PUoLg6pwHi919g3Rn4O/7B4tIu/oTDp//uHxbs45vojwzMSYg9LOD/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777137960; c=relaxed/simple;
	bh=bQw4GB6+Mb1RFHh4FLOg5X0R8rUEfAXo9fXYqxzmkVw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K7G3UF7IartRE/NOVfb7hOYZF14SoqgHqmaDhpWAlqJ93Qy/IguyM5i0RR/87XR9978Ij7MIrxsGzI8LPByG/4Cs5nVUIne7YhITNEz0SG3KNkS4XVsG63qJsFK2hpxAwSANzuwFZr+Gk6SFR6OGQilnArl5S+CMxG+yAnlvpoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9ygRKaG; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9ygRKaG"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c6df0b9bbso7271681c88.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777137958; x=1777742758; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vDfwM7AkUzCMsES1t/5tU9ghzPxQk2n+Zg2CCgKlMSQ=;
        b=E9ygRKaGqK9qjS3bb5XrB/3XFMUOkLzc/r96cOUslBRbVz4k4SMXn9iXbrw/fGFj+R
         rEzgenQueMQsdMeZwt7uan+LpmB8DsPth+g5TfG0xQFD+PJRvEsHlRNX2r077KCwMx/l
         liGJlCcpW7BkqKjR50w70k7uMnJqo/zkQPKEcXXiVm60aozn7TBq8KLaezJuu1yJROs3
         xDtEiTkDZR3Ttzttn2+oPYOiRU2XDJU08u9djnBSCHd4qT5FsvSQ2P+eC8N9vodKg43s
         qWpaq4EMJvErYLbtIwSADhG7/fZ63uERGU0beHQWUcmQQ/P6XuPuwtlbCT5OGPJfi4I/
         RPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777137958; x=1777742758;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDfwM7AkUzCMsES1t/5tU9ghzPxQk2n+Zg2CCgKlMSQ=;
        b=LjrdVu7bM0Cp67pXUL6X+A9qoOpKzkRliwpx/9Pdz2lbvAgU59qpq9gizYqkOgA9Yb
         LhbPPM29lr56JXtPRAIPoCPmnm2U0NH8v3vTVKnGA4er9nmE7OjFAp9LayV7NjEpjXId
         hVj9QPUiHQhkDi7kNR98uKob+j8pp6Y2l8Z5oQYpUft+qdh6Kdwkr7HhYVqI8mzfIb0y
         EtYscbw2eUXilaZqWqyfNw2MwTtQrv68SPo+Bqcf6vfRcwrcjTRURz2Ta3CTv0oF+qcA
         VFB8CWH19DafZhlgoVwEEXQF9AqItiGn/INdOHHuRddhs/yO/jNUWU9JYm1nfIZoG/et
         pBdQ==
X-Gm-Message-State: AOJu0YxWcIvYeR2Bz39EwCtWdLPissKDFlwNnDC9RqL+knSyZ6nSxxYy
	Yb8LQYULsX4msj7CHDJyIYIBWIvOncZcZy2jSBMiCpe+mg73vxM2VkHppT6YKw==
X-Gm-Gg: AeBDiesGjaBOjtJZBQ7OmlyRoKEGHM7YbjVV3as+vvAKLh0123kq0Vp8qrfvdptVQD8
	pTklLFjVoDE5jdfhtO+ziBWi6Y9c4f/k0jdvZhFjPNkXzEWYTFKSXtonZQBgTTDorfLFFY35BTf
	WdwOb/8fBi5xUvStlv54OaZn+IiE6inUiZZI4XWCOCoeAkd7+WmLItOEG3V4Ph+9dfpBWGf3fvQ
	osV1quS4tXQoHf0CAtcTGzOIPOyV3XBCnu6DluUfyN5634Xh9jrzm92XlSl8lwuzwH4Zbn+cz6d
	nwTFSw0WTbuB8qCYbno/pXZoPaDVhDZIwcwfVQeg9H2X4qMbOrHRACFOyxLIbTmoF+Pc/aLfx2d
	XZrqmmTnSuIUtho6tpJowkJ+FhMsiniRjcgeJOqlnuSOMdPBdZFAmZpl1pkmsuqDs42oe434f1r
	GPkgx2jL0lUEIKHzMVddbyVrJqq0uc5RgYTtYmMo1QxE7+74xTxAg=
X-Received: by 2002:a05:7022:388f:b0:12c:f77:f0a0 with SMTP id a92af1059eb24-12c73f73440mr22268299c88.13.1777137957893;
        Sat, 25 Apr 2026 10:25:57 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.81])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm47899703c88.14.2026.04.25.10.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 10:25:57 -0700 (PDT)
Message-ID: <69ecf925.050a0220.f32ef.65ff@mx.google.com>
Date: Sat, 25 Apr 2026 10:25:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2593635925676080168=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, agarrigues@riseup.net
Subject: RE: drivers: bluetooth: fix uninitialized scalar variable
In-Reply-To: <aezuBuQca26r4a7l@lal>
References: <aezuBuQca26r4a7l@lal>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2593635925676080168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1085521

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 FAIL      0.08 seconds
BuildKernel                   PASS      27.12 seconds
CheckAllWarning               PASS      29.39 seconds
CheckSparse                   PASS      28.56 seconds
BuildKernel32                 PASS      26.28 seconds
TestRunnerSetup               PASS      567.61 seconds
IncrementalBuild              PASS      24.54 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/125

---
Regards,
Linux Bluetooth


--===============2593635925676080168==--
