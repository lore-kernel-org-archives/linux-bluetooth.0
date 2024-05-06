Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BCE13FD9E
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981271; cv=none; b=htD5s8xAebiLWxq79lzx77YmOhuiYHrJ8N5obKOAvtkXzWX6jlV/vnjrwCRxLVoPvohMASthrP9ockJOkGlmAmyuQQEyMfdN5YznxdVm3F3IJYHo3mNu52kC90pf0PrIccOeLpl7QL4iVHsYQN88gTkjK/pipsHLr23flIU5akM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981271; c=relaxed/simple;
	bh=OtiiaCZBUQgEU8CU41m34kPD/LLGp88NbWEksYRolbA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kL3UGe0rB5xn3hVJswNCeQSUFzCflonCccdFeDqhmQJkXXbs9OLw4OhTACB0rpBzi80GvOW84btH4Zbh1taZVhh8BNf3RIs2nNeaOxBTgZto9g8H/l4fdTv/qTh0NaBLvRoWW3Fhr0KX6rmoI2JXcIaFTTKmU/hw+ovbSsXkgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QTLXheFy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QTLXheFy"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4465apBX025065
	for <linux-bluetooth@vger.kernel.org>; Mon, 6 May 2024 07:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=ERm++eDuVMgwhJNMy0psDMiV2eZnHtMBqKuQBs/W5KQ=; b=QT
	LXheFypBwlRqK6qReDaE4EHaNtZ63vIli/f9jr6K5f7QR/q7Tqe8fcveYx38iTWt
	gS6jzQdypLtuEqBA6/v8v7uRu1U1C2YZ1NB3EwxQsbBzTB0XcqOAuTY5MY4CgXjD
	f0D0vaGWs7HZkTI33D9xaHVDzR9rp5gQtigE3RPX8Cm+7BDn+yn9tw685Mq8mCS1
	USPNI4b0fWAKzGGrnGzqKHzh0fqKFgAgG3Sqwq6AsCkjsshlIXRdHmPPRfHuyKIJ
	uhuuCt1OkMCQ8PjT89/46ngTUw1pXz7afEo1yhL4DD9EzZUUIwbSTHJQHkNgc3mU
	dRjtrom98HPQV76h6JeA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwdsmtv2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2024 07:41:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4467f7cQ018188
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 6 May 2024 07:41:07 GMT
Received: from hu-nakella-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 6 May 2024 00:41:05 -0700
From: Naga Bhavani Akella <quic_nakella@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>,
        Naga Bhavani Akella <quic_nakella@quicinc.com>
Subject: [PATCH v1] Bluez: unregister-includes option is not working in bluetoothctl
Date: Mon, 6 May 2024 13:10:43 +0530
Message-ID: <20240506074043.4200-1-quic_nakella@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DKzc9tGWPV4xnb9ESpUUVLhoTU9sKmCj
X-Proofpoint-ORIG-GUID: DKzc9tGWPV4xnb9ESpUUVLhoTU9sKmCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_04,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxlogscore=639 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060050

unregister includes option takes two parameters service uuid and
included service uuid, since the space between them is missing,
the menu option is not working.
When two uuids separated with space is given, it is throwing error.

Signed-off-by: Naga Bhavani Akella <quic_nakella@quicinc.com>
---
 client/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 51d08a67a..c8b0f7f1c 100644
--- a/client/main.c
+++ b/client/main.c
@@ -3060,7 +3060,7 @@ static const struct bt_shell_menu gatt_menu = {
 					"Unregister application service" },
 	{ "register-includes", "<UUID> [handle]", cmd_register_includes,
 					"Register as Included service in." },
-	{ "unregister-includes", "<Service-UUID><Inc-UUID>",
+	{ "unregister-includes", "<Service-UUID> <Inc-UUID>",
 			cmd_unregister_includes,
 				 "Unregister Included service." },
 	{ "register-characteristic",
-- 
