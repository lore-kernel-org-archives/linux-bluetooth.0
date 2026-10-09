Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291A749A3DE
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537941; cv=none; b=dH/EYZZShgCEprLpxFBsQiN4LieS8Do4ShYTjg72e4NunXVspQ8jMwiYo0z7+NX4rJWI4dN0q9VvneGbq2A2ti2XaD4Z0ZHwaLo/XNDh4ld+y78903l7M9cfkP4BqJPS77/Bkui+JkSOxi+1bqpS57BFODSpDwDTPwjyQGWSH90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537941; c=relaxed/simple;
	bh=T+9M44BexP7R4/zKF6t8GXBKjP7B2jeL/HF7FcaCEHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYJV5YA4eHfahJxnaiX2ROG/s4R8mYrH72RrEZQjxlUnjX5wrWXR7DMQdl+S++JU3YLdo4aNTHPIplwmcPHYB/fMD3Dxol58ghd6tRN2RWhLFlfPaRUljrkwTHOTEdsSaBZFODajmYnNHX0/A5xyS8cYOAsEHMKi96JnyVBa0WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ElFdQHWb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ElFdQHWb"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KHnP230937
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WPlx2BowtcY
	R1zhC4fVa9O2IkPg5Wk8I4qaEU7BfCLM=; b=ElFdQHWb51StBAetfu9BACpBxbA
	vjGE2jd27RLLU9LifSxponFxaZX/w89vWsWukiKPgVNTPUsWHccUPmF0NRQfCP/f
	E4auHJdNG6/crivF1xohA0HRp63Ryeep+zz8IWS/Ak2w8Fn2l+QaKg0bI9+2OP9E
	THlBnzR5HwPkVdPsCoVQdiDqHoRDAR30FSPEkfVsHnI4FYLUgAeqU4me8WAYfcSL
	AbaX7vnmu1YM06xk21Rlbl6fx3htN5f+fQcdR8jj/3BxEUCH8PBf1b5X1Qj7cRAB
	FCzPFLy8EoFTf2kIK6hLP08s3xF5UHD3JF7JXFweiPw9Tbuwp7oHArTOUeg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxu2vfy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 09:25:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999PZrj3501235;
	Fri, 9 Oct 2026 09:25:35 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6999PZvr3501203
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:25:35 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 90C0C49BE4; Fri,  9 Oct 2026 17:25:33 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH v2 11/14] profiles/ranging: Expose requester ranging data mode over D-Bus
Date: Fri,  9 Oct 2026 17:25:27 +0800
Message-ID: <20261009092532.3600749-12-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfXyYANbyIsrTRQ
 SpEtuwipDEzXj4Zg0rtp6rw21xbTAX3x587evBKkF+6sAeqFgxlzW0mfjraJ4sllsZNq04mOnwt
 gk+aAWsR5m6o+rd8aL7Jak1kqxt3NvbvhT9VoVlbTtxoYtzMHf5OKi9JwQUhevmd1L9GNRNddio
 d91JNeHqwV8ROQSbpSeVW1rO97N/j9S4lNDyJbJlJuXGMyHsxQpEmKuCX+fbB1Za/XqHnClkRkz
 abspur+kZmzUiVRpY/Q6fiz2UYroYNS0s9iGNnLsDCJOJOs27/mI6K1F/KYBHbBKuFt0G5viaId
 FB7DnHyLb2sxudmg47ChDwbihsUrajqY5jyfddpLDh/ncRwoM285chKprtNcbdf0Tan5HS2lsjx
 JHVPbgbKjea4YZctKo/1+KQdkD2QQVvNhSuWAcWaQrwOCO9oZt8e3f668Z7PFgqV9zfCn5QwnAE
 a1MsbhDYy5gryYgCQMA==
X-Authority-Analysis: v=2.4 cv=QbjzLcbv c=1 sm=1 tr=0 ts=6ac8b312 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=WwGtstz2p8n0CXtVlhQA:9
X-Proofpoint-GUID: H0kYWIDT9amYy7qHKXOhwh_M0b2WDYLD
X-Proofpoint-ORIG-GUID: H0kYWIDT9amYy7qHKXOhwh_M0b2WDYLD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX9J3LOGWujjXA
 2IOunz4Puh/0lw2dP1H+PIZd+e9C8xW9J0btJyzeUreahGublCw7l/+LfOdrmFbzbS6CAcH1CQh
 EBctpxYEzhKIvyTBXE9ctv2UmzR3f+s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090037

Add a SetRangingDataMode method to the Channel Sounding interface so a
client can select how Ranging Data is received from the peer (Real-time
or On-demand) and the CCCD transport to use, wiring through to
bt_rap_set_ranging_data_mode().

When a measurement stops, disable the Real-time Ranging Data
subscription so the peer receives the CCCD disable that the requester
owns.

Assisted-by: Claude:claude-opus-4.8
---
 profiles/ranging/rap.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index 0fffd3e03..6152da910 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -876,6 +876,14 @@ static DBusMessage *stop_measurement(DBusConnection *conn,
 
 	bt_rap_hci_set_procedure_data_cb(data->hci_sm, NULL, NULL, NULL);
 
+	/* The Requester owns the Real-time CCCD subscription. Unregister it
+	 * when the procedure ends so the peer receives the required CCCD
+	 * disable.
+	 */
+	if (!bt_rap_disable_realtime_ranging(data->rap))
+		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
+					"Disable Real-time Ranging Data failed");
+
 	memset(&data->active_session, 0, sizeof(data->active_session));
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
@@ -885,6 +893,30 @@ static DBusMessage *stop_measurement(DBusConnection *conn,
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
@@ -894,6 +926,10 @@ static const GDBusMethodTable cs_dbus_methods[] = {
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

