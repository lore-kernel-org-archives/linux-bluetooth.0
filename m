Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92084434E40
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442721; cv=none; b=S3+Ec3ZsZ/VBtN/6iD7GsGt+7Scaj5RQRqqNInp4+rwMjEHS2mD/zOCTTUlAvbglfBeozC66yrCdfs6LkyZJxUlWCkR2SqMny4GKSQjs1ZubUvm91HzqenRNQ8cs5cSAW3FNCbcTPJY3TlAHqyp92jqs1XYOOT3/2RyPkWe2KfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442721; c=relaxed/simple;
	bh=cXYNiEkTt7WN6cSjjO0mP0DYWHH9OCtWDWIGAD40/1M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ApDYD3/XXzHLVox1vAAK1KUPRW0TIOiUsK1CAdXaqC2ZK+m2doS5CQ6Vbn2l9npKSLognahwfRIFbn98yPUHqahKuVz0KnzeCQxmUbNXEbL3tmWGU0Wq6RsvTFcEDN+yH9Y4WNVY5UxW6wAH7Y9wls57z72baL50Bzpw3ZX9ACY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJVhhHQ7; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJVhhHQ7"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-847aebc56b6so3610030b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783442720; x=1784047520; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9m/fR60c42u22klLEf//3fcAUFDlbG+b5DvYU0ZFZmo=;
        b=KJVhhHQ7S0lebhMCmDIEoQP1MomnuLf8XJzTRmYGBGbo6qnWdgv5sL4Sg8kcLvhJRc
         WQEHHBIvQr9Bw7r5bQ+wzNxF38FrVpr58JvZwVor5S4EW/p5EqYEixTJCoDRKDVe3F55
         lK4nM2mh0Twgu+GTrdMic9DG1ewT/x4ZCu41YovJILf9uDtnSly07KeqmY0Mpzx0zZ3A
         hOBD5HYhcJwVug6uIBax5MnZqmgrF7rjdchdH+eW37xfVC0gO11hFW1plEefPyuYuchO
         xJPpDE/xXMpRztPJcPBuwUk+PWTL6A2IXbqrBjB4Pd/fVdlb6UVMb+9/TdtcasN7y17A
         gS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783442720; x=1784047520;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9m/fR60c42u22klLEf//3fcAUFDlbG+b5DvYU0ZFZmo=;
        b=JxZbsfyuRaACIeQs0/MO1QaBpAKE+2kpiSm09nIGMJmjXGo7n26fYkawinOERjdHrq
         3ZTdZMJ6tUM6RXVg9Kwf4YlSq58PhZt51/I+xsM19ksIz5LeeDMEz+ehRiLQ3ecJDHdd
         kRDEVev858OaIZdcmNycH+mKizFEylJfEosPAK1JXNc/QLT0CbJApTYYCByTy5PovMWg
         cnvp+1d1V9vH/nJkT2X1eSSmpNls67nrwKjGQ6q3oeOSMrxTffLHKC50nEKc5T7rzcnC
         sO25EtWuSVa1I1ceCGQhI0xu4XuTMoP4SeRD550PANqRTjsMMAWWOsfAxXke6YO7fhlS
         WPzQ==
X-Gm-Message-State: AOJu0YxGEtmG481F0qSdQJavzNaz4fClE2HmjOb1NVzWDbQ2qjAyq1Fr
	G1Ird1SeYzIP7WBJ1zQggijhcj5Illd0lMhPaGCsHA+MfcxqzyTnZzZwAlgfkQ==
X-Gm-Gg: AfdE7ck2dUCxray3TBFr7dZyZzIPkiEKKZFngelzVtfwnkstZH4ip45lWMwX0uQ70n6
	X7EMOjMzPOnWS930jaLVMU4PJpkgfbgL97e/TujAJrrahRXXKg5McQ0Gkp8TqXVZsI2iXYmECpV
	TyYw4mEYMutOJK8Vtb1rm6NaLL3z5AwF+kPgVYKJRHLCGSVZLJJ3yKugZELbvzCbkp7E2Yf07fv
	pZT4ur2FnuBfEbBFXJm4TVOszmBFEVgAd2DARuhLAEZqCDWqEemKgmwOLbKaFplxi5tOV5/i9no
	oXKGDi9vJiIOHkWHuY2ySoB/QxvHKS+77rBt+3DZmLG/8eweAi3Q4sbDHewA+BZreLsIx+zv/VZ
	FSmgon4Y8gzpoGrqU1KYQr6Txe7U3SXoPimsIW5DwkH264vH/gBh8ONQbkLHXVQ/ZCbHRYN54oa
	LUaT7fA7+KsSmHmQ5Z/FuO5bAQWfDc5Q==
X-Received: by 2002:a05:6a21:b85:b0:3bf:9cbd:9a36 with SMTP id adf61e73a8af0-3c08ed94fc8mr8110205637.26.1783442719818;
        Tue, 07 Jul 2026 09:45:19 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.7.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659fa13bsm9690484c88.15.2026.07.07.09.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:45:19 -0700 (PDT)
Message-ID: <6a4d2d1f.bf38ae28.39239a.74b3@mx.google.com>
Date: Tue, 07 Jul 2026 09:45:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3043973526329926412=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] l2test: Fix calling getsockopt(BT_PHY)
In-Reply-To: <20260707145536.874859-1-luiz.dentz@gmail.com>
References: <20260707145536.874859-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3043973526329926412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1123158

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      20.94 seconds
BluezMake                     PASS      569.33 seconds
CheckSmatch                   PASS      315.20 seconds
bluezmakeextell               PASS      102.60 seconds
IncrementalBuild              PASS      557.19 seconds
ScanBuild                     PASS      988.52 seconds



https://github.com/bluez/bluez/pull/2276

---
Regards,
Linux Bluetooth


--===============3043973526329926412==--
