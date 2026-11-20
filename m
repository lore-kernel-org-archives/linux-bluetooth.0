Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193717;
	b=NpJ9mT9cMtA3fZHAw/PzxPGZNe33wsUwdwWWI6mpi0LimbNtXQ+qQmAsGOHULeTEYsIX
	 aRAssuUaqEs5Kn/PLW9WLg9cyq+aa7xQM28wotJ7BF+UooD/HnZJzaFhqXy+wjrb/qni+
	 MOAZL7k4E5MwYks45HEZ3tixW3CRtQOYTxmqKcszp4SzfgDhoJrKSxJwQ8OaxOrwzIa/8
	 7PorwQlbEk3luQg2x+xIn9eOxLh2H0iJjVhGfWllDviy7k9ySaWyJ8w50JGGIpAGJnzQv
	 tM1KDIcP6utGq23oIv71CUK2gYMzn7pI3MQCIdmWYO7jArWmC1lxzLPaXCMIBjKKOZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
	b=LNJ5NmVjs79HYQZRd0lcRPX8+vIvc2IQKYJJZNiG804Xj1AZclgY9v92reGdWAMEyF2V
	 RLLX8ky2n6ZJhlfCoNK1i2hNVmYdFZ8wqT9hEf8v8C9nIZuASOPpS0ioliyn6f1KlM1k5
	 tufSzRA04ubNuiNTXg+o05/snZaBLp85yXs93mekL51swiKqXPIsupnuUV4nXswDf5Lpn
	 HHzNEZJCNJt7P7dK2vmofcatleoaOfKuh/cTs8Nj0TyuvQGMPkmjfnZu9YgBWVgk2+wsh
	 yDlnAZGWPpCaRsiZC75dMVeqiA2NHiTtsVqxTOW1itdrHIwxeD0c3L2dTJDi35m8wkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L8T+Q4yU;
	arc=none smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D960A2609
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A55D960A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L8T+Q4yU
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9906870a9baso604712241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193715; x=1795798515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
        b=L8T+Q4yUMp+/84kloWwLO+hmJiTmAh9sMLPBoB6lCfgT8a//abxKQZGLnQT1B3oI6A
         RWs6TFNbsVErsPeHzTRyhaTviQLjM3iAKCFvyGgNPKeLDE3qvk5XarAMO0esek5r6NGS
         wpJOTY4CKUAAm8Yeut4uoaPbN0iRFPG3iBFAnOFMyRz/tTO0NF+ShOUh4gOT1bEvjNdd
         9b5vXEl2Yma4qislniacKzBd0hyVoZSHHInEdvUf/TpkMgh6SQBE4zdrQ01VKk3aLT9y
         c41FTJGjObwiaY8BVo/lo9ZBvOBbIW9aJDZjwwQk5dwswolLZ1EcJ07uQYBZ6avxp0Wv
         KPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193715; x=1795798515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G+7q7zymhQTc4eKcMtAr/buHoRyWJV+MAtC4j6V4TBs=;
        b=xV+DmSBLZJ9dm5KaHVDIljWZjUsSOUcDv5Kff0/t2U2fKlToNaVNNl+wmvTxL8rCB2
         UwshnduEVslrempEdHF6AislWBKeoa7So8GP+LJ6UGQFp3nzoKYn2UVOMJq8NI0Sz9BK
         wEvybNlH4xW/Ytyo5m0Lq8g915FiJbxwTey/LId0OU41EDC9MPnrPeEQbi0db+PAs9J5
         7YKV3XQgE2XLOXdcJ20jYufuf8irCpfyLVuGm677cyw5oGxuXOlMXXWbaVMjjasqzHEM
         Xp2XwmvkbBOudSgCroFUHgeAxTOwDpcEdnl3Vd7YyxE1/EcCwqBYONAzXLBpkT/sZe7n
         NYcg==
X-Gm-Message-State: APuU4Z8eTGobh0RovnqVgaHSs2cy8F71CCLCGSkJ1qkUfMwdWyrQ0gSL
	m7FtZVN3m6kpzkJjdgQ6O+8kXSTjKoB+8ZV/QX59cmbINMDmTnrOzkQ7phtqnVGr
X-Gm-Gg: AZFdTZfB5241ZSEbLtxM8H9dNr0/34hu9+XzVwPc9VgKI+lZSv0Pqx7GN5/Rpg09KvL
	2pw5ffY8IQDBavvJouadlRBKdIRJ++Ll6FUNCoIpSPiPpYk5N3fWMnow3oJC7c2XVt3PTe6pwwt
	jJ9AKgsq41TBtN3VlDFtm3HHdgEHY2JixVJOdXVhi+ZI93zxiztZIVbFOzCMPV2tECgQVc2XBsm
	lAd0CR9oNsYlNvXFFEqPI9bliOtt9fXKieenw5f7DtfhOmq8Y7alZOcZZ6EdFTS+jxMHxddqrXp
	2Az00ONsAZwnSJHumLgPg7khybVJl90V283RbO7a2k3wJiuZ0iVr0gP9B9c721yKkiGYVm7lDJr
	TM00rP85Gfa25BVybjRglxF/aALtGIwAFYd20n5s4sxBlKZVJ5wiR0WWSQdm39TGuPhVUdLN9eQ
	riJQrE4xc4qY7pMACZqhThMqb2/S5aLyUwZxhwLFAho+ShLBxoOLjfTghjIaIzDyvse5Ezbq268
	D+LMLV143wWRPimR/wY+mxVkknMl7Ed2mV5tp6AFADN6staah95FdU5Lzyhbb6lZEu56F4qqJny
	lWEFCcouJtbIOMnNqPlU5BgerRmQi9fUrI/5a9IOrm7Qkf26ko4OfpLS6wXiHcHY6etV2cxT8JM
	VzNViYb/C+em+XjhlirFOL81hZZkWKC+aSrR+/uDRKi9GkLXycuFMZOrJvX0tyTNxFSVAHRwsJb
	0Ohfo=
X-Received: by 2002:a05:6102:26d3:b0:7cc:26a8:e716 with SMTP id ada2fe7eead31-7d739460f96mr1832659137.18.1795193715473;
        Fri, 20 Nov 2026 08:55:15 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 03/18] shared/rap: Subscribe on-demand data with the requested transport
Date: Fri, 20 Nov 2026 11:54:53 -0500
Message-ID: <20261120165510.1858959-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120165510.1858959-1-luiz.dentz@gmail.com>
References: <20261120165510.1858959-1-luiz.dentz@gmail.com>
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

