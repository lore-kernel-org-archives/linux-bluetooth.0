Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8715B971
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089912; cv=none; b=QrRsEnTshnuVSQUsDLkoFpIsWP1vo7dlwkbhYmsNCYeFK2VTOVQISbeY4XxCwZJnMBrY7LI7l0Ut/1dxBv1M6QDydLL74NasbRUunvcOxId5KQ8BCWDesx2gxMr8GoryloXu32gtbDUQHblN+wOeOIOq7pkYN82Ka0MMTEFvucw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089912; c=relaxed/simple;
	bh=4bhvU57idk+ei/y+hWffPOVnQ8/vWhp5Yt/UpS/aM6M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FHEBV1vCBsoAlsEfeVkE3SaiYyIsY5aPS0LVDGJOEJkxQQJ+fSvBSWKnx0lYC35D0J1qcmsjcIGF9btpxdvOB0/CIJtutRge7INms4ROYT0FmjUKx9c/bk7kg2IP35jzP7vP1htLYSePj0M//gmetL3yUQMBd/trUc/mnln+Tww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AYk1MEhr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AYk1MEhr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK4roEt015120
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 08:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mXkglym466oGoYbdm9XLX0
	KVcvKPs+pwgnkJfeW07PI=; b=AYk1MEhrJxG06NcsdnhSF8pGH+TtaG3GYISGr0
	uyGNHohHe1KT29x631ZNqbk5c0N9rKdX0BEu4my2/K4+9cunIqbOkqRSZ+KWFqqk
	45Z7WpeTMnmMoel5VIkcDZSPW8/BjrVkHFpLxGg1wDHVqQD9jyYg3nAIrni0UxYE
	PIzuDoPmqu8A/+3givzZ7FIICH3daVqBgYryZ6z1drASdHg6oeTqGgR2QGTM5C2K
	5lxzLbnt8Rmk9m8uJMH4TYW/KlC3VLZFKdQLxCWIS1cJwrGKaLtZhDYl5NK0EwwS
	OJO7lh+mmSIJa0wZumN5icgIYiXBqvYhmSxz8Dg5jXdQoCqg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4319528d45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 08:05:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AK859nN009954
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 08:05:09 GMT
Received: from hu-jiaymao-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Nov 2024 00:05:08 -0800
From: Jiayang Mao <quic_jiaymao@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_chejiang@quicinc.com>, <quic_jiaymao@quicinc.com>
Subject: [PATCH v1] att: Check security level before setting
Date: Wed, 20 Nov 2024 13:34:47 +0530
Message-ID: <20241120080447.233393-1-quic_jiaymao@quicinc.com>
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
X-Proofpoint-ORIG-GUID: eS94Pqkn1qPfbgJmcHH9xt8-h9NnSjce
X-Proofpoint-GUID: eS94Pqkn1qPfbgJmcHH9xt8-h9NnSjce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0 malwarescore=0
 mlxlogscore=611 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200057

bt_gatt_client_set_security could fail if the security level in
kernel is already BT_ATT_SECURITY_MEDIUM but long term key is not
ready. So, get and check the security level before setting it.

Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
---
 src/shared/att.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 4a406f4b9..dabbdb431 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -727,6 +727,9 @@ static bool bt_att_chan_set_security(struct bt_att_chan *chan, int level)
 {
 	struct bt_security sec;
 
+	if (level == bt_att_chan_get_security(chan))
+		return true;
+
 	if (chan->type == BT_ATT_LOCAL) {
 		chan->sec_level = level;
 		return true;
-- 
2.25.1

