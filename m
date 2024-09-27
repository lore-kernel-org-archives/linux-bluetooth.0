Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891018CC05
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727442896; cv=none; b=OFoNF8OWe+jrzp8bxJOhvFDuCnqWtuhHM6ajErGYU1m5ykD6t/Cm/ccIPiKkHNDzfwT0pvyNpKcCcWmR1lndAzLRL4fn6eCA26wI0uIqMWFwPO0kCRDPTRr6sRGfGA8mYPGKAfJdB/iQLf2CGA5HBmQWu8cq9QGWiNO9wqGENOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727442896; c=relaxed/simple;
	bh=G7DxccKDULDMxM4oUZDFRmbE/NzW6JbLzRBZXax8Rj8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dmn1FFKA0ALuDpFBDCALPHRYVhIaa9nr65z+y0cadTKg/f/GKj8MeI4jnmjaexyZxU51eCoNbU8B0FzLTBTIvNfiK1EcMTFuPpMPWApiNLf8ZtHz4xTglGBO5GG7YoI89BxyGLMUqngA/j5j+zStNrpbGdnqQQJA2O6h8zlzrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ShU0naEC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ShU0naEC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R6d55g002680
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 13:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uLClt10qrY5TSvLIqLiTQI
	zz1ghUhG28on6nMNHh0bM=; b=ShU0naECvZCpYW36z7x980ed+n8Lw+JKgZmvgw
	gkyFE/oHAWhQgAnzfgSYecJsnpLwWjLaSCz+34bjqfdLzrH0snhrgXfdjHQkYfsc
	5InqPmmV8w5+XMr/N5B4L1cu46qLGRc5/VDUGJEfS1rPYsvJCLq727lbEoXt9Ak6
	xT/B9j/m+qNq3JFH8KSj0cgYXZRHfUNnBF1sbhcpHpcp4HVJUwpdHsScVHEgTE19
	wCJaIo/KoF77LFcAAxX2QtcqH1C3SPJ3nkbKiY42hhyO2k8vfwQe+xNG6timbwds
	ahZpL+b2y7+SbaGFT2p23kL+6S+1utvX8IYSVdWvGZpIpBpg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sph73bqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 13:14:54 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48RDEqav031267
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 13:14:52 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 27 Sep 2024 06:14:51 -0700
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_jiaymao@quicinc.com>
Subject: [PATCH v1] Client: Fix the list_attributes command returning nothing for a dual-mode remote
Date: Fri, 27 Sep 2024 21:14:41 +0800
Message-ID: <20240927131441.2617450-1-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: auQeeYKk9A6Cjjswz8jaKnfyfSbcMYjX
X-Proofpoint-ORIG-GUID: auQeeYKk9A6Cjjswz8jaKnfyfSbcMYjX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=872
 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270095

When a dual-mode device is paired first on BR/EDR and
then on BLE through RPA, the RPA changes to a public
address after receiving the IRK. This results in two proxies
in default_ctrl->devices with the same public address.
In cmd_list_attributes, if the BR/EDR proxy is found first,
it prints no attributes.

Modify cmd_list_attributes to search all proxies in
default_ctrl->devices and display the related attributes.
---
 client/main.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/client/main.c b/client/main.c
index 50aa3e7a6..17c1fb278 100644
--- a/client/main.c
+++ b/client/main.c
@@ -768,6 +768,29 @@ static GDBusProxy *find_proxy_by_address(GList *source, const char *address)
 	return NULL;
 }
 
+static GList *find_all_proxy_by_address(GList *source, const char *address)
+{
+	GList *list;
+	GList *all_proxy = NULL;
+
+	for (list = g_list_first(source); list; list = g_list_next(list)) {
+		GDBusProxy *proxy = list->data;
+		DBusMessageIter iter;
+		const char *str;
+
+		if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
+			continue;
+
+		dbus_message_iter_get_basic(&iter, &str);
+
+		if (!strcasecmp(str, address))
+			all_proxy = g_list_append(all_proxy, proxy);
+	}
+
+	return all_proxy;
+}
+
+
 static gboolean check_default_ctrl(void)
 {
 	if (!default_ctrl) {
@@ -2051,7 +2074,9 @@ static void cmd_disconn(int argc, char *argv[])
 
 static void cmd_list_attributes(int argc, char *argv[])
 {
-	GDBusProxy *proxy;
+	GList *all_proxy = NULL;
+	GList *list;
+	GDBusProxy *proxy = NULL;
 	const char *path;
 
 	if (argc > 1 && !strcmp(argv[1], "local")) {
@@ -2059,11 +2084,33 @@ static void cmd_list_attributes(int argc, char *argv[])
 		goto done;
 	}
 
-	proxy = find_device(argc, argv);
-	if (!proxy)
+	if (argc < 2 || !strlen(argv[1])) {
+		if (default_dev) {
+			proxy = default_dev;
+			path = g_dbus_proxy_get_path(proxy);
+			goto done;
+		}
+		bt_shell_printf("Missing device address argument\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	} else {
+		if (check_default_ctrl() == FALSE)
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
-	path = g_dbus_proxy_get_path(proxy);
+		all_proxy = find_all_proxy_by_address(default_ctrl->devices,
+								argv[1]);
+		if (!all_proxy) {
+			bt_shell_printf("Device %s not available\n", argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+		for (list = g_list_first(all_proxy); list;
+						list = g_list_next(list)) {
+			proxy = list->data;
+			path = g_dbus_proxy_get_path(proxy);
+			gatt_list_attributes(path);
+		}
+		g_list_free(all_proxy);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
 
 done:
 	gatt_list_attributes(path);
-- 
2.25.1

