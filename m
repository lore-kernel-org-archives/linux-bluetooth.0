Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBC61714D7
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007758; cv=none; b=DeScrinQ+93FzcaA80i7u8CnLTEor0AurWZWOKzxecpxyQFCtxBs8dc6xo73xfrf1xQ1eHUcev9zuIUtVRVwywjHPYum9VDEinqCqNpjO/skjTbUKdamaH8WVlOq+Z2RUdViU10w4AsUqnXUSMzbyUexsoHE9eYSGTvGAvY25Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007758; c=relaxed/simple;
	bh=4rbzliemNVln4YDxmuG2hl4HMjHtjsf5TpKV4jTJmAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MdsTpHbZ3dTDjJnpz3SgolUQ5Pg0yciE+mDphfh2Rl9YRt2DNR5E0EzgiKWYGNTnGslSegl22pD3DhhX34AkHTVhuzH4crzoCGRc2PfmxbBKOj8EdKv+RhQZXVYKPHvJ5Y+1cniuc1Y3gYnJX/XuyQGzRxubRuEJirQtl+0UVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XDS9UkcB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XDS9UkcB"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7qAX5019074
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 12:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=up6P6PVGjZ+c8PHpJ/hs4a
	Z7UR6onlKuXltffOa+66g=; b=XDS9UkcBgKosEXzYF49diVzdazh1IRAvprioQB
	qh7P8B+UTjQkoxgVToAQ0Bqsik2rXriBFJ3h0LiWM3ryig8iB3NiC8SzqTydk+vV
	Sa6KNdhirvTR9YyF+YElg4zUV3p38SpbQ2cLYss1MnVJwWX+6GIABTYAJutQHuxc
	A4lssYN8+z32ePCrEBSTn0lYhn4mmetH3+c7YYjI5zQNr92zNWhkxOt7GytI6ZHN
	gzO642EHrKF4hJJBCWKTYWCtfDhCbisMM+8ZK6dB+AK1OoWJyKxg0QdyPEKlYIJh
	JR98c9AP4Jb/lXjHYp0tTmQZrzqys8A+U9bJZsc25x/ENbWQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ffdytgp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 12:49:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BCCnFPr019351
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 12:49:15 GMT
Received: from hu-dgangire-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Dec 2024 04:49:13 -0800
From: <quic_dgangire@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ v1 v6] tools/obexctl: Add support for system/session bus
Date: Thu, 12 Dec 2024 18:19:03 +0530
Message-ID: <20241212124903.3450994-1-quic_dgangire@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3jBAVNDxp7DWCdfqw6PPR7iAu2Knmv2k
X-Proofpoint-GUID: 3jBAVNDxp7DWCdfqw6PPR7iAu2Knmv2k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=905 lowpriorityscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120092

From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>

Currently obexctl only uses session bus.
As obexd has been enabled support for both session and system bus.
Configuring obexctl to use session/system bus during the runtime
if the name is available over session or system bus.

---
 tools/obexctl.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index a398b095b..9adf8088a 100644
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
@@ -2149,19 +2151,47 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 		session_property_changed(proxy, name, iter);
 }
 
+static bool check_obexd_service(DBusConnection *conn)
+{
+	DBusError err;
+	bool has_owner;
+
+	dbus_error_init(&err);
+	has_owner = dbus_bus_name_has_owner(conn, OBEXD_SERVICE, &err);
+
+	if (dbus_error_is_set(&err))
+		dbus_error_free(&err);
+
+	return has_owner;
+}
+
 int main(int argc, char *argv[])
 {
-	GDBusClient *client;
+	GDBusClient *client = NULL;
 	int status;
+	bool session_bus_active;
+	bool system_bus_active;
 
 	bt_shell_init(argc, argv, NULL);
 	bt_shell_set_menu(&main_menu);
 	bt_shell_set_prompt(PROMPT, NULL);
 
-	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
+	session_bus_active = false;
+	system_bus_active = false;
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
@@ -2171,9 +2201,14 @@ int main(int argc, char *argv[])
 
 	status = bt_shell_run();
 
-	g_dbus_client_unref(client);
+	if (client)
+		g_dbus_client_unref(client);
+
+	if (dbus_session_conn)
+		dbus_connection_unref(dbus_session_conn);
 
-	dbus_connection_unref(dbus_conn);
+	if (dbus_system_conn)
+		dbus_connection_unref(dbus_system_conn);
 
 	return status;
 }
-- 
2.34.1

