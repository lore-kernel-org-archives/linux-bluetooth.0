Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08372FFDF4
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609256; cv=none; b=VeM1pZMJ961lWcgUmhso7zgl4KnPQfymFRfteOmLodiAJFoGDN6yl+Nj+dBLGunIjHffJDCPvbmWqqsEiEI0yM4fZEY5ME/98kXcRVrLcYhk7Q7hHsitlY+l0uwYjgE2gw4tR9k5HjfsB05e4uiGr0MxYSS1qWpglIIoc9oIJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609256; c=relaxed/simple;
	bh=GgPtwmQN1DwowMW4+XY0X7r57ronczUOkMW8StsPzTk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hLwbLR7ieI3zX3dx5pI4ZfUytUI2Xpq/x2jpv6hgcebJnW2ZHHLgDue2dWvYo5BJdg1pmqzFe1KhViJthnHm95ak0AR1PPTHAPC+uKKzE2z87sWFgXQAs3ZJsXvzmr4VYYve2P7+Oo4UuZ58J3OyPshCHbp58xj4kRSG9YNQuEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhQA26gO; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhQA26gO"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5f9ed174ebcso1248692137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771609254; x=1772214054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dE14VIs0yRTLv9+WcvH3ybx4JdL8W8SqKdTB8apk9wk=;
        b=RhQA26gOcvtFXFZ5dll8/TsrdDIjaYLW0EtI8Yh1OdWEMh0HvKsPOHRd1C/8DDdg6z
         y1AhWM2tXxtA7lgxd4bgvkfOQqtUcg3xQF39nYx6YFCCzhhllp8BDqjKs+Sf6h6onG/Q
         bEZkvJ7Mmz8cp3dfIhDhrWkWwIPoXDi1i1efk0/6MybaNQu+KS9RBZ/KAs/3M9sazACu
         BDO7wjkqophGvWxRmBIysGornQBXlpYuCTjIp9/rJqxuBgWALLRigEfbNlAt64Gd/r36
         hBX49RcYMzbZDQ5h/2xPLOdO4frp1ql2abbJnYZa9TwLvx32yxXNGefMLFrfG3Ld2rrV
         4PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771609254; x=1772214054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dE14VIs0yRTLv9+WcvH3ybx4JdL8W8SqKdTB8apk9wk=;
        b=dJQiyltNzmDJpnIkaZVN1efvORysTyoJKXLuePpxpDxYrJhyAMqAG/zUT8y/Hg+FBD
         yQxlc6UV3tSoWC2UtZQUC5kvmX3fJ9gLXFNXdEFc6ealdhG4SIlyGBZ3+yHuz7fFvuaj
         JX4lVv2DPnkcDauMgdsEx38qLvN4L6853qdnZBL5ASJQmdfCzq19bA13T8tIRSiYVDeM
         ltIw8EYqIvPFC5CrQxhZvxCHWBMld3h151vGXkaCErwD3CM/RshV//UP7nqGY95HAC8T
         LearuZZpTVSLpCNMdnRz4xwBCe0edlMCT6riBuRGPC4N+JtcnpRDx9o1L5DNPB1EeWpv
         ELvg==
X-Gm-Message-State: AOJu0YzAS403Tc8PNBycpiUWE7jyg3Th0m/uePeEcdjH/sWkQtpGyFRp
	DcPCoBGS53pitkOi0eOsUw+7s0MH14vnEknq44XyGa1keJAxRWX+Zfyiki1Tfg==
X-Gm-Gg: AZuq6aJ1erDaX+R13p89u/+2TY5U+rcVzhtvyOVTquRQfR/kXopHlDzcewfW26spWyE
	FpHjSVgbVvdE79yyCO4Uh9TEsLt/meOC+awOqW2KgjQtmywF3WhZ6SCt7MhXunNoyFbEKVbJRtZ
	HE5w0UHrNEvAV/9wte785kcA8eDmEvfgGbvOC//C9ES+cLPixCLcoJNEw2qI4k/3y4r1bX0y2Aj
	FV4bMmzhnucqj6LTdqF0VvhYbBH0mnJkl0WscOKmG9Y0Xt3kjx7NNOS2WNnsplTT65OUigrbY4g
	HSlSqFP2SMOzzfkHQEBbdIGLXanmrRtCYFnZ0a35oMyKEVoQeOgd3qlc9U3uPF+jIZJ8O/bDARI
	njRkCLV1fNg2EU4vPLcb8EBcyiK8IKmqHgxynH6Uti1nhnnjeW5LND7Iz6gzh749nX6ymU+udhw
	u4xMOhTSEHi5niq7E+VTgE/Vv8jgL4Dy0pf5e5QuoV3KbTu8Q8EBCTPoAGbpj51vkMPy2jro1L/
	UmQWPECE7cMSl4ZqA==
X-Received: by 2002:a05:6102:ccc:b0:5fc:6664:bb4a with SMTP id ada2fe7eead31-5feb30d6402mr472633137.29.1771609253719;
        Fri, 20 Feb 2026 09:40:53 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8816298sm195298241.0.2026.02.20.09.40.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:40:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] l2test: Attempt to use BT_SNDMTU if output MTU has been set
Date: Fri, 20 Feb 2026 12:40:44 -0500
Message-ID: <20260220174044.3421300-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With the suggested fixes for L2CAP/ECFC/BV-27-C the kernel shall be
able to accept setsockopt(BT_SNDMTU) in order for an applications
to require a minimal output MTU greater than 64.

Fixes: https://github.com/bluez/bluez/issues/1895
---
 tools/l2test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/l2test.c b/tools/l2test.c
index 7eecf1364492..b085c8d05453 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -318,6 +318,12 @@ static int setopts(int sk, struct l2cap_options *opts)
 		}
 	}
 
+	/* Older kernel versions may not support BT_SNDMTU so don't check its
+	 * return.
+	 */
+	setsockopt(sk, SOL_BLUETOOTH, BT_SNDMTU, &opts->omtu,
+				sizeof(opts->omtu));
+
 	return setsockopt(sk, SOL_BLUETOOTH, BT_RCVMTU, &opts->imtu,
 							sizeof(opts->imtu));
 }
-- 
2.52.0

