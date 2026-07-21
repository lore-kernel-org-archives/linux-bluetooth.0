Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779D03BD646
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623299; cv=none; b=qfBpXiFuoXrLtWXsNX83GzIDlLh7ZfkJrTPyqpmyvEuKVLYUzo9nzhbpM07UV/EShGSBakX/gdoLGvR4tJhpAb1/m6WtuWrgyGilEf3rPpG2hWEhr4TkAZ4bQaDNqcJJFc9XeLwsEgsAUFLX4XHhZpq31UkzSqbsoNtglKT5WA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623299; c=relaxed/simple;
	bh=f0/II6ESIdSuDHgMkh3dphrT27CLyVbZ2fMo243t8cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzeqgCMPkF8BWswryf1NwA0TMU9VrxgQ41QHHbJ8tEFkeJpblTzCeU6N8/XaA3fDWCn5TggOiqlo4b0/l6rjtg7QhhheNpdOuQPgJGhb1Owv2n3AqAky/mHqUNXkt8yhTuDtpLclQlJiedtKZS5CD3OeLihSMwxBxPdXzWYcE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CgI5Kj9D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iCxtR6uS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CgI5Kj9D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iCxtR6uS"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L460mY037541
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 08:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JHDUZPDhoziOM00C52qGxAR6roQUXx0eAST0KSvZCKk=; b=CgI5Kj9DyVfAEoAf
	it/RVRVvmpZQHaZN3dbwUUmRgKueZlIPkl3FaeTqxD0WaqQe4haexTHkHph0dx2z
	lwysyKDkyEjn5q6zoC/ADSCsETR5avU5MNOVBJkjOTa3RIgcf/WLLfHCd+TXz1a8
	csurCzR/XUl63qD+Zn4JWWVfEGi6qIqL91UXimOiOWCcZmclU8falaexdUKb8IJU
	ZHo21lx8SVcmJ0mgsAKBBsPH+PbReTCt4fDqddjFOOX9PV+DI8LRLRev4xRMZRb7
	hx3I+3tN9ZnyFZqejh3+MGKxn36AoPoEUJC1DfbEqJaOvTOd7Ga5U0I0OvOQr9NN
	tZBjmw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1es1650-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 08:41:36 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cab041eced3so13559971a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784623296; x=1785228096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JHDUZPDhoziOM00C52qGxAR6roQUXx0eAST0KSvZCKk=;
        b=iCxtR6uSby6Mn++U32YX1A9ocN4jRs7Al87ZaYmb7JrGBC4bUCNvA+yy3AvPhmdR/h
         eNaOFbMyDl4vb6inPvoN7z3qXa4a0agBUtYqJu0bnuG+PehrRLRgfVvel8xTXDRxvI+h
         cTt8Eshp4RfUBQyZvbcLsMOKtgwA9ouXsUsr5mBoi/nK4gj/B9Bj7E5TDnB0ue+KIFym
         AaFViKGyBX4cqO+CVNYZPKvhjc496pKBDkx9KLE7F8KBKk2+/fNaA6syBq1sw6VCPH2B
         qR4JEqYLyabbz/4ViyQBBYnjTAunIrATPFFYO1AIy/k2a1X4UbSziENU5Ddpeh6AKyW+
         skSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784623296; x=1785228096;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHDUZPDhoziOM00C52qGxAR6roQUXx0eAST0KSvZCKk=;
        b=DT2DsbCOfwJwg6pBsVBqy+1ILS7j1YiwmhTiI/H2XeKQeG4/TDMhIarXoOaGnp6D7a
         yT6xspqxFV0PE2egpDjEZjZJanuoM3FNpwOEneFlj7LVwlr39NVzB15OumFCE/oX7Tb8
         ntizpVkzhJsbd8lhgWQQewzK9ULyHour3qckIX6i2NMee6nb0f6YBX/QNB/zVWOvUrhO
         b/rrOFm4yYQS6noRxvsBeuBsunYfVP7KcXG36M7wc7SKkyjHyrlRavIy3nY8emL1UkWn
         cicKG9W+NRtgY2E2hFL53NJDDF8UNP9nhJBjqXdfQK6PueODRHTh5ikYcGjZ3yxVLUOz
         wX3A==
X-Gm-Message-State: AOJu0YxRbqZmAu/PAvRK82iQCb5bMTWMzxeisTn0suti9j9Vl3gaEGaM
	WHLSEsrUAyqrL/z5zBqpIJYj6Ud1ID08MIJEYJGdW4MgNTHaVVkpbqfbF4xZ5Qb6FcNo8DoPumH
	sVKVMgj+yzWWaidnl3QjNyh1DT66coB6y5fCqD2pO8uX81YhkQ3nE8wizO3TT7/CNUUzfGKLsGE
	piCtI=
X-Gm-Gg: AfdE7cnF+XSjE1u7APwpVeYbFqb9UsW6wFUTeuiMBe1pTZNX76PcY5ISECVICe82lHo
	4L6hXjgG6w0BWHlVMMYQbK3uef2RWSMsJA+kOSA+RFfTZsSqFaRLqiY6ynb8IZHukGpfvto2I0+
	G9/awgHGQykwidlLd/4VlPVZbo4LS6PvxTHDyrd4uLOwVOMmJ/ZlljteFY+sPyADO+jgLt3CDo4
	2s3mh8ruZOnExutuqy2Q+gl+qoUfHtxSgjRV/6SS0UZvLhULMZtkd9ppVwjbjsek9X96UqXMq/D
	SunQudEkNBpRKiSdhsqUNDY4N/+rPdh/c6qZHCRfWwrJlLiWHxJGlfxSWigRqvtZmblmQjdUDkO
	P5jbqZbjLgK/DjTayrxuKCV38MDAdxQ==
X-Received: by 2002:a05:6a21:7002:b0:3c3:8aa8:6caf with SMTP id adf61e73a8af0-3c3ad6777c4mr19530531637.27.1784623295887;
        Tue, 21 Jul 2026 01:41:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:7002:b0:3c3:8aa8:6caf with SMTP id adf61e73a8af0-3c3ad6777c4mr19530497637.27.1784623295419;
        Tue, 21 Jul 2026 01:41:35 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb7c5sm38063131c88.10.2026.07.21.01.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 01:41:35 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v5 1/2] rap: use session lookup for RAS operations
Date: Tue, 21 Jul 2026 14:11:20 +0530
Message-Id: <20260721084121.688467-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721084121.688467-1-naga.akella@oss.qualcomm.com>
References: <20260721084121.688467-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SPZykuvH c=1 sm=1 tr=0 ts=6a5f30c0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=ucqL3kFcTJbZLder1q4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: X0JBwYrPWNpyCcwjhFWGkhOiVrp645LJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5MSBTYWx0ZWRfX2HNc7GFod8mk
 4c69/0CSOC3UA4rVLmegAAgcvfWsjGr0+sPYzds5VNmqbn780948NQ2ruIFO8xa6OoZTnv60+ew
 riLVtoY39S4tq/rdgwlp1TEuw3PlPtDKM8axsfK5slSDa81ON+FwJaoWrXqbwFD2NAhNuVt0YGC
 kjff9B/ZlRYSAAhQ763eljL3xlX2ueGM6B03ecL+J8aZeb4V7V9k83ehviU7L45lRYgT9jcL7cx
 jDiqjEPNdubf6K7oG7NkJQrrP19n82MylS0gQF1o0UcQsAO5RAe7Hkh2l6ngp2CBBzn9lRhP2/O
 vMUqf2B0oDby1N4B3MRtSfE31f+UIz9hjw452yAqJONZSxlDZpb0bSFvyqZabUILEti3CTI+sDR
 M6bXHtD3TLKkFx6GdCypdTQVlqopQA8kR8HLqA7hQhRR2ItNqxL3aVMJY1tjlFLB5J7oImclyFC
 xCBGQkaPJAvvFcKJNuw==
X-Proofpoint-ORIG-GUID: X0JBwYrPWNpyCcwjhFWGkhOiVrp645LJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5MSBTYWx0ZWRfX1P7AZ/7WyH5E
 dxO2V9CHe0ZkuYBgC0oiY1yyR224ePS9gB9NgGJugkSfUV02yqDh/Ed6AEOxjPVtS7nBSxl4KfD
 EjLZIIKavQfkoZKMXIbM0cq/MFujjEE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210091

Store disconnect information in RAP state and
centralize attachment handling through dedicated helpers.
Add bt_rap_get_session() and use it from all RAS
GATT server callbacks instead of the previous accessed
notification bridge. As part of the cleanup,
remove the accessed callback registration APIs,
related notification code, and the unused timeout.h include
---
 src/shared/rap.c | 107 +++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/rap.h |   2 +
 2 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index dfb272d3a..962b84240 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -19,7 +19,6 @@
 
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
-#include "src/shared/timeout.h"
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-server.h"
@@ -291,6 +290,7 @@ struct bt_rap {
 	struct bt_att *att;
 
 	unsigned int idle_id;
+	unsigned int disconn_id;
 
 	struct queue *notify;
 	struct queue *pending;
@@ -564,6 +564,40 @@ static void rap_detached(void *data, void *user_data)
 	cb->detached(rap, cb->user_data);
 }
 
+static void rap_attached(void *data, void *user_data)
+{
+	struct bt_rap_cb *cb = data;
+	struct bt_rap *rap = user_data;
+
+	if (!cb->attached)
+		return;
+
+	cb->attached(rap, cb->user_data);
+}
+
+static void rap_disconnected(int err, void *user_data)
+{
+	struct bt_rap *rap = user_data;
+
+	rap->disconn_id = 0;
+
+	bt_rap_detach(rap);
+}
+
+static void rap_attach_att(struct bt_rap *rap, struct bt_att *att)
+{
+	if (rap->disconn_id) {
+		if (att == bt_rap_get_att(rap))
+			return;
+		bt_att_unregister_disconnect(rap->att, rap->disconn_id);
+	}
+
+	rap->att = att;
+	rap->disconn_id = bt_att_register_disconnect(rap->att,
+							rap_disconnected,
+							rap, NULL);
+}
+
 void bt_rap_detach(struct bt_rap *rap)
 {
 	if (!queue_remove(sessions, rap))
@@ -573,6 +607,9 @@ void bt_rap_detach(struct bt_rap *rap)
 	bt_gatt_client_unref(rap->client);
 	rap->client = NULL;
 
+	bt_att_unregister_disconnect(rap->att, rap->disconn_id);
+	rap->att = NULL;
+
 	queue_foreach(bt_rap_cbs, rap_detached, rap);
 }
 
@@ -653,6 +690,29 @@ struct bt_att *bt_rap_get_att(struct bt_rap *rap)
 	return bt_gatt_client_get_att(rap->client);
 }
 
+struct bt_rap *bt_rap_get_session(struct bt_att *att, struct gatt_db *db)
+{
+	const struct queue_entry *entry;
+	struct bt_rap *rap;
+
+	for (entry = queue_get_entries(sessions); entry; entry = entry->next) {
+		struct bt_rap *rap = entry->data;
+
+		if (att == bt_rap_get_att(rap))
+			return rap;
+	}
+
+	rap = bt_rap_new(db, NULL);
+	if (!rap)
+		return NULL;
+
+	rap->att = att;
+
+	bt_rap_attach(rap, NULL);
+
+	return rap;
+}
+
 struct bt_rap *bt_rap_ref(struct bt_rap *rap)
 {
 	if (!rap)
@@ -729,6 +789,7 @@ static void ras_features_read_cb(struct gatt_db_attribute *attrib,
 				 uint8_t opcode, struct bt_att *att,
 				 void *user_data)
 {
+	struct ras *ras = user_data;
 	/*
 	 * Feature mask: bits 0-2 set:
 	 *  - Real-time ranging
@@ -737,6 +798,9 @@ static void ras_features_read_cb(struct gatt_db_attribute *attrib,
 	 */
 	uint8_t value[4] = { 0x01, 0x00, 0x00, 0x00 };
 
+	if (ras)
+		bt_rap_get_session(att, ras->rapdb->db);
+
 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
 }
 
@@ -745,6 +809,11 @@ static void ras_ondemand_read_cb(struct gatt_db_attribute *attrib,
 				 uint8_t opcode, struct bt_att *att,
 				 void *user_data)
 {
+	struct ras *ras = user_data;
+
+	if (ras)
+		bt_rap_get_session(att, ras->rapdb->db);
+
 	/* No static read data – on‑demand data is pushed via
 	 * notifications
 	 */
@@ -761,6 +830,11 @@ static void ras_control_point_write_cb(struct gatt_db_attribute *attrib,
 				       uint8_t opcode, struct bt_att *att,
 				       void *user_data)
 {
+	struct ras *ras = user_data;
+
+	if (ras)
+		bt_rap_get_session(att, ras->rapdb->db);
+
 	/* Control point handler - implementation TBD */
 }
 
@@ -770,9 +844,13 @@ static void ras_data_ready_read_cb(struct gatt_db_attribute *attrib,
 				   uint8_t opcode, struct bt_att *att,
 				   void *user_data)
 {
+	struct ras *ras = user_data;
 	uint16_t counter = 0;
 	uint8_t value[2];
 
+	if (ras)
+		bt_rap_get_session(att, ras->rapdb->db);
+
 	put_le16(counter, value);
 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
 }
@@ -783,8 +861,12 @@ static void ras_data_overwritten_read_cb(struct gatt_db_attribute *attrib,
 					 uint8_t opcode, struct bt_att *att,
 					 void *user_data)
 {
+	struct ras *ras = user_data;
 	uint8_t value[2] = { 0x00, 0x00 };
 
+	if (ras)
+		bt_rap_get_session(att, ras->rapdb->db);
+
 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
 }
 
@@ -806,6 +888,8 @@ static void ras_ranging_data_ccc_write_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
+	bt_rap_get_session(att, ras->rapdb->db);
+
 	if (offset) {
 		gatt_db_attribute_write_result(attrib, id,
 					BT_ATT_ERROR_INVALID_OFFSET);
@@ -2795,27 +2879,42 @@ bool bt_rap_attach(struct bt_rap *rap, struct bt_gatt_client *client)
 {
 	bt_uuid_t uuid;
 
+	if (queue_find(sessions, NULL, rap)) {
+		if (client && !rap->client)
+			goto clone;
+		return true;
+	}
+
 	if (!sessions)
 		sessions = queue_new();
 
 	queue_push_tail(sessions, rap);
 
-	if (!client)
+	queue_foreach(bt_rap_cbs, rap_attached, rap);
+
+	if (!client) {
+		if (rap->att)
+			rap_attach_att(rap, rap->att);
 		return true;
+	}
 
 	if (rap->client)
 		return false;
 
+clone:
 	rap->client = bt_gatt_client_clone(client);
 	if (!rap->client)
 		return false;
 
+	rap_attach_att(rap, bt_gatt_client_get_att(client));
+
 	bt_gatt_client_idle_register(rap->client, rap_idle, rap, NULL);
 
 	bt_uuid16_create(&uuid, RAS_UUID16);
 
-	gatt_db_foreach_service(rap->rrapdb->db, &uuid,
-				foreach_rap_service, rap);
+	if (rap->rrapdb)
+		gatt_db_foreach_service(rap->rrapdb->db, &uuid,
+					foreach_rap_service, rap);
 
 	return true;
 }
diff --git a/src/shared/rap.h b/src/shared/rap.h
index 5582635e6..a44831e6e 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -15,6 +15,7 @@
 struct bt_rap;
 struct gatt_db;
 struct bt_gatt_client;
+struct bt_att;
 
 /* Channel Sounding Events */
 struct bt_rap_hci_cs_options {
@@ -171,6 +172,7 @@ bool bt_rap_attach(struct bt_rap *rap, struct bt_gatt_client *client);
 void bt_rap_detach(struct bt_rap *rap);
 
 struct bt_att *bt_rap_get_att(struct bt_rap *rap);
+struct bt_rap *bt_rap_get_session(struct bt_att *att, struct gatt_db *db);
 
 bool bt_rap_set_user_data(struct bt_rap *rap, void *user_data);
 
-- 

