Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633F26E710
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482190; cv=pass; b=LMscmJEBz9JASdceXaG+AETtbWxhb56PZg6YtSmNMU2HcOiyGTXxKI1R3E0IlCsh/NpR0aw07NB+sp8sK1/CmE1JAaQVGGcquAb+u9b5ERsqbnM+rq7/lZ2OZ4jUoiQIJThYzvO8zZiErjzTHPvIOWfm+iEtbsyY9eQlfhihQAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482190; c=relaxed/simple;
	bh=VHpdsmCjHabt/3m7/Qb/6PdpBYdWJIIT2n5F3a6hVu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKsokptDKZN+LQU5emy6ti5hqlgopNxaQFMa+NdPncNfZYRChp/hJ/r/sBe+aAHDhNvYG7bdJ5MpDlO0Czm7AX5V5tPgaqN1TdkhhuilMngpUUjgrFxLlQdry3WeEhqGIOlp03ZHXjqYMC5TZ3VKTlnsVwxvz19H2BTzKUUh+ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=gMS+vK/S; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="gMS+vK/S"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cVGF31RgWz49QN9;
	Sun, 21 Sep 2025 22:16:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758482183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHtmWblPHRBh2jiEUHz4BaHVd72AiLsTR4IIivDBeHM=;
	b=gMS+vK/SzW/aKTXCD3V6uhev0Kk5Blw5PmNIJZ/vMOwAk9LbC0FV2FmlXaDzrtuVyxr8Zr
	YAFmsnVZXSKdaAWVWhncql7UPw5gnnhEhFXDZF8zVZh4GBRaxPkY9IAEphY9s0Rc92PL8A
	2teUV0JqCgFxM+oVG7r7Am0WI7V74TYWIYdUpIY+wOgFgEU5UhLpDngN1TlyZS0E/KcPeR
	V7V25jvdjfgWYNa/OtNKUpGr+iio8ZA7q8GD0dcKs7Is3exgQ2fAE3VvxquUTZFxfRCKBd
	4h2WnNG5L0LOkWeY5sWWBTcV0984GumPw3RCmBZWi8/w1hoJhpG9z+WLf6bLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758482183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHtmWblPHRBh2jiEUHz4BaHVd72AiLsTR4IIivDBeHM=;
	b=uMELNedTnKClArmgV4L2Oj/i0B38GI36O2Zs1fV8JILRoG/rCCOllOKhvoI/oDrErfeE+O
	z/IL+xEhc1/dW+CJOmsAAtnZ0gGdtqVy2qGYxASNkltr+yYG4V/Raqr45oPKS7dCtC19M6
	qpv/qC3ilCwUR+WmGlbUlFZPrqagNBxI457ZE4uZAd1HS0aFRCFNhARXRC85F7Ph0d04kQ
	Ak3R4CAeI79gc1JZmaXNpY0yoGb5Y1uFS4FJHD/dOBJwPf51xKA0ixhWNL7xXaTVoMyazU
	wBem3+WSz0kp5C+T12NCIRzPZy4vb5J2WTh+SD5QqyGdCcC4wOpS/hHWcJbShA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758482183; a=rsa-sha256;
	cv=none;
	b=hFE/zMgHWG4X+YTUjfJf+5VLJvc+Tl6dOsx8+V6dj4XlvXZPzgWCUJuIP19Fu9LpZezoCT
	Qwy4eOmUe+CJhxX+8gfLWNKHviUH22t8qreWWQ11H7UNtsnxmm7XTdIyZg/IK/2/sXj/TO
	uyXZlFcdeBDFzlmG6AguLj/4aBlJoFQrPVe+Fvvipu2WRILblaxDDRLk5WLXK7KCDyigUW
	KIens3W4TopE5aROeLJv+LMT3hJ/VTGDb4j75DZi73ivoen3GM1Be6WP+so9WVdjlAWJtC
	02E+ij6GgnIOqDcggSZK/lZdu+gU4/MxWXALUSd+EFRSLARqlz0Mod8YsxJTcQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 24/24] Bluetooth: hci_conn: fix ABA and locking in hci_enhanced_setup_sync
Date: Sun, 21 Sep 2025 22:16:08 +0300
Message-ID: <70212259769f594af2ea1b73b6f438a53f6462fd.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
References: <cover.1758481869.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn_valid() shall not be used on potentially freed conns, otherwise
that is ABA problem. Avoid that by holding reference.

hci_enhanced_setup_sync() also modifies hci_conn status fields, and
should hold hdev->lock during that.

Also fix wrong "return false" when "return -EINVAL" appears to have been
intended.

Fixes: 881559af5f5c5 ("Bluetooth: hci_sync: Attempt to dequeue connection attempt")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c | 48 +++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b39fb6843fad..cc1f674c743b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -286,15 +286,22 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	struct hci_cp_enhanced_setup_sync_conn cp;
 	const struct sco_param *param;
 
-	kfree(conn_handle);
+	hci_dev_lock_sync(hdev);
 
-	if (!hci_conn_valid(hdev, conn))
+	if (!hci_conn_valid(hdev, conn)) {
+		hci_dev_unlock_sync(hdev);
 		return -ECANCELED;
+	}
 
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	configure_datapath_sync(hdev, &conn->codec);
 
+	if (!hci_conn_valid(hdev, conn)) {
+		hci_dev_unlock_sync(hdev);
+		return -ECANCELED;
+	}
+
 	conn->state = BT_CONNECT;
 	conn->out = true;
 
@@ -311,7 +318,7 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	case BT_CODEC_MSBC:
 		if (!find_next_esco_param(conn, esco_param_msbc,
 					  ARRAY_SIZE(esco_param_msbc)))
-			return -EINVAL;
+			goto error_invalid;
 
 		param = &esco_param_msbc[conn->attempt - 1];
 		cp.tx_coding_format.id = 0x05;
@@ -337,8 +344,7 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	case BT_CODEC_TRANSPARENT:
 		if (!find_next_esco_param(conn, esco_param_msbc,
 					  ARRAY_SIZE(esco_param_msbc)))
-			return -EINVAL;
-
+			goto error_invalid;
 		param = &esco_param_msbc[conn->attempt - 1];
 		cp.tx_coding_format.id = 0x03;
 		cp.rx_coding_format.id = 0x03;
@@ -364,11 +370,11 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 		if (conn->parent && lmp_esco_capable(conn->parent)) {
 			if (!find_next_esco_param(conn, esco_param_cvsd,
 						  ARRAY_SIZE(esco_param_cvsd)))
-				return -EINVAL;
+				goto error_invalid;
 			param = &esco_param_cvsd[conn->attempt - 1];
 		} else {
 			if (conn->attempt > ARRAY_SIZE(sco_param_cvsd))
-				return -EINVAL;
+				goto error_invalid;
 			param = &sco_param_cvsd[conn->attempt - 1];
 		}
 		cp.tx_coding_format.id = 2;
@@ -391,17 +397,33 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 		cp.out_transport_unit_size = 16;
 		break;
 	default:
-		return -EINVAL;
+		goto error_invalid;
 	}
 
 	cp.retrans_effort = param->retrans_effort;
 	cp.pkt_type = __cpu_to_le16(param->pkt_type);
 	cp.max_latency = __cpu_to_le16(param->max_latency);
 
+	hci_dev_unlock_sync(hdev);
+
 	if (hci_send_cmd(hdev, HCI_OP_ENHANCED_SETUP_SYNC_CONN, sizeof(cp), &cp) < 0)
 		return -EIO;
 
 	return 0;
+
+error_invalid:
+	hci_dev_unlock_sync(hdev);
+	return -EINVAL;
+}
+
+static void hci_enhanced_setup_sync_destroy(struct hci_dev *hdev, void *data,
+					    int err)
+{
+	struct conn_handle_t *conn_handle = data;
+	struct hci_conn *conn = conn_handle->conn;
+
+	hci_conn_put(conn);
+	kfree(conn_handle);
 }
 
 static bool hci_setup_sync_conn(struct hci_conn *conn, __u16 handle)
@@ -467,12 +489,16 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 		if (!conn_handle)
 			return false;
 
-		conn_handle->conn = conn;
+		conn_handle->conn = hci_conn_get(conn);
 		conn_handle->handle = handle;
+
 		result = hci_cmd_sync_queue(conn->hdev, hci_enhanced_setup_sync,
-					    conn_handle, NULL);
-		if (result < 0)
+					    conn_handle,
+					    hci_enhanced_setup_sync_destroy);
+		if (result < 0) {
+			hci_conn_put(conn);
 			kfree(conn_handle);
+		}
 
 		return result == 0;
 	}
-- 
2.51.0

