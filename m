Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC801D6195
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067244; cv=none; b=T5BBa85UEGDw5Pgufv4LKamqNHy7x8KKG53P1bHymtuHur0jVygIRhyHIxMhkVd19zf0pqt+ISmEJXBZbaBOQjoKaCemOzqEAcRzFhQwlsV3OMEMjTCM4UpESdo9wyvH26SltpCQHgqYapwKjrQrzmoielHFxsObDY9tfsnmkpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067244; c=relaxed/simple;
	bh=WP1VkMqMpH/puSWetMPEnt1vMG1Tge21kzUyG/JlboU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pVdWg69O463niPVKAneSvrUC7GbFEgVgZN0yOnRELd+iVvgNhZH7cGG0ewJ2OdmKJQ/ud+udPLzrCJDuXkTp5Icg0T+dmNjW0FMW1nYn8JyedNXn/5BfoFjOQRf4ZN26mIM5PwM9qaCrjn4BJqCg7JpvmrXyz54FcfKG6TlHzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lpl29j2v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L9SQ2wLt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lpl29j2v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L9SQ2wLt"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D6xnYe2662866
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 08:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jKxyjMK0Xd9
	qo8oyWMGEK1Uts0osWzamS4e7KKGTG78=; b=Lpl29j2vuiwIoQd6bV3VrzpSF4f
	mTj8omO5r5+rHijM59p8+xJiXTfygmAEussvnHoOw3abK2MkWJFAieZuMmfK3+su
	SdiULZMJ6WZ+nYGx27q+pLYzLL31M4IJjz0NshdFhU/alk0XPfI9Yjo2rBaCSHNx
	tFHBfqAxzmau2Dmc7NNRNEBre0BVBLvT8EdaEcewNWKQmAZT+0Ifpab2DxpeRn3L
	Yk15jcrtKYN4Nz3pSM6D0/MRaMgC9BOoaa+SbEcueTX8UlWJQxBbVL91qYzD/jMF
	J50FjMjL4Uj+RXRs1AxYshiJadoDr3T//kEpob4dmkL4KhbNGx60f1+ZMew==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dffk6mawr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 08:00:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fb3bebb30so1474315a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776067241; x=1776672041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKxyjMK0Xd9qo8oyWMGEK1Uts0osWzamS4e7KKGTG78=;
        b=L9SQ2wLtz3+15F15ffCwPMuD4zibqXrkvYNP7WbR2urMTk0gJSWz1JeY1WZuBAMHC6
         0ZaRX+Tc274zUMmdcGT4eUwTK8FFzn4Un4Jpq9Hho2ouULpeAcUJCGoNgG+efKJ19byz
         z1WFHrmrjx/2JwTvqzmkZp2DlNoNdF6ASWmJtYQX/WBV3UTUV1IqW2WDcj3SZxRzDaiI
         3+CS4ROT2vKR1PxHBisBIjTaSyHpwrWPF/2CKn0Mgzw56PXPSq9Vl6cj7E8Q5nF+mpW9
         1hn7MW9w8jiZsr9CQxSp7z8vJW+Rg0UcTwJC5/INny2f09U3QtImNrNz2LNcsgwYRdDp
         ONUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067241; x=1776672041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKxyjMK0Xd9qo8oyWMGEK1Uts0osWzamS4e7KKGTG78=;
        b=h6Ko9h91T7mVUp+kUDQSM7zFx1mlLJhJOg+J3ltVPMp9I3YrT67DxvO8FndL6/z7Zf
         GjB47eu1HwlyGQEMT85HijmYfftpDuGdZH8qdfuSde3o8NCOS54efQNp/4qiXGMKC3mT
         Gf+uM0DQbgzC7cJ1aGFAZdHH9YlrNl0L6Ri33ShpXPKMMeJMiNc74Ft9RQ1YNThs919R
         aUOZggxHjZX+ZI964Q2xkAYBGom0r3Jw321J2b0sp5upIMNtzUEBDn2uJrcnbFNzuqSq
         2+Jk+qxEXx9mQJgrxY4FaG1gXHyQX5ftVs51y9aRy2y3gEXVZbmi8DR9mP3vGGRZdz6m
         FB9w==
X-Gm-Message-State: AOJu0YzOcOOsr8gzroKtXuH4xFfLOYYMYA9IoYfRaWSUsFf+bHRGlcAt
	nJCzY2I3Jmfw+wG6XfWrHQHavRG5JS70ifHbXqI4DH8UY0Hrv3C/bmcodFTFiqu4cjjBcfM1eaH
	Ro8sflgzRjV9xriqdTzV4buOHyshC7kWoanObrl69AJIn1M4V4u8W/gLHQQCnTjoRA5XH2sLO4q
	Pb0o0=
X-Gm-Gg: AeBDieumxlk3POfebl+1FRrvEZcOycu9zGaa3Faxb1bEcYhKDQNjn9xVmQtxqzq3k63
	IqqWeLbNfSYlujkEA4iGgEXtF2YzO23iPMMto8hg6waY/K5OzrrvYah2DpeXSVds2TMEVKD3bjp
	8beOeqCdMCu4sSxbTUhr+wnXatPK2vwkeh1RXY5ol5bMcA6zAVrs/2VkbcTs0CWpBSzFsQM7e+0
	IhLmrlF3EfZaPs6AnoiEYyRATXj/FPeeBvDAO7COQ1poaWsxsVqsZ4u78FVVfB5Ba/wYCef9rhd
	QUPsEpV3hPBPJgKxiVXv45b3pb0dedmBksQz8gEZGrCb1DJIEYUGle/iKXFIaY5nkubxIAzFgjo
	2KxOlMkcA4mvRfgR3TvMPIuQloZ3w3T2sdee5SIy+PoX8k6NMZ/Y=
X-Received: by 2002:a17:90a:d450:b0:35d:a2d3:5c2e with SMTP id 98e67ed59e1d1-35e42841782mr11587594a91.20.1776067241184;
        Mon, 13 Apr 2026 01:00:41 -0700 (PDT)
X-Received: by 2002:a17:90a:d450:b0:35d:a2d3:5c2e with SMTP id 98e67ed59e1d1-35e42841782mr11587546a91.20.1776067240382;
        Mon, 13 Apr 2026 01:00:40 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f0adbbsm107930475ad.46.2026.04.13.01.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:00:39 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 1/3] shared: rap: Introduce Channel Sounding HCI raw  interface support
Date: Mon, 13 Apr 2026 13:30:21 +0530
Message-Id: <20260413080023.1455582-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413080023.1455582-1-naga.akella@oss.qualcomm.com>
References: <20260413080023.1455582-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA3NyBTYWx0ZWRfX058VxCZGkPI1
 jJ3X5ReMc5msXHaiLwW1pkhsgl2vDe66vUF4Yci6dSNO42fTCK5Bk7A0r4E0IyMZRz84xB9mqke
 1C3cMdyyfmJrAQ3XLqX/9AQm+49URQzy8n58I8+DJ2rvr12LfW5erK9Gel5Ql2ocoVmUe7lLMpi
 ikQMXmMY4CjUqO5oG8O0pK6H416kyNmi8EMUSP7HLEL+JEUmzv6x9vV15pGMtlKJUZ76jn4j4+a
 LnncNAq+FXB5Ne/pzn7gjLqtgFoF47yZfBjLQyl6R/Jow87XzjD+A8bVG4C0nDrxufFcYty5+kS
 Cf08VbmkNgUesmFMAMRrzVbkkYN6o/NKdFXVdyxA+FJADGwwYu6ssmNYMWH3y/eZHPZDQOWlrup
 dUQ51d3+wHl3flzXwhuhNE3yc7aYydKOA388d/7Ls7At83YYxGxyR92xkfB4UeYCTyYvkAM0KDt
 BILL4F1sk9frEf1+kBw==
X-Authority-Analysis: v=2.4 cv=YM2vDxGx c=1 sm=1 tr=0 ts=69dca2aa cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=QxWqq81_DWPgsp5-wqkA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: oroMrR_W19LRw_8PcAMym0vrx3-rsQbu
X-Proofpoint-ORIG-GUID: oroMrR_W19LRw_8PcAMym0vrx3-rsQbu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130077

Implement stub callbacks for Channel Sounding HCI events and add the
required protocol definitions for CS configuration, procedure control,
and subevent result parsing

Add data structures to support Channel Sounding Processing
Add helper function to get hci conn info list and integrate it with RAP
---
 src/shared/hci.c |  67 +++++++++++++-----
 src/shared/hci.h |  12 ++++
 src/shared/rap.c |  50 +++++++++++++-
 src/shared/rap.h | 174 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 285 insertions(+), 18 deletions(-)

diff --git a/src/shared/hci.c b/src/shared/hci.c
index 575254c09..50ba199e3 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -20,9 +20,11 @@
 #include <sys/un.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/ioctl.h>
 #include <fcntl.h>
 #include <errno.h>
 
+#include "lib/bluetooth/hci.h"
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
@@ -673,3 +659,52 @@ bool bt_hci_unregister(struct bt_hci *hci, unsigned int id)
 
 	return true;
 }
+
+bool bt_hci_get_conn_info(struct bt_hci *hci, uint16_t handle,
+				struct bt_hci_conn_info *info)
+{
+	struct hci_conn_list_req *cl;
+	struct hci_conn_info *ci;
+	int fd, i;
+	bool found = false;
+
+	if (!hci || !info)
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
+	/* Search for the connection with matching handle */
+	ci = cl->conn_info;
+	for (i = 0; i < cl->conn_num; i++, ci++) {
+		if (ci->handle == handle) {
+			info->handle = ci->handle;
+			memcpy(info->bdaddr, &ci->bdaddr, 6);
+			info->type = ci->type;
+			info->out = ci->out;
+			info->state = ci->state;
+			info->link_mode = ci->link_mode;
+			found = true;
+			break;
+		}
+	}
+
+	free(cl);
+	return found;
+}
diff --git a/src/shared/hci.h b/src/shared/hci.h
index 76ee72f54..742e24897 100644
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
+bool bt_hci_get_conn_info(struct bt_hci *hci, uint16_t handle,
+				struct bt_hci_conn_info *info);
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
index a1d1ff2ae..21de72af3 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -9,9 +9,154 @@
 #include <inttypes.h>
 
 #include "src/shared/io.h"
+#include "lib/bluetooth/mgmt.h"
+#include "src/shared/hci.h"
 
 struct bt_rap;
 
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
+
 typedef void (*bt_rap_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_rap_ready_func_t)(struct bt_rap *rap, void *user_data);
 typedef void (*bt_rap_destroy_func_t)(void *user_data);
@@ -43,3 +188,32 @@ bool bt_rap_ready_unregister(struct bt_rap *rap, unsigned int id);
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
+void bt_rap_hci_set_le_bcs_options(uint8_t role, uint8_t cs_sync_ant_sel,
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

