Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683139;
	b=EWoK0+qgWggOnGvU9irTGmMsGBS6fY7z7mKVoNGnjnO8iwniYZeDmkg8bEGx6Nvy2s+i
	 JQ899UHnHJO/+kjzOAE4xqAZmLyStapYwutL30ZER0NRQCuDL7yTa7KnRFjM5zDqTLpGE
	 UDsOKrmnQ7vySsMWfrHj5XpLS0o2nqSnVqlu2R+uzMu99r1paig/2s6fY5iHGAtdPoSjT
	 JPNUDHrubOTjtXaWNRsrjKaBqS1JfeJOwcnv1d350imyZ6+cTVafww/1Ve5KozqG35Fn5
	 2EH8QMXh5Piw0AtJrIkSVjaz2LaPylBWE7wen5IV/gOAFuzFQMZOTtfxGlLg2EfhbvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683139;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6lyJk2dG2zjoKXAhP65csYgCjb0GniTBaWVYli9wnIQ=;
	b=lLDlEcVGaf8ru6Jl2u9xN2NlhM2YuT7kaHFffq1KH0Kz6b67qh2Vyy3cPY1x/E3tiKD6
	 WxSVE4PO29R2N/PR+AUHwVi+PnMxSVBbzZ5eAMYgkGEyTqRTZBUGuJXWW3LCgh7/te6sR
	 gaIpFDx6W7Ltl1EF6/M4bVdsTP6uKDSyTEJ5lest6fBgm6jnAUAB8HbR7EdO4skWLE7Z0
	 bzbt/JOqR/TLvhTfr4jatcbPSxHa7nBhLqCWzM2vQy29qOGVa40TcovJiQIqd1aiGBPvw
	 JeZBxUaOVq3uyhf9EW94blNSzjWs+oshDPnphSh6Sz2zSRsRNgXX9HWnPcIEovelldw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Bj2z4YPv;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6073E606A327
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 08:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6073E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Bj2z4YPv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795683138;
	bh=4cYfzII8+bSeGVH0vUL7VGRBZXYgjOLw4H3tg4j630g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Bj2z4YPvvzhugd/dUXnC8n6OrSugIU4vl2sfO6VBAKDeS5tXVE0Mq7bu2G7gbPVg2
	 KDEmJhc/4JfYg/G7axRfoARFD1hpF2DnFttPEw2y5QcFZtSMRQ+hfpVhgEnoRvLX4g
	 QkGat3fJQJidH+2Cl2mAp4FOyq+mq58KvzdMzBBNcZKSiCef0JIJ1mOFRYKk03r6W4
	 6UDu6tkPH9pUaFiqDOmQPV2YyXbWUjpXNiajqf4Ovmm5FqmIJgk5tHJzNJQglqZmdq
	 BbFCIKvz3IkNS0tCT3UuJ88/tyP9kbESXvKznu67gOswGw3HWWse2kj5N5uulYrmYy
	 IigbxDVKx2crg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DEBA917E0BA9
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 09:52:17 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 4/5] device: Reset Security Level and Encryption Type on disconnect
Date: Thu, 26 Nov 2026 09:52:10 +0100
Message-ID: <20261126085211.80204-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126085211.80204-1-frederic.danis@collabora.com>
References: <20261126085211.80204-1-frederic.danis@collabora.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

SecurityLevel and EncryptionType are retained across disconnects, so
replaying them for a later unsecured reconnect could report the
previous connection's security state. Reset both to zero, with a
PropertiesChanged notification, once the last bearer disconnects.

Assisted-by: Claude:claude-sonnet-5
---
v5->v6: New in v6.

 src/device.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/device.c b/src/device.c
index a21819419..b7235f56b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4141,6 +4141,24 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 	if (device->bredr_state.connected || device->le_state.connected)
 		return;
 
+	/* Security level and encryption type are only meaningful for the
+	 * current connection: reset them once both bearers are disconnected
+	 * so a later reconnect doesn't report a stale value.
+	 */
+	if (device->sec_level) {
+		device->sec_level = 0;
+		g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE,
+						"SecurityLevel");
+	}
+
+	if (device->enc_type) {
+		device->enc_type = 0;
+		g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE,
+						"EncryptionType");
+	}
+
 	device_update_last_seen(device, bdaddr_type, true);
 
 	g_slist_free_full(device->eir_uuids, g_free);
-- 
2.43.0

