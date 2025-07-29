Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB014884C
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814816; cv=pass; b=NgnkVCURak/y9Kyq8jQ1ZSNN6LxGQS0oD+SyYpKECV2ss0WppeTvFWSkNuomdguecQmrbsQ5FWwc04QxjLmnlRpBlSy0Y5MbIMPt1bq8Q2JtJHZ2URfTyETNpAwTQk/ADykhUzRJutH0At42qvxnw9Z0D9SHIOPvM1Cns8moAfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814816; c=relaxed/simple;
	bh=0i9+MTkFnQvDUc9akGojXkt5l04XHqyVOW73Xb5GYQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YgD3AtLoZA8U9K+CoqWDJxgR1a9Iw2Lk1ZAKkKA3V04bX/M0vJtW7g/k3Cpsmy0p+NuvtWqMOObG8MaeMfl3kNHdoLjIU4daiHIhOkLxD2snd1tcrfljYAQCI9/qg0RW4WT9kjyRCzoVBCe/QziVaby0Tp+6RwCawdncr8yWCJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GwwbGOHP; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GwwbGOHP"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4bs47m0vZDzyVW;
	Tue, 29 Jul 2025 21:46:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1753814804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iOGL+VGecU3sEbTw9+m7Y2bxh7gzENMRvmXYTUDq4+0=;
	b=GwwbGOHPoKdHrxOc90Rb+WezpAbbufuk3dK0XzIOqpvmA0WeMYWA266p3wqM1vzG7r0qZY
	O4xUF8AAdayV4HTgfZkAwoblNCG2phQNNnNhm+U7UGCb1OD/hPXHVeFVvRUSPMJIxoiHDD
	NCY1mQh2g/UyszA89BFQe+lAZP1onKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1753814804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iOGL+VGecU3sEbTw9+m7Y2bxh7gzENMRvmXYTUDq4+0=;
	b=tsO04HlNhHgIQaitLcseZxDDWRev+m78RHxv40w8/k4Qfh8ID780Y6ivHELprv+YNqj24H
	f0onqm745O8lHTuFoQ0QevguhXOKzqm5FCCffl/BbjKLTiIEMEWp3EO1yDhLm0+iHmTODK
	MBEjf37z28xoEyNMHwJEXeZqhfmuJoc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1753814804; a=rsa-sha256; cv=none;
	b=FCC2WRNGpgVW/EL168tpvD16KTkW8OacvOXMDQl5+P8IJUWUW1ukyYTJPedeFPRM+hhT/O
	GIB2BLxsvPLMTwED+1jn4PYxJLkMtYnySm2EpNnzUAngbPdxdslQ05ChTBoIvbuiNRA56v
	OlPwFbsC+OATaTj+VndC5+QJVH532sk=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ RESEND] profiles/battery: handle reversed ordering of CCC and value
Date: Tue, 29 Jul 2025 21:46:41 +0300
Message-ID: <ccfa6652c4391fbc7d403f3e5208fa1cdfe983e3.1753814700.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Order of batt_io_value_cb() and batt_io_ccc_written_cb() may be reverse.
This causes device to appear with 0% or missing battery percentage,
because batt->percentage is set on the ignored update so the initial
update is lost.

Fix by saving new initial value, if battery is not registered.  Also
downgrade warning to debug message.

Also check data length before parsing it.

Log (Sony Linkbuds S):

src/shared/att.c:can_read_data() (chan 0x7c31eea05c50) ATT PDU received: 0x1b
profiles/battery/battery.c:parse_battery_level() Battery Level updated: 87%
profiles/battery/battery.c:parse_battery_level() Trying to update an unregistered battery
src/battery.c:btd_battery_register() path = /org/bluez/hci1/dev_CF_D2_4D_EE_A2_1A
src/battery.c:btd_battery_register() registered Battery object: /org/bluez/hci1/dev_CF_D2_4D_EE_A2_1A
profiles/battery/battery.c:batt_io_ccc_written_cb() Battery Level: notification enabled
---
 profiles/battery/battery.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 5be78ab14..2f5be48e9 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -91,16 +91,19 @@ static void batt_reset(struct batt *batt)
 static void parse_battery_level(struct batt *batt,
 				const uint8_t *value)
 {
-	uint8_t percentage;
+	uint8_t percentage = value[0];
+
+	DBG("Battery Level updated: %d%%", percentage);
+
+	if (!batt->battery) {
+		free(batt->initial_value);
+		batt->initial_value = util_memdup(value, 1);
+		DBG("Battery not yet registered");
+		return;
+	}
 
-	percentage = value[0];
 	if (batt->percentage != percentage) {
 		batt->percentage = percentage;
-		DBG("Battery Level updated: %d%%", percentage);
-		if (!batt->battery) {
-			warn("Trying to update an unregistered battery");
-			return;
-		}
 		btd_battery_update(batt->battery, batt->percentage);
 	}
 }
@@ -111,6 +114,8 @@ static void batt_io_value_cb(uint16_t value_handle, const uint8_t *value,
 	struct batt *batt = user_data;
 
 	if (value_handle == batt->batt_level_io_handle) {
+		if (!length)
+			return;
 		parse_battery_level(batt, value);
 	} else {
 		g_assert_not_reached();
-- 
2.50.1

