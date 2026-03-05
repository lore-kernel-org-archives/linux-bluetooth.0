Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211D288514
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699922; cv=none; b=j7O/y8wkZ34V/IMnCsfkuESSMfDhUFqBRJ4XxtUdqiQIR22+e9sF8kK8z76h4f9bFNYO+U1AV0NbpJOjVE8NpuagtEbZnuJFemEIF6mB92dfVgIi+obgvv6fXz0UeHROXl7BDExOyD6If+KMFwbCqhAwJtxl4S154Nhpn8nvj4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699922; c=relaxed/simple;
	bh=GPOsCSHP3YbG4zZD6uKYQCcBV1Qp2RsSJp23TS0W5qc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lXMJzLxZNiCD6xPX5D2SZgqzpWfC3u9HR8EZE3YTRvkvaISv4BBTH97Vx/atlCaI/xBiAY2Qow13xTvrTctmsT/9u96zg5VuZjmHRSzBi6l4OvlM7tE8vDWzF9kYArV+GV44MPpb0Eq5y79MwWx0jmsj9swGa22Zo4y41se+rd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MQ/dhl1s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MQ/dhl1s"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6251C0uh3160514;
	Thu, 5 Mar 2026 08:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uy5VsUFXYoIUpguPl5972s4yQ7HUNhI3Kwh
	osvOIV1w=; b=MQ/dhl1s/XOCnY9XqDqDXzIGZtm5vVND/+BQgC+FbO/y0XEVcJQ
	sd74k4de90jRgEfR8hPeOhDxFIcewZck85YxA1gtEDpPLy7y1A3DSKkO4yplnnZT
	AbEcEr8Cen3hvMH2Jl+AV9s5KB2N/67t5KEIG7lsGUk/W6qDegWvwmWo9QbvA4VE
	Yw4OQR4TBZg/9QHNac8bsNq0WFiEgE2XV+/9l1mMd/Uo85HlihytAQBcc+o2bAmd
	vjXLztxZEYPK8asLHkS3WQj4eiUmy9oj2PWjoxN+4tBAEYajkEUfsIdplBJAvPRC
	n/GY69IxVn0Bn3K2OHxnqtp7j91rKxTm2Xw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpjh5uuy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 08:38:39 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 6258carS019635;
	Thu, 5 Mar 2026 08:38:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4cksemruav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 08:38:36 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6258catZ019626;
	Thu, 5 Mar 2026 08:38:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6258cZf3019622
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 08:38:36 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 217BA235B5; Thu,  5 Mar 2026 16:38:35 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
Subject: [PATCH v2] transport: Fix set volume failure with invalid device volume
Date: Thu,  5 Mar 2026 16:38:33 +0800
Message-Id: <20260305083833.369358-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-GUID: jn1jnwE7SvonHqxEgVSMEdXzoYIhxqNZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA2OCBTYWx0ZWRfX0ghOoHavOTi4
 LNEundRB7hn2V1aoNmipqUnWAQf7rg8Ib5F6JS2QvX2AY99VEohpDnuoPt6ewcdLZExBHYkewpY
 GfNEM29grrSRC/yjlOnt3yoH9q1E1XKhjAOT9oa3JlYBgVpwkd6qSXgmmAVbhiW2JEhfRVNSpiP
 MVNzhzZ4Q0wSoBL9Sw9uyV2ll9eO5naHUKhmLyvG17Li545ZZXmEV6ITW/67etzm57aBz23TsT3
 QIEQTqECCRTLhtfhrOPlvlff5E8IZniVFe2eIB1arcQajoosATfGzdWXJv7SaY15bAHbxZgz/bb
 oYbeZ6qF9LVynw+AebFcBLX1osOmJkU9tP/vnLXwQe5FrWtlqXMdGnckGCl2UCevX0QCJrUEyn7
 AUeZXt68olagsIwIjlyAZdgYpDX+zRmkYljJbKlq1mV/FLrimISpuYE92Dx7+QHka+wjMoKP5zU
 uNhOb/+Igai2Wbl9VvA==
X-Authority-Analysis: v=2.4 cv=JK82csKb c=1 sm=1 tr=0 ts=69a9410f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Kx5-L7xavbwsdZ5IZ0UA:9
X-Proofpoint-ORIG-GUID: jn1jnwE7SvonHqxEgVSMEdXzoYIhxqNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050068

When AVRCP is connected earlier than AVDTP, this invalid device volume
causes the A2DP sink to reject the peer's registration for the
EVENT_VOLUME_CHANGED notification. As a result, subsequent attempts to
set the volume fail.

Fix this by ensuring a valid device volume is returned when the device
volume is invalid, allowing volume registration to succeed.

Fixes: fa7828bddd21 ("transport: Fix not being able to initialize volume properly")
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
---
 profiles/audio/transport.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Changes from v1:
 - Return the max volume from media_transport_get_a2dp_volume()
   when there is no A2DP transport and the device volume is invalid.
 - Restore the default device volume in device_new().
 - Update the commit subject name.
 - Link to v1
   https://lore.kernel.org/all/20260122063640.310090-1-jinwang.li@oss.qualcomm.com/

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index d9feef768..41d8d0a75 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2767,6 +2767,7 @@ static void media_transport_emit_volume(struct media_transport *transport)
 int media_transport_get_a2dp_volume(struct btd_device *dev)
 {
 	GSList *l;
+	int volume;
 
 	if (dev == NULL)
 		return -1;
@@ -2793,7 +2794,11 @@ int media_transport_get_a2dp_volume(struct btd_device *dev)
 	 * of ordering between AVRCP and A2DP session start. (Note BAP+VCP do
 	 * not have this issue.)
 	 */
-	return btd_device_get_volume(dev);
+	volume = btd_device_get_volume(dev);
+	if (volume < 0)
+		volume = 127;
+
+	return volume;
 }
 
 void media_transport_set_a2dp_volume(struct btd_device *dev, int volume)
-- 
2.34.1

