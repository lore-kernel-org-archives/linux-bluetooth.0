Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC721E47B9
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289024; cv=none; b=RExDI8R6tdMp/rkWC5lHkMjIoAoayMvR2X2Ljhu4KZ/b3M9gssjC+baYGdYqsD4kv3AR4frOv5wVk1VI6HEymElr2s+HL8MM3B53a3KR1VIvakkg0zgmoYxHyYgqnIoSArOJL3DVfBNK+gBWGXfsYcSQSO25zqzuhIVsNpSABKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289024; c=relaxed/simple;
	bh=DIF9pV2Na/Ga+oQ8QeMPMYS8BVsoZfyzwMEYeQIUskM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T/VgZLI/r18YtfSbhMbgKOXzhgVtVbND5sfqsGSF0pwVOWrVWCxYVkZE1N3xEGnp7NKO03QQI/iuuYsHWAcAzV0w+/XsdonssIC4l1vO8GhniNn0ovsscHKvBZGDSVIxvIq3pwUzu9Mf2KAWlVO9thitYxEA5p+h/TuDfTGwFC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h6TisEAA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h6TisEAA"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U9Dm6c008610
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 11:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6P9e7YnBPAmAE8Qio5JaY5
	HOezMihS+IPjKDEGa0GUA=; b=h6TisEAA0IKb0O3iBPcuykJJPcBgCMqCZSgrTA
	lGEPmux9NJ8CKFgxx1o0fW243GmKgQTCX0Zgw/qv3DfH/YslDom80hJTsF2Mn7JL
	/7riwzv9uVTuarzM0RYiP2owPtD4sZwptPYVK6EFtAOQvg4zgBiHIBm/lSbTXW/K
	9GH4COLybeNf0iHuxlepiH22hZmzMVfScZ3d5819b6QpWg8SdtQrOOVAZJ8BfCNE
	kKXVpUA5RXIeziDBkB3z5rKy9wdeKWZuF5f42shYenww1MvgFgLH4quZ39OMzzkx
	8C4R4iNtoR8rkaXZeaqejzdzzxj2lu08qscpS3spbI2qDBUQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grt73rfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 11:50:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UBoI5T027988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 11:50:18 GMT
Received: from hu-dgangire-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 04:50:16 -0700
From: <quic_dgangire@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ v2] obexd: Add system bus support for obexd
Date: Wed, 30 Oct 2024 17:20:01 +0530
Message-ID: <20241030115001.1278503-1-quic_dgangire@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dkyWcOQRhGthLU3fAybCzer82xEUAUCW
X-Proofpoint-GUID: dkyWcOQRhGthLU3fAybCzer82xEUAUCW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300093

From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>

Currently obexd uses session bus.
Distros  where session bus is not supported and still obex profiles
are required in that case use system bus instead of session bus
which can be configured at run time.

---
 obexd/client/ftp.c      |  7 ++++++-
 obexd/client/map.c      |  7 ++++++-
 obexd/client/opp.c      |  7 ++++++-
 obexd/client/pbap.c     |  7 ++++++-
 obexd/client/session.c  |  7 ++++++-
 obexd/client/sync.c     |  7 ++++++-
 obexd/plugins/pcsuite.c |  5 ++++-
 obexd/src/main.c        |  8 ++++++++
 obexd/src/manager.c     |  8 +++++++-
 obexd/src/obexd.h       |  1 +
 src/bluetooth.conf      | 12 ++++++++++++
 11 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/obexd/client/ftp.c b/obexd/client/ftp.c
index 160e0636a..83ddb51cc 100644
--- a/obexd/client/ftp.c
+++ b/obexd/client/ftp.c
@@ -19,6 +19,7 @@
 #include "gdbus/gdbus.h"
 
 #include "obexd/src/log.h"
+#include "obexd/src/obexd.h"
 #include "transfer.h"
 #include "session.h"
 #include "driver.h"
@@ -463,7 +464,11 @@ int ftp_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (obex_option_system_bus())
+		conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	else
+		conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/client/map.c b/obexd/client/map.c
index 513dcaf14..c81e9c524 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -27,6 +27,7 @@
 #include "gdbus/gdbus.h"
 
 #include "obexd/src/log.h"
+#include "obexd/src/obexd.h"
 #include "obexd/src/map_ap.h"
 #include "map-event.h"
 
@@ -2063,7 +2064,11 @@ int map_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (obex_option_system_bus())
+		conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	else
+		conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/client/opp.c b/obexd/client/opp.c
index 90d0c0c8e..2d402d77e 100644
--- a/obexd/client/opp.c
+++ b/obexd/client/opp.c
@@ -17,6 +17,7 @@
 #include "gdbus/gdbus.h"
 
 #include "obexd/src/log.h"
+#include "obexd/src/obexd.h"
 
 #include "transfer.h"
 #include "session.h"
@@ -178,7 +179,11 @@ int opp_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (obex_option_system_bus())
+		conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	else
+		conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 2d2aa9508..fe5da5c80 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -27,6 +27,7 @@
 #include "gdbus/gdbus.h"
 
 #include "obexd/src/log.h"
+#include "obexd/src/obexd.h"
 
 #include "transfer.h"
 #include "session.h"
@@ -1303,7 +1304,11 @@ int pbap_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (obex_option_system_bus())
+		conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	else
+		conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 13a834e14..889c43936 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -27,6 +27,7 @@
 #include "gobex/gobex.h"
 
 #include "obexd/src/log.h"
+#include "obexd/src/obexd.h"
 #include "transfer.h"
 #include "session.h"
 #include "driver.h"
@@ -591,7 +592,11 @@ struct obc_session *obc_session_create(const char *source,
 	if (driver == NULL)
 		return NULL;
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (obex_option_system_bus())
+		conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	else
+		conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+
 	if (conn == NULL)
 		return NULL;
 
diff --git a/obexd/client/sync.c b/obexd/client/sync.c
index 92faf4434..ef2c338c0 100644
--- a/obexd/client/sync.c
+++ b/obexd/client/sync.c
@@ -21,6 +21,7 @@
 #include "gdbus/gdbus.h"
 
 #include "obexd/src/log.h"
+#include "obexd/src/obexd.h"
 
 #include "transfer.h"
 #include "session.h"
@@ -224,7 +225,11 @@ int sync_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (obex_option_system_bus())
+		conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	else
+		conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/plugins/pcsuite.c b/obexd/plugins/pcsuite.c
index 07c444ff2..70e67e5d3 100644
--- a/obexd/plugins/pcsuite.c
+++ b/obexd/plugins/pcsuite.c
@@ -322,7 +322,10 @@ static gboolean send_backup_dbus_message(const char *oper,
 
 	file_size = size ? *size : 0;
 
-	conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
+	if (obex_option_system_bus())
+		conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+	else
+		conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
 
 	if (conn == NULL)
 		return FALSE;
diff --git a/obexd/src/main.c b/obexd/src/main.c
index 151574afa..aee86ebd1 100644
--- a/obexd/src/main.c
+++ b/obexd/src/main.c
@@ -126,6 +126,7 @@ static char *option_noplugin = NULL;
 
 static gboolean option_autoaccept = FALSE;
 static gboolean option_symlinks = FALSE;
+static gboolean option_system_bus = FALSE;
 
 static gboolean parse_debug(const char *key, const char *value,
 				gpointer user_data, GError **error)
@@ -164,6 +165,8 @@ static const GOptionEntry options[] = {
 				"scripts", "FILE" },
 	{ "auto-accept", 'a', 0, G_OPTION_ARG_NONE, &option_autoaccept,
 				"Automatically accept push requests" },
+	{ "system-bus", 's', 0, G_OPTION_ARG_NONE, &option_system_bus,
+				"Use System bus "},
 	{ NULL },
 };
 
@@ -172,6 +175,11 @@ gboolean obex_option_auto_accept(void)
 	return option_autoaccept;
 }
 
+gboolean obex_option_system_bus(void)
+{
+	return option_system_bus;
+}
+
 const char *obex_option_root_folder(void)
 {
 	return option_root;
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 3c0c2a7cc..f85e0e9bb 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -488,7 +488,13 @@ gboolean manager_init(void)
 
 	dbus_error_init(&err);
 
-	connection = g_dbus_setup_bus(DBUS_BUS_SESSION, OBEXD_SERVICE, &err);
+	if (obex_option_system_bus())
+		connection =
+			g_dbus_setup_bus(DBUS_BUS_SYSTEM, OBEXD_SERVICE, &err);
+	else
+		connection =
+			g_dbus_setup_bus(DBUS_BUS_SESSION, OBEXD_SERVICE, &err);
+
 	if (connection == NULL) {
 		if (dbus_error_is_set(&err) == TRUE) {
 			fprintf(stderr, "%s\n", err.message);
diff --git a/obexd/src/obexd.h b/obexd/src/obexd.h
index af5265da5..54f91545b 100644
--- a/obexd/src/obexd.h
+++ b/obexd/src/obexd.h
@@ -28,3 +28,4 @@ gboolean obex_option_auto_accept(void);
 const char *obex_option_root_folder(void);
 gboolean obex_option_symlinks(void);
 const char *obex_option_capability(void);
+gboolean obex_option_system_bus(void);
diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index b6c614908..f8879c8bb 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -21,10 +21,22 @@
     <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
     <allow send_interface="org.freedesktop.DBus.Properties"/>
     <allow send_interface="org.mpris.MediaPlayer2.Player"/>
+    <allow own="org.bluez.obex"/>
+    <allow send_destination="org.bluez.obex"/>
+    <allow send_interface="org.bluez.obex.Agent1"/>
+    <allow send_interface="org.bluez.obex.Client1"/>
+    <allow send_interface="org.bluez.obex.Session1"/>
+    <allow send_interface="org.bluez.obex.Transfer1"/>
+    <allow send_interface="org.bluez.obex.ObjectPush1"/>
+    <allow send_interface="org.bluez.obex.PhonebookAccess1"/>
+    <allow send_interface="org.bluez.obex.Synchronization1"/>
+    <allow send_interface="org.bluez.obex.MessageAccess1"/>
+    <allow send_interface="org.bluez.obex.Message1"/>
   </policy>
 
   <policy context="default">
     <allow send_destination="org.bluez"/>
+    <allow send_destination="org.bluez.obex"/>
   </policy>
 
 </busconfig>
-- 
2.34.1

