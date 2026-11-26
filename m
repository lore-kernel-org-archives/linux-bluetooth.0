Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683139;
	b=gRJGrj//xh407dncUceKnJ9QOQf3tz57jrCm7toEcopP2WkaDX/xAjVE9owyVXUBopNp
	 Yps2QDbg3SAb1ELKT9DU9TbCcPfY29cYwIm9D05ycAqOxhW/BiAHDFlxmIDaCX2PDbomW
	 oWT3G9zTEv4CbEpERzZwW0jy1maYgRUeBDDfPhHFyIpWCFvQDVGT/s2vaqLbxP5qxXyvg
	 DPADYzcyizLKh8makOeVFWWQeOXcIsQb+A/ZhGeVrEKnqmU4bFn2tAaxRFoLNLWs4hd5u
	 NLrGJhN9+b+6+RSnQFn91UppVS9DrC7pXzGjb1wB+6dv/TSOOM9vyJ6T8RNHiBH4JfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683139;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6489sCqUWU+0vucjR3BeH+0AF+cUIf41odZf7LIwGO0=;
	b=geCV2QoaoJ5sUXTgdihhT8e8dH6pKKLexaHHGiuqLvXU5qoXc3yVumg+YoxPGj2Yt5Lo
	 4z7XMyjF/qhq4bgdvFpUWDOq+GLonsPbKCd/pvulSU216WrSQcLgTLAcTfpI/giWxoOiW
	 kG2cU/lPuvuhZ99oLLNUFq4jV6Oe0wKnUlvJdbxb5IBvPGwFRoRbNHtTReMtaoIdwDOOJ
	 heoHqIFSCEjnsaBo0CohCnckL9S2kMOy4qRytrMl+p/CAnkcK83JzM6b+MyPKJWGowAnC
	 0R++IG2hdkgv35qTXfKecEbE9t+PDze2VKyD/IsZvk02SnxoPcfZmkh7OCAzkYZm2qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=oPhGTJ4d;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067A606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 08:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4067A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=oPhGTJ4d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795683137;
	bh=PZIV22aiIXl5qK0k/qA+kppV3BeaPZm35z36+5sAEGI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oPhGTJ4dl4+6MFeMO3O4sFF4xSOcW8Jqro2eZbfYgImlr4E8jDR3ERSjwYD0NoLL6
	 kIYkM1Rbmb0M2jVfp1tXVHgjEHEHUfSARh6RB3gV4fXTKz/P+OeqY+lzF+yAJPv/VH
	 ahZVvNe5RaIeHdah+1NCU3nCJsUj4Xd7u7j32WDa1/dsxpjHzjI2G4w32ExNALlMGk
	 Zuck2tmhuQG1lEiMRzKyroFvuiEt4AXTzZwTgRIvcyg3RSvSP0RdH6PJZAeT7+0DXo
	 FPoAf6seUSpI4et8jTBjrQjrnjTUHWiqZhZwh+DvFA4p2MSxrW87eXnbVJfbp6tdtU
	 V7lmU9PLEWDJQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A2E0E17E09ED
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 09:52:17 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 3/5] client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support
Date: Thu, 26 Nov 2026 09:52:09 +0100
Message-ID: <20261126085211.80204-4-frederic.danis@collabora.com>
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

 client/btpclient/gap.c | 75 +++++++++++++++++++++++++++++++++++++++++-
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

