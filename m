Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562F92153C9
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734699544; cv=none; b=O8usf2MqHsrShHhIrOSjIeaHk0H352ZPpj9T+3bfULCx3Q454xFbWv/o+M/KAnmX8OXlUCI+MJtet8NmNIGgbCob6uH9rG4mGQXlStyrSUFYdSjyQttP8fKbJt6MyCIyxSxT4nLvsYu2ognJgV82dXJB4B2JG87Ewld2RhZb3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734699544; c=relaxed/simple;
	bh=ZDvJAQKfNxlE4EQTdpZ1iMs4GT1gT/2m/N6pOOx1Op8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BfH4/YL0ES+D8YOaQbE1ex0i9HpCRUWQgOnFihQnHN+YwinSQMB5qaS0f6w0TfwwsOCrwRwNqDky1SUcL+Bo3c7rFwEuoOJjuF5x8NA8S3qgiM8DOzhmHgqnKFxcojXSblQs7KvZbmcpAN9uTxtTDVkUBZZ8//goRm9aj2THJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fDFxY+Yw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fDFxY+Yw"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKBv3pX021773
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 12:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2l6YMHD7Y5Hmdc4fcb7zH1
	S6i0MypFFn80zQqzpHvcc=; b=fDFxY+YwnyaYmkUZIT4SrNF8Whd35ktf9yWeIG
	8qJc7eXmUPXs3rmIoI+A6AuHslhAGY88+HX7K7cNPXLQdwDrupnRngPaoYimdj5e
	d9lhN0Pl1+lRbkMaPvnbSoCWW/YdaN4AlFY9qTV3mAXqnCj1ijqLBTvOq5DzD/q3
	Y5DZdxLpQmNV9CQS9O4iwkb9Wfad4ejizPET0uLUd/zrScOVLx9gPmVPjf24zhta
	yPXGtBvhU0G9CBgPjAN7macftqgz6ycyDG8rS2n8Qgo7n8sEaz6FC+u6GdKf8nqz
	dvjplJbl0gbQ0nLPMEKWZoZYsazYYzKDhYLTe7XiP0R+jbyA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n85d84cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 12:59:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BKCx0ni016798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 12:59:00 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Dec 2024 04:58:58 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obexctl: Implement support for message listing format version 1.1 for MCE
Date: Fri, 20 Dec 2024 18:28:48 +0530
Message-ID: <20241220125848.84645-1-quic_amisjain@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: muGLtLmsLZGek7bBVenfxVN010HCwaoq
X-Proofpoint-GUID: muGLtLmsLZGek7bBVenfxVN010HCwaoq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412200107

This change is corresponding to obexd changes done for implementing
‘Messages-Listing Format Version 1.1’ .
This change will emit the newly added properties values in obexctl
which are sent by server.

---
 tools/obexctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 0965762ce..463d5b0ef 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -477,6 +477,11 @@ static void message_info(GDBusProxy *proxy, int argc, char *argv[])
 	print_property(proxy, "Deleted");
 	print_property(proxy, "Sent");
 	print_property(proxy, "Protected");
+	print_property(proxy, "DeliveryStatus");
+	print_property(proxy, "ConversationId");
+	print_property(proxy, "ConversationName");
+	print_property(proxy, "Direction");
+	print_property(proxy, "AttachmentMimeTypes");
 }
 
 static void cmd_info(int argc, char *argv[])
-- 
2.34.1

