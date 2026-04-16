Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41119224F3
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 04:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776313233; cv=none; b=KzR+rm/igGHaoKtibHIyCJ9eF6DXe2gngTXA6Yo+pAP595oPErgR54WbZtwDKMiCwklQyde/j2jT80lzoOZM+a8ekbY1PqqYYR7M7GDZl6QfruYVKjD60X4vucxDjHbrhkKh8G4k/VPSKdtSYVOtBGAfNm0qEfnxNM2w+YIId0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776313233; c=relaxed/simple;
	bh=cxbU9ZsSsmeNh3kuBe+KS4oNlwuEyb4rhGuEBdkSguE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XuiFeYssJ/LJ1fvia3JESzwUzeJZIThpgBTDontPw9D/DAJRWsMl0oUkuskGcQoFGbf4ilBOUtRGp5NLXc22DunhjYFoZy9HJf8GuSWKqY2pZJadPZ6AC/G01+8AksNZPJdkV0NXuY54pYjG7c9qwHe0n5CyQtNglOZvkwCiPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dBYsB3jl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aPKQaTJU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dBYsB3jl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aPKQaTJU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G2vZfX506783
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 04:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Z/0ETnlWPgf
	qhM2fSMgLFeFctG5jfV6TjDpURtsKRLQ=; b=dBYsB3jlHoNhTkGvLxtIc0Of7uq
	qkN4Qv6mjS4S75gx7SWbVngheGoRE2aYt8NGJwM/MiGXUShWp7BYXFOmKSw4XIUD
	1xTeBtorm9Ej4lEq+q3hy+HTYWuiLQL1rMRhW39OOXmbUrvqPe22P2SnoIDnW6L6
	YyqXlf/yHpeA/jL+2DGNERwMv3PuMJzFTpmuYsiYXwpGPeny9RNDXLTlIHTC3mfv
	YSU127JO2tuK2H+UrkOMsldfPA+9Cn74RJuBfU/Rc0/8wxYa5IfvyNiLwE8KquFi
	qF77CSW6wTLveFp+FrouVwCuOSs4glPzXgk33b9fWt+2jE4hw4q3BFd22KA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dje1e1x1y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 04:20:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b24611696eso56386465ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 21:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776313230; x=1776918030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/0ETnlWPgfqhM2fSMgLFeFctG5jfV6TjDpURtsKRLQ=;
        b=aPKQaTJU0I5m6neoA3BmVqCn3/N9wuPlNCgliPPGuETYSFueszruXXBXPEapy5PDCi
         jjyEFpDiafwmFlkBb4+xHhl4DdCimBO8FWCM2ytKVIttuI2etEmtiuytfLpeXT4OQlbf
         XQtkqootXYFns4BtkBi9HXynaoL5pmdwpxjS6EXERaUmlxj/0Ck/CFNZozqc+EPQFIeH
         lnFCbJTXdbEZUSxbR+rDfUN4aXTPxAZVGck7NgqjdD58hvjDdlMGhgYrNMl63L4QSva3
         y5erk3O0mAMHPR/oEfNpRE/Cgd15YJuz7vD3hIKgcBgZvhtaNz67hMd9VIui5sRijSma
         dEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776313230; x=1776918030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z/0ETnlWPgfqhM2fSMgLFeFctG5jfV6TjDpURtsKRLQ=;
        b=C6I/knn4l/3AmovWbKi3mKpa9d65mQ4k+F5adN8lDhe90521H5rU05RUCGVKj6YhoL
         1zFjqTkN/lI7lH3GZWnO66i6bZT03/AKJEE9S31MhGCVpaVFT/+zbpZ8dNQzEUd8q2vc
         M6DN+iSVi/82Nby99Bqvc2b6V3qE+xpuQKlZn/6Mf8gcv+HninnjN86ZwagmR4RZJBYf
         ElgM3hKER2DMaVr4MDEJavLb2nSHHKPUs8uvUGVEKpjZvseqyCtt5KWpjawcIrfMWNKH
         sUciIBGq1muFkZFym5qvEHFkwPvCsbDwVz6hGY9HoiujSvznlP3ysox3DU+3SfHgCHL4
         MG/w==
X-Gm-Message-State: AOJu0Yz0UPOWvIRH1NJ64dUOwHUEi75xphpbDWN/BPjAiTrGTetzKK0R
	wdCHgt+CNJsyXqohOIPaj2T1cGbrO628xwdxxe+gl+zMTMrvGg7mW3vr+jmudMQOZcQ0ljEPO+9
	rpVeJgayTDmKVEd6In2jSm0Jmu2lSukJ8laKoTFEAk1Htbr8iWN53920ru4qXTGy08CcEGlMy8d
	k38EY=
X-Gm-Gg: AeBDievqKTms5qRRzqlNPL0Fr22cYQnlmTUjurhN5K6/WHjXEzEQiO6XsIN/1sQu/rG
	D8d3sTqpvaOL6Kl2wJoXWXpEJVVZQoJaG3Jugax755BrktysKkd1Z2WcCccwUquGTDkOEOruXnK
	lSOXeeNjq4fbTBDdUj7A2MPw1YdfKuHDWV1uFlPPwhMbx0jwr1EISojkZxQGFBnTt7airjC1MYc
	C1Ag34xQSxksrUADKLdlwbi1mAlOieZ07x+LiXt/6banUiOR4vWy2jXN2PSxqwKavAvy+YqV4J3
	+EXKg+2rv+C+yhkwYJSSnF2KhRaUdgYubSoZEoJZUlDHQLu4e5RcFQWAV3oUi2iWOJos9bqM7CY
	ZtldaYxpcCmD+yfXrGk1ewH25gEldc8QJOz4BKExOX4Y+UowQw4E=
X-Received: by 2002:a17:902:f64f:b0:2b4:6562:642b with SMTP id d9443c01a7336-2b4656265f5mr126826635ad.35.1776313229893;
        Wed, 15 Apr 2026 21:20:29 -0700 (PDT)
X-Received: by 2002:a17:902:f64f:b0:2b4:6562:642b with SMTP id d9443c01a7336-2b4656265f5mr126826345ad.35.1776313229373;
        Wed, 15 Apr 2026 21:20:29 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782abd6csm37208465ad.63.2026.04.15.21.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 21:20:28 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v9 1/3] shared: rap: Introduce Channel Sounding HCI raw  interface support
Date: Thu, 16 Apr 2026 09:50:10 +0530
Message-Id: <20260416042012.1204688-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416042012.1204688-1-naga.akella@oss.qualcomm.com>
References: <20260416042012.1204688-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HZwkiCE8 c=1 sm=1 tr=0 ts=69e0638f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=sRifeLEwFzd54yERP08A:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDAzNyBTYWx0ZWRfXz4V2d44HLsCR
 ct5cxd8pASXLE8zVWau9yGePiWt6iS10Pe+cFuWEjacrLWNRzK3KyFx1v/MiKDOkjs5al3UUDhv
 Q3vogz3Pfe2lpb1AjbHJFhetCDtDof0njQog9AnSh8oU15XKRiCMgL0ZGUIN8M2accDsR9Q1v3t
 VWpBKRW5p+GdcyO0gnTMm5Nb+uc+X46s3IddL3cfTRVuM9UnpFm7dYzPvlo696wbFPHtYm8lgSk
 3Pnf8YIYP026OswuIFjA4uPee9ZpFVIhIwyjzJCxrTKaiORpPV9otLikNQYtEZXf9cOQnZ9+jbp
 4ZN89T+wsI5JqPRSB+T8oAkYxaIMwyMNVGqKMCN6iaaUQdka9QRurqs+nAcE2J29zJNmxh0MH3m
 mmw2MyBNJUQ/DGCsdO+0oTvLNm/SxSMvt7jUcRCAhZeTPHuYpfqSY024xjbF3XmtGY0Kxpw6bLk
 ZUAa/aUwziXY82/4Kzg==
X-Proofpoint-ORIG-GUID: b3uJWMWlG5HLHIMOtpKMOAWe_lDxCdra
X-Proofpoint-GUID: b3uJWMWlG5HLHIMOtpKMOAWe_lDxCdra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160037

Implement stub callbacks for Channel Sounding HCI events and add the
required protocol definitions for CS configuration, procedure control,
and subevent result parsing

Add data structures to support Channel Sounding Processing
Add helper function to get hci conn info list and integrate it with RAP
---
 src/shared/hci.c |  62 ++++++++++++-----
 src/shared/hci.h |  12 ++++
 src/shared/rap.c |  50 +++++++++++++-
 src/shared/rap.h | 176 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 282 insertions(+), 18 deletions(-)

diff --git a/src/shared/hci.c b/src/shared/hci.c
index 575254c09..0faa6dea5 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -20,9 +20,11 @@
 #include <sys/un.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/ioctl.h>
 #include <fcntl.h>
 #include <errno.h>
 
+#include "bluetooth/hci.h"
 #include "monitor/bt.h"
 #include "src/shared/mainloop.h"
 #include "src/shared/io.h"
@@ -30,22 +32,6 @@
 #include "src/shared/queue.h"
 #include "src/shared/hci.h"
 
-#define BTPROTO_HCI	1
-struct sockaddr_hci {
-	sa_family_t	hci_family;
-	unsigned short	hci_dev;
-	unsigned short  hci_channel;
-};
-#define HCI_CHANNEL_RAW		0
-#define HCI_CHANNEL_USER	1
-
-#define SOL_HCI		0
-#define HCI_FILTER	2
-struct hci_filter {
-	uint32_t type_mask;
-	uint32_t event_mask[2];
-	uint16_t opcode;
-};
 
 struct bt_hci {
 	int ref_count;
@@ -673,3 +659,47 @@ bool bt_hci_unregister(struct bt_hci *hci, unsigned int id)
 
 	return true;
 }
+
+bool bt_hci_get_conn_handle(struct bt_hci *hci, const uint8_t *bdaddr,
+				uint16_t *handle)
+{
+	struct hci_conn_list_req *cl;
+	struct hci_conn_info *ci;
+	int fd, i;
+	bool found = false;
+
+	if (!hci || !bdaddr || !handle)
+		return false;
+
+	fd = io_get_fd(hci->io);
+	if (fd < 0)
+		return false;
+
+	/* Allocate buffer for connection list request */
+	cl = malloc(10 * sizeof(*ci) + sizeof(*cl));
+	if (!cl)
+		return false;
+
+	memset(cl, 0, 10 * sizeof(*ci) + sizeof(*cl));
+	cl->dev_id = 0;  /* Will be filled by ioctl */
+	cl->conn_num = 10;
+
+	/* Get connection list via ioctl */
+	if (ioctl(fd, HCIGETCONNLIST, (void *) cl) < 0) {
+		free(cl);
+		return false;
+	}
+
+	/* Search for the connection with matching bdaddr */
+	ci = cl->conn_info;
+	for (i = 0; i < cl->conn_num; i++, ci++) {
+		if (memcmp(&ci->bdaddr, bdaddr, 6) == 0) {
+			*handle = ci->handle;
+			found = true;
+			break;
+		}
+	}
+
+	free(cl);
+	return found;
+}
diff --git a/src/shared/hci.h b/src/shared/hci.h
index 76ee72f54..83f4cd1c0 100644
--- a/src/shared/hci.h
+++ b/src/shared/hci.h
@@ -13,6 +13,15 @@
 
 typedef void (*bt_hci_destroy_func_t)(void *user_data);
 
+struct bt_hci_conn_info {
+	uint16_t handle;
+	uint8_t  bdaddr[6];
+	uint8_t  type;
+	uint8_t  out;
+	uint16_t state;
+	uint32_t link_mode;
+};
+
 struct bt_hci;
 
 struct bt_hci *bt_hci_new(int fd);
@@ -41,3 +50,6 @@ unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
 				bt_hci_callback_func_t callback,
 				void *user_data, bt_hci_destroy_func_t destroy);
 bool bt_hci_unregister(struct bt_hci *hci, unsigned int id);
+
+bool bt_hci_get_conn_handle(struct bt_hci *hci, const uint8_t *bdaddr,
+				uint16_t *handle);
diff --git a/src/shared/rap.c b/src/shared/rap.c
index 39ef3f278..5745cda08 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -26,8 +26,8 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/rap.h"
 
-#define DBG(_rap, fmt, arg...) \
-	rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
+#define DBG(_rap, fmt, ...) \
+	rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ##__VA_ARGS__)
 
 #define RAS_UUID16			0x185B
 
@@ -504,6 +504,52 @@ bool bt_rap_unregister(unsigned int id)
 	return true;
 }
 
+void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
+						const void *param,
+						void *user_data)
+{
+	struct bt_rap *rap = user_data;
+
+	DBG(rap, "Received CS subevent CONT: len=%d", length);
+}
+
+void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
+					const void *param,
+					void *user_data)
+{
+	struct bt_rap *rap = user_data;
+
+	DBG(rap, "Received CS subevent: len=%d", length);
+}
+
+void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
+						const void *param,
+						void *user_data)
+{
+	struct bt_rap *rap = user_data;
+
+	DBG(rap, "Received CS procedure enable complete subevent: len=%d",
+	    length);
+}
+
+void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
+						 const void *param,
+						 void *user_data)
+{
+	struct bt_rap *rap = user_data;
+
+	DBG(rap, "Received CS security enable subevent: len=%d", length);
+}
+
+void bt_rap_hci_cs_config_complete_callback(uint16_t length,
+					const void *param,
+					void *user_data)
+{
+	struct bt_rap *rap = user_data;
+
+	DBG(rap, "Received CS config complete subevent: len=%d", length);
+}
+
 struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
 {
 	struct bt_rap *rap;
diff --git a/src/shared/rap.h b/src/shared/rap.h
index a1d1ff2ae..5b94d28bd 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -9,8 +9,155 @@
 #include <inttypes.h>
 
 #include "src/shared/io.h"
+#include "bluetooth/mgmt.h"
+#include "src/shared/hci.h"
 
 struct bt_rap;
+struct gatt_db;
+struct bt_gatt_client;
+
+/* Channel Sounding Events */
+struct bt_rap_hci_cs_options {
+	uint8_t role;
+	uint8_t cs_sync_ant_sel;
+	int8_t max_tx_power;
+	int rtt_type;
+};
+
+#define CS_MODE_ZERO				0x00
+#define CS_MODE_ONE				0x01
+#define CS_MODE_TWO				0x02
+#define CS_MODE_THREE				0x03
+
+#define CS_REFLECTOR			0x01
+#define CS_INITIATOR			0x00
+
+#define CS_MAX_ANT_PATHS			0x05
+#define CS_MAX_STEPS			0xA0
+#define CS_MAX_STEP_DATA_LEN		0xFF
+
+struct rap_ev_cs_config_cmplt {
+	uint8_t status;
+	uint16_t conn_hdl;
+	uint8_t config_id;
+	uint8_t action;
+	uint8_t main_mode_type;
+	uint8_t sub_mode_type;
+	uint8_t min_main_mode_steps;
+	uint8_t max_main_mode_steps;
+	uint8_t main_mode_rep;
+	uint8_t mode_0_steps;
+	uint8_t role;
+	uint8_t rtt_type;
+	uint8_t cs_sync_phy;
+	uint8_t channel_map[10];
+	uint8_t channel_map_rep;
+	uint8_t channel_sel_type;
+	uint8_t ch3c_shape;
+	uint8_t ch3c_jump;
+	uint8_t reserved;
+	uint8_t t_ip1_time;
+	uint8_t t_ip2_time;
+	uint8_t t_fcs_time;
+	uint8_t t_pm_time;
+} __packed;
+
+struct rap_ev_cs_sec_enable_cmplt {
+	uint8_t status;
+	uint16_t conn_hdl;
+} __packed;
+
+struct rap_ev_cs_proc_enable_cmplt {
+	uint8_t status;
+	uint16_t conn_hdl;
+	uint8_t config_id;
+	uint8_t state;
+	uint8_t tone_ant_config_sel;
+	int8_t sel_tx_pwr;
+	uint8_t sub_evt_len[3];
+	uint8_t sub_evts_per_evt;
+	uint16_t sub_evt_intrvl;
+	uint16_t evt_intrvl;
+	uint16_t proc_intrvl;
+	uint16_t proc_counter;
+	uint16_t max_proc_len;
+} __packed;
+
+#define CS_MAX_STEPS			0xA0
+
+struct pct_iq_sample {
+	int16_t i_sample;
+	int16_t q_sample;
+} __packed;
+
+struct cs_mode_zero_data {
+	uint8_t packet_quality;
+	uint8_t packet_rssi_dbm;
+	uint8_t packet_ant;
+	uint32_t init_measured_freq_offset;
+} __packed;
+
+struct cs_mode_one_data {
+	uint8_t packet_quality;
+	uint8_t packet_rssi_dbm;
+	uint8_t packet_ant;
+	uint8_t packet_nadm;
+	int16_t toa_tod_init;
+	int16_t tod_toa_refl;
+	struct pct_iq_sample packet_pct1;
+	struct pct_iq_sample packet_pct2;
+} __packed;
+
+struct cs_mode_two_data {
+	uint8_t ant_perm_index;
+	struct pct_iq_sample tone_pct[4];
+	uint8_t tone_quality_indicator[4];
+} __packed;
+
+struct cs_mode_three_data {
+	struct cs_mode_one_data mode_one_data;
+	struct cs_mode_two_data mode_two_data;
+} __packed;
+
+union cs_mode_data {
+	struct cs_mode_zero_data mode_zero_data;
+	struct cs_mode_one_data mode_one_data;
+	struct cs_mode_two_data mode_two_data;
+	struct cs_mode_three_data mode_three_data;
+};
+
+struct cs_step_data {
+	uint8_t step_mode;
+	uint8_t step_chnl;
+	uint8_t step_data_length;
+	union cs_mode_data step_mode_data;
+} __packed;
+
+struct rap_ev_cs_subevent_result {
+	uint16_t conn_hdl;
+	uint8_t config_id;
+	uint16_t start_acl_conn_evt_counter;
+	uint16_t proc_counter;
+	uint16_t freq_comp;
+	uint8_t ref_pwr_lvl;
+	uint8_t proc_done_status;
+	uint8_t subevt_done_status;
+	uint8_t abort_reason;
+	uint8_t num_ant_paths;
+	uint8_t num_steps_reported;
+	struct cs_step_data step_data[];
+} __packed;
+
+struct rap_ev_cs_subevent_result_cont {
+	uint16_t conn_hdl;
+	uint8_t config_id;
+	uint8_t proc_done_status;
+	uint8_t subevt_done_status;
+	uint8_t abort_reason;
+	uint8_t num_ant_paths;
+	uint8_t num_steps_reported;
+	struct cs_step_data step_data[];
+} __packed;
 
 typedef void (*bt_rap_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_rap_ready_func_t)(struct bt_rap *rap, void *user_data);
@@ -43,3 +190,32 @@ bool bt_rap_ready_unregister(struct bt_rap *rap, unsigned int id);
 bool bt_rap_unregister(unsigned int id);
 
 struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb);
+
+/* HCI Raw Channel Approach */
+void bt_rap_hci_cs_config_complete_callback(uint16_t length,
+					     const void *param,
+					     void *user_data);
+void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
+						 const void *param,
+						 void *user_data);
+void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
+						      const void *param,
+						      void *user_data);
+void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
+					     const void *param,
+					     void *user_data);
+void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
+						  const void *param,
+						  void *user_data);
+
+void bt_rap_hci_set_options(uint8_t role, uint8_t cs_sync_ant_sel,
+				   int8_t max_tx_power);
+
+bool bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci);
+void bt_rap_detach_hci(struct bt_rap *rap);
+void bt_rap_hci_sm_cleanup(void);
+
+/* Connection handle mapping functions */
+bool bt_rap_set_conn_handle(struct bt_rap *rap, uint16_t handle,
+				const uint8_t *bdaddr, uint8_t bdaddr_type);
+void bt_rap_clear_conn_handle(struct bt_rap *rap, uint16_t handle);
-- 

