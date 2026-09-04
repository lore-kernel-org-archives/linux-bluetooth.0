Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873854A33E1
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529902; cv=none; b=eRezPXsjyjiSwEz94Uxz8ATuDfXNdRam/sfg5sysO0dhaxNbAiKXLFJoTKC4FiFDgxUs5sloTLzEQcOZoRJGgnJwnSXtwW/SlZNSLBNiTGnjA7wj8B5Ow6GTK23qD/Bp0AMHUNe1Z3fvltC/aC7scPbk1WpSX9+z++0QfqQGMvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529902; c=relaxed/simple;
	bh=1r85M+Gig6BEdrM908Xykom3UijUR2h2gNsGLsYF1s8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTcHZk+yi5CetA4kz6sJXBsy3u8987+fba0OKLdwt+hVILte4ToxaJ/0/eKGR/aO0JLKikfBltl7YiwGkUnzYIYXlcSRlWs/2mcQGk7GkLOB2KT9TJ7UwddQygKsh7NoMCFwTH7eD2C8vYpTdP3o5QG+tT/OyrLIhbRc932auEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lc0WJ8Lr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lc0WJ8Lr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788529890;
	bh=1r85M+Gig6BEdrM908Xykom3UijUR2h2gNsGLsYF1s8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lc0WJ8LrAwV1CsMCyChusiXBVchIoOglavyQJVzW7VwRIMIFJAIpX5FAvJr0EySFr
	 XHA+XtHl9eQMPVDGoXAtS+yJRrUjbAa2szjdPnFljkhbmXLpt2c+NhrNtEZon88Kkp
	 K6hSkLhapXw7qU0JeHdBrLyWYhl5PTV1s/3L/rxbRKCYzY+Ki9j3GXglpkenyANkbW
	 LqJ6gZNE0ptGn2nRPm+OeKojoymoMFKzZP7dkkXjQFEtTWuAycgm7zLRZyEBYEkDze
	 MpGZtW0J+klE6TcYWkrFfbejxd/na3oBZ9NGYKdxmMMNrvsnl9IMfevtW5i1Nkz/tN
	 E5coVIR581CkQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A1FC317E0FAA
	for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 15:51:30 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/8] client/btpclient: Add BTP_OP_BAP_SEND support
Date: Fri,  4 Sep 2026 15:51:21 +0200
Message-ID: <20260904135124.981346-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904135124.981346-1-frederic.danis@collabora.com>
References: <20260904135124.981346-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 client/btpclient/bap.c | 41 +++++++++++++++++++++++++++++++++++++++++
 src/shared/btp.h       | 13 +++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/client/btpclient/bap.c b/client/btpclient/bap.c
index d30d931f1..f7bee9831 100644
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
@@ -104,6 +105,43 @@ failed:
 	btp_send_error(btp, BTP_BAP_SERVICE, index, status);
 }
 
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
+	ase = find_ase_by_dir(dev, BTP_BAP_DIR_SINK);
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
@@ -304,6 +342,9 @@ bool bap_register_service(struct btp *btp_, struct l_dbus *dbus_,
 	btp_register(btp, BTP_BAP_SERVICE, BTP_OP_BAP_DISCOVER,
 					btp_bap_discover, NULL, NULL);
 
+	btp_register(btp, BTP_BAP_SERVICE, BTP_OP_BAP_SEND,
+					btp_bap_send, NULL, NULL);
+
 	bap_service_registered = true;
 
 	return true;
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

