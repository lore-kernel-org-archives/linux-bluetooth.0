Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95ACA4E
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780725855; cv=none; b=DmRmXGa0qJcFWjpEpBrHqPHtbGYM0IQGejP5J04Pi4MI4lALbRxnuzSGInObM/soamEa5y4Q53WJZrikDIi4uXT4E0T6dOuKCHNiqgBCvqALAt5NswfP5395FWekf7fsfYx0+AiVOeLjqQvinetGKGJFUxiHzZlpMzVTk1Im0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780725855; c=relaxed/simple;
	bh=SxE1p2Apcw7NFJ5YxIlSCj1e5Oa0UwzZ217+eAtXHWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vAHAe6U6dXrUlBj29rcjf1SYxJFP+yjz/YxV7Xb3Swum2cDs0KEKF4vS+eualz82py2vs0hSR4sPrpfD9uRNup0aPkH5HLO7iei6LKMoQ6IvbU7QFaIeJmns0Bcp4/ncCeTG7RqWv0TvtFcG0NK9DGaD9+1K5JdpPSLp/lHvfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=0r2XsYrg; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="0r2XsYrg"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68c5eecdd56so3956733a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2026 23:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780725851; x=1781330651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qb2lyrVFnP3S+5CMjQ7vFchLFsvm2xjSL1clR3Dmzuk=;
        b=0r2XsYrgoYYXqJOD9IbU++b4pAX0pmx7GAWQR91IbZahEXwAyoKoj09I3Z3eH2XR81
         gQ/kZ0roaiHEyN+yTnaSpPR5GIZS3uxN9C8fEoGzNyH7roFIuVzZcrNtJbMs8eTZKyEi
         mAYnURlGyYcvyCHUqc4eTMGmtqPQ6pw+52KdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780725851; x=1781330651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb2lyrVFnP3S+5CMjQ7vFchLFsvm2xjSL1clR3Dmzuk=;
        b=ag6bLwKiE6w9Ttl5vkUWp5HOSRF0gmstDL1Es+MgnANMVgZy8JRjItkbhKcDhsFTNx
         AQX1k44+an8QT71nC5OW2blNGOsP/vCIkpPWMm2vhEMF/mv+7/iVbhRdxNcbNlPRNJ9r
         8pLM4BhDBN2azLTK4DguMLOTRjf7G+Srv9WuWR77Up55JzrcO1axCoJXRtRzCpcbWj3J
         zh96Gmyx3iYhbA5Jtx+J6TZ+Eg91G1V/AAp+ILEkIAXg/WHntyNuT4ONEIB2njCHXkrL
         dHubnbFbIpYJR+fedfuawa5ff021IjCLKO6YfN/EwwJo82lrVCXRxwe8l4tqBewpVr1D
         Fuyg==
X-Gm-Message-State: AOJu0YzpYgYLDk3vrU5+hAqty5NSqZfQXJHHLD8c5lahVIA3Yq0CbBZ7
	BhmrNoeZLs19YkHqQRi9HQAL2OPfs2869hZF3wLpz1XddaYLZgfm42YLpgZSNiqWKx7uQkoNAaf
	oVjg=
X-Gm-Gg: Acq92OFjq97B3mr2hA8KMtnjoEzKlRKTrZxxhYtvpkSFY2SFiRKuc4DanALUGDI6zvI
	sIBzKd+nlhMP3qk2uKB4jgY3H8rE5jyVTGX1Nlv/xDP+chr8sXKr+m82r7dn4weXkw/ZPesdrWW
	oRXO5nu9y/FDec6FwqCJmWnuF+1Kawq5vlr8y9oZlHu3P5jT7Pxb+MCL0MmeYxncfYx7Vc+74j/
	NgudavWZ/TsgHoGn1EOjZO3U8y9Hjc4Ni2Pn3xhuoD7htFDTQZ5uQ9mAuMs5lnNn16FPChQOice
	oPKbU63H+RXJF8Tfg7Rnu2lNxoxQR7twn1+KgKtEJ9DZjZJoU+7EJSqqx6spblSL784cRr+Q2t2
	kbvGL2a3YJtiwqQazldOacSkTrPS8PKBtQtjuv3nnWMP1FTNqkFRxpal5ut1xMBXonZrr+9M0e0
	pYCkcxj+UNbQokgAAQklge2ermPHO9/wk3HHFw1Hdw/3LjpyZvMFGpnwAmxxI+kIumlRTB14yRl
	L68l2RRdkSpG9pWz8A=
X-Received: by 2002:a05:6402:5cf:b0:66e:56a2:b67b with SMTP id 4fb4d7f45d1cf-68fa524c4d3mr3862196a12.20.1780725850889;
        Fri, 05 Jun 2026 23:04:10 -0700 (PDT)
Received: from great-eastern2.home (public-gprs207019.centertel.pl. [46.134.147.236])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64e2c810sm4593197a12.9.2026.06.05.23.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 23:04:10 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ 0/2] btio: handle error from broadcast ISO socket
Date: Sat,  6 Jun 2026 08:03:46 +0200
Message-ID: <20260606060348.2240980-1-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If not handled, server_cb() will be stuck in endless loop of calling
accept() on the socket.

Michal Dzik (2):
  btio: handle error from broadcast ISO socket
  bap: log errors in BIG sync

 btio/btio.c          | 20 ++++++++++++++++++++
 profiles/audio/bap.c |  5 ++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.43.0

