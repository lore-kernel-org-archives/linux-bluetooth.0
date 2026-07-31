Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7624F3B9D83
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493027; cv=none; b=IGdy4jxKtY+cpZpdFEoWZlZE5PlGuNqdEqXIysKcdQ8gPOBRSsB8WXttL3RHUs3JSbKexW9QQaY8ST18BHBldeddIXjRiZ0xKYX3ugAZe+0MFjrEMqxIf7mYxIBDGzoS3n7LcXdPfVKSXzMLegJnqY0VjBrP9+BAvunbSczYRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493027; c=relaxed/simple;
	bh=twuYxPh2M6vuV/7VFTXtAzTIcFho7FWN38UVkQTmLV4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HsvnqSalDsKV86++TdFT0LYgOjkxzPNWkqd2Z0lqFP5W40pslhmeoPmjXDpx/MbngBK5sLmuuJnovtLRKEqn5Di2Q4NKVGUvXLydY+tY5bq7h5jxck8ypWflJpWu4We7kWu6U7GCgviNzfpxA+hdW2aRBzL74g73GEF+Bl64yGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpF8AILN; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpF8AILN"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-456d267da8cso425436fac.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 03:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785493016; x=1786097816; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=twuYxPh2M6vuV/7VFTXtAzTIcFho7FWN38UVkQTmLV4=;
        b=XpF8AILNtVn1rryq13zAyINRnSVhBFLK3d3FKKRAuWMXh/r+yKFrfhzp4iVKhlNQKl
         y/JULpT5d9CZPgI/5m3x0vyVzYkg6WSADuVBXSuPaWtWrbGQfVhIDLQVisInmvYfv81r
         X6+9gdmtDpqVWkH685JTcprXZQS4O4okgubMM6Vv+Lp/9zNZ+x1BF2kWTygKzKmwz7zk
         +XnSu21J1YIQEGcQeQxFjgG6Xyr1P4wa1Kk7/LBQN60hwg8T33av2DAQlF7M8Snylhy5
         1jJ2RJBxOzAmYIkthcTCZj+M5jvYrXaz7WfzNgmw64LbhdWXxLqWrjGkaX6Xlrv32huo
         yYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785493016; x=1786097816;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=twuYxPh2M6vuV/7VFTXtAzTIcFho7FWN38UVkQTmLV4=;
        b=KR21Xkhps/HCbnFMq27q/8GUqb+AlYmjrS43An+5Uq5WOm8XFKE+3u33qZOg2zM+qb
         7DNuybMSW9v8eeW0kfCE06bd4L6eyLa9vnLHxxUnJpbv/ny01QQR9DF0lZotQmJO5weV
         job3bAqLGBtTOmx4xy8K0ZFbLVIU9zExjU7vUxGxIwaQ9+9dZvhqvraHJNFi+/2IUvo6
         ndWSjx1ks7RbVYHtO8A7FpFnxmsv0gIF+LuDxVKRHp9ZdlXlFaqeRhHXVmjG1WRUKJMH
         x6D3CYOsOHLCPh0qMqLjJrUKQfbasyeQDeRSaz6u5d+0PBszzXUfU/tRMu7fQAchoYuE
         560Q==
X-Gm-Message-State: AOJu0YzFuTGT4YUQ+xY34qjcaeCUUNTTBcwESqWP0EfV6SESGfo6WBLX
	U+HvtxYpqusMFn4zVJmveKD38sGn3k2STdxWJr83sq9jHRaq3xlDk8ZoUsOWhA==
X-Gm-Gg: AR+sD11Kmpp0Knv+/OqHgY0BYkoRRZpTsKAz1z2Bfl3sOjzBviFeCr3oxrlp249sGFK
	WBRpG5GW46q6EuxBKFu1CmhGrd8BrvJ6uqInOF/pB49TDYGoDzFRWSJcXdM+1fYmC/QP0PKbLlH
	Ryd7bJRh5+ee5weKqLj0FOUAWuK35y72ltpcJDlioaQxVrGWKEyod95hQVGpWZEHGd0wN+X4i0e
	lUbthjHsH9Vsbc+C3xoD24Ctlf2pqNqiZ21/qOOM7Zzjj1xRVX7writroyaiH9J+jkHJIhzG4eJ
	Jn0KLSzzwUjoTqScomuZRb9Wob4nQdz3S1UjlbV3fh+hgTyUHJuCeu+TvF59LZCTz11VS1gG2rF
	RrdQkbOs0y47bBnYj17Zf4HD3l+q7AIVVCy0LtWfF71ypPLvllhOhY+h22UjCpJo/9KJ0P8xP+o
	viY1ZUJCy508NwjzRhsx6JCTCqwhLrWP2OQfFt6SvreB0LoclzPr5sPQ2Hxe/B32/q1ESgRBw5L
	5pHKZI=
X-Received: by 2002:a05:6870:c0ce:b0:448:7667:2e96 with SMTP id 586e51a60fabf-458f2f3f00bmr1271663fac.9.1785493015924;
        Fri, 31 Jul 2026 03:16:55 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.15.176])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f66c1fe3sm667222fac.14.2026.07.31.03.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:16:55 -0700 (PDT)
Message-ID: <6a6c7617.997c261f.4327c.dda7@mx.google.com>
Date: Fri, 31 Jul 2026 03:16:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1464340173004706540=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@oss.qualcomm.com
Subject: RE: [v2] power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable()
In-Reply-To: <20260731-pwrseq-vote-rename-v2-1-480357946e00@oss.qualcomm.com>
References: <20260731-pwrseq-vote-rename-v2-1-480357946e00@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1464340173004706540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/power/sequencing/core.c:966
error: drivers/power/sequencing/core.c: patch does not apply
error: patch failed: include/linux/pwrseq/consumer.h:20
error: include/linux/pwrseq/consumer.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1464340173004706540==--
