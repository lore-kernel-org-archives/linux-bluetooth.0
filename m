Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DA1185924
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653014; cv=none; b=P1wJLkdHvvGrFeNLudcIuVyPOPisZ/VwDm5U715Ejd/EL48/FLht3IXTGmETZcBNLW65B3KGbtQqftqh9bh3YeR1Gxj/O6NUFp91gHeRnRMNMHe5EAtOd1R8VwZrgBO7ney07P8AqgAib+AEhaala8e0RidTyaEt08JHCmdl8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653014; c=relaxed/simple;
	bh=ea9vVYIfwIvdCcScSChqjbhQ6N1l9Zf+D9KnJqrPccw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DbqwHaxmaO2UQCqvnPqZAp0KTfhWIxyPQhPs4MPVLOXm/GZ9ZSpFG0Q6N2BTutzJkOM7kfsdikzEvDcBGHoewZd3vjtlXypsiDFteybhtFwaD7AJXRZhJtx15rYFKQHnIb2bJzeJKnjIlA6OJEKJEZOc+ntDATDF2kY4gV4AKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hu21LAt6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hu21LAt6"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF248hL002666
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 06:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0BtBPgzlGfOZdGX70snLF3
	A4xFf8iGw2rgVTnp9mCsA=; b=Hu21LAt6VAj/8yjVzePNn2oreK9qq5Z57XtISd
	HCDyk1E1Vq4YkHmru0wXNx8q3J/7Xaru/LJ/8N7DztafKqsoTI/sCi0fQyLspB35
	TehsCKoxWOgiPB8XgAPmsyqn1GXcpJIi4cuXPN5RIqUoc/NNlI6LygpXY3aeHhHg
	M1Cz4RU9y5KHW2tosbSEbzemsyHdzXdPWr5AjwCWO+XTNI4+MeTFIoRGdushM+Ou
	BBevgWsh3DG09m5ALE2Zqhy2RMyQzmp1crKdY17utDn1Py6QC+gdBy3oIbiLOibD
	FqFqn9zd3ZAAvhQKAoEJL0yokrJ2zCv43biV+gZJui6/xonw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ww6drjvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 06:43:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AF6hTWO024888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 06:43:29 GMT
Received: from hu-dgangire-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 14 Nov 2024 22:43:27 -0800
From: <quic_dgangire@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ v3] tools/obexctl: Add support for system/session bus
Date: Fri, 15 Nov 2024 12:13:04 +0530
Message-ID: <20241115064304.503655-1-quic_dgangire@quicinc.com>
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
X-Proofpoint-ORIG-GUID: bh36uABw_99drM_k4NbuFyNElWWnzg34
X-Proofpoint-GUID: bh36uABw_99drM_k4NbuFyNElWWnzg34
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 mlxlogscore=995 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150055

From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>

Currently obexctl only uses session bus.
As obexd has been enabled support for both session and system bus.
Configuring obexctl to use session/system bus during the runtime
if the name is available over session or system bus.

---
 tools/obexctl.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index a398b095b..95350358c 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -43,8 +43,10 @@
 #define OBEX_PBAP_INTERFACE "org.bluez.obex.PhonebookAccess1"
 #define OBEX_MAP_INTERFACE "org.bluez.obex.MessageAccess1"
 #define OBEX_MSG_INTERFACE "org.bluez.obex.Message1"
+#define OBEXD_SERVICE  "org.bluez.obex"
 
-static DBusConnection *dbus_conn;
+static DBusConnection *dbus_session_conn;
+static DBusConnection *dbus_system_conn;
 static GDBusProxy *default_session;
 static GList *sessions = NULL;
 static GList *opps = NULL;
@@ -2149,6 +2151,22 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 		session_property_changed(proxy, name, iter);
 }
 
+static bool check_obexd_service(DBusConnection *conn)
+{
+	DBusError err;
+
+	dbus_error_init(&err);
+
+	bool has_owner = dbus_bus_name_has_owner(conn, OBEXD_SERVICE, &err);
+
+	if (dbus_error_is_set(&err)) {
+		fprintf(stderr, "D-Bus Error: %s\n", err.message);
+		dbus_error_free(&err);
+	}
+
+	return has_owner;
+}
+
 int main(int argc, char *argv[])
 {
 	GDBusClient *client;
@@ -2158,10 +2176,23 @@ int main(int argc, char *argv[])
 	bt_shell_set_menu(&main_menu);
 	bt_shell_set_prompt(PROMPT, NULL);
 
-	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
+	bool session_bus_active = false;
+	bool system_bus_active = false;
+
+	dbus_session_conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
+	if (dbus_session_conn)
+		session_bus_active = check_obexd_service(dbus_session_conn);
 
-	client = g_dbus_client_new(dbus_conn, "org.bluez.obex",
-							"/org/bluez/obex");
+	dbus_system_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+	if (dbus_system_conn)
+		system_bus_active = check_obexd_service(dbus_system_conn);
+
+	if (session_bus_active)
+		client = g_dbus_client_new(dbus_session_conn, OBEXD_SERVICE,
+								"/org/bluez/obex");
+	else if (system_bus_active)
+		client = g_dbus_client_new(dbus_system_conn, OBEXD_SERVICE,
+								"/org/bluez/obex");
 
 	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
 	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
@@ -2173,7 +2204,11 @@ int main(int argc, char *argv[])
 
 	g_dbus_client_unref(client);
 
-	dbus_connection_unref(dbus_conn);
+	if (dbus_session_conn)
+		dbus_connection_unref(dbus_session_conn);
+
+	if (dbus_system_conn)
+		dbus_connection_unref(dbus_system_conn);
 
 	return status;
 }
-- 
2.34.1

