Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941869;
	b=N0a3KVH3+sorTYAr9FJKgqF9HEtOIlq9kFPNRnb6zFUeFO/ClECn1AwoU59hNHTD1T64
	 n7Vmwf/ILgPy/t/z1erEytcrfxIYuXVvA3Uu9NjN3/uce+56dhhJIn0c0t6uKzbBsJ5Kw
	 DMynPxXlcoGk8eApPDhe45MgKMFGAtzBYqS5GKORuXqiw1JluvdTl7cYDQfUkwIcY8V9h
	 mJGZQ3KkfQgWIlPCFNelK0cAJf8+AgUyy9FfrK2csj1rx4ZOowJxo4AGBwEyqrZ6P/GZp
	 Vxrek3UVcKCsBFqy2xUs98uTtOVnHZFDmV7sOygKZDXGwW5v68ilGqJg5j8UN6GbdSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xJATwFXwkaEep7XjHcirvvESl6tIqq4orm4NGLK1LGA=;
	b=IdFaknQyl2bg6nGkPafi1ubDX9CwZxHDijnUJXiVqIYczu1KuUdyFdJy23OnW7eUxWOg
	 8pDw9udevjD/+mJnlEhA9iHsPZjneRJBZ/r0tSSlR2vyKzJuncUi1sjmwoFiBLSkSX358
	 mPzGNeNlYxRv4VzfqM3d4E1W1B+FIn333CamXtZ8MiEhI+LAxefOCExZrZP847x5/GlNN
	 lEAmubxIarwdpjz8Qd8JMVAx3jdz1BKmAN8vclAYzKDreodtu4ribSfbrtiiqW2Ko2hD/
	 UbAPFGFmbVGHIkwARn8pvqAHh1uHfYytRPn+esTcqw1BeO6wumS+YmEWu50hbyd1O5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oEilsbc3;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB6B606A338
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAB6B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oEilsbc3
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7cc53938a8fso82431137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941868; x=1795546668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xJATwFXwkaEep7XjHcirvvESl6tIqq4orm4NGLK1LGA=;
        b=oEilsbc3wGGbUn1O9B4pdKt7KdtkzIkrLzbNpUprsk1p1ripco8Q2ERYxDVUppaZjT
         KfwoEAjOOBHabVKQvcDCiTZmPIw2NVw5pucF3ItCHTYMF/UpXPFxLCXQRVduh1mPbOta
         JiYEzWJebg4NKFhj5bEGGzqeq2FTN6qXrblOHuRZWkQSzR9H2oa8lP7+jYNhlFVjw1Vr
         xUih/haifLfpSWvrYhkqyQXOCk2gHGMU6XNT8bngnjpuZhAsKkYLbCeqpIlLH3kZVwSl
         20i/BN5pZBrjRXyEKGwwFDSZa9eLzATYM/JsWFwUeYGs9eDxvWrgrGs9noTSgCxVeF0o
         QC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941868; x=1795546668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xJATwFXwkaEep7XjHcirvvESl6tIqq4orm4NGLK1LGA=;
        b=S0OXvWvpP7EJvLvjsi02t1EoTKxh6N3zt1PUQ6Moyk2+p2QErpoyEpieqSNd6OMaWF
         XiEdBeGvrxEmOMwVL7KiktTI+psN28Y7N3c+ZttvuRn51iSdjDgb5CIYrkf/Pz/SpjEK
         W6Rb9rwXI3xAkHOxNVZp6JvaH+VvwU18qFbbT9O4F6MvAy/Qq6ITcHtPG1myaMXo3GL9
         SPiLMdiB/9mKNlA3J7/7EJv+kKKX1YMoT6JvSf5RfESO6PO3gerBeUougEEHgYmTJMiQ
         JqH8HuO2RLKXvLHfrsbnngU8HxFVEiIlyJJxILxM4mOM7bnVXOD5iBUoDyAPn3eXkQTX
         mYLw==
X-Gm-Message-State: APuU4Z9IAA2uQshvIVGLR8rTjD0LQv/A3zprMxM+Zdp3LoNBEtQxRina
	y3HJkgOeojL/Kn2BrbUxncMVJo/Bl+EafLwQ0y7E34grdKh90Adeu5Txjpm84Q==
X-Gm-Gg: AYBFou3sArFZ9UnDvVUHWhC9f07Wo18/4am5/EbiVtVccNWm+Obh4HNoG9fsegXl6pt
	pWVKPCbTNhCG1B6bbSScDHd+FpH/+r6A2uxybV/SSbZkh6jhBq0RpqW4XJbAYXliOwnDDIdb+tL
	2m/Ou3h1iKVzmheqHXj65988NE79rup+fOGnUh+qygkNjs6YOejN1VwL6zhV54BM0Q1OfjOd4im
	GHYni5t+nh/jJZGv3Ta1IZ1z8siMpwSHO0YUzl+hpm2lNdGDye7mDr5NkJeAh+gChqvU19OJeVn
	wU4Z/B0ZiAMOLVudX42BmiacuxbN7vUCIvuLaMulU0P6QYPr484A6a96WDJo5xyGHfllUNt7TX4
	upb/E77Ar0nkA95hvTSkIEyWOK2zJOZVsv6RFyVrC6457q6nqasCoCQWptl0WEZskrrM6gQo4sy
	VcdHBkuVIP2o5wNDA566FTa/ElQ+UUwP9qnFYfdkJ+ZbzqoqcfIYqXZmwXZqjyaMlyxnweKOZxn
	Mg9jbHmjpbbnlbifJp3bDtjUV7YZ0UFtrYNsRwab1fuMRpB0R2JGiQsNQ4Jhlw3gZ5eKgTkr8Ys
	60FDQDVxkuWM+Gegh/XWAPAQrTAJJhJGqtWWeU37u0sZRPvY40m1jgsn+ie/d9PFYPxCKR209rH
	XriRa9dGeITaHuuII+ryupY/ntCO9tRA97H98KUTIi06rMyjC6k5GOgbLHiALsaPHUeauSpqFa3
	f6tGw=
X-Received: by 2002:a05:6102:548e:b0:7d2:cbb5:71f9 with SMTP id ada2fe7eead31-7d64d6ed863mr5944566137.7.1794941867637;
        Tue, 17 Nov 2026 10:57:47 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 10/16] Bluetooth: L2CAP: Don't use uninitialized EFS in l2cap_parse_conf_rsp()
Date: Tue, 17 Nov 2026 13:57:31 -0500
Message-ID: <20261117185737.3758255-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117185737.3758255-1-luiz.dentz@gmail.com>
References: <20261117185737.3758255-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The local EFS values were copied from an on-stack struct even when the
response carried no EFS option. Track whether it was received.

Reported-by: sashiko.dev (linux-089f015e-6251-4fea-85ef-7d6761e8c457)
Fixes: 66af7aaf9edf ("Bluetooth: EFS: parse L2CAP config response")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0d4f3341bd47..7bc6f9797ef8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3892,6 +3892,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 	unsigned long val;
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	struct l2cap_conf_efs efs;
+	bool remote_efs = false;
 
 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
 
@@ -3947,6 +3948,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 			if (olen != sizeof(efs))
 				break;
 			memcpy(&efs, (void *)val, olen);
+			remote_efs = true;
 			if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
 			    efs.stype != L2CAP_SERV_NOTRAFIC &&
 			    efs.stype != chan->local_stype)
@@ -3985,7 +3987,8 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 				chan->ack_win = min_t(u16, chan->ack_win,
 						      rfc.txwin_size);
 
-			if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
+			if (remote_efs &&
+			    test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
 				chan->local_msdu = le16_to_cpu(efs.msdu);
 				chan->local_sdu_itime =
 					le32_to_cpu(efs.sdu_itime);
-- 
2.56.0

