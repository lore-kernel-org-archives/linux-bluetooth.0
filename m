Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1FC3ACF11
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779728130; cv=none; b=AZBjx3r76zc0JTMI0BhaijA3wfLvHjC1v8psJP3uGZEmFdGcDU1jAXi67QFVtWqQVwwXahlu/kBz7Rz+XlV2VMislLtudug5aRndNT0xFKD3OV0vaVrKY1AV8cmcpW6dSL5nruHXEg+pAR477nCTvUWfbf5X7v/Mzk1RQH+SHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779728130; c=relaxed/simple;
	bh=xU7B/rMGy3yK+sCwEorXAkbGAbl8j/xmvgN5VRQ3kkY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=atYgjnnz9hSxlq8Vzv+9ce1k5lN4e+0twL15k9KjaexVJPLvjvku99l5gBnIFgZWGBCKPqoRnaLBHoSH6weEKmKneN/VNXacmiRgN7gvY2JwW0088RPbJJ7FHtUfPiw/15UosdEHf3Y0aMdLTGCAUXLKsLKgs5IkdiE57jCg4hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbMCugMf; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbMCugMf"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9102e90bcbeso1028185685a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 09:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779728128; x=1780332928; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QdwkexilDrV/jwD9wojQUfJCLnD4+Zj90vWDYyQg63U=;
        b=PbMCugMfBe+hGL+zVV35xtrZniarGQTPMKMVKWI0fa9/6T1mVVT4FV8/3bjOir6h4x
         /zm7Oo7Ygn9NdS+ZvLci9PfWFIeKU/kSoTudIXUYoPx7BolB3VisKmrRy5QRMBWuH7Ev
         ryBKjbTjIvMCZEzCUlEhRdaIyEGufPia7NoOOkVmwZlugSuKmJUzEOoZ6aqOjeyIAm5z
         wpKqQB2/PQL7vpmLEtxzTbt1HCicIKhK4dUdPnIDzJoaEwFD0WVWoVqRhw+/1PBbVIc5
         iX/c+xU/XWgYgxt9SxRhnEFOcYgvIhBvYalFYgOmEAw7pEoKjuseaIX0+D6uYBwGnTN1
         +hvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779728128; x=1780332928;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdwkexilDrV/jwD9wojQUfJCLnD4+Zj90vWDYyQg63U=;
        b=ljPyb4jd2tw/MOfSZs5jt3RxV3HmKq1hjiCfQ7l6gyJyScfevJAW+mgDf4gjyynxcE
         6Lg+21trUE5DF7spt+up6iFExT1K/N3Zp8dU1S74rLhitLQjoGB7v7a4yQVcnMU6I6YQ
         fsQE9Ihas2br/qqdKYBgUpw3zBF4DGBjJlrID5i5q0aLYasnDtg4kZH/Pzjbreai6Di6
         RvPKd5ek0x69JtMYadK3vdsGZj7T3+qAZ46qUBxUX9cRIysazhG7Oek6vtyrGuwNBhYS
         bD/x7W6EcLpihPJ12VC95W3XefwhG0W9GNgzYr65pd4TwgGQurzJ2yOhTXwQO90QgzQ6
         7aJw==
X-Gm-Message-State: AOJu0Yxb2y7X0lmbDE9H3AUkBWM11W8vYgMahAUSUwjVIR+cHnGA64qQ
	i0xzTAQIQZn1uw58ilBlpLnvejhVGaDlh/Qoa+ftFO93Wo1o/O3V1KjeHhjR4A==
X-Gm-Gg: Acq92OHraevReG7MZra+Uoy40SOrTlx6CVatO0Ao1Yt11gpbVpsbeQa4x/H/JGPII3z
	zvmNR8YAXK2tkHAfXzQwBj9cmnWqo2Y9WkzSyREjtgVyY1GzmO4jHfylzERuYXUkRFofoIvyalg
	D+gp7mmLkpfnKDaIxpB7SdHgrv5iHOGYpfR6tdNnnrW81Y1wtlmXDSZk6yG68FysoUavF+BvUDJ
	6EjJaI7DNhgZB6e10ihe29O/wT2QsMPCSCojkauRtySAel5k4cxu498Cdtbk5B3+VRNKKWcmF+k
	K42blEa4gw/wm8FpdElu8ooS7WsmEI4f1/40xpA4DP6qmigbsiYR2oNMbf90p+KsEyN6VSatpCY
	N1Q0DmBp6iNw7mNZwudSwM29UK+TByQzWHVmux+zJCVleEmYFNNER120zRk4+NRRq4O3yLtl1pW
	j+pygxz2AEAj2uWNaQeNg5OtXYZih2NQ==
X-Received: by 2002:a05:620a:438a:b0:8ef:1157:6a05 with SMTP id af79cd13be357-914b49323b9mr2184865985a.19.1779728127628;
        Mon, 25 May 2026 09:55:27 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.116.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914c217cf69sm942900185a.24.2026.05.25.09.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 09:55:27 -0700 (PDT)
Message-ID: <6a147eff.86c817c2.3c3a8.b8e7@mx.google.com>
Date: Mon, 25 May 2026 09:55:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7675626986084650915=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tarjeib@gmail.com
Subject: RE: Add configurable default LE PHY policy
In-Reply-To: <20260525145010.154170-2-tarjeib@gmail.com>
References: <20260525145010.154170-2-tarjeib@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7675626986084650915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1100512

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.48 seconds
BluezMake                     PASS      632.11 seconds
CheckSmatch                   PASS      328.33 seconds
bluezmakeextell               PASS      167.60 seconds
IncrementalBuild              PASS      620.54 seconds
ScanBuild                     PASS      923.33 seconds



https://github.com/bluez/bluez/pull/2153

---
Regards,
Linux Bluetooth


--===============7675626986084650915==--
