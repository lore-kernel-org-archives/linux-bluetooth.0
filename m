Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E104BC4167D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Nov 2023 07:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjKCHFa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Nov 2023 03:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjKCHF2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Nov 2023 03:05:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C915E3
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Nov 2023 00:05:22 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A346UT1023225;
        Fri, 3 Nov 2023 07:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=UDBd+UsEoO/swDlHvRiqOaa5Ukou0ic4thdZTh51sZA=;
 b=MLayaTIF+/TezLXjZtebZ8qCgnbmf11Zixj9WaTeEyO2LLhdFrB/GKZU16EfdXtXqB9S
 VxjUoe4yQqC7hwldDtBHylLhAzPHH6LYR4UMsa1VNkf93Ep0UlbAY8bVd5p00WTrp1zJ
 NW9sWoS+2PNbO9S8Rwzg3EgTbMdoSo9ztt6V8ZejUmm36Z77dVjyos/VDiZpxujRLU2z
 ABuOiZgscUUXPaRv8j8yerVFIQk+XfrGeeO0Kiwq9T3OV4YuheztEphlm2HAP1u46000
 Zl3VKeJCu7bKxD9eTmQWb2I0BSEkUabmBelcTaJChfjXtaNpzSq4tkxPz4QYKzQJ8zhE Bg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u47d52h42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 07:05:17 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A375Ggh032732
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 07:05:16 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 00:05:14 -0700
From:   Zijun Hu <quic_zijuhu@quicinc.com>
To:     <luiz.dentz@gmail.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>, <jaikumar@google.com>
CC:     <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v2 1/1] Bluetooth: hci_event: Correct power save marking logic
Date:   Fri, 3 Nov 2023 15:05:03 +0800
Message-ID: <1698995103-2273-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698917302-28018-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1698917302-28018-1-git-send-email-quic_zijuhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hYu2vuA_0whFnVKmBhn-E3yXwnY_gyGt
X-Proofpoint-ORIG-GUID: hYu2vuA_0whFnVKmBhn-E3yXwnY_gyGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_06,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=932 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030056
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HCI_CONN_POWER_SAVE should stand for non active mode, but
hci_mode_change_evt() wrongly set this flag, it is corrected
by this change.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 net/bluetooth/hci_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5b6fd625fc09..95a582bffc32 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4590,9 +4590,9 @@ static void hci_mode_change_evt(struct hci_dev *hdev, void *data,
 		if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND,
 					&conn->flags)) {
 			if (conn->mode == HCI_CM_ACTIVE)
-				set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
-			else
 				clear_bit(HCI_CONN_POWER_SAVE, &conn->flags);
+			else
+				set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 		}
 
 		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags))
-- 
The Qualcomm Innovation Center

