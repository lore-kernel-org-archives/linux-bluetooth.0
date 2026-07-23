Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1F47CA70
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819531; cv=none; b=miqiHESJfyucwpQ6bvm0KL6JNdALLyyBtTPoFxBvKYowMdfYcALwJ4jvk+CYMbLW76i8AT6kVKS4Y+Twd08zbxMur+w7omEedQEh1toOdK3gI/g4ik3aBM7wczfWw7ryvf+0h3qR0k3XSAMZX7xS2H8pnicrQnmMISm8Kx71tIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819531; c=relaxed/simple;
	bh=dIysWuuNjk8eZfZf1tjWDHMLE+vl8nRgnxUb1PlLhyY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=l9KmSQ9rm2vV3E+k2oJubub1Rfx+KSadYAN386lbyJnaIIdpCWx3OM8jcemP1C/5hVdOGdkeFJYZHX2RYQ+065+fZKr/cWJBX8cMSiN4NcmBkSohBsIMVDJ6crkNvYrpquZ0VbIzJtyu3cm7u6Ulp1QWJ9i3eDMZEOev5c9GD0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3ORJFSb; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3ORJFSb"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-902e4af2d9dso6591346d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784819522; x=1785424322; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dIysWuuNjk8eZfZf1tjWDHMLE+vl8nRgnxUb1PlLhyY=;
        b=D3ORJFSb+Tsk1ziytuzHfww51kJwL9YOFRwKgSWmv8fLd0m3sXcK/9tme1SDAg101w
         yM7C/ch7GPF7VPnYO+IRkDMY+txZMChlJXTi1svwoJFqtMviP7kqHeDHQLSe3pAlxurH
         QlvVATHQu0BXCwM8ozHS3ZfXB7KPxYTdIVgPmb8PKrsTESFMVSl2WDPMETEQOD3K8uUS
         3pj/QzRFcMvjsvLgg1X7B4lMK6KXpy2rDzzktOkRtPHHi2g7qv0cQ0cvRG/UnO35PZFz
         4ZWJdCrjCjHR7nkgsOd4+iOBJub2R7zJSJVZq3J99M1eD6n3fTvtcHbscDIAex9p65oc
         3Zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819522; x=1785424322;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dIysWuuNjk8eZfZf1tjWDHMLE+vl8nRgnxUb1PlLhyY=;
        b=kZExUf7APQUbMRiEiYw1qwH8JO3/Bfz7YcGBZYPZEBg0e/plEPeWZPuDFRUt6csyST
         JRGOG+lB/P9koj7P305lZQwSV8eiIJr533kCEdihsGI8Vx9l/g9bYayuUZc1EfhBQIiU
         ESsQOjQ3XC8+nr51sI2Q7a8yjo/UoDrxoxcU8faVLs2vmlnMktHYajzKF8fa9BfjcxXb
         YPgHwCQSvaCOlZZyyNXIaFoBPl/TsuUix3gphflPK0zjnt/lCoGBIQgD6g6hkHD3/wYW
         LVSWaBK1kazECTY3se6XUTTcUH9znLFIxcNNCRgT9f1xFU+nbNKOPIetCKF2I76v9mbA
         oAEQ==
X-Gm-Message-State: AOJu0Yy+6fY1Vo70hSPhDGoQ3HuUFRUe7ktKXDQuthUTjMLxc2PIQ16c
	lRRfAZRjx9BUiXwEHzm2ARzNdkoJUm+KfaVDeaSHrPr1W6frfmnufxLMe4C2CA==
X-Gm-Gg: AR+sD127NBfsJwbTGBKP3xhWrKD+ap2oOPGmNwufkNfCvhQw2nk2y7YsGWs8DDC/mO3
	be1oOV7X80MrizuUVnbMm0CqYBtCriKR6KvDbui6FOceVlYwRCrQ6bjQWbPv5felusX+etCeRe8
	pb/TczTgD3OZS+WxfGTz9IpkCMjA/nvJ279QbEHFqABOSYcHqm3bcScCKOQwohMzut7jqrZ4Dlu
	IZigFMYEdl66naiXYl7CuMjcbwJtZykoKsRU5Ghv5XFwqCla1dz0EkWSF5RFr1qTXfgYhBy9qYH
	jixiI3VD40Dd6gs9owdGH2dv8dKPmkB0RBcGaW5BI3O3NBqpGg/GfnpA+lGj4AExfZmcHTGvr4K
	MY7DEcCg/DORxqHqntrwHPsV5kiiV4YyFdhZhXJ8avPijyOAoFylCS3SsxzJ9zHi+G7HO46A2sp
	kqYQJTLlBrWg==
X-Received: by 2002:a05:6214:1947:b0:8ee:d9b8:8538 with SMTP id 6a1803df08f44-907cd00a55amr30778076d6.9.1784819521861;
        Thu, 23 Jul 2026 08:12:01 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8d484esm46889926d6.14.2026.07.23.08.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:12:00 -0700 (PDT)
Message-ID: <6a622f40.4c95d0d1.51cbe.aa42@mx.google.com>
Date: Thu, 23 Jul 2026 08:12:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5863415320682936141=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v5] Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs for PLDR
In-Reply-To: <20260723094443.855492-1-chandrashekar.devegowda@intel.com>
References: <20260723094443.855492-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5863415320682936141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:2781
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5863415320682936141==--
