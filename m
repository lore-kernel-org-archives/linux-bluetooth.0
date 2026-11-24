Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534743;
	b=o5uykWImb1zOo3Wt2bjT4/u8a+6o1HSUcTfu3RB/xhrCEl4fOjuqzcyW0u7gDj+h3iEq
	 2IDAvih/0sF8zl+54Varv5gLJSMTw/P0s33/FzzukCCCFn91+jVCVxTtXbu48EbUXWuCK
	 P9vaTcTLAHbrX99V6WBD+OrvhiPJCxzIDrXrjEDpal9x4eVcK1G0yg0r5PQ4axm3rKRWR
	 5z9Tk1R3tnRaSQbwGWQiYBgHyPHFn9Rs+CwQC9B/RgCbsHyvU6fAQfW1qY1C1Ok7IrH9e
	 OkJKW5iL7/sIRVG9Pj/9iL03rk6/mWXA46Mw+UoJhVl9SzJukl0rN+sKJEwkQootb2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
	b=s/qohkJBiVYWDFYO5McFyESVl7rH5xeKvHrIyZSwVpuuCCvcgcH/AWUFNqOCvLTr4+Ht
	 JVekGo+M1Pu+njBjPmvx3BRX+q51eLabcRRIuLLtPlRqt0PQI0qVKMUV2AmYxIVazYW+N
	 TnBTf7B3F6ABo+yi2IHiHI2WFFZ/YyQupJGwWJ+g7e2Kd0RXutKdqcMYsCDU19DmgZej9
	 UwLvdZIUeSqUrS2EvrxWZjSBfmKvlmO1HmXw1B14zui3SfAlADmYN1QPREQTbzc7wX3/U
	 j4yWy/OI2DQcOOoglB8ShBYJdKSkp7BaBUh1ge/zndVx7Efoz0ns90GbnyV1H+j5iww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=geg7Ytzu;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E8A606A335
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3E8A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=geg7Ytzu
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5ec690faf85so1622475e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534742; x=1796139542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
        b=geg7Ytzuc6NjRgmKopJNHiuwFdb+5TWfjXDBh494Z8gZsEeDDrRlJhLa4g3rD5eqmC
         4j+rVPaxuHYivSHFmLipQ5iX9jj4ikpVHJzSYxERuPKbkGqvbkpuGj+A5rattrH18XiS
         EAe2mxRh7X/l+hxlutrUmjHS7l0VRuAXy4xk4tMdhicgzAKTX4mDZ3u3RWPyiMLZsIKG
         JQFGtyPNeiFwuGoyDVzZ2vzB7qrf+3BR/4CzYe6CaLRjNCvZ/blUoCJIcTlf3Zw6cT1+
         /ZzByduf0KBfp0c5oUOeAY/+iIMES4vjuwRdqxHooElztCAf9qbXlDBEYc1uMjM37aSJ
         Uo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534742; x=1796139542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
        b=WPeTG10BfTOtpBputKLOEqX/QTfHEoi3oO8OqCV3QULArcSc38tkkI/oMd+hjAgkJr
         gR2F9itLrOKaa3RSGfiIFjMwtxuDi+rNFYdev1ZtZFHvq1RQ8YdSd21xHW2lT7shj/1o
         d8jBLg40cj39NHnCbxvHJIxsyz4sJ0vzaVfu7dJo0WmR33CVeAfJdmOKZkhKUlEkiVfd
         N7Q9Y0mPtB1ytJ7NrgFh4JHDAkJsnta2Cfsgg2ArAOpP/hD0H2lmIWofYLUUD0jnLwnc
         hFziHMQh2uVl5msIUW/Y9GGLhNJBHMbi+Z1mEB1Gl678hdzSN2xl+5r/8+PZoBeoBgP8
         CLfw==
X-Gm-Message-State: APuU4Z/H4hk6FW+sRrEphHZLdBQpzOYuzOzmwyA0bffzRBwKtcX7xban
	DGe6yXyqkX0FA3kvYsHYuN4jZnbi/tRAJR16QW4GsHE20XL0cIvS6L5Cp2Iabw==
X-Gm-Gg: AZFdTZfWfu7RUHkjBK9VIGmMQ6zwNmtGRdEAny4JN7MUvodp2U0vyRilQEbP+AdT5V/
	3XIk73sLGZnU4GkaJuFGVpKxL6g5NTySUp/C0pFK+s6E8+NTifdBFgPIwGnjpUApJz8K13OUuvP
	tTe7FBeS3Wo0YeQ/g3Q+05abcBr4Y8J7S64i9pfMrs/34l/VMKJtMBxotTWEPEZ6BLIRmWmiNFl
	xpvch/7KqsaOwLbIhmBD2aqw2wBw8Xc7vkZNzboDoTNZila6hf0A3/LclqSr+Up4t8d8BTPmYUf
	Ix7rlhR7pKJYrFywHj9r6VSBJptmFx0hmMzFFMtaWxt8SOFlGiotv67RnJpAmeJLm/ATPe7wqnI
	wXG8THXU8jpFInZRKsZVWIcaGjRYSxCjZopKdb/zqz1FfnmvNYrXhAHYWVTyu4P+z81lVUgr08k
	ORMUvcODQM3REJrWpLrKvPK5OuGEvsjTtF1h3JA7ITAgKkYLR9iPvnNBvxa0cr3BiPKH3h0ag0F
	+uwQ3LBEVAgB3ANqcy1gJLSLANB46m884Fp+FHlmWFBfK2PjjdltG9B3XOScHMPQTaIuh4wHvqh
	80PW3mUwGWd4ISHMax6nTIKgHwL2C1L4pGM7TnkGsssBNsLdZehSxWZu2bB4LOufStZe/GMUI+d
	LH3bioukjjiZBIFYoP3Z1j8g0hyIbnEfbk9L4WIyIP7gr6iMtzHsOzbiajhvRjwIqgLAeoNU47Q
	S3fEc=
X-Received: by 2002:a05:6122:1d0f:b0:5ea:d649:d1bc with SMTP id 71dfb90a1353d-5ee8af45319mr9044065e0c.18.1795534741626;
        Tue, 24 Nov 2026 07:39:01 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.39.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:39:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 03/18] shared/rap: Subscribe on-demand data with the requested transport
Date: Tue, 24 Nov 2026 10:38:40 -0500
Message-ID: <20261124153856.216054-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124153856.216054-1-luiz.dentz@gmail.com>
References: <20261124153856.216054-1-luiz.dentz@gmail.com>
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

