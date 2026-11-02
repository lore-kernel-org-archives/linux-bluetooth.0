Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607565;
	b=S63YAJLQ5EsiKpqGKQ8okpNfuRlQDQnYgyJH584AJwv9wRmh0w+0pst7grgqRdReqgyg
	 szmTbeo9X4HBuOemsgRgfmNOhsxBNuKVUm2cGr2dUxOWWAY0bzdDlxosM/1ZSmtSBv0FY
	 P1mdU6zAkidA4dvLFqgKCvnuyy/28HUFbI0iKcy2V4iIsScJVumwnWmj0Vo7+zcfSRuFg
	 6VgOSyIsY/Ntp2xP5lRvs1o1SRAafG5pAh8p5FXOVjMfdGdBPqzoNcwgWENlWZQVRtHRq
	 jUNgUg6q/RswNcoMm04Jbdd84AOUWrOnHxO+JtbK1VtEmHUTxrafcyJnhG22duwF4xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607565;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aIqBeKybiOlsEHuFJxH+euU6HSeyvE4+My6j/1IGXl0=;
	b=Apu7m/mHDmIUeQsZwbB8Emzw0eLVs9Z9hNo3k87dll2oQ/hZtmjL50NddewokzzXiJHw
	 JummOxEckJW8bby/6jr/UFH7hGE52p8Lv5jzSk0/UGWtH+adHd13aalSNplFSh/lAZKS5
	 9l7z3wCn6WplFTiD0boAr/tup4FyCldMtho1si0WzAQf/OnoX0lHfs1Be3ULIAu9OP9qI
	 WxdyHd/QIre3ACeYaQkUOyG58jjPPgucbcGZg80pFVkopsUIRDINvi/l6BjWovIowh5oO
	 vigU3hYXjsmU3oM0XnvB7ZlUIVusvBo0wfgn2QCA4DX+0DOvGXn81KKn0e9pclS0GIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ohgqfVRt;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1E606A334
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BF1E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ohgqfVRt
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A23vFn72753354
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aIqBeKybiOl
	sEHuFJxH+euU6HSeyvE4+My6j/1IGXl0=; b=ohgqfVRtKIGBJBF31Pw2745eVjC
	8WuIUURZihS1h66ROXank6J+5WRNzWAb38JP9pTs2RVh0hsE+x+wG3+jRNiji6/n
	PpNNWcU7C7LCDspqacLAc2q680YrgN/tRJT+6lRJpiUDWafsHxLgUflNgzZaHXGV
	VDjN2fvgt6VtZUMDZYEXhxriWJFDVttNswAWtM6Y7NEVriNmBshiombZOFHXC6Ke
	OX5y+gE/Eg8nE8S91Inp4CMKUtnGhMq/89mNi5OSJ01rhtvT0CcVxviG8mCnevfP
	UTbBOxKUXsDvhFMRfGOKcEFWIrIjrJ6dCMJDMmwAL3WJw5fpRgJz/AondgQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpg201bxg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:23 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JLMw3331096;
	Mon, 2 Nov 2026 08:19:21 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJfw3331043;
	Mon, 02 Nov 2026 08:19:21 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 03/15] shared/rap: Subscribe on-demand data with the requested transport
Date: Mon,  2 Nov 2026 16:19:00 +0800
Message-ID: <20261102081913.1623864-4-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-GUID: sRAtKSprT4RbxbIoR7EcbsYD8ii0IhR3
X-Authority-Analysis: v=2.4 cv=fZY4WEQF c=1 sm=1 tr=0 ts=6ae8478b cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=xGT2LW89_x2-L1gI-M8A:9
X-Proofpoint-ORIG-GUID: sRAtKSprT4RbxbIoR7EcbsYD8ii0IhR3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfXz1g+bwx5gSnk
 a4JjAh4o2g3ttAVi3R7X5TbWLZa9mw4lH+p9ZmnNjk08TSTuGTxvbbY5IfV5aRH1FFPsn1Dz5gp
 KWKQx62OITCsc/jBoLF2JXF0igJoblh72uz2ezvpY+c+Di2Sb1+nUqbhZ86O5HP2Dq/5ECPKQDB
 VapHjQatkbpXLGLB58pkYzsgBoq+zRMAg2MDS7kOzhRu/ANNi9lGMCs19PMpX76ACO7vp+4h3sh
 1Xe3NyECDye/Rjq3fsGBBPwW53RBY3E8RkYqkKjS+B3oZQsqlt2eqobhuvp1dJuZQj4Q0WOiHVO
 WF1ZuGpp7qlD/QCItd82THaJhY0aFD5j2jxc7YCxBkVtiFHdaB2gc8L1mrcFrOeFCXkyPNlgisj
 IsilZaOrVj+6AKq0iI4cgJGIpO1u1ayRsqIq2ziBbjQjVcX3Mz/KIuM8g4v5fd2aQiA+sBxVbeP
 9Rz+f4hQ7AwddVLVP0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX3ql4d9U+3Iae
 PKDdRA2mIwtMzzpX2uZuSfORfz11Uze2AGZlLo6EduyflC4n0uvN7AdXKvp68m6vTv2ZXFywJj4
 PBnISYiqzvkfmQXkTig45g0dC331xLo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

The On-demand Ranging Data characteristic was always subscribed with
notifications, so an indication request from the Upper Tester was
ignored for the data characteristic, while the RAS Control Point,
Ranging Data Ready and Ranging Data Overwritten followed it.

RAS v1.0 Table 3.1 has it the other way around: On-demand Ranging Data
must support both notifications and indications, the RAS Control Point
supports only indications, and notifications are optional for Ranging
Data Ready and Ranging Data Overwritten. With notifications selected
the Control Point subscription was rejected, so no On-demand transfer
could be requested.

Use the requested transport for On-demand Ranging Data, always
subscribe to Control Point indications, and subscribe Ready and
Overwritten with indications when the server supports them, falling
back to notifications only when it does not. A server may send Ready
only as indications: PTS does so in RAP/REQ/ORD/BV-01-C.

Assisted-by: Claude:claude-opus-5-5
---
 doc/org.bluez.ChannelSounding1.rst |  5 +++--
 src/shared/rap.c                   | 32 +++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/doc/org.bluez.ChannelSounding1.rst b/doc/org.bluez.ChannelSounding1.rst
index 32c83e36f..e75535b97 100644
--- a/doc/org.bluez.ChannelSounding1.rst
+++ b/doc/org.bluez.ChannelSounding1.rst
@@ -275,8 +275,9 @@ CCCD subscriptions, then enables the selected mode.
 
 ``transport`` selects the CCCD value for Real-time or On-demand mode. It is
 ignored for Disabled mode. Use ``0x01`` for notifications or ``0x02`` for
-indications. For On-demand mode, this applies to Control Point, Ready, and
-Overwritten; segmented On-demand Data always uses notifications.
+indications. For On-demand mode, this applies to On-demand Data. Control
+Point always uses indications, and Ready and Overwritten use indications
+if the peer supports them, notifications otherwise.
 
 Raises ``org.bluez.Error.Failed`` when remote RAS discovery and Features read
 have not completed, or the selected mode is unsupported by the peer.
diff --git a/src/shared/rap.c b/src/shared/rap.c
index e0aa965e5..f275f5835 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -4556,6 +4556,21 @@ static void ras_cp_response_notify_cb(struct bt_rap *rap,
 	}
 }
 
+/* Indicate Ranging Data Ready and Ranging Data Overwritten when the server
+ * supports it; otherwise let the client fall back to notifications.
+ */
+static uint16_t rap_status_ccc(struct gatt_db_attribute *chrc)
+{
+	uint8_t props;
+
+	if (gatt_db_attribute_get_char_data(chrc, NULL, NULL, &props, NULL,
+								NULL) &&
+			!(props & BT_GATT_CHRC_PROP_INDICATE))
+		return 0;
+
+	return BT_RAP_RANGING_INDICATE;
+}
+
 /* Initiator role: subscribe to a single on-demand-related characteristic,
  * logging (not failing) on any missing attribute/handle so a
  * partially-capable peer doesn't block subscription to the others.
@@ -4637,21 +4652,24 @@ static bool rap_subscribe_ranging_data(struct bt_rap *rap,
 	if (mode == BT_RAP_RANGING_DATA_ONDEMAND) {
 		uint16_t value_handle;
 
-		/* Data is segmented and can be large, so keep it on
-		 * notifications. The control and status characteristics use
-		 * the requested transport.
+		/* Only the data characteristic follows the requested
+		 * transport (RAS v1.0 Table 3.1). The RAS Control Point can
+		 * only be indicated, and Ranging Data Ready and Ranging Data
+		 * Overwritten are indicated whenever the server supports it,
+		 * since a server may send them only as indications.
 		 */
 		rap_subscribe_ondemand_chrc(rap, ras->ondemand_chrc,
-			BT_RAP_RANGING_NOTIFY, ras_segment_notify_cb,
+			rap->ondemand_ccc_value, ras_segment_notify_cb,
 			"on-demand", &rap->ondemand_notify_id);
 		rap_subscribe_ondemand_chrc(rap, ras->cp_chrc,
-			rap->ondemand_ccc_value, ras_cp_response_notify_cb,
+			BT_RAP_RANGING_INDICATE, ras_cp_response_notify_cb,
 			"RAS Control Point", &rap->cp_notify_id);
 		rap_subscribe_ondemand_chrc(rap, ras->ready_chrc,
-			rap->ondemand_ccc_value, ras_data_ready_notify_cb,
+			rap_status_ccc(ras->ready_chrc),
+			ras_data_ready_notify_cb,
 			"Ranging Data Ready", &rap->ready_notify_id);
 		rap_subscribe_ondemand_chrc(rap, ras->overwritten_chrc,
-			rap->ondemand_ccc_value,
+			rap_status_ccc(ras->overwritten_chrc),
 			ras_data_overwritten_notify_cb,
 			"Ranging Data Overwritten",
 			&rap->overwritten_notify_id);
-- 
2.43.0

