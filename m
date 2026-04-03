Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4203A0B39
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775211468; cv=none; b=W2ErrkxTRh9KdggPYu8aLaTRH6DaoNG1RDTnoHP8dsgLeUXtu1HFzz4QD0J7vUKMd6wBqcAfHGRpIb8GCKQAsz4uTDU+pmH43OysgnA4V5Vk+PH+aKq9K5Z2Gm0Er7tmPn8VMTKJyL1Ff+gvJJGgN+qEea/n8w/MazeZln1H8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775211468; c=relaxed/simple;
	bh=n7DBS6nU+jBUZlw41Rw4B7FslSiXOqHip+3cpEkgLWY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OaEZIm3o1qdxNrcEBMwyBOIO0Sb2XO6c7wERoB5fPnnTxbU7PisfKQchG7Nf2pf8JdwM+Wg/te0xjzYm6trBD7xrGofs7/eh1p7x6L9nd3FnBv4yVbBBgWBaJcEOHgwZRIhiZEaZDaU3g2rLThnDryCX1e9ycq9Ao7R47wV2VCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1r18kZb; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1r18kZb"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d9d929e27aso1602727a34.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 03:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775211463; x=1775816263; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NANoFoXd1/ptbR0nqwZq+YEtlkqh0v3axVLg1oxyhZw=;
        b=l1r18kZbAHnDkL7NrSnSJoCtHu6gTOjzlpfZrVpkQ3N7ggLSVV3jV0s1KivBQfpIJe
         D384R93IGCp68CGqbaZD0a6LgNeaNZK9WyXoMDW3GFj+YmV+Yy+kZiqoJ6q/xwnDgspG
         uPB2t9cKdioVVya9qyj0ntKmUVYQa8XE4R5TTNh5jkW8+e+hHkgpIaiER4TWC3sbSSLf
         /BRWQxG1/b53+E1V2KStSiF2mK4Q/wcumecVzvvVWSK0/+0ABBv3E8jLk73FLAymECXX
         lcPO1IXMY4g4c1jPwFsk464tLCY4/JGOmXNWPVQxXAmovUiK7S+gDIam4kt5FIp0IAFx
         A97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775211463; x=1775816263;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NANoFoXd1/ptbR0nqwZq+YEtlkqh0v3axVLg1oxyhZw=;
        b=l8eihr49/HPXmBT9/qjixITxRQvxQvEDrsNLKFZyE+InH7CSGfpIKmGnb1YseKjz3M
         LH8itCS20Mp52RzVPq6gPxqWHvuj7pZTAligdU1yqHwq4sEN4NaiDumcxy8ZmtT0Zq1l
         0iDFnR1ffESOTjvco2/SdkWrckD2a7eK+sZafEwHWU2c368wa9JDJ7C3/AGFNJep+rof
         MKUTTSFNI5OBJwkOSZEr8iAnFpkzJCsIyUSVsbCvnEw1vZO/ZH/tDut6zs5kNh/Bc3FI
         1WWHAvKjK5G25ibPuyYSd3hjhCxtQqO0kevBt4ASx4GVIsLPG3tqjcAR7U1PB/MESc0G
         G2Vw==
X-Gm-Message-State: AOJu0YxHXop7TmmM8wT8nGiXZo/TRgPpybzYJwuWRCiyHrkfh0YldOqH
	93e7L2tsftS0k6Djh/z8BqBiGi3k+8MTtYquFo2inYQZPuD64YDstW78zoiwxA==
X-Gm-Gg: ATEYQzxPomoa4vT4kzAO5alwtB0v2C7Ur3BMIJNkq0UZQri5tyrEbSHghlm5wKVGbzY
	zPowWLGbM4kqf8KPbuNpD2cUR1M9xRZz8hHrI41nYs6s9xG0jYI3BUaE9qFOJbkvi195qZZlXQQ
	4WpQ1IXGm8KNkxH2p9v93D4BH7hIjLPBZf63eAVFSPhGiME2IQ5IIGnuTjdjDU5Ssf428tApymq
	7wKQQcVLefOQCec6JtDEXZww9FkL2ZAZ6Ht2BUr2Ps9/6/fh8ZOE8d6ftzG0mqMd+TWKxOAaW4h
	iewUEqvs86Ex5+j4TC1xRgjg/fCYHk41zE5X4uz6djPuEi1LThhGpTAo40dROlEEjzIWl7ML1IX
	sgErXcGxAjEa/lhm1EDjRHYvEA2vWZFW+sijKfrVVdcccPL1x/yxFATTx8YWvoOZFipDgblWm6E
	bSf63brkPFTQNUa64SrwcE6qW9/SaRQl32
X-Received: by 2002:a05:6820:60d:b0:67c:2d5e:e9eb with SMTP id 006d021491bc7-6821f487d70mr1251854eaf.33.1775211463583;
        Fri, 03 Apr 2026 03:17:43 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.169.152])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb3c8282sm4458142fac.13.2026.04.03.03.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 03:17:43 -0700 (PDT)
Message-ID: <69cf93c7.050a0220.af876.5d1f@mx.google.com>
Date: Fri, 03 Apr 2026 03:17:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7511817402756877851=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,1/4] shared/queue: Add way to iterate over queue contents
In-Reply-To: <20260403084128.348931-1-hadess@hadess.net>
References: <20260403084128.348931-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7511817402756877851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1076877

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      19.98 seconds
BluezMake                     PASS      633.06 seconds
MakeCheck                     PASS      18.61 seconds
MakeDistcheck                 PASS      242.45 seconds
CheckValgrind                 PASS      288.97 seconds
CheckSmatch                   PASS      345.38 seconds
bluezmakeextell               PASS      180.10 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      998.84 seconds

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



https://github.com/bluez/bluez/pull/2008/checks

---
Regards,
Linux Bluetooth


--===============7511817402756877851==--
