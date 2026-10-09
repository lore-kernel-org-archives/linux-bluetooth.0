Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F50497B62
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537940; cv=none; b=tDEBwYct/3iyusS+IwCr8pG/2FZE5EZFQD89S/ekx/kO2A924KDthJk8NGU2vV0vTuylaMy/VQicryTXPMSTKR8i5S/k3PJMUGL5oT5IB+kjHyTPIQUCsiTIo5tt0uva8R9cJXZbcXwTtqLRVN8hspwxhROC0j2roagZgazYeJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537940; c=relaxed/simple;
	bh=0XJRva+TQn4YGD1lSUJostwzlIOxtOQ1RxjFRcLLLww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YY7XpomEPpSg/MO0/Tm8z03pov+Zzac9lzWxwXwg1Ka0urKIU+3OdXr77xRKR9b+AUjsedjX6pL/AgZZUOfljqyr73ar9yjTO+2Xsvv0z+yva8DRrlGIhTTjTZXaaRuhSctEfkb5jKNrE3sxQQJ2f69GBatKcpJ3B1dfWdKfc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e6HNgsca; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e6HNgsca"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KBep2256985
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=P26EgmuzdKf
	PT5s3963TNO82vqwRwpWz0CTeWTvJdsc=; b=e6HNgscam7Ojnf5AXwOubC/xW3A
	6Ot4kLvVryM3m47fLA22A2UmyYM8jcwokC+DjArGuTQNhegyMCI2NZZBaFw+aChW
	E4DHVEP5roao/kP4UvemmLrPE8RENPqqgQsD0aWtjKeWXXyQJsdc2RHZIhA2Q33Q
	taXoWAoZTGyOqFMs20KxSQVf3cLNIKfwybhV0g+PMvgIw0MFL/vAEO96B+dWbgJ5
	dBrLDdrfcguhw7yLa2TLMmzuImgnDtW4i5cb3tEuU4ngLIdcaHDZ2a+4G39LXtl+
	084y28gbsnAyruSjOHYTF4gqFJU5q5/N5nSZ3zW/uUiRSQM8f9PcT2y24Kg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6nufspfv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 09:25:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999PZ573501233
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:35 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6999PZmx3501207
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:25:35 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 9748449BE6; Fri,  9 Oct 2026 17:25:33 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH v2 13/14] doc: Document Channel Sounding ranging data mode control
Date: Fri,  9 Oct 2026 17:25:29 +0800
Message-ID: <20261009092532.3600749-14-cheng.jiang@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=afn0Dhot c=1 sm=1 tr=0 ts=6ac8b311 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=iF3Mj4SGPmvb1BWJrdEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX5346MWYWSUXR
 plMzKEp71DAnLwYjykwxgSJ0uv9eiKfBXkGM3rNwN8RVtaU4kObDqfQGQVxOV0EbJ5+mGSYhMDq
 l90YX/Y1quzNbCokdjLdqezctK4dZNo=
X-Proofpoint-GUID: Yas5mbyHX1bF6WzDfwxBiQNj1pFbJmbD
X-Proofpoint-ORIG-GUID: Yas5mbyHX1bF6WzDfwxBiQNj1pFbJmbD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfXzVK8Qf2F6Te/
 9/j7YeqZMUbHV3tC5cYSz06LQ+CjlPn3JDZHRPGOkoK9gAi2HLkxyF+SuxJnM7OWG0bnh58qIaA
 4IckSeggOejZEweiGCx1d4b5xVhIG9zt3+sW1m9962ScpctD6Pr9Js7Vx9/FNFaOIPVOZQ4ztTY
 P3PQRtIAGgVVp3aPhXDV+mcZf+KkdPid6PrYsRWeyCUB8bHX9aLTCYUrf2sBQDeeO6uaLdjYCXu
 W1S5tBwMqqSQbutzIEZdyZkCmZglPmnTs+tj5OslsJ8ElxIFZJp3mw+D5FcRxXID+LXhz9okMO7
 A34Z3VrfPWpIJj4zULl26fH37Yk7BNxctW4v+9f+8ix+uYv2yd5i8qHoDeXILoobvkdLwwj33mo
 6kj+i4Wp030/XG39L5ZpSQT3F+6s5CAzsf23zsbc8HrAVvJfshOWKoUnKzO3qVB+h8bEHpYj2mE
 /8IF3rlYTZQupWELWtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090037

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

