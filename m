Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603503EDAA1
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180624; cv=none; b=ougTLh8Or5elGE/dNYk0RxmGC1sZ7+yUXJsNjQ8gApe0/k91ahYAMt1iK7gcFs404kmHId9B4GBkMtG/A72Pmr5xIxPawhkoljsc483SDCv+LYWy4+zwo4+NEl+C57QvIaEUpRwtbXoEiFUoVpZPv5npp6c0Mbd2B151ShfRNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180624; c=relaxed/simple;
	bh=XRXh3GX+M3MEhYWexnDTChAIV6AhrmjZZjjFOVeesMk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=utHPxNAkpzFrsUBs9QDi02psfPEBrEW/6rr4rxpC4E5gkEXpVEHcBOvFwgidQUCB3qtPFb4QLUch84wcg4Bx3X/SiO5lP0WLutCuQnTmK948C5KpMsRmdaCIx20EvrNmdetCT7p42bofgj17xi6ExORaAEn7mCsZBkA6DuyfzuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dyif5Hk0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dyif5Hk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779180621;
	bh=XRXh3GX+M3MEhYWexnDTChAIV6AhrmjZZjjFOVeesMk=;
	h=From:To:Subject:Date:From;
	b=Dyif5Hk0KVZ98KZGFl/Hlmtsqi2bJL1x+aMIXteaGT1uVt/08QswV8K3j+MCgeqPx
	 y0vZV+8bqNJrk6Zmpubyk73hIXvx+z0GBQEDHdPT8eJpLWFJGVzMNirKkYNhs/bGXj
	 c/t75cmi891ikggll1yZl0SlD5L1xMKigJ/caOePYe4lg2CsseusBUKzcEFaYB9LUb
	 DA5Nlb+ogLuTDLSWd0sJ4n+aqq1/VCVnGUylk5od/Pi/Rv61G8Q89ZU9FYjVvrymSu
	 t40bE2ITWn0fODNOQlCI+7HzshYZlM4d3mSp6KASs/8Npq10UecsoaGDGoBXnzQNFX
	 F1cMlaF8IiFRw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 699F717E1299
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 10:50:21 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] client/btpclient: Fix GAP unpair command
Date: Tue, 19 May 2026 10:50:15 +0200
Message-ID: <20260519085016.188744-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Fix unpair_reply() because the device is no more available on
RemoveDevice reply.
---
 client/btpclient/gap.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
index 68e029dcc..a14cd4795 100644
--- a/client/btpclient/gap.c
+++ b/client/btpclient/gap.c
@@ -2174,17 +2174,15 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
+struct unpair_req {
+	uint8_t index;
+	struct btp_device *device;
+};
+
 static void unpair_reply(struct l_dbus_proxy *proxy,
 				struct l_dbus_message *result, void *user_data)
 {
-	struct btp_device *device = user_data;
-	struct btp_adapter *adapter = find_adapter_by_device(device);
-
-	if (!adapter) {
-		btp_send_error(btp, BTP_GAP_SERVICE, BTP_INDEX_NON_CONTROLLER,
-								BTP_ERROR_FAIL);
-		return;
-	}
+	struct unpair_req *req = user_data;
 
 	if (l_dbus_message_is_error(result)) {
 		const char *name, *desc;
@@ -2192,19 +2190,19 @@ static void unpair_reply(struct l_dbus_proxy *proxy,
 		l_dbus_message_get_error(result, &name, &desc);
 		l_error("Failed to unpair (%s), %s", name, desc);
 
-		btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
-								BTP_ERROR_FAIL);
+		btp_send_error(btp, BTP_GAP_SERVICE, req->index,
+							BTP_ERROR_FAIL);
 		return;
 	}
 
-	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_UNPAIR, adapter->index, 0,
-									NULL);
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_UNPAIR, req->index, 0,
+								NULL);
 }
 
 static void unpair_setup(struct l_dbus_message *message, void *user_data)
 {
-	struct btp_device *device = user_data;
-	const char *path = l_dbus_proxy_get_path(device->proxy);
+	struct unpair_req *req = user_data;
+	const char *path = l_dbus_proxy_get_path(req->device->proxy);
 	struct l_dbus_message_builder *builder;
 
 	builder = l_dbus_message_builder_new(message);
@@ -2223,6 +2221,7 @@ static void btp_gap_unpair(uint8_t index, const void *param, uint16_t length,
 	uint8_t status = BTP_ERROR_FAIL;
 	struct btp_device *device;
 	bool prop;
+	struct unpair_req *req;
 
 	if (!adapter) {
 		status = BTP_ERROR_INVALID_INDEX;
@@ -2237,14 +2236,21 @@ static void btp_gap_unpair(uint8_t index, const void *param, uint16_t length,
 	device = find_device_by_address(adapter, &cp->address,
 							cp->address_type);
 
-	if (!device)
-		goto failed;
+	if (!device) {
+		btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_UNPAIR,
+							adapter->index, 0,
+							NULL);
+		return;
+	}
 
 	/* There is no direct unpair method, removing device will clear pairing
 	 * information.
 	 */
+	req = l_new(struct unpair_req, 1);
+	req->index = index;
+	req->device = device;
 	l_dbus_proxy_method_call(adapter->proxy, "RemoveDevice", unpair_setup,
-						unpair_reply, device, NULL);
+						unpair_reply, req, l_free);
 
 	return;
 
-- 
2.43.0

