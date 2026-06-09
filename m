Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362663F8714
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002246; cv=none; b=gBg8BcbptbAh/A0p4Uu4gUzX1qKmU4VTjiVYup+PBGlDx6mKId9Vf832xE5fuSQYx9fuClViLEMumOpg+zRz9F6iDESVqT8EoIknuRTGGxW4NjyTMVChyNsc2zUUC2VOD4fYEwRUngTzWfmSb0gfAZeICt9MEzEAHrPkCkRswtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002246; c=relaxed/simple;
	bh=1erIQ89/rdv7JiLlqcw6hJMpIsMBibpgOt3ajcsA12I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzRSKatwBx1U9ARE8AtAFJKe2kk0d4QBcl41rm55p4xnw1v3zfZIKkSrgXWmal91r6UzskdH12C4BT4BoKgteJiKRxb1pKg4cLCB5Cxd+EaWJjg/p6FP7jTcvb1N/R4OLRx3e0UmtxGJEjLevAsLN1uW57A2q1sshRC3zcfQxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CbJtb5XO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WIrqRWEh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CbJtb5XO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WIrqRWEh"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599vIqB1868644
	for <linux-bluetooth@vger.kernel.org>; Tue, 9 Jun 2026 10:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rW3s812nr+t0Canderc6IBOT2Q2gF5YCl7q/8gb4+VM=; b=CbJtb5XOK1Xf6Ufw
	sfv1POcy6PSP7gne3CL0aPhC1tDSc3M4hd1Kg5eh41njjYVREO+qegQ6l2RsUNS4
	taCvo4H81OVNjbCwozn+1png1n5+tbR534gqmLBZoS56Em/prmSWZIP70NJiGkuY
	j6rMF8HzvN/qj6I+k2BGIXLd94Gs1aWwG1fsFI20lUpBw1zCyhD1FszngRyHEZxe
	X6BW3nHdHIH7yFFZt+GH6zxM3S6UGok7WnCV2lE/JFIiAqeuQmGbJdQhQn9Wm+CC
	m/kkx1ZXR/i9ntMJAUVWAuj06RMURxENYvt7LoywNmUSaxY5iWwoX4BVhF5KKosb
	qjboDg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wgavm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 10:50:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0bfcd629eso68114565ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 03:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781002243; x=1781607043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW3s812nr+t0Canderc6IBOT2Q2gF5YCl7q/8gb4+VM=;
        b=WIrqRWEhFCNqZTRP17GLkAHbZF4MDNg8bAqpXdgPp8fP2O2CCAf0TAnzhyt3XCTkra
         DlbgVf4U2S9RsAyzXhK1z6mwvnj8PdNgOePcfnXpqWQfRBw1dUnmb9c6weuGNkOSGoI3
         vmtgdvqQJlf+a2jF4wGdsV1SgEJdcCye2mDg6fowL5TGvYMz01Aw8AH0Tr1FUuffU0v5
         B8w9cqMT5F6Hms9CPySDD8WdOCiFkocNDKYjITSA7vX4dSZ+Y9uvVCI6GOkUqMJjpD/S
         MujXYLS0TLocawQMcRyvJvNVTNPQfd/57sa8P9pDmevZ5dxXYEbYAOhozxum2hQfxPbK
         JceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002243; x=1781607043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rW3s812nr+t0Canderc6IBOT2Q2gF5YCl7q/8gb4+VM=;
        b=lYukTs0iEYPYMdwrSpCYb3z/7X9hLN896OV+4lVe3NZtaEkdCN/kvlJ3xEu1LLdnDU
         83tflezGoaeeG3sD2pU5dfdHZisOwkO/XF9QePBs3DWJeN3TbPLtvIS+LwHZSorXdV+j
         EfNtOjPPoRYJad/j7PxxvZbnC47L5BrUdhLVAOUpgbFgNgGJMFx9wYDfASpmbE/srN/T
         lpEAjF0Ya0gD+D6vbQysJUhhrEap0ACf3Qc3/FwH2Wy6e+hhdGagvIR9jBmu2RN6YHY2
         o2RD5qgNjQUQ5XpnWifki0ABMYXmHyOH0jk3JMV9t2ZgzB1PiNq8d0H6fkKcPL02EfQO
         fq3g==
X-Gm-Message-State: AOJu0Yy3v3UdRsJGWFu3i6Y3kYMXaKRSxee8pQ6jafXDXYRZF4QHpg+Q
	7US4CCF0IkkP2ohdJmOzgkcHaPxjae4i6CW4WmHmSQt+btOCsPUf+rZ9EyYGHonovo8hD5vrJYO
	OIaiHkOoWWyAInlqM43ORJzwmeXkODT/h+jjVSnVsov8iIffNME++iCfmwNBlyUNQkwwYXO0mUA
	HQ0uI=
X-Gm-Gg: Acq92OF/Y9jUNTLA7VOpni14GKXgantC3DUzAWJEJfiVlJ8PtFS5ElUeSsLDMuvFyX7
	pdJez+7u+pV6xUeXF3EcoBfpYt6uHM8yZ1EjHmsTU47ntXLb7oIRQ3xW/tc+OEbuEeXRWpvLDCa
	YWJrT4i8ySBBdmLfG8MZKRF+lLfYkkoDmRXjKUylzWVyrLHFyvFfgPe/eIQTtKwpxNEXFgV6GjX
	l8jWbKdcsi5wOF5qf+hBOKZX0ygxnLdTREOuE9aS4Zxh7yvW+AOR0w3SpAu18V5XqjYm9PzdLpq
	NV+sgzt9rl5IajwKzQcJJGt+A6cTW9xJ/gJSbyvrrnq55TvwpHOD3HAgeYkP+MtlrLattoxCAVK
	OaGpoaZB/dsJF1x6OU/cjywJWbG1JuFN6zCA+D/WcT9DuvDKTtPR5aBW/rrUR2Q==
X-Received: by 2002:a17:90b:586d:b0:36b:a2cc:485b with SMTP id 98e67ed59e1d1-370f086c1cbmr22952632a91.21.1781002242159;
        Tue, 09 Jun 2026 03:50:42 -0700 (PDT)
X-Received: by 2002:a17:90b:586d:b0:36b:a2cc:485b with SMTP id 98e67ed59e1d1-370f086c1cbmr22952580a91.21.1781002241385;
        Tue, 09 Jun 2026 03:50:41 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371341170c7sm8864573a91.1.2026.06.09.03.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:50:40 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 2/2] profiles: ranging: Add command flow and event support     for CS Initiator
Date: Tue,  9 Jun 2026 16:19:53 +0530
Message-Id: <20260609104953.3122718-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609104953.3122718-1-naga.akella@oss.qualcomm.com>
References: <20260609104953.3122718-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEwMSBTYWx0ZWRfXzBTvMB7ZYScY
 857Iecxwq153OaxgsCd39fkI5sDwCezMdCuHI5fo3aer6tSlEF1P29gfTeWni4W/Yr+pQrN4w+c
 0aXjCfgmaiGVMNC1gpBUedkA70o6oJuBZM4VaTK8EzYUM2A347LlgE5OQgYf3pRIL3vOwwy4m53
 n4PbF5d1xDS2Z51reUo3t93ZLVNi3XoT0poP3VGuD7JC4aPChR1h0osx+llzelqHPSiZGc/K4gS
 84FeBRGVK7VW+JpOhR3EoqJK9VyfsXWSUtM+3jOrXRSnXLCH5Az8kns8HShZo1AAh6ws+0vcmIm
 G/SbnfjmNK+MRLrx481e1K9sefLjyGp4seuukeF9IAQ6+nqOmqM5z0e/VNpGflKAJRrraSacvWF
 cvC7a5xauOSbkEBJd813kwrlwe526Yo70pxbQWxihkfiNQ4WDcM9L6JsoZRr2FuvTGo2H6duQqz
 VN5/Gk2bGzRpCxxySVA==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a27f003 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=C98QVVwj3gasZhDW7kMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: UUHIaWIN_OlSZSG5TcUaXx2FyNOm34pb
X-Proofpoint-ORIG-GUID: UUHIaWIN_OlSZSG5TcUaXx2FyNOm34pb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090101

    Introduce support for LE Channel Sounding (CS)
    ranging procedures in the Initiator role by enabling required
    HCI command sequencing and event handling.

    - Add transmission of core HCI LE CS commands:
      HCI_LE_CS_Read_Local_Supported_Capabilities,
      HCI_LE_CS_Read_Remote_Supported_Capabilities,
      HCI_LE_CS_Security_Enable,
      HCI_LE_CS_Create_Config,
      HCI_LE_CS_Remove_Config,
      HCI_LE_CS_Read_Remote_FAE_Table,
      HCI_LE_CS_Set_Channel_Classification,
      HCI_LE_CS_Set_Procedure_Parameters,
      HCI_LE_CS_Procedure_Enable

    - Add handling of event:
      HCI_LE_CS_Read_Remote_FAE_Table_Complete

    This enables cs capability discovery, cs configuration management
    and execution of CS ranging procedures in the Initiator role.

    - CS init pipeline not yet wired up pending D-Bus API.
    bt_rap_read_local_supported_capabilities() has no caller,
    mark __maybe_unused till DBus APIs are introduced.
---
 profiles/ranging/rap.c     |   3 +-
 profiles/ranging/rap_hci.c | 876 +++++++++++++++++++++++++++++++++----
 2 files changed, 783 insertions(+), 96 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index e0a46a87a..e3b50c145 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -421,7 +421,8 @@ static int rap_accept(struct btd_service *service)
 			bt_rap_set_conn_handle(data->hci_sm,
 						data->rap, handle,
 						(const uint8_t *) bdaddr,
-						bdaddr_type);
+						bdaddr_type,
+					btd_device_is_initiator(device));
 		} else {
 			error("Failed to find connection handle for device %s",
 				addr);
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index febe23384..873bbe6cb 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -16,14 +16,20 @@
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
 
+#ifndef __maybe_unused
+#define __maybe_unused __attribute__((unused))
+#endif
+
 /* Macro to sign-extend an N-bit value to 16-bit signed integer */
 #define SIGN_EXTEND_TO_16(val, bits) \
 	((int16_t)(((val) ^ (1U << ((bits)-1))) - (1U << ((bits)-1))))
@@ -67,6 +73,7 @@ struct cs_state_machine {
 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
 	uint8_t role_enable;  /* Role value for HCI commands (1, 2, or 3) */
 	struct queue *conn_mappings;  /* Per-instance connection mappings */
+	struct timespec last_chan_class_time;  /* For 1-second rate limit */
 };
 
 /* Connection Handle Mapping */
@@ -74,10 +81,18 @@ struct rap_conn_mapping {
 	uint16_t handle;
 	uint8_t bdaddr[6];
 	uint8_t bdaddr_type;
+	bool is_central;  /* true if local device is BLE Central on this link */
 	struct bt_att *att;
 	struct bt_rap *rap;
 };
 
+/* Function declarations */
+static bool bt_rap_read_remote_fae_table(void *hci_sm, uint16_t handle);
+static void rap_send_hci_cs_create_config_command(struct cs_state_machine *sm,
+						uint16_t handle);
+static bool bt_rap_read_remote_supported_capabilities(void *hci_sm,
+		uint16_t handle);
+
 /* Connection Mapping Helper Functions */
 static void mapping_free(void *data)
 {
@@ -97,14 +112,6 @@ static bool match_mapping_handle(const void *a, const void *b)
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
@@ -118,19 +125,14 @@ static struct rap_conn_mapping *find_mapping_by_handle(
 
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
@@ -138,6 +140,7 @@ static bool add_conn_mapping(struct cs_state_machine *sm, uint16_t handle,
 		if (bdaddr)
 			memcpy(mapping->bdaddr, bdaddr, 6);
 		mapping->bdaddr_type = bdaddr_type;
+		mapping->is_central = is_central;
 		mapping->att = att;
 		mapping->rap = rap;
 		return true;
@@ -152,6 +155,7 @@ static bool add_conn_mapping(struct cs_state_machine *sm, uint16_t handle,
 	if (bdaddr)
 		memcpy(mapping->bdaddr, bdaddr, 6);
 	mapping->bdaddr_type = bdaddr_type;
+	mapping->is_central = is_central;
 	mapping->att = att;
 	mapping->rap = rap;
 
@@ -171,13 +175,28 @@ static void remove_conn_mapping(struct cs_state_machine *sm, uint16_t handle)
 		mapping_free(mapping);
 }
 
-static void remove_rap_mappings(struct cs_state_machine *sm)
+static struct bt_rap *resolve_handle_to_rap(struct cs_state_machine *sm,
+						uint16_t handle)
 {
-	if (!sm || !sm->conn_mappings)
-		return;
+	struct rap_conn_mapping *mapping;
 
-	queue_remove_all(sm->conn_mappings, match_mapping_rap, sm->rap,
-				mapping_free);
+	if (!sm)
+		return NULL;
+
+	/* Try to find in mapping cache */
+	mapping = find_mapping_by_handle(sm, handle);
+	if (mapping && mapping->rap) {
+		DBG("Found handle 0x%04X in mapping cache", handle);
+		return mapping->rap;
+	}
+
+	/* Profile layer should have called bt_rap_set_conn_handle() during
+	 * connection establishment. If we reach here, the mapping was not set.
+	 */
+	DBG("No mapping found for handle 0x%04X", handle);
+	DBG("Profile layer should call bt_rap_set_conn_handle() on connect");
+
+	return NULL;
 }
 
 /*  State Machine Functions */
@@ -194,6 +213,7 @@ static void cs_state_machine_init(struct cs_state_machine *sm,
 	sm->hci = hci;
 	sm->initiator = false;
 	sm->procedure_active = false;
+	sm->conn_mappings = queue_new();
 
 	/* Store role_enable for HCI commands (1, 2, or 3 from config) */
 	sm->role_enable = role;
@@ -219,8 +239,8 @@ static void cs_set_state(struct cs_state_machine *sm,
 		return;
 
 	/* Validate state values before array access */
-	if (sm->current_state > CS_STATE_UNSPECIFIED ||
-	    new_state > CS_STATE_UNSPECIFIED) {
+	if ((unsigned int)sm->current_state >= ARRAY_SIZE(state_names) ||
+	    (unsigned int)new_state >= ARRAY_SIZE(state_names)) {
 		error("Invalid state transition attempted");
 		return;
 	}
@@ -238,11 +258,85 @@ static enum cs_state cs_get_current_state(struct cs_state_machine *sm)
 	return sm ? sm->current_state : CS_STATE_UNSPECIFIED;
 }
 
+static bool is_initiator_role(const struct cs_state_machine *sm)
+{
+	return sm->role_enable == 0x01 || sm->role_enable == 0x03;
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
 static void rap_def_settings_done_cb(const void *data, uint8_t size,
 					void *user_data)
 {
-	struct bt_hci_rsp_le_cs_set_def_settings *rp;
+	const struct bt_hci_rsp_le_cs_set_def_settings *rp;
 	struct cs_state_machine *sm = user_data;
 
 	if (!sm || !data || size < sizeof(*rp))
@@ -250,10 +344,11 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 
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
 
@@ -261,9 +356,13 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 		/* Success - proceed to configuration */
 		cs_set_state(sm, CS_STATE_WAIT_CONFIG_CMPLT);
 
-		/* Reflector role */
-		DBG("Waiting for CS Config Completed event...");
-		/* TODO: Initiator role - Send CS Config complete cmd */
+		/* If role is initiator, send CS Create Config command */
+		if (is_initiator_role(sm)) {
+			rap_send_hci_cs_create_config_command(sm, rp->handle);
+		} else {
+			/* Reflector role */
+			DBG("Reflector role: Waiting for CS Config Completed");
+		}
 	} else {
 		/* Error - transition to stopped */
 		error("CS Set default setting failed with status 0x%02X",
@@ -272,8 +371,196 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 	}
 }
 
-static void rap_send_hci_def_settings_command(struct cs_state_machine *sm,
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
@@ -285,8 +572,8 @@ static void rap_send_hci_def_settings_command(struct cs_state_machine *sm,
 
 	memset(&cp, 0, sizeof(cp));
 
-	if (handle)
-		cp.handle = handle;
+	if (ev->handle)
+		cp.handle = ev->handle;
 
 	cp.role_enable = sm->role_enable;  /* Use preserved HCI command value */
 	cp.cs_sync_antenna_selection = sm->cs_opt.cs_sync_ant_sel;
@@ -302,12 +589,93 @@ static void rap_send_hci_def_settings_command(struct cs_state_machine *sm,
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
 static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 					   void *user_data)
 {
 	struct cs_state_machine *sm = user_data;
 	const struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *evt;
+	struct bt_rap *rap;
 	struct iovec iov;
+	uint16_t subfeatures_supported;
 
 	if (!sm || !data || size < sizeof(*evt))
 		return;
@@ -334,6 +702,16 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 		return;
 	}
 
+	/* Resolve handle to RAP instance */
+	rap = resolve_handle_to_rap(sm, evt->handle);
+
+	if (!rap) {
+		DBG("[WARN] Could not resolve handle 0x%04X to RAP instance",
+			evt->handle);
+		/* Continue with state machine RAP for now */
+		rap = sm->rap;
+	}
+
 	DBG("num_config=%u, ",
 		evt->num_config_supported);
 	DBG("max_consecutive_proc=%u, num_antennas=%u, ",
@@ -343,9 +721,26 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
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
@@ -383,8 +778,15 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
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
@@ -428,12 +830,40 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
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
@@ -486,9 +916,27 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
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
+			// Reflector role
+			DBG("Reflector role: Waiting for CS Proc compl event");
+		}
 	} else {
 		/* Error - transition to stopped */
 		error("Security enable failed with status 0x%02X",
@@ -565,8 +1013,13 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
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
@@ -800,6 +1253,54 @@ static void parse_cs_step(struct iovec *iov, struct cs_step_data *step,
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
@@ -822,7 +1323,6 @@ static void rap_cs_subevt_result_evt(const void *data, uint8_t size,
 	uint8_t abort_reason;
 	uint8_t num_ant_paths;
 	uint8_t num_steps_reported;
-	uint8_t i;
 
 	if (!sm || !data ||
 		size < sizeof(struct bt_hci_evt_le_cs_subevent_result))
@@ -883,28 +1383,13 @@ static void rap_cs_subevt_result_evt(const void *data, uint8_t size,
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
+	cs_parse_steps(&iov, num_steps_reported,
+			proc_done_status, subevt_done_status, abort_reason,
+			cs_role, cs_rtt_type, max_paths,
+			rap_ev->step_data, &rap_ev->num_steps_reported,
+			&send_len,
+			offsetof(struct rap_ev_cs_subevent_result, step_data));
 
-	/* Parse interleaved step data from remaining iovec data */
-	for (i = 0; i < steps; i++)
-		parse_cs_step(&iov, &rap_ev->step_data[i], cs_role, cs_rtt_type,
-			max_paths);
-
-send_event:
 	DBG("CS subevent result processed: %zu bytes, ", send_len);
 	bt_rap_hci_cs_subevent_result_callback(send_len, rap_ev, sm->rap);
 	free(rap_ev);
@@ -920,7 +1405,7 @@ static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t size,
 	uint8_t cs_rtt_type;
 	uint8_t max_paths;
 	uint8_t steps;
-	size_t send_len = 0;
+	size_t send_len;
 	uint16_t handle;
 	uint8_t config_id;
 	uint8_t proc_done_status;
@@ -928,7 +1413,6 @@ static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t size,
 	uint8_t abort_reason;
 	uint8_t num_ant_paths;
 	uint8_t num_steps_reported;
-	uint8_t i;
 
 	if (!sm || !data ||
 		size < sizeof(struct bt_hci_evt_le_cs_subevent_result_continue))
@@ -981,28 +1465,14 @@ static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t size,
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
+			offsetof(struct rap_ev_cs_subevent_result_cont,
+							step_data));
 
-send_event:
 	DBG("CS subevent result cont processed: %zu bytes, ", send_len);
 	bt_rap_hci_cs_subevent_result_cont_callback(send_len, rap_ev, sm->rap);
 	free(rap_ev);
@@ -1010,6 +1480,208 @@ send_event:
 
 /* Subevent handler function type */
 
+/* This cmd is used by host to update channel classification
+ * function will be used when user sets channel classification
+ * keeping it unused till DBUS API is added */
+bool __maybe_unused bt_rap_set_channel_classification(void *hci_sm,
+		const uint8_t *channel_map)
+{
+	struct cs_state_machine *sm = hci_sm;
+	struct bt_hci_cmd_le_cs_set_chan_class cmd;
+	struct timespec now;
+	unsigned int status;
+	uint8_t default_map[10];
+	int i, enabled_count = 0;
+	long diff_ms;
+
+	if (!sm || !sm->hci) {
+		error("Invalid state machine or HCI");
+		return false;
+	}
+
+	/* If no channel map provided, create default map */
+	if (!channel_map) {
+		memset(default_map, 0, sizeof(default_map));
+
+		/* Enable channels 2-22 and 26-76 (total 72 channels)
+		 * Channels 0, 1, 23, 24, 25, 77, 78, 79 are reserved/disabled
+		 */
+		for (i = 2; i <= 22; i++) {
+			default_map[i / 8] |= (1 << (i % 8));
+		}
+		for (i = 26; i <= 76; i++) {
+			default_map[i / 8] |= (1 << (i % 8));
+		}
+
+		channel_map = default_map;
+	} else {
+		/* Validate the provided channel map */
+		/* Check reserved channels are disabled */
+		if ((channel_map[0] & 0x03) != 0) {  /* Channels 0, 1 */
+			error("Channels 0 and 1 must be disabled (reserved)");
+			return false;
+		}
+		if ((channel_map[2] & 0x80) != 0) {  /* Channel 23 */
+			error("Channel 23 must be disabled (reserved)");
+			return false;
+		}
+		if ((channel_map[3] & 0x03) != 0) {  /* Channels 24, 25 */
+			error("Channels 24 and 25 must be disabled (reserved)");
+			return false;
+		}
+		if ((channel_map[9] & 0xE0) != 0) { /* Ch 77, 78 and RFU bit */
+			error("Channels 77, 78, 79 must be disabled (res)");
+			return false;
+		}
+
+		/* Count enabled channels using popcount; mask reserved bits:
+		 * ch 0-1 (byte 0 bits 0-1), ch 23 (byte 2 bit 7),
+		 * ch 24-25 (byte 3 bits 0-1), ch 77-79 (byte 9 bits 5-7).
+		 */
+		{
+			uint8_t masked[10];
+
+			memcpy(masked, channel_map, 10);
+			masked[0] &= 0xFC;
+			masked[2] &= 0x7F;
+			masked[3] &= 0xFC;
+			masked[9] &= 0x1F;
+			for (i = 0; i < 10; i++)
+				enabled_count += __builtin_popcount(masked[i]);
+		}
+
+		if (enabled_count < 15) {
+			error("At least 15 channels must be enabled (found %d)",
+				enabled_count);
+			return false;
+		}
+	}
+
+	/* Controller rejects with Command Disallowed (0x0C)
+	 * if less than 1 second has elapsed since the
+	 * last invocation. Enforce the limit here to avoid silent failures.
+	 */
+	clock_gettime(CLOCK_MONOTONIC, &now);
+	if (sm->last_chan_class_time.tv_sec != 0 ||
+	    sm->last_chan_class_time.tv_nsec != 0) {
+		diff_ms = (now.tv_sec -
+				sm->last_chan_class_time.tv_sec) * 1000 +
+			   (now.tv_nsec -
+				sm->last_chan_class_time.tv_nsec) / 1000000;
+
+		if (diff_ms < 1000) {
+			error("CS Set Channel Classification throttled: "
+				"only %ldms since last call (min 1000ms)",
+				diff_ms);
+			return false;
+		}
+	}
+	sm->last_chan_class_time = now;
+
+	DBG("Sending CS Set Channel Classification command");
+
+	memset(&cmd, 0, sizeof(cmd));
+	memcpy(cmd.channel_classification, channel_map, 10);
+
+	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_SET_CHAN_CLASS,
+				&cmd, sizeof(cmd), NULL, sm, NULL);
+
+	if (!status) {
+		error("Failed to send CS Set Channel Classification command");
+		return false;
+	}
+
+	DBG("CS Set Channel Classification command sent successfully");
+	return true;
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
+/* This cmd is used by host to start cs distance measurement procedure
+ * function will be used when user start distance measurement
+ * keeping it unused till DBUS API is added */
+static bool __maybe_unused bt_rap_read_local_supported_capabilities(
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
 static void unregister_event_id(void *data, void *user_data)
 {
 	struct bt_hci *hci = user_data;
@@ -1041,6 +1713,11 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 				max_tx_power);
 
 	sm->event_ids = queue_new();
+	if (!sm->event_ids) {
+		error("Failed to allocate event_ids queue");
+		free(sm);
+		return NULL;
+	}
 
 	/* Register each LE Meta subevent individually */
 	id = bt_hci_register_subevent(hci,
@@ -1051,6 +1728,15 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 
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
@@ -1100,12 +1786,14 @@ fail:
 	error("Failed to register hci le meta subevents");
 	queue_foreach(sm->event_ids, unregister_event_id, hci);
 	queue_destroy(sm->event_ids, NULL);
+	queue_destroy(sm->conn_mappings, mapping_free);
 	free(sm);
 	return NULL;
 }
 
-bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t handle,
-				const uint8_t *bdaddr, uint8_t bdaddr_type)
+bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap,
+		uint16_t handle, const uint8_t *bdaddr, uint8_t bdaddr_type,
+		bool is_central)
 {
 	struct cs_state_machine *sm = hci_sm;
 	struct bt_att *att;
@@ -1124,7 +1812,8 @@ bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t handle,
 			bdaddr[2], bdaddr[1], bdaddr[0], bdaddr_type);
 	}
 
-	return add_conn_mapping(sm, handle, bdaddr, bdaddr_type, att, rap);
+	return add_conn_mapping(sm, handle, bdaddr, bdaddr_type, is_central,
+				att, rap);
 }
 
 void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
@@ -1157,9 +1846,6 @@ void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm)
 		queue_destroy(sm->event_ids, NULL);
 
 		/* Clean up per-instance connection mappings */
-		remove_rap_mappings(sm);
-
-		/* Destroy the connection mappings queue */
 		queue_destroy(sm->conn_mappings, mapping_free);
 
 		/* Free the state machine */
-- 

