Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888973CA49C
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579756; cv=none; b=guzBz8BUY2HqeLl5MlYeFqbW+wdybWpmOcaIleimfY1OulseI0L1Y2VDo0cd69nhbDRgWq6pt2dx65eqsvqo+TyuMX+oM+gjS8Hxcywba5mPIgrlWNsm4+uipEQ1QrOrNuChaSyErwFcQsCsL5xL6tXLcGT0hfKlMJ+MF7L38RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579756; c=relaxed/simple;
	bh=98UWbsQzsoLXNtT7pmaReMyZ2riDrZk4H0bwmJBGM58=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PJlkFI0E2A94pdiSVd1YIrT06cDH48Zk0DXuYBoJSRD/6GkkY++5NQXvCvb/i6irzPAn5AnFXX5Re7f/JsUyQ95zjEluPPtvbkiOYoYCYKVDkrk8sm6ySdz6rzhQGjdg69BAD5yRav6A+oBY+yEvaZ0G+39nUSqoVZQKICdPpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxjR69Kq; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxjR69Kq"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e7632b193so772672185a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579754; x=1785184554; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+yjXFi5vlBOGgg0ItGGWpYJalpUig40GwTXM2PKTeX4=;
        b=QxjR69Kqr4j18rMYDBrxoERYY7n9xyz9ImNJ8TuveMIiFJIw0UUnKA5bleSvse/YcN
         3r4Uwluk0aEDInn0wI8XZEa+XV+qjiZycQG7jRVtbv4DGRx/+O6b+4gIozNdly1otAz9
         n2+M0IFOmDnDAo6Pt/iMA+xvo3EzLzfwM4SDF+W1FUQHDfFtGwRHNf+VHNRFpMlFovuv
         J3SUq0CIEUftvNPX/3b2MDzuCuWSxnrQpQcR82ci7z+kWjNWFxpEinvghXTXt6DmWOAz
         rXa34HRfs3NAT+zAIDtfmU+Ylkga1DIdVLanBIU3jOxF8uKi1GWBF5LKbThf44MKQwpo
         KoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579754; x=1785184554;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+yjXFi5vlBOGgg0ItGGWpYJalpUig40GwTXM2PKTeX4=;
        b=sVsT5AQz8wVmdalKrUkytn17K/ym1JjkSHuQDEInYY4Avs02dhQQHpAtzNAna4HWqI
         suJUxaQJGv2jWcieiBU8DV67yedj4nycQJpnj/aLQoyktLY8zZ3qRMKWdpbEN0NmSSqa
         NBWg2dXYeYcvDASB5CJ28m4Q+Od7enbAuLXaU/uDCyN/z96usVK2mT/PWn8/UchiYw73
         PIgSRVz3+VBfuAxxk0fQY8eKYobDmybv0G3pWiR+Qb2syoL6QFYYguUGx2SsmPRmBw8g
         IMMkCbPzE2wtnY3tX2TyL21f7GikGoxeMqXIrxhHNsV5vE7MnXC4bdSSYITh5eDYqGJL
         BG4Q==
X-Gm-Message-State: AOJu0Yzu2Nt4pS28Y597bF9om6/5xKvv7STvR1QKgVmInjvUGQqQqkwc
	bLQ8i/J0bG9a2oZqSGPIJC8FIBGUbJiiZucESko6T/sOeKwTGytc4jBcoX2CDQ==
X-Gm-Gg: AfdE7cm1Q1d7kq2d2K+ydwPSFo20pK2x7WqvZlbc/v0xbBHhSdgSYtSMmtHGbpU6RRN
	oMxmP0bRysUCZJEHUpJt+aHGbVoZoFcK+80NQv9/UKjYLN71Nbv9gSec2JiR3ZveE7I7vfIrOqe
	uCc4gxaPGret2jPq8lehIduxB5zyitKS/6/4f7jhvnsP2b2+PvEm7Dot9qSRV6i7vNldnnqEnAE
	WI06SlAs6S985CCZxF1z/ZymZt/6xGyb6FEECMk4uodsNwSMbEfXNVEToWn9VvDp7kMn8HmVHEr
	p7VJtAJGwdKXNi5iNcWpEegaeq9qlyWyfHbNb3p3nJYcnrTrkPZQzCdCLBvVuD6cYX059Lygy25
	q+E1rW4O8SwcslXJyCP5X191E1n5uSI/EflIm3p705QQIo+YKNQSNAY+QHslXLkl37QsT+mY5Zy
	qXoIQB7AbV
X-Received: by 2002:a05:620a:44c3:b0:92e:5b45:b572 with SMTP id af79cd13be357-930b3ed6651mr1551661085a.1.1784579754306;
        Mon, 20 Jul 2026 13:35:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.213.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545f522sm942676785a.37.2026.07.20.13.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:35:52 -0700 (PDT)
Message-ID: <6a5e86a8.9e118ab0.17d6f7.2020@mx.google.com>
Date: Mon, 20 Jul 2026 13:35:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0842257609542619215=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] tools/iso-tester: fix GIOChannel refcounting
In-Reply-To: <77c23b3b0b0b0be0ce52e5718f88f8723dabf7ee.1784571951.git.pav@iki.fi>
References: <77c23b3b0b0b0be0ce52e5718f88f8723dabf7ee.1784571951.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0842257609542619215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1131086

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      20.37 seconds
BluezMake                     PASS      498.03 seconds
CheckSmatch                   PASS      296.18 seconds
bluezmakeextell               PASS      95.09 seconds
IncrementalBuild              PASS      496.49 seconds
ScanBuild                     PASS      882.20 seconds



https://github.com/bluez/bluez/pull/2334

---
Regards,
Linux Bluetooth


--===============0842257609542619215==--
