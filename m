Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D63EB0EF
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819833; cv=none; b=JoK6yBc7IZW06bUg2QU+dgZ8EMLvLfMxlpLOV38GX412XHjE7Zx85RXg2XPANPgUQQGde3UEHyvyFVPSvsqe2L16emO4K9YmfK+BzDkpS06ayhChInahhEh8z23MbsQqntTlawNNJVSN9QBdxBW5w0o+gSudqojanY2KSe1vYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819833; c=relaxed/simple;
	bh=7O6MbaId9Nb8b9j0WKr+vsl9Jx2BGX/0q90+hpo96iM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LCejEY+sHLp4VNNVzuPztstXWwBMCgzSoM0RjjmxBTUtklU4Z+aOLr30CKAc+YJ6thX5YdXctHWmTOy5VHgSQAGChRyYf0zc4GmaE2dXM86AqatdXb9+EaqgBm86AzW/bN7QvaDoNfCvQ+1esu4lx6dfx1CaD40gUikxQn4GeQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b/dpgz6Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b/dpgz6Q"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R76g9e3226533
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 08:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ShcgQMBctIsn8TZEMCISgCsr983aptjCTwN
	f435bejo=; b=b/dpgz6Qmg0K2RS2LjdhialOm5gTVvnAIwpVRkkwUnXXcCIQ4II
	CU4B/1Dy0oulSQ2hSA8Fc2UrlJcKnqRiN4uISckxH8qQRm+Lz6cWMuITKmvDBrgI
	L9xd+Fis+Xg+SIr7nEv6ZZEKgnJDALTms6Wz/I5a/nXbjYTuI/iiZ8iP2wioNc5v
	0gEDv50a77z3jT94MpeRHLYc9gFeEKesGbCG+l2Hv4Vm79xCJA2ADFbhoFYOa41p
	DwtgRp81y4ONd2B8tiybm0BLC8Xu2kLsHl91y8lVYxXvj8RhtFHCTT4EWaJsXeoH
	XbGTJ+EH15NeuSBcRd4PTHq6df/5zgopLrA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfrbnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 08:37:09 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R8Y0ut029399
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 08:37:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4g74ujdx81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 08:37:06 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67R8XrNM028811
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 08:37:06 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 67R8b65R000578
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 08:37:06 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 4453D22925; Thu, 27 Aug 2026 16:37:05 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1] gobex: Fix ABORT response being discarded
Date: Thu, 27 Aug 2026 16:36:51 +0800
Message-Id: <20260827083651.1355587-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Id1KnHadJ1_n-sVZeJIvyV2O-ygRAiTT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfX8K4uGGLm4wwQ
 5IgQJjLj4IvRPnsZSxW3szVIo2cKQNiezsRKKMGx9oT03GrvJBySbQY4D9eBU29WXNWNgsABAzu
 w+qptXMVMr/yMhbjIpLq+AGiz7zTRUqzgEdIoBx5AOVGL6EtVgJAudr1O0FOtLk6c7MWjzuaI/v
 qgSTTDur9rQQ1cyWUkLdGlUcDrRywMtjxiDh/Kp4RmH7ZeETBWxbOGkrD59w9wv+RqT4EsL8Un2
 GApVmTKfTe2kUtASUsb65maWJTrE3a2+UsnrpUoVYHxqtRqJw1cWbJTmMvbbzhpC0BfzhDhXWqj
 kru/EBeYR8B1es57ui3aJFgxWMhsvhIeMw33mirw+x50f7FOIPtsmCUkqWiHEgk7CiOT7fZ4wq7
 CTI6rkb5bA1r6qEOLJFuE2hpVqO6GDZFCwgtoXMQB6iUxKdYEdsFpgGBWjTESLDtkhmIvxDO3gN
 KPGFZ4ecCE/oZO/dEQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfX2ApPZ0d1ayIT
 JCoLJqDQ0rVvn+9nqqY0KjspRK7vDFMj6McEDjwWiAXXz1ts9YFfbZy0cRGArf9disuuPY8L4oi
 uoP6tEZA5ei+Ge6ZjfmgKSjEsqImn1k=
X-Proofpoint-GUID: Id1KnHadJ1_n-sVZeJIvyV2O-ygRAiTT
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a8ff735 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=Ve9YV43bfDj327hqASQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270070

g_obex_drop_tx_queue() in transfer_complete() clears any pending tx,
so the ABORT success response should be enqueued after transfer_complete().

Fixes the following PTS test cases:
- OPP/SR/OPH/BV-27-I
- FTP/SR/OTR/BV-02-C
- PBAP/PSE/PDF/BV-06-I
- PBAP/PSE/PBF/BV-03-I

Fixes: 7a35c12a6ceb ("gobex: Fix segfault caused by interrupted transfer")
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
---
 gobex/gobex-transfer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index c94d018b2..e4c7c557d 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -314,11 +314,12 @@ static void transfer_abort_req(GObex *obex, GObexPacket *req, gpointer user_data
 
 	err = g_error_new(G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED,
 						"Request was aborted");
-	rsp = g_obex_packet_new(G_OBEX_RSP_SUCCESS, TRUE, G_OBEX_HDR_INVALID);
-	g_obex_send(obex, rsp, NULL);
 
 	transfer_complete(transfer, err);
 	g_error_free(err);
+
+	rsp = g_obex_packet_new(G_OBEX_RSP_SUCCESS, TRUE, G_OBEX_HDR_INVALID);
+	g_obex_send(obex, rsp, NULL);
 }
 
 static guint8 put_get_bytes(struct transfer *transfer, GObexPacket *req)
-- 
2.34.1

