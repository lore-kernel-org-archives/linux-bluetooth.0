Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E7621CC59
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689770; cv=pass; b=so6A73TP8Q6ku6YmKEuVjGpPOPsnuisPBkTBvftzeonPgM/RdUoUmUzxSD0Prkvpask8hqkuqjPPkRg1asLSPa1VPuh9WtM8nrCjVhIAHgXfEQRIYObslqZdH8FJfMpa1YPF2h97G273TrXVaOvt4UdXbaSACMffQE8Qorf/3kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689770; c=relaxed/simple;
	bh=+SYvN7Gzao7QWaxlIRHzKY+fJ1QGT1tZYK424Z9ntZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFFCVscTH5q73qoyhJ4KaYsAai1hnEQ8J3U1BVDXRSSRL46cS+zks45OYFBplYKcB8RhRsUnkB9CSx8QMb5oy2wAxPXdz56PvWQ9NOTcSblpxgq9xfoTLHDkC9KTWWx2PqgbJPo5WqwoJ8RHHdDYltWaBN4gbOtWKxpssEtRJ4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=PrPjaOeg; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="PrPjaOeg"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::dc01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hmCVp2SMMz10rS;
	Fri, 18 Sep 2026 03:02:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789689762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cc6zIfz8/G3AjgpLhBdijWBuMX8pQ3IzircyjM4lKks=;
	b=PrPjaOegNm/nD2SDGYicXvjtVrdDBNrem7EFu0VnS/eNbw3DWqgdxCRC0PLp8QMYJOFawq
	WSopV4YEwott4h8SjFx9IfbBxzvVI1KHbF7ldNcz250D38bTSAfwcfFYzSAnCgfFuS6HHd
	9RNOuHv4n3yFXQeuA3w//2m00ZwyI7E=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789689762;
	b=lXAHzkPw37ZhPbmU1E9+AL3cqWedaZfc3pUKuFkdQK3H9FEA+JFal49ne04dWsoJfx2e/Z
	2K2Ssxp65ZNCwpmYX6zJekFGqX2s3ZQ8hOCDUHq8D3HGuavS/ptBeYTP2IPb0L0SG8Fb4L
	4sci3DrQ2ipzB63hCy01qHMopgBLSb4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789689762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cc6zIfz8/G3AjgpLhBdijWBuMX8pQ3IzircyjM4lKks=;
	b=J0+3XVygdFu5Mtbl5mhFlda1XBHlRAsFBxA9BXoa8R15tzyiFDilw8z5vCtmRwAR8wztRL
	+WB+qemSZNyx21T4KT8NE2iwZOkMUfJnE0quc/4kiU8zgzKCjw7So4HBiZNkSbpXCiPZ9F
	YJPaReq3wYxOzwlVsYb68FtS41EI+SA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/4] device: Remove unused central field from struct ltk_info
Date: Fri, 18 Sep 2026 03:02:27 +0300
Message-ID: <4d30c78a719d9da058a36a17e679c785255a47b0.1789689632.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789689632.git.pav@iki.fi>
References: <cover.1789689632.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ltk_info::central is only read in btd_device_get_ltk(), but its
only caller in csip.c does not use the output parameter.

Remove the unused field and adjust btd_device_get_ltk() accordingly.

Assisted-by: opencode:qwen3.8-flash-next
---
 profiles/audio/csip.c | 2 +-
 src/device.c          | 7 +------
 src/device.h          | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/csip.c b/profiles/audio/csip.c
index d766c3da9..bbd9e4ffd 100644
--- a/profiles/audio/csip.c
+++ b/profiles/audio/csip.c
@@ -328,7 +328,7 @@ static bool csis_encrypt(struct bt_att *att, uint8_t val[16])
 		return false;
 	}
 
-	if (!btd_device_get_ltk(device, ltk, NULL, NULL)) {
+	if (!btd_device_get_ltk(device, ltk, NULL)) {
 		error("Unable to get device LTK");
 		return false;
 	}
diff --git a/src/device.c b/src/device.c
index c140a2e36..443fbbca9 100644
--- a/src/device.c
+++ b/src/device.c
@@ -163,7 +163,6 @@ struct bearer_state {
 
 struct ltk_info {
 	uint8_t key[16];
-	bool central;
 	uint8_t enc_size;
 };
 
@@ -2147,7 +2146,6 @@ void device_set_ltk(struct btd_device *device, const uint8_t val[16],
 		*ltk = new0(struct ltk_info, 1);
 
 	memcpy((*ltk)->key, val, sizeof((*ltk)->key));
-	(*ltk)->central = central;
 	(*ltk)->enc_size = enc_size;
 	bt_att_set_enc_key_size(device->att, enc_size);
 
@@ -2156,7 +2154,7 @@ void device_set_ltk(struct btd_device *device, const uint8_t val[16],
 }
 
 bool btd_device_get_ltk(struct btd_device *device, uint8_t key[16],
-				bool *central, uint8_t *enc_size)
+				uint8_t *enc_size)
 {
 	struct ltk_info *ltk;
 
@@ -2174,9 +2172,6 @@ bool btd_device_get_ltk(struct btd_device *device, uint8_t key[16],
 
 	memcpy(key, ltk->key, sizeof(ltk->key));
 
-	if (central)
-		*central = ltk->central;
-
 	if (enc_size)
 		*enc_size = ltk->enc_size;
 
diff --git a/src/device.h b/src/device.h
index 7683be82e..7c3f45333 100644
--- a/src/device.h
+++ b/src/device.h
@@ -151,7 +151,7 @@ bool device_is_connecting(struct btd_device *device);
 void device_set_ltk(struct btd_device *device, const uint8_t val[16],
 				bool central, uint8_t enc_size);
 bool btd_device_get_ltk(struct btd_device *device, uint8_t val[16],
-				bool *central, uint8_t *enc_size);
+				uint8_t *enc_size);
 void device_set_csrk(struct btd_device *device, const uint8_t val[16],
 				uint32_t counter, uint8_t type,
 				bool store_hint);
-- 
2.55.0

