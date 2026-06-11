Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19F9346E74
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179276; cv=none; b=rmBny1AUaK6jME2QsvpO4oABHw615QgLeX3QXyRwKlBK9bcQ7IUsLp7N0IUl0KgBGh5ZkwCdn3gt1QsCEr9+linuEOTeiW2vkpnGiiFEqDFQqYWiog3vMYyiu7uvHU576Wnbv7+ZtB1VL5bOYawPbhBM9umjkoDrvPsHfNwu6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179276; c=relaxed/simple;
	bh=Q+e18mjZulop6Y59gTXb8ujq4PgMUDZ3rmOGybRST3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWO57vwjRF0AwxFxElPlwUXR4CDBzAhnCkMnerJxi70yKDTqWTuVbDtQO8IYvtNcBOcQSApfp8AluiakDl2ibhq50cwdCk341DVSqj68qzCyq+F/t0oh2MXABZLzMgRtnVpt2L748wLWiMZ9spVOYI+TlDq16tPIdvTWqnqXpqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kfNtCADH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XVbmlcmk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kfNtCADH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XVbmlcmk"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B9xAe4263521
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	16yRiXiITj8LyWVyXfdxY+1HsjJ4sAefThplsNH4bWg=; b=kfNtCADHhBfIMqOi
	LWcon7IR9BCamawUnBEsZffWJyxk+zgBQImOtz9nTSWH41iTE5AhHBnG/s7pJw+E
	4a6tB6n79PfG3C4vSWbAhCzlvzdag93hcDLCuaXXo7UZ30amFVTirdZ3VAzOfnB+
	cWMy6l2MaO+C9fpBeumZXWxQFjlLkOpmdSJN/QJaw7IIqWKKXL8ynoOStX4SzyT1
	q2WQGUTwC9jz2s0TEGx43huU3Bz2XwA+vF0V12Efylo9dnjuuGc6xdFukjSTbSwS
	FW1dBpYq7EhHcw/V2X67IulmmtZRk/AcCJPZOrvIm39yPbR8L4olTlxYofGgE1c0
	Xdl8GA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6uu8gu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:01:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d98b6f019so7772788a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781179272; x=1781784072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16yRiXiITj8LyWVyXfdxY+1HsjJ4sAefThplsNH4bWg=;
        b=XVbmlcmkXZTCQn2NOxLFENJ79yk9p2o4zSRez6uLLhQf9QQC6hKIXYs5IQ42WoJaw0
         A6la2PWwpKRdX7OUlefyY6SHdLt/WBEJCS6SzMlmcPjJg69m7VELyYBDckWkXmHr4c/9
         cBL4pYTYG1IZPj817wI3gEKavyiebKhkFAg/2ZK+YZxUNk941KJHboQMXmzd45SjvrIM
         zpcmFTkF8osVKQmr3W+OAkf+uLYNBcJahKyoh2CvfSQFYQ1K7D9laruo8gRcFH81WQzK
         6XORLK/bzGq3zIhd0ybVA5um4xdreTKjnWBmzCUgnBbphE3eK0sxNlxnHUbnBGl98p7r
         WE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781179272; x=1781784072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=16yRiXiITj8LyWVyXfdxY+1HsjJ4sAefThplsNH4bWg=;
        b=AlS0TNvLPyV4MyjOvRqI33jhxZ/KvSNjb2t+WoXfVUgFtSfB+jxhojilDx01PuQYxQ
         na7lnY/6Oe1NuiufnA56w+OUBSadAUq0Ttmff0TuTgdKQtpPXLvF+/zyXZq47BdC+V6S
         DG0B308O5FczNSfdbn/NPrS38NrbhTv8z15ov1CKpUXu3CWEo9y9cyRlrymyZntrgYw3
         iBTGzsWy6qHAdAx3LwG1EN5EAGVo85AhfN2WlfrJ4OoMWQANgPbV7qD0GRJYHxs/Gz3G
         zTux1z9v/VKYdkcLL/ba2V1lXovYKUP06wnag797tJqI2QtGOEkl+wtCQ6lFqFD0kWat
         wEKg==
X-Gm-Message-State: AOJu0YxeZ+v5ktzLHCeiBF+1v0sY4bicBa4NWhgHQCMHp48QGAl/mb+L
	tZlmHVd2uNUfoCNbRFHf4xdsGoJB/ZVW77m4+cgmuYOsT5lgeIOE8v6C3xqAaAixRF/axflng0g
	h7cZfp8wic0JxAk7yLNobHJ2FgLXyCb6OyCO6DkmNh4s4bDiCJUxfrmynSQ2xOJG5k4CC8stSI7
	QJQV8=
X-Gm-Gg: Acq92OGQe0n/sqn+W6PxCiGgpQUth9d4v4mavSpOR0x8bOfeq2OjywGFAGf2t+8epBG
	G3oC+QYw9LCs1BUOrSoPmlQt2enoeWhG77k+UKV4Ghq4kFhQkQJDEv2bZx/mlcGkQTYqjJaig1f
	6qkAzIP7S+qmqIv8Nzw87nYH/V81zTCyZ80svPYoQ28c2KI78cnVzflw4rdGlCbgd49yRkQiTaU
	1YzVlItEWR0p7o89pB4g7/FmQ0UPPmDTSAWAFdW4SIY5Nc5hzQO+fSfFwdhqBSS+/b5+EsXk7b2
	o0UYUEsMvHdWVXGCjaarBdZimxNKSC6x78uRJiBB2b4fWmio/FJp3XRYmMpy9pCHafbu7VZEARg
	uKHIvo9/PzosLOXNr7h7pywO5Vr84s8jMGGb6NF+fPMmqMhtp5ZAEa8FiUVWtAA==
X-Received: by 2002:a17:90b:4990:b0:36d:b12f:6143 with SMTP id 98e67ed59e1d1-377a8adc459mr2638356a91.25.1781179271662;
        Thu, 11 Jun 2026 05:01:11 -0700 (PDT)
X-Received: by 2002:a17:90b:4990:b0:36d:b12f:6143 with SMTP id 98e67ed59e1d1-377a8adc459mr2638279a91.25.1781179270776;
        Thu, 11 Jun 2026 05:01:10 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37755e5c283sm2437402a91.15.2026.06.11.05.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:01:09 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 2/3] profiles: ranging: Add CS Initiator cmd and evt handling
Date: Thu, 11 Jun 2026 17:30:43 +0530
Message-Id: <20260611120044.1641009-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611120044.1641009-1-naga.akella@oss.qualcomm.com>
References: <20260611120044.1641009-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2aa388 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=kjJPULdg0VD0-no7Fq0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyMCBTYWx0ZWRfX+HSvMu33xvzN
 hPF6I7Z2lX4K1JHyx3cQQqeNvBl7wAX8gT4OMHV5t+Dj2vj7+KDVAZa0kQ/VtY8irbUd31vU95I
 lylXC2whskeFmbrsD27+U7Sb2VDoPi8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyMCBTYWx0ZWRfX6ME7jD68jkoy
 6Pl6EwsAeI3luqCW50y2Id1s48sXorxXn27xXYv5NbVxF6dH3oEBrk5xBve8KBSIBUexhoqDnnz
 jEfpn147XmvOmwvJ0oec35xFxI76d9Xjm2sFCN7eelbpyc7Nn3yAnmugqsbUocZ3nC6OwUFRJZD
 FJvaiJciIEk5MBAKeRAx+xU4RTxayGZ62wAJPoAkqtAFrPSNxnW1M0k4ed08xJp1+GyqkYDTt4d
 OqHFbD8GLKSbjUH4RO4m92nWcfDsgCNZiJgX1ubyBqQzH9oTL4Zb1xG+Bp6qRpg170edK9tZd39
 6SsSd/fhEvNGaQ8wg4XKcdGKzQqCLqXZ4b/1gUxQrlqbz8NHoRb9O0qiWxQx+jhzOipzCoYhGAI
 r/AI6qQ2+3JM+CRWizlsJ0bdwjJxluNaa++zaI4QmvDHR4Xq6YTmuIv52bVYvhEjb6eBsRMPYLm
 7vBrwKPJPa/Vv31DHdg==
X-Proofpoint-GUID: AgSO7jq1wpfD4r8jlY0h95KbYsqtH4Xk
X-Proofpoint-ORIG-GUID: AgSO7jq1wpfD4r8jlY0h95KbYsqtH4Xk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110120

Introduce support for LE Channel Sounding (CS)
ranging procedures in the Initiator role by enabling
required HCI command sequencing and event handling.

Add handling of core HCI LE CS commands and events
This enables cs capability discovery, cs configuration
management and execution of CS ranging procedures
in the Initiator role.
---
 profiles/ranging/rap.c     |   9 +-
 profiles/ranging/rap_hci.c | 763 ++++++++++++++++++++++++++++++++-----
 2 files changed, 673 insertions(+), 99 deletions(-)

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
index febe23384..c0784502e 100644
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
 
@@ -67,6 +69,7 @@ struct cs_state_machine {
 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
 	uint8_t role_enable;  /* Role value for HCI commands (1, 2, or 3) */
 	struct queue *conn_mappings;  /* Per-instance connection mappings */
+	struct timespec last_chan_class_time;  /* For 1-second rate limit */
 };
 
 /* Connection Handle Mapping */
@@ -74,10 +77,18 @@ struct rap_conn_mapping {
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
@@ -97,14 +108,6 @@ static bool match_mapping_handle(const void *a, const void *b)
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
@@ -118,19 +121,14 @@ static struct rap_conn_mapping *find_mapping_by_handle(
 
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
@@ -138,6 +136,7 @@ static bool add_conn_mapping(struct cs_state_machine *sm, uint16_t handle,
 		if (bdaddr)
 			memcpy(mapping->bdaddr, bdaddr, 6);
 		mapping->bdaddr_type = bdaddr_type;
+		mapping->is_central = is_central;
 		mapping->att = att;
 		mapping->rap = rap;
 		return true;
@@ -152,6 +151,7 @@ static bool add_conn_mapping(struct cs_state_machine *sm, uint16_t handle,
 	if (bdaddr)
 		memcpy(mapping->bdaddr, bdaddr, 6);
 	mapping->bdaddr_type = bdaddr_type;
+	mapping->is_central = is_central;
 	mapping->att = att;
 	mapping->rap = rap;
 
@@ -171,13 +171,28 @@ static void remove_conn_mapping(struct cs_state_machine *sm, uint16_t handle)
 		mapping_free(mapping);
 }
 
-static void remove_rap_mappings(struct cs_state_machine *sm)
+static struct bt_rap *resolve_handle_to_rap(struct cs_state_machine *sm,
+						uint16_t handle)
 {
-	if (!sm || !sm->conn_mappings)
-		return;
+	struct rap_conn_mapping *mapping;
+
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
 
-	queue_remove_all(sm->conn_mappings, match_mapping_rap, sm->rap,
-				mapping_free);
+	return NULL;
 }
 
 /*  State Machine Functions */
@@ -194,6 +209,7 @@ static void cs_state_machine_init(struct cs_state_machine *sm,
 	sm->hci = hci;
 	sm->initiator = false;
 	sm->procedure_active = false;
+	sm->conn_mappings = queue_new();
 
 	/* Store role_enable for HCI commands (1, 2, or 3 from config) */
 	sm->role_enable = role;
@@ -219,8 +235,8 @@ static void cs_set_state(struct cs_state_machine *sm,
 		return;
 
 	/* Validate state values before array access */
-	if (sm->current_state > CS_STATE_UNSPECIFIED ||
-	    new_state > CS_STATE_UNSPECIFIED) {
+	if ((unsigned int)sm->current_state >= ARRAY_SIZE(state_names) ||
+	    (unsigned int)new_state >= ARRAY_SIZE(state_names)) {
 		error("Invalid state transition attempted");
 		return;
 	}
@@ -238,11 +254,85 @@ static enum cs_state cs_get_current_state(struct cs_state_machine *sm)
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
@@ -250,10 +340,11 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 
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
 
@@ -261,9 +352,13 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
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
@@ -272,8 +367,196 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 	}
 }
 
-static void rap_send_hci_def_settings_command(struct cs_state_machine *sm,
+static void rap_send_hci_cs_create_config_command(struct cs_state_machine *sm,
 						uint16_t handle)
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
+						uint16_t handle)
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
@@ -285,8 +568,8 @@ static void rap_send_hci_def_settings_command(struct cs_state_machine *sm,
 
 	memset(&cp, 0, sizeof(cp));
 
-	if (handle)
-		cp.handle = handle;
+	if (ev->handle)
+		cp.handle = ev->handle;
 
 	cp.role_enable = sm->role_enable;  /* Use preserved HCI command value */
 	cp.cs_sync_antenna_selection = sm->cs_opt.cs_sync_ant_sel;
@@ -302,12 +585,93 @@ static void rap_send_hci_def_settings_command(struct cs_state_machine *sm,
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
@@ -334,6 +698,16 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
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
@@ -343,9 +717,26 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
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
@@ -383,8 +774,15 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
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
@@ -428,12 +826,40 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
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
@@ -486,9 +912,27 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
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
@@ -565,8 +1009,13 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
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
@@ -800,6 +1249,54 @@ static void parse_cs_step(struct iovec *iov, struct cs_step_data *step,
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
@@ -822,7 +1319,6 @@ static void rap_cs_subevt_result_evt(const void *data, uint8_t size,
 	uint8_t abort_reason;
 	uint8_t num_ant_paths;
 	uint8_t num_steps_reported;
-	uint8_t i;
 
 	if (!sm || !data ||
 		size < sizeof(struct bt_hci_evt_le_cs_subevent_result))
@@ -883,28 +1379,13 @@ static void rap_cs_subevt_result_evt(const void *data, uint8_t size,
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
@@ -920,7 +1401,7 @@ static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t size,
 	uint8_t cs_rtt_type;
 	uint8_t max_paths;
 	uint8_t steps;
-	size_t send_len = 0;
+	size_t send_len;
 	uint16_t handle;
 	uint8_t config_id;
 	uint8_t proc_done_status;
@@ -928,7 +1409,6 @@ static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t size,
 	uint8_t abort_reason;
 	uint8_t num_ant_paths;
 	uint8_t num_steps_reported;
-	uint8_t i;
 
 	if (!sm || !data ||
 		size < sizeof(struct bt_hci_evt_le_cs_subevent_result_continue))
@@ -981,28 +1461,14 @@ static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t size,
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
+			offsetof(struct rap_ev_cs_subevent_result_cont,
+							step_data));
 
-	/* Parse interleaved step data from remaining iovec data */
-	for (i = 0; i < steps; i++)
-		parse_cs_step(&iov, &rap_ev->step_data[i], cs_role, cs_rtt_type,
-			max_paths);
-
-send_event:
 	DBG("CS subevent result cont processed: %zu bytes, ", send_len);
 	bt_rap_hci_cs_subevent_result_cont_callback(send_len, rap_ev, sm->rap);
 	free(rap_ev);
@@ -1010,6 +1476,96 @@ send_event:
 
 /* Subevent handler function type */
 
+/* Set Ch Classif cmd handling to be added after DBus support enabled */
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
@@ -1040,7 +1596,15 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 	cs_state_machine_init(sm, rap, hci, role, cs_sync_ant_sel,
 				max_tx_power);
 
+	/* place holder, need DBus API to be called */
+	bt_rap_read_local_supported_capabilities(sm);
+
 	sm->event_ids = queue_new();
+	if (!sm->event_ids) {
+		error("Failed to allocate event_ids queue");
+		free(sm);
+		return NULL;
+	}
 
 	/* Register each LE Meta subevent individually */
 	id = bt_hci_register_subevent(hci,
@@ -1051,6 +1615,15 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 
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
@@ -1100,12 +1673,14 @@ fail:
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
@@ -1124,7 +1699,8 @@ bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t handle,
 			bdaddr[2], bdaddr[1], bdaddr[0], bdaddr_type);
 	}
 
-	return add_conn_mapping(sm, handle, bdaddr, bdaddr_type, att, rap);
+	return add_conn_mapping(sm, handle, bdaddr, bdaddr_type, is_central,
+				att, rap);
 }
 
 void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
@@ -1157,9 +1733,6 @@ void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm)
 		queue_destroy(sm->event_ids, NULL);
 
 		/* Clean up per-instance connection mappings */
-		remove_rap_mappings(sm);
-
-		/* Destroy the connection mappings queue */
 		queue_destroy(sm->conn_mappings, mapping_free);
 
 		/* Free the state machine */
-- 

