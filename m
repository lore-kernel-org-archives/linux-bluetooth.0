Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B724A0E
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Apr 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713002677; cv=pass; b=dXOWKN8jWmTYFDEFGxZG0Ms7//1XLIyqS5USyd2HvJJk9tBDnWq4lrssQBGUszqrpXa1bELgjL6qG4TvBOcFGIdzXK3/U3Mvck0KJjbrDRNcvLyWxD4qdJzJyXrfy9QXJO4U/27hntIJQmhcwLTodHLyAh2EyLlrwH+1IQL8IIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713002677; c=relaxed/simple;
	bh=4DCVZh1OJJemPdOk31CMVIuliEXT9zVagzOAe10jAuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwhqFn5SWyDOYmOH5ylrzHFKa/X+dpA7F2Vb2O9d6JjyX/4vpfgD1RMA8j0uxAfHh2mVkPfRqdts380803lGpsugV5N6ykJ8ooql5t03KpfKHtITd51w902n27nhubIc8zHKKbb2NiYIiEOJ48BOy8pE6fpKY75gt7S4gQVcDhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=IXkBupdd; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="IXkBupdd"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4VGpv21P3gzyPV;
	Sat, 13 Apr 2024 13:04:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1713002671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0pizIhNiXypBeWMiZA5ANF+4ChFrEWN85HEzM1UCA1c=;
	b=IXkBupddkq3wWZ6S5353yf2ecSvO4dCSMevNbxhpCUvWacEPHAMMmiD/wmI+MLMSs69poB
	cNXFe9WkjVpzteEjun0ey8at0MfQIscYvmMbZ8HacYUbxRSdK4HcGxQ0H95cEqNbrECmMM
	GJWsa1kCsL0BEobheBJg52q5WFBhD/I=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1713002671; a=rsa-sha256; cv=none;
	b=aQItY97xSttYulqch5E5zEj3pEsFeRS8HyGN6DwkQaCyCbcOgvfr7YyU7DHDjmziOojsVq
	aJg+Zx5giWJB/Rb4cZe+U3dxqg0eWzGTd185Ppdw3AZqOX9AcbQ48cR6NzaY7yqA7iWU0m
	yuhLX8tTy1ettuXAWJsCOHGIU5fTaWI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1713002671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0pizIhNiXypBeWMiZA5ANF+4ChFrEWN85HEzM1UCA1c=;
	b=y77AhbnuIwiOJanFI5fRlUAuUKIyfdpMg5cu9m/AW3oV9+d3eD9pPN8SaRSvZ+ClCv3pfd
	xOKBEZCNy1FMyXOMAcUyTFstGQUP7/Oh2gfn2UTQ2lc0DuXZWrmVWI+cizvqo08zwZdB5/
	Iq7s1myle62eGOSAIGAl00ihceuIwFw=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] set: don't modify input sirk key in btd_set_add_device()
Date: Sat, 13 Apr 2024 13:04:26 +0300
Message-ID: <b468e20424d271295c84c72059952acaf65968a5.1713002640.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, btd_set_add_device decrypts the sirk in-place, modifying the
key passed to it.

This causes store_sirk() later on to save the wrong (decrypted) key
value, resulting to invalid duplicate device set.

It also allows devices->sirk list to contain same set multiple times,
which crashes later on as sirks-set are assumed to be 1-to-1 in
btd_set_add/remove_device().

Fixes:
=======================================================================
ERROR: AddressSanitizer: heap-use-after-free on address 0x60600001c068
READ of size 8 at 0x60600001c068 thread T0
    #0 0x762721 in btd_set_remove_device src/set.c:347
    #1 0x7341e7 in remove_sirk_info src/device.c:7145
    #2 0x7f2cee in queue_foreach src/shared/queue.c:207
    #3 0x734499 in btd_device_unref src/device.c:7159
    #4 0x719f65 in device_remove src/device.c:4788
    #5 0x682382 in adapter_remove src/adapter.c:6959
    ...
0x60600001c068 is located 40 bytes inside of 56-byte region [0x60600001c040,0x60600001c078)
freed by thread T0 here:
    #1 0x7605a6 in set_free src/set.c:170
    #2 0x7d4eff in remove_interface gdbus/object.c:660
    #3 0x7dcbb3 in g_dbus_unregister_interface gdbus/object.c:1394
    #4 0x762990 in btd_set_remove_device src/set.c:362
    #5 0x7341e7 in remove_sirk_info src/device.c:7145
    #6 0x7f2cee in queue_foreach src/shared/queue.c:207
    #7 0x734499 in btd_device_unref src/device.c:7159
    #8 0x719f65 in device_remove src/device.c:4788
    #9 0x682382 in adapter_remove src/adapter.c:6959
    ...
previously allocated by thread T0 here:
    #1 0x7f5429 in util_malloc src/shared/util.c:46
    #2 0x7605f1 in set_new src/set.c:178
    #3 0x7625b9 in btd_set_add_device src/set.c:324
    #4 0x6f8fc8 in add_set src/device.c:1916
    #5 0x7f2cee in queue_foreach src/shared/queue.c:207
    #6 0x6f982c in device_set_ltk src/device.c:1940
    #7 0x667b97 in load_ltks src/adapter.c:4478
    ...
=======================================================================
---
 src/set.c | 10 +++++++---
 src/set.h |  3 ++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/set.c b/src/set.c
index ad64fb163..bf35ee403 100644
--- a/src/set.c
+++ b/src/set.c
@@ -171,7 +171,7 @@ static void set_free(void *data)
 }
 
 static struct btd_device_set *set_new(struct btd_device *device,
-					uint8_t sirk[16], uint8_t size)
+					const uint8_t sirk[16], uint8_t size)
 {
 	struct btd_device_set *set;
 
@@ -206,7 +206,7 @@ static struct btd_device_set *set_new(struct btd_device *device,
 }
 
 static struct btd_device_set *set_find(struct btd_device *device,
-						uint8_t sirk[16])
+						const uint8_t sirk[16])
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	const struct queue_entry *entry;
@@ -295,10 +295,14 @@ static void foreach_device(struct btd_device *device, void *data)
 }
 
 struct btd_device_set *btd_set_add_device(struct btd_device *device,
-						uint8_t *key, uint8_t sirk[16],
+						const uint8_t *key,
+						const uint8_t sirk_value[16],
 						uint8_t size)
 {
 	struct btd_device_set *set;
+	uint8_t sirk[16];
+
+	memcpy(sirk, sirk_value, sizeof(sirk));
 
 	/* In case key has been set it means SIRK is encrypted */
 	if (key) {
diff --git a/src/set.h b/src/set.h
index 67177e8c7..2307218c4 100644
--- a/src/set.h
+++ b/src/set.h
@@ -13,7 +13,8 @@
 struct btd_device_set;
 
 struct btd_device_set *btd_set_add_device(struct btd_device *device,
-						uint8_t *ltk, uint8_t sirk[16],
+						const uint8_t *ltk,
+						const uint8_t sirk[16],
 						uint8_t size);
 bool btd_set_remove_device(struct btd_device_set *set,
 						struct btd_device *device);
-- 
2.44.0

