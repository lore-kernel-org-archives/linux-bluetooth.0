Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399E5921E4
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887207; cv=none; b=Vr2USIGOFm9g6/lHo9DRI5gd4fDGYABh/h3fWYlvjWYx+VXefT6VehNHU7ditmmzPNfNOSXkqS1jBHYl+yhq75JsuZ+xcB3ymAxXr/YL+ShEZgpRuP8A0E+rIxA073GViiS2NyMRpWGHeKU5NZy3Wt41mqAcRXb0k1gtZKUhM0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887207; c=relaxed/simple;
	bh=hdDa02uD5uIvTKCf+pKmqwybaSAnZlERFDM9S7rfb0A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cx3KohPHKY7CT9+BUJiAfR/RWmQvLk/Sbokm2pTuSpjuEx1fXVYnGeJ7rbot41aIq6u/k09Y7+l4+pvaV8Dsa6R9ZTm/66TGz+DrlJgIMCZyFMLdFcnX3+PR/1z3Sv2Is9kyNDcMeOecfX3vzpr58Uok6nvGvLyNCdUHVeVkTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L17GJRhJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L17GJRhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788887200;
	bh=hdDa02uD5uIvTKCf+pKmqwybaSAnZlERFDM9S7rfb0A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L17GJRhJHtSfzal1IHY+i92HFR2pEqVyxZ6ct+I8jb/9+HOTPl+mDd/JD+OepRTk+
	 AeYBhOPrWzOTy0w4pAA04OggUxE/uzlFDOhG0N43+auBvD2gw2hNp4pA1sZaLw51fz
	 vRSe4k2xmvfIpcH8qauntIdKXHscOc9mGX9mihqgGEhNuzM7oJxLxyvpJCdDJcDSKT
	 oI3M0TaKkYZV3V0O9hOA7ZdWqYCNmxXJDt/caGyEfVvtJxWIVnwZJkVuYdhWcvPplp
	 /dOrBE+DFggtbZP+E9cmV2NUJjs+Vfp8yuCJZxQPtObSL8Bovp6+gaLBiV3DYPDoh4
	 m33YU1N3keSzw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1694D17E0EB0
	for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 19:06:40 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/8] client/btpclient: Add BTP_OP_BAP_SEND support
Date: Tue,  8 Sep 2026 19:06:30 +0200
Message-ID: <20260908170633.510244-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908170633.510244-1-frederic.danis@collabora.com>
References: <20260908170633.510244-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
v1->v2: Fix incremental build

 client/btpclient/bap.c       | 49 ++++++++++++++++++++++++++++++++++++
 client/btpclient/btpclient.h |  3 +++
 src/shared/btp.h             | 13 ++++++++++
 3 files changed, 65 insertions(+)

diff --git a/client/btpclient/bap.c b/client/btpclient/bap.c
index d30d931f1..548b5e8ed 100644
--- a/client/btpclient/bap.c
+++ b/client/btpclient/bap.c
@@ -31,6 +31,7 @@ static void btp_bap_read_commands(uint8_t index, const void *param,
 	const uint8_t supported_commands[] = {
 		BTP_OP_BAP_READ_SUPPORTED_COMMANDS,
 		BTP_OP_BAP_DISCOVER,
+		BTP_OP_BAP_SEND,
 	};
 	uint8_t *commands = NULL;
 	size_t commands_len = 0;
@@ -104,6 +105,51 @@ failed:
 	btp_send_error(btp, BTP_BAP_SERVICE, index, status);
 }
 
+static bool match_ase(const void *entry, const void *data)
+{
+	const struct btp_ase *ase = entry;
+	uint8_t id = L_PTR_TO_UINT(data);
+
+	return ase->ase_id == id;
+}
+
+static void btp_bap_send(uint8_t index, const void *param, uint16_t length,
+								void *user_data)
+{
+	const struct btp_bap_send_cp *cp = param;
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	uint8_t status = BTP_ERROR_FAIL;
+	struct btp_device *dev;
+	struct btp_ase *ase;
+	ssize_t bytes_written;
+	struct btp_bap_send_rp rp;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	dev = find_device_by_address(adapter, &cp->address, cp->address_type);
+	ase = l_queue_find(dev->ases, match_ase, L_UINT_TO_PTR(cp->ase_id));
+	if (!ase || !ase->io)
+		goto failed;
+
+	bytes_written = write(l_io_get_fd(ase->io), cp->data,
+		cp->data_len <= ase->tx_mtu ? cp->data_len : ase->tx_mtu);
+	if (bytes_written < 0) {
+		l_error("Failed to write (%d)", errno);
+		goto failed;
+	}
+	rp.data_len = bytes_written;
+
+	btp_send(btp, BTP_BAP_SERVICE, BTP_OP_BAP_SEND, index, sizeof(rp), &rp);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_BAP_SERVICE, index, status);
+}
+
 static void bap_charac_read_setup(struct l_dbus_message *message,
 							void *user_data)
 {
@@ -304,6 +350,9 @@ bool bap_register_service(struct btp *btp_, struct l_dbus *dbus_,
 	btp_register(btp, BTP_BAP_SERVICE, BTP_OP_BAP_DISCOVER,
 					btp_bap_discover, NULL, NULL);
 
+	btp_register(btp, BTP_BAP_SERVICE, BTP_OP_BAP_SEND,
+					btp_bap_send, NULL, NULL);
+
 	bap_service_registered = true;
 
 	return true;
diff --git a/client/btpclient/btpclient.h b/client/btpclient/btpclient.h
index 2ba612ade..9996df506 100644
--- a/client/btpclient/btpclient.h
+++ b/client/btpclient/btpclient.h
@@ -42,6 +42,9 @@ struct btp_ase {
 	uint8_t dir;
 	uint8_t ase_id;
 	struct l_dbus_proxy *ep_proxy;
+	struct l_io *io;
+	uint16_t rx_mtu;
+	uint16_t tx_mtu;
 };
 
 struct btp_agent {
diff --git a/src/shared/btp.h b/src/shared/btp.h
index 8ad57f48f..fe93158aa 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -481,6 +481,19 @@ struct btp_bap_discover_cp {
 	bdaddr_t address;
 } __packed;
 
+#define BTP_OP_BAP_SEND				0x03
+struct btp_bap_send_cp {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint8_t ase_id;
+	uint8_t data_len;
+	uint8_t data[];
+} __packed;
+
+struct btp_bap_send_rp {
+	uint8_t data_len;
+} __packed;
+
 #define BTP_EV_BAP_DISCOVERY_COMPLETED		0x80
 struct btp_bap_discovery_completed_ev {
 	uint8_t address_type;
-- 
2.43.0

