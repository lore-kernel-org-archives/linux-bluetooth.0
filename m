Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C3B4B5CA2
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860762; cv=none; b=Y54yacdMgj/THvuJg3mPWpgHGm6n0N+P2W+iX6hr+VJHUWpfaOT9H1Z2wm1gizJ1WVbs21foyq2h9kFyyO4bJlF+fEhXm/u7Mhk9gN3B3WgMiyWiw1lyUu3NvznZTV5epl2lcsNKJ9RCf+8z//PQNJ9ibwJRnD3tYCNdYUSWuoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860762; c=relaxed/simple;
	bh=cNNbovdkB10uQKEBlswGCp5RJqCDdFro41kg1sL3fF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5iRxuaUWSv3XFMcAvlZqt8OUrJ7qbDutDl/jRAKX6mD2t9FFn1AabaR6jS7Lsxlg8OyM+VxJ8p2lDhP1LV5YWi932AVK1qR008yMD9kOonBwpc+Oij34HZtxNyG6ry3qgKNGsgHYF9+ALQu6/eUlH/zDhm874WVRIxPOtFLhAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dGf/a5pu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGf/a5pu"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691CTRiO2806225
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=MDBIx/9NzqB
	T2CSUbpX8AipUyeZZWnFzMmoOecGOWLE=; b=dGf/a5puCAc5sFsl/WHGau7P8Mp
	tK3x5XooxuxhvCfNnXYYGUxPDv1dM9eIKgjeYUJR5RwrMMwDeeRIbPFc1zlJfOFS
	6y8OPG8KmRfeW0ZUq0yHUFpUGFgGZfvZycqFotVJAwEuRpNKaxQZ46Dvdf1q3YU6
	xHJsdE74clG94U6ZM0Etj3OTBx8Ewb4beR1feryiyFscol/1ufyZ8ZxeWicookrU
	BUe4cynwZ9UnjVKE+k4GlVssUz0iz30Dvp2SkIkyXTeyKzqyYd1JtWrfcrTol5tX
	pr0e6UyQL6jPHuou5D+4XGtbUFGjhqtJBe8fybkXwilA46zwS0qoum+q4eA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1hvkhujm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 13:19:16 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 691DJEtD2496320
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:15 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 691DJELQ2496336
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 13:19:15 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 1CF8949BCA; Thu,  1 Oct 2026 21:19:13 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH 09/11] client: Add Channel Sounding ranging data mode control
Date: Thu,  1 Oct 2026 21:18:55 +0800
Message-ID: <20261001131900.707485-10-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001131900.707485-1-cheng.jiang@oss.qualcomm.com>
References: <20261001131900.707485-1-cheng.jiang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX7WXq8TrePGft
 3pa786uYjFuyYpsRh7A9yrGokTdMiSknReseSli3cBE9Lz5U647VriaOQT4oARQewReNet9t1iH
 GFTHElcsF7Px89OvvdPzufdme6QwP/Q=
X-Proofpoint-ORIG-GUID: 9PG5fGkXlSsfKwUB1Ej9e0wq-Fx7jb6E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX+sml5OQ6PbcL
 b4YvGfqpALTu2EOuOXW+bw8Acu7QsNL/gCRNu/m3yY9PrtAlGQ8K0+nxG2jm9W5HLYy1n8mg3Ez
 AQZZSS+R3iB4yGI8kvxOaiwwRLFVC92IQLGIPCKjR1CHovwWS5ft3QDWixjnMpXg7M0YaFYdWWv
 dU8KPZWwSDQC/yxIzbWe7h8eghtubT33MuWNhA4i3z3Td4Vwg9ELuspDV/qThO3ivKXtbZEsK4D
 TIDPfBhGC67zuDIkhJd7TzR9dweVjk0iT2v6B7c8DNQBWVWGImpmU1rK1usNapOQGKhLCSjg+MO
 8yQu3VFWDDWJdt2rz8gfuzk51iJOHY18cCKwi61tCZ8ugDLAJm+xpaXJIdA6D77i42unSWghrV5
 yPeDIbMGWTtltCimc+IzhMZys2B3QGDa0ACIfkUdq8nqzkGFIQnrovxJ8oL2WhZO5Gnm5nbjOz2
 OvO8WAtf93QosVc84JA==
X-Authority-Analysis: v=2.4 cv=IY8Symqa c=1 sm=1 tr=0 ts=6abe5dd5 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=Wa6Tw3IEVIx-cRDSnNoA:9
X-Proofpoint-GUID: 9PG5fGkXlSsfKwUB1Ej9e0wq-Fx7jb6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010053

Add a "ranging-data-mode" command to the Channel Sounding submenu that
selects how Ranging Data is received from a peer (disabled, real-time or
on-demand) and the CCCD transport (notify or indicate), invoking the
ChannelSounding1.SetRangingDataMode method on the device.

Add an advertising helper so the Responder can advertise the Ranging
Service UUID for discovery, together with a getter for the default
LEAdvertisingManager proxy it needs.

Assisted-by: Claude:claude-opus-4.8
---
 client/cs.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/client/cs.c b/client/cs.c
index 7533d053b..5d9f6ca31 100644
--- a/client/cs.c
+++ b/client/cs.c
@@ -1429,6 +1429,85 @@ static void cmd_cs_stop(int argc, char *argv[])
 		bt_shell_printf("Failed to send StopMeasurement\n");
 }
 
+/* ---- ranging-data-mode ---- */
+
+static void ranging_data_mode_setup(DBusMessageIter *iter, void *user_data)
+{
+	uint16_t values = PTR_TO_UINT(user_data);
+	uint8_t mode = values & 0xff;
+	uint8_t transport = values >> 8;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &mode);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &transport);
+}
+
+static void ranging_data_mode_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+	if (dbus_set_error_from_message(&error, message)) {
+		bt_shell_printf("SetRangingDataMode failed: %s\n", error.message);
+		dbus_error_free(&error);
+		return;
+	}
+
+	bt_shell_printf("Ranging Data mode updated\n");
+}
+
+static void cmd_cs_ranging_data_mode(int argc, char *argv[])
+{
+	const char *dev_path;
+	GDBusProxy *proxy;
+	uint8_t mode;
+	uint8_t transport = 0x01;
+
+	if (argc < 3 || argc > 4) {
+		bt_shell_printf("Usage: ranging-data-mode <dev_addr>"
+				" <disabled/realtime/ondemand> [notify/indicate]\n");
+		return;
+	}
+
+	if (!strcmp(argv[2], "disabled"))
+		mode = 0x00;
+	else if (!strcmp(argv[2], "realtime"))
+		mode = 0x01;
+	else if (!strcmp(argv[2], "ondemand"))
+		mode = 0x02;
+	else {
+		bt_shell_printf("Invalid Ranging Data mode: %s\n", argv[2]);
+		return;
+	}
+
+	if (argc == 4) {
+		if (!strcmp(argv[3], "notify"))
+			transport = 0x01;
+		else if (!strcmp(argv[3], "indicate"))
+			transport = 0x02;
+		else {
+			bt_shell_printf("Invalid Ranging Data transport: %s\n", argv[3]);
+			return;
+		}
+	}
+
+	dev_path = cs_resolve_address(argv[1]);
+	if (!dev_path) {
+		bt_shell_printf("Device %s not found\n", argv[1]);
+		return;
+	}
+
+	proxy = cs_find_proxy(dev_path);
+	if (!proxy) {
+		bt_shell_printf("No ChannelSounding1 interface for that device\n");
+		return;
+	}
+
+	if (!g_dbus_proxy_method_call(proxy, "SetRangingDataMode",
+				ranging_data_mode_setup, ranging_data_mode_reply,
+				UINT_TO_PTR(mode | (transport << 8)), NULL))
+		bt_shell_printf("Failed to send SetRangingDataMode\n");
+}
+
 /* ---- show ---- */
 
 static void cmd_cs_show(int argc, char *argv[])
@@ -1545,6 +1624,9 @@ static const struct bt_shell_menu cs_menu = {
 				cmd_cs_stop,
 				"Stop the active distance measurement;"
 				" address required when multiple are active" },
+	{ "ranging-data-mode", "<dev_addr> <disabled/realtime/ondemand> [notify/indicate]",
+				cmd_cs_ranging_data_mode,
+				"Set RAP Requester Ranging Data subscription mode" },
 	{ "show",   NULL,
 				cmd_cs_show,
 				"Show active session id and current"
-- 
2.43.0

