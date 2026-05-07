Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47BC302753
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170603; cv=none; b=YojmlJwwIg/L41rQFawtYz/519Jpcq8Ivsl6+HnmqsiQILVBdshT2Km/aROoD++Q1e+/z6XqaRXBgB0TmlRltcA5p1xbEt7p7fCT71JJ0QNkJEUelOTnqLhKj0DG5aWKJ1DFAcVOzERIUAhDOmHMgXaK9zogpwGMLqSAqRNM7uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170603; c=relaxed/simple;
	bh=eXDHOOB6Ha+pnkRgwUGg1q6iV9Xv2AkEYk/VceqLU0M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fp0qJ41qnRUbpDGd1YZ2EFT8StWjSWEMJugz+xTA1ezQfVrz99gLKlngTOX4ccRdBcu0ByxPAdwbTZkh0xF4dpPp4PdnmaA7AFZ8X8MsN1TKWZcbTgT6f11hklh9c3pFOr6XlTfbLNlcSkvKi//akcn98CBgioo3VT3w0sTI5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NEQp9Z8q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NEQp9Z8q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778170599;
	bh=eXDHOOB6Ha+pnkRgwUGg1q6iV9Xv2AkEYk/VceqLU0M=;
	h=From:To:Subject:Date:From;
	b=NEQp9Z8qB6iR7KY/JnAQVhpXGytAJjsHbXFiR2h+1VRca44xPifzYP5YNDbngoqiI
	 VxhWA1iZXZDrXRI+IG9Viyn5H9vWUr0zV54viN6SIEbl5WzeZ64kWWh6+87ryLXDoV
	 P3+a8yDxdxkFm7bu8jBx73/jwtQc/+3DX38aNcBgLjJPd8zcbz/pOuAzPQM2X0X5qO
	 Jt1WwFp/R+l1u6JVaf7qVgPcGpo414MSycgpDdhbDB0yfIMSiUDs4qtvFd6eBcoZYW
	 gtzx3Bke07hjc0DoF62FpmFQO1codplRZJvcJ1NgD77Ip8TTDR0OOMphhob5+MNYTk
	 ppcHCsmdkpajg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9183E17E0280
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 18:16:39 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support
Date: Thu,  7 May 2026 18:16:33 +0200
Message-ID: <20260507161633.437600-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This allows reduces connection time for the BAP tests.
---
 client/btpclient/gap.c | 22 ++++++++++++++++++++++
 src/shared/btp.h       | 11 +++++++++++
 2 files changed, 33 insertions(+)

diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
index 68e029dcc..1a6c2c2f0 100644
--- a/client/btpclient/gap.c
+++ b/client/btpclient/gap.c
@@ -2538,6 +2538,21 @@ static void btp_gap_device_connection_ev(struct l_dbus_proxy *proxy,
 	}
 }
 
+static void btp_security_changed_ev(struct l_dbus_proxy *proxy, bool paired)
+{
+	struct btp_device *dev = find_device_by_proxy(proxy);
+	struct btp_adapter *adapter = find_adapter_by_device(dev);
+	struct btp_gap_sec_level_changed_ev ev;
+
+	/* TODO: get real security level */
+	memcpy(&ev.address, &dev->address, sizeof(ev.address));
+	ev.address_type = dev->address_type;
+	ev.sec_level = BTP_GAP_SEC_LEVEL_AUTH_ENC;
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_SEC_LEVEL_CHANGED,
+					adapter->index, sizeof(ev), &ev);
+}
+
 static void btp_identity_resolved_ev(struct l_dbus_proxy *proxy)
 {
 	struct btp_device *dev = find_device_by_proxy(proxy);
@@ -2709,6 +2724,13 @@ void gap_property_changed(struct l_dbus_proxy *proxy, const char *name,
 			 */
 			if (!prop)
 				btp_gap_device_connection_ev(proxy, prop);
+		} else if (!strcmp(name, "Paired")) {
+			bool prop;
+
+			if (!l_dbus_message_get_arguments(msg, "b", &prop))
+				return;
+
+			btp_security_changed_ev(proxy, prop);
 		} else if (!strcmp(name, "AddressType")) {
 			/* Address property change came first along with address
 			 * type.
diff --git a/src/shared/btp.h b/src/shared/btp.h
index b99ad3a28..4d3c4ec6f 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -286,6 +286,17 @@ struct btp_gap_identity_resolved_ev {
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

