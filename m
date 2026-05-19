Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607803EDAC5
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180624; cv=none; b=ONtxpQmXG2ar6Cwwh9serSIemigTU6w1WZrUbhrwq/6UrCR00xQk4k3C1PeQf1MZYDahY0C8aVfbkwVvOs2YjWeK4GZrlJeUPdMuzquTfQ0w8V9IjwafDgfE/jRaYS9/UiEEVRvrmzvirbeQzZdMTwdGRlWWOLIQqjzzMTUrslE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180624; c=relaxed/simple;
	bh=uHbeRkmGPF0wSZuECyiAf/gG+X3r1p2TiXUJl026vl4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0eZ2olLFudwOTrUmjdA+XLiGBSVGqgkNqz0FrtCJMOEp1+gtbsmZwWWTujR0fh5Rp5/Lwu4cH/Ytf7TI3f38wgaFE3LGzjQDNUOjUcZrov9VeB+b0d5YL4D/p7nq8pPD6FEzoLSXfTeiiUgUpNiObl5Tkk3/12gDvcE29ps1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UrpsqmQp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UrpsqmQp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779180621;
	bh=uHbeRkmGPF0wSZuECyiAf/gG+X3r1p2TiXUJl026vl4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UrpsqmQpWW/vFoaxqlwhU6YWVYBa1qOfjebqWZOT+5LiIeb9Q1z/cQOj+D2DwJXPc
	 wUaYlLgK1pnZQbXP607xfA3jMyfIe+F1g/ECtvkiB5431vZB7X9ckzFcFGzkmUXf8y
	 UAp7XR35iFhEDVv/Ur9FuIy2FivjNJiErgYBXsiReO8wpkw3x412pqosTOEGZyNYmj
	 1r3ts+GEtnVHa76HTmuu48hEF9P78x08UTPopDivnaPkvDWs1jTyhMcTzuLDTsQlyE
	 wy3QAGUrYQSRJOYKU7pS7ljGFN6qxxszl07BZrZE/jPvnyLSz0vDi2Q6LKQZNBjDr7
	 hwte8jZANLI1w==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B037E17E12AE
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 10:50:21 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] client/btpclient: Don't remove all devices on GAP Reset command
Date: Tue, 19 May 2026 10:50:16 +0200
Message-ID: <20260519085016.188744-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519085016.188744-1-frederic.danis@collabora.com>
References: <20260519085016.188744-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently running auto-pts remove all paired devices, instead of just
removing the PTS devices.
This removes this behavior, expecting auto-pts to explicitly remove the
PTS devices using Unpair command.
---
v1->v2: Fix build error

 client/btpclient/gap.c | 55 +++---------------------------------------
 1 file changed, 4 insertions(+), 51 deletions(-)

diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
index a14cd4795..f6b920b37 100644
--- a/client/btpclient/gap.c
+++ b/client/btpclient/gap.c
@@ -200,39 +200,6 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
-static void remove_device_setup(struct l_dbus_message *message,
-							void *user_data)
-{
-	struct btp_device *device = user_data;
-
-	l_dbus_message_set_arguments(message, "o",
-					l_dbus_proxy_get_path(device->proxy));
-}
-
-static void remove_device_reply(struct l_dbus_proxy *proxy,
-						struct l_dbus_message *result,
-						void *user_data)
-{
-	struct btp_device *device = user_data;
-	struct btp_adapter *adapter = find_adapter_by_proxy(proxy);
-
-	if (!adapter)
-		return;
-
-	if (l_dbus_message_is_error(result)) {
-		const char *name;
-
-		l_dbus_message_get_error(result, &name, NULL);
-
-		l_error("Failed to remove device %s (%s)",
-					l_dbus_proxy_get_path(device->proxy),
-					name);
-		return;
-	}
-
-	l_queue_remove(adapter->devices, device);
-}
-
 static void unreg_advertising_setup(struct l_dbus_message *message,
 								void *user_data)
 {
@@ -351,9 +318,7 @@ static void btp_gap_reset(uint8_t index, const void *param, uint16_t length,
 {
 	struct btp_adapter *adapter = find_adapter_by_index(index);
 	struct btp_agent *ag = get_agent();
-	const struct l_queue_entry *entry;
 	uint8_t status;
-	bool prop;
 	uint32_t default_settings;
 
 	if (!adapter) {
@@ -361,22 +326,10 @@ static void btp_gap_reset(uint8_t index, const void *param, uint16_t length,
 		goto failed;
 	}
 
-	/* Adapter needs to be powered to be able to remove devices */
-	if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &prop) ||
-									!prop) {
-		status = BTP_ERROR_FAIL;
-		goto failed;
-	}
-
-	for (entry = l_queue_get_entries(adapter->devices); entry;
-							entry = entry->next) {
-		struct btp_device *device = entry->data;
-
-		l_dbus_proxy_method_call(adapter->proxy, "RemoveDevice",
-						remove_device_setup,
-						remove_device_reply, device,
-						NULL);
-	}
+	/* PTS devices should be removed explicitly by calling
+	 * BTP_OP_GAP_UNPAIR to prevent removing all paired devices
+	 * from the IUT.
+	 */
 
 	if (adapter->ad_proxy && ad.registered)
 		if (!l_dbus_proxy_method_call(adapter->ad_proxy,
-- 
2.43.0

