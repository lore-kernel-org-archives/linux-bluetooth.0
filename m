Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DCE397338
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594588; cv=none; b=jTfD5Irsm/apnETFnGD6ZmCJmL42ycZOq9RCiU81QW0c295cwwu3xIU+HHqdazv3o16gF3R1BLw1Bg+SBpZjlpd38cFXFhM+q+t994Igvb/sBQkgn61N3/JbHTYrM02JG/eoFtHTFEGbisiWA/37dPy/6lhF4qb67UBWoI2THTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594588; c=relaxed/simple;
	bh=pRkSZMlY9bLTCDGmHyIxJ/UYDcRJENV3ktE2SQbZwSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXBmYzlZC9AazAFWv3u5hfy4HDTW7UhYiv8JGNvy/lDITBeccy5FLTCBmx0KtRPfChftG2RvfStcsk1cg06pDNxJDIuZ2KOlAMZIhPVmCTOLUF/8apAGba9O4dsXgFxdxm3ma7Dvqog7eCE87xXgkKOnRxDk+FKNUFxlnNXh1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P5ar57Rq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lj0dtkPs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P5ar57Rq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lj0dtkPs"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G64TVX2336868
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 07:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4i4ha+vCAkMWpKwqmufTypgA1DoCgaCikSn4SjVWyto=; b=P5ar57RqZtgJwO8b
	IoK+219AzLyhg3hHNpXAOl3UYNLYiwnvci+02vkovBrB9JuvTIVDtY58L+ej/OEn
	aT+7+zrZqlHPHw7yi7xondQ/hY0ZUr0Wypkm+XLE0O5ewUFNmxPYx4d7pMLTGgWB
	ZCZFAdH+R5SUIYRTQ8Le0/O8nDeKv8X1C2LPKOJXAGlYRjWwsALUaHBkBBXlHhKh
	rUctI2upy1aWQQgzq0ybgC2wV+9Ytfufwky0jza05BbBk092n5Qc6EPUtXuVFtzb
	oLplhJe4xeAy0xXjUBSgjm80C8HNI2jDAEOh/R0NbKtY1K/14xJTzfsZSV58NaHX
	EcOb2A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0ng17-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 07:23:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c85a2c0b56fso4094446a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 00:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781594585; x=1782199385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4i4ha+vCAkMWpKwqmufTypgA1DoCgaCikSn4SjVWyto=;
        b=Lj0dtkPs4u0tQ4FLSZffbkeBd3RXObBAUdMrgk5oXaAOPCHkK/wtVAZku+9kmGD6pv
         05BjDTVSM3DTNJT5AiVliLFfCdhpU4wQ7vUtRknf5ERu6FRixUq2Kl3Bwereq6VnpNl2
         16mK5FqhKlMTwUhfCUvBh/MZHPQN4CtfklwOuM5hjdxpTa4CHLvevPmi0+Rdoq8m7VIs
         XY6Xjpw6Ms0TE1oCpAPXuZrw35OYx6qj3OPopMfjABDoUYT42EQjduF1xR38m+nMD/4k
         e8Xt083baITCLj8L6bFN0O/8OFFTfgGF7yDyzgWSHL2x7leB1p2ZgSECjy2TRUvXVaxp
         Mlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781594585; x=1782199385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4i4ha+vCAkMWpKwqmufTypgA1DoCgaCikSn4SjVWyto=;
        b=ERuTmrtSktBkYuisHNRNKI7DawIyRRKDhPUFo6qWpq5ye9THw3da6GjfjvWrYKLno/
         kvZ+R3+EvQaODJe19satWOtcxZGg4nGU5jmmLX3+NIcxQFS2UfB0jWsR/iv/1f+/fRpN
         sLibzKXIMAgrGPIOxJHsEg5Gkh1x2yiO+3uiTFi8rEMs2j6vnj3utZsodErKcWmDFLYr
         Rpy3h5pf5BMJpldotxwkJXjUFLXV9qdxFNn3mZk9iS15tmWZHdmxu0n+oK5vimXfQ4lt
         5XSfPvkTf3BqLgvMClai9j8OYhgxXbtFR6qJ2nxQiwKjaF7IRBC3gWzy8y8OxCPFuRFu
         /Lbw==
X-Gm-Message-State: AOJu0YwgMcsxVgJg/Uu29r921t90pD0LJuF8UfTq39jQGQddIuipwVKj
	rQr4D/OoXVXLQMjs1k5qZhZw77Qfeuc9xyUXxRmPNbFD623oUoYdYnHxTFwWBLFCpK2i8Vnspq3
	T2yYFceinCg6t8GzarZ6EvOD/ExK5b2GvubiuCIN/ANJy3q4KutLuV1mxIM0FhHcgzAuU8KPSpn
	HC8Mw=
X-Gm-Gg: Acq92OHiL91YYkMsBiDmAwr10WrV5/tH6do8rI5cxWApCb+QIG1vd7ymVeTsMcvRinl
	K3FTVlMP+U03DHD2bCL1mH/CYGrEZAazYyBvxbrcr2ZgyB/PP5IXfBCC6f7N/Mh+YgFqM5FbzzN
	Eiqr8F64OlIckzRkUlgVZ5eophFZoFxCBIwyTBqUqb8GnOfVorzf2G445RFTDfUKnzKh4uqfBdP
	LBERw3tTprM7lAyHoPdlFa1/zxhHEcHtmRp6IlFWHwSCb3T4/mqRxUYdWUWgK+yD8n036u5f6IP
	LX4Ii72KoGR4qrClcAfmhRAr3onVebs4wbt+H11xIX3iz1QhiRe12El+0F6LbY+aSKRzfeBfHFo
	nmlVVXoVS2ZhUVlg4x3SYhfh3Z6RXQJ60j0xd0fF3yCn8aF9wSuQ=
X-Received: by 2002:a05:6a00:3927:b0:842:6004:3fce with SMTP id d2e1a72fcca58-845155f7ba7mr2302621b3a.26.1781594584205;
        Tue, 16 Jun 2026 00:23:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:3927:b0:842:6004:3fce with SMTP id d2e1a72fcca58-845155f7ba7mr2302564b3a.26.1781594583263;
        Tue, 16 Jun 2026 00:23:03 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b057461sm14394934b3a.58.2026.06.16.00.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:23:02 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 2/3] profiles: ranging: Add CS Initiator cmd and evt handling
Date: Tue, 16 Jun 2026 12:52:44 +0530
Message-Id: <20260616072245.3700010-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616072245.3700010-1-naga.akella@oss.qualcomm.com>
References: <20260616072245.3700010-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA3MyBTYWx0ZWRfX392MJhSGqRvx
 +QGSOpxMecBEp4/Qb8VqZk28U/geCGbiZy5igXDq5xGcLKJWQdUBWbBjm+lKylw+tNbWyOyUYAg
 XknwEfqnWSQdtMOEORC5IhxD5I/fVS0=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a30f9d9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=jxswotFHykHIy8MwBbIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA3MyBTYWx0ZWRfX7eOgdKUXvxdI
 WD9l0/Ko2oGauoIzHrmBe+JZ2txFioQbQyqEaRYvXE+RyiX3aOEtSobNa9eCkp2Z+3AuGsp2vPX
 Al065nVEvtVP6PreuKh6R5fphRtjbNUyjD4RxPtPSah78pwAddiML3lY7FOvxJio8eVmj/fdL5s
 wQ83cOfHGIio1chVXYXxQLqB6VDwa0VYH+dz+Vtbc/uov+kiUGx2cJJ+6FhviN++P7mMad7fOKP
 ozhuEHI7BKpzTUcf32/nqLVkO3qRevP67G/Ne5NLmAB0UEibLye1EPVQFG+ltmC9TlUX4hYuAWG
 KrGDvOUrHRG8Oodc0tGur9fHKUvIpX0OLXs+n41u/3vzQN/obqv2Z6B3Cj8znLXGC6DBnr8ybhj
 /twkDT+d8BMlN+HtxJt+EehaTS9wMMLQjnpl5ZQI9g97Xhd6Heb1K9dK0u2c8axsCZgjNXYgEhq
 ngizdp92rQ/qBxVoD2g==
X-Proofpoint-GUID: SfMR-Ksm_MNC5eBe_csT03RcqTOGUmLn
X-Proofpoint-ORIG-GUID: SfMR-Ksm_MNC5eBe_csT03RcqTOGUmLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160073

Introduce support for LE Channel Sounding (CS)
ranging procedures in the Initiator role by enabling
required HCI command sequencing and event handling.

Add handling of core HCI LE CS commands and events
This enables cs capability discovery, cs configuration
management and execution of CS ranging procedures
in the Initiator role.
---
 profiles/ranging/rap.c     |   9 +-
 profiles/ranging/rap_hci.c | 734 ++++++++++++++++++++++++++++++++-----
 2 files changed, 640 insertions(+), 103 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index e0a46a87a..dc57eeda6 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -418,10 +418,11 @@ static int rap_accept(struct btd_service *service)
 			DBG("Found conn handle 0x%04X for %s", handle, addr);
 			DBG("Setting up handle mapping: handle=0x%04X",
 				handle);
-			bt_rap_set_conn_handle(data->hci_sm,
-						data->rap, handle,
-						(const uint8_t *) bdaddr,
-						bdaddr_type);
+			bt_rap_set_conn_hndl(data->hci_sm,
+					data->rap, handle,
+					(const uint8_t *) bdaddr,
+					bdaddr_type,
+					btd_device_is_initiator(device));
 		} else {
 			error("Failed to find connection handle for device %s",
 				addr);
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index febe23384..13f1365f3 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -16,11 +16,13 @@
 #include <unistd.h>
 #include <string.h>
 #include <endian.h>
+#include <time.h>
 
 #include "lib/bluetooth/bluetooth.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/rap.h"
+#include "src/shared/att.h"
 #include "src/log.h"
 #include "monitor/bt.h"
 
@@ -51,6 +53,9 @@ static const char * const state_names[] = {
 	"CS_STATE_UNSPECIFIED"
 };
 
+_Static_assert(ARRAY_SIZE(state_names) == CS_STATE_UNSPECIFIED + 1,
+		"state_names[] out of sync with enum cs_state");
+
 /* Callback Function Type */
 typedef void (*cs_callback_t)(uint16_t length,
 			const void *param, void *user_data);
@@ -67,6 +72,7 @@ struct cs_state_machine {
 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
 	uint8_t role_enable;  /* Role value for HCI commands (1, 2, or 3) */
 	struct queue *conn_mappings;  /* Per-instance connection mappings */
+	struct timespec last_chan_class_time;  /* For 1-second rate limit */
 };
 
 /* Connection Handle Mapping */
@@ -74,6 +80,7 @@ struct rap_conn_mapping {
 	uint16_t handle;
 	uint8_t bdaddr[6];
 	uint8_t bdaddr_type;
+	bool is_central;  /* true if local device is BLE Central on this link */
 	struct bt_att *att;
 	struct bt_rap *rap;
 };
@@ -97,14 +104,6 @@ static bool match_mapping_handle(const void *a, const void *b)
 	return mapping->handle == handle;
 }
 
-static bool match_mapping_rap(const void *a, const void *b)
-{
-	const struct rap_conn_mapping *mapping = a;
-	const struct bt_rap *rap = b;
-
-	return mapping->rap == rap;
-}
-
 static struct rap_conn_mapping *find_mapping_by_handle(
 					struct cs_state_machine *sm,
 					uint16_t handle)
@@ -118,19 +117,14 @@ static struct rap_conn_mapping *find_mapping_by_handle(
 
 static bool add_conn_mapping(struct cs_state_machine *sm, uint16_t handle,
 				const uint8_t *bdaddr, uint8_t bdaddr_type,
-				struct bt_att *att, struct bt_rap *rap)
+				bool is_central, struct bt_att *att,
+				struct bt_rap *rap)
 {
 	struct rap_conn_mapping *mapping;
 
 	if (!sm)
 		return false;
 
-	if (!sm->conn_mappings) {
-		sm->conn_mappings = queue_new();
-		if (!sm->conn_mappings)
-			return false;
-	}
-
 	/* Check if mapping already exists */
 	mapping = find_mapping_by_handle(sm, handle);
 	if (mapping) {
@@ -138,6 +132,7 @@ static bool add_conn_mapping(struct cs_state_machine *sm, uint16_t handle,
 		if (bdaddr)
 			memcpy(mapping->bdaddr, bdaddr, 6);
 		mapping->bdaddr_type = bdaddr_type;
+		mapping->is_central = is_central;
 		mapping->att = att;
 		mapping->rap = rap;
 		return true;
@@ -152,6 +147,7 @@ static bool add_conn_mapping(struct cs_state_machine *sm, uint16_t handle,
 	if (bdaddr)
 		memcpy(mapping->bdaddr, bdaddr, 6);
 	mapping->bdaddr_type = bdaddr_type;
+	mapping->is_central = is_central;
 	mapping->att = att;
 	mapping->rap = rap;
 
@@ -171,15 +167,6 @@ static void remove_conn_mapping(struct cs_state_machine *sm, uint16_t handle)
 		mapping_free(mapping);
 }
 
-static void remove_rap_mappings(struct cs_state_machine *sm)
-{
-	if (!sm || !sm->conn_mappings)
-		return;
-
-	queue_remove_all(sm->conn_mappings, match_mapping_rap, sm->rap,
-				mapping_free);
-}
-
 /*  State Machine Functions */
 static void cs_state_machine_init(struct cs_state_machine *sm,
 				struct bt_rap *rap, struct bt_hci *hci,
@@ -194,6 +181,7 @@ static void cs_state_machine_init(struct cs_state_machine *sm,
 	sm->hci = hci;
 	sm->initiator = false;
 	sm->procedure_active = false;
+	sm->conn_mappings = queue_new();
 
 	/* Store role_enable for HCI commands (1, 2, or 3 from config) */
 	sm->role_enable = role;
@@ -219,8 +207,8 @@ static void cs_set_state(struct cs_state_machine *sm,
 		return;
 
 	/* Validate state values before array access */
-	if (sm->current_state > CS_STATE_UNSPECIFIED ||
-	    new_state > CS_STATE_UNSPECIFIED) {
+	if ((unsigned int)sm->current_state >= ARRAY_SIZE(state_names) ||
+	    (unsigned int)new_state >= ARRAY_SIZE(state_names)) {
 		error("Invalid state transition attempted");
 		return;
 	}
@@ -238,11 +226,167 @@ static enum cs_state cs_get_current_state(struct cs_state_machine *sm)
 	return sm ? sm->current_state : CS_STATE_UNSPECIFIED;
 }
 
+static bool is_initiator_role(const struct cs_state_machine *sm)
+{
+	return sm->role_enable == 0x01 || sm->role_enable == 0x03;
+}
+
+/* Helper function to send read remote capabilities for all connections */
+static bool bt_rap_read_remote_supported_capabilities(void *hci_sm,
+		uint16_t handle)
+{
+	struct cs_state_machine *sm = hci_sm;
+	struct bt_hci_cmd_le_cs_rd_rem_supp_cap cmd;
+	unsigned int status;
+
+	if (!sm || !sm->hci) {
+		error("Invalid state machine or HCI");
+		return false;
+	}
+
+	DBG("Sending Read Remote Supported Capabilities for handle 0x%04X",
+		handle);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.handle = cpu_to_le16(handle);
+
+	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_RD_REM_SUPP_CAP,
+				&cmd, sizeof(cmd), NULL, sm, NULL);
+
+	if (!status) {
+		error("Failed to send Read Remote Capabilities command");
+		return false;
+	}
+
+	DBG("Read Remote Capabilities command sent successfully");
+	return true;
+}
+
+/* Helper function to send read remote capabilities for all connections */
+static void send_read_remote_cap_for_mapping(void *data, void *user_data)
+{
+	struct rap_conn_mapping *mapping = data;
+	struct cs_state_machine *sm = user_data;
+
+	if (!mapping || !sm)
+		return;
+
+	DBG("Sending read remote capabilities for handle 0x%04X",
+		mapping->handle);
+	bt_rap_read_remote_supported_capabilities(sm, mapping->handle);
+}
+
 /* HCI Event Callbacks */
+static void rap_rd_loc_supp_cap_done_cb(const void *data, uint8_t size,
+					void *user_data)
+{
+	const struct bt_hci_rsp_le_cs_rd_loc_supp_cap *rsp;
+	struct cs_state_machine *sm = (struct cs_state_machine *) user_data;
+
+	if (!sm || !data ||
+		size < sizeof(struct bt_hci_rsp_le_cs_rd_loc_supp_cap))
+		return;
+
+	DBG("size=0x%02X", size);
+
+	rsp = (const struct bt_hci_rsp_le_cs_rd_loc_supp_cap *) data;
+
+	if (rsp->status != 0) {
+		error("Read Local Supported Capabilities failed: 0x%02X",
+			rsp->status);
+		return;
+	}
+
+	DBG("Local CS Capabilities:");
+	DBG("  Num Config Supported: %u", rsp->num_config_supported);
+	DBG("  Max Consecutive Procedures: %u",
+		rsp->max_consecutive_procedures_supported);
+	DBG("  Num Antennas: %u", rsp->num_antennas_supported);
+	DBG("  Max Antenna Paths: %u", rsp->max_antenna_paths_supported);
+	DBG("  Roles Supported: 0x%02X", rsp->roles_supported);
+	DBG("  Modes Supported: 0x%02X", rsp->modes_supported);
+	DBG("  RTT Capability: 0x%02X", rsp->rtt_capability);
+	DBG("  RTT AA Only N: %u", rsp->rtt_aa_only_n);
+	DBG("  RTT Sounding N: %u", rsp->rtt_sounding_n);
+	DBG("  RTT Random Payload N: %u", rsp->rtt_random_payload_n);
+	DBG("  NADM Sounding Capability: 0x%04X",
+		rsp->nadm_sounding_capability);
+	DBG("  NADM Random Capability: 0x%04X", rsp->nadm_random_capability);
+	DBG("  CS Sync PHYs Supported: 0x%02X", rsp->cs_sync_phys_supported);
+	DBG("  Subfeatures Supported: 0x%04X", rsp->subfeatures_supported);
+	DBG("  T_IP1 Times Supported: 0x%04X", rsp->t_ip1_times_supported);
+	DBG("  T_IP2 Times Supported: 0x%04X", rsp->t_ip2_times_supported);
+	DBG("  T_FCS Times Supported: 0x%04X", rsp->t_fcs_times_supported);
+	DBG("  T_PM Times Supported: 0x%04X", rsp->t_pm_times_supported);
+	DBG("  T_SW Time Supported: %u", rsp->t_sw_time_supported);
+	DBG("  TX SNR Capability: 0x%02X", rsp->tx_snr_capability);
+
+	/* Transition to INIT state before reading remote capabilities */
+	cs_set_state(sm, CS_STATE_INIT);
+
+	/* Send read remote capabilities for all connected devices */
+	if (sm->conn_mappings) {
+		DBG("Sending read remote capabilities for all connections");
+		queue_foreach(sm->conn_mappings,
+				send_read_remote_cap_for_mapping, sm);
+	}
+}
+
+static void rap_send_hci_cs_create_config_command(struct cs_state_machine *sm,
+						uint16_t handle)
+{
+	struct bt_hci_cmd_le_cs_create_config cmd;
+	unsigned int status;
+
+	uint8_t channel_map[10] = {
+		0xFC, 0xFF, 0x7F, 0xFC, 0xFF,
+		0xFF, 0xFF, 0xFF, 0xFF, 0x1F
+	};
+
+	if (!sm || !sm->hci) {
+		error("CS Create Config: sm or hci is null");
+		return;
+	}
+
+	DBG("Sending CS Create Config command for handle 0x%04X", handle);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.handle = cpu_to_le16(handle);
+	cmd.create_context = 1;
+	/* Default values, will change to pick user given values later */
+	cmd.config_id              = 0x00;
+	cmd.main_mode_type         = 0x01;
+	cmd.sub_mode_type          = 0xFF;
+	cmd.min_main_mode_steps    = 0x02;
+	cmd.max_main_mode_steps    = 0x03;
+	cmd.main_mode_repetition   = 0x01;
+	cmd.mode_0_steps           = 0x02;
+	cmd.role                   = 0x00;
+	cmd.rtt_type               = 0x00;
+	cmd.cs_sync_phy            = 0x01;
+	memcpy(cmd.channel_map, channel_map, 10);
+	cmd.channel_map_repetition = 0x01;
+	cmd.channel_selection_type = 0x00;
+	cmd.ch3c_shape             = 0x00;
+	cmd.ch3c_jump              = 0x02;
+	cmd.reserved               = 0x00;
+
+	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_CREATE_CONFIG,
+				&cmd, sizeof(cmd), NULL, sm, NULL);
+
+	if (!status) {
+		error("Failed to send CS Create Config command");
+		cs_set_state(sm, CS_STATE_STOPPED);
+		return;
+	}
+
+	DBG("CS Create Config command sent successfully");
+}
+
 static void rap_def_settings_done_cb(const void *data, uint8_t size,
 					void *user_data)
 {
-	struct bt_hci_rsp_le_cs_set_def_settings *rp;
+	const struct bt_hci_rsp_le_cs_set_def_settings *rp;
 	struct cs_state_machine *sm = user_data;
 
 	if (!sm || !data || size < sizeof(*rp))
@@ -250,10 +394,11 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 
 	DBG("size=0x%02X", size);
 
-	rp = (struct bt_hci_rsp_le_cs_set_def_settings *) data;
+	rp = (const struct bt_hci_rsp_le_cs_set_def_settings *) data;
 
-	if (cs_get_current_state(sm) != CS_STATE_INIT) {
-		DBG("Event received in Wrong State!! Expected : CS_STATE_INIT");
+	if (cs_get_current_state(sm) == CS_STATE_STOPPED ||
+	    cs_get_current_state(sm) == CS_STATE_UNSPECIFIED) {
+		DBG("Def settings response in terminal state, ignoring");
 		return;
 	}
 
@@ -261,9 +406,11 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 		/* Success - proceed to configuration */
 		cs_set_state(sm, CS_STATE_WAIT_CONFIG_CMPLT);
 
-		/* Reflector role */
-		DBG("Waiting for CS Config Completed event...");
-		/* TODO: Initiator role - Send CS Config complete cmd */
+		/* If role is initiator, send CS Create Config command */
+		if (is_initiator_role(sm))
+			rap_send_hci_cs_create_config_command(sm, rp->handle);
+		else
+			DBG("Reflector role: Waiting for CS Config Completed");
 	} else {
 		/* Error - transition to stopped */
 		error("CS Set default setting failed with status 0x%02X",
@@ -272,8 +419,145 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 	}
 }
 
-static void rap_send_hci_def_settings_command(struct cs_state_machine *sm,
+static void rap_send_hci_cs_remove_config_command(struct cs_state_machine *sm,
 						uint16_t handle)
+{
+	struct bt_hci_cmd_le_cs_remove_config cmd;
+	unsigned int status;
+
+	if (!sm || !sm->hci) {
+		error("CS Remove Config: sm or hci is null");
+		return;
+	}
+
+	DBG("Sending CS Remove Config command for handle 0x%04X", handle);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.handle = cpu_to_le16(handle);
+	cmd.config_id = 0x00;  /* Default config ID */
+
+	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_REMOVE_CONFIG,
+				&cmd, sizeof(cmd), NULL, sm, NULL);
+
+	if (!status) {
+		error("Failed to send CS Remove Config command");
+		cs_set_state(sm, CS_STATE_STOPPED);
+		return;
+	}
+
+	DBG("CS Remove Config command sent successfully");
+}
+
+static void rap_send_hci_cs_security_enable_command(
+		struct cs_state_machine *sm, uint16_t handle)
+{
+	struct bt_hci_cmd_le_cs_sec_enable cmd;
+	unsigned int status;
+
+	if (!sm || !sm->hci) {
+		error("CS Security Enable: sm or hci is null");
+		return;
+	}
+
+	DBG("Sending CS Security Enable command for handle 0x%04X", handle);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.handle = cpu_to_le16(handle);
+
+	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_SEC_ENABLE,
+				&cmd, sizeof(cmd), NULL, sm, NULL);
+
+	if (!status) {
+		error("Failed to send CS Security Enable command");
+		cs_set_state(sm, CS_STATE_STOPPED);
+		return;
+	}
+
+	DBG("CS Security Enable command sent successfully");
+}
+
+static bool rap_send_hci_cs_set_procedure_parameters(
+		struct cs_state_machine *sm, uint16_t handle)
+{
+	struct bt_hci_cmd_le_cs_set_proc_params cmd;
+	unsigned int status;
+	uint8_t min_sub_event_len[3] = {
+		0x00, 0x20, 0x00
+	};
+
+	uint8_t max_sub_event_len[3] = {
+		0x03, 0x20, 0x00
+	};
+
+	if (!sm || !sm->hci) {
+		error("CS Set Procedure Parameters: sm or hci is null");
+		return false;
+	}
+
+	DBG("Sending CS Set Procedure Parameters for handle 0x%04X", handle);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.handle = cpu_to_le16(handle);
+	/* Default values, will change to pick user given values later */
+	cmd.config_id = 0x00;
+	cmd.max_procedure_len = 0x0640;
+	cmd.min_procedure_interval = 0x1E;
+	cmd.max_procedure_interval = 0x96;
+	cmd.max_procedure_count = 0x00;
+	memcpy(cmd.min_subevent_len, min_sub_event_len, 3);
+	memcpy(cmd.max_subevent_len, max_sub_event_len, 3);
+	cmd.tone_antenna_config_selection = 0x07;
+	cmd.phy                    = 0x01;
+	cmd.tx_power_delta         = 0x80;
+	cmd.preferred_peer_antenna = 0x03;
+	cmd.snr_control_initiator  = 0xFF;
+	cmd.snr_control_reflector  = 0xFF;
+
+	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_SET_PROC_PARAMS,
+				&cmd, sizeof(cmd), NULL, sm, NULL);
+
+	if (!status) {
+		error("Failed to send CS Set Procedure Parameters command");
+		return false;
+	}
+
+	DBG("CS Set Procedure Parameters command sent successfully");
+	return true;
+}
+
+static bool rap_send_hci_cs_procedure_enable(struct cs_state_machine *sm,
+						uint16_t handle,
+						bool enable_proc)
+{
+	struct bt_hci_cmd_le_cs_proc_enable cmd;
+	unsigned int status;
+
+	if (!sm || !sm->hci) {
+		error("CS Procedure Enable: sm or hci is null");
+		return false;
+	}
+
+	DBG("Sending CS Procedure Enable for handle 0x%04X", handle);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.handle = cpu_to_le16(handle);
+	cmd.config_id = 0x00; /* Default config Id */
+	cmd.enable = enable_proc ? 0x01 : 0x00;
+
+	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_PROC_ENABLE,
+				&cmd, sizeof(cmd), NULL, sm, NULL);
+
+	if (!status) {
+		error("Failed to send CS Procedure Enable command");
+		return false;
+	}
+
+	DBG("CS Procedure Enable command sent successfully");
+	return true;
+}
+
+static void rap_send_hci_def_settings_command(struct cs_state_machine *sm,
+		const struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *ev)
 {
 	struct bt_hci_cmd_le_cs_set_def_settings cp;
 	unsigned int status;
@@ -285,8 +569,8 @@ static void rap_send_hci_def_settings_command(struct cs_state_machine *sm,
 
 	memset(&cp, 0, sizeof(cp));
 
-	if (handle)
-		cp.handle = handle;
+	if (ev->handle)
+		cp.handle = ev->handle;
 
 	cp.role_enable = sm->role_enable;  /* Use preserved HCI command value */
 	cp.cs_sync_antenna_selection = sm->cs_opt.cs_sync_ant_sel;
@@ -302,12 +586,120 @@ static void rap_send_hci_def_settings_command(struct cs_state_machine *sm,
 		error("Failed to send default settings cmd");
 }
 
+static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
+				      void *user_data)
+{
+	struct cs_state_machine *sm = (struct cs_state_machine *) user_data;
+	const struct bt_hci_evt_le_cs_rd_rem_fae_complete *evt;
+	struct iovec iov;
+	int i;
+
+	if (!sm || !data ||
+		size < sizeof(struct bt_hci_evt_le_cs_rd_rem_fae_complete))
+		return;
+
+	/* Initialize iovec with the event data */
+	iov.iov_base = (void *) data;
+	iov.iov_len = size;
+
+	/* Pull the entire structure at once */
+	evt = util_iov_pull_mem(&iov, sizeof(*evt));
+
+	if (!evt) {
+		error("Failed to pull remote FAE complete struct");
+		return;
+	}
+
+	DBG("status=0x%02X, handle=0x%04X", evt->status, evt->handle);
+
+	/* Check status */
+	if (evt->status != 0) {
+		/* Status 0x11 (Unsupported Feature or Parameter Value) means
+		 * the remote has zero FAE, the procedure continues
+		 * to the Default Settings step.
+		 */
+		if (evt->status == 0x11) {
+			DBG("Remote FAE=0 (No_FAE), proceed to Def Settings");
+			if (is_initiator_role(sm)) {
+				struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete
+								tmp_ev;
+
+				memset(&tmp_ev, 0, sizeof(tmp_ev));
+				tmp_ev.handle = evt->handle;
+				DBG("Initiator: send def settings (No_FAE)");
+				rap_send_hci_def_settings_command(sm, &tmp_ev);
+			} else {
+				DBG("Reflector role: continuing after No_FAE");
+				cs_set_state(sm, CS_STATE_INIT);
+			}
+			return;
+		}
+		error("Remote FAE Table read failed with status 0x%02X",
+			evt->status);
+		cs_set_state(sm, CS_STATE_STOPPED);
+		return;
+	}
+
+	DBG("Remote FAE Table received:");
+	for (i = 0; i < 72; i += 8) {
+		DBG("  [%02d-%02d]: %02X %02X %02X %02X %02X %02X %02X %02X",
+			i, i+7,
+			evt->remote_fae_table[i], evt->remote_fae_table[i+1],
+			evt->remote_fae_table[i+2], evt->remote_fae_table[i+3],
+			evt->remote_fae_table[i+4], evt->remote_fae_table[i+5],
+			evt->remote_fae_table[i+6], evt->remote_fae_table[i+7]);
+	}
+
+	/* After receiving FAE Table, send default settings */
+	/* Local capabilities already read before this event */
+	if (is_initiator_role(sm)) {
+		struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete tmp_ev;
+
+		memset(&tmp_ev, 0, sizeof(tmp_ev));
+		tmp_ev.handle = evt->handle;
+		DBG("Initiator role: send def settings after FAE table");
+		rap_send_hci_def_settings_command(sm, &tmp_ev);
+	} else {
+		DBG("Reflector role: Proceeding after FAE Table");
+		cs_set_state(sm, CS_STATE_INIT);
+	}
+}
+
+static bool bt_rap_read_remote_fae_table(void *hci_sm, uint16_t handle)
+{
+	struct cs_state_machine *sm = hci_sm;
+	struct bt_hci_cmd_le_cs_rd_rem_fae cmd;
+	unsigned int status;
+
+	if (!sm || !sm->hci) {
+		error("Invalid state machine or HCI");
+		return false;
+	}
+
+	DBG("Sending Read Remote FAE Table for handle 0x%04X", handle);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.handle = cpu_to_le16(handle);
+
+	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_RD_REM_FAE,
+				&cmd, sizeof(cmd), NULL, sm, NULL);
+
+	if (!status) {
+		error("Failed to send Read Remote FAE Table command");
+		return false;
+	}
+
+	DBG("Read Remote FAE Table command sent successfully");
+	return true;
+}
+
 static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 					   void *user_data)
 {
 	struct cs_state_machine *sm = user_data;
 	const struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *evt;
 	struct iovec iov;
+	uint16_t subfeatures_supported;
 
 	if (!sm || !data || size < sizeof(*evt))
 		return;
@@ -343,9 +735,26 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 		evt->max_antenna_paths_supported,
 		evt->roles_supported,
 		evt->modes_supported);
+	subfeatures_supported = le16_to_cpu(evt->subfeatures_supported);
+	DBG("subfeatures_supported=0x%04X", subfeatures_supported);
 
-	rap_send_hci_def_settings_command(sm, evt->handle);
-	cs_set_state(sm, CS_STATE_INIT);
+	/* Check Bit 1 of subfeatures_supported (0x0002) */
+	if (!(subfeatures_supported & 0x0002)) {
+		DBG("Bit 1 not set, sending Read Remote FAE Table");
+		bt_rap_read_remote_fae_table(sm, evt->handle);
+		return;
+	}
+
+	/* Local capabilities already read before this event */
+	if (is_initiator_role(sm)) {
+		DBG("Initiator role: send def settings cmd for handle 0x%04X",
+			evt->handle);
+		rap_send_hci_def_settings_command(sm, evt);
+	} else {
+		DBG("Reflector role: send def settings cmd");
+		cs_set_state(sm, CS_STATE_INIT);
+		rap_send_hci_def_settings_command(sm, evt);
+	}
 }
 
 static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
@@ -383,8 +792,15 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
 	/* Check status */
 	if (evt->status != 0) {
-		error("Configuration failed with status 0x%02X",
-			evt->status);
+		if (evt->action != 0x00) {
+			/* Create/update failed — try to remove the config */
+			error("Configuration failed with status 0x%02X",
+				evt->status);
+			rap_send_hci_cs_remove_config_command(sm, evt->handle);
+		} else {
+			error("CS Config Remove failed with status 0x%02X",
+				evt->status);
+		}
 		cs_set_state(sm, CS_STATE_STOPPED);
 		return;
 	}
@@ -428,12 +844,40 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 		rap_ev.main_mode_type, rap_ev.sub_mode_type,
 		rap_ev.role, rap_ev.rtt_type);
 
+	if (rap_ev.action == 0x00) {
+		cs_set_state(sm, CS_STATE_UNSPECIFIED);
+		DBG("CS Config Removed !!!");
+		bt_rap_hci_cs_config_complete_callback(size, &rap_ev, sm->rap);
+		return;
+	}
 	/* Success - proceed to Security enable complete */
 	cs_set_state(sm, CS_STATE_WAIT_SEC_CMPLT);
 
-	/* Reflector role */
-	DBG("Waiting for security enable event...");
-	/* TODO: Initiator role - Send CS Security enable cmd */
+	/* CS Security Enable may only be issued by the BLE Central */
+	if (rap_ev.role == 0x00) {
+		/* Initiator role */
+		struct rap_conn_mapping *mapping;
+
+		mapping = find_mapping_by_handle(sm, evt->handle);
+		if (!mapping || !mapping->is_central) {
+			error("CS Security Enable skipped: not BLE Central");
+			cs_set_state(sm, CS_STATE_STOPPED);
+			return;
+		}
+
+		if (bt_att_get_security(mapping->att, NULL) <
+						BT_ATT_SECURITY_MEDIUM) {
+			error("CS Security Enable skipped: not encrypted");
+			cs_set_state(sm, CS_STATE_STOPPED);
+			return;
+		}
+
+		DBG("Central,encrypted: Sending CS Security Enable command");
+		rap_send_hci_cs_security_enable_command(sm, evt->handle);
+	} else {
+		/* Reflector role */
+		DBG("Reflector role: Waiting for security enable event...");
+	}
 
 	/* Send callback to RAP Profile */
 	bt_rap_hci_cs_config_complete_callback(size, &rap_ev, sm->rap);
@@ -486,9 +930,27 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 		/* Success - proceed to configuration */
 		cs_set_state(sm, CS_STATE_WAIT_PROC_CMPLT);
 
-		/* Reflector role */
-		DBG("Waiting for CS Proc complete event...");
-		/* TODO: Initiator - Send CS Proc Set Parameter and enable */
+		/* Check if role is initiator */
+		if (sm->cs_opt.role == CS_INITIATOR) {
+			DBG("Initiator role: Sending CS Set Procedure Params");
+			if (!rap_send_hci_cs_set_procedure_parameters(
+							sm, handle)) {
+				error("Failed to send CS Set Procedure Params");
+				cs_set_state(sm, CS_STATE_STOPPED);
+				return;
+			}
+
+			DBG("Initiator role: Sending CS Procedure Enable");
+			if (!rap_send_hci_cs_procedure_enable(sm, handle,
+								      true)) {
+				error("Failed to send CS Procedure Enable");
+				cs_set_state(sm, CS_STATE_STOPPED);
+				return;
+			}
+		} else {
+			/* Reflector role */
+			DBG("Reflector role: Waiting for CS Proc compl event");
+		}
 	} else {
 		/* Error - transition to stopped */
 		error("Security enable failed with status 0x%02X",
@@ -565,8 +1027,13 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
 		rap_ev.proc_intrvl);
 
 	/* Success - procedure started */
-	cs_set_state(sm, CS_STATE_STARTED);
-	sm->procedure_active = true;
+	if (rap_ev.state == 0x01) {
+		cs_set_state(sm, CS_STATE_STARTED);
+		sm->procedure_active = true;
+	} else if (rap_ev.state == 0x00) {
+		cs_set_state(sm, CS_STATE_STOPPED);
+		sm->procedure_active = false;
+	}
 
 	/* Send callback to RAP Profile */
 	bt_rap_hci_cs_procedure_enable_complete_callback(size,
@@ -800,6 +1267,54 @@ static void parse_cs_step(struct iovec *iov, struct cs_step_data *step,
 	}
 }
 
+/*
+ * Handle the common step-parsing tail shared by both subevent result variants.
+ * Fixes truncation (num_steps_reported > CS_MAX_STEPS) by zeroing the step
+ * count and trimming send_len to header_size, matching the abort-status path.
+ */
+static void cs_parse_steps(struct iovec *iov,
+			uint8_t num_steps_reported,
+			uint8_t proc_done_status,
+			uint8_t subevt_done_status,
+			uint8_t abort_reason,
+			uint8_t cs_role, uint8_t cs_rtt_type,
+			uint8_t max_paths,
+			struct cs_step_data *step_data,
+			uint8_t *num_steps_out,
+			size_t *send_len,
+			size_t header_size)
+{
+	uint8_t steps = MIN(num_steps_reported, CS_MAX_STEPS);
+	uint8_t i;
+
+	if (num_steps_reported > CS_MAX_STEPS) {
+		DBG("Too many steps reported: %u (max %u)",
+			num_steps_reported, CS_MAX_STEPS);
+		*num_steps_out = 0;
+		*send_len = header_size;
+		return;
+	}
+
+	if (subevt_done_status == 0xF || proc_done_status == 0xF) {
+		DBG("CS Procedure/Subevent aborted: ");
+		DBG("sub evt status = %d, proc status = %d, reason = %d",
+			subevt_done_status, proc_done_status, abort_reason);
+		/*
+		 * Step bytes were never parsed; zero-initialised step_data[]
+		 * entries would appear as spurious mode-0 quality=0 steps to
+		 * the BCS algorithm.  Clear the count so an aborted subevent
+		 * carries no fake measurements.
+		 */
+		*num_steps_out = 0;
+		*send_len = header_size;
+		return;
+	}
+
+	for (i = 0; i < steps; i++)
+		parse_cs_step(iov, &step_data[i], cs_role, cs_rtt_type,
+			max_paths);
+}
+
 static void rap_cs_subevt_result_evt(const void *data, uint8_t size,
 				void *user_data)
 {
@@ -822,7 +1337,6 @@ static void rap_cs_subevt_result_evt(const void *data, uint8_t size,
 	uint8_t abort_reason;
 	uint8_t num_ant_paths;
 	uint8_t num_steps_reported;
-	uint8_t i;
 
 	if (!sm || !data ||
 		size < sizeof(struct bt_hci_evt_le_cs_subevent_result))
@@ -883,28 +1397,13 @@ static void rap_cs_subevt_result_evt(const void *data, uint8_t size,
 	rap_ev->num_ant_paths                = num_ant_paths;
 	rap_ev->num_steps_reported           = steps;
 
-	if (num_steps_reported > CS_MAX_STEPS) {
-		DBG("Too many steps reported: %u (max %u)",
-			num_steps_reported, CS_MAX_STEPS);
-		goto send_event;
-	}
-
-	/* Early exit for error conditions */
-	if (rap_ev->subevt_done_status == 0xF ||
-	    rap_ev->proc_done_status == 0xF) {
-		DBG("CS Procedure/Subevent aborted: ");
-		DBG("sub evt status = %d, proc status = %d, reason = %d",
-			rap_ev->subevt_done_status, rap_ev->proc_done_status,
-			rap_ev->abort_reason);
-		goto send_event;
-	}
-
-	/* Parse interleaved step data from remaining iovec data */
-	for (i = 0; i < steps; i++)
-		parse_cs_step(&iov, &rap_ev->step_data[i], cs_role, cs_rtt_type,
-			max_paths);
+	cs_parse_steps(&iov, num_steps_reported,
+			proc_done_status, subevt_done_status, abort_reason,
+			cs_role, cs_rtt_type, max_paths,
+			rap_ev->step_data, &rap_ev->num_steps_reported,
+			&send_len,
+			offsetof(struct rap_ev_cs_subevent_result, step_data));
 
-send_event:
 	DBG("CS subevent result processed: %zu bytes, ", send_len);
 	bt_rap_hci_cs_subevent_result_callback(send_len, rap_ev, sm->rap);
 	free(rap_ev);
@@ -928,7 +1427,6 @@ static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t size,
 	uint8_t abort_reason;
 	uint8_t num_ant_paths;
 	uint8_t num_steps_reported;
-	uint8_t i;
 
 	if (!sm || !data ||
 		size < sizeof(struct bt_hci_evt_le_cs_subevent_result_continue))
@@ -981,28 +1479,14 @@ static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t size,
 	rap_ev->num_ant_paths                = num_ant_paths;
 	rap_ev->num_steps_reported           = steps;
 
-	if (num_steps_reported > CS_MAX_STEPS) {
-		DBG("Too many steps reported: %u (max %u)",
-			num_steps_reported, CS_MAX_STEPS);
-		goto send_event;
-	}
+	cs_parse_steps(&iov, num_steps_reported,
+			proc_done_status, subevt_done_status, abort_reason,
+			cs_role, cs_rtt_type, max_paths,
+			rap_ev->step_data, &rap_ev->num_steps_reported,
+			&send_len,
+			offsetof(struct rap_ev_cs_subevent_result_cont,
+							step_data));
 
-	/* Early exit for error conditions */
-	if (rap_ev->subevt_done_status == 0xF ||
-	    rap_ev->proc_done_status == 0xF) {
-		DBG("CS Procedure/Subevent aborted: ");
-		DBG("sub evt status = %d, proc status = %d, reason = %d",
-			rap_ev->subevt_done_status, rap_ev->proc_done_status,
-			rap_ev->abort_reason);
-		goto send_event;
-	}
-
-	/* Parse interleaved step data from remaining iovec data */
-	for (i = 0; i < steps; i++)
-		parse_cs_step(&iov, &rap_ev->step_data[i], cs_role, cs_rtt_type,
-			max_paths);
-
-send_event:
 	DBG("CS subevent result cont processed: %zu bytes, ", send_len);
 	bt_rap_hci_cs_subevent_result_cont_callback(send_len, rap_ev, sm->rap);
 	free(rap_ev);
@@ -1010,6 +1494,38 @@ send_event:
 
 /* Subevent handler function type */
 
+/* Set Ch Classif cmd handling to be added after DBus support enabled */
+
+/* This cmd is used by host to start cs distance measurement procedure
+ * function will be used when user start distance measurement
+ * keeping it unused till DBUS API is added
+ */
+static bool bt_rap_read_local_supported_capabilities(
+		void *hci_sm)
+{
+	struct cs_state_machine *sm = hci_sm;
+	unsigned int status;
+
+	if (!sm || !sm->hci) {
+		error("Invalid state machine or HCI");
+		return false;
+	}
+
+	DBG("Sending Read Local Supported Capabilities command");
+
+	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_RD_LOC_SUPP_CAP,
+				NULL, 0, rap_rd_loc_supp_cap_done_cb,
+				sm, NULL);
+
+	if (!status) {
+		error("Failed to send Read Local Supported Capabilities");
+		return false;
+	}
+
+	DBG("Read Local Supported Capabilities command sent successfully");
+	return true;
+}
+
 static void unregister_event_id(void *data, void *user_data)
 {
 	struct bt_hci *hci = user_data;
@@ -1041,6 +1557,11 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 				max_tx_power);
 
 	sm->event_ids = queue_new();
+	if (!sm->event_ids) {
+		error("Failed to allocate event_ids queue");
+		free(sm);
+		return NULL;
+	}
 
 	/* Register each LE Meta subevent individually */
 	id = bt_hci_register_subevent(hci,
@@ -1051,6 +1572,15 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 
 	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
 
+	id = bt_hci_register_subevent(hci,
+		BT_HCI_EVT_LE_CS_RD_REM_FAE_COMPLETE,
+		rap_rd_rem_fae_cmplt_evt, sm, NULL);
+
+	if (!id)
+		goto fail;
+
+	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+
 	id = bt_hci_register_subevent(hci,
 			BT_HCI_EVT_LE_CS_CONFIG_COMPLETE,
 			rap_cs_config_cmplt_evt, sm, NULL);
@@ -1094,18 +1624,23 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 	DBG("CS options: role=%u, cs_sync_ant_sel=%u, max_tx_power=%d",
 		role, cs_sync_ant_sel, max_tx_power);
 
+	/* place holder, need DBus API to be called */
+	bt_rap_read_local_supported_capabilities(sm);
+
 	return sm;
 
 fail:
 	error("Failed to register hci le meta subevents");
 	queue_foreach(sm->event_ids, unregister_event_id, hci);
 	queue_destroy(sm->event_ids, NULL);
+	queue_destroy(sm->conn_mappings, mapping_free);
 	free(sm);
 	return NULL;
 }
 
-bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t handle,
-				const uint8_t *bdaddr, uint8_t bdaddr_type)
+bool bt_rap_set_conn_hndl(void *hci_sm, struct bt_rap *rap,
+		uint16_t handle, const uint8_t *bdaddr, uint8_t bdaddr_type,
+		bool is_central)
 {
 	struct cs_state_machine *sm = hci_sm;
 	struct bt_att *att;
@@ -1124,7 +1659,8 @@ bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t handle,
 			bdaddr[2], bdaddr[1], bdaddr[0], bdaddr_type);
 	}
 
-	return add_conn_mapping(sm, handle, bdaddr, bdaddr_type, att, rap);
+	return add_conn_mapping(sm, handle, bdaddr, bdaddr_type, is_central,
+				att, rap);
 }
 
 void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
@@ -1156,10 +1692,10 @@ void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm)
 
 		queue_destroy(sm->event_ids, NULL);
 
-		/* Clean up per-instance connection mappings */
-		remove_rap_mappings(sm);
-
-		/* Destroy the connection mappings queue */
+		/* Clean up per-instance connection mappings.
+		 * Each state machine owns its own conn_mappings queue;
+		 * this destroys all mappings for this instance only.
+		 */
 		queue_destroy(sm->conn_mappings, mapping_free);
 
 		/* Free the state machine */
-- 

