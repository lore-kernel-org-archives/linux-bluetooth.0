Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8767835CB91
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792723; cv=none; b=H8goxM72mypBAVToEpif0uHQXABE+jqSCHo4s6UVsMVAe4CseCxiK7cErt/cg186mug1sHX5ZZxM48zJ1wiopnikbcy5gtu8d8Fv+nvuO6g8d5gS8cxp6G/pqA1bWQimTh2kI3tlRTlYTlIOmguGYskw2P3B8RrjNGxks/mWrEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792723; c=relaxed/simple;
	bh=d1XtK2d8Mg0YQlZbiBQkQFmZucUOwu3dt/ghuzwIan4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/1XhrqdNfh78/TOM75WYYKZvesQm1g5nHnOgwCMIAyq59FDN0PfoftJ8EZnBuVmgptFPokW212ozGB4Y0tL6MYeGTDP3Dr9jE43SeAWNG4g9em9ICIdoWPzkA/2ipGFm4FuE0lYgdhlmiGD0MA8IaZdDEQzCEhRWl44YYSqPDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzSG4DzD; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzSG4DzD"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2ba17c8cfacso109311755ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792722; x=1780397522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9xlWXn5mE7pkm5ckLftzVtrrd/9HAGB+5lP9+i3WsE=;
        b=AzSG4DzDpCE9QQp8LuhhytQJ5KYknvBXQYDChlRfH53xd4+jzzGz8e43ZClyuLElUy
         Kb5fkBdnw0JwTosf0gCrtX9b4z3UlTrI+5B6+vxnr0GR5tLmoNXy6slqti3rMiGL1x9y
         TIrPxOEF5SrTfpYq6s9BeG4rPtjy7vd3lMaVGmacArcNY67NQUIUqU7qgoJDHjDS0Go9
         y+Y9+loy79jGDmFGF5F7gtvTCpN6EpH66WaLhpdL1BhT2MmL24wBr8ME9qvxKkD0jxtG
         ehk8l6/SJjQbZRaTQ06U4WfsJGBqoPwdCEODbpP1M8sxi+lEpk8x2NXzsUce80Czmupo
         mnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792722; x=1780397522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9xlWXn5mE7pkm5ckLftzVtrrd/9HAGB+5lP9+i3WsE=;
        b=qCqfO68hUospO+gkl5EoDrBD1Uqn/A9zrJiQoIHBWGacfYttQG3JwHOvSrOjWb9Ja/
         fuHXW3eYVmoqAsIyRuRVTWx3H4BDKJMfU3Jo5bv/TXhlPh8ZGIM5f/D/oudYyVqMZSAo
         dx+RtEfCR+J/cPUpvmzifaeCQix6UuPGystAWASFvYD87NoBnE+UYh8Helll4ExX6UVv
         uw2yzvPFK+DtDELdQv0RB/VwdqkkVSMNnZtdstSTmuO+7XzVIqtjzILIwrTH0E2oGv4Q
         VaxjugXdVzEOlKm807PN9sGr0i6+l8O+Qx7na/6HBl6appRZ7BA7VOqW40NteRsKQM2V
         nvhQ==
X-Gm-Message-State: AOJu0YzeYCx/bpGSn4fn5uyPZp6dDqbTTmLntI31yAp4VNcujwS7teD8
	0szTHPV3HCAw1e+cBsNd+daqfZV87sZcraf6zy/6tohKO7QGnQduLJeC
X-Gm-Gg: Acq92OEdlEQ7ohijhjQnmZ+4mbMZGkP3iVFXmafb2BpNEZ6cDPQbMmeberUqT/ckEot
	A6LgJK2wi5jsFW7zflO4sovitERXuato5Y3GHS4vAyzFWURwzq0P4wNCzUrnX5542+JiTStNYRL
	PT6whiETyn1lyUu6UM4kYbt2VbliBy3wqtQu4CbmxSloXkO3THbcd2V1MHtbqPZ+xFkK5wWfHAE
	XDH31azPXJRjOhxvfMG0GsVADvsV70JbGGYKnH9VQ9yrVYj/8OAU2m2FXVQPiBIH2nYpHqJNXlg
	UzpAbPKFtld8UBnZHv7M4W8Sn7U8eRL6H9jp6vGPuLyZgcvf6wiiXQdus0r7bF+5ePBUGgTgTnM
	R6f0KFMf43qjn7KvJMoxJWKmFSqlRSnHPzoJH5TBaMlR/x3IdGejTez6Ix3F40q8kRlUTyLSPhN
	JAUeSNld5Bga39mvUAJGeaIraSwY9w7aGn5ur0fM2FiXPZfpccoK+8lucZqKzi
X-Received: by 2002:a17:903:1a2f:b0:2ba:7749:f89a with SMTP id d9443c01a7336-2beb035c500mr190176565ad.11.1779792721648;
        Tue, 26 May 2026 03:52:01 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56b5886sm108947845ad.20.2026.05.26.03.51.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:52:01 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH bluetooth] Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success
Date: Tue, 26 May 2026 18:51:52 +0800
Message-ID: <20260526105152.78178-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_ecred_reconf_rsp() returns early on success without clearing
chan->ident. Every other L2CAP response handler (l2cap_ecred_conn_rsp,
l2cap_le_connect_rsp, l2cap_config_rsp) clears chan->ident after a
successful transaction to prevent the channel from matching subsequent
responses with the recycled ident value.

A remote attacker that completed a reconfiguration as the peer can
replay a failure response with the stale ident, causing the kernel to
match and destroy the already-established channel via
l2cap_chan_del(chan, ECONNRESET).

Clear chan->ident for all matching channels on success, and harden the
failure path by using l2cap_chan_hold_unless_zero() consistent with
other L2CAP handlers (l2cap_le_command_rej, __l2cap_get_chan_by_ident).

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 net/bluetooth/l2cap_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7701528f1167..08c70caf24d4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5458,14 +5458,20 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 
 	BT_DBG("result 0x%4.4x", result);
 
-	if (!result)
+	if (!result) {
+		list_for_each_entry(chan, &conn->chan_l, list) {
+			if (chan->ident == cmd->ident)
+				chan->ident = 0;
+		}
 		return 0;
+	}
 
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		if (chan->ident != cmd->ident)
 			continue;
 
-		l2cap_chan_hold(chan);
+		if (!l2cap_chan_hold_unless_zero(chan))
+			continue;
 		l2cap_chan_lock(chan);
 
 		l2cap_chan_del(chan, ECONNRESET);
-- 
2.50.1 (Apple Git-155)

