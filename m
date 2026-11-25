Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593436;
	b=r9aA8bxhfj5uJP2u0tbigBvqwD2UeuedXzZj8FyPxBwHhadlPWxZ/6mZ/KMFMepUnMPp
	 ifRvMxqcFbfC9cDo0syQE97eMb0PfIEi/4Wu7dOzBG4rqO1MquJ+E9QVsH64yNMtPTbem
	 LraI0ErFHmnqn25DYCRBR65e3WZcETMmj4YoTr6x1IuTIZsepeYxzAsQX38KpMgGfd4hH
	 fW4eK3PBsll1AtC88KSFaAek7fpbKeTNK9/d5avSmx220StL7rud8tZOOtCKWQe4rSInm
	 T80e5Y0rexpIDAaQEcSnsHYbzTP6ke+IRDYbw7Jov+xfi80ApQhtP9oQvNbaus9Tzgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593436;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3x8UNbCuBCxysY+bI+SRPGmFNTfls3/1lPCGWGPpyqM=;
	b=k99xuh7UBn3eLpe2jyeOqNppg6DEsh8LzY8ScHq/uAK09JSVjS63yQYgD/lP0T+EJDeQ
	 hnVRuqTkjbl431TbiQLyA+OyPX8cTOLE9G69naHOw0qZi3DdO4uYUSd19FIvfqNnLFYQN
	 Ya/5HYHsKYMfPrnUtc1HJr33VzcfjcwMc/9QFMM9RaK02JxoYlSwNg3tLzQdi9mnx1ynt
	 NOrwE/X84Jdv1TokaqUlPoVgAlrpwb945oOjs4IqFVdui7MCcKXBnyb9r2lu86RAkPR4/
	 V2XCmNDzu+4gFZhBZMpj/tOLDtE82nLnJK5seUY7q9oPbxcHTBtHd+2vm2CMyBy3aag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=PWIlmZqJ;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410EB606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 07:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 410EB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=PWIlmZqJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795593434;
	bh=QgUYezhBxtNppnT61AgwK9UUVfNf9EA6aoJXnWvnm7E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PWIlmZqJOBOAIKpLhh0N8FmpLTITzc0eLaIPPDIg4LipnaXTXjnbNZeJSEiInEJJq
	 aH6WtWAGsfAHz8ra3S9Gbw49QZouy/Ku9bM4wMzt+gRun1nNGpXMa2b8BusLh+Kd29
	 yH5XcyqErlnQM7DCAjuNr4/2IexzouX4kjo8ghSN4TOljQqRbPv1GZ2/dzNue/jaJz
	 zWHHQotGsSI8Mv50L+ZBHw+sfd8+MJfPje1BiFtH+eIRAhlvGInvYED7xtWj+aZuqU
	 WiVkt7SKAZTY5PToRjMARRbQg6/xbVbZu6ek8wjn8QZuCzrVCCBXQnES0va0Ej6c4g
	 gKbXV/qrQJdYQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A40B817E1090
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:57:14 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 3/3] client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support
Date: Wed, 25 Nov 2026 08:57:09 +0100
Message-ID: <20261125075709.459719-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125075709.459719-1-frederic.danis@collabora.com>
References: <20261125075709.459719-1-frederic.danis@collabora.com>
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
v3->v4: Fetch the device's Address/AddressType D-Bus properties instead
  of reading the btp_device struct fields directly, consistent with the
  other event builders in this file (btp_gap_device_connection_ev(),
  btp_identity_resolved_ev()).

 client/btpclient/gap.c | 65 +++++++++++++++++++++++++++++++++++++++++-
 src/shared/btp.h       | 11 +++++++
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
index 33a6c1693..5f0774e6e 100644
--- a/client/btpclient/gap.c
+++ b/client/btpclient/gap.c
@@ -2564,6 +2564,46 @@ static void btp_gap_device_connection_ev(struct l_dbus_proxy *proxy,
 	}
 }
 
+static void btp_security_level_changed_ev(struct l_dbus_proxy *proxy,
+							uint8_t level)
+{
+	struct btp_device *device = find_device_by_proxy(proxy);
+	struct btp_adapter *adapter = find_adapter_by_device(device);
+	const char *str_addr, *str_addr_type;
+	struct btp_gap_sec_level_changed_ev ev;
+
+	if (!device || !adapter)
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
@@ -2736,6 +2776,22 @@ void gap_property_changed(struct l_dbus_proxy *proxy, const char *name,
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
@@ -2743,12 +2799,19 @@ void gap_property_changed(struct l_dbus_proxy *proxy, const char *name,
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

