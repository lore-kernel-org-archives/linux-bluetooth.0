Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BDA3264D0
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434183; cv=none; b=JM8IiR4qVKEPY3v9bYDkldOHGJvKGaxbdX3PLT5o810Vvj1imkin7NE6+yqyqdmDjv9j2Em9zS7b6F1SYs69yePmU6ZjFZkc1qZXbZ7E4qygQdhs9N3DsMTQyzlNiEjsdsZOh5+9GbXeJpY8LoY6B+qELoWAFUzD7rT7FvFxvNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434183; c=relaxed/simple;
	bh=nh6ZKeOAAnZhJFoYA1WIL3XEBiNnI3d0l0kSqB6lqjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kwo16ueSLrqDL2l5VLUE3EAnAhf1vZvFamFb4aQ0dfafOn8+2zBrVq6foZxARAb8Q6Zd2cEtlzjqCXOluAkMVMNgpiFuY5LeKi9Sp1o4Hyu9c9vilrJ9VmKyfzTvACtVD5F5YyTEdKKb1nedOBGEqKfKTusHTI6emMRtE04cZqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IW6EDj5c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ndaaxyyq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IW6EDj5c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ndaaxyyq"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HCBxML3942153
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 13:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HChXHelXdfT
	d8nxO7oxHqQFMRmZcKOAApWjAFEfvan4=; b=IW6EDj5cdGYXeLYEasOb+tZvmO2
	JjzcSZikoKMGDgQ/mlYaAzpsq4pG0JSGitokZvS9+SVFMSOTXkoemRRd013Z574c
	hmv36q7fqKSiSAgpSLvJzfq7GobKXBWpTmcsM/90IwpiPvWtZrlQ4cKzbkCU5GvB
	9oF0IxLu5lxPAM4HCRBTC49I0BXeesCLiNM/7XMjILbX+Xpd2e4B6jKvbjMKwdHH
	eQGr9VpgB7bpbGZ4MIVFsIzQgOzUetnRPitsTxrTupFC3y+LLNIfvX9JiN7IiTJL
	qDNAooJsPvaXwBHlwnul2p3PrypUNZR2so8D0sa8aX4Pta7/ecpeAPdoOVg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkg7rsj09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 13:56:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f780a13c9so604818b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776434181; x=1777038981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HChXHelXdfTd8nxO7oxHqQFMRmZcKOAApWjAFEfvan4=;
        b=NdaaxyyqkPGgCP551PwpNJd0+BGNJalPC9k+lnjQ09x8sVCW4WZs9cJ+h+63P++aRO
         OsDG8SHzwKr2Eb+DM05Y8tdx9ode09hZuLebwdvvtdy3S5ra6t0cuLDI/VtiW+rhRd4X
         tmD9loMfT35NcMUsOAQhTxWm9SwILsMWAGEVcVnMHBOx2gBdWVUwuIw3to5Kuz7vdTAg
         rAPwfOxjde66l0RxlnKxJ+m5s3v26WCGXUd/zAMKCWLiTOe9rznaNexvYkio1epwqnOq
         9Eu0xdcJfR53lD1/J0Hf02racbCmjsopIsU1XNq5PrjAy45AcRmsqUJzsHeArdFM7QXS
         sOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776434181; x=1777038981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HChXHelXdfTd8nxO7oxHqQFMRmZcKOAApWjAFEfvan4=;
        b=U1JxfIPTnXYVda9NkmpPcTlQs6DrvvFK61xm40c9nGEHTJ4qq1U/4k8MZdxMYqrCcC
         Hi27DVdKRtiAfoUvfdJ1SDGHT6hiK9BY9o57LfXLkt0va607+0c3kGwL4BXmXeY4fF3P
         n1Zp6VV0rafIRsGiFIXvB0HndrDb4f1zl62BkyWbcpRIRBtDV1HeMycpO9xmksq8i53K
         1lMAIYX4RbJ+5MJgVy45RigqB2E0Ar5ZuHRKoLSvO0nwq3FIB21a39rRxvzUjbfuiIN4
         Svf9B4QWDcsuIja2rpIN20CaHNgmyT27WmJjGn+0mBZGb7Ngq+9lbAgiIsQOxpqYQJlx
         8UkQ==
X-Gm-Message-State: AOJu0YzmWa4dPRRN4s6LhcwgIb5SvA8WFnJOsuyoU0jgkEy/TUD9fJK0
	mb32MA5zn9exCqBkAbgZ2QhFMPfNkyXxfLtPUgnm+YW1gfQN5rUuaM1Sa+0gGhWarZYBErHsmv6
	PuMdTilG92Jy9vGp8AZZUTg+k1OA/4OpoLfbR4kuWAw/M+oB/KkyXEIjm1UxTtTwINPLobCLdPP
	OppnM=
X-Gm-Gg: AeBDieuveWulAqUIzJAGQvreUVJpkM19lZ+AfBLVbyRSz8aZ0miTkf+WEUwH8LQSXQ1
	kwy/ZfngBqdZDVQkIhKGeMCTiVMNerUZLGo/w9JIGqfDL0L3fDLVnY0WUgDyZvBN83Vo5KR5agl
	fOuSzfYmky6m+ZSxyUfxfTOQs7eXTpk7wYmZnpvmgu+s2Dc4ViQ5yqbg4gN++jMvqWQsBSDVbJ2
	YzCZ4fGSh/1+KjSYOup83XNZRo1sT4CN2hPvyrzRXj52w2EyS1VF/qVjhxng4pLI8kSx6ix52Zx
	q1LCoSOdbN0InyV6xD9CccV6bKhFcYm9s1pVckn6OIJkctM3OOKY6SmCT7+ltEAPI96xJUg0Gjq
	q++Ri31eX8JB7ToCRu/HaZmGM5jrUAVmAweS7gMIYUn5efpAIAoR9n4Iv40j9RA==
X-Received: by 2002:a05:6a00:94e2:b0:7e8:3fcb:9b03 with SMTP id d2e1a72fcca58-82f8b531fe8mr2585479b3a.25.1776434180417;
        Fri, 17 Apr 2026 06:56:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:94e2:b0:7e8:3fcb:9b03 with SMTP id d2e1a72fcca58-82f8b531fe8mr2585448b3a.25.1776434179894;
        Fri, 17 Apr 2026 06:56:19 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c12sm2652375b3a.6.2026.04.17.06.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:56:19 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v10 1/3] shared: rap: Introduce Channel Sounding HCI raw interface support
Date: Fri, 17 Apr 2026 19:26:02 +0530
Message-Id: <20260417135604.3044630-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417135604.3044630-1-naga.akella@oss.qualcomm.com>
References: <20260417135604.3044630-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1raTkZIU_O_IN_hee_-6Y2Uh83Y8HTFu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0MCBTYWx0ZWRfXzQ0DG0IoDaRk
 ussV496rwVd+FxfCk4m6iRkYl1WOpJxWtjt3lmSN9YxUyea26nDkr3RZjfKU+WW4807lXHz0hBe
 ZPzCbv9R14fwsts2GSERvnGt0I6yJEnt3zw7J/B3cgXM2SnXI0tdcRyDbnLOhhkk4jqeBKRw5hQ
 BjCe6X96FKES/fENE6mh+n1Y9+F2EfuyzpoPwpMVSYJwMESro8PtmzlmncrRf5OMGdBcwd0tuwP
 P/bTZjP8sla2cpJ47CX9FIX03lc6V7xTeHgmBSly7m+kIqU+VSGW6N3aOy916dtTwRbbJE4ze1P
 C/zlYvo12qucneK++k/XPXfoSYVq1nJNfPeJ+H0jmzszhc84RX9M0YfJ3Y85/cV3KClWLx5EfgC
 wWP34iQskUGGu3ZJ7JB/muUkWC+VjEtfbq3gJEwBEfZbi3SE7/RXlfdxJI/0e12K0lAbusvwV7Q
 hugWNMJEQ/1PTJomOtg==
X-Authority-Analysis: v=2.4 cv=b4mCJNGx c=1 sm=1 tr=0 ts=69e23c05 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=iQ1p-M_iqrsMsUXJ19YA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 1raTkZIU_O_IN_hee_-6Y2Uh83Y8HTFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170140

Implement stub callbacks for Channel Sounding HCI events and add the
required protocol definitions for CS configuration, procedure control,
and subevent result parsing

Add data structures to support Channel Sounding Processing
Add helper function to get hci conn info list and integrate it with RAP
---
 src/shared/hci.c |  62 ++++++++++++-----
 src/shared/hci.h |   3 +
 src/shared/rap.c |  68 +++++++++++++++++-
 src/shared/rap.h | 176 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 291 insertions(+), 18 deletions(-)

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
index ccf3e6f33..cfffd983d 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -12,6 +12,7 @@
 #include <stdbool.h>
 #include <unistd.h>
 #include <errno.h>
+#include <glib.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/uuid.h"
@@ -25,8 +26,8 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/rap.h"
 
-#define DBG(_rap, fmt, arg...) \
-	rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
+#define DBG(_rap, fmt, ...) \
+	rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ##__VA_ARGS__)
 
 #define RAS_UUID16			0x185B
 
@@ -70,6 +71,7 @@ struct bt_rap {
 	bt_rap_destroy_func_t debug_destroy;
 	void *debug_data;
 	void *user_data;
+	void *hci_sm;
 };
 
 static struct queue *rap_db;
@@ -503,6 +505,52 @@ bool bt_rap_unregister(unsigned int id)
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
@@ -745,3 +793,19 @@ bool bt_rap_attach(struct bt_rap *rap, struct bt_gatt_client *client)
 
 	return true;
 }
+
+void *bt_rap_get_hci_sm(struct bt_rap *rap)
+{
+	if (!rap)
+		return NULL;
+
+	return rap->hci_sm;
+}
+
+void bt_rap_set_hci_sm(struct bt_rap *rap, void *hci_sm)
+{
+	if (!rap)
+		return;
+
+	rap->hci_sm = hci_sm;
+}
diff --git a/src/shared/rap.h b/src/shared/rap.h
index a1d1ff2ae..71a33fb05 100644
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
@@ -43,3 +188,34 @@ bool bt_rap_ready_unregister(struct bt_rap *rap, unsigned int id);
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
+bool bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
+			uint8_t role, uint8_t cs_sync_ant_sel,
+			int8_t max_tx_power);
+void bt_rap_detach_hci(struct bt_rap *rap);
+
+/* Connection handle mapping functions */
+bool bt_rap_set_conn_handle(struct bt_rap *rap, uint16_t handle,
+				const uint8_t *bdaddr, uint8_t bdaddr_type);
+void bt_rap_clear_conn_handle(struct bt_rap *rap, uint16_t handle);
+
+/* HCI state machine getter/setter */
+void *bt_rap_get_hci_sm(struct bt_rap *rap);
+void bt_rap_set_hci_sm(struct bt_rap *rap, void *hci_sm);
-- 

