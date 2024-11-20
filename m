Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B642145B18
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117701; cv=none; b=jzzD3uBDPCP1JZfC9R2EgqjcPJoDV6Slxw4Ab9I85ZsZwRhs5whzy70HjntK9zRY213Z7O6CGkd7mQzqYk8Z4Wac8H9I62CiLL/gY7+KBOrllkM9GAgWkE22oL7EkOpDQZSmQ1bCtutJYsCySDbsusj2wNl2c0uSzkLZ69cAc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117701; c=relaxed/simple;
	bh=NKy+6+XqxHs9rjFbp1To5VN6MBSlH6B16sGVycoO/Fc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jEJU2UX3/NLBtCo4Cow7Mb2hUi72rGRV8GI53BrUD+PkXVbaGWgvkxksp6FrlgXuR9dLRbIbk51yoPEDAPlf6RXlCMkRJcsFRWb/xofEZ57foGFnBAsDS7aa0eqxu20ZQ2Y411OqvAnLcNquG7FzWHDTFG2WaPUtrM0PQR/2rPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IV57XJq6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IV57XJq6"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKAjqt8004507
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 15:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=6XGXoBfMfmjtFxBPjo1u0ZydiFVBYYQ+Xnhb+wF/31w=; b=IV
	57XJq661Z+ETvQtFTvGzE9L9pxoaOZeJSxQO/kG0Khp6PZNcAuS+LLK5iweL4gaW
	ae+CqKD/wINTyaO/nlopBadZ2tNWYNna4XmBGgblwVgbPD62POilg2ga9mPmWUvQ
	5cvS6OrxGUwHnRDLDTJ0s0wVAmdvXtqIviU1LTwcjf2XCDCbSQHATxFlG8qmmNlj
	Mss+p7a8ehTIxy5QnUBoFHq/FJFRpFhFX3DEN+Jq8Tg2x98gfGWuHnd9G9XbGbA0
	AjJGtA4iZDF4sxSZDASyOmkDE4/rVw4S/6hui3DqyqJdpoM5sl6pQffxZX6Iwjdo
	V71RgTwje3VKP01aE6Qw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431ea70rkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 15:48:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AKFmIf4019967
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 15:48:18 GMT
Received: from hu-prathm-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Nov 2024 07:48:16 -0800
From: <quic_prathm@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ] Fix for broadcast mode, not to add any AD flags in advertise Data
Date: Wed, 20 Nov 2024 21:17:55 +0530
Message-ID: <20241120154755.1951-1-quic_prathm@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PA3Cfhrey6--PsETmrApq-GiwCyUyUZj
X-Proofpoint-ORIG-GUID: PA3Cfhrey6--PsETmrApq-GiwCyUyUZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=548
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200107

From: Prathibha Madugonde <quic_prathm@quicinc.com>

src/advertising.c
Include check for broadcast mode:
AD flags shall never be set for broadcast

Test steps:
From DUT, bluetoothctl go to menu advertise
advertise.secondary 1M/2M
advertise.name on
advertise broadcast

---
 src/advertising.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index bd121e525..2fc6f917d 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -759,10 +759,15 @@ static bool parse_discoverable(DBusMessageIter *iter,
 
 	dbus_message_iter_get_basic(iter, &discoverable);
 
+	/* For broadcast mode, need not add any flags
+	 * just return true without adding flags.
+	 */
 	if (discoverable)
 		flags = BT_AD_FLAG_GENERAL;
-	else
+	else if (client->type != AD_TYPE_BROADCAST)
 		flags = 0x00;
+	else
+		return true;
 
 	if (!set_flags(client , flags))
 		goto fail;
-- 
2.17.1

