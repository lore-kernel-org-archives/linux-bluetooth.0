Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9D35D91B
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012128; cv=none; b=KyntxJbPbiLXO6pUXLdvMe0Im72VFzkwg351zeyffEQTKdzYexIr3Uq96wQ6I2NJzssZ8VXcYo1gEVElJnIz+HeiCapV24ZMJBc86LHlao9lCw2BJ8wWDbIpe29L/qjCweIezjs6MkBwPct/IWKaDFZ+mqs7AyImq/BEs2sveuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012128; c=relaxed/simple;
	bh=/nh8co27MrhVlDeKnQkMaj3e9VRx6HJEZGqAxf/tXhU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkal+hVqadCrJBBl8GDDalWnFfXmGlrul7hrW41Bara7qrVo9Ak9KqpAlVWTTi4BGU7VtL9+hQ2JDCTBUqbphFSPBDTV2nG/nJMqySRDzMpTkuM4+NzO2AGsfsuqIX991WascaxicIwkotqQMgEnH+ndTp+kuj/RRs4Kjv47agQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fX2ZzMwN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fX2ZzMwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706012125;
	bh=/nh8co27MrhVlDeKnQkMaj3e9VRx6HJEZGqAxf/tXhU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fX2ZzMwNoV2W4wtWUQIEhIu3tqPww6Am1upb+ooJZ69eA+batQjn0rRuXlMK6Fn49
	 d+n9US76N8UDsVA3vlwsA9tCByYAwUiBu6MQSktcE53J7CxZfv/oIpCBWy7witJy9U
	 sOuqMxXlM7Ojfg5fOQHpLCl7GFEe89nNLHuHnbjSoraAAGXz/ZPUy7x4PMFoPg0LN5
	 ke3PKh1SRQiT1GOMn8x5C95+Mf5abEUF5h0zsXlxaYaiznE1dTVdr7KSGB7Zm76P7O
	 HUE2FRrRYbhwb6t+9tY4Uc7ZhleJNBOB5M7JXVyDodi1idJS73zgsh36w28osLKgVu
	 rlcb6le9ImGiA==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D293037820AC
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 12:15:24 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] device: Update local and remote CSRK on management event
Date: Tue, 23 Jan 2024 13:15:19 +0100
Message-Id: <20240123121519.523735-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123121519.523735-1-frederic.danis@collabora.com>
References: <20240123121519.523735-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The local and remote CSRK keys are only loaded from storage during start.

Those keys should be updated on MGMT_EV_NEW_CSRK event to be able to
perform signed write for GAP/SEC/CSIGN/BV-02-C.
---
 src/adapter.c |  2 ++
 src/device.c  | 16 ++++++++++++++++
 src/device.h  |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 022390f0d..fb71ef83e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8882,6 +8882,8 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
+	device_set_csrk(device, key->val, key->type & 0x01);
+
 	if (!ev->store_hint)
 		return;
 
diff --git a/src/device.c b/src/device.c
index 17bcfbc49..34f64ca5b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1955,6 +1955,22 @@ bool btd_device_get_ltk(struct btd_device *device, uint8_t key[16],
 	return true;
 }
 
+void device_set_csrk(struct btd_device *device, const uint8_t val[16],
+				bool remote)
+{
+	if (remote) {
+		g_free(device->remote_csrk);
+		device->remote_csrk = g_new0(struct csrk_info, 1);
+		memcpy(device->remote_csrk->key, val,
+		       sizeof(device->remote_csrk->key));
+	} else {
+		g_free(device->local_csrk);
+		device->local_csrk = g_new0(struct csrk_info, 1);
+		memcpy(device->local_csrk->key, val,
+		       sizeof(device->local_csrk->key));
+	}
+}
+
 static bool match_sirk(const void *data, const void *match_data)
 {
 	const struct sirk_info *sirk = data;
diff --git a/src/device.h b/src/device.h
index 8bb38669d..d00c002c3 100644
--- a/src/device.h
+++ b/src/device.h
@@ -134,6 +134,8 @@ void device_set_ltk(struct btd_device *device, const uint8_t val[16],
 				bool central, uint8_t enc_size);
 bool btd_device_get_ltk(struct btd_device *device, uint8_t val[16],
 				bool *central, uint8_t *enc_size);
+void device_set_csrk(struct btd_device *device, const uint8_t val[16],
+				bool remote);
 bool btd_device_add_set(struct btd_device *device, bool encrypted,
 				uint8_t sirk[16], uint8_t size, uint8_t rank);
 void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
-- 
2.34.1

