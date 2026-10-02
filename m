Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63E3F0AB8
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969297; cv=none; b=JaDwbXYnCWw+tm1FCkQgGxi4tZH8lDip6Pd979RVlKLNVmlHuaP/FlbBmtLUa365y2gCcnDGQuAHgS1+mSL6mjlPW3oxkIh90ZQtYCpIKx9idruVh0g0xXgZNcxAm78S3eKBBj5AuFggX8dOhsN+D2Z7d0LtgpM3Qb9dsgsNd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969297; c=relaxed/simple;
	bh=9nVBEDSox+wV5NPL7Iqp6pEwycQu8enqiUf5PwIKezY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKv6T1KY068mHs6Na+dlJcqLoG824onbV7Vb9vjjrbSzfG0PLWMcW0HZtaJ538nC2FpTxNapX7LeHnb0dYeTMhROkZlCAgDyBfYh1g59oZeNXOWlBAAylfd8VKqhyr/E4xZLgMnYNh4Ci1A8XUFG5Xq1NxTDAp3UGEF9A0xSvAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHlbOb+q; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHlbOb+q"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c8319dd4a5so3219591e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790969291; x=1791574091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UqT8nf+W0D7VtXFZEFtc35SaBGhQmVGcaAaxjYlI2Rk=;
        b=CHlbOb+q44mwVi/eRbUNGQbNvoGzComG5doo+LGQ6a2ZV3PMlnVVq3ABhWHsaGrzRo
         5N4sRJq+HfZsLNVozgJ5oBVklCP6d4TF8AB3WcyvfojKJwDhhiYX0avzEfdEfoZlGblC
         M9QS/CNl4YwTkY+Md3dd+NhdoGvJHkYl3llEGTXp6ZbO7TeDRlGXxrTz1v9zNW3pqVIo
         zgTtCLZK/vW/d5lEVaqf5X1o6qjbQt5QXNeE1Gxa7HOOahk2O+qMyHO5ieMfcvRDZ53i
         6SjZY5Ra3/PQBX8c+D37nPd+Mgm5sGjusPG5DvxXSUG2fIV/ei+vT3wvbNS5zI6w08E6
         NL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969291; x=1791574091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UqT8nf+W0D7VtXFZEFtc35SaBGhQmVGcaAaxjYlI2Rk=;
        b=ANOh7ykUaHtluEH800u/En5gUcMAoY2rABYuIuJ+TNkOUSSxAb98A31Aw95izdtExr
         +kuk1q6mYyhDX1qWLNIStx+adnkVv0wZJgrE3eWnmjOQW8qFXHeKDuJtU1o2BMUlMQ4o
         aTaHl3x+jGTfrsqGVB81aHQvr1qcphiBcGA+p2DP88WAr9lCW9IFFQ9Ggj4cBJUtRiBy
         IfurFIilLDqiEe3AbCsfYBnrLQ+4VGvf3ibiWUZjFibnC1oHm4k21USGTBu5819yrHde
         cUl6lM0W/0rCYOulnNmITUZwkVfK46GqZ1XZWyU8IiNs1HA+euQzGtrewSUB6BckYW8W
         MiBQ==
X-Gm-Message-State: AFq9FYJdRn6ktC5s9dCpMxHsHcYyFIvHNXcPAHqA6s2bYolDc5Kb2qZ3
	senZ2dwk4jGcT5dbEpUIsOXL3UgZ/auPzdKm6sOky9hyX9x5MFmwD9n4NPhjP1rJ
X-Gm-Gg: AYBFou0n5gR4XYvk5zPpPkr58jpDS2pxP1p2WiFjCign6RvXL1IZIKXBVfla2xjjFwG
	4g+DjFmdQ1DTXXY1dBysVkGHvng7XjeuygFacFV9MxqDFhrRfsk4yMT+1omxr/zCF9i/cYF2+Tc
	gZVj3+CgPEq6UdBoihUYhlV2b5Z9nDBwwv+RaZsDpb2hwkY+6DHww3bjDWN7Aj6lc3qp0rFQfe6
	ONuiuJSTssVr1Oq0c1WPSnZJ6CIbzgEUxEGjhhoUvalU/FxHVWcdNw6OMFbiAkn6VBZU17bW94j
	0ajR/NruCP+zUu0xiDKgWubiAUQocg//NECz4Y+aJqkocMbQTlzvb1O5xvmwF4xoxqVxXfT0FUN
	xHrUjqqZgzxsIJXXTCcV7jyYklsy+sQTS569+torPKfM+NffLayID0EjookZhtbr83CbHmFigRo
	M/wMr5gvbUs7ecBmn2GjLjbcRkvLgm+qKeJA93Plx15j7EjeplrQNKKJ6GU0PqYlmuHKGVvmjBD
	sipnrv2XkwCwvyst2tpPR7opnblfsrTyi0GlRyfkd/kyJKpplbJfQJccHpAiSJh
X-Received: by 2002:a05:6102:511f:b0:7a6:f970:27d6 with SMTP id ada2fe7eead31-7c0f498af71mr740551137.20.1790969291022;
        Fri, 02 Oct 2026 12:28:11 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98b2f15ef60sm3857759241.12.2026.10.02.12.28.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:28:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC 6/7] monitor: Add ISO link details to the analyze mode
Date: Fri,  2 Oct 2026 15:27:58 -0400
Message-ID: <20261002192759.3071262-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002192759.3071262-1-luiz.dentz@gmail.com>
References: <20261002192759.3071262-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Print the link parameters of CIS and BIS connections along with the last
LE Read ISO Link Quality counters:

  Found LE-BIS connection with handle 2560
        ...
        Link: ISO interval 30.00 msec NSE 12 BN 3 PTO 0 IRC 4 latency 28880 usec
        ...
        Link quality: 1 reads
          TX unacked 140 flushed 9 last subevent 31 retransmitted 210
          RX CRC errors 402 unreceived 12 duplicated 3

With a burst number above one the SDUs of an ISO interval are delivered
together, so pace them by the interval they belong to rather than by the
SDU interval, which reported most of them as jitter. On the BIS above:

-       RX jitter: 13.05 msec (max 45.73 msec, late 2556)
+       RX jitter: 0.68 msec (max 30.00 msec, late 0)

Assisted-by: OpenCode:claude-opus-5.5
---
 monitor/analyze.c | 73 +++++++++++++++++++++++++++++++++++++++++++++--
 monitor/packet.c  | 20 +++++++++++--
 monitor/packet.h  |  2 ++
 3 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 3a11590a0061..2b5e3087197c 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -109,6 +109,9 @@ struct hci_conn {
 	struct packet_loss rx_loss;
 	struct packet_jitter rx_jitter;
 	uint8_t sco_rate;
+	size_t lq_num;
+	struct bt_hci_rsp_le_read_iso_link_quality lq;
+	char iso_link[96];
 };
 
 struct hci_conn_tx {
@@ -382,9 +385,26 @@ static void conn_destroy(void *data)
 	print_stats(&conn->rx, "RX");
 	print_stats(&conn->tx, "TX");
 
+	if (conn->iso_link[0])
+		print_field("Link: %s", conn->iso_link);
+
 	packet_loss_print(&conn->rx_loss, "RX");
 	packet_jitter_print(&conn->rx_jitter, "RX");
 
+	if (conn->lq_num) {
+		print_field("Link quality: %zu reads", conn->lq_num);
+		print_field("  TX unacked %u flushed %u last subevent %u "
+				"retransmitted %u",
+				le32_to_cpu(conn->lq.tx_unacked_packets),
+				le32_to_cpu(conn->lq.tx_flushed_packets),
+				le32_to_cpu(conn->lq.tx_last_subevent_packets),
+				le32_to_cpu(conn->lq.retransmitted_packets));
+		print_field("  RX CRC errors %u unreceived %u duplicated %u",
+				le32_to_cpu(conn->lq.crc_error_packets),
+				le32_to_cpu(conn->lq.rx_unreceived_packets),
+				le32_to_cpu(conn->lq.duplicated_packets));
+	}
+
 	if (conn->setup_seen) {
 		print_field("Connected: #%lu", conn->frame_connected);
 		if (conn->terminated) {
@@ -902,6 +922,24 @@ static void rsp_read_bd_addr(struct hci_dev *dev, struct timeval *tv,
 	memcpy(dev->bdaddr, rsp->bdaddr, 6);
 }
 
+static void rsp_le_read_iso_link_quality(struct hci_dev *dev,
+					const void *data, uint16_t size)
+{
+	const struct bt_hci_rsp_le_read_iso_link_quality *rsp = data;
+	struct hci_conn *conn;
+
+	if (size < sizeof(*rsp) || rsp->status)
+		return;
+
+	conn = conn_lookup(dev, le16_to_cpu(rsp->handle));
+	if (!conn)
+		return;
+
+	/* The counters are cumulative so the last read has them all */
+	conn->lq = *rsp;
+	conn->lq_num++;
+}
+
 static void evt_cmd_complete(struct hci_dev *dev, struct timeval *tv,
 					const void *data, uint16_t size)
 {
@@ -919,6 +957,9 @@ static void evt_cmd_complete(struct hci_dev *dev, struct timeval *tv,
 	case BT_HCI_CMD_READ_BD_ADDR:
 		rsp_read_bd_addr(dev, tv, data, size);
 		break;
+	case BT_HCI_CMD_LE_READ_ISO_LINK_QUALITY:
+		rsp_le_read_iso_link_quality(dev, data, size);
+		break;
 	}
 }
 
@@ -1080,9 +1121,22 @@ static void evt_sync_conn_complete(struct hci_dev *dev, struct timeval *tv,
 static void set_iso_interval(struct hci_conn *conn, uint16_t interval,
 								uint8_t bn)
 {
-	if (bn)
-		conn->rx_jitter.interval = (uint32_t)le16_to_cpu(interval) *
-								1250 / bn;
+	if (!bn)
+		return;
+
+	conn->rx_jitter.interval = (uint32_t)le16_to_cpu(interval) * 1250 / bn;
+	conn->rx_jitter.bn = bn;
+}
+
+static void set_bis_link(struct hci_conn *conn, uint16_t interval,
+				uint8_t nse, uint8_t bn, uint8_t pto,
+				uint8_t irc, const uint8_t *latency)
+{
+	snprintf(conn->iso_link, sizeof(conn->iso_link), "ISO interval "
+			"%u.%02u msec NSE %u BN %u PTO %u IRC %u latency %u "
+			"usec", le16_to_cpu(interval) * 125 / 100,
+			le16_to_cpu(interval) * 125 % 100, nse, bn, pto, irc,
+			get_le24(latency));
 }
 
 static void evt_le_cis_established(struct hci_dev *dev, struct timeval *tv,
@@ -1110,6 +1164,15 @@ static void evt_le_cis_established(struct hci_dev *dev, struct timeval *tv,
 
 	/* Only the Peripheral gets a CIS Request for the handle */
 	set_iso_interval(conn, evt->interval, link ? evt->c_bn : evt->p_bn);
+
+	snprintf(conn->iso_link, sizeof(conn->iso_link), "ISO interval "
+			"%u.%02u msec NSE %u BN %u/%u FT %u/%u latency %u/%u "
+			"usec (C/P)",
+			le16_to_cpu(evt->interval) * 125 / 100,
+			le16_to_cpu(evt->interval) * 125 % 100, evt->nse,
+			evt->c_bn, evt->p_bn, evt->c_ft, evt->p_ft,
+			get_le24(evt->c_latency),
+			get_le24(evt->p_latency));
 }
 
 static void evt_le_cis_req(struct hci_dev *dev, struct timeval *tv,
@@ -1152,6 +1215,8 @@ static void evt_le_big_complete(struct hci_dev *dev, struct timeval *tv,
 			conn->setup_seen = true;
 			conn->frame_connected = frame;
 			set_iso_interval(conn, evt->interval, evt->bn);
+			set_bis_link(conn, evt->interval, evt->nse, evt->bn,
+					evt->pto, evt->irc, evt->latency);
 		}
 	}
 }
@@ -1179,6 +1244,8 @@ static void evt_le_big_sync_established(struct hci_dev *dev, struct timeval *tv,
 			conn->setup_seen = true;
 			conn->frame_connected = frame;
 			set_iso_interval(conn, evt->interval, evt->bn);
+			set_bis_link(conn, evt->interval, evt->nse, evt->bn,
+					evt->pto, evt->irc, evt->latency);
 		}
 	}
 }
diff --git a/monitor/packet.c b/monitor/packet.c
index 1e177d0abd3d..c21c79f75971 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12161,7 +12161,7 @@ static void jitter_add(struct packet_jitter *jitter, struct timeval *tv,
 							int64_t expected)
 {
 	struct timeval delta;
-	int64_t arrival, d;
+	int64_t arrival, d, period;
 
 	timersub(tv, &jitter->prev_tv, &delta);
 	jitter->prev_tv = *tv;
@@ -12177,7 +12177,8 @@ static void jitter_add(struct packet_jitter *jitter, struct timeval *tv,
 	jitter->last_dev = d;
 
 	/* A sample arriving an interval or more later than expected */
-	if (jitter->interval && d >= jitter->interval)
+	period = (int64_t)jitter->interval * (jitter->bn > 1 ? jitter->bn : 1);
+	if (jitter->interval && d >= period)
 		jitter->late++;
 
 	if (d < 0)
@@ -12212,6 +12213,7 @@ void packet_jitter_add_sn(struct packet_jitter *jitter, struct timeval *tv,
 	if (!jitter->have_prev) {
 		jitter->prev_tv = *tv;
 		jitter->prev_sn = sn;
+		jitter->ext_sn = sn;
 		jitter->have_prev = true;
 		return;
 	}
@@ -12221,7 +12223,18 @@ void packet_jitter_add_sn(struct packet_jitter *jitter, struct timeval *tv,
 		return;
 
 	jitter->prev_sn = sn;
-	jitter_add(jitter, tv, (int64_t)diff * jitter->interval);
+	jitter->ext_sn += diff;
+
+	/*
+	 * With a burst number above one the samples of an ISO interval are
+	 * delivered together, so pace them by the interval they belong to.
+	 */
+	if (jitter->bn > 1)
+		jitter_add(jitter, tv, (int64_t)(jitter->ext_sn / jitter->bn -
+				(jitter->ext_sn - diff) / jitter->bn) *
+				jitter->interval * jitter->bn);
+	else
+		jitter_add(jitter, tv, (int64_t)diff * jitter->interval);
 }
 
 void packet_jitter_add_ts(struct packet_jitter *jitter, struct timeval *tv,
@@ -13617,6 +13630,7 @@ static void set_iso_interval(uint16_t handle, uint16_t interval, uint8_t bn)
 		return;
 
 	conn->rx_jitter.interval = (uint32_t)le16_to_cpu(interval) * 1250 / bn;
+	conn->rx_jitter.bn = bn;
 }
 
 static void le_cis_established_evt(struct timeval *tv, uint16_t index,
diff --git a/monitor/packet.h b/monitor/packet.h
index 85b7f2ff762c..77921af39263 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -59,6 +59,8 @@ struct packet_loss {
 
 struct packet_jitter {
 	uint32_t interval;	/* Nominal interval in usec, 0 if unknown */
+	uint8_t bn;		/* Samples delivered together, 0 if 1 */
+	uint64_t ext_sn;	/* Extended sequence number */
 	bool have_prev;
 	struct timeval prev_tv;
 	uint32_t prev_ts;
-- 
2.55.0

