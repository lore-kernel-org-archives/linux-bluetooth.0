Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607565;
	b=rk6VF4JTkg1HXGiXgIkACpmexo3PUn++fLMXAPauHKzBMGqJG2pqBR24pEKiE26Vrmst
	 C6wVAHnzlPvzzBPkRtMsaeMNykimJl1cjWvLHlIZMighwNne4K/cUFItIDR+iS/VAg2Yp
	 iKQFIcl3piOvKdQd0nMPjP4l8JDRSCfQrJmNy+yJE2nNQkD0DO+xzRv8o6tUJv/8Q3QyR
	 OLwJ1R6CBr0M/nJ+GXc+pq9X0zA0tAUpEuaHziuQ6qZK5V2n1wB8L9SHD0FOPbTya67Dr
	 zCgZAgXdYOGc8FpBNVTGiM1NJNHEMHMo95mCFzcXDVBvgVmhJqMEhdwVsZLyR1S+MNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607565;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7g7qVmBiR8WI7TR/W8LkN9A4Zeaz6kZwVhIdeL4OTpo=;
	b=n8v27wl1jcBu9cx/3ElH+D1dwSUGrprSBIsvQnvE9nbxoBzNIIbTiu/a5MsdfVg9p5rs
	 OAgY1Li6asZ0OTk5Of2hf+ZMsxHMCcB6fyYnHIgMCzj4CFd3Kq+vSQdklG7SDwq1Kg6cS
	 LyzNUAF/JsFgIUjBHNh99tHA6bWULQjp3D2mTG3T1obYCXPcHgoKm9SA+xsKxs4u8QrK5
	 EIE9Gkb7+td2+gUHcn+DfiGRmecVaUDk5VrZkmm9KM0pZq0HoBf14489CB8rNuxS4R9Cn
	 F0OIOn8p53ohMA+UbIAJ0oHGrdYoY16mjW2QtrP6d9H1oMzXEJVqnv1rjAZzPX4bJnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=auz5aydh;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786A606A324
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E786A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=auz5aydh
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A24w05n1261903
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7g7qVmBiR8W
	I7TR/W8LkN9A4Zeaz6kZwVhIdeL4OTpo=; b=auz5aydh6h1HVjQQUy0xuYqoaGU
	d0oQEdLXCGXoOo+dNC/bkAihQVVky/pZdovWtj56PZGAkKpvj6rIwUAQqj1XucwB
	H+I1+rWDcQkUawaYSDtu2tUQr6Qg0Uu+n4xhJpw5Gq/1FSvLp0xoOzLGii94eTsx
	l/GeS0HKheIs3K/6Smi9N/g0EJaJoVd3IaArskNe1IXJkQ38/MbkS0yaJVykBfBb
	0XbWfI+5fyi93r9CBbE8SOSlyD5iknc12ojytLeMnL7M/zpzBBEolvW9ftOmL7pM
	Z3I0mVwb6Y1Sfor2rIRbspT3TfulJG/YnTYbSmEUn50evcGMqErrxAct7Zw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4gp46-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:24 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JMfq3331103
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:22 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJg03331043;
	Mon, 02 Nov 2026 08:19:22 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 05/15] client/cs: Fix use-after-free in stop_measurement_reply
Date: Mon,  2 Nov 2026 16:19:02 +0800
Message-ID: <20261102081913.1623864-6-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
References: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: -75ehfwytJ-EBqyhaonu3qGrHPBnroAl
X-Proofpoint-GUID: -75ehfwytJ-EBqyhaonu3qGrHPBnroAl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX1TfcHXl36OkY
 fstWZ/y9zDeBTVttleaApjO8en30l8b1Rrp56KQ8yQXRCQXq8hJWA1G7AkxKmfsy4TkHjX2HBF/
 8bQLHfP2rr+4X5x8gcxxsYa2x6qJEAY=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae8478c cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Rnx0kEunZ_VH6A0BWhcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX6W8Dl1hCGWH2
 JJuDUdrrRNZZeLVDAl7wxvPkipiiBF7j2NbZE0asEG+uATpp11CbSF+1Df5MRdEacY+1Y5qtIBE
 SLoyDqkJsRQzVXDUPW94ZW6Ld7ylNUHYoOGSGQ5mVQBTnVPMoH49NNa4KKtfvKcpsMHiLIyCP3f
 5Dc/Hs4iDLMas1O6pEoezSGnMvtjxuqGhOwlbAKOipjywILuEj3u/njhWZXr08RTjRkBzCDvLMu
 gEYoFRkc40+dSpGM0qEU/fZaymY++m6kJ2v0ZBl6YpQ/MszUdgWmNe37q1JroQ8iCOCTMW1fhTe
 +5H1O4sSoT5jQKpDvPmpGS42AuPYuDYciWfJpzfHKKRkfrLOphEU1MBmWgOxXHkWVf+noXoq9US
 IeahXLSM3fD9ifOta7Hj0/1SOoSFiE09Ca+XNnu2XLfjihdgPFBk4iUbwp+acJK+ajeybJ4501L
 Qa08A0Wg9tknAzXvWkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

The daemon emits the Active=false property change before the
StopMeasurement reply, so cs_measurement_stopped() frees the session
first and the reply callback then read and freed it again.

Pass the proxy as user_data and look the session up again in the reply
callback, returning if it is already gone.

Assisted-by: Claude:claude-sonnet-5-5
---
 client/cs.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/client/cs.c b/client/cs.c
index 4c181e743..e029da881 100644
--- a/client/cs.c
+++ b/client/cs.c
@@ -1369,7 +1369,8 @@ static void cmd_cs_start(int argc, char *argv[])
 
 static void stop_measurement_reply(DBusMessage *message, void *user_data)
 {
-	struct cs_session *s = user_data;
+	GDBusProxy *proxy = user_data;
+	struct cs_session *s;
 	DBusError error;
 
 	dbus_error_init(&error);
@@ -1380,7 +1381,15 @@ static void stop_measurement_reply(DBusMessage *message, void *user_data)
 	}
 
 	bt_shell_printf("Measurement stopped on %s\n",
-			g_dbus_proxy_get_path(s->proxy));
+			g_dbus_proxy_get_path(proxy));
+
+	/* The Active=false property change may already have dropped the
+	 * session, since the daemon emits it before this reply.
+	 */
+	s = cs_find_session(proxy);
+	if (!s)
+		return;
+
 	cs_sessions = g_list_remove(cs_sessions, s);
 	g_free(s);
 }
@@ -1425,7 +1434,7 @@ static void cmd_cs_stop(int argc, char *argv[])
 
 	if (!g_dbus_proxy_method_call(s->proxy, "StopMeasurement",
 				      NULL,
-				      stop_measurement_reply, s, NULL))
+				      stop_measurement_reply, s->proxy, NULL))
 		bt_shell_printf("Failed to send StopMeasurement\n");
 }
 
-- 
2.43.0

