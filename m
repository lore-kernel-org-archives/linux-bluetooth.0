Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607565;
	b=0UYtsu8zarjrDcWBvxiQAwi/O1pkdDHgGnY+yqUVgxkLr+rmIbpCtZxhz4cAwl4r4Yfw
	 haplxcS4JZnyiuwWDMXHGQDbQe+cl248WFtEwdPao09RzGku521AV1sOuLMgRMwuH3Ukt
	 qm5n6s3GsoU1JR+QgU7a6QCPx7w3u6TPAKchfBl1/Rj9geL7OU3MrNbnZia6uu+tD00qA
	 oCpQPpIVQtVTpydX8UyqdUM54ttbj3IgAhiOkE/GOk2R0BXIV5KFCwqYl0m8qGeFtA8Eo
	 9c9kddH1X7hnggJ/0Tj3vK38a1rlHv4Jzipd2eK8pWMqs4meVk7YqRqWYLEss/dWrew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607565;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SHw/lfApQAhyMNsgEsg9QKKAIPL/1byN0Rl28fzQAvA=;
	b=LX/qBAhXwvkq93Rhn47hQMf92LjMJvRA6xcGae8ZQss5YdJCGY71H3Qmb2PiS4HB/eOu
	 mUmC5rGBgjaJSyBHo8Pg7S2f2P+dglQM4FcYxKvxx0q7igtledBIj5Vp+UUGwWI7fGb9Q
	 UfNMnajB127Wl0sr/t7qpj8aA1i1TtcsNP6GILIbn9T/TBHCXTc6qLA2z4ax6rgaOy4H5
	 1JhKYmX+ZFvhb+x0xASb7pOrrtLnK4bA7LIGWa3QilYUzr99qeG3MrxR5xyUNHoJ5HYpq
	 PZstOYbkUnbzBZsUZm/FfTIUAabMs6A4ekiZi648VgCo1a69F0HMaLr5z0Wwh5swQ7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fktLiNl+;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4AB606A332
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C4AB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fktLiNl+
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A25W3S83924346
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=SHw/lfApQAh
	yMNsgEsg9QKKAIPL/1byN0Rl28fzQAvA=; b=fktLiNl+6G1wrgTeX0tWZoPThnJ
	KSgVfU/QVoqnblL2E041vfFzFwlPxQ5HV2G4DgCz3iTCOVmv0yvQ6BQ2kyX7ESJn
	iN9zsnLHT3qeeKLtaggnwLxgigCgI8zci1vDpgF5o65KL/knukEAC+6onHCgfBOu
	4oq3nBsmnWeqXtMm0q7iMCy15EyhyKMWVPuN5xBUgNoanI7FOHsMA9mgDR9aFuT5
	+qbrMtt2ZvStMlOzOx0d97x4ZQomKBmJaZh1EejSszvrOfiRMnwbkCarMSiejhaY
	LIhYW6l+cIH7pSs4EQW+fX/SmkhlgDB1AI6Tp74YzVXzy/5zkicOztrXX0g==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1rjy4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:23 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JKhk3331063
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:22 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJfx3331043;
	Mon, 02 Nov 2026 08:19:21 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 04/15] shared/rap: Subscribe to Ranging Data when a measurement starts
Date: Mon,  2 Nov 2026 16:19:01 +0800
Message-ID: <20261102081913.1623864-5-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: ApZZrRs80RnToy7P8okDzkHmlFZLdd5f
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae8478c cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=X_yO0FScMVS8bjrd2VwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX2DsDiK7C+CiC
 wpPpPKSNXxWj8NKI1DM0QC1f/JDc42skr7w3561nvm/mrcIpEfQwnExWPFQfypSVSz3nQtvMddh
 dpI7FeV8J6Lt3cPFCNxWu3tgL/VmMeeukm1iAT5eXmJsDv9XHuQ5QyAzwqT/SnI+w9OBiNhp5BY
 8ZwDIZfEbDzYWy4XPTgJijreseDNqmRaLD4dlTfA6BKlnk8oM1jAvTid0HuNIIbN9QHpkkXybEh
 Ib6h/3j5lqggHqWFyct2ICAOFBNch5RagexbhZMNx0xO5AFojQTUVjfIJ7Fv6TiniqVR3C85cPW
 4kETTAvBW+xsJ4uZxnDURhxlyiu+5tw+dK34Dn9sygMA24XbeXg4X69l2DrxnJt4VMgJOHy1g8Z
 +x9IVEIK3uHnro8tLvzQmsVnl+y98pZhTdnFLoEL6Ytfjo8yMr+XJPm9gadyoNx9dE0sTpJ821y
 Do/olf4Nd387ob4WbTw==
X-Proofpoint-GUID: ApZZrRs80RnToy7P8okDzkHmlFZLdd5f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX0ANspDS0aech
 TYQLNaS4jz2HVAryUjEGUwxjkvD67POgzk+A8uU3l5M+tCo6q76eZH0ZNGlIiD8gkQSFJtOX4Tu
 cuU9JrifJBbM8aCK6rqvqRaK6xvvlkU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

Reading RAS Features subscribed to Real-time Ranging Data whenever
On-demand ranging was not configured. The subscription also arms the
5 s first segment timer, and at connection time there is normally no
CS procedure running yet, so the timer fires and writes 0x0000 back to
the CCCD. The connection-time subscription therefore only adds an
enable and a disable write that no application asked for, and a test
that expects the IUT to enable Real-time Ranging Data only when told
to (RAP/REQ/RRD/BV-01-C) sees both. It also subscribed to nothing when
the peer does not support Real-time Ranging Data, although the RREQ
has to enable On-demand Ranging Data then (RAP v1.0 4.4.2).

Subscribe at connection time only for the configured On-demand mode.
When StartMeasurement() is called and SetRangingDataMode() has not
subscribed to either mode, subscribe to the configured one, using
On-demand if the peer lacks Real-time Ranging Data.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap.c |  6 ++++++
 src/shared/rap.c       | 28 +++++++++++++++++++++++++---
 src/shared/rap.h       |  5 +++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index f1717d932..2d8b1a7a1 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -843,6 +843,12 @@ bad_type:
 	if (settings.role == 0x02)
 		return dbus_message_new_method_return(msg);
 
+	/* Nothing is subscribed at connection time unless On-demand is
+	 * configured, so subscribe now if SetRangingDataMode() was not called.
+	 */
+	if (!bt_rap_ensure_ranging_data(data->rap))
+		DBG("Unable to subscribe to Ranging Data");
+
 	if (!bt_rap_start_measurement(data->hci_sm, data->conn_handle,
 							duration_secs))
 		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
diff --git a/src/shared/rap.c b/src/shared/rap.c
index f275f5835..85cf8111f 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -4712,6 +4712,28 @@ bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
 	return rap_subscribe_ranging_data(rap, mode);
 }
 
+bool bt_rap_ensure_ranging_data(struct bt_rap *rap)
+{
+	enum bt_rap_ranging_data_mode mode;
+
+	if (!rap || !rap->client)
+		return false;
+
+	if (rap->realtime_notify_id || rap->ondemand_notify_id)
+		return true;
+
+	/* The RREQ has to enable one of the two (RAP v1.0 4.4). Real-time
+	 * Ranging Data is optional for the RRSP, so fall back to On-demand
+	 * when it is not supported (RAP v1.0 4.4.2).
+	 */
+	if (rap->ondemand_mode || !(rap->ras_features & 0x01))
+		mode = BT_RAP_RANGING_DATA_ONDEMAND;
+	else
+		mode = BT_RAP_RANGING_DATA_REALTIME;
+
+	return rap_subscribe_ranging_data(rap, mode);
+}
+
 static void read_ras_features(struct bt_rap *rap, bool success,
 			uint8_t att_ecode,
 			const uint8_t *value, uint16_t length,
@@ -4771,9 +4793,9 @@ static void read_ras_features(struct bt_rap *rap, bool success,
 		return;
 	}
 
-	if (!rap_subscribe_ranging_data(rap, rap->ondemand_mode ?
-				BT_RAP_RANGING_DATA_ONDEMAND :
-				BT_RAP_RANGING_DATA_REALTIME))
+	if (rap->ondemand_mode &&
+			!rap_subscribe_ranging_data(rap,
+					BT_RAP_RANGING_DATA_ONDEMAND))
 		DBG(rap, "Failed to subscribe to requested Ranging Data mode");
 }
 
diff --git a/src/shared/rap.h b/src/shared/rap.h
index af4fab057..7ee51143c 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -322,6 +322,11 @@ bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
 			enum bt_rap_ranging_data_mode mode,
 			enum bt_rap_ranging_transport transport);
 
+/* Subscribe to the configured Ranging Data mode unless one is already
+ * subscribed, falling back to On-demand if the peer lacks Real-time.
+ */
+bool bt_rap_ensure_ranging_data(struct bt_rap *rap);
+
 /* Initiator role: stop receiving Real-time Ranging Data. The GATT client
  * disables the characteristic CCCD when this is its final subscription.
  */
-- 
2.43.0

