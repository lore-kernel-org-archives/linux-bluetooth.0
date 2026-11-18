Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031933;
	b=MPHnSEloV7LhkHh2/XAu028ax/LUUculecwbYFi572TCRO5rwcHDB+9ooHGTMvOX3/g8
	 +FcomdUaeqZGp7TAHffVFqXjAuhxZP9fbCwxgwJHBH8UX6GFf4tf8Gzm0zQvwZFD6g6bQ
	 iOSr0n+pRC7s9wnadr6Ry9r50C7/HibXjH+3G0CbZgpDqC+5wpDg65PTzY4cJO8vdJQ3s
	 ttYEkpdc/PeHzn/0ppvRGV84yyrCuLm9ThMgkRawAv+F4oNhRIEOAEKYUGrtKJ3gpIqtU
	 zRothHLvtlBUhLQanj67B/kBEIkALR3ilBXUTsJPssjgZhUGxdChYHWWDJIO6gEwkNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
	b=JkQj9jcBcY8uTj0AH8TnfIbGSPSD7/FLGDu336nHvIvSEuto1fuqi0mzfacyafM8iKvR
	 VL8I7p+LAZli0xWCxSc9O44EgPMJYg54ENKn73C4lfLJxnN/7V9JxecvVRyhNXzMmiG7E
	 dXnqZJw4lIBK9chAgJ31LedXL7eu6lnaGyiiWss+QXBhTR5pr5EAD8FeW0EuQcm993dey
	 d+zNrJkMTdHpmAe5JWowZ+hMHmzLUQDg/iy4l1QGEFK3OrmdMJYuPsR12NX0wjlNq7QSM
	 VfumiOJiJu2bYoQM0vpDYGBWhJw8j2FCa6LcesKmad12YZWGWI1GC0zE6xKGlJh98qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="P/TZxlRI";
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245160A2602
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2245160A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P/TZxlRI
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7d2d18f1bf5so955556137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031932; x=1795636732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
        b=P/TZxlRI1RLe+6r0eQ5H33AmJzBtQP9ewNAhPttyziLv9GwGLIVsW4Tc6dORExHH5q
         5hhYsUklS6sxIx8iWf2KTQXt6QQQBPgv5CpGnz/ban2UTKFIooaFnJTQYDmVIKDMAe2L
         iApgkq6trfdN/JczGFrppIC+yVw9FG6SVbvuO4CvFqTU/LAsW9qXJtkG28I2gVXzU0G1
         3yld4OU+po9D7CDO8FJNFjfo6GvR6jTuYRbZ7YxRzoJF4TqnP6pvgcuejnTnQ6YTsB+e
         qFZueBYuPv6yQpEidslt4N9x0O6ACyliLQ26I6Lf86wDE+o7wAqY5z1T43iDmvowiYyl
         eArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031932; x=1795636732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
        b=qhQX6GRWaSqwcjgHkC/zdFexVq9C7+Yvbipu9+NyBJ4/CAfvGB2FwUH66lKSAsb8Yy
         bOQLqGj7RjbDEhubBCdqN5iIvYrJs2HtKyQr6vrC3Sdk1ZES6wzVzgnmJImvJKw7unsj
         1DBbVG3SG3MZDncR1XG/7L0n5pNsooerTS7aPYlUi3ILMDemlEQi3DI64UFF3N77bQvf
         f+zbfieB5r5VkECI7G+25AsiDGGBwcpboVRZTFyrFqrmrWUZteBZYZdfXr62TtxRDszK
         7/TZZWqdVVHe41dpwn8palbzGYeO92FZTKtGUJ0U6DzRAj+/sKST/wJcdYRV0aBh9aYN
         RlYg==
X-Gm-Message-State: APuU4Z8055YdYLcjNNSFixldVY2Srj1pwToYFMBruME5Jtt83SRGvyAM
	pGUMbJuLHsxmcgBvwo32uNeRrMYdyPgAb5Aw7c++TShb8su5YIxdnpfaoNHLDMjk
X-Gm-Gg: AYBFou2h4retrepL0kkzFtAQ2t2Z9EZGlw4C+F2TLR+DuCZ4KfLbs5J5UyYVtxR7fRC
	7zyxgmtC/g0mW/qPVWJlJyTp+CbjNXpSMpbeJn9VPNiXq/inNV8credMubsPOdrk7MdneN0kFjt
	l/JI/CC7Breu6aJm+Q+fMI4k15kCHSwHDT4X5hhDIN6f5lRYXs3jcHsAb97IjSZLMHlNowT+is6
	1SuLQyhjjsNLM9IVlKGVIrapqQJK01YKL1I8cYu+YLehg/0+H1cxo/Ai2eJ5tNv3sTXlc1NP+06
	DehvP00u/A9zUsfIf8+dp1qmvey7oJHLT1SQCIZkxHv6AOESCWRnY8YWEihw53sSe9DszrA2F91
	E9lzxZ3nqtIWnbOpWajVL3X90awaWpdMIC/q+DFfO8WsK6ip+FcXsumrnDsPLXUGW2sagEJdbkC
	WbBBoKq28nwhltlrcLw3XNesn8dFlN3jWtx+vtjIrEuuHsQ679GXG5X2QXzUf9g3l1RCj2xtMxZ
	GN1pUlNmUR7rju5B4X3NK/2KTPmOstjaIA58cUzpj60582gDIJmDhSHMYBexAnre+ErOrG28T7h
	d9K/TXEK+Wswhx2SS+7bVlKVK0XCbvYJ99vCRJ5pu/4Wm4Y0jTnQekhwVeFUHOAmvONdR4kyuqu
	qcKYIQazruZr0SbMuYJUNHqhEC/DWuhLjZyPeeo7Mpy3ZXwY8Hw7hUXJYj6paYlMrmyhtUVcsIv
	XfH34=
X-Received: by 2002:a05:6102:6f08:b0:7d0:5688:f507 with SMTP id ada2fe7eead31-7d6ba3e4955mr1251422137.20.1795031931981;
        Wed, 18 Nov 2026 11:58:51 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 04/16] shared/rap: Subscribe to Ranging Data when a measurement starts
Date: Wed, 18 Nov 2026 14:58:32 -0500
Message-ID: <20261118195846.393710-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118195846.393710-1-luiz.dentz@gmail.com>
References: <20261118195846.393710-1-luiz.dentz@gmail.com>
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

From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>

Reading RAS Features subscribed to Real-time Ranging Data whenever
On-demand ranging was not configured. The subscription also arms the
5 s first segment timer, and at connection time there is normally no
CS procedure running yet, so the timer fires and writes 0x0000 back to
the CCCD. The connection-time subscription therefore only adds an
enable and a disable write that no application asked for, and a test
that expects the IUT to enable Real-time Ranging Data only when told
to (RAP/REQ/RRD/BV-01-C) sees both. It also subscribed to nothing when
the peer does not support Real-time Ranging Data, although the RREQ
has to enable On-demand Ranging Data then (RAP v1.0 4.4.2).

Subscribe at connection time only for the configured On-demand mode.
When StartMeasurement() is called and SetRangingDataMode() has not
subscribed to either mode, subscribe to the configured one, using
On-demand if the peer lacks Real-time Ranging Data.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap.c |  6 ++++++
 src/shared/rap.c       | 28 +++++++++++++++++++++++++---
 src/shared/rap.h       |  5 +++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index f1717d932eab..2d8b1a7a1364 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -843,6 +843,12 @@ bad_type:
 	if (settings.role == 0x02)
 		return dbus_message_new_method_return(msg);
 
+	/* Nothing is subscribed at connection time unless On-demand is
+	 * configured, so subscribe now if SetRangingDataMode() was not called.
+	 */
+	if (!bt_rap_ensure_ranging_data(data->rap))
+		DBG("Unable to subscribe to Ranging Data");
+
 	if (!bt_rap_start_measurement(data->hci_sm, data->conn_handle,
 							duration_secs))
 		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
diff --git a/src/shared/rap.c b/src/shared/rap.c
index 1c4b5239e1ba..bc6f133b5da9 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -4712,6 +4712,28 @@ bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
 	return rap_subscribe_ranging_data(rap, mode);
 }
 
+bool bt_rap_ensure_ranging_data(struct bt_rap *rap)
+{
+	enum bt_rap_ranging_data_mode mode;
+
+	if (!rap || !rap->client)
+		return false;
+
+	if (rap->realtime_notify_id || rap->ondemand_notify_id)
+		return true;
+
+	/* The RREQ has to enable one of the two (RAP v1.0 4.4). Real-time
+	 * Ranging Data is optional for the RRSP, so fall back to On-demand
+	 * when it is not supported (RAP v1.0 4.4.2).
+	 */
+	if (rap->ondemand_mode || !(rap->ras_features & 0x01))
+		mode = BT_RAP_RANGING_DATA_ONDEMAND;
+	else
+		mode = BT_RAP_RANGING_DATA_REALTIME;
+
+	return rap_subscribe_ranging_data(rap, mode);
+}
+
 static void read_ras_features(struct bt_rap *rap, bool success,
 			uint8_t att_ecode,
 			const uint8_t *value, uint16_t length,
@@ -4771,9 +4793,9 @@ static void read_ras_features(struct bt_rap *rap, bool success,
 		return;
 	}
 
-	if (!rap_subscribe_ranging_data(rap, rap->ondemand_mode ?
-				BT_RAP_RANGING_DATA_ONDEMAND :
-				BT_RAP_RANGING_DATA_REALTIME))
+	if (rap->ondemand_mode &&
+			!rap_subscribe_ranging_data(rap,
+					BT_RAP_RANGING_DATA_ONDEMAND))
 		DBG(rap, "Failed to subscribe to requested Ranging Data mode");
 }
 
diff --git a/src/shared/rap.h b/src/shared/rap.h
index af4fab057e97..7ee51143c0ef 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -322,6 +322,11 @@ bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
 			enum bt_rap_ranging_data_mode mode,
 			enum bt_rap_ranging_transport transport);
 
+/* Subscribe to the configured Ranging Data mode unless one is already
+ * subscribed, falling back to On-demand if the peer lacks Real-time.
+ */
+bool bt_rap_ensure_ranging_data(struct bt_rap *rap);
+
 /* Initiator role: stop receiving Real-time Ranging Data. The GATT client
  * disables the characteristic CCCD when this is its final subscription.
  */
-- 
2.56.0

