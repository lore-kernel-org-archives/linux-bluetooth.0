Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522647;
	b=dcVLKGoIANtyZ9kOkdDlyEU3d7AQKniuWl5tZOLPUQNMUkRxtE67i9WwzAmkWqy8Kzme
	 kT19XIc2Jzp7etx2rjvq7yubrPA7t4oKV4p0apn7c4MymQpdGNhkwaHsvFEhRAQy5eHaM
	 SsjH/3NyAcKOsnMf9+/8ESbY6BLBKrQj50yIUDligwVsmuOvv4rBbKlpjbsT6ABT49y2S
	 ZDwIa2PzBojwni0h3Cyj0jwmm1UfqG4K4MVKzj2gzHEIF6B3gQ3624COwS+6M+qqqAHJ4
	 9U2AtWAHLyNuxYbpi6eLSZneL8aD4rkRh6+n8x51/F0MQZ7Q9Ccdu1kfQeipVIbiG8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522647;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gc0rAMSXsWgok7sZC9vcM7IU//FiZMmceNMs0Pz63KU=;
	b=zcnVtuGkNc6bMgzU/NzfdxYDiWDy1FladUgmZ26WmcRHLaMBtrdC4f7w4augBso2ISjK
	 Ae4j4MM7Qw+6BsTt1TtpmOipDpgcFapVoq+8xQUCUIz/bZ+9W6twyVTnnFs4TLQwf+EQz
	 yDubC9uXOB5qm4UZz8bpRX1FRdGGlFTGPHOReigYLDwJGoVzpI3VQtjE7Sl24jaxH6fHB
	 TKtwrsqWrSjA7HcSMnI/maznfTDSczztm1sU+Ml2bhLM1DvFtzUblFJ0TU5uF0KVk0nlv
	 t/3mHx2/Zq3p+eBf3L6xwuUbnKMiI05CjtrShNyePtf3vkfWeFzGaK6NhUCtOAL7NBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=D39U26h0;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95401606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95401606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=D39U26h0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795522645;
	bh=TIa81Aoy/JUUE2eyRhXPJGHukxgtWJn617h9NaLrKAA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=D39U26h0r8lxkW9+JGZDuViquQR8FdfZnKp/oTsyfUL8IN5q6507oqdv+GYrmzVOU
	 I9TEgvj75qFD6hARvSx7kjT1z5s+YFbF8mMOpSFEZqZOed225vNTniZybv6XVuWW1i
	 T7KHxKHXJu2JqplUylXHY7Pkk2QuYhwlBFHMPkBf9dcHRVm4wjIYMJSEC+bfg9zoaE
	 mVZ7nlcTfortk02jjE4FZFMOIhWt/+Oyn9sMsXlAHlkr4+zwe0/0+Xd7Qu7Pr36YbQ
	 18mCxYhJMPGnIBCfDm5S660w/LL+YKvP/tXhFH6ciKk4ZpxJu2sQU5biVG//TisrW7
	 f73uhLIxQmFDg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 18C2817E0EBF
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:17:25 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/3] client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support
Date: Tue, 24 Nov 2026 13:17:19 +0100
Message-ID: <20261124121719.280039-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124121719.280039-1-frederic.danis@collabora.com>
References: <20261124121719.280039-1-frederic.danis@collabora.com>
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
v2->v3: Only read and report SecurityLevel when ServicesResolved becomes
  true: device_remove_connection() clears ServicesResolved without
  clearing the cached sec_level, so the ServicesResolved handler was
  emitting a stale security-level-changed event when an encrypted peer
  disconnected.

 client/btpclient/gap.c | 56 +++++++++++++++++++++++++++++++++++++++++-
 src/shared/btp.h       | 11 +++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
index 33a6c1693..3d5890b2c 100644
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
@@ -2743,12 +2790,19 @@ void gap_property_changed(struct l_dbus_proxy *proxy, const char *name,
 			btp_identity_resolved_ev(proxy);
 		} else if (!strcmp(name, "ServicesResolved")) {
 			bool prop;
+			uint8_t level;
 
 			if (!l_dbus_message_get_arguments(msg, "b", &prop))
 				return;
 
-			if (prop)
+			if (prop) {
 				btp_gap_device_connection_ev(proxy, prop);
+
+				if (l_dbus_proxy_get_property(proxy,
+						"SecurityLevel", "y", &level))
+					btp_security_level_changed_ev(proxy,
+									level);
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

