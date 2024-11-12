Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AA54C91
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731387050; cv=none; b=XWH38j2Qu5xwW0uOgCYJsdrtFGrPCNPcSyscPw099E9GWcpjjvCt5clpzdDIFJTqMYaj54zpw9QcTGtVCmoYS1K8PLGnJn4Ra0jDNibeVoE4ITwsgWQiA2Kc9CIIWSosMBQKZvlrlpgbgeP51PXOQDgMeOZvMCQBAZmw4Oh3hH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731387050; c=relaxed/simple;
	bh=yYj8Hr69aFja5vBNP8TkIuKXByteTOFTeY5BUWtEe8k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TRCRQ8VtX4SwMYGrX1sx31uoVU+nf8qFwO7ID/zTDDkkPGOP7aAk32AG3To9G3vYQnu0DKGooTJrEtld11LVOZpTktVO94lUbgI6Vhyby8ZSYNhm6nOjBZbPtibyareUxXt1Zfe1RCi+ouE6DJSP8R5IxDwVaVg3wuoa+QJabDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X2krD5e2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X2krD5e2"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC2DHji003882
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 04:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/amOirFSA5zRj2ZA3/QDHx
	s42tbZ7pzcp1MPkXbCPGI=; b=X2krD5e2JM1h3pzjtyzycJC4BbdckFJV9oHLjQ
	cR0VtwC4M9hB95qDoYZ6ovqyNYSDsMfndoC5q/coI5wdZ+hszSA5Pjus3NCBqcpX
	wctsjOHWilaJBvR3L1fdrkSNqANLSlz6zLBhl5PIeqkeIA768XNyZetHh8HJeREs
	WQ2c4ejG9dYmb+P4JqyL8E66FfhlWXzziTVWljLD5hZR1+WPubTinLviNvcDX/Sr
	J54iuss+hZ4rmgDpzvJmLiMON3aGiJqdFSzMyNWX09nGi7nWCaY077Vj+fGum6Iq
	XSjlakX6Ilp8cpWsvFdk+B4FVE2KiDiwsu8qjwIAPn6TgYOQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t11862ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 04:50:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AC4oedY027357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 04:50:40 GMT
Received: from hu-dgangire-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 11 Nov 2024 20:50:38 -0800
From: <quic_dgangire@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ v2] tools/obexctl: Add command line options to support session/system bus
Date: Tue, 12 Nov 2024 10:20:22 +0530
Message-ID: <20241112045022.2743723-1-quic_dgangire@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lHH1MPXpooBqfrzmaAky7jdszkYq6JAO
X-Proofpoint-GUID: lHH1MPXpooBqfrzmaAky7jdszkYq6JAO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120039

From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>

Currently obexctl only uses session bus.
As obexd has been enabled support for both session and system bus.
Configuring obexctl to use session/system bus during the runtime
with command line options.
./obexctl --bustype=system or --bustype=session.
By Default session bus will be used.

---
 tools/obexctl.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index a398b095b..d88ffc9fe 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -2149,16 +2149,42 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 		session_property_changed(proxy, name, iter);
 }
 
+static const char *help[] = {
+		"Configures either session or system bus.By Default session bus is used",
+};
+
+static const char *bustype_option;
+
+static const char **optargs[] = {
+		&bustype_option
+};
+
+static const struct option options[] = {
+		{ "bustype", required_argument, 0, 'b' },
+		{ 0, 0, 0, 0 }
+};
+
+static const struct bt_shell_opt opt = {
+		.options = options,
+		.optno = sizeof(options) / sizeof(struct option),
+		.optstr = "b",
+		.optarg = optargs,
+		.help = help,
+};
+
 int main(int argc, char *argv[])
 {
 	GDBusClient *client;
 	int status;
 
-	bt_shell_init(argc, argv, NULL);
+	bt_shell_init(argc, argv, &opt);
 	bt_shell_set_menu(&main_menu);
 	bt_shell_set_prompt(PROMPT, NULL);
 
-	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
+	if (bustype_option && !(strcmp(bustype_option, "system")))
+		dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+	else
+		dbus_conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
 
 	client = g_dbus_client_new(dbus_conn, "org.bluez.obex",
 							"/org/bluez/obex");
-- 
2.34.1

