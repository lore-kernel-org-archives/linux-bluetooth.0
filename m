Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589D40849
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424457; cv=none; b=dynSJQYRAD1fGqUSLF0vYtExt4ujzTP6396pRMZoxIuQSoA6oRjeszChi3s9Ds1/Hpi9AkmBJ6PmkQmVBAHdDGIkfYfwsOlq+7MF81IilGwJn88rGmxFOnF+qK+k4xRRSlfzFfu4nMdL0u1hz/g78i+lctnSvh1GPqXitjzs1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424457; c=relaxed/simple;
	bh=ixCPzW1ccpDhG+/+IkDkfruvnCcggMsOW+TKAo7Qk/E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V0a1UPfLyebqgNKCwfXrgd4g/93R7SOgW0HldV6L+Bi741PwZ5diBxAdFGdZdchCxGx+erF4GpnnWuPULCAOhm3wCg9IG4mU8tFEoPP1bV9zsaK7AeChryvfvZn9zMN6VAQUMhZ8ND/Wmjbg+0Ps1ok/7E/4IjN407h/yWr6aqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=evTWcLaX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="evTWcLaX"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467NhUt2028546;
	Mon, 8 Jul 2024 07:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=N9nBTrkjy1BzwjrFUsyjS6pJdLct48VrCxrneLwaH8k=; b=ev
	TWcLaX9MzXtxiBDWcb0anyoAaM1l5Rrfrdc6LBahOba+WBhHNRdAzC3P3UrTgtBo
	ZlrrZvMxlPo2gteF4AYFL/NJxkdz6ZJOjISHQ6aFdCxfvk7Y8saWou+eHT8ItDYY
	ZoQhxQqOlkAEy2sbWmpIa7+i1cROrE3N+j0QFUbFlOW9uUmmSUdgh5Wo5jGHf5sy
	9ZhW0oByGaTEszrXnH0BdRsC0yzHhhYc+/VW9c+47YvT+PyBETq/2jRdtnC+Z9TX
	szvdZxxkckufqglolNDncr1KrAhltDQui2QEmms2+ojQN0OTG7eztjNu+jLVt7GM
	tzNoj8yK37lYBN6pgQyA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wjn2y2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 07:40:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4687eh2d031158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 07:40:43 GMT
Received: from hu-prathm-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 8 Jul 2024 00:40:40 -0700
From: <quic_prathm@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <pmenzel@molgen.mpg.de>, <luiz.dentz@gmail.com>,
        <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ] Fix discoverable property not emitted on updating value to false
Date: Mon, 8 Jul 2024 13:10:24 +0530
Message-ID: <20240708074024.5300-1-quic_prathm@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5RfjZPLb6b60mmWdqWkWRydLP3OsdBU0
X-Proofpoint-GUID: 5RfjZPLb6b60mmWdqWkWRydLP3OsdBU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_02,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=964 clxscore=1015
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080059

From: Prathibha Madugonde <quic_prathm@quicinc.com>

client/advertising.c:
Allowing discoverable property to list in the parsing
function when discoverable is off.

Test steps:
From DUT, bluetoothctl go to menu advertise
set discoverable to off and then advertise on.

---
 client/advertising.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index a9b865a65..4a98121a4 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -416,12 +416,6 @@ static gboolean get_data(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean discoverable_exists(const GDBusPropertyTable *property,
-							void *data)
-{
-	return ad.discoverable;
-}
-
 static gboolean get_discoverable(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -498,7 +492,7 @@ static const GDBusPropertyTable ad_props[] = {
 	{ "ManufacturerData", "a{qv}", get_manufacturer_data, NULL,
 						manufacturer_data_exists },
 	{ "Data", "a{yv}", get_data, NULL, data_exists },
-	{ "Discoverable", "b", get_discoverable, NULL, discoverable_exists },
+	{ "Discoverable", "b", get_discoverable, NULL, NULL },
 	{ "DiscoverableTimeout", "q", get_discoverable_timeout, NULL,
 						discoverable_timeout_exists },
 	{ "Includes", "as", get_includes, NULL, includes_exists },
-- 
2.17.1

