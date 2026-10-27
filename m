Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090404;
	b=4vigeqXx94eEM7lApBY/jv9A7/X7VG2k2OkH06x79lnV4lc6m6Q4Bol714Hb29xpUqJp
	 VxTfDD168qn2pLbg7L72T+3ktI3/nWK8QhhpFIGG2K+L2Oelo7SSZp2FRcXwkXgnn/l9+
	 SLdI+0SMw+DECfdifHKF/konDt0cTo/K1GmwYwsn2uXjngSjRX3khDK4TiO/Hnvj0Dhud
	 wh/tc5ZQUPRu4+SVlb1GuSRgDZtA4yDMOMVw4md0VWOyuPG3vhQfuB9kJm7mBLBLuXKfW
	 JbrNTIZKhq7g6UnnL59lIRE8V1T+DtQjCcrZfhUvQzHAUfgfD8GV0D/MfZyHKXpCpig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=xZlP3mqAtSS3BR8QzwsR0LvSlJVcJ45w+t8lTUV4pTY=;
	b=lixeEftQOZMutEZxUCi8IilTK1DvEwcUYm1Yy3BbIxTf1BYo/Csi/Z1gGlp7Y0FtGg0m
	 T1mGmp+p8PaVjHhw1YkrjFMT/qElKdpbCRMThc1RZiEf747RbP5BG3b1hCajiLcYIahUq
	 9VSCyJBpLg3Y+zEiMW2hRmNIbNW/fyk8IsB0zE4x+p7TXJAaqEyfB2V091rSGgzQn79Y+
	 IVCRBL+2oN04VRGp11+4EYVyorcRywWTp/IoE2erB/+pHYdo5Wfw1SrZaXY2gK+CkNeLI
	 AoffgalzZ1Iajg7L0/4/kHDObQkF2orZa2JwLiXhWy4W/UqgYUYkhnEQuT2myPKLSew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NdITQWiu;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D73606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 08:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59D73606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NdITQWiu
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4911df1e196so1932977fac.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793090403; x=1793695203; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xZlP3mqAtSS3BR8QzwsR0LvSlJVcJ45w+t8lTUV4pTY=;
        b=NdITQWiuOEy0ptsERzrgCbk0PkpWTSPDPoU6W5/0y0gOA7EHBJLQGEI7BlszyD2Xa2
         NdOAy5ZCWWAMwzYMOVZQ092h+Qf6IEY/Hizt/3G82IUEXviBK7NmIoD5oJv5pB2CTYfS
         OyjuGWpsf77gYm+98jsYLVO2bHJz27bSDvlNvzcbosFE70v/wP/xH33HmLZsrr0/mqfe
         7GrYmXXnUlvpBJABceuM1cfL5GrmxQpI29goY7XNXGZAklF6SDXKkGmlujZMyymlGu/z
         tzsCyg2gHcdiJtit2JklZrw1cNcltYKFXoUYNySYuIjRtBPudyPjoDUvRKuNZgLFxn91
         57Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793090403; x=1793695203;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xZlP3mqAtSS3BR8QzwsR0LvSlJVcJ45w+t8lTUV4pTY=;
        b=jX/Q+DAEFlTj92VapBooYVqzlwGMUsXPd09fkmLplaPQVTrrJ2rG2Zq6BiJlY8blXX
         zEWDVoD2/v1bJaoKbquqPwIFSVxCfJmYrRtvEZ1gcXJtc4RSvgit55X6FkbbPVpaYUFt
         lOwlcZPTtkNcGjLgnRZCc2YoHjfWO+hBOyrUtBYjw2cLxYCptRs3elb0k0nx0AfycuFI
         xJRN3/oWPqma8nDqEhi3w2b5o06MM1GHXH+COg6zhvcRW9OtoljWW2irpcrScplGPzpx
         n+AOWq74+XRrDMVSTWJkNcndqF2U0fsNU4kApP5JILLpALTLO0yU5FaMKC3t7P4h9ihM
         hq2Q==
X-Gm-Message-State: AFq9FYLVaW9w9ZUMKS+/MLB5BqjMrNdV9gki28tuqxxGxIcf75uSyOR8
	Z0lGasWlm5uWnBxD5vK9/m0VeGKrs5fthKYCFQP7no5V39ThD8RHBDVxV6WVu4a2
X-Gm-Gg: AYBFou3Vp+SYiHkcxIoa/DJuhzx77W1zGSldnQmTRzUuy88BvWDDawK9XMeyV7fJf3m
	Ru1Oh7RuTBQ9w9L6+QFflmP6bc3UvdM89+/qzy5jNfLpj0FdSKtHMktwxD28F/gtSmWvpW6yxUk
	CENNSKA2qs0Aqd9YimMBcTGhK2AVOJz9f8CS2vX71ReHg7/nfH6O6+wpCFb3C42Jn0P6/u2dIlj
	HcLvplWti0qaX0bS1MrObcM8u2h1jdxNwWQG/6h9RIKM9wCNaB2Yr7bqpGtk3OlpLoz4xQMVDHk
	AQ5aQi9F0NprhHDetZuZztVihBpsEVlql9n4CiFGWBxfHybwXJLC5wButmFr8lK3mnBDujJKTAb
	sVPHagUWos6Z1NXd9E90GglLf9h2Ky8YAqix+MUnZ7I5gyvP6uPeu5QjbdUxwWPRqebVazCcI+V
	kux4UT5NPYbKLx0yElGU2cMFPpymM82dMO0goi8Ub0NSrixrwgLf8FZYeqkylLPFxGC4X1bs+BD
	n3yuBpOznQ1WWGgR7QFKnt3NNZ8orQnef0bYIcG4vBEOV0DNWsvwB4oWM6DKN4=
X-Received: by 2002:a05:6871:787:b0:49d:fa23:1b9 with SMTP id 586e51a60fabf-4a83f5f9a19mr5024780fac.46.1793090403036;
        Tue, 27 Oct 2026 01:40:03 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.245.32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a843225d69sm6270549fac.15.2026.10.27.01.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:40:02 -0700 (PDT)
Message-ID: <6ae06362.73f9ae50.c726d.5f35@mx.google.com>
Date: Tue, 27 Oct 2026 01:40:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8920073652898551528=="
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
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: [BlueZ] advertising: Fix leaking clients that exit while registering
In-Reply-To: <20261027051206.92829-1-kevin@simpleble.org>
References: <20261027051206.92829-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8920073652898551528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194268/

---Test result---

Test Summary:
CheckPatch                    PASS      0.35 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      13.15 seconds
BluezMake                     PASS      170.17 seconds
CheckSmatch                   WARNING   171.41 seconds
bluezmakeextell               PASS      58.38 seconds
TestFunctional                PASS      809.77 seconds
IncrementalBuild              PASS      177.82 seconds
ScanBuild                     PASS      584.87 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/advertising.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capabilitysrc/advertising.c: note: in included file:./src/shared/mgmt.h:95:25: error: redefinition of unsigned int enum mgmt_io_capability


https://github.com/bluez/bluez/pull/2718

---
Regards,
Linux Bluetooth


--===============8920073652898551528==--
