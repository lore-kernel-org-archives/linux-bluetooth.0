Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42173DFC7F
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889777; cv=none; b=PL/qgqXDEucEBOgIYNPeEOZ34SQUVY2dGB9Z6H6ZJ/jqfale05Ai9nFq8j0E9qoVwvYxeCXNx2z65wn4wy4g8c8XJvZwbV+KvXbyCK3OCiJjHumf8Q1VENp2FYdDKBcaPmgghq6Sq830nAwWJxXtOiVDisHAK7404k5dprP++xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889777; c=relaxed/simple;
	bh=oFcjZefuZ1lzzRmE2m5i96opXRkaaOUyaCgFSk9M7uM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sd9IJ+dN7WMa2j87PyprNQnNlp16WOG6XG0rUvHF5xvZPsM2PTKgIoNtRQ3SQowrCeEaCuFMUY0giUzwoKy7t0VE35g9eXTjW7s1n7KRJWTnK/S6W04zzoUlvxBFvJCHiPNEhppjwA2xq8WrKWPb+AX3y//XTLiQosgRCE3q6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4EmT1kO; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4EmT1kO"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ec6185so12336985ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 00:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789889773; x=1790494573; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M83s6vhFDISoJw5pxOHjt3sQGgq6sXwdvZqfUFvP4OE=;
        b=h4EmT1kOTsETzCtmwp6EjoR3CIDR31TsI6/6E3ez1aLrCSuYzB9IbYO2rlJmD3NPOf
         89vuy73MfeC8QpSCObUktq0o8FSUh2VSAIgoqABZ6t913ijIiDz8+W7AVg3ZsXOHL9IH
         UlbPjEFHwO093tuEzncRG9k4n0sc1iqCkdL8VEufGiJPo3eRGmjWJRX19dWLIezvqjDp
         8gsmduKGFAQt8CNuGyTGPezCLgbHojDhGM5gfOqV4SUXs86Z/3tSUze56W9i/Jkj/Jkc
         69xQDJhUICdY8IvewcPPSJ6wb90QjcB1pHkjNU+Ne3jbITkKpUAx8uP0ZMCBy5BTyfaC
         NGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789889773; x=1790494573;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M83s6vhFDISoJw5pxOHjt3sQGgq6sXwdvZqfUFvP4OE=;
        b=gjtaKfEPrNnpO2OICsWbnaWp8Yr+0FXI4ZMyqLmg0GFp4mOvFnnfvKCbIcJ7Zl06LM
         Y+79rwVieK4IJj2R2rTnOm9k2iL15qb5xN/zQkFevHI0YxybF0EnBl2bti0eEFotXzdG
         +eiJUhaNzK7pTlwyWxuRxUh1r6yNFsUxFmIdK/N3Pbugvmu6uvECmAl0sunhK+YqS5KL
         5yYFM/U8yuVTzX4pvxKSK74emu0hCkG5UXYzVOJNL4/bsMtPtL/eU6Xoim6yTgFQYTnu
         ccM4XIJcyY885XDfKQDekmqsP38M30EUOwGKxlvxt0T43GjmmgUdjUHZBTS8jCwR8/Y2
         Q2rQ==
X-Gm-Message-State: AFuF++m7f0ank8iUTxl2E2O695warKVyVHuwKCCxB5V/rGBjHfwJTnQp
	gvxnXECiDmbNIhgN86urYmsMaLo08h9D8YPZcXrxiYcqHvRnqIvM5/E8UMhliqn2
X-Gm-Gg: AYBFou0VbstmuOaTI4u4/OTXZZ5n63w7WCt2UQmW8wE6zajChcmm4FHp/UhEop7IhKs
	httA/tDbLm7bw948jtXEYLQfArOn3lLcQ7VALde5hxO2FBZFRhMWEFxVqh8dvIwUWIBvL6RaRgS
	aHIDnbWCi6KnXjDA10p+bTD/ugj4RQBx8nK4YEncn75FJ6vluz6wzRk7GkqZTaaEabhm9FtO+6S
	n+HI7soWoDJgaH/3CWa4TNZ/Nw3LMzQp0BF72TXVN0CFyGbD+Iywy97ivgr8ZBiwO+HVcAcCCUk
	j7drmOpoJkRdDHJ6X5C5im+vOJ127XcAzN8eZ5mmCMNDnS+0UBXd1r4GVpzKt50CrVsXJVGPdUl
	p2ajdJst6rWrWZS0iWaQjivGyd8vZ3SMlMBwtpigqokuj/w1SToIUBlil8We26keJupO1W/Ngh1
	neAylEjD9TwTWLgvwFHLQzQhv6mCzIJviRQvf3qwU9ewm7bGl0Hw9b4ongZevSh8dvfjZyN2+4y
	F1kPzo=
X-Received: by 2002:a17:90b:4cc1:b0:3a0:3d1c:2dc6 with SMTP id 98e67ed59e1d1-3a03d1c38ecmr757573a91.66.1789889773345;
        Sun, 20 Sep 2026 00:36:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.166.99])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144df9ad683sm2630398c88.6.2026.09.20.00.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:36:12 -0700 (PDT)
Message-ID: <6aaf8cec.48d69adf.1ef902.b684@mx.google.com>
Date: Sun, 20 Sep 2026 00:36:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8199444847156438958=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, junjie.cao@intel.com
Subject: RE: Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728
In-Reply-To: <20260920020227.709800-1-junjie.cao@intel.com>
References: <20260920020227.709800-1-junjie.cao@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8199444847156438958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1169520/

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      22.83 seconds
CheckAllWarning               PASS      25.22 seconds
CheckSparse                   PASS      27.66 seconds
BuildKernel32                 PASS      22.77 seconds
CheckKernelLLVM               PASS      32.23 seconds
TestRunnerSetup               PASS      590.41 seconds
IncrementalBuild              PASS      22.26 seconds



https://github.com/bluez/bluetooth-next/pull/802

---
Regards,
Linux Bluetooth


--===============8199444847156438958==--
