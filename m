Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108592;
	b=L2BrP/+xD1HVb3zjZ5BjSF0/8yDvrV2A6DDx4FYTZgS3gFY6oBFhxX+pzPbY4WV7RadL
	 0QONbxNAbI7DVCdyMKa/IPlv0qFpjWqr7cVsI5rLLD+2YtwYkgStRthZo8IoXsrRJVAUx
	 9izWeDrxStF5+e4GbhmGqYWxHFkf4PgVLGylZKb4idbX0qkl9IxNCWgUvaPCIFstita3W
	 FrBxtOR4BdwB3eATnfkYNoEs0QiPpvxgIgZm15PzUtx7U7iD/gufGxcUXFpqOqJVkZJfK
	 pYPqoJISkNdtc7/QCuZESzj+9qmOTxsWAAa44/qeQXL2WGjWM54iR2TD1CsjCFGLf8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
	b=eAz1CfUoiCoB+M5GeDBZWA4Ugygow9AcdF6m4Woc9dzs3hw9PS5YiCyN2/JtmJFNE6W/
	 XqPaARkv0FH2LYUGWW//2nV77h69yFM3pDx261+7STvZK+Cr3vM5/My0cSzG50WK2rZyS
	 y+nQBzekuH6fWL6csVivkYCunuOs/foaIntH78kH82Y5VzTFBBtHepwbcU8oUd7M8ejSv
	 Iv1azvopgaxmH4iJg5BIknlOJ+yyiuM4Np+L/g7RI9xp+Cn29jFqpX3ZGGqJOm8NRUwOV
	 1He08Hp4MQ8V1onoILIBoPUOouM5BKGAlf2imB/yTE4Q1BG6G7+Xj/jPdtmDcQ6UeBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G7cFH3Zw;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C7606A325
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A39C7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G7cFH3Zw
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ee36376a0dso1301481e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108591; x=1795713391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
        b=G7cFH3Zw84mx4//nOAdYY7ENT9lveBZv6n4azImxC/q8MrbQTtsEPlFhLKV2UIH6VW
         +VN2RUKVWl2M+jzhld2nXK+WQKsWqg7EyKJHBBhzknwAIAU9ZeMYDK9Tas6X9x1GugIx
         TlISdG7LUxIFOWKOJVpxMFNpPea6iU5ZOnjswuI8mHjiyI2docWO1AkO1THYEQkEyFhA
         3jNOO5dLIfeJkdHJ/2svFnbc/jxVt4U8xZGuzyGR7JSPDThzj4R+7VOl7i6i6YUuTGlQ
         T9XleiLZFu1WX3OXSeo6e1gknk5GgjbaaWhbD6GaR1OEV0icJf02GbVOup0F11xkEp2k
         cOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108591; x=1795713391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
        b=A0beiY7I7HTy+wlIOJSQaoJYEAv4Ew0HD7jFUz4aHrgpqF0MoEsHy0dyVuRKQxcmGQ
         iMRICECWQrD3JFDZgL35ElKAEpwhiduMa3336L9EnGxjiQCqUGmIfoLJlcwKzzamb4UJ
         Nv5FbnkrOvPmr5yX2vesGd2los4mVJfHO0k+FvyLfWmlE2AznWCI+KsGUM69TR/RmH0u
         OFOqyVMlwbtr8L96Ni8VXeol87jJ9Ov2H8H3jve1RZAYX4h1jAgTU+Ds6JbugFgPg3Si
         It1MJslTcp7yE7sWYJMnHWQfRp5CRyo6bJGHOdySzh2B8xpbNKtbgtO9ILNOe6CdGI1/
         XtOw==
X-Gm-Message-State: APuU4Z/HNahxpBAb2GfVUh8+sitw8/9p/y9TB0CVf+dCdMSfjOclt4Dm
	7gqwHzjmN1b+FPyoYOjchJmb+1/KxRT7LMsY4a4vJLYuJsLXMYlFNC5K7AggGy9myuE=
X-Gm-Gg: AYBFou2sakZhMWFEG+fuChKCZXmaY/po3XAcmhVUKzZ5JnTyyzPJyeVKb8B3+9n0I5u
	CvfOTpjmTZHdwNVi6MOHqpaFx3rBjEVxcAGL7C46XU+wVwa9X9xJtpIxi1nPH6lK84GjSJP7udp
	MiRoelg6FbbdL+2kcBKHYloDZhUFpAvYeBPiwCM7SkyHyaNUwNeq65bQk3hggjJbRWN7Oz6lPMQ
	ExjGKLIKBYAJ1Y+hXeCRB6Xmz6mduGdYWPlUTVycKaKHby6UYbCycaercG0k/YVHbkS5s9IQfOT
	kM/8vUbaRhVENEInRT7b1ixJlASl6XYuzmgyXMNrs7vQ6h/iaTW7hWspVx9PBIc1jd4uIs4HyaA
	XYQcnogwLPixYuw3FNbR3hNFVO75pp+LZRHbfhXv1A6wVlgaITXe5T2SUjAJeWCjyTxMks3nQ0Z
	MZe8xWCBqd8P3EsDtwlZD3Hy+Uqziy0PbV66li1awTkwl4J+rCVT4O02phRDlfggS1eHDroh9A2
	HoMsYbUf1x9mG0qXZ8j6NjtrouGQHIbOiz5VjQ1ejRvQuip6/lEPw9z7Yu/XZL+OniXkg/wfGK8
	+tMwOz3YTeeNA/2qfBlRnt/enaz0FQBtLs5SIJgRUbE+mRzfFGayui9hsuY/8pOZ+5qBcFnVsSM
	VeiKJA/CTqEu52sQ/zlwlBJXGymiyjKKk92tFQnGTAcksSzUeHUY2Pku0l+k11dtFp11BR8R8Za
	+jW8I=
X-Received: by 2002:a05:6122:1d0c:b0:5ea:b991:d489 with SMTP id 71dfb90a1353d-5ee8aed6f75mr301793e0c.13.1795108590644;
        Thu, 19 Nov 2026 09:16:30 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 03/16] shared/rap: Subscribe on-demand data with the requested transport
Date: Thu, 19 Nov 2026 12:16:11 -0500
Message-ID: <20261119171625.1014004-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119171625.1014004-1-luiz.dentz@gmail.com>
References: <20261119171625.1014004-1-luiz.dentz@gmail.com>
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

