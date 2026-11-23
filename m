Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447885;
	b=pAEl12zlKBzDpCsg/unL4wNlM7HjmLGMhIdFEiv8cSjcOuGbHoWhIftY8NU6jetTY6vP
	 jbFnTr7xbNjG3GdrLO7FSBJ7Yhxqo+NvDIcSPmlHEP65JXHgkGv6U1guu5grx0xHCpxyg
	 E50uv+q1VbS0KYKjzq5Pq8/IEXCddr31qSLjvG0BAGRO0WE6vN07MFdGQ2+tlYgeCUwv9
	 FGv4lY5iB4Ma26xWIcGVXzzXyzQ1X2XVbmHHhQMohH2XfRWOkb4LClc2bA3NiiFoImRqV
	 joY/VqF14NJupZStE3Ycdv5hriO2x7uprPLplube8pe6Z1yJ/DAKDcMQ97bw1pFjxbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447885;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ms7BWLNhXQuCJxxKt8SjzZH2dDeBI1JEocc4L+u3LG4=;
	b=s4IW0GZABV3TnnZq1nVYlMM2VIy0d4C+hDuyj+GxXMbNz2l7C9Ql78XwFh1/aMx7SoHp
	 Su0t0gWf6OmErg8NfIqTTbgzccJutSFgv/a6G/3fQHxOblc1BJPgFQ+faIJrFXFZesOXe
	 GZ/CpMf61aZuBHEPFkHBZ0KM3zI5MMZ7wtadlt5qGZvoUutegcgPXPOwsWZJcNO6v/nmw
	 S6dFAUF4N8i+Bo6AuPzq+qb32mZ6BA+9eBZR6IsnRGqJvIp9FoyxBvNJlruBe2zrEt+Is
	 xQjW3oIjRl2BrvXIFmRHN146WJwniAwVL8kH92jyBvDIZBQ/ymWWsrH8yqyJ4Uta/Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hWygWhw+;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237FC606A32A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 15:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 237FC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hWygWhw+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795447883;
	bh=7oGiBBP6OZZJuNi25F0V+1IZIY8UetllReimk2tKUUs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hWygWhw+nP81HSTbFk9Dz5XeW5DljUIB6mA0bjlw/Gx1k+owdey4WDDJULMJiKJCs
	 LhM23QzFvUNwLp/BJqG9BF9RpN5L170eShgRtbCYaAhmkGpJgHhykbynl89oegpCU7
	 sERSA/avGscyTcPlWs/y9zLNHI2tux0KKNMA4SUysDAeLiIRueHhZc7fS/yEqQS3ws
	 UuvZDsgCEJgvoz4YlrX/v+B3LoNvbei3bYEI3IM3bQvOynuSY5pyEmSaru7OgoOl91
	 Jh2IGpRn9usl4UOeRoMz4fLRVesqT6xs0eLdcbfKhSk+IBk5v6iimw9dW1CkzVp5eS
	 MUyBJA2Ez9/Ag==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 95AC217E0EBD
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:31:23 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support
Date: Mon, 23 Nov 2026 16:31:17 +0100
Message-ID: <20261123153117.135583-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123153117.135583-1-frederic.danis@collabora.com>
References: <20261123153117.135583-1-frederic.danis@collabora.com>
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

This reduces connection time for the BAP tests.
---
 client/btpclient/gap.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/btp.h       | 11 +++++++++
 2 files changed, 63 insertions(+)

diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
index 33a6c1693..07ac60871 100644
--- a/client/btpclient/gap.c
+++ b/client/btpclient/gap.c
@@ -2564,6 +2564,37 @@ static void btp_gap_device_connection_ev(struct l_dbus_proxy *proxy,
 	}
 }
 
+static void btp_security_level_changed_ev(struct l_dbus_proxy *proxy,
+							uint8_t level)
+{
+	struct btp_device *device = find_device_by_proxy(proxy);
+	struct btp_adapter *adapter = find_adapter_by_device(device);
+	struct btp_gap_sec_level_changed_ev ev;
+
+	if (!device || !adapter)
+		return;
+
+	memcpy(&ev.address, &device->address, sizeof(ev.address));
+	ev.address_type = device->address_type;
+	switch (level) {
+	case BT_SECURITY_MEDIUM:
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
 static void btp_identity_resolved_ev(struct l_dbus_proxy *proxy)
 {
 	struct btp_device *dev = find_device_by_proxy(proxy);
@@ -2736,6 +2767,22 @@ void gap_property_changed(struct l_dbus_proxy *proxy, const char *name,
 			 */
 			if (!prop)
 				btp_gap_device_connection_ev(proxy, prop);
+		} else if (!strcmp(name, "SecurityLevel")) {
+			uint8_t level;
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
+			if (!l_dbus_message_get_arguments(msg, "y", &level))
+				return;
+
+			btp_security_level_changed_ev(proxy, level);
 		} else if (!strcmp(name, "AddressType")) {
 			/* Address property change came first along with address
 			 * type.
@@ -2743,12 +2790,17 @@ void gap_property_changed(struct l_dbus_proxy *proxy, const char *name,
 			btp_identity_resolved_ev(proxy);
 		} else if (!strcmp(name, "ServicesResolved")) {
 			bool prop;
+			uint8_t level;
 
 			if (!l_dbus_message_get_arguments(msg, "b", &prop))
 				return;
 
 			if (prop)
 				btp_gap_device_connection_ev(proxy, prop);
+
+			if (l_dbus_proxy_get_property(proxy,
+					"SecurityLevel", "y", &level))
+				btp_security_level_changed_ev(proxy, level);
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

