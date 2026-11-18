Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031932;
	b=frnB3KrsOm44kuYZutNuPG8tbLQYm9knWhYBQCoOpU24sbHeAE+9p1+QK4SYra5o+BIX
	 Sa8gwIYzwUOUupvZSdaCIHuiAKthjjNxhwoQDoqUOvD0DUNMJiynpNNmZmHVYqXfiI9hW
	 +4yMgN7KoYXOL/ISAiWmbHxl919w/4xGck04uRgEqCHCcibhs+0lBePK8XfGFgrzGISJq
	 5EFReiEHSLhGDmXJgGitQIA/sDG7W5C/T1daSMeKbiaeXlOevGzod05MIiCI0vMosUVyE
	 wezcn+27GxklhUsZOC71lqy4pabA5besA3Z7qVUBOf0ZLDqzd9ZG7GQ1NLOzD/WwU3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
	b=NpPRPwrLrm6XUN8kt9uzoEH2xWLTZIdpryX4rgloKjp2KtZ16dSSXAwy0tTuilZOVbgB
	 gWMZdu0swHbXe2bVvL1QNWOcOTCGuajL7HFcz8Iz2CX4mHNpXhVwKXkP9zu6xbMd3NkIE
	 Vyk9dGEKS3uzO6odVFn+eZeBFTljUCPUq1IeHNFe9Go3WMwQcekZ2p0Gq0GnQuvLz3DlC
	 msc4p4tXuwB5jsqET9BgvVlWc7/voM57L7Ih4lsOiJKHOPb4gRYdpjXMUhRHUZ87wGFUb
	 tUlug7DjlJ1ANbhAAeS3FD7wDuuNIhjDAnTnUKWddA8jxVpkTntIfpjRikBB1i00OiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aJDO5Ss0;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AF60A2608
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C6AF60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aJDO5Ss0
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7cc0ccc2fddso519285137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031931; x=1795636731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
        b=aJDO5Ss0QeTaSPE43vnghVizh/X8AKmHbGk3pauD+FlZCyzxWmk0mmB/nxoldcE/ew
         i2Q5A7/mVWDK6TX0Jvnl/isECIzKF80Sd0YpzFvjhsIZX6ZtYUol+ThQHeGlSz4fx8IP
         xSuTg7RIQEyGbn2TzJU6y0a7QvZEF5VnFuO7FaMI0sR9T423fdRqWdPcBqscTkgSXHXp
         RihhQW3MkyMC72tNYFMPvJ4joHYn4ONQ5rPPNBceK7tnFcev/1JvbMPCJ6ybQ51IDdqp
         mcePQB05gW4wDi2HkHCyiHPoMey+aw7wnz28SRQPzw/fCo+8ZfrnI2GEPhVG/AldpKHP
         FwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031931; x=1795636731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
        b=PDnaM0T+gl8N2xaChI7hDeHDSACYps7RY0GlqRq48fvgh1x5E1t1686v1diyDBIrwF
         JiJRhvijh5m5q/hMTlKNJAIs+PEByj114SJuXgG1FqYIQvMDnV0by5N55afkp6lOG4ya
         c4CB/zu+v/byLkQtdz0zuLvCeiNliNcWBnpKqBwLNPzIgi5Qrl6cA5ybudXyCWehLZcP
         kVw9cv5nqgUkwkiSlyf8kH9EwJkM3v+MRZohC0lWDi+zDrerGxOsiJNEin/Aq4R9E7yf
         hNVSApwJUilRY4PO0UgjrppigRtcPgEUhXCbAzRqk/9B+xMn27X3EuaVKC97IGboajP+
         DwEw==
X-Gm-Message-State: APuU4Z/hBBNwjlht3bxtyKIPqCEJCYzYLOerdWA2QZgG2U88aG/OLzww
	UV2m1Bx3zelEK9vVpeDnNGmzOlhrQ/PxLUEEcEPrr9occ6pz3/U9+3O4MnGV7Edt
X-Gm-Gg: AYBFou2BY3vspIKDceePxSxPnd8Lt0yeRfwY2lZpkmQOaEfpfj7Df9S0qP2HgnijS/4
	lQseDUpdxmrQI7Gb14MnPTD0ga67OjwiA/6nMlVJdQ47xEbcQrn8Yi2w/yCrjBRFFHrxMdqZWwq
	m5sNt76prME5F//w6qhPRgj7KCFwoiKoeS/CmX62b7bDf+8ilwpfZGy6XEduhENFy8HpuWTogNW
	1mnA3nHk+Vn+FEbOOZd14VhxgH/fmhWo0xzcIcFlZuo4uAcd/H/V0oAYkB0qQFHt6EaKSIcb8ek
	J2p2AzdFB9ybOFDX7cKIsIXzKykN2CjqLfcQcqmicm1Ex5eQZxwANRV/PE6FFsxIqxJOVZhMz2P
	9noEM/OV6iAxbAREeAK1UyO+7A+DR7hQU2BuSBhKDoyZfcvsGYpRuw4lmxBnMy6oTxIIlmJxMOy
	UN068fK1H8eAcK6t7ggxU3DvYL9kSsbZoU9SwtXngmW4cnLL1t+R3iyHI7HDeFhd++RXCM1FeQI
	hwHtKTaZ2UfKf8U6632lyAA1XU47G2s8lNQbAbq1PR/W56ZPtIIGMuOHrOlaHGT7SS4d35nflpa
	PELl5XLILQlHfEN3yUtOzpOVDNqSaX9qzB3LOTYbx52MO1dOz0a1uSQvKpIZtLpHMZrJcJIqAxC
	XMzmkkse/rf5MmSDO2lntYlzteeiSkcSGJfJ/lwmld6YWVWE5fm4STW6jdae/1ujgAUPKeFe3RZ
	WBG2M=
X-Received: by 2002:a05:6102:2923:b0:7d2:8dd0:301 with SMTP id ada2fe7eead31-7d6ba469f37mr1470363137.29.1795031931038;
        Wed, 18 Nov 2026 11:58:51 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:50 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 03/16] shared/rap: Subscribe on-demand data with the requested transport
Date: Wed, 18 Nov 2026 14:58:31 -0500
Message-ID: <20261118195846.393710-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118195846.393710-1-luiz.dentz@gmail.com>
References: <20261118195846.393710-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>

The On-demand Ranging Data characteristic was always subscribed with
notifications, so an indication request from the Upper Tester was
ignored for the data characteristic, while the RAS Control Point,
Ranging Data Ready and Ranging Data Overwritten followed it.

RAS v1.0 Table 3.1 has it the other way around: On-demand Ranging Data
must support both notifications and indications, the RAS Control Point
supports only indications, and notifications are optional for Ranging
Data Ready and Ranging Data Overwritten. With notifications selected
the Control Point subscription was rejected, so no On-demand transfer
could be requested.

Use the requested transport for On-demand Ranging Data, always
subscribe to Control Point indications, and subscribe Ready and
Overwritten with indications when the server supports them, falling
back to notifications only when it does not. A server may send Ready
only as indications: PTS does so in RAP/REQ/ORD/BV-01-C.

Assisted-by: Claude:claude-opus-5-5
---
 doc/org.bluez.ChannelSounding1.rst |  5 +++--
 src/shared/rap.c                   | 32 +++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/doc/org.bluez.ChannelSounding1.rst b/doc/org.bluez.ChannelSounding1.rst
index 32c83e36f536..e75535b97092 100644
--- a/doc/org.bluez.ChannelSounding1.rst
+++ b/doc/org.bluez.ChannelSounding1.rst
@@ -275,8 +275,9 @@ CCCD subscriptions, then enables the selected mode.
 
 ``transport`` selects the CCCD value for Real-time or On-demand mode. It is
 ignored for Disabled mode. Use ``0x01`` for notifications or ``0x02`` for
-indications. For On-demand mode, this applies to Control Point, Ready, and
-Overwritten; segmented On-demand Data always uses notifications.
+indications. For On-demand mode, this applies to On-demand Data. Control
+Point always uses indications, and Ready and Overwritten use indications
+if the peer supports them, notifications otherwise.
 
 Raises ``org.bluez.Error.Failed`` when remote RAS discovery and Features read
 have not completed, or the selected mode is unsupported by the peer.
diff --git a/src/shared/rap.c b/src/shared/rap.c
index 6de8111d1067..1c4b5239e1ba 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -4556,6 +4556,21 @@ static void ras_cp_response_notify_cb(struct bt_rap *rap,
 	}
 }
 
+/* Indicate Ranging Data Ready and Ranging Data Overwritten when the server
+ * supports it; otherwise let the client fall back to notifications.
+ */
+static uint16_t rap_status_ccc(struct gatt_db_attribute *chrc)
+{
+	uint8_t props;
+
+	if (gatt_db_attribute_get_char_data(chrc, NULL, NULL, &props, NULL,
+								NULL) &&
+			!(props & BT_GATT_CHRC_PROP_INDICATE))
+		return 0;
+
+	return BT_RAP_RANGING_INDICATE;
+}
+
 /* Initiator role: subscribe to a single on-demand-related characteristic,
  * logging (not failing) on any missing attribute/handle so a
  * partially-capable peer doesn't block subscription to the others.
@@ -4637,21 +4652,24 @@ static bool rap_subscribe_ranging_data(struct bt_rap *rap,
 	if (mode == BT_RAP_RANGING_DATA_ONDEMAND) {
 		uint16_t value_handle;
 
-		/* Data is segmented and can be large, so keep it on
-		 * notifications. The control and status characteristics use
-		 * the requested transport.
+		/* Only the data characteristic follows the requested
+		 * transport (RAS v1.0 Table 3.1). The RAS Control Point can
+		 * only be indicated, and Ranging Data Ready and Ranging Data
+		 * Overwritten are indicated whenever the server supports it,
+		 * since a server may send them only as indications.
 		 */
 		rap_subscribe_ondemand_chrc(rap, ras->ondemand_chrc,
-			BT_RAP_RANGING_NOTIFY, ras_segment_notify_cb,
+			rap->ondemand_ccc_value, ras_segment_notify_cb,
 			"on-demand", &rap->ondemand_notify_id);
 		rap_subscribe_ondemand_chrc(rap, ras->cp_chrc,
-			rap->ondemand_ccc_value, ras_cp_response_notify_cb,
+			BT_RAP_RANGING_INDICATE, ras_cp_response_notify_cb,
 			"RAS Control Point", &rap->cp_notify_id);
 		rap_subscribe_ondemand_chrc(rap, ras->ready_chrc,
-			rap->ondemand_ccc_value, ras_data_ready_notify_cb,
+			rap_status_ccc(ras->ready_chrc),
+			ras_data_ready_notify_cb,
 			"Ranging Data Ready", &rap->ready_notify_id);
 		rap_subscribe_ondemand_chrc(rap, ras->overwritten_chrc,
-			rap->ondemand_ccc_value,
+			rap_status_ccc(ras->overwritten_chrc),
 			ras_data_overwritten_notify_cb,
 			"Ranging Data Overwritten",
 			&rap->overwritten_notify_id);
-- 
2.56.0

