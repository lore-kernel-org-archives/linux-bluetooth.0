Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456290;
	b=rk9qRpicMzZRT86LclTr/xuwbKFE0ZIQJ6jCkTHFi2V5Vsn4yXbUTF8du0hMgNFpxQ8v
	 fToQhHjvMss3QMBcqDYNa2WZfFJ+vQyDGumr2nHtGrceUOXU4gf1tWbF27QQd+vXdnazf
	 QUTQgJ4ptHYjU7L6Df1z/T6N5Zq3JPUZh67Deaku2fJNcHSrKHBza68ghDQmG9Wp6TrFH
	 dYMdi8nEUDLBSj7+VYjIiLKkzQn0PKlH/TE5qhukl3Vg/5RN37zfzua93UvbXzaWYngXY
	 6JtR9yZ6YQAfQdlkv2oqDB/oB1MSU+YGSawRPkOWwKZGABeteUyYOFSErcAcyEobcBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
	b=HTleutcn1KNbcBN7xm2uJfVHOUQ9EJxJXfQofniTESfFzbovBXrB94vjzRTy2kG5N+VG
	 z2Q1a18mrNtWUqd4nky9++ymsIFx2la8hZ1ZrtfA9D2Z0Ju10UWo9UNVnF1dCprF7JQpw
	 A2hSdIxTpp0/Q83Y2S4dyxTLRu7Hz2Cm7+b0QNik1WexislzP6tGhBIqWM8ATvfmAP6FA
	 vnNV0DCJNvtEIkWjbdsonLeKK0PmI1c9kQlxJUDb1i4zj1ortplIuDlDfLuA1KVamrMcA
	 /83e6TkxxL022USFLyRjLvhpcasAXUogin1zJIb8TRAeK9puDJ4B8A/UrLhXDRPqaVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bpsLeHC6;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A5606A335
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D3A5606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bpsLeHC6
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7d88baba78dso735711137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456289; x=1796061089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
        b=bpsLeHC6kFt+AULU5pIIvAbVLHo5GE/9prAWou7eTDaK4oF1qlSUnQciA60HVqCZ8q
         paH1C+6sooQwbuKIvhaE5R5U/un1S7hGh6ZyOe8BDJMy0b40IixTqs/Wk3mQU1j+igv0
         jKW3UA/K43XOkhADQLPXyWm2kkowWuVn91gYqHooRg4N8C82Nl0HGLJUov29qxqgovq9
         oCFp3Krdy6BjU9BmuUtZyfPF2qcRbB7UJpaMTxapVx0OMiYY8WWic/HUCjdqLPKi46Ug
         h77BEcSykhPLsE0ZkjFINli6alG+M94IvSiBdPpaMGlru4h+xW9dMoMuTEzcyCxQc7IL
         UkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456289; x=1796061089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
        b=Ot7O0yaY6+q5ezDAPsD4l9w/naJdwDuXEISMFzc1AbQVkkiihf4/AqCNfu3ZRHWA1K
         v4qYTYBe2YRbYmi9vw1lBfWGQA4eBFvF6ZQCU2PGXsm3ZcNdXWzMrZhA6uiSF39BX+tf
         khj/l2vhOh6LTEYe1Tu5cSTl5/1wA6quxlUS6WtXQG1a99v5/FoWcJqAXUsyBilCmdOi
         WPpaaEsSrwl5plGLN7g2O3iOr2KutSy6d4R6sdMn3M8dXOEPVD50A8nl4JJ6SD3tQyhC
         2YNYqe+nAFu5hJ42DQC5sHDP862zFXUOuxZyMNbiT/3Qd9H1u3piWhAij5T3t/2jr0yi
         OXew==
X-Gm-Message-State: APuU4Z8UXBoHUT1KsvN7PzvRojWdoU/ncQt0J1i1lcDyOQ4V3Ybo5xnO
	m5GaQn8KcnLLFU+m5EQ5BprV8uqzEESCGYKiLmfVbIrFMJtlO8C9p2lk+8JXQA==
X-Gm-Gg: AZFdTZdG++1Ast64KaoUIQMVJjsk4l06hHj8dYzRtDdMNJaIejckdiuknN491r/o/KH
	CerH9+1x9opDvZdau8mlKw++JhDDQkasjiiDhN4Ct1tPEmbeibekBHPSZeopkb2PpE5hJ+vmC2w
	Mj97I305gdvSeZV0ksqc/un9dUgJGiZDKTlwtJq2PqEWsdlcIm5dI2FIVaJy/rirQbSbTmhhD5O
	hgM7f89zFeA3eE+NqJP7jF93wOy05RflwYdYgD7Y+Ln3AaZCYtk5jM4WQK8CUK8iuNJFN7v5UT+
	NdwPLBKJ+xec7hyE7+uCKJf40RtEakGswkrLZfh4kW6500blxrpd9DzPxSpBbN2musTV+TVkJ65
	CSOl02J2eUXpHcQQugqEzPFD6dD3AGw2vRsQbOUgL5VE1hAiq6FnrBBiX4SeBFUPmlDmbwMgt7c
	apUG85An1nNy4MCjhHX3bTaLVZOGxoNIrw+RypdMJmxDwZaBj1q5XI19ZHORu5JaRuJsLRrrPWi
	raldqAGcbJ97xDh52nOzZfcZN/4PiDXN03om1gmdwYW0uD9ugURF6gULFAbUkIVagXKRo6QKJvC
	Y5CnrcpMeFTvk9G+H3t6dT+a0zCWx+mYiIHK2/JwPgVpxjjIgBoOrdhkztzqVfn+mHEJOk66Klp
	wmOhWgU9vRxlk3BTojkkLPlkg5X3pc3cmt2EFo0w52p8IqZCr/ErLlWAS+sE+/SlASBfQDpHlBF
	RskhE=
X-Received: by 2002:a05:6102:950:b0:7d6:48c4:ed56 with SMTP id ada2fe7eead31-7d7393cc6d0mr4960902137.6.1795456289088;
        Mon, 23 Nov 2026 09:51:29 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 03/18] shared/rap: Subscribe on-demand data with the requested transport
Date: Mon, 23 Nov 2026 12:51:06 -0500
Message-ID: <20261123175125.3642617-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123175125.3642617-1-luiz.dentz@gmail.com>
References: <20261123175125.3642617-1-luiz.dentz@gmail.com>
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

