Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78DA361648
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212482; cv=none; b=iI62dVCti/J3PQfdQ5kae42nUHm53E+ZM59Uw4UaA5l472f4s8dVDGqj5Un94fw5R4dwxuRiBl6Q3ROFEB2RbSMYwqEvVrjtIn6FSzM9OH1vFvR/qnzZDmTnf0Pu+Jivq75JG+TxCPZaIeW9BFymJl4BrlRjRKan09MEaDoiBXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212482; c=relaxed/simple;
	bh=hG6g1h6M+Cc+lVpH/yYZs9AyNb9lOYwuVXKG0IdE1PY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Iauh/ufnkQP9hHHbSftTOAcMjGU5psiqC+YXRsIMwxqzKYk4H7BmbTd3DIK8movQA2q/W3bYISiv4gfndBL/Lnq93CjHOZaTCWoqWqfp3onG4d0bqbn2MUth96AjJrFCTjRd559Dng8rXhDyavGOHV4v4+Tt+DqgSly7GOdZcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGIlJtem; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGIlJtem"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1271195d2a7so918577c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 09:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772212479; x=1772817279; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WOtkWiHkeaCcn6lAAM/2+eu8rfeqhbN4/kuR2WePMng=;
        b=aGIlJtemyqXMeEVF7ACNQisJk2RNaiDPADpTaX9mQD8Go9OqT9oGk1rb5BAyOeZDjm
         MTKtCoaP/EeoK20OdwRFPPiInGR7HvvTK8gZ6oDMGCOT7VLTqEs54sKj/OqArp1rbz10
         ckgOVJCnLkTYYBsl2mxZIqd21THfmDj4Rig0pFdicTQZfrBC9yIgWOJnFuPPX6K6xxs5
         6jATA9JzUCD1IrXB/TD0ML9M/7lU+XcYAGfd1oPnEVQkl51ORiGpnQc15UVyzCeip/DT
         pK8L67kWRDvj33Fm/PMqy3tOzc6d4nTQdhEk5W1gp/GCUxFPBG63p7r3kPgAcPK6E30d
         97Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772212479; x=1772817279;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOtkWiHkeaCcn6lAAM/2+eu8rfeqhbN4/kuR2WePMng=;
        b=jBOQy+rDvTVbvjrwBk0fOatDzrQ5Zdjhy3Im/hWNxUdiN8S2FzBc3YM18qnZCaIGCE
         gaSPRHtBg1xTKsgCL4jc2q6UpZut9KngVz1KaD1alY0GUlOYpAy+xPAInhtGpG8i1zGs
         B0dbZplNptnolv9NM+Is1d/sZuy8YBCH5Ob3oMZdm3fD0rtJywgiwlFuicpl+ZDvCzfm
         zfumZArgXnvb7togit+ZYMJMG8nYB+g9n9qdLGnKUjNJpTSmZ86JpTvfvLpU/PoO0Wtq
         5hJ7s1/3z1yuxdyWDjDNSd5R2hjnHLqXtq1pjvUif8QO/FltEfexntpapJZkl/gB9bIj
         P9tQ==
X-Gm-Message-State: AOJu0Yz3C8bNoWxEFkISM/zOqtkuhmUMcdQ+pQf2vpQqyPvcXH3FQqbr
	FjS3ze+Ylv4Xi1HSDTaqlFgwyIWEzeJYF+tnonI+B7NBem4OvuzxXuyM9dIcPA==
X-Gm-Gg: ATEYQzz7dRg6cAzGTClTRX+vQS54M+wv+LIUdQBPqPWSzD4z1oLFFgJDrz086+5NHhW
	3th2tCOwlJ/dkV2bP03LzB/g6ED0TgSbv6LRWJSlvHWYBuJ36nkVoJYHXJQ8G17YiM+ND45brb8
	Ohe60d0kIYAzdj0QOPRQoWtefOl62euilLNI5o0p3mJDHT2z6ggnV3UI8uMVX9DSz6ACeIwJ7dV
	cGQX1YI6NlSruLVol7hvJrMojDhSY+redL66S2XhbtLA6WS6Oi29WvoBqegV6HGKoNyupnQ78Ox
	mHltxfIM+J/3Zf+AUEUckpSjccNazaiDk6enAq7Ruf6LU3m7I5THbgk5IaYvGwqaSWHBG4Apa7L
	lCF6A2k+EYNaRKz+RWKKN53lJLaOo6DjRj/yctu7a2ShiY/DTa1BTLBJq0iPcHrMecDsfDQ6Klk
	fcaVFgVc04yVJmO5algdgme38pLDs=
X-Received: by 2002:a05:7022:209:b0:119:e569:f268 with SMTP id a92af1059eb24-1278fc5ecaamr1495297c88.17.1772212479320;
        Fri, 27 Feb 2026 09:14:39 -0800 (PST)
Received: from [172.17.0.2] ([52.159.246.1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdf0cd07e6sm71554eec.21.2026.02.27.09.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 09:14:38 -0800 (PST)
Message-ID: <69a1d0fe.050a0220.cec5f.fe01@mx.google.com>
Date: Fri, 27 Feb 2026 09:14:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8049948917573550727=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: doc/qualification: Updates for TCRL pkg101
In-Reply-To: <20260227160022.21462-2-ceggers@arri.de>
References: <20260227160022.21462-2-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8049948917573550727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1059103

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.78 seconds
BuildEll                      PASS      21.37 seconds
BluezMake                     PASS      654.44 seconds
MakeCheck                     PASS      19.09 seconds
MakeDistcheck                 PASS      252.87 seconds
CheckValgrind                 PASS      304.43 seconds
CheckSmatch                   PASS      368.99 seconds
bluezmakeextell               PASS      187.92 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      1081.50 seconds

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



---
Regards,
Linux Bluetooth


--===============8049948917573550727==--
