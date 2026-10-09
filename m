Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E97495ADB
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537940; cv=none; b=dsAP1lRdC8+yIGZihcNKwXZQ6mkQ0pHDKFO0uzQXwq5a+9xWAPdddjONkHw7KoQTRLOL/RcbhWJh9jS1hUkc4TycOh//N9xtDRZVsm0fZzGyy7n99rM96C805AZ9UHJ9uKdTtmS7gmGYFxP5wkWzNkhIGqjWZKLnosLKJvaGSWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537940; c=relaxed/simple;
	bh=Z7XPLW5Ib2h5/UrxXfMz9VRySiZHH2osOxtZeb55ghU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ee2fnP+312WLKeQ9Re8byManRdUAIMen6TgZHPf3CBAaxci+yMEnZl4bRaYowDcRE4h/5yPCYR8WU7/dmukw99Y+cyKgNYkgcOP8flgY/LxGi+LTH8drv8DATgnjjxKXtZqao8AsDbtQKdo/qA9bZzvEA4SexrI3cVKmE0gsjUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MEq3yOwt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MEq3yOwt"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KOeb3977805
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=SIFqwKQ6VMX
	Fxx0hLuRtQqLFDRpEalworh2sY9wi6G8=; b=MEq3yOwtrecGW4OE8LZFbfVhBnZ
	GyRA7xLIOlARD3zV+ZKqRQRtGjNbaO3b+o7usEUd9kXlX7UvdLLRkvKwiMvh+JY3
	3hl+2IuWqsIiCswsjPWWT7s8WAUzxBRX51OfxeoAk9g7u/7qL0uEWGlv7BxEXZwH
	RFMzvlReYP4B1qotnOKLpYZlGyg/U4gw9K/dfmA2IvHIgiLd4HWVOLBJHmv5ZM0g
	2S1UTaX2zkNTz0pZSn6fMi9qM/241RH/w4pXHc6VSUFzT8v6UJDhVKj9SJ/P97VR
	gnlvfod8yyikqXdyLTl/aBSCaFFs27l6j5vR6F/QXUSzch5LsjEpJS5RE1Q==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ev5b5ge-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 09:25:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999PYCY3497409
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:35 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6999PZho3497437
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:25:35 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 93F7C49BE5; Fri,  9 Oct 2026 17:25:33 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH v2 12/14] client: Add Channel Sounding ranging data mode control
Date: Fri,  9 Oct 2026 17:25:28 +0800
Message-ID: <20261009092532.3600749-13-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009092532.3600749-1-cheng.jiang@oss.qualcomm.com>
References: <20261009092532.3600749-1-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX4tQfyCdEMzz1
 NUQSJ0OxZ1B5ogSrliwnnnzk4y0WzMehN1WdhuNJFPnTi6CeO3ijOe9XUvvIL/jiBgO0lhz32da
 5384+tek5Jq72oHxdRIf+47s7TxB45c=
X-Authority-Analysis: v=2.4 cv=MMT1C8Zl c=1 sm=1 tr=0 ts=6ac8b311 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Wa6Tw3IEVIx-cRDSnNoA:9
X-Proofpoint-GUID: z_GGwp88XKoHYWn0AR-mLnH_sNZM_SpI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX+KXrvGpg7xef
 ueJJrSeqLrsmzb+SVSmYvyvZdDdvZAYvr5daYbPLbSkySvH8CBVmC9Tzml8QvMphbaSSQ70S8CI
 +7COEa3niBgRTkYm0Aqtq2pfg9+1qY7hx7qYmpdXryG+bZotLDfQmRrj5K0bEJ1dmfDJex47ZX+
 xo3/cVBCoi7t6sxf2KxAkA2y9iM82V1jTO+4sezKFD25Fczlex9bEZPx3bRsJn2w85nD4rYyme4
 286VLS8Y61gmA3uin0/6NS9D/sGrV6Oq0bekFUZK78dFPvKzisx/O/AAqHHCMHYUH0M+kZ/FJ78
 vlU1QnBWwSd3hZwhwG0ek3J9OjLWDF6jtAzdg6OYFsFGmX0QlQx1WLhpqsc8LkKeCT+LWQPCuWq
 Y83rjkv/+yutUWfMRJO7VU4txa/E5x621RD4w037e8jLmtMsZxPqy0SLryy1UMGZt5KFtvlTqdo
 8qEWnGyI34X/YLyNdWw==
X-Proofpoint-ORIG-GUID: z_GGwp88XKoHYWn0AR-mLnH_sNZM_SpI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090037

Add a "ranging-data-mode" command to the Channel Sounding submenu that
selects how Ranging Data is received from a peer (disabled, real-time or
on-demand) and the CCCD transport (notify or indicate), invoking the
ChannelSounding1.SetRangingDataMode method on the device.

Add an advertising helper so the Responder can advertise the Ranging
Service UUID for discovery, together with a getter for the default
LEAdvertisingManager proxy it needs.

Assisted-by: Claude:claude-opus-4.8
---
 client/cs.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/client/cs.c b/client/cs.c
index 7533d053b..4c181e743 100644
--- a/client/cs.c
+++ b/client/cs.c
@@ -1429,6 +1429,89 @@ static void cmd_cs_stop(int argc, char *argv[])
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
+		bt_shell_printf("SetRangingDataMode failed: %s\n",
+							error.message);
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
+			bt_shell_printf("Invalid Ranging Data transport: "
+							"%s\n", argv[3]);
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
+		bt_shell_printf("No ChannelSounding1 interface for that "
+								"device\n");
+		return;
+	}
+
+	if (!g_dbus_proxy_method_call(proxy, "SetRangingDataMode",
+				ranging_data_mode_setup,
+				ranging_data_mode_reply,
+				UINT_TO_PTR(mode | (transport << 8)), NULL))
+		bt_shell_printf("Failed to send SetRangingDataMode\n");
+}
+
 /* ---- show ---- */
 
 static void cmd_cs_show(int argc, char *argv[])
@@ -1545,6 +1628,10 @@ static const struct bt_shell_menu cs_menu = {
 				cmd_cs_stop,
 				"Stop the active distance measurement;"
 				" address required when multiple are active" },
+	{ "ranging-data-mode",
+		"<dev_addr> <disabled/realtime/ondemand> [notify/indicate]",
+		cmd_cs_ranging_data_mode,
+		"Set RAP Requester Ranging Data subscription mode" },
 	{ "show",   NULL,
 				cmd_cs_show,
 				"Show active session id and current"
-- 
2.43.0

