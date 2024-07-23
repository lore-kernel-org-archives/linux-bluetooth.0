Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445414EC5E
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721732358; cv=none; b=fxsDiJyBJ2C4uLtjPRX7+qr6W3RarJYF4bGB3DJXAk3iiND93tyU8ttf0XaOw1kZt/STxwr2gtkiwnZmm0MxtAmXEqEsCXEzU8qXbn4ZvRD9nLF0smY+uyIZXWOJlsqeOq7hZpY/eNPWHg0fQB2ehzIdPAB9M/9y95RJJDcbFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721732358; c=relaxed/simple;
	bh=CQEE/C1VdOfBah9kAs63jEtbCdJ+5Iri0aXUw5eFrIQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I3GwC8htBwbUDfg/tH9x2Ei3t0OHGH6X4kpTJoCs91YQhhnaG7m4fGkf2LaS9POW1mFAdErzFGz+CPWMePoUm5OBv7sJ71w+LQDEn+uiifC3s7ZXrQb2wVplbLtIgbeinavu3gWcxiFb4cpq/MBl5cmX9b48QORtQDz+41/clTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fVLrMWqg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fVLrMWqg"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NANqXt007911;
	Tue, 23 Jul 2024 10:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=rhfu9YuzgvBion465byk2uGdkGDBbfFowGuqqeG6IgE=; b=fV
	LrMWqgVjqG7MOoUBqsAiszBI9xKJC99tAmAmTE7/tJjfqUM0fy4E6yRtBsqEvwTR
	r7F4FV67qG6p6tCcaQltmbZGRIGQ9bsQHFlMWaDPfCdgE17ZA+g2Mi4Xvw/TCQUb
	nnpeOe0fU6H6VS1Gl8H2O/OD7T9Bv8chmO2h6tFY7Ki5R2mQZlIjUOrO5ZUkBZG6
	RZZ5hJykVfzfjQatRro0bMpz5d27J7pFFwZobleA55P4DTsLZsw3zmD3I22/5Ped
	WbWzESAZb2Qwr2K9mSQP7MTbwVrClroTtap/8EaTmyjWVrvPbbFekKTg2AJEVcqZ
	95JRkHVvuUPsCrZIOzCw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g4jgxg74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 10:57:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NAvC68027318
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 10:57:12 GMT
Received: from hu-nakella-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Jul 2024 03:57:10 -0700
From: Naga Bhavani Akella <quic_nakella@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>, <schapman@lixar.com>,
        Naga Bhavani Akella
	<quic_nakella@quicinc.com>
Subject: [PATCH BlueZ v1] hcitool - Added option for Peripheral Initiated Connection Parameter Update Request.
Date: Tue, 23 Jul 2024 16:26:31 +0530
Message-ID: <20240723105631.18422-1-quic_nakella@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HRIQJV_am_L7GDAtH2KYu42el_8nzhhV
X-Proofpoint-GUID: HRIQJV_am_L7GDAtH2KYu42el_8nzhhV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230079

There is no option in hcitool when Peripheral wants to
initiate Connection Parameter Update Request, hence
added provision to be able to send LL_CONNECTION_PARAM_REQ
using hcitool.

Required for PTS TC - GAP/CONN/CPUP/BV-02-C

Reference link for discussion :
https://marc.info/?l=linux-bluetooth&m=139714173525776&w=2
git code link :
https://gist.github.com/SandyChapman/4a64c9ea22cd27d935e3
---
 lib/hci.c       | 75 +++++++++++++++++++++++++++++++++++++++++
 lib/hci_lib.h   | 29 ++++++++++++++++
 tools/hcitool.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)

diff --git a/lib/hci.c b/lib/hci.c
index 937e65d48..435ff63f0 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -1119,6 +1119,81 @@ int hci_send_cmd(int dd, uint16_t ogf, uint16_t ocf, uint8_t plen, void *param)
 	return 0;
 }
 
+int hci_send_acl_data(int dd, uint16_t handle, uint8_t dlen, struct signal_hdr *sh, struct signal_payload_hdr *plh, void *pl)
+{
+	uint8_t type = HCI_ACLDATA_PKT;
+    hci_acl_hdr ha;
+	struct iovec iv[5];
+	int ivn;
+
+	ha.handle = handle;
+	ha.dlen = dlen;
+
+	iv[0].iov_base = &type;
+	iv[0].iov_len = 1;
+	iv[1].iov_base = &ha;
+	iv[1].iov_len = HCI_ACL_HDR_SIZE;
+	ivn = 2;
+
+	printf("\nACL Packet details[handle:%x, length:%d]\n", ha.handle, ha.dlen);
+
+	if (dlen) {
+		iv[2].iov_base = sh;
+		iv[2].iov_len = 4; //HCI_SIGNAL_HDR_SIZE;
+		ivn = 3;
+		printf("\nACL signal command details[length:%d, cid:%d]\n", sh->len, sh->cid);
+		if(sh->len > 0) {
+			iv[3].iov_base = plh;
+			iv[3].iov_len = 4; //HCI_SIGNAL_PAYLOAD_HDR_SIZE;
+			ivn = 4;
+			if(plh->len > 0) {
+				iv[4].iov_base = pl;
+				iv[4].iov_len = plh->len;
+				ivn = 5;
+			}
+		}
+	}
+
+	while (writev(dd, iv, ivn) < 0) {
+		if (errno == EAGAIN || errno == EINTR)
+			continue;
+		return -1;
+	}
+	return 0;
+}
+
+int hci_signal_le_con_param_update_req(int dd, uint16_t handle, uint16_t interval_min,
+                                        uint16_t interval_max, uint16_t slave_latency,
+                                        uint16_t timeout_multiplier)
+{
+	struct signal_hdr sh;
+	struct signal_payload_hdr pl;
+	struct le_con_param_update_req ur;
+
+	uint16_t length = 0x0010;
+
+	memset(&sh, 0, sizeof(sh));
+	memset(&pl, 0, sizeof(pl));
+	memset(&ur, 0, sizeof(ur));
+
+	sh.len = HCI_SIGNAL_LE_CON_PARAM_UPDATE_REQ_SIZE;
+	sh.cid = HCI_LE_CHANNEL_ID;
+
+	pl.code = LE_CON_PARAM_UPDATE_REQ_CODE;
+	pl.id = 0x77;
+	pl.len = LE_CON_PARAM_UPDATE_LEN;
+
+	ur.interval_min = interval_min;
+	ur.interval_max = interval_max;
+	ur.slave_latency = slave_latency;
+	ur.timeout_multiplier = timeout_multiplier;
+
+	if (hci_send_acl_data(dd, handle, length, &sh, &pl, &ur) < 0)
+		return -1;
+
+	return 0;
+}
+
 int hci_send_req(int dd, struct hci_request *r, int to)
 {
 	unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr;
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index baf3d3e12..906720eaa 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -35,12 +35,41 @@ struct hci_version {
 	uint16_t lmp_subver;
 };
 
+struct hci_acl_hdr {
+	uint16_t handle;
+	uint16_t len;
+};
+
+struct signal_hdr {
+	uint16_t len;
+	uint16_t cid;
+};
+
+struct signal_payload_hdr {
+	uint8_t  code;
+	uint8_t  id;
+	uint16_t len;
+};
+
+struct le_con_param_update_req {
+	uint16_t interval_min;
+	uint16_t interval_max;
+	uint16_t slave_latency;
+	uint16_t timeout_multiplier;
+};
+#define HCI_SIGNAL_LE_CON_PARAM_UPDATE_REQ_SIZE 0x000C
+#define HCI_LE_CHANNEL_ID                       0x0005
+#define LE_CON_PARAM_UPDATE_REQ_CODE            0x12
+#define LE_CON_PARAM_UPDATE_LEN                 0x0008
+
 int hci_open_dev(int dev_id);
 int hci_close_dev(int dd);
 int hci_send_cmd(int dd, uint16_t ogf, uint16_t ocf, uint8_t plen, void *param);
+int hci_send_acl_data(int dd, uint16_t handle, uint8_t dlen, struct signal_hdr *sh, struct signal_payload_hdr *plh, void *pl);
 int hci_send_req(int dd, struct hci_request *req, int timeout);
 
 int hci_create_connection(int dd, const bdaddr_t *bdaddr, uint16_t ptype, uint16_t clkoffset, uint8_t rswitch, uint16_t *handle, int to);
+int hci_signal_le_con_param_update_req(int dd, uint16_t handle, uint16_t interval_min, uint16_t interval_max, uint16_t slave_latency, uint16_t timeout_multiplier);
 int hci_disconnect(int dd, uint16_t handle, uint8_t reason, int to);
 
 int hci_inquiry(int dev_id, int len, int num_rsp, const uint8_t *lap, inquiry_info **ii, long flags);
diff --git a/tools/hcitool.c b/tools/hcitool.c
index 639ee6a51..d6e025e51 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -3369,6 +3369,95 @@ static void cmd_lecup(int dev_id, int argc, char **argv)
 	hci_close_dev(dd);
 }
 
+static const char *acl_lecup_help =
+	"Usage:\n"
+	"\tacllecup <handle> <min> <max> <latency> <timeout>\n"
+	"\tOptions:\n"
+	"\t    -H, --handle <0xXXXX>  LE connection handle\n"
+	"\t    -m, --min <interval>   Range: 0x0006 to 0x0C80\n"
+	"\t    -M, --max <interval>   Range: 0x0006 to 0x0C80\n"
+	"\t    -l, --latency <range>  Slave latency. Range: 0x0000 to 0x03E8\n"
+	"\t    -t, --timeout  <time>  N * 10ms. Range: 0x000A to 0x0C80\n"
+	"\n\t min/max range: 7.5ms to 4s. Multiply factor: 1.25ms"
+	"\n\t timeout range: 100ms to 32.0s. Larger than max interval\n";
+
+static void cmd_acl_lecup(int dev_id, int argc, char **argv)
+{
+	uint16_t handle = 0, min, max, latency, timeout;
+	int opt, dd, base;
+    int options = 0;
+
+	/* Aleatory valid values */
+	min = 0x0C8;
+	max = 0x0960;
+	latency = 0x0007;
+	timeout = 0x0C80;
+
+	for_each_opt(opt, lecup_options, NULL) {
+		if (optarg && strncasecmp("0x", optarg, 2) == 0)
+			base = 16;
+		else
+			base = 10;
+
+		switch (opt) {
+		case 'H':
+			handle = strtoul(optarg, NULL, base);
+			break;
+		case 'm':
+			min = strtoul(optarg, NULL, base);
+			break;
+		case 'M':
+			max = strtoul(optarg, NULL, base);
+			break;
+		case 'l':
+			latency = strtoul(optarg, NULL, base);
+			break;
+		case 't':
+			timeout = strtoul(optarg, NULL, base);
+			break;
+		default:
+			printf("%s", acl_lecup_help);
+			return;
+		}
+        options = 1;
+	}
+
+    if (options == 0) {
+		helper_arg(5, 5, &argc, &argv, acl_lecup_help);
+
+		handle = strtoul(argv[0], NULL, 0);
+		min = strtoul(argv[1], NULL, 0);
+		max = strtoul(argv[2], NULL, 0);
+		latency = strtoul(argv[3], NULL, 0);
+		timeout = strtoul(argv[4], NULL, 0);
+	}
+
+	if (handle == 0 || handle > 0x0EFF) {
+		printf("%s", acl_lecup_help);
+		return;
+	}
+
+	if (dev_id < 0)
+		dev_id = hci_get_route(NULL);
+
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
+		fprintf(stderr, "HCI device open failed\n");
+		exit(1);
+	}
+
+	fprintf(stderr, "Signal LE Connection Update Request: %d %d %d %d %d\n",
+            handle, min, max, latency, timeout);
+	if (hci_signal_le_con_param_update_req(dd, htobs(handle), htobs(min), htobs(max),
+                                            htobs(latency), htobs(timeout)) < 0) {
+		int err = -errno;
+		fprintf(stderr, "Could not change connection params: %s(%d)\n",
+							strerror(-err), -err);
+	}
+
+	hci_close_dev(dd);
+}
+
 static struct {
 	char *cmd;
 	void (*func)(int dev_id, int argc, char **argv);
@@ -3417,6 +3506,7 @@ static struct {
 	{ "lecc",     cmd_lecc,    "Create a LE Connection"               },
 	{ "ledc",     cmd_ledc,    "Disconnect a LE Connection"           },
 	{ "lecup",    cmd_lecup,   "LE Connection Update"                 },
+	{ "acllecup", cmd_acl_lecup, "LE ACL Connection Param Update Req" },
 	{ NULL, NULL, 0 }
 };
 
-- 
