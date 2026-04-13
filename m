Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4652731E842
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776076908; cv=none; b=H+CxpLAS5vEBFZxzugcFHCfOKGmBcox1EmaI/fPYbLg/qWGCKmWri4zF5tcwSXJ/ZCS7IUozFDkd3qW2LoQqynbCH1lGrulEVJmkzjQYGMhkwIUvpkQ+Txv+MUM19D72nNTj+WGT/lYJQ/FDoxCog3rEa2DoEGiW3cAEUcNAGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776076908; c=relaxed/simple;
	bh=WP1VkMqMpH/puSWetMPEnt1vMG1Tge21kzUyG/JlboU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pJ5u3iaPFYrw7xdLDgzNlXE3BUAoXcoSamCx0InfObQf90jYAHn7Lq2n7u93vtHSfhP3vBW7eKkyMKmUoP9tZXu0azQZuD5xmWXLVor6/zl/tUZYoDCdvdui9dvnERK3WY/KP42IL9SKLcYBykBQB/e+fr+fnhOeM66M8COLmH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R138zRm0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ffGQ2Mca; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R138zRm0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ffGQ2Mca"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D7cwQp1367778
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 10:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jKxyjMK0Xd9
	qo8oyWMGEK1Uts0osWzamS4e7KKGTG78=; b=R138zRm0kfJCpVFtVpVhmNuyVuT
	JJPHLHKz57VUoZNMAMQZF/7q0pV4M261GkY+DBAftCSVNtsJF5okbDdW8K3B95a4
	DiRzgeda3cD02v4Ia1Fuw+kuHT8b4AOxnBik2zhodRe00XUSTBKyveLiEIkhxpQh
	Zyy3qkKPijdySqdReou0YPWRef5tbXuEG+IM9GB9Jh9Fnwg6HhogeO4oQ4g5w/DP
	LCAH4flYlZYb754l0tbLgizPJr4oUEIjIyZzChDVypHgh+fGW5HAQ4edybFMelJR
	0eHVfZhQAw35Wfx56IjmSbBPfFo0xlo52+eUixBHdC5TrJiU/rLtsOBYSJw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevtmyfd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 10:41:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b4654f9bb6so4758755ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 03:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776076904; x=1776681704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKxyjMK0Xd9qo8oyWMGEK1Uts0osWzamS4e7KKGTG78=;
        b=ffGQ2McabOSQ6m/p2uw71Ab6/Cl7dptSz/VCexkWLhyI6+L4qwuw6tPmf+iC3y7nAY
         7e1+duSIEEJ9GFyKy5xk2wziKtAzlfATSxQDPLQiBHbHvUWSRU0IRNaO+0M3vBt6ACd9
         LJeXvnmS2yx3Qx+t1VpVMn5xozJ4Q2EftTEBMGWTEd4pZ7Pq1TjjasSfjx+tn8JXzo/B
         gJVV+hrRTgYWyzK9QVxfBnC2QC6CWcoP7ejE9r+h9RmiyMoDQuQYYaLJUdnWriRvcKC9
         gpbfX3nux/UKcHW3js2X4CkycPgkDw1QdTgKdVNoM13u4evJVlGhSkwZh/aHHigfgYEQ
         +3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776076904; x=1776681704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKxyjMK0Xd9qo8oyWMGEK1Uts0osWzamS4e7KKGTG78=;
        b=llCOTMlINqRC9OUs0/R5OAnEAqq4r2Es2R/8OReXXBm6MtY3x5IWHW6JGZfjTPsB9B
         IVy1UpLvSFft7VdnYGcK+kcHrJaXq+ooRLsB7ayR5c725NxdR5ZG532VvzRU/DkBNpSG
         OY4RlGDQLSzVlIEBzBflk40UDHcgb8ZanEkfdBwWNYPRcOjrrWr4Q3fnYB7dQpbIFEnQ
         URaFEU+WKFgGdvGnMN4gGWRtLUckHgliOuaWu2mFKSdSgrsnRYWKyqPb08Wni9xs27rr
         /4ZRJJ8iqyv9aG+JDqfMzbu3b9539xFGZuiuM4OJdit6OPhIh8yC0vYSud+nJ8KhMAVN
         LICA==
X-Gm-Message-State: AOJu0YysQ5f/e8t3ecREWOAIkIEqZbG9XLoTRviXC20GZm9V20qXmwbX
	GsJIvfQJymQuUMje5YyE8A1UfW+LbIcsnBgKSTrBQJIfO0X8Kr3ylXoG6k+DQQRinbz6f2a7XIW
	oA3YlMjxKWA/jaSLrnzOUnV3rlht+4ZEHl/h1X2EMroHbtmlfs78xwOX4JR3Fa/rRYuvmRitGXh
	yP9hI=
X-Gm-Gg: AeBDieufFEFOogfqSLA3M76kTWxrE/O0qK+t2EDysihk3riex7AkzTRLJ5NTxhpqJ61
	hTGB9D/NcahS1XrGR37ugGVsQVvdG7R8biiO9DyYDFhc/ReqYHvHKpjMk09usGadIcfgQYM0XQY
	2VD7mpr5zHqwkkq//fLcONxmDbPnomNUaO+O5xejRew0E0XPMYsyccXKYiLpY8i2Yh15UIVaoCr
	hSMu2i+uQo2H7ZguTKqZlfeNSBWCNS4B7i+SHbjtbF8VUwf8vXrVwWX6/DrhULgMJkYFrKEjQuo
	r/e852tLQh/6vFeoS1ctAJ3ublqUyzvzWpgFf6D7pm+9J0QAbg05i46qFf1CPasxYPs6+rqid+2
	g94lfgpxrTSOy4WfUeDeCRz4iQpeo1xQdVmBfj0ZxH0jdRUReSFc=
X-Received: by 2002:a17:903:3890:b0:2b2:d09c:c07c with SMTP id d9443c01a7336-2b2d5a68ed9mr126335165ad.36.1776076903986;
        Mon, 13 Apr 2026 03:41:43 -0700 (PDT)
X-Received: by 2002:a17:903:3890:b0:2b2:d09c:c07c with SMTP id d9443c01a7336-2b2d5a68ed9mr126334955ad.36.1776076903480;
        Mon, 13 Apr 2026 03:41:43 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4e0f909sm144495055ad.35.2026.04.13.03.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 03:41:43 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 1/3] shared: rap: Introduce Channel Sounding HCI raw  interface support
Date: Mon, 13 Apr 2026 16:11:14 +0530
Message-Id: <20260413104116.1605357-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413104116.1605357-1-naga.akella@oss.qualcomm.com>
References: <20260413104116.1605357-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69dcc869 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=QxWqq81_DWPgsp5-wqkA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: iUEe5RSZqu3ceJ6d527M34738dOeHoVl
X-Proofpoint-ORIG-GUID: iUEe5RSZqu3ceJ6d527M34738dOeHoVl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwMyBTYWx0ZWRfX6Q+yIBa2uThl
 b3ApXezclMXEuzPY72YmdnUz67f9MejPeADLwpJ5VhKA91MPsiIKWFWT/lvMIsbUlHQkPK766oj
 4O3HNmRM8z8Gg82W3Znr8L9tGeDRso4BKIr8wqOisNPBFUAyA1WxIbNbTLTb+KFHf1zpW3W2y32
 OCMeZPVFAxghaqhnXYpH5pbrnnMU8IOs3NV19sJ+QNA8Bx5tJyhg8xwPHUfnhireYB3o9KB0t9o
 AEhVeZejUvXDdSpIp+P7Rl3fP8eX2KGTlkvq3eDHecxZOssO9ER7gXGY3bOTlIgzCKVoEpzuuZq
 N36mWhxsK8zbxFMQVa3/mA8RzfmliJ3Tr6ZDwFqXuj+AE6L5dcbB3/1Zi+XcCNcpG1Fby0gufqD
 1bt6W9uilSfmOhfYOZ3wPyZEGLAmBkvtXcNMuOYMPJiU6AU+JAvY9rFRJ2tuaHGGhyv5i9WyjiM
 t2y5zuwJI4FT3HeIsdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130103

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

