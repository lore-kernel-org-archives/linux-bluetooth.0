Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245631A04D
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776271100; cv=none; b=GSPC9LB4KW6Ns6H4JZyM3b8cosmd9tepsfGjl5+zT+tLX1Pxpzw8DnhdUY8JpSD7LQpaWPeykD/i91KdEGoYb6Akeama8G08XQUMog91yz5eJso3bvCHDVUyA3c0CBmutq0asum9YoLImlptlYWFjlEpLiVtoftSDxqGUjo5JwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776271100; c=relaxed/simple;
	bh=Aiffb4WyiIyZA3Hz+6psY3j8nwDhJT39ukzJFXEwRZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yo72ty9sBURiQy9+NIrEn7A0TXuM6S5n19NHYlBBL1d4yC2IxPX9TOYPXVV2sUVtQ+ESa0CfUWyD4kcIB7R0frvdkp/2WYhluREKpOdM6JGLtLnu2ptG1gZoBmaahpxLVkV+9+UbQFXko58PGFZ2yYS5rG6of+9aShDNb5oRhUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JjnFNegu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Exf8sVaq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JjnFNegu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Exf8sVaq"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FFQEFO1702416
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 16:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CWBhPzqYrVd
	/dZ55TyvxueOoRV86jf978axlVRRBJnA=; b=JjnFNeguGn8/SIGbLM7VRptBRL7
	jr5yjxUQDi8NirgSlHveMsxgzR+UXTKJuB508eXcxHQjz757RuIk/6+1ReUr/9aE
	jqXNtIkViip+IvHl7dJ8Zge7KWrWdvLerzXxYhTrB4KBrJn22/hOTObdBOPajHrF
	kImG8bTHLT3odIkJ/0prJYyJJTI/S18ubDgnK2xTbkhT/VrZ9Zvl1ac+xTZdKn+S
	rEf0D7upAdLiQx0qB5xFc2r2nniZLP5URQyeNWT6tzQd5b/LtpoNzdptpSyCu/yo
	37tU9RfVGVZk4KajrRO57qWq2pO5hAdyrmqU3SbeHemTnpJkLJuMTjfQhUg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djdamg8g5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 16:38:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b241be0126so137974605ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776271096; x=1776875896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWBhPzqYrVd/dZ55TyvxueOoRV86jf978axlVRRBJnA=;
        b=Exf8sVaqnArQHqNELjI0v5vBtNrXumJiGx4JvQlViINeSerIsiaHgo1ItBpn15GFtX
         olryppn+IJJr0A5hb6bO1leOJl6O3ReufmzOaqT8DkjLyM+qUdRemikJDnkqoTp6KII8
         g+QNDsi6m68N/SaiP/0kcFWBYgactkTJEBP/CcGaB3x6eX3lA6o8DAG+WsOWYMf3axtO
         PxDPJW2kgjGcqjAIFVRDRRWWCPxX/IiYupSu092Xqbs2xlLPI8glE8WF79UzFKYq4xqy
         uZPcWKk8498ONENdHmhFmcIfifSZEEHPm7fkwDq+Uo+QE7hFNrNWZ1p1yI62IVFC30M4
         1UBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776271096; x=1776875896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CWBhPzqYrVd/dZ55TyvxueOoRV86jf978axlVRRBJnA=;
        b=q3SgLxMS3q3r0kqwwIauXFWBLoDpBJ/a5KHRW4YDzyTOsKH1rr+t81fiy5uW+N363v
         U3TT1dNLkkAXR8Do/EJQ84LJ1NWo4xEjHiZfAsAPo1jFXaC8tgoKb19gPWFvmf3M3j/m
         g0H5O4G4ORf3WuZYppZRQzH00OUiUASgzQrbVj2EAbIsO9BmCck9ihOuo/kFrltIuEmo
         uygjh6FMbW1aKIL1voqkWp+6Hx1BBjU58LMFnaqYxAUggDwZo65OyNAEHxSFzsSsk65m
         SFefpNoR3JsWUAzgY3rJW6V3mzRNujTiqf8U93vUOFuplG83/J5Ad+CJ5dGzThbVZYeq
         U0sA==
X-Gm-Message-State: AOJu0Yx3Eh8O0L5Qdoso9eEEuHjXKsHpT3Fb8tnQNtiHh1KPIsXM6Qyq
	U94oTL2YhSHvRL/vntGF241BPBaKSTgdiLRfsR+nqPx8Ec0J3eLB/kQOYYqA3ViJA2DSm5PDOtk
	P0CtmaAvtZ7nf1lt70TmVuEDTckU4rHW/L7NQ0Z1B2qxbVhdrFwl5y142PkoA39E4g/tJX9o3jS
	bSR8s=
X-Gm-Gg: AeBDiespgpMASqlW6LExBHxO9Fy1TbKddx+KZG6U48gFTuUQO/LBNweJmkiqiffcG7l
	DkWtiDTE9cIhbPlgyhkmOurzqLWch3Xabetf7Ch0JvMvf9562I19cPEyBmzEl1C+RhXr0U0t15I
	LB1G6tHLcy+TfVvcwu1HVq15LipdSBV6Q93YvktguKp7+nfjLYHfaGXmdwyQM3k/Nt3kia8UE0W
	pLoZ5UCPw0KE41xoBiuku5gvk+pdyEJOpMHvvdZh9NsPHn5TaPj7FE+BaeeD/fXrm25HtUfJ8hg
	yjTb8M3ZUrVybiTEC8kXhLGj36Joi/v4ffYWxMdjOu09gUgT9g/7lFgzgopA2nZR3uqLyz8Xw+A
	fs0vLOT98jtqT9OcrGqmx6Wgd6A44EWsIUYDZQQicTgW3nCJbgIk=
X-Received: by 2002:a17:903:2283:b0:2b4:5ed3:415f with SMTP id d9443c01a7336-2b45ed3464emr141851015ad.18.1776271096334;
        Wed, 15 Apr 2026 09:38:16 -0700 (PDT)
X-Received: by 2002:a17:903:2283:b0:2b4:5ed3:415f with SMTP id d9443c01a7336-2b45ed3464emr141850725ad.18.1776271095840;
        Wed, 15 Apr 2026 09:38:15 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47826e110sm34941035ad.43.2026.04.15.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 09:38:15 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v8 1/3] shared: rap: Introduce Channel Sounding HCI raw  interface support
Date: Wed, 15 Apr 2026 22:08:03 +0530
Message-Id: <20260415163805.564395-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415163805.564395-1-naga.akella@oss.qualcomm.com>
References: <20260415163805.564395-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -SXxqMtp9T_90k0Veko0AU7IRE6XGok7
X-Authority-Analysis: v=2.4 cv=HMjz0Itv c=1 sm=1 tr=0 ts=69dfbef9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=iQ1p-M_iqrsMsUXJ19YA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: -SXxqMtp9T_90k0Veko0AU7IRE6XGok7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE1NCBTYWx0ZWRfXxDIjJz6atuU8
 drL91DbflTh4B6l7F6bj4xFjKenbaFrLhJiFlirDFt9n63Z67KiNwir7Ei1lSe0ypbpZ9++F5HF
 SfIwb9Pt+FNQI7m4bc0jc6QJXwk/fsruMgXvrpmbMmmalvuf+OQTleALKfVkfcDQtkK9sfj2+LJ
 rK0bBLh+xNMxPmYEIN6ddWhlFa9z4XvxVgM5E/OhXDoDAASluV0pR3PhYPmJm+DrTn4tYkcukl3
 +kjO8GoeMi1PSWW4KYXghNy5lwSA5RSIuvnVfUX2d/5w1h4v6z+JL69t6k+e7YxrE+4eyG2Il4l
 /7lfcQJpauuPpT6oyfSfIHLc7WwFH5BOLLfKJPpZrqKNCUzzeUMpUB7roH7dkEiFXj/cphNjcAI
 ipTc1PWCyjKqRiCMw8rCnWU8hJdUDbd367fT0uiLMTYc2Vf9Ep1rXhacWP1cM1Cx42+O9o7xCst
 y/Dx1O1+kzleiJtkP9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150154

Implement stub callbacks for Channel Sounding HCI events and add the
required protocol definitions for CS configuration, procedure control,
and subevent result parsing

Add data structures to support Channel Sounding Processing
Add helper function to get hci conn info list and integrate it with RAP
---
 src/shared/hci.c |  89 +++++++++++++++++++-----
 src/shared/hci.h |  15 ++++
 src/shared/rap.c |  50 +++++++++++++-
 src/shared/rap.h | 176 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 312 insertions(+), 18 deletions(-)

diff --git a/src/shared/hci.c b/src/shared/hci.c
index 575254c09..46377fa30 100644
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
@@ -673,3 +659,74 @@ bool bt_hci_unregister(struct bt_hci *hci, unsigned int id)
 
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
+
+int bt_hci_get_fd(struct bt_hci *hci)
+{
+	if (!hci || !hci->io)
+		return -1;
+
+	return io_get_fd(hci->io);
+}
+
+int bt_hci_get_index(struct bt_hci *hci)
+{
+	struct sockaddr_hci addr;
+	socklen_t addr_len = sizeof(addr);
+	int fd;
+
+	if (!hci)
+		return -1;
+
+	fd = bt_hci_get_fd(hci);
+	if (fd < 0)
+		return -1;
+
+	if (getsockname(fd, (struct sockaddr *)&addr, &addr_len) < 0)
+		return -1;
+
+	return addr.hci_dev;
+}
diff --git a/src/shared/hci.h b/src/shared/hci.h
index 76ee72f54..20a12d4ae 100644
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
@@ -41,3 +50,9 @@ unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
 				bt_hci_callback_func_t callback,
 				void *user_data, bt_hci_destroy_func_t destroy);
 bool bt_hci_unregister(struct bt_hci *hci, unsigned int id);
+
+bool bt_hci_get_conn_handle(struct bt_hci *hci, const uint8_t *bdaddr,
+				uint16_t *handle);
+
+int bt_hci_get_fd(struct bt_hci *hci);
+int bt_hci_get_index(struct bt_hci *hci);
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

