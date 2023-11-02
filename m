Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B7CC4167B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Nov 2023 09:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345659AbjKBJ2k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Nov 2023 05:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345701AbjKBJ2j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Nov 2023 05:28:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A54123
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Nov 2023 02:28:33 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A288p4q000939;
        Thu, 2 Nov 2023 09:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=HywElSdgRpIV3IOF3qfdWFuuo0MQ+iaMCYrFMbx/pAo=;
 b=TNJCgoUUL4n3Y2HRtnNwiKmQTYiTkwfjgYwcIvUMnNj/LAGqwJUj7QL1F42+Z0A2ZN1a
 Vlk62aosbDkoNEruwGtSfCn/bd1MXQh8Z+zIy9+HmEBBTLmb2dKnr+cydRUaZ6ZCvAi8
 uvJxT7+ZZM9rFPXST9KW9mX1RZGr45Cji87B/Vl4Ze03Ptc0YfZZEllW60KHKiQRC6l8
 rm05wPGH/OztpiLG0xKDWDW2HFtyx4Q8zluremb7qV/0WfQ9cfW8g4ZUMeQq1PSAJLU5
 oBaGuod+EYcm37bNMRMlmmZ34wAQxpJPEDzHyGCmCAWY5K3Cjpkb9lAKAFw/rKouHO+1 xQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3y5y12ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 09:28:28 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A29SSGs019392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Nov 2023 09:28:28 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 2 Nov 2023 02:28:26 -0700
From:   Zijun Hu <quic_zijuhu@quicinc.com>
To:     <luiz.dentz@gmail.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>, <jaikumar@google.com>
CC:     <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v1] Bluetooth: hci_sync: Fix logical error when enter active mode
Date:   Thu, 2 Nov 2023 17:28:22 +0800
Message-ID: <1698917302-28018-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gotvY-IsVYuAWvpqn1uwQ9whWM0SuwcV
X-Proofpoint-ORIG-GUID: gotvY-IsVYuAWvpqn1uwQ9whWM0SuwcV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=682 adultscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020074
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

it seems HCI_CONN_POWER_SAVE stands for active mode based on
hci_mode_change_evt(), but hci_conn_enter_active_mode() does not take
this flag rightly and failed to exit sniff mode potentially, it is
fixed by this change.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 net/bluetooth/hci_conn.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 929d0e313db2..302fb5eaca55 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2582,7 +2582,12 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 	if (conn->mode != HCI_CM_SNIFF)
 		goto timer;
 
-	if (!test_bit(HCI_CONN_POWER_SAVE, &conn->flags) && !force_active)
+	if (test_bit(HCI_CONN_POWER_SAVE, &conn->flags)) {
+		BT_DBG("%s: hcon %p is already active mode", __func__, conn);
+		goto timer;
+	}
+
+	if (!force_active)
 		goto timer;
 
 	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags)) {
-- 
The Qualcomm Innovation Center

