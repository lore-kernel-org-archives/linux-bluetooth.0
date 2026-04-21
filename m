Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C713790B
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771122; cv=none; b=iRN+z1uP3n6FhiZPux4Oc7N++Z0SoPGARzlmw5Gs5Jvms0i1C8uoONdGHbd2CKGXthg6PDbUsue1YPouTcAEaxMtAz1pGOOAJSdRmgr6dZIE3l7CjM4q9sJX6e6giEWkK91rgi3taDgg/F+/I4HnhWp7WdNEgstgX0rkYI8Qn28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771122; c=relaxed/simple;
	bh=BSqe/AUH2Kmw3H91HQEUbYuwu0djfuZqc3MODiwIwy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hlnKfsxyGljzJE0UJ5WxiaFKCZVfqyGswbMr6LlSso4ypjUdlimk1ubofOqxM/BfqgYp+PiMIBqQIJRwrbvR7qluOr04sfVHxv656I67P+JsZ5My+XkvOALC9FLakmZxHVZJztzZP3onHQEo5xi15HrgS2CtsmzqpqSeYIicACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g+lZA0Rv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YHpRuFIk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+lZA0Rv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YHpRuFIk"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LBNjfF1015347
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zhTZu36PWSr
	2P/X2qv3Vh/bnyE9e2QxC937Did8Gv28=; b=g+lZA0Rvx/ND42R1c2K+DWa7Yyv
	M3FaNRKPvmfMVB2m/EQd3qmNTVoHZcU7NJiUAA8tVV5BPawaR2FEI8TvPox7dRVA
	RJ/MDe2W3rK3OEBzV3dFlcEZfQ9+G5w8+cUATzGqg/Nln6unJVO7T6Q6th68oupD
	h4bl8ZIB93+qv6QF5rSFb6FrKFw9kO3qBJgG9Ppy+zjrGtM46QZbGIW5ZNwEZqT1
	Od6G/6BI21IEgUYEDcwNJsqGxTjRnYdzPrcgDPiV4+N2M2Twpemm+trStNtG3XxU
	MIPF+UWnByJ1/H/MJOcWfeACmCphJ98rvzEntMA4AzgJ8zxAMuDnflRYUPQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnt902xak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:32:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c76b69fb9d6so2833010a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 04:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776771120; x=1777375920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhTZu36PWSr2P/X2qv3Vh/bnyE9e2QxC937Did8Gv28=;
        b=YHpRuFIkHTX0MBIshg7bl+NCkFBLNhZ24mSeDtBu1CRK+O4lPKei4priGA3JQSemx9
         SxtcJ+93Q99yo23sVhlTXyK8yB7nWYwwZGVe5DPXjyf0aCERS/9Foei6nJ18sYNT64Pg
         PzGVwawDFMOU/gdxXOq+ny50ENO1xTZxYZqWnv1EzHkZwKRvelRfASb+oxHaicMk0rVI
         3BdfTngZnACA8cKVapsjunEqgNTMv6Rb9WEmB7GsqL1akSvmcI0EUgC8hH0ULr4//vfx
         Bkshpc72fbFazj1akA/QdEP2HSUVYyA7yWgXLGVUrpaq9mxQStVxX6frb6rBGcGX7YN3
         rBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776771120; x=1777375920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zhTZu36PWSr2P/X2qv3Vh/bnyE9e2QxC937Did8Gv28=;
        b=WF3jRD05P17xVBu9bXGNndksfqyhScppWAIQhTe/KEjHPlk6HGAVTPuLfSgZxcUpBf
         6Uh566TqEKX7lKulzSBPwAu0ugzVGkkSdDQnE59qGgSTHwYvYIy2LKSuPexKbD3ebCUJ
         1MJ8VO8EzHgTsyHYPg7B3aj9cCqYn4yM7CN8E/rWYtqTZaCuwSNWmG1Vg2TQOW1VO9cr
         +vDLtqlg1UoWyOgVyA6oWl1/NvZzRsZN/dvoAw+38LtSx5OJ7Fl0oNA+2mCF3AM3vx7U
         zjw29hu/vVwFlTPMHeG5zxCDMBhraZQjPubbwzKCFWeDIOM8fnDKLE+idEpEblYaMjQp
         nmug==
X-Gm-Message-State: AOJu0YzUcZn+ZscS21+vbvX+uCdaUpsWiyklvyNLeua82ILb8koK+h4+
	FYtGzjlvGuLUdF+JuYo5sH2wPHr6ES3FHYQhl/XjfuIvn7ZQYUTsSZQNneeIarXt2DZUF9orgJq
	ZhzznsKr9WYZKUoA2pissFPd+jPEUuwhokzhS0V59dyMF5vkb9nFNu8gF/3OnbbLsVF1abv6J35
	UdTpw=
X-Gm-Gg: AeBDietGS4ApjppIB5ybr3mujXSH7Q8SY0WC5CBDVh61CldmqaETBY+r6LoxDpJ4N23
	NY5UReFeA+yLsMUbtPETUZZKOThEj64sjN0w3AzoxtMycW6VGUnk2UHjR2gogRQOiioUbt8lxgc
	OGAt2Rl49KD5gcC7fhESWZRhputUAOH+tcONeVJq6Cal/E71lFbj6tCbsxFvTCIc0Kzhf1ElqMj
	I6NrItxz4wu3RjFQMU3AotT+AldQCTR/reAzAVoAFg8g44RvWBRopFs0y/j6aaN006tXSFRtt+8
	6c9EODgepTw+CVVdxRI+XiCZpPlXVvtpsfFwNCYOLyB6UK+Ss3HnpIrkXFiZHu/pl7uS1LpgELz
	j3K2nb5DVUh0fBkcpvQu5xmz+NbjoADxe59e3ajGyeki52IjujR1aOAtgdbcL9g==
X-Received: by 2002:a05:6a20:3ca2:b0:398:6fff:3dc0 with SMTP id adf61e73a8af0-3a08ca73cbamr16918054637.24.1776771119416;
        Tue, 21 Apr 2026 04:31:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:3ca2:b0:398:6fff:3dc0 with SMTP id adf61e73a8af0-3a08ca73cbamr16918016637.24.1776771118842;
        Tue, 21 Apr 2026 04:31:58 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797703059fsm10334903a12.24.2026.04.21.04.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:31:58 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v11 1/3] shared: rap: Introduce Channel Sounding HCI raw interface support
Date: Tue, 21 Apr 2026 17:01:46 +0530
Message-Id: <20260421113148.3809176-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421113148.3809176-1-naga.akella@oss.qualcomm.com>
References: <20260421113148.3809176-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KfbidwYD c=1 sm=1 tr=0 ts=69e76030 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=sRifeLEwFzd54yERP08A:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: jNrGJ6sNJ7vl742ncsslfwOPQF7DNZql
X-Proofpoint-GUID: jNrGJ6sNJ7vl742ncsslfwOPQF7DNZql
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMyBTYWx0ZWRfXxhQ5Rjk2qOYe
 +IRzhgQMoaszvMukTByWXnCvfSYv3i5h05RUBGBtc6is/hwPc/LWcp8LvCCSq5rgvSA81TS/x3K
 5tW7kuVCA4ujtNiBD/FYVTGngfDUhIUWzOFQE/i8bp7m6wtBEUdMCsgHuKbyFtsUAQjJz5AMial
 RISsxZ9WNlYqVDn4I9NgYwbbdsmhbBwUN+spmpqzypLrB0YXtd05b0r+dLiVKUVpA9QdfqE2l6/
 /I1FmbRW6YXutFxIC5EyRAVhJ4XOzhbGAG79AqlyD4i1hO12xMhAeiH6v9BLZEkMNSP1kq7A2i8
 42JDAs1Yl9b/K4IceG6OUUNihcsDthAOsVjobFqS1Xv1HG+3gxYq79VkhSwiGwBY4Qm0peDPEbe
 WIRC93o4iBe3KMtJqwPTdPZNt9mCz385+Nl3HBSziffB4vlMXFRUUGn7BZHJ6uFH2A5Wg2e2fuS
 +e7WMvNKt8a31x2yDtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210113

Implement stub callbacks for Channel Sounding HCI events and add the
required protocol definitions for CS configuration, procedure control,
and subevent result parsing

Add data structures to support Channel Sounding Processing
Add helper function to get hci conn info list and integrate it with RAP
---
 src/shared/hci.c |  62 ++++++++++++-----
 src/shared/hci.h |   3 +
 src/shared/rap.c |  50 +++++++++++++-
 src/shared/rap.h | 172 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 269 insertions(+), 18 deletions(-)

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
index 76ee72f54..800dc4946 100644
--- a/src/shared/hci.h
+++ b/src/shared/hci.h
@@ -41,3 +41,6 @@ unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
 				bt_hci_callback_func_t callback,
 				void *user_data, bt_hci_destroy_func_t destroy);
 bool bt_hci_unregister(struct bt_hci *hci, unsigned int id);
+
+bool bt_hci_get_conn_handle(struct bt_hci *hci, const uint8_t *bdaddr,
+				uint16_t *handle);
diff --git a/src/shared/rap.c b/src/shared/rap.c
index ccf3e6f33..ac6de04e0 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -25,8 +25,8 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/rap.h"
 
-#define DBG(_rap, fmt, arg...) \
-	rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
+#define DBG(_rap, fmt, ...) \
+	rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ##__VA_ARGS__)
 
 #define RAS_UUID16			0x185B
 
@@ -503,6 +503,52 @@ bool bt_rap_unregister(unsigned int id)
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
index a1d1ff2ae..15ddea295 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -9,8 +9,153 @@
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
+};
+
+struct rap_ev_cs_sec_enable_cmplt {
+	uint8_t status;
+	uint16_t conn_hdl;
+};
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
+};
+
+struct pct_iq_sample {
+	int16_t i_sample;
+	int16_t q_sample;
+};
+
+struct cs_mode_zero_data {
+	uint8_t packet_quality;
+	uint8_t packet_rssi_dbm;
+	uint8_t packet_ant;
+	uint32_t init_measured_freq_offset;
+};
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
+};
+
+struct cs_mode_two_data {
+	uint8_t ant_perm_index;
+	struct pct_iq_sample tone_pct[5];
+	uint8_t tone_quality_indicator[5];
+};
+
+struct cs_mode_three_data {
+	struct cs_mode_one_data mode_one_data;
+	struct cs_mode_two_data mode_two_data;
+};
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
+};
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
+};
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
+};
 
 typedef void (*bt_rap_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_rap_ready_func_t)(struct bt_rap *rap, void *user_data);
@@ -43,3 +188,30 @@ bool bt_rap_ready_unregister(struct bt_rap *rap, unsigned int id);
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
+void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
+			uint8_t role, uint8_t cs_sync_ant_sel,
+			int8_t max_tx_power);
+void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm);
+
+/* Connection handle mapping functions */
+bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t handle,
+				const uint8_t *bdaddr, uint8_t bdaddr_type);
+void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle);
-- 

