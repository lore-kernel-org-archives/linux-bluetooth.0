Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72FA35F163
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558152; cv=none; b=R9Tbewsv9pMjaUgQdFK1XUhjzL1pyVZrXF4gugkGSPl/dsdLXjGQdyRVkgcptdZbm2M230DnDZFOQIIrvHzPTJDGz0JUETBMuBLkxxjbiHIKjdrz0iqjNE5MFLtYQRHn8+JKYxDD1UxgMHKeym5PYfoa9Q9H0cT+JWRItuZ83FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558152; c=relaxed/simple;
	bh=o0hP6iSagdVVjWHbI75Zo8hZZeNV6dbH8FDDpOZLnWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A2QT8p7bDPRJtU4e+VyQ4iyC1CGygmRAFCQpUv+w2yfbOn+sF2DHktHfOgECfmEAJNB8db8bwPcRskLg/1mhEBNnDubQji7qp2cNjlOEesJ1hIJq366phqY04e7KF2qq+OA1JondVOvAZNbSdaZuIhz0C6vokunvtnYx4YuJfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DLseNnHG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bukLV/z8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DLseNnHG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bukLV/z8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376RuBL2550324
	for <linux-bluetooth@vger.kernel.org>; Tue, 7 Apr 2026 10:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YpRQKCFvWsW
	L1+enbc+U4LrFHUHkv76LqYi8zeJXvLM=; b=DLseNnHGnA1HLoaW94uENcSfsXI
	+sU4hmN68wSLW+LTT6ZAnPEF0DJhEHAriUItJLHgquuDsTmEA6zEptctS6Lfzwfm
	bbN4FB7zrro4IhWKWUpYeLRcvCb0tvLiB6Tt8rXYtvslf8aWTF7jKfFRloAZFmqI
	NkVRXy+MB5FWDLqq/N7RJXPzS40E9bGebTMhb0DC+vWpCzw70ho3ePGnNhdVxOfn
	8aUUFCqObIf2w6eYQqNlfr7nDKktUPmxG2z78zYPmAcPCcHWdlt1OzoSDlmoKF3k
	ioOa/Nw6gj5EL1USiJx43bQTzOSfWoNeiabtjxMpUiisMDYW93PijeIqVoQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmreaasm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 10:35:49 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82c83bd48afso2796955b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775558149; x=1776162949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpRQKCFvWsWL1+enbc+U4LrFHUHkv76LqYi8zeJXvLM=;
        b=bukLV/z8XK8hQ6Vwp5SgTUDA1KSDiiFIkXCRWxQ6GaaO4adQzpFx932sxncE6XHK8E
         7OgzrfAoPu6+YKLyLIJ7w68RwBQdd7R4oT93q8eEoUXensuoYT8VwwUEfea3Y6tXCQ9T
         tj9iYiLl3g/LkFh11aBXd7RSx0oN5BvIOMYIyEBbKEvUmMCE3WWfR0TYbI7hUiXKWW5f
         kfkgf2KtgNsSSPeWuCn5nS3XLrFXB7/j09wtphLqC5EtFQNOgWZUIpttB3kexivmNHad
         WHGyoEGMa9E6Ol3HndE45DQPsTSEBJe2Jztpcz5rGRsHP89iuWvDWzKaGmXHvg1kdBDW
         TlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775558149; x=1776162949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YpRQKCFvWsWL1+enbc+U4LrFHUHkv76LqYi8zeJXvLM=;
        b=fb/K+sXK/jRYSfpD3/ncSGtDMCX7KPoBoYGtLQ9rP2/Vo/YJquX/7j9PF2egI+8LWY
         OBOJqWF7czEgTwutBFSX1vosaD3retsHnIkwBmZS6XdBNAdhjqgVjrVhht34toFo/ILV
         Vakdi3tLUX74XVZ//921PPGfR4UybB9QM3aE++qa4buZqLJ3c3Qt2c1k5ycBIG9+sEQE
         BRrmXrq0GlW/+7Xu9LZchg8Ry1SQM1j+BI80TwKWlYDaSxOLkYJDSZkuPPTJm3j1bGHO
         ccavxN14zMwu0759Q/UHqJJdRPXiYjGkItX5qeyQKDise5JnC8aWwzPRPc17cbDc1d7b
         QxFA==
X-Gm-Message-State: AOJu0YwJpQIpzSmr1t8CMVtKsln4WJ+3FbSfmaPashMs4ohWohcclhZw
	FRIlG9glMd72vEZvsEBzhlGcyFi3R/DFMfKoDimCjKDncRLdgfNqvJiKo32fhRv9s1ETOgfkcG6
	d6c7qZtoYbxN8dkHVCTK5tAeRnoBNwDQbeJs140Ujr1UUpO6kBTyVtC1ikYfcoaiLQ1wa3BJdau
	/BpSQ=
X-Gm-Gg: AeBDieszatVFy8o6HkVedbOnfGQin6w/X2cq9Bh5/pj0XRjUbyQ9QaMWWf+lt+pu89K
	PT7YeIV6SdBGvtRk9HxvSkVG6aqYtr0zsigBoV1MJorJ8rK0nLkH4tAIAYgWWYMFSVQj9RgGlP+
	Tos/n36T5YSU5YIS9xyQWqM+K+4S+Pt1Fw9ZWr0BsVJfUpE6aVvC6M6c+0TE/3CxbVBzUrmicHN
	0JHnSaBXTUECwghCK/TQ3zeX9oCLwoQTMyDC9EQcQve3cLDcNMKHCUClLU3ASAIq34bnJV/4klU
	vOk/FJsGrIkYzzAk4mvR/LlPsXVRWgIl14VyaEbTdTgx0YpBeb1+mJ3whg5Q+oiDYYZOxNIo2xT
	fCosfc5eG9bsF9twz01FkTXC2Tbuc3hqEHzBNxzVcbWe4qkIyOEA=
X-Received: by 2002:a05:6a00:3314:b0:82c:e83d:a9a3 with SMTP id d2e1a72fcca58-82d0da8d96fmr15026169b3a.22.1775558148998;
        Tue, 07 Apr 2026 03:35:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:3314:b0:82c:e83d:a9a3 with SMTP id d2e1a72fcca58-82d0da8d96fmr15026139b3a.22.1775558148466;
        Tue, 07 Apr 2026 03:35:48 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca14b3sm19575136b3a.54.2026.04.07.03.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 03:35:48 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 1/3] shared: rap: Introduce Channel Sounding HCI raw  interface support
Date: Tue,  7 Apr 2026 16:05:14 +0530
Message-Id: <20260407103516.2371804-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260407103516.2371804-1-naga.akella@oss.qualcomm.com>
References: <20260407103516.2371804-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OKEXGyaB c=1 sm=1 tr=0 ts=69d4de05 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=HdaM-3HAgpQx_hXQJJUA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: hguKe2xdRNAG4jAk2QSNG2k196-yAnaI
X-Proofpoint-ORIG-GUID: hguKe2xdRNAG4jAk2QSNG2k196-yAnaI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5OCBTYWx0ZWRfX67ly0QOcsWIb
 H/rxEvMGkKSm7gUrs3JiaEZH9LSKeQCiTMgZ1Zh64W651ZraWj0JY7xjTGbZiAcedinlKZLU2Ez
 2rrdPitVJuJQcf6aZjHRWDSeSM8jVO3Q2L9nDNGAwewLnFQ6OZtmc1FaxNsdS/zywH4krz1wbvQ
 XSVzlEfu/XpO1Vmspaji7N4Sw8e+pCs4hsFEI3tNM/oMBs6YSm659TJlCxEjGIA+lgxJV3q/Xb7
 L/O03QrZhDDGXxEblcD6h6faYZ+2jmn0Y4Nhs91t5eakHVbdERZcxsZN6etKK0lynpwBtkYsgQ8
 k/HJmStZxlVMYB7nHj4hKRf5ZCsWmZS3pXwiDotbrFTUFalFbdcWRx2C3fb7nDPBhGlZx3qgW3y
 TmiW69bkfwiq5PMe4iCurIAVmqfYLdPsoA/OCs/+5mj2fXY0Juq0/1NLYAJQkUoKPThqpvHhYRA
 43AcW6O7e2hyp/wABVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070098

Implement stub callbacks for Channel Sounding HCI events and add the
required protocol definitions for CS configuration, procedure control,
and subevent result parsing

Add data structures to support Channel Sounding Processing
Add helper function to get hci conn info list and integrate it with RAP
---
 src/shared/hci.c |  67 +++++++++++++-----
 src/shared/hci.h |  12 ++++
 src/shared/rap.c |  46 +++++++++++++
 src/shared/rap.h | 174 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 283 insertions(+), 16 deletions(-)

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
index 39ef3f278..a0ca6ca71 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
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

