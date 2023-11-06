Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C87EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Nov 2023 06:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjKFGDA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Nov 2023 01:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjKFGC7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Nov 2023 01:02:59 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16A0123
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Nov 2023 22:02:56 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A65wCbF019514;
        Mon, 6 Nov 2023 06:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=zpxWTQQ7W1m1Sy6aD1OtEpK/k2ISpi/PGMjC1ik+q/Q=;
 b=cj5027Te7IW+blYILAv+JLoaa8qVHdzPUDKM9fjB8fNZy7DSe0VqNOMTi4bPEEptL+Nm
 bw/5ug6Oq/k23A9qXY6TLW87GCKLgMnQLLBcZ/KkN4RrcPpVTpOfAK+TPgHNxya5+I5W
 3YHkk5jWqQJWvnvmyO126xxqOCd8p+rHNK9CLILcQOi4zRQ9hSE7HUsm2ZuhFEXFe6hj
 V2B09dNvE5d8FcnqGPDg9CcjI3cXaptEdRLnPC5+BtR5ZsEtVYP823EaX/kX5Xn5yd/n
 l4YXEQ30vF+Nj5FgwN6HVkcELcGacL/gtOcBFw0+8Af/65fIvnWYOK8ha4lDYq5855FA sg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5eg8k5xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 06:02:53 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A662qFv002172
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 06:02:52 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sun, 5 Nov 2023 22:02:50 -0800
From:   Zijun Hu <quic_zijuhu@quicinc.com>
To:     <luiz.dentz@gmail.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v2 1/1] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066
Date:   Mon, 6 Nov 2023 14:02:46 +0800
Message-ID: <1699250566-17101-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6REV-DsxTw2Dg71QoreFm6xM0ojDtOv1
X-Proofpoint-ORIG-GUID: 6REV-DsxTw2Dg71QoreFm6xM0ojDtOv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_03,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060050
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

