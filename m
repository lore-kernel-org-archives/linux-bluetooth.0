Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B11C01
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340477; cv=none; b=YK8RFodTD692fFQdsBdYTxjynz75Q2KBYwsNfAp+hF12+QHVl5zd2D5ZJbTaNc7s8hQHwu1QkvKnDii5zP7k8EPrBgt005odTLUfsgq69Swzz7FGgU4wQ185mLL9ADRepdhXAEPW/d7TL/nSdYRXvI6kbVtVtcyfOWfW29cZ0RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340477; c=relaxed/simple;
	bh=XooXvHMMs1uuaBkcLgrhBEN/C/SKxtl6Ur+vSYnxu9g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S19yTIH/xpncej6QC4i41uQqm7WOYgHUfzeI1epCJUOEL5e2QMEzNQ+qT8u5B/kWZSj72xSttXv0oBFs2KovOODjmbEn1Rvml0gZ2tGZP3KpY2ptwYxUgeK87PuOZehj5PLNqR8E95TSbkVVE8s834MEe+3y8YnIEUUeU8Q8dmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XONh68YM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XONh68YM"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABCF1td014837
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 15:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=teYnekODRUlfeoMlMe7UGs
	m8hUGQgAkP7gUNXL9TrTk=; b=XONh68YM7xIcg2kS4ODABX5UwXgzWKQvft0s/7
	cKsEAlcW73RNsouzeQV4NXYOpgCZP/xCgPJ+UBnyElXMtz3gg5hawuXQ6YcE6jP3
	iO9IWHX8+uHO+r1BDt0+WdNpnwsXit+izg131c0ABECSQbA3fKQfqkafFoAvSS7Q
	YPIr8fscAUHAnipzjDR6WjrDMI3alG1aQvBd+w+GvzaNy8JGaAgbVcwTO5twT/rK
	txTG/D/sTfdTXc9JBWmhfWbXaFt0Hm29UxMIz8uVgcm+AD/HWdPBLWWEnUNYg9Za
	dbx6eF8ywraWdRGYhxpkh7OTyfDeAy12D+71Nn7nVcjCOafg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42syax4nr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 15:54:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ABFsWub029884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 15:54:32 GMT
Received: from hu-dgangire-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 11 Nov 2024 07:54:30 -0800
From: <quic_dgangire@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ v1] tools/obexctl: Add command line options to support session/system bus
Date: Mon, 11 Nov 2024 21:24:17 +0530
Message-ID: <20241111155417.2439689-1-quic_dgangire@quicinc.com>
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
X-Proofpoint-ORIG-GUID: IBd7W__inCZFQlqcOOrLu-nGJOi-BuXW
X-Proofpoint-GUID: IBd7W__inCZFQlqcOOrLu-nGJOi-BuXW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110130

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
index a398b095b..21abfc6f0 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -2149,16 +2149,42 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 		session_property_changed(proxy, name, iter);
 }
 
+static const char * const help[] = {
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

