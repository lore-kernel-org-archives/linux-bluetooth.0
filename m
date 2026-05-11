Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42664425CEA
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516708; cv=none; b=d41oFXEWHBfuDKX6C7HD49w0hUuZ5Z/nLumjZEvf3TjOu6wg7sA155ZUQKhgFN7W/RhEOtNbmjgCwRHxRZFUCPlGby3FLTiBroXB/ml0moTIVwloiTQxn4mDlDDAI7+sSlfODCqHQoxPUGH9+egZb0sFOI0nU22e5NI+mhUcdGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516708; c=relaxed/simple;
	bh=FGzSzfWC9sz+oCltMa3ZGcp+SDV7JZRdQhYP3qsB/FQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aXElnVOpkEH94Q6gC3Rg7L5YmJ4TkzVTbI0UsXzbK4yBQck1mCF7vWfRiTpU1oQzDxbo/dj903oG0pyG4MpZ+kyHL1lyTwle3zrBh3q2tSSZ/4bAp1vAlbD+acYmVgd2B2kMgZUPPsKFrNFXgpbfYsMG6I0T64s49qPfP+tJ28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tD/afA/U; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tD/afA/U"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5751e12c524so1556530e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516706; x=1779121506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yODhcNs8aLHG0+ZDqjLHJ6532FIe90ZRKHiFwxX89c0=;
        b=tD/afA/UDQKwq4MOQHPNysehcSVBGrk8R2cVFMaspvQTJHeP7wdkdqpXPRW/n/wZrH
         VV2uh36mDWhTPNZxsxbPI8fUxwh5CE5aYdQBHTfSsrk72rTVxjO7Aslb6ywG6axqyR+t
         HK8uG+J1oUHA90oMuLie1QWoewkamsqdq+FQYXrDGQvZzmhBh7Nx0l0L0e1CLhLt2+fs
         rbep0lVd+ZkeizmOlH1Di33pmdIVZ9TtiKfj1Xira14bmdjZk/lF4Sr2kIQWRH4nk3dQ
         ZeObZgC9DIt1ukHi1UaBsisFMU16/HrgkAGeQO3h3V8jQImSBP+9vm11Jjqms8Bmqqtc
         rB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516706; x=1779121506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yODhcNs8aLHG0+ZDqjLHJ6532FIe90ZRKHiFwxX89c0=;
        b=b61vmvJjAuCy4zMLZOv9CPP4arJaHWiSdjI2Bn0OzK/rl052Gboch6s5prkeu0xtW0
         2tFg7ZWhLaQYcKmqUMIAsiTgRrIS4eaBZuQVC9uVjNI1GIHD8N2m4gRKZCLy0VrDL7/3
         frUaep2Ds5JH6bltxVyjubNYsLkMzvpv8SLX9kaYjaerMIHuV80SB28/s7AeP6PZh+L8
         bLolam9b76Vzd+TphHUfkf80Lm05+sH7on9Zwqihk7/RQbMF+ExT1SkN1N+2ZOw+NDlb
         M34A821QRtNRkfwyBLM4kcv6xV/xmYTung9OnSnJ/d3jdBGlyst24b/9XWwyj900vwrn
         QkxA==
X-Gm-Message-State: AOJu0Yz3LjI6bnERAno764niFFAqfUmdEFq0lUXqNxTG3FnfMCBBtOiL
	N+QRcDbnyz15kyNCNuRi5ryCChY4+ATesGKPSSBNhU2rfvLOKK0T080UtIEGEg==
X-Gm-Gg: Acq92OE74OJOHOkElDq1Ccj1v92ace0DFdfWYXj9faX+sEYuoUBQdkGFhDBxjl319Q+
	10NF//Er7eg/+bA0kPkw40W57A1Bl33EIFNmNMoIUMOTtYqGB9G5CJI1ERmqDGdR9eoi9TOGYZe
	+X+y7gCez7Hqubf8vB2JyvXhwkhzcKWevs2yMp0xnRtBnHm6Y0SCofye3J0qYMmNm06Gd6ySDB2
	zvtl6m66M6jbgmdSGn4/jAY1JvMCj0VhfrH+ZWqOisPuiW+yUb0WmSI8F5Dseq9Y+PBLL7L+N5t
	kkxboKPbraFVDOxgWG9wIDsTHcMm1qIw8kN7XdYsp4XKUenOGFFrUun5VLG+D9/CqQV61pe+llr
	TX3gTCn2LiVsmRYKz2nXEifENstSuXg3/xsK6M9+Mejq3fHjn5MgmV/aySutEXAwACjml9M6tYK
	g2lSYZLLxH9Spbt3Q/BiADO6Zcl+RAVjp0amYrDbsuk6e18mWmnuUrZTz1+TidAq2aFYlWq4EpE
	d3R+79nusLdHyrdZQ==
X-Received: by 2002:a05:6122:4f94:b0:575:3b9e:db3e with SMTP id 71dfb90a1353d-575594fb4admr14475953e0c.1.1778516705408;
        Mon, 11 May 2026 09:25:05 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-57586996768sm6213659e0c.7.2026.05.11.09.25.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:25:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
Date: Mon, 11 May 2026 12:24:56 -0400
Message-ID: <20260511162456.657014-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If dcid is received for an already-assigned destination CID the spec
requires that both channels to be discarded, but calling l2cap_chan_del
may invalidate the tmp cursor created by list_for_each_entry_safe and in
fact it is the wrong procedure as the chan->dcid may be assigned
previously it really needs to be disconnected using
l2cap_send_disconn_req otherwise the remote peer would have no idea that
it shall consider to be disconnected.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fdccd62ccca8..71846849e5b0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5293,7 +5293,11 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 			l2cap_chan_unlock(chan);
 			chan = __l2cap_get_chan_by_dcid(conn, dcid);
 			l2cap_chan_lock(chan);
-			l2cap_chan_del(chan, ECONNRESET);
+			/* Disconnect the original channel as it may be
+			 * considered connected since dcid has already been
+			 * assigned.
+			 */
+			l2cap_send_disconn_req(chan, ECONNRESET);
 			l2cap_chan_unlock(chan);
 			continue;
 		}
-- 
2.53.0

