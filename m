Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622426;
	b=tyZfS0zQJEjmJI7YoIlIo18T3AAZHXIuF5tFN9vNbs/HDnreKcMFacK4s+UDJkv1BIbD
	 RtluuwxzcA6m716bQKDP+RxLyWXUttSTxJDB5Vn1YD3Y53ZIFBNY8Rekcgaahse9D40r9
	 ra/1RzEYkZ2zMG43vjoO+7bXP0+TeR8ATO2EQMWo+V0u4kuRtgWHfLvU2kX4DlKO2+csw
	 pyLz3Q3xj5tAaA/wlsvppj1unRKH1qWFyqirs3zTn//OpjBaFapbrBoc82d+yDxXHwbh/
	 tu9laaEU6bKx+g9mLdmVjunaSJJIIJOMpxLJGBD8JOXPeAH6Q9W3JSMpSOqTrOL9R0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622426;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3Lmvr/7eooTC3FHNPEwlA9BRE4zJFLXFk1uqhZP1QDI=;
	b=bIXQtei8xqxrBuPwk7I00GnRrMf4zEATu7oGTgm+j6EaDVBNml72gLoQdzKlEw/0PnPE
	 OVSQ1mRtWldR/rke4zQQCBrgh2Fc5xuvCYJXXbgBgd6NFBGhEKDKZqxRtx8x3K4Egc+eL
	 19WlTLAhY61hDSeIE/UTIv0sOLxKimA5WsiLMoTQ3Kle3yGbMTAJ1PNtCERNI4v6EcCLT
	 AsJZqhQDD0UO/f4wQV0VXmcPZg+RaZ0tqdAotxPYMwvWwSMv+B9Nix8ldPeQRdRzA7RVw
	 xVKVzEVxpaVhvbRLA+NOHJZTuEoYXlIt3ML1EsUss0oJz5jPtg3vB35a381rpZ3Nfqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=qkxIfACY;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73DD606A333
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D73DD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=qkxIfACY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795622424;
	bh=M+ymb1nIQO8xhG8JY9juj1lBpgKsly+PjH7gZj1MjgE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qkxIfACYyCUawgxuyfGG9b5WvY4dVvpNpzLUMj/9ggy3VPcEPQqNTcqWFFidGURMg
	 uHSEXZAuBEedmPsA2ylJM4gyAV/3FztZnUNHyrTWdRTRcS6JWEYsx6ykxbfzEh6oKT
	 ZQV8PWXsvE7NSkeSoCPCKMw0iFzlyhIo2D/AFAWA9nDatHn5kBAb7sJSRrgUDvh2Hp
	 nPs3od3xl72+RtD19IaRJxDuxYmRiiVJfF45svnMIAVoroF+njdnjokOCNEN95aoay
	 JclZYA8B105g61AQcjFmFPOvBsw1FryYmkf43kbLe9oteek6yKo8+T+zALTtO9ssqo
	 9zyD6pU8ginIw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5781917E10D0
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:00:24 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 3/3] client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support
Date: Wed, 25 Nov 2026 17:00:18 +0100
Message-ID: <20261125160018.590013-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125160018.590013-1-frederic.danis@collabora.com>
References: <20261125160018.590013-1-frederic.danis@collabora.com>
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

When supported, send BTP_EV_GAP_SEC_LEVEL_CHANGED from org.bluez.Device1
SecurityLevel property changes, mapped to the matching BTP level, and
skip levels with no BTP equivalent (no security/encryption yet).
Postponed this BTP event after device services has been retrieved to be
in sync with auto-pts expectation.

SecurityLevel's BT_SECURITY_MEDIUM only indicates encryption is
desired, not that it is active: also check EncryptionType before
reporting this level as encrypted, and refresh the BTP event on
EncryptionType changes too.

Replay the cached security level when GAP registers, or a device
proxy is added, for a device that is already connected and resolved,
so its security state isn't missed.

This reduces connection time for the BAP tests.
---
v2->v3: Only read and report SecurityLevel when ServicesResolved becomes
  true: device_remove_connection() clears ServicesResolved without
  clearing the cached sec_level, so the ServicesResolved handler was
  emitting a stale security-level-changed event when an encrypted peer
  disconnected.
v3->v4: Fetch the device's Address/AddressType D-Bus properties instead
  of reading the btp_device struct fields directly, consistent with the
  other event builders in this file (btp_gap_device_connection_ev(),
  btp_identity_resolved_ev()).
v4->v5: BT_SECURITY_MEDIUM only means encryption is desired, not that
  it is active: now also check EncryptionType before reporting this
  level, and refresh the event on EncryptionType changes too. Replay
  the cached security level in btp_gap_device_found_ev() for devices
  that are already connected and resolved when GAP registers or the
  proxy is added, so their security state isn't missed. Moved
  btp_security_level_changed_ev() before its only caller,
  btp_gap_device_found_ev(), to drop its forward declaration.

 client/btpclient/gap.c | 85 +++++++++++++++++++++++++++++++++++++++++-
 src/shared/btp.h       | 11 +++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
index 33a6c1693..2731329ef 100644
--- a/client/btpclient/gap.c
+++ b/client/btpclient/gap.c
@@ -2399,6 +2399,58 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
+static void btp_security_level_changed_ev(struct l_dbus_proxy *proxy)
+{
+	struct btp_device *device = find_device_by_proxy(proxy);
+	struct btp_adapter *adapter = find_adapter_by_device(device);
+	const char *str_addr, *str_addr_type;
+	uint8_t level, enc_type;
+	struct btp_gap_sec_level_changed_ev ev;
+
+	if (!device || !adapter)
+		return;
+
+	if (!l_dbus_proxy_get_property(proxy, "SecurityLevel", "y", &level))
+		return;
+
+	if (!l_dbus_proxy_get_property(proxy, "Address", "s", &str_addr))
+		return;
+
+	if (!l_dbus_proxy_get_property(proxy, "AddressType", "s",
+								&str_addr_type))
+		return;
+
+	str2ba(str_addr, &ev.address);
+	ev.address_type = strcmp(str_addr_type, "public") ?
+				BTP_GAP_ADDR_RANDOM : BTP_GAP_ADDR_PUBLIC;
+	switch (level) {
+	case BT_SECURITY_MEDIUM:
+		/* This level only means encryption is desired, not that it
+		 * is active yet: only report it once EncryptionType confirms
+		 * encryption is actually in use.
+		 */
+		if (!l_dbus_proxy_get_property(proxy, "EncryptionType", "y",
+								&enc_type) ||
+								!enc_type)
+			return;
+
+		ev.sec_level = BTP_GAP_SEC_LEVEL_UNAUTH_ENC;
+		break;
+	case BT_SECURITY_HIGH:
+		ev.sec_level = BTP_GAP_SEC_LEVEL_AUTH_ENC;
+		break;
+	case BT_SECURITY_FIPS:
+		ev.sec_level = BTP_GAP_SEC_LEVEL_AUTH_SC;
+		break;
+	default:
+		/* No security/encryption yet, no BTP level to report. */
+		return;
+	}
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_SEC_LEVEL_CHANGED,
+					adapter->index, sizeof(ev), &ev);
+}
+
 static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 {
 	struct btp_device *device = find_device_by_proxy(proxy);
@@ -2518,6 +2570,12 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 
 		btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_CONNECTED,
 				adapter->index, sizeof(ev_conn), &ev_conn);
+
+		/* Replay the cached security level for devices that were
+		 * already connected and secured before GAP registered or
+		 * this proxy was added.
+		 */
+		btp_security_level_changed_ev(proxy);
 	}
 }
 
@@ -2736,6 +2794,19 @@ void gap_property_changed(struct l_dbus_proxy *proxy, const char *name,
 			 */
 			if (!prop)
 				btp_gap_device_connection_ev(proxy, prop);
+		} else if (!strcmp(name, "SecurityLevel") ||
+					!strcmp(name, "EncryptionType")) {
+			bool resolved;
+
+			/* Postpone security level changed event after services
+			 * has been resolved.
+			 */
+			if (l_dbus_proxy_get_property(proxy,
+					"ServicesResolved", "b", &resolved) &&
+					!resolved)
+				return;
+
+			btp_security_level_changed_ev(proxy);
 		} else if (!strcmp(name, "AddressType")) {
 			/* Address property change came first along with address
 			 * type.
@@ -2747,8 +2818,10 @@ void gap_property_changed(struct l_dbus_proxy *proxy, const char *name,
 			if (!l_dbus_message_get_arguments(msg, "b", &prop))
 				return;
 
-			if (prop)
+			if (prop) {
 				btp_gap_device_connection_ev(proxy, prop);
+				btp_security_level_changed_ev(proxy);
+			}
 		}
 	}
 }
diff --git a/src/shared/btp.h b/src/shared/btp.h
index ee5d7bd21..8cae0e765 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -296,6 +296,17 @@ struct btp_gap_identity_resolved_ev {
 	bdaddr_t identity_address;
 } __packed;
 
+#define BTP_GAP_SEC_LEVEL_UNAUTH_ENC		0x01
+#define BTP_GAP_SEC_LEVEL_AUTH_ENC		0x02
+#define BTP_GAP_SEC_LEVEL_AUTH_SC		0x03
+
+#define BTP_EV_GAP_SEC_LEVEL_CHANGED		0x89
+struct btp_gap_sec_level_changed_ev {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint8_t sec_level;
+} __packed;
+
 struct btp_gatt_service {
 	uint16_t start_handle;
 	uint16_t end_handle;
-- 
2.43.0

