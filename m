Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7373264E2
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252335; cv=none; b=L4bP+wn9GciNcIAJoImP/yeILrYaDwNWp3m5U0gd5FQ2/8QXfejbF3PsQkLe+gGMXtb9VV5uCdf/7MDm+EpWE/TzujEt+f3CpTaitxeJE0cWT2ZlANuOdfTYV8dp409UdYnNU7GzCzB2YxifFD8ElUWpYA0eBk3fcDEXDjfBIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252335; c=relaxed/simple;
	bh=6hHy3CoNDKDdzqGQ/quXsRqSSb/1epmQuuwOg66yqJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LA+C7P/BTjhndPBldoIRt4ZkCOvJKY1Up0R6OQ/UY0ZpX8nTMuxKofkld8voxlOD0diI857ewcG7nQPSA94pV+N+2QbJxb41ftiynxFC+OA7Xfie7qq9FSgRidGVi7G+oyIlURC3qOVTIwTNBkFiBELfGIZJFuic+eOtx92rBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o6pZCKlf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ai9k3QC5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o6pZCKlf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ai9k3QC5"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F9s0fl1701733
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 11:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WBxNQnLa655
	yUJfvpdEoHnwvvLOJQ2wDFivXkHZxJRI=; b=o6pZCKlf0SbAeMLlB/isJZAewGt
	JpcX5P8AY7Eb/NgeCf4CZJovGUTNlKcH2oN1AZiYbLoiPeWyYDuxVVyx3A/DYhvR
	pJ70MEyMiVUFKZmeOR+jY0wkjwVjWXucOgbXd26TpvaOTgwuGon/LaTO3QGRkSzt
	LnlDxfc+1H7epGGCPULtCdQZGy+qznPzj893Yg1R+HieBGg5+Ck5n5GM6Dn/+TYv
	9b0TMUKbHGn1XJNXbj736Xdf+xz5u2MPGX89djKmVqIfJwJBpHzjkaZc9pTzxnPN
	TLCH+iLIJRLBzhUpw1Tw46oSb0ZkVD+SHubl5wOAg8uGY/RMfufBwjtbzpA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dht56u0pd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 11:25:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c76bfd7b9cdso2756031a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 04:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776252332; x=1776857132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBxNQnLa655yUJfvpdEoHnwvvLOJQ2wDFivXkHZxJRI=;
        b=Ai9k3QC5KO2AecpRbyeTi+2HIx/JEvgewhFvRgh1HuyqVaLGj7CXp2de+AZX6/vRQ+
         6dZUSOWs9rYTp5+szuM1DbZUdIi1GpjZH/zH9aOkHoLXHaJaso6zB1gggMCz+XBoPljl
         DYVvOTT72GN0lJZJflDJ5Se+/OvKVS9b8XjivHXQZdD7d/RYwr3kfCBkMtBiYKz/XRsy
         Sw5fFMPQMa7DO5u3j+ir9GFXvr6XcUxlsD3u156GQSmenWF97eLGstWPVyIy2VzOINXH
         QqifbkTuYIfnUdw1H2tUq8gBdJurCPTJOrJTr+02l0vL/IQD+HT9dGORICFbB3lxEO4P
         /hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252332; x=1776857132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WBxNQnLa655yUJfvpdEoHnwvvLOJQ2wDFivXkHZxJRI=;
        b=kBvSKcwUQrH2oC0byrxloIrcC7HjdxXzpi9Ea9sDw9ewKJXKjlvo/t6aS+kOeV/a9m
         bH+uoRp63Dg8tGsY/gN0SawHBl3jHQKtwMmPsDfsg8R+1rI5CPPldHFSsXFaolfeh0w0
         nuz0zsH/WSXLELS846o2PX8IhHJs8hPnx3hmATNDXbm1Vy73zOBOJx0vS+v/qmagLR0s
         p/7puzrdL0TwvdrBGGU9H65ehb+1ucNlpHporpU4tmyYTu0u+stKgOveAwQvwzm+A6Ld
         +zTLgyRx7PTedbNHIA+7V9Lh0b0Rz+Y8sczGb1znbmG/7RGIowaAxegatW54mhxxn6Nr
         91NA==
X-Gm-Message-State: AOJu0YwOCLb7bynTMYIXNJDQfOrsk9qqlqodxf0BXXu4WIG2aUI4K8k1
	aXEhnew0zQb0f8UnXEbW0YM5NI75YUWg3QtgFTrWckpSXuMC/lar9Asa3Kqa332h1TjQAvD/fb4
	nb2TOIkpqOwEi7k4fwAIXwHMJdZ8xTk6MIcetcUu4qILbtj2NjPqH7YqN5BFYUg6GkEK14i+265
	TOpjI=
X-Gm-Gg: AeBDievQNeD6kWISGvsiMLS0RSoEg93WRF44JFjs+6upvMDdEorRqoWa6TZgbVkyVs4
	Ep/ZonN2QKHg8Hxsn0T57diQpP2n68VZHy0WGAPgQho3L9yb7N/Ju9cGwgNzpEo/Nh4Ro+/kl7P
	IPC1j7ISFuhYnnx86e/9Nu+ZQX20OB3EpZ1r6Jf9PF+WcgV/H6DVRpJJ2E/C8YG5OX281EKf3c8
	wwY3gham32e2tTvOWup0FvY0IWfKj0YfiYP4058jXq+Wj9D8hXbvzSUWvVnB7S3JfVVuX9KhD9f
	e2KvOKr7SvGKEUINpLx8TaccvRiTuBIaY+aO/wmC+25U2vWM4/ja73yWtQnnZatMAyhz9n/mxVd
	hSj2D+vdSiHcodqp2dcFsLz0YzJv47/V6+amR/HlLdPLYOOJ3rco=
X-Received: by 2002:a05:6a00:1c97:b0:82f:761:2b44 with SMTP id d2e1a72fcca58-82f0c2de00fmr19665514b3a.50.1776252332109;
        Wed, 15 Apr 2026 04:25:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c97:b0:82f:761:2b44 with SMTP id d2e1a72fcca58-82f0c2de00fmr19665481b3a.50.1776252331467;
        Wed, 15 Apr 2026 04:25:31 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f69ef0b79sm1492172b3a.36.2026.04.15.04.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:25:31 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v7 1/3] shared: rap: Introduce Channel Sounding HCI raw  interface support
Date: Wed, 15 Apr 2026 16:55:08 +0530
Message-Id: <20260415112510.195491-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415112510.195491-1-naga.akella@oss.qualcomm.com>
References: <20260415112510.195491-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oyRvOJbT5ZVWVqQZd_w3qg6m7JIijmJ1
X-Proofpoint-GUID: oyRvOJbT5ZVWVqQZd_w3qg6m7JIijmJ1
X-Authority-Analysis: v=2.4 cv=K9gS2SWI c=1 sm=1 tr=0 ts=69df75ad cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=iQ1p-M_iqrsMsUXJ19YA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEwNSBTYWx0ZWRfX+uOqxbYehsCu
 4AYqigIHXUiLyab73O5F09pHKCzwMjUCjKIr+HTAjeyU9+lahnViLaY+ks5F9YYDOIE16FUUXK9
 aDd67PtIPPD3bQ11P7x0zCdTgpPBlLjNZ6VFdruPiedlnU2XHLIt/iA6JE1e+6BNQ+elT4s43+w
 XUN4subx2X1KkLkyfk/mxNKzJ59uU0acLNkh6AEttTmxq8m1o6Fszyjl9oa9Y7rKlUI6qWwZtgz
 ntM17HCDNHbpc6oReVwMETk7+VUU5zqB/DystDsn/ykgHSgIl6wnT7wOiXkne+P+kekm3YLGn/p
 wVtvx4wtTNA+ylxL1pmOoYKDxuf9eEdTEbgx5HRuQ6zaFoLOj2UQfmJ41M0mxWm8iFePDWEqPbk
 ha73+VtuJoZB52zh6R7SXLRGc0o9Nnf6qe8OrsWv0QyMo3BU9aehS53VD+KvJI3r3B3jvuPZBen
 JicoLYVmD1end7NI8qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150105

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

