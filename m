Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C93C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Nov 2023 05:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjKFFuk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Nov 2023 00:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFFuj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Nov 2023 00:50:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33997CC
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Nov 2023 21:50:36 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A65Zo2G006535;
        Mon, 6 Nov 2023 05:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=zpxWTQQ7W1m1Sy6aD1OtEpK/k2ISpi/PGMjC1ik+q/Q=;
 b=ee6gG0riV6awoe/2ShDiIiBmCNageibqAd8Rl8tnhqgxCQjrKO/4cTePwLCsra6ySoUA
 TPjb/196xfUJZRVw3NlRwKFhRyyUAnpJTzZHLP2/Wl1StG+2BPKXlZxQ/pTHbBwrnac5
 43cveZTCNWX9Pmj7ACzpGp+TO2zEX4ucACnoslg/sw5+LT+fLd/C0h6qpaNMfAsTXRke
 BLB2r9/hN55dnHrgtIZEXOxKLOZ/wUh3PeozcNHsePUFXVw5E/g+0Jh+IuCIPz3brAfS
 6hXw5IYY5z2vyxRxO9ZfAWeSljER8BZ1qX1iPNwvC1w3NiOD/+DzES0H5YP970Cm1fgW hw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5f52338c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 05:50:32 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A65oVBX028866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 05:50:31 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sun, 5 Nov 2023 21:50:29 -0800
From:   Zijun Hu <quic_zijuhu@quicinc.com>
To:     <luiz.dentz@gmail.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 1/3] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066
Date:   Mon, 6 Nov 2023 13:50:24 +0800
Message-ID: <1699249824-20358-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TjIhsOZV7qXjwVRpKklzVPhbPd5cbmzB
X-Proofpoint-GUID: TjIhsOZV7qXjwVRpKklzVPhbPd5cbmzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_03,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060049
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set both WIDEBAND_SPEECH_SUPPORTED and VALID_LE_STATES quirks
for QCA2066.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 067e248e3599..35f74f209d1f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2039,6 +2039,7 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
 static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
 	.soc_type = QCA_QCA2066,
 	.num_vregs = 0,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
 static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
-- 
2.7.4

