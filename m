Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95A279C8
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724335; cv=none; b=KeQvsuyqWLEkNtkWx6woaHXXLs2iMbo8EXod11f++dr3M/RszMzG5IxJkL2PNPz4OlVCd8jVMf86CG5fb0iWProGUB96Krv6MYo6Ndc/KAZyzhLs09/PKQ2i7e3u7akW/wkpMCGqokCYSaGa8U9L8Md4MBeRLvy00FgAE8ix/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724335; c=relaxed/simple;
	bh=Ug6QXrSeiuvqQaxoGmZezR9EA08G+zVcLxN5Iv3D8pM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o0fVr9oiFRdOoD2nKfCEIEkMNNppdVeWWZVj8t44oZ+YOZ1K+1JceAvlt4kio2/zqBc4XccznGrUzAEgXfRt755uZKp+2x+9to7ncjkm8dGInWHmQg33wJfftgCFwJ8s9GW7Ljd7BUXMYJdYuUFbikHzjTOZglClxZZpyUH1zhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=liEQgOpq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="liEQgOpq"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BjePj028273
	for <linux-bluetooth@vger.kernel.org>; Mon, 4 Nov 2024 12:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GmuarO3XfaG69ovFBGSBeI
	L6FAWLOFLva/TsGSKBxVs=; b=liEQgOpqZf51xjFYX6wN3y4Gr+cTNoqQ3uFKOC
	XVQIvahXkEuELiRd/QLp6WBH73QDzbWX/8o/tUI8CvXS4+HScUvyb/LYVrX1WFso
	tQE8dI3WwXt6Bx0AKTBG6EPFjGUA3wTLn8+VQhmZ/DSv8o9CQV83wA4CZfdPY0Cc
	x4eelSYQHTfItGbsYiOQo8oSno247y0I+VX9WmLZ3izOfcXTv89unugGtx4QAd3x
	A5bRxRbfrjUjNhTTxmfpc1N4U+Sd2rBUBmwBaQLJQxKA9xSpsuNoYX2bFfZVL5No
	u5TdYwCpAyF0qbw1nAPqa1g2Bojq7FXMTyEOl4r3fpjk5YFA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ncyxv7pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 04 Nov 2024 12:45:32 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4CjVqE015625
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 4 Nov 2024 12:45:31 GMT
Received: from hu-dgangire-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 4 Nov 2024 04:45:29 -0800
From: <quic_dgangire@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ v3] obexd: Add system bus support for obexd
Date: Mon, 4 Nov 2024 18:15:17 +0530
Message-ID: <20241104124517.4112676-1-quic_dgangire@quicinc.com>
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
X-Proofpoint-ORIG-GUID: k44QsSfAVJZGKT323mXeDPqxSi2Brf4M
X-Proofpoint-GUID: k44QsSfAVJZGKT323mXeDPqxSi2Brf4M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040111

From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>

Currently obexd uses session bus.
Distros  where session bus is not supported and still obex profiles
are required in that case use system bus instead of session bus
which can be configured at run time.

An Command line option has been added to achieve it.
{ "system-bus", 's', 0, G_OPTION_ARG_NONE, &option_system_bus,
				"Use System bus "},

we can use option obexd -s to use system bus.

---
 Makefile.am             |  6 +++++-
 gdbus/gdbus.h           |  5 +++++
 gdbus/mainloop.c        | 25 +++++++++++++++++++++++++
 obexd/client/ftp.c      |  3 ++-
 obexd/client/map.c      |  3 ++-
 obexd/client/opp.c      |  3 ++-
 obexd/client/pbap.c     |  3 ++-
 obexd/client/session.c  |  3 ++-
 obexd/client/sync.c     |  3 ++-
 obexd/plugins/pcsuite.c |  2 +-
 obexd/src/main.c        |  8 ++++++++
 obexd/src/manager.c     |  4 +++-
 obexd/src/obex.conf     | 28 ++++++++++++++++++++++++++++
 obexd/src/obexd.h       |  3 +++
 14 files changed, 90 insertions(+), 9 deletions(-)
 create mode 100644 obexd/src/obex.conf

diff --git a/Makefile.am b/Makefile.am
index f639f7f8b..297d0774c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -39,6 +39,10 @@ if DATAFILES
 dbusdir = $(DBUS_CONFDIR)/dbus-1/system.d
 dbus_DATA = src/bluetooth.conf
 
+if OBEX
+dbus_DATA += obexd/src/obex.conf
+endif
+
 conf_DATA = src/main.conf
 conf_DATA += profiles/input/input.conf
 conf_DATA += profiles/network/network.conf
@@ -421,7 +425,7 @@ manual_pages += doc/org.bluez.obex.Client.5 doc/org.bluez.obex.Session.5 \
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
-			profiles/input/input.conf
+			profiles/input/input.conf obexd/src/obex.conf
 
 test_scripts =
 unit_tests =
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index d7be17661..8e0d9c1ea 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -40,6 +40,11 @@ DBusConnection *g_dbus_setup_bus(DBusBusType type, const char *name,
 DBusConnection *g_dbus_setup_private(DBusBusType type, const char *name,
 							DBusError *error);
 
+DBusConnection *get_dbus_connection(gboolean bus_type);
+
+DBusConnection *setup_dbus_connection(gboolean bus_type, const char *name,
+							DBusError *error);
+
 gboolean g_dbus_request_name(DBusConnection *connection, const char *name,
 							DBusError *error);
 
diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
index a04ebb19b..7bf691191 100644
--- a/gdbus/mainloop.c
+++ b/gdbus/mainloop.c
@@ -293,6 +293,31 @@ DBusConnection *g_dbus_setup_bus(DBusBusType type, const char *name,
 	return conn;
 }
 
+DBusConnection *get_dbus_connection(gboolean bus_type)
+{
+	DBusConnection *conn = NULL;
+
+	if (bus_type)
+		conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	else
+		conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+
+	return conn;
+}
+
+DBusConnection *setup_dbus_connection(gboolean bus_type, const char *name,
+							DBusError *error)
+{
+	DBusConnection *conn = NULL;
+
+	if (bus_type)
+		conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, name, error);
+	else
+		conn = g_dbus_setup_bus(DBUS_BUS_SESSION, name, error);
+
+	return conn;
+}
+
 DBusConnection *g_dbus_setup_private(DBusBusType type, const char *name,
 							DBusError *error)
 {
diff --git a/obexd/client/ftp.c b/obexd/client/ftp.c
index 160e0636a..31fcd42fb 100644
--- a/obexd/client/ftp.c
+++ b/obexd/client/ftp.c
@@ -19,6 +19,7 @@
 #include "gdbus/gdbus.h"
 
 #include "obexd/src/log.h"
+#include "obexd/src/obexd.h"
 #include "transfer.h"
 #include "session.h"
 #include "driver.h"
@@ -463,7 +464,7 @@ int ftp_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	conn = get_dbus_connection(obex_option_system_bus());
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/client/map.c b/obexd/client/map.c
index 513dcaf14..2732eb7df 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -27,6 +27,7 @@
 #include "gdbus/gdbus.h"
 
 #include "obexd/src/log.h"
+#include "obexd/src/obexd.h"
 #include "obexd/src/map_ap.h"
 #include "map-event.h"
 
@@ -2063,7 +2064,7 @@ int map_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	conn = get_dbus_connection(obex_option_system_bus());
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/client/opp.c b/obexd/client/opp.c
index 90d0c0c8e..13c49d12f 100644
--- a/obexd/client/opp.c
+++ b/obexd/client/opp.c
@@ -17,6 +17,7 @@
 #include "gdbus/gdbus.h"
 
 #include "obexd/src/log.h"
+#include "obexd/src/obexd.h"
 
 #include "transfer.h"
 #include "session.h"
@@ -178,7 +179,7 @@ int opp_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	conn = get_dbus_connection(obex_option_system_bus());
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 2d2aa9508..5280cbac5 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -27,6 +27,7 @@
 #include "gdbus/gdbus.h"
 
 #include "obexd/src/log.h"
+#include "obexd/src/obexd.h"
 
 #include "transfer.h"
 #include "session.h"
@@ -1303,7 +1304,7 @@ int pbap_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	conn = get_dbus_connection(obex_option_system_bus());
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 13a834e14..3460690dd 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -27,6 +27,7 @@
 #include "gobex/gobex.h"
 
 #include "obexd/src/log.h"
+#include "obexd/src/obexd.h"
 #include "transfer.h"
 #include "session.h"
 #include "driver.h"
@@ -591,7 +592,7 @@ struct obc_session *obc_session_create(const char *source,
 	if (driver == NULL)
 		return NULL;
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	conn = get_dbus_connection(obex_option_system_bus());
 	if (conn == NULL)
 		return NULL;
 
diff --git a/obexd/client/sync.c b/obexd/client/sync.c
index 92faf4434..0283d9729 100644
--- a/obexd/client/sync.c
+++ b/obexd/client/sync.c
@@ -21,6 +21,7 @@
 #include "gdbus/gdbus.h"
 
 #include "obexd/src/log.h"
+#include "obexd/src/obexd.h"
 
 #include "transfer.h"
 #include "session.h"
@@ -224,7 +225,7 @@ int sync_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	conn = get_dbus_connection(obex_option_system_bus());
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/plugins/pcsuite.c b/obexd/plugins/pcsuite.c
index 07c444ff2..06aca7366 100644
--- a/obexd/plugins/pcsuite.c
+++ b/obexd/plugins/pcsuite.c
@@ -322,7 +322,7 @@ static gboolean send_backup_dbus_message(const char *oper,
 
 	file_size = size ? *size : 0;
 
-	conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
+	conn = setup_dbus_connection(obex_option_system_bus(), NULL, NULL);
 
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
index 3c0c2a7cc..dff2e3783 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -488,7 +488,9 @@ gboolean manager_init(void)
 
 	dbus_error_init(&err);
 
-	connection = g_dbus_setup_bus(DBUS_BUS_SESSION, OBEXD_SERVICE, &err);
+	connection =
+		setup_dbus_connection(obex_option_system_bus(),
+							OBEXD_SERVICE, &err);
 	if (connection == NULL) {
 		if (dbus_error_is_set(&err) == TRUE) {
 			fprintf(stderr, "%s\n", err.message);
diff --git a/obexd/src/obex.conf b/obexd/src/obex.conf
new file mode 100644
index 000000000..114bdb882
--- /dev/null
+++ b/obexd/src/obex.conf
@@ -0,0 +1,28 @@
+<!-- This configuration file specifies the required security policies
+     for Bluetooth core daemon to work. -->
+
+<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
+ "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
+<busconfig>
+
+  <!-- ../system.conf have denied everything, so we just punch some holes -->
+
+  <policy user="root">
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
+  </policy>
+
+  <policy context="default">
+    <allow send_destination="org.bluez.obex"/>
+  </policy>
+
+</busconfig>
diff --git a/obexd/src/obexd.h b/obexd/src/obexd.h
index af5265da5..72b04b993 100644
--- a/obexd/src/obexd.h
+++ b/obexd/src/obexd.h
@@ -8,6 +8,8 @@
  *
  */
 
+#include "gdbus/gdbus.h"
+
 #define OBEX_OPP	(1 << 1)
 #define OBEX_FTP	(1 << 2)
 #define OBEX_BIP	(1 << 3)
@@ -28,3 +30,4 @@ gboolean obex_option_auto_accept(void);
 const char *obex_option_root_folder(void);
 gboolean obex_option_symlinks(void);
 const char *obex_option_capability(void);
+gboolean obex_option_system_bus(void);
-- 
2.34.1

