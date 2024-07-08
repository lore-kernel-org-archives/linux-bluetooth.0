Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC6D8C04
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424722; cv=none; b=bn9/R4jtlTo/YzVxrvdFq+Vw0jDYgL/2TAfFAsmXr9UWQUDXpPka2rP3Padn/XCTat+WnHqhZWaeKwL1EW2otu/WP5lyVRLMiihCJMGWv7ovduZbDsyRTj90ANMU68q0RihBNLpNSOJHOlHOnyRRpK508s+OOrHghtIYBMP2DEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424722; c=relaxed/simple;
	bh=PC/eUy9eh22xtg7FpyKkEHI/F5GMXirSO01qk7OqKf0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M95kbfHEaFyvhQ9070Ha8ivtIdjELRlhV/JZ148rnBSeTk+Y5XwLcfoVKecCNSidtCVDyeHvCBRrjOTaJhD40MnVsTVGKFD70f7Jb7MuXyaYweKd+TAwTt3yNkbmTf8BkiMop+n+eOppEdgePA/Bz0SnVwxl4Ld+CP0uwLwOd4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ls2/51VB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ls2/51VB"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467MvaGI026786;
	Mon, 8 Jul 2024 07:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=q9zn6q3x/6iv58NyF1j53+Itb6IFoPeH5zAc/JHqkjk=; b=Ls
	2/51VB87nVOiPF6oMi1OAjzKKy9efOAx+Fn2Yik+fAVNi2llvmyPQC8MuDg2y62m
	9Idy6TtsUmjXmoq+cxkDRlm33xJAsQAWxGJXoxlFTDXM8osUahoTNHAbcqn0ihKQ
	UJjPJefgnpMj+3qF3yF0quII1WONW4N8ZGvsOMYwtVx6D3gzcsmhz4zXVzu218Vx
	v6zd1mkd7Ay++kQrKYhdGm2XxD+FTGVZ0pDUdVxgLqp3q7nhsH88l4pRSXFezPl8
	34Rl84TcjLVYZVPyLYp1aoUrjzI+dxp9leXAsGWQZBls5ClmuwPTUOqrrROuFPEE
	zpH4/YNWBiZFAf2+H8GA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wg3tym9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 07:45:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4687j7rO015061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 07:45:08 GMT
Received: from hu-prathm-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 8 Jul 2024 00:45:05 -0700
From: <quic_prathm@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <pmenzel@molgen.mpg.de>, <luiz.dentz@gmail.com>,
        <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ] Set BREDR not supported bit in AD Flag when discoverable is off
Date: Mon, 8 Jul 2024 13:14:54 +0530
Message-ID: <20240708074454.5891-1-quic_prathm@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Stvj-_O82cMur-izubWE5NZa2DB3QyKZ
X-Proofpoint-GUID: Stvj-_O82cMur-izubWE5NZa2DB3QyKZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_02,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080059

From: Prathibha Madugonde <quic_prathm@quicinc.com>

Fix for GAP/DISC/NONM/BV-02-C
As per GAP.TS.p44 test spec
IUT does not contain General Discoverable mode and Limited Discoverable
mode in the AD Type Flag. IUT shall send AD Type Flag to PASS the test
case, thus set BR/EDR not supported bit in the AD Type Flag when
discoverable is off.

Test steps:
From DUT, bluetoothctl go to menu advertise
set discoverable to off and then advertise on.
In AD Flags BR/EDR not supported BIT shall be set.

---
 src/advertising.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 5d373e088..af3ed2b93 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -734,8 +734,7 @@ static bool set_flags(struct btd_adv_client *client, uint8_t flags)
 	/* Set BR/EDR Not Supported if adapter is not discoverable but the
 	 * instance is.
 	 */
-	if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
-			!btd_adapter_get_discoverable(client->manager->adapter))
+	if (!btd_adapter_get_discoverable(client->manager->adapter))
 		flags |= BT_AD_FLAG_NO_BREDR;
 
 	if (!bt_ad_add_flags(client->data, &flags, 1))
-- 
2.17.1

