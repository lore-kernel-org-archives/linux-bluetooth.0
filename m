Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368F6223336
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129610; cv=none; b=EvR0TsKZXrAv3BKmnsWFv9SC6Z/WESMnlTwRqUSUfKCq5UloxZnPRkn+yMTnr9+r1xCvggrEh1WKLLZKJ65GwW9XpLR6vviXiFnRsMjpJIlOd8v1IJpLCHVIPrZWxfWPvoT9yOthot8T0QHQsSzW14Kuic5j4DXSsofvsb77nHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129610; c=relaxed/simple;
	bh=8jfQuydDb2rNlwJ7ImzS7fa6QxHtVppnpYqo1ku/jZU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OMNuw0NObzo26UrjVXICXYEGMnQP3YUsT5tapo8w4bPXjPF03zWleheQQHHe9zn0bw+QUIizCg7nSs23tvS3Y3KFSZuu3jm73bevZlQbk4WjXlNvbU8g/2I09kvAXfREoqAxi3UZpjBid/18krfJlWlkRrThF+8yD0KyoZ8cHBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqF4JKvp; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqF4JKvp"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53512cd2f85so75297441cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 22:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129608; x=1792734408; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JhzNWuOP8DGdNuZhwyB8yqG3rLf8RaXboLheUqCZPsQ=;
        b=JqF4JKvpNSnz2SOGSxw39CUi3HpqGBTHt2KmuB6TKpBKw4mpvsRjmx0IEDRXHm1LC6
         KA1OkeMNlyLEkVjgJ8DEgXvmVIzQxydILZMdBJ0QOAzxwbTUGiHezp1ChQHDFwWPWw6+
         urXa1DvNuHqUYC1xmh/TD2Ve/X6pYON+1Ru14qyVcPYJ9heelCJcpW6YQxfWh1Enx8Yq
         XPaFo+X9tPHTjm805biLBq+Xl0d0jWqQlA/+1ZDMzJ2c/bvsRv0P9RKy0V40qVZwRHwQ
         9MfYZdKqIDU3YaDDK/lDkoMCE8eX2eQe/yDK8CEhuQ3IxZ3Ox6oF2w8Wzq/oFNXN0W3d
         vieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129608; x=1792734408;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JhzNWuOP8DGdNuZhwyB8yqG3rLf8RaXboLheUqCZPsQ=;
        b=tS98lvCpxVaVJsqAOdVAhJ9mjkDMdoFlD7GJFGAsGSR8K2f1cpYLYlsNP6WktzajCo
         mSuDqHw7VZml458GYGQG+JQKDhFtdFIgjZrxGnHbh7JB46m/jy87Qlf3MCbgPkAy11pY
         wOterx97cKUigjyjbMEgUPiPHPiU3fevUEeI5EtINr3mBB2KCldKTf1t4LDPst4MkyTw
         2ydowz3mW5JetX/GcZLXOZ7me/PMuQoRi5Z+PpMWAYNEVerbKL6rVioZflBnLvxYAt0q
         FP53hoG5wF34uD/3fDunDpJkLHQu4+NnNNkFI3o778isyQfGPr6Cdyl17WlYOblPJHT1
         U7ow==
X-Gm-Message-State: AFq9FYJthwL3yoWqMJbODLn2ErKzWap8XWjdJWWJHpSH6j9hKOB7Y1kU
	pUfNGU7rBC0C0fRLMw0NPyCPyvUOLZ1wX8ExV7Umc/8cUsMDvTkb341T+wWYrg==
X-Gm-Gg: AYBFou3yu/O3Z5IlxCac60neS4OOCBToDfRI06yT6rSUVOUp7JUG6zLxrHJwFLdsx2L
	4bjK2xKE70tMtwms98K2qAEb0DrL9iz/93KuhJJ0v4hHcpnJWiWxds9e2MmflymBnzCSO57nNlP
	yhndhpQAmbDgT4fTzzmUSJhG5fApmk5AM0AbLSEvavnh6JsYyvj7817Xbi62SApYsoSeeb9bI8M
	FKPzqWYbmXVvBI7/la52+/sPSeLZZj7Zk5asEYVZnlRRAWipRk/76FJWpCiQ5yDRl9Sdg3EjMVV
	FWwvhjptv4ocPXnS3VJMoVN/014Yh9UhNy41oc1lx3qN/IK41X+6xrSUB6IvFARi8n4Jcnl3VLY
	b7XVYvOk/aL/3VOBlu3VJTHXzXkdBeAkukK6V2BanUe/ZA1UV3rdmWtGxnvjIxl6HEe71LXgIGw
	roQxE+H//G3ZwvKNzAEdPl0ExGPyU4Nok1mwmsCgWvk4KNSRIKcBTveIXj41i+82QA3fLXuvU1+
	J/XRZlYxcm/41DL
X-Received: by 2002:ac8:5d0a:0:b0:536:2fd8:a4d8 with SMTP id d75a77b69052e-5362fd8a9a2mr10103811cf.15.1792129608057;
        Thu, 15 Oct 2026 22:46:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.47.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362a8dac81sm13640941cf.6.2026.10.15.22.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 22:46:47 -0700 (PDT)
Message-ID: <6ad1ba47.b7d948ac.384926.ee56@mx.google.com>
Date: Thu, 15 Oct 2026 22:46:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0531157600676688510=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v2] Bluetooth: hci_qca: Reopen port after power on for QCA2066
In-Reply-To: <20261016022302.4003647-1-shuai.zhang@oss.qualcomm.com>
References: <20261016022302.4003647-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0531157600676688510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186867/

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.66 seconds
CheckAllWarning               PASS      34.41 seconds
CheckSparse                   PASS      36.25 seconds
BuildKernel32                 PASS      29.04 seconds
CheckKernelLLVM               PASS      33.01 seconds
TestRunnerSetup               PASS      711.70 seconds
IncrementalBuild              PASS      27.64 seconds



https://github.com/bluez/bluetooth-next/pull/955

---
Regards,
Linux Bluetooth


--===============0531157600676688510==--
