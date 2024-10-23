Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1A1369AE
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729664259; cv=none; b=tlvczHRcuMYCcoq2sCRoy//TWAykw1WHFg8jTCtuI/dFU/FeLr+sghRRUbjTTKf37WEcb5d8n/Gj5Yq2lCFU4QzYWfE/plX7zEAXHcIWVQXHHmSSw39jjIw+Gb2sdG+4uwdfhytKEJrc6ANTTtmmu/DTe8369UBNsqt8Sb1zPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729664259; c=relaxed/simple;
	bh=xt3iYkEPk360n8LPmol0KfpvmqIkPlRzHC/4Fxlm8cg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdGEW9GnmcnfbP8wCj2a+ceHy5au3V0bB3fM7KSh93+cetSUBqUDttw2S8jNJtvAMFws5LYnFw5T5GcnfAA8609+c1FCB4a/DFeetT1XSyiqIJgx/NIqEGklYDkv0bSHmfFX7WvlXPlmeygp1h1GJ15oCO4K/4d9D5qQjv8sMxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V8gJ8BEZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V8gJ8BEZ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLa3VX025435
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 06:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YGQ3yJfyLayzblnabYbsD+
	sHKiu3ffw6+D/CuBhyVvk=; b=V8gJ8BEZqcnJz2HZu+8DdaLernTVeXeKF1O7EF
	4FRamXUTvmNRLs9VDv1pSYYsPOMRKo7gA43ARE8BTVtEwBANw6tjvDxQoGmMxqT/
	wuYqyUznPK9nQsOdL8klRcKgr3J9TwD30AjABU3Cp4/vUTn4cbIZ81EHmNHLqTCP
	HxC0yh7CLHvaBdzypQ1WIpyJGv3GNNzCxRTBGVEwrFKOXqvPmkBv/aUedr5bTQf/
	nizbjFwcoq5l6+qRvMERJuSFKhYRIxlXM45md5QPoREZt/nUOwaJXgNHBVnQtqgm
	LLYrlJZJ3uNks4s13m58Swe2oPUKOS8+iRQLl5hqll+GxiPA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em4092pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 06:17:36 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49N6HZTk007766
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 06:17:35 GMT
Received: from hu-dgangire-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 23:17:33 -0700
From: <quic_dgangire@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ v1] obexd: Add system bus support for obexd
Date: Wed, 23 Oct 2024 11:45:18 +0530
Message-ID: <20241023061518.535790-1-quic_dgangire@quicinc.com>
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
X-Proofpoint-ORIG-GUID: A7nR9vjW0afbSOcSbwz6ivmZFtV_qOBp
X-Proofpoint-GUID: A7nR9vjW0afbSOcSbwz6ivmZFtV_qOBp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1011 malwarescore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230035

From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>

Currently obexd uses session bus.
Distros  where session bus is not supported and still obex profiles
are required in that case use system bus instead of session bus
which can be configured with new optional feature

Additional optional feature has been added to achieve this
with name --enable-use-systembus-for-obexd

steps to configure system bus
./configure --enable-use-systembus-for-obexd

---
 Makefile.obexd          | 14 ++++++++++++++
 configure.ac            |  9 +++++++++
 obexd/client/ftp.c      |  3 ++-
 obexd/client/map.c      |  3 ++-
 obexd/client/opp.c      |  3 ++-
 obexd/client/pbap.c     |  3 ++-
 obexd/client/session.c  |  3 ++-
 obexd/client/sync.c     |  3 ++-
 obexd/plugins/pcsuite.c |  3 ++-
 obexd/src/manager.c     |  3 ++-
 src/bluetooth.conf      | 12 ++++++++++++
 tools/obexctl.c         |  3 ++-
 12 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 74dd977a0..cab872413 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -2,6 +2,19 @@
 if OBEX
 
 if SYSTEMD
+
+if USE_SYSTEMBUS_FOR_OBEXD
+
+systemdsystemunit_DATA += obexd/src/obex.service
+dbussystembus_DATA += obexd/src/org.bluez.obex.service
+
+obexd-add-service-symlink:
+	$(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-org.bluez.obex.service
+
+obexd-remove-service-symlink:
+	rm -f $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-org.bluez.obex.service
+else
+
 systemduserunit_DATA += obexd/src/obex.service
 
 dbussessionbusdir = $(DBUS_SESSIONBUSDIR)
@@ -12,6 +25,7 @@ obexd-add-service-symlink:
 
 obexd-remove-service-symlink:
 	rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
+endif
 else
 obexd-add-service-symlink:
 obexd-remove-service-symlink:
diff --git a/configure.ac b/configure.ac
index 7093e41ff..181ba0e10 100644
--- a/configure.ac
+++ b/configure.ac
@@ -292,6 +292,15 @@ if (test "${enable_obex}" != "no"); then
 fi
 AM_CONDITIONAL(OBEX, test "${enable_obex}" != "no")
 
+AC_ARG_ENABLE(use-systembus-for-obexd, AS_HELP_STRING([--enable-use-systembus-for-obexd],
+		[enable systembus for obexd]), [enable_use_systembus_for_obexd=${enableval}])
+AM_CONDITIONAL(USE_SYSTEMBUS_FOR_OBEXD, test "${enable_use_systembus_for_obexd}" = "yes")
+if (test "${enable_use_systembus_for_obexd}" = "yes"); then
+	AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 1, [Define to 1 if you want to use system bus for obexd.])
+else
+	AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 0, [Define to 0 if you want to use session bus for obexd.])
+fi
+
 AC_ARG_ENABLE(btpclient, AS_HELP_STRING([--enable-btpclient],
 		[enable BTP client]), [enable_btpclient=${enableval}])
 AM_CONDITIONAL(BTPCLIENT, test "${enable_btpclient}" = "yes")
diff --git a/obexd/client/ftp.c b/obexd/client/ftp.c
index 160e0636a..e3cef32f6 100644
--- a/obexd/client/ftp.c
+++ b/obexd/client/ftp.c
@@ -463,7 +463,8 @@ int ftp_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	conn = dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
+			DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/client/map.c b/obexd/client/map.c
index 513dcaf14..815806f52 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -2063,7 +2063,8 @@ int map_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	conn = dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
+			DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/client/opp.c b/obexd/client/opp.c
index 90d0c0c8e..4889a3a0f 100644
--- a/obexd/client/opp.c
+++ b/obexd/client/opp.c
@@ -178,7 +178,8 @@ int opp_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	conn = dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
+			DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 2d2aa9508..1658c853a 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -1303,7 +1303,8 @@ int pbap_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	conn = dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
+			DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 13a834e14..b86f476fd 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -591,7 +591,8 @@ struct obc_session *obc_session_create(const char *source,
 	if (driver == NULL)
 		return NULL;
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	conn = dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
+			DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
 	if (conn == NULL)
 		return NULL;
 
diff --git a/obexd/client/sync.c b/obexd/client/sync.c
index 92faf4434..bd339adfa 100644
--- a/obexd/client/sync.c
+++ b/obexd/client/sync.c
@@ -224,7 +224,8 @@ int sync_init(void)
 
 	DBG("");
 
-	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	conn = dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
+			DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
 	if (!conn)
 		return -EIO;
 
diff --git a/obexd/plugins/pcsuite.c b/obexd/plugins/pcsuite.c
index 07c444ff2..5daed2abb 100644
--- a/obexd/plugins/pcsuite.c
+++ b/obexd/plugins/pcsuite.c
@@ -322,7 +322,8 @@ static gboolean send_backup_dbus_message(const char *oper,
 
 	file_size = size ? *size : 0;
 
-	conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
+	conn = g_dbus_setup_bus(USE_SYSTEMBUS_FOR_OBEXD ?
+			DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL, NULL);
 
 	if (conn == NULL)
 		return FALSE;
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 3c0c2a7cc..dd83f056d 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -488,7 +488,8 @@ gboolean manager_init(void)
 
 	dbus_error_init(&err);
 
-	connection = g_dbus_setup_bus(DBUS_BUS_SESSION, OBEXD_SERVICE, &err);
+	connection = g_dbus_setup_bus(USE_SYSTEMBUS_FOR_OBEXD ?
+		DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, OBEXD_SERVICE, &err);
 	if (connection == NULL) {
 		if (dbus_error_is_set(&err) == TRUE) {
 			fprintf(stderr, "%s\n", err.message);
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
diff --git a/tools/obexctl.c b/tools/obexctl.c
index a398b095b..44b8b4d53 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -2158,7 +2158,8 @@ int main(int argc, char *argv[])
 	bt_shell_set_menu(&main_menu);
 	bt_shell_set_prompt(PROMPT, NULL);
 
-	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
+	dbus_conn = g_dbus_setup_bus(USE_SYSTEMBUS_FOR_OBEXD ?
+				DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL, NULL);
 
 	client = g_dbus_client_new(dbus_conn, "org.bluez.obex",
 							"/org/bluez/obex");
-- 
2.34.1

