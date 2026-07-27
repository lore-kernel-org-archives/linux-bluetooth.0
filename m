Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842A3D333F
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 07:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135618; cv=none; b=e9vCM/AsrHITqfuzL76WOza5/zTC7vsih7FVT94+lKVT8co1dMbWMtEoy359EE2cBC4HqrNdMl5GrifMx8rsj9wUxxa3QfY9iEp3tZhHMP8EIu69sWNe20pqjzxtpE4nFpsNJiwR1S2MqXN8yOVpmIbbQDYPMI35FVbR1WnMWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135618; c=relaxed/simple;
	bh=OXK2cC7+us4KHwuT53VZRgrzH+14azmyz/k+Z1dCVwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDr8TURNxKlnl1Zex3pj9ek/EValMPkLsa2Dt7cl80NzqznxDwnEFEWvfPB98rz7ShLCqFwuga6DcrnRLQPrXs1FO0lZkDJVYKLNIYq3Q5quFGn2Pazse0MM+NGfuTbTXgclVpl9wyXxZRY8ywfJu4RHfagdQy8QaS6VOfxZs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iA1HQhA9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j0Xl69Lk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iA1HQhA9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j0Xl69Lk"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1ftN82572006
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 07:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mgjJHYaTp6IblDYTn+X4BJh1GjAWwK0yiRk9S0gXG0k=; b=iA1HQhA9b77A3Gy6
	0que94E6o0Y0LT1fDFvF8fCmRgSxSUUhO+gy9E+hIk/fRMuPNcrwYO7CizKcTQl3
	Gv7PiwNiEhYJn8HwAfoSjMf1nVl5wUiX1ibhWUx8Cdi7EhR3z/o1PqToqD18UoqF
	PuqRskJLlZftbYii9hAOdoIRmXbkLjyN/AbW3TtD1b9nE+OnOtf2kgIHNbK1oNQz
	QAoz7wU/w6dfs7Vm5z9h0b5eBy3cNioyUfsQS8WTIKHPw7JkeFZlgH3ZFOdVzYGX
	PlwxTSz6L6Iu3PhlOe8qnkV3u7g3h3NE85M7HAM+r3J9+xR2vM5/2AgDBDY2qa+Y
	WZ+nVg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm3sd0j0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 07:00:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so5170876a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 00:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785135607; x=1785740407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mgjJHYaTp6IblDYTn+X4BJh1GjAWwK0yiRk9S0gXG0k=;
        b=j0Xl69LkFymoiVvy3PktSmVNdxqASCDIHBCgy13/wPCDSNby9N8F3jzEbjbKYELj9j
         L5RMQgXC+uJ7OjxCEmcyrIQny7mrRCCZ2x+KSsrz0FWmrvmrZIuEqzs7q1cUcmAUiOFl
         6WNRaN2QJ/XOy/szaDxcNAXh5zvQL/2GZGrK10HDdFUL825IlVbu272f+cffeRSPpJva
         eVkC0ZkxDszpSh7mKlcEowU37pkNcyUwvjWl8/TU5hKnNhKmwi5Wg40mUV/p6pENJeuT
         v3Qbajh3P7q8lyxaGl5ESMZS5SNY5zEeM1JcE5BuZdQZ4pls3iDAp6AfoNRLbpNcNw5k
         2E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785135607; x=1785740407;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mgjJHYaTp6IblDYTn+X4BJh1GjAWwK0yiRk9S0gXG0k=;
        b=nzoMham2tTR5S+XchLgTKova/lqw0Z4pqZYl7nkfy4gHap2l+EBn8uQU8nZ5g+CtT4
         nMoTtvYcey4Qzh1IV5K1lhTdtoKgIY8DTZyy0WpBuTDVUPk8P5FbAWlq45IZIDVTmY74
         z/zvNxt8Yh9/WV6s/g6gjJ1/DamdNnrfVeTYQzmiEXpXUl4HVoSNqkvqR8VMM8cZDbz1
         ALSYRZOxwDt7PHAuf0IShWi1hFAgGMEP2XJ4r+TF3xRwJ325M6wgsRnDnRtBEqIL3vrw
         uImxT/hjCL406BDUoO6mr5MWd4x0cef9eyVxVH8xkj6fVTkBHfy9fULURcNEh3CHHVj0
         g+rg==
X-Gm-Message-State: AOJu0YwywhoL6/LRx2FjK/6tI3BJruGh2OAuouZQDg33yPBsFI4NPAvC
	82GgiuDXf/XgkIvLjYDgH4ymYfGkl2VK8sxTMiPzUR3+4zwqxZ1IwZ1SEXQjBNR8BaPIxaTKlZy
	jM7kvNP6Z3t6Oi8AgD2KrnZLtfVsUrlRSxmAhPzYQJUM14fZFEBXvszBGB5NltW6eOa4oRYJsL0
	06t0s=
X-Gm-Gg: AR+sD11tCQ2mZageFIT7so7GOTe4hiUaQtO2ujDFg6XK2Y5f8WGtpfPl96rxcElvrp2
	Q+Ejv+x6e+1WZGK8PYS9uyDUrEIwkd7RCHexZft+y4dI8vICaIBjmHyXl3EzV/7kztRSFShyE+M
	SP+dix2+22holy5SvjXn5G7wJcSOZD2xldBVu6x1NHYlabbS/IWuJEjCVolb8K95gczSB2AQBV1
	HTbp5UrFnaRQD4eFlPpPSGHaOB0+2I4Q8/JGRvSYpcFATG2HDcPCx0W+0Y6iApzNN+0VdZzrqYX
	+TBd1UOkxjUFJmcqK+0rrNKjSsH7uwlj5nT6vMoxrKD3luOXuvawkShNWtxu3okXSBM6JQektVi
	iQDtGk0egxROf/3sYH6AVUhshTPlQAw==
X-Received: by 2002:a17:90b:1846:b0:381:5bd6:eb19 with SMTP id 98e67ed59e1d1-38f295232ebmr6953634a91.18.1785135606604;
        Mon, 27 Jul 2026 00:00:06 -0700 (PDT)
X-Received: by 2002:a17:90b:1846:b0:381:5bd6:eb19 with SMTP id 98e67ed59e1d1-38f295232ebmr6953596a91.18.1785135606018;
        Mon, 27 Jul 2026 00:00:06 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm43432530eec.4.2026.07.27.00.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:00:05 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v6 1/2] rap: use session lookup for RAS operations
Date: Mon, 27 Jul 2026 12:29:53 +0530
Message-Id: <20260727065954.1053484-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727065954.1053484-1-naga.akella@oss.qualcomm.com>
References: <20260727065954.1053484-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA2NyBTYWx0ZWRfX1w4gQ6kLBs1W
 xb0sKH06J3jQvnxihIY7xjmQv6GvPPCs82pCSR9nV6JayUE7xEaOCPyYChtrgWJbFeTfRyJOVXo
 Au0jqm/MDOzPe6uLCaf7jokVVHINZaiSWFxRZ0rNTZltHi6In4wzkxKGrlWdRyCRJKwlzU4rMAt
 1SMKSp/v5Pn8D+qBIpS8izN5d7Anltq1N+RZSItCn+nQoG4XvNamJQ6fA+7pjilgpvf3M7S/dh2
 FlIgk3k5xOtAp2gO6fTilDl+oZYx3/inVFFlklSDsoBGBJ4vN3MgQtr44cTizRlVR7AxK1KVW8j
 6M3j6RUlcUGQN7menDyre65e1IjtCTE89sP1yVfS0LorMQHH6SrX/pIMasSmO84dmaVqmlwTdb/
 HJyZbQdFHMfvOBJ7Ag7kILHSvXulSsAw1dcnXmpfUIOenEOpKGRkFuLdnP1xIKeyDp+IQeogCgk
 oAN/PeZ0mkIlpq6DyMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA2NyBTYWx0ZWRfX+ucLr949JhZV
 Vl6l4iAyCoSmD8VfC/4sFSIlz9nWroLhjt1J3L1fuA+edSBHSjkOgoVfBEqBld5UCo4JjD/r1M8
 /B0UoZHVmjAxKFR1biFDNPDVQFgvGvg=
X-Proofpoint-ORIG-GUID: sfQ4xyu-jDQg_pOnqohTb4vft31470_8
X-Proofpoint-GUID: sfQ4xyu-jDQg_pOnqohTb4vft31470_8
X-Authority-Analysis: v=2.4 cv=KanidwYD c=1 sm=1 tr=0 ts=6a6701f7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=OQyQrhNhWUCbm7MB7LEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270067

Store disconnect information in RAP state and
centralize attachment handling through dedicated helpers.
Add bt_rap_get_session() and use it from all RAS
GATT server callbacks
---
 src/shared/rap.c | 143 +++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/rap.h |   2 +
 2 files changed, 141 insertions(+), 4 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index dfb272d3a..b0c5f8ae7 100644
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
 
@@ -653,6 +690,34 @@ struct bt_att *bt_rap_get_att(struct bt_rap *rap)
 	return bt_gatt_client_get_att(rap->client);
 }
 
+struct bt_rap *bt_rap_get_session(struct bt_att *att, struct gatt_db *db)
+{
+	const struct queue_entry *entry;
+	struct bt_rap *rap;
+
+	for (entry = queue_get_entries(sessions); entry; entry = entry->next) {
+		rap = entry->data;
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
+	/*
+	 * A rejected attach (e.g. a duplicate session for a device that
+	 * already has one) leaves rap already freed - don't touch it.
+	 */
+	if (!bt_rap_attach(rap, NULL))
+		return NULL;
+
+	return rap;
+}
+
 struct bt_rap *bt_rap_ref(struct bt_rap *rap)
 {
 	if (!rap)
@@ -729,6 +794,7 @@ static void ras_features_read_cb(struct gatt_db_attribute *attrib,
 				 uint8_t opcode, struct bt_att *att,
 				 void *user_data)
 {
+	struct ras *ras = user_data;
 	/*
 	 * Feature mask: bits 0-2 set:
 	 *  - Real-time ranging
@@ -737,6 +803,9 @@ static void ras_features_read_cb(struct gatt_db_attribute *attrib,
 	 */
 	uint8_t value[4] = { 0x01, 0x00, 0x00, 0x00 };
 
+	if (ras)
+		bt_rap_get_session(att, ras->rapdb->db);
+
 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
 }
 
@@ -745,6 +814,11 @@ static void ras_ondemand_read_cb(struct gatt_db_attribute *attrib,
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
@@ -761,6 +835,11 @@ static void ras_control_point_write_cb(struct gatt_db_attribute *attrib,
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
 
@@ -770,9 +849,13 @@ static void ras_data_ready_read_cb(struct gatt_db_attribute *attrib,
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
@@ -783,8 +866,12 @@ static void ras_data_overwritten_read_cb(struct gatt_db_attribute *attrib,
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
 
@@ -806,6 +893,8 @@ static void ras_ranging_data_ccc_write_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
+	bt_rap_get_session(att, ras->rapdb->db);
+
 	if (offset) {
 		gatt_db_attribute_write_result(attrib, id,
 					BT_ATT_ERROR_INVALID_OFFSET);
@@ -2794,28 +2883,74 @@ static void rap_idle(void *data)
 bool bt_rap_attach(struct bt_rap *rap, struct bt_gatt_client *client)
 {
 	bt_uuid_t uuid;
+	bool attached;
+
+	if (queue_find(sessions, NULL, rap)) {
+		if (client && !rap->client)
+			goto clone;
+		/*
+		 * Already attached: treat re-attach as idempotent rather
+		 * than failing, so e.g. a second rap_accept() on the same
+		 * session succeeds instead of erroring out.
+		 */
+		return true;
+	}
 
 	if (!sessions)
 		sessions = queue_new();
 
 	queue_push_tail(sessions, rap);
 
-	if (!client)
+	/*
+	 * Notify profile callbacks before rap_attach_att() below runs, so
+	 * bt_rap_get_att(rap) inside a rap_attached callback only sees the
+	 * att already set on rap (e.g. by bt_rap_get_session()), not the
+	 * one about to be registered a few lines down.
+	 *
+	 * A callback may reject this session (e.g. a duplicate ad-hoc
+	 * session for a device that already has one) by unref'ing rap,
+	 * which can free it. Hold our own reference across the
+	 * notification so a rejection can never drop the count to zero
+	 * while callbacks are still running.
+	 *
+	 * Releasing that reference below is what may actually free rap
+	 * (via rap_free() -> bt_rap_detach(), which removes it from
+	 * `sessions` before the object is freed). Check membership only
+	 * *after* the unref, and only by pointer identity - never by
+	 * dereferencing rap - so the check itself is safe even if rap no
+	 * longer exists.
+	 */
+	bt_rap_ref(rap);
+	queue_foreach(bt_rap_cbs, rap_attached, rap);
+	bt_rap_unref(rap);
+
+	attached = queue_find(sessions, NULL, rap);
+	if (!attached)
+		return false;
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

