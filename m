Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181903E1D17
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933307; cv=none; b=bg0yFEPLAvbzP30SYTLU+gEazcIdpRy+1waFpBEx/XtV5QYoOnjELNP8450Bq5y0Zmop/yg4YKqFbjecM6siXP1FmgvCy6RTIKv4zO8rh+pIfEBRqJRGpBrOAi5Jf0qLvfnoFzEWQiNMUyqDrODHhBKz8yN3+MztQBqMFXe5TQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933307; c=relaxed/simple;
	bh=3AipI2MlzAHC6jkq28VnCJ5eX3cN+gzsL91ZRzC3US0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BD4vEWiX+o3w1a43aiYIBmoPuwsazX9p67veYPuNIZ/pPfhC0Gf0riHxiYGQNHIV2Lh1+CsUf+WOCXRH8QwrNDsfGbAgegO/t9+CqlTlINroV60w729r+aS7ve1b6adJG3NikSZ2tQzm9yegS6THEkotQgp6Kkb0F0VCiZaakrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCY76ig6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCY76ig6"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso810648a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773933302; x=1774538102; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfnVnho9KwSbFPvatI82WAt8OGnoz9YZWP61wo6omOE=;
        b=VCY76ig6nZvuwr9km+tN0Je1rSmWZ3gQ3eD1gin+vPlpBXeqogV+0gLwa3wrchy86C
         upkeJDrtQ7Klt/CQzvTVsWi+ePHCiHM4re9Jn+TjWbvyvpX4O+okDstrixouJBBWJBbT
         SWHbCobaFbNM1NZpksXrb7hz+cXmaAB6SuwzGFkx9zPurGza9nelRByyZRhEuPq7L7mZ
         qL9U8/0whnDg528wCR7YRYl5VfCedO4Fgpn6oN4lduW/UQlo0HJwUWM7Kd+XYrr2vgzf
         efB8PQqqfT7r+w3ZOMMLk/xP92bPazkAOz7ugsrkWT3Y0n6PNe2RxDCctjdcaPblXoQ1
         YVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773933302; x=1774538102;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfnVnho9KwSbFPvatI82WAt8OGnoz9YZWP61wo6omOE=;
        b=UeaIo7LphRwRLrsDX5XQRXiA4WdpzWh6Tzy1VWp5cxcxqvDDai9B/wxvC8vQN9eQFM
         MJUYcffamJ10IZjUtEuvdr/OfVftG+uBoUQCnFaohINU8f02gdfDnwhicJ9VohI3MPPc
         1d05GvDOWqHCAdqSsWEoN0dMqF28QYOoFl1bI5ljg6zCtVsb/uzvypoZBC6kLd+HWwEE
         E8QjPI5qWF0eSkg2CetM6mJPvrZQxxwpHhdRfk6pffHkRAHCvyaJ1OWNuEahQFKuap/Q
         A0BFQuwIDUbCZVfEZnS1WJF8AuPyLc1XGKTd8nv96gAPde88ytLu8Etr+yOe3Jg9/w3C
         2J4g==
X-Gm-Message-State: AOJu0Yzxx5ernT8BD5IuROwFCJGmSWz10HjuJqAkZVDEkr1jz4D8YUpH
	Xb4uhTtoiroHDCsW8Zzm219+nehIBDOn5nGhZieRvK4NILl3r1P9V1vo
X-Gm-Gg: ATEYQzwB40NyzwwTGM70VCqeyziBYz3+XpNAWfcRPbwdpWdJ42a6wXG7ahb52jPETIv
	0xMZyDLiUjzm2e55rqW9Is2+8SERjsyHIjk0iL6YMXmewpvXLHl5pcEO/iOYXdwg4r+tJLr9txB
	nbTn29wwAivRiaoSmoMEoPZE6uYOYrCoC88cE7xOfMW1FfkKgZHGs2YGpUJ+0t+zoZREZEMsy43
	f2nnGt642KobDwweCU+gBWFEs/FA7l/5IemR0drRBor4ri9PjFHXIhEHyEbdCofllNa/5ob8GrA
	BjLTMDlq5n+Zcej/zkvx2HtSOZJ7BCWMAPIbbo14I/wBlPV24ujl5orNwQ+XfFzgfoLlLUpU2Rs
	nwjs9+Ndnraexv0s6Fx/tqHgDlQuXA2E4BB0ykI+kUecm1luKJXcUEvU6jyHIYV+dhMLy83N/mn
	TOsStJNgX6lREEJxSWJRrE2UivHIydSSzXUrUmFQip9g==
X-Received: by 2002:a17:90b:1fcc:b0:354:bda7:8827 with SMTP id 98e67ed59e1d1-35bb9e6fd93mr5999286a91.2.1773933302174;
        Thu, 19 Mar 2026 08:15:02 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bbaf8bc74sm2035875a91.11.2026.03.19.08.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:15:01 -0700 (PDT)
Date: Fri, 20 Mar 2026 00:14:58 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() to
 prevent infinite loop
Message-ID: <abwS8q6yvVAGI-ci@v4bel>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

rfcomm_apply_pn() accepts the MTU value from a remote PN (Parameter
Negotiation) frame without checking for zero. When the remote peer
sends an MTU of zero, d->mtu is set to 0. This causes the sendmsg
path to enter an infinite loop when fragmenting data, as each fragment
has size == min_t(size_t, len, 0) == 0, so the remaining length never
decreases. The infinite allocation of zero-length skbs exhausts all
system memory.

Fix by clamping d->mtu to RFCOMM_DEFAULT_MTU when the negotiated
value is zero, consistent with the initial value assigned in
rfcomm_dlc_alloc().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/bluetooth/rfcomm/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 611a9a94151e..f9b428b1f1c8 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1423,6 +1423,10 @@ static int rfcomm_apply_pn(struct rfcomm_dlc *d, int cr, struct rfcomm_pn *pn)
 
 	d->mtu = __le16_to_cpu(pn->mtu);
 
+	/* MTU 0 causes an infinite loop when fragmenting in sendmsg */
+	if (!d->mtu)
+		d->mtu = RFCOMM_DEFAULT_MTU;
+
 	if (cr && d->mtu > s->mtu)
 		d->mtu = s->mtu;
 
-- 
2.43.0

