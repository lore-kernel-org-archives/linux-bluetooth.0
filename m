Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF42217C98
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923374; cv=none; b=sY7MFNqJk0PJ2JQyrXE5TUY7yKhUU8eu9sTp6uedAuYlUUnxI4bpj1hxjCbS7FfzkuufuI/uS8uFlXpx5oxhF4X2fgqt6c8BF2XK3UefjlNkZNELFL3UFLUHOVGsUolzto0PczT9yThBpiZ8P3azlO+Nu/M5yYviefnYSbJ7hUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923374; c=relaxed/simple;
	bh=kORZ+eZRjw6a03yzohXzvG8X3wAP6OTE5s2behH2eDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YtqKd91uBTYZDENJpmE6q2GW7RQrFhHf8dyLetQQm5HcgoeP5RsEqJZNCzpfDqkySs6xwvTVs4jL8b2w6waXyLWdsZP+wpKfMNtxHnwPPyy2qbDzS7sz3Str5s/eH/dag0Vd85vBFcFGk6u6WKy8MRBlDH48NlMUZD/nVAjWRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=APzTdwYt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="APzTdwYt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI5RkAT004211
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 09:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZJQiCIZcMS3IC3rXoOlfp1
	zN5yrfRfFDkHHOi05w9mw=; b=APzTdwYthw6cs0gJ9acXEiREdIkSpJ006lotMw
	Hp+v/7SLuzaGxgskKFllfXmbKOPO973oTAL5NqxA0OIOXVbCHS9CscLsfOzs+UoL
	Aa4ntbN6wIITCTZAmH26cwFpiYDo8NCMnH48KatUqosCPB4G86c39jWTX92hsb77
	0zjSzmGBYKyU/EzRrqaomcj+48gU4E1imWvNfDHDvuF74KxqPi97UaUK8TtTQgoE
	bKeEpAQZsUcrtK3wbitXGE2L+E6Dt01xR7oYaW7hm2AJmmGcly9CPnsokYpPeTEx
	rZqIFoolkBmdxOTtkwwVNqgSfK3YWZxtEv4LXeZODozINF4Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42xm5g430w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 09:49:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AI9nUlS022843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 09:49:30 GMT
Received: from hu-jiaymao-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 01:49:28 -0800
From: Jiayang Mao <quic_jiaymao@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_chejiang@quicinc.com>
Subject: [PATCH v1] hog: Check security level before setting
Date: Mon, 18 Nov 2024 15:19:07 +0530
Message-ID: <20241118094907.2673431-1-quic_jiaymao@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VmdV_fQ2VXBOT53oooBu1GjMnKn0SXSM
X-Proofpoint-ORIG-GUID: VmdV_fQ2VXBOT53oooBu1GjMnKn0SXSM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=758 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411180081

bt_gatt_client_set_security could fail if the security level is
already BT_ATT_SECURITY_MEDIUM. So, get and check the security
level before setting it.

Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
---
 profiles/input/hog.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 017e320f0..011cc0a88 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -191,8 +191,10 @@ static int hog_accept(struct btd_service *service)
 			return -ECONNREFUSED;
 
 		client = btd_device_get_gatt_client(device);
-		if (!bt_gatt_client_set_security(client,
-						BT_ATT_SECURITY_MEDIUM))
+		if (BT_ATT_SECURITY_MEDIUM !=
+			bt_gatt_client_get_security(client) &&
+		    !bt_gatt_client_set_security(client,
+						 BT_ATT_SECURITY_MEDIUM))
 			return -ECONNREFUSED;
 	}
 
-- 
2.25.1

