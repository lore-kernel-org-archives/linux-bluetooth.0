Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A8A4AAC71
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860761; cv=none; b=pmgilaKuf5OEmWm8NOvV9jEG0ns6BcQX4XUs4fXoguE0cR2VqHk8/sQIPI5NgZwttYWfIK05rZpz7Cp763Z8ljZubFicfs2Hwa3ritUfPMrnKOq2LU/hpcnTnnrEJtXEIibY29iu9fmRBm3LJOL6yhLS/iKWp/SUgva0JS2xK8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860761; c=relaxed/simple;
	bh=0XJRva+TQn4YGD1lSUJostwzlIOxtOQ1RxjFRcLLLww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLK/tBL7ijkaKqGmk1dqu325zOUpsRf2bHps1+L9cCl730gFBP1xcUgfM0aURtV3nSiud3T2p89AcfBanJhXVqMTOmTwU7FeOHIyr4rMdxiM9VQXRUojW0M3ju8vUaITLfurCv9WElQNI5XHClgl3l5ZVGsnmC0c45GQz507TQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uj2mjiUx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uj2mjiUx"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691AkGoV3388450
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=P26EgmuzdKf
	PT5s3963TNO82vqwRwpWz0CTeWTvJdsc=; b=Uj2mjiUxIn+ppj4DwDpZ84JsXY6
	1FmgopJ5tVpiURCIRsEDEirOvSkvaf3Lg58lfTBhKCo+zksHBw0cSQ0iLiNsRlnx
	OuDZ/JpMTYrtJkOkGR8tJzIpk2PqP+dLeszVdHC9VriI69omugoC6IA+PDiU77tN
	3+qC4NSDwgj3dCMfEEBrlsfppI7HoyWVZxwJUEOzKNukIL3EdAnze+RMgGaKynfg
	gHfopJZDbx2hyXtlBOsBfuQRWZEmnEH9X98arwzpVf9+jPdRiheQVc2zjCvch6ax
	4fyTh3mHLZIQrL/Hzdtm1oQU2xRPfarTFQBGAIPgZFCxoIasV9ptp/HHtCQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1p2b8k18-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 13:19:16 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 691DJEsM2501453
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:15 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 691DJEAh2501473
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 13:19:15 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 207DE49BCB; Thu,  1 Oct 2026 21:19:13 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH 10/11] doc: Document Channel Sounding ranging data mode control
Date: Thu,  1 Oct 2026 21:18:56 +0800
Message-ID: <20261001131900.707485-11-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-GUID: uBby-WrfeOGO7fPGt30D7FWCJEShD2re
X-Proofpoint-ORIG-GUID: uBby-WrfeOGO7fPGt30D7FWCJEShD2re
X-Authority-Analysis: v=2.4 cv=O8SsLx9W c=1 sm=1 tr=0 ts=6abe5dd5 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=iF3Mj4SGPmvb1BWJrdEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX2yuZPYO6vpAi
 F21ClCoETYU95/bkIg9rWpKVWogcO1Q/+JsKz7DecR51MRcjm66z9qyS0LfUC6gbzPdOV+JcuDz
 2QiFWJVMKsZc1s1MrksN93TctUINEig=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX6pHcfeuZ+9+I
 6lVHvXbGDyhry/IwMLpGZ6fELmTA9b6mNj3Bsa7UlE/882PbBJRiWY0U78/odfXWdxrMkVIVFye
 qcf64LYBJ6kvY7qE7io5c1I4ds3NMj+grZ9NBD1fdS08nJtw2Ve9NtLiFA6GTl8aEJ5i1S6u6R0
 pWdewRVIeBWWjccqkKlKl+PAYmYAUDgOWPFr7Vfu8hQ1ieedD3EY7EaRRQK9mGH8kOzMoSMrMaG
 uaCI0jX22BpgbRihbKmKa3tQvfT8YQ4pQ3K1bHpvMuURygOrUyZ8b1RU9OQaye9jp9TIQX9d4SK
 FBhleYv9Z9ONRj4E60q8ma+3p2/ipUTkm+w+1iGbWgHwIeGELxwPxUHMS2TIMUMyIIg14/7qy7z
 b0GNdjhmnroq85zG1oY9CWXPUTN+4ZWgaXTpjnpDoVdpTFE4IExnZaPb6+C9YV7uWq6D6o/k47e
 k5xHjw1w18tAgH/CCHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010053

Document the ChannelSounding1.SetRangingDataMode method and the
bluetoothctl "ranging-data-mode" and "advertise-rangeservice" commands
added for RAP Requester and Responder control.

Assisted-by: Claude:claude-opus-4.8
---
 doc/bluetoothctl-cs.rst            | 24 ++++++++++++++++++++++
 doc/org.bluez.ChannelSounding1.rst | 32 ++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/doc/bluetoothctl-cs.rst b/doc/bluetoothctl-cs.rst
index c3d67fd2d..eecf4bfe4 100644
--- a/doc/bluetoothctl-cs.rst
+++ b/doc/bluetoothctl-cs.rst
@@ -103,6 +103,30 @@ are active the address is required to identify which one to stop.
 :Example Stop a second device:
 	| **> stop 11:22:33:44:55:66**
 
+ranging-data-mode
+-----------------
+
+Controls the RAP Requester's received Ranging Data subscriptions independently
+of the local CS measurement lifecycle. Changing the mode disables the current
+RAS data CCCDs before enabling the requested mode.
+
+:Usage: **> ranging-data-mode <dev_addr> <disabled/realtime/ondemand> [notify/indicate]**
+:Uses: **org.bluez.ChannelSounding1(5)** method **SetRangingDataMode**
+:disabled: Disables all Ranging Data subscriptions.
+:realtime: Enables Real-time Ranging Data; transport defaults to ``notify``.
+:ondemand: Enables On-demand Data, Control Point, Ready, and Overwritten;
+	transport defaults to ``notify``. On-demand Data remains notification-based
+	so segmented transfers are not limited by indication confirmation pacing.
+:notify: Uses CCCD ``0x0001`` for the selected Ranging Data mode.
+:indicate: Uses CCCD ``0x0002`` for the selected Ranging Data mode.
+
+:Example Disable Ranging Data reception:
+	| **> ranging-data-mode AA:BB:CC:DD:EE:FF disabled**
+:Example Enable Real-time indications:
+	| **> ranging-data-mode AA:BB:CC:DD:EE:FF realtime indicate**
+:Example Enable On-demand indications:
+	| **> ranging-data-mode AA:BB:CC:DD:EE:FF ondemand indicate**
+
 show
 ----
 
diff --git a/doc/org.bluez.ChannelSounding1.rst b/doc/org.bluez.ChannelSounding1.rst
index 95d6bc7b2..32c83e36f 100644
--- a/doc/org.bluez.ChannelSounding1.rst
+++ b/doc/org.bluez.ChannelSounding1.rst
@@ -258,6 +258,38 @@ Examples:
 :bluetoothctl stop a specific device when multiple are active:
 	| [cs] > stop AA:BB:CC:DD:EE:FF
 
+void SetRangingDataMode(byte mode, byte transport)
+``````````````````````````````````````````````````
+
+Selects the RAP Requester's received Ranging Data subscription after remote
+RAS discovery has completed. This is independent of the local Channel Sounding
+measurement lifecycle. Changing mode first disables all current Ranging Data
+CCCD subscriptions, then enables the selected mode.
+
+``mode`` values:
+
+:0x00: Disabled. Stop receiving Ranging Data and disable all RAS data CCCDs.
+:0x01: Real-time. Enable the Real-time Ranging Data CCCD.
+:0x02: On-demand. Enable On-demand Data, Control Point, Ready, and Overwritten
+	CCCDs.
+
+``transport`` selects the CCCD value for Real-time or On-demand mode. It is
+ignored for Disabled mode. Use ``0x01`` for notifications or ``0x02`` for
+indications. For On-demand mode, this applies to Control Point, Ready, and
+Overwritten; segmented On-demand Data always uses notifications.
+
+Raises ``org.bluez.Error.Failed`` when remote RAS discovery and Features read
+have not completed, or the selected mode is unsupported by the peer.
+
+Example:
+
+:bluetoothctl disable Real-time Ranging Data:
+	| [cs] > ranging-data-mode AA:BB:CC:DD:EE:FF disabled
+:bluetoothctl enable Real-time indications:
+	| [cs] > ranging-data-mode AA:BB:CC:DD:EE:FF realtime indicate
+:bluetoothctl enable On-demand indications:
+	| [cs] > ranging-data-mode AA:BB:CC:DD:EE:FF ondemand indicate
+
 Signals
 -------
 
-- 
2.43.0

