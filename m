Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733934B95CD
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860762; cv=none; b=tUd1BsPfkMF9hyMuAgM+sd2W6EyNSP+B9FlzhuYweBG7miIQExT7OuHBDQu0d+y+MCAaHe0TU2A2fEx3oAxJn6kgazgojARFu14rCd+F30PZdkEI++TXI8nQEdzoeDBtwW4YxMk4mY3Nku78s+dab9eb0Xn8+QCD6ErgN8byBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860762; c=relaxed/simple;
	bh=QLZpMXqRpMgX68eyp81Zzu3f2ZWY3uFlSbd1DEF3WV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuK1lnZ+hLjhq9RQlcOemxs8CPapiDY8FOaEh0H68bwZ7PM5SQb8mIhdfSvPIsv2gWCozxWe1FalSPk0HxlLoRqsng7Y3vDzs1wmJL8G3AiRqqIvt/Os4IS/E22OQKxAuTP5+ijWMNpzwDwGJCG2CN/hMUVUltBz31wh5ch1Z24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k4EMFyJu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k4EMFyJu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DAXpS1933065
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Oo0f4oc1OrY
	MvpzyV3CZ2ITxGXpVQK1Tiiir0LmTBZ0=; b=k4EMFyJuQtW/0eHnRdi41uJuYhJ
	O3nUFVd6jQHo3GOGHLKMEu2ZCnhUeTwhymK6DO/eP3UQ1+HZ4KO8Y84K4f5bG4UW
	P9Ef8OAEd3HyDdmpW+4WFD0vdl6tX05+0yL9OsQWKy2lHB6oX1cFy+y/519f1yTj
	RqB4sr9SguXco0RltJEbxDsJ5A/g0KjIBaWMircFhr9iQ5r/fJ9BoyhbQlokUh6P
	B3As37AgQdBIZYq0XN+hrYx89uq/OljtlS3y/twBQI183pvVzHeRjre1TKUEdG6t
	25vODoEtBLb1LKQVrpIWGXqvDxbnLL7Y+Z1o3WDjW7HpXgkVxVNyRQPHQAw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1jcfspr2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 13:19:17 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 691DJFV92501486;
	Thu, 1 Oct 2026 13:19:15 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 691DJEYL2501474
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 13:19:15 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 192AA49BC9; Thu,  1 Oct 2026 21:19:13 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH 08/11] profiles/ranging: Expose requester ranging data mode over D-Bus
Date: Thu,  1 Oct 2026 21:18:54 +0800
Message-ID: <20261001131900.707485-9-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX9Kk049Iz4yjZ
 E26wihRxoEKI3KCOSjJsdugaIs71p7j5izgquzGhUVmMs9iSLNI1u1mHlqukuZ12DyPAoT8CGDe
 Z6kViA4o6jTaoevghVkjEp1Q8lvzZCw=
X-Proofpoint-GUID: u1Qbnhro0kzMscpCwaSXcl92b3_Emq6s
X-Authority-Analysis: v=2.4 cv=b4YncdGx c=1 sm=1 tr=0 ts=6abe5dd5 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=WwGtstz2p8n0CXtVlhQA:9
X-Proofpoint-ORIG-GUID: u1Qbnhro0kzMscpCwaSXcl92b3_Emq6s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX7uFdBAz4uvQQ
 SRiSqAigKnP0wfKFCsOL3gVtkb0EuUVaP+SM+vroHyQQOTXgjJ/3x+A9ZBqLmqrgTSUr4l8LyAx
 G1rRMi4cf7v/UtBHySOHdhhbf9ExPE7QRthvQ79V3+R8HDX5iCEld+1id7nN41zeDP0PZBqEbcu
 Uhwn05wsoNMySvmqxfA+Hrk1l9P6gVfnSntXn7K4R2AS92LRGjMa4F3yaP41cZ7I2uNMbYlMzmp
 ND4yZIYVgUo2WwNVkigrTAuK8hMf1eCTXJtz6v94cmdiVYH7RIml8825NKuRPsH+zywyWS0/cnD
 CNh+4riN8CeaTm/jfWI6hYU2wXf3nKIZn11QZc9N7i0oklmBT1py1okDBeWBU44HyYbUOCKmEcM
 au114+VGsQ4GKZDtmy2PtDn4QdWWmuPAKimwQcbOMR9sK37NLa6fUWIqDXFcDe5O5UO+OOs1EBo
 7RWSqQmRGNStYuxnKVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010053

Add a SetRangingDataMode method to the Channel Sounding interface so a
client can select how Ranging Data is received from the peer (Real-time
or On-demand) and the CCCD transport to use, wiring through to
bt_rap_set_ranging_data_mode().

When a measurement stops, disable the Real-time Ranging Data
subscription so the peer receives the CCCD disable that the requester
owns.

Assisted-by: Claude:claude-opus-4.8
---
 profiles/ranging/rap.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index b494d188c..de9cd3d1c 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -878,6 +878,12 @@ static DBusMessage *stop_measurement(DBusConnection *conn,
 
 	bt_rap_hci_set_procedure_data_cb(data->hci_sm, NULL, NULL, NULL);
 
+	/* The Requester owns the Real-time CCCD subscription. Unregister it when
+	 * the procedure ends so the peer receives the required CCCD disable. */
+	if (!bt_rap_disable_realtime_ranging(data->rap))
+		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
+					"Disable Real-time Ranging Data failed");
+
 	memset(&data->active_session, 0, sizeof(data->active_session));
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
@@ -887,6 +893,30 @@ static DBusMessage *stop_measurement(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *set_ranging_data_mode(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct rap_data *data = user_data;
+	uint8_t mode;
+	uint8_t transport;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_BYTE, &mode,
+					DBUS_TYPE_BYTE, &transport,
+					DBUS_TYPE_INVALID))
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+					"Expected Ranging Data mode byte");
+
+	if (mode > BT_RAP_RANGING_DATA_ONDEMAND)
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+					"Invalid Ranging Data mode");
+
+	if (!bt_rap_set_ranging_data_mode(data->rap, mode, transport))
+		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
+					"Set Ranging Data mode failed");
+
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable cs_dbus_methods[] = {
 	{ GDBUS_METHOD("StartMeasurement",
 			GDBUS_ARGS({ "params", "a{sv}" }),
@@ -896,6 +926,10 @@ static const GDBusMethodTable cs_dbus_methods[] = {
 			NULL,
 			NULL,
 			stop_measurement) },
+	{ GDBUS_METHOD("SetRangingDataMode",
+			GDBUS_ARGS({ "mode", "y" }, { "transport", "y" }),
+			NULL,
+			set_ranging_data_mode) },
 	{ }
 };
 
-- 
2.43.0

