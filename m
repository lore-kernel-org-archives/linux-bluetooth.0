Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738422737F8
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055116; cv=none; b=mQzSeJs85QU9A6u9K+hqA8ss66gWAvx3+BUiyoRQIPp+lxeRhI3UUt2QZKhHBTAz3RA5wFr5Pu2Agnxkj2MKQRz7RD9PZ4SgxbiK104ihtydeiPjrsDIeLswFuVZWQEwZoZel2VJrfkfdudsr0HiuOnuG+Q0D1aT+VJq7AMung8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055116; c=relaxed/simple;
	bh=R9jNeQXBx23BmugNWTx5cDCPC7v2WmvX4puEPqfQFH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ioMsoMoVaRpV9ILhLLpRQvRzn6lKe9RLBXPJbqz0eWmWGWSyU43g7H3o06KF7HzUvT9erKlM1HT3D63PgOQ0a//dU350TAP9M6KtTbvqa0plTfhNfRRgAwUCykSS6+MU6rPfVfdGc95gwrpyuIwXBa59fGaz0kVVOjxHG03hYL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X5I2SbbV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X5I2SbbV"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6299ALHx1882681;
	Mon, 9 Mar 2026 11:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qrdLNzfD5aDkR2nJri/vXnxEih9PaCssZNp
	Ji13xgow=; b=X5I2SbbVRyCrK/HH9Nr0qlr0RdyqtN3I4esMqXAKCFweoif08Bo
	iT8DhI5tl19gmiqHdYHUr5hhknq4ITEzsW1JBnvEGyxWSQQ5G1n3an5ZLjqn9WZd
	9k/4w2gUoGymkUfjRL/ul2uxi1+EorLiI9tmsXHZRGnbaJwkHagRvCPxnNGKZwAg
	eGykATIWjLAfXOHsTqeDHSKE2q+7bARdCt6B6oFhN/RiQPUWXncpaujK/E11W4pQ
	BV+b/zsYRqFEwEEStNS6qRRfmE0u9EnMjrPpcZh+hYqo/uHOjQe56OMj47jDrfhh
	CsZ3WcuO583RoKwiyxVUxsoC66xfRPv8A3A==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crd6fd23n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 11:18:32 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 629BIUUi011669;
	Mon, 9 Mar 2026 11:18:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4crd3kx7pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 11:18:30 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 629BIUSh011663;
	Mon, 9 Mar 2026 11:18:30 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 629BIT8j011662
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 11:18:30 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 033E521D47; Mon,  9 Mar 2026 19:18:29 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH v3] transport: Fix set volume failure with invalid device volume
Date: Mon,  9 Mar 2026 19:18:26 +0800
Message-Id: <20260309111826.3998132-1-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dlJw0CMJkdXM1lg3M9dZchdz_Szj6gb4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEwNCBTYWx0ZWRfX3fgFlvPfr7ok
 hyHDkGLrH6kRs2R048szHakuX9gpTuEFZT6jwxDyQ5Fw8k/20ekgfyrmmFfa3F+lJE7vGmScOFY
 ON0rV4zgZU3FMC//DhfxhUAInvK+eKQrH2RxBIJNtXU0dpbRu04rDVbdTx97vnlq2RkGuQyyfvw
 Lqmrf5eA8iZcuBl9wEAOrPoSYmrP6SPH0TbrDfWiFEQURRGb1osndqjmSaQ7RZHPGvb4SwyMWEL
 JrSnvuBxJxCVRAjWaLlECn5Bw5UUz+zZgAb3ZXPTQ4fCmsYbhu7faC0vxbQb8tG+Hdg2KSqT698
 x5SanGmRqMXD6B5pfLjLglomBvl9/a1PPB2J2wDmmZihrqwykyxU1m+srlrjemNvQOY3Gq9Jq7g
 tS0EwsxoVtbb44qH/71t+LwZ62y7o3Es8/MsU1F1J0pMlxvktFCsxWCxF2g6wz3A9034sotnUCF
 GfbszYqBriwEFPaF8IQ==
X-Proofpoint-GUID: dlJw0CMJkdXM1lg3M9dZchdz_Szj6gb4
X-Authority-Analysis: v=2.4 cv=RP++3oi+ c=1 sm=1 tr=0 ts=69aeac88 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=kdO5B34v-8opkgHShjwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090104

When AVRCP is connected before AVDTP, an invalid device volume causes
the target to reject registration for the EVENT_VOLUME_CHANGED
notification, which breaks subsequent volume updates.

Fix this by initializing the volume to the maximum value in the AVRCP
target init path when it is invalid, allowing the controller to
subscribe to AVRCP_EVENT_VOLUME_CHANGED.

Fixes: fa7828bddd21 ("transport: Fix not being able to initialize volume properly")
Suggested-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
---
 profiles/audio/avrcp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Changes from v2:
 - Initialize the volume in the AVRCP target init path instead of
   returning a fallback value from media_transport_get_a2dp_volume().
 - Set the volume to the maximum value only when it is still invalid,
   avoiding role-dependent behavior issues.
 - Link to v1
   https://lore.kernel.org/all/20260305083833.369358-1-jinwang.li@oss.qualcomm.com/

Changes from v1:
 - Return the max volume from media_transport_get_a2dp_volume()
   when there is no A2DP transport and the device volume is invalid.
 - Restore the default device volume in device_new().
 - Update the commit subject name.
 - Link to v1
   https://lore.kernel.org/all/20260122063640.310090-1-jinwang.li@oss.qualcomm.com/

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 724b46c59..326dfdab7 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -4296,9 +4296,16 @@ static void target_init(struct avrcp *session)
 	if (target->version < 0x0104)
 		return;
 
-	if (avrcp_volume_supported(target))
+	if (avrcp_volume_supported(target)) {
 		session->supported_events |=
 				(1 << AVRCP_EVENT_VOLUME_CHANGED);
+		/* Check if transport volume hasn't been initialized then set it
+		 * to max so it works properly if the controller attempts to
+		 * subscribe to AVRCP_EVENT_VOLUME_CHANGED.
+		 */
+		if (media_transport_get_a2dp_volume(session->dev) < 0)
+			media_transport_set_a2dp_volume(session->dev, 127);
+	}
 
 	session->supported_events |=
 				(1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
-- 
2.34.1

