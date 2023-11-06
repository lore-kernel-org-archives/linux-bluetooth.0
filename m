Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3568BC4167B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Nov 2023 06:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjKFGT7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Nov 2023 01:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjKFGT6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Nov 2023 01:19:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF426B8
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Nov 2023 22:19:55 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A63JjSs032138;
        Mon, 6 Nov 2023 06:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=IRqwXzWYKDpE55XOiiDsQRqxjpy7opdGeGkohcB1m5w=;
 b=RXyvluFUCRVvnFCWhquNmi3NUZVgAvCy6Yc5Wxkgb9b4VENZ0KREUXTyNoftD/WERig3
 56ZMmiznVoahu+6EPX6Jw3x+AdDB13nMWQQKQuOo+azRNzHl2tRqgUCKRYPYOV9iFQ0W
 NQUc0DKCAg22mKcuiENWjFQcGmO7SNhpa011mbgBDK47Qh86X1rB8Ezgds1HYArRPStS
 TJy0JHaI96GdJyLTlHsnBU2UwMyi/KZa4o9zsSlYPskiXr72y6MLI1xWBMcam3EHzf0C
 J4HIFkrOQxgIXNCbcmBAgHGnu9xifVporVTVPJN1SiCCJgdekjAipGngMcmJQkW0nUpK WA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5euyu7nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 06:19:52 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A66Jppi025838
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 06:19:51 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sun, 5 Nov 2023 22:19:50 -0800
From:   Zijun Hu <quic_zijuhu@quicinc.com>
To:     <luiz.dentz@gmail.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 1/2] Bluetooth: hci_conn: Check non NULL before calling hdev->get_codec_config_data()
Date:   Mon, 6 Nov 2023 14:19:24 +0800
Message-ID: <1699251565-28759-2-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1699251565-28759-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1699251565-28759-1-git-send-email-quic_zijuhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y20HxazDcgL448SyktAvssMY43bGDtrY
X-Proofpoint-ORIG-GUID: y20HxazDcgL448SyktAvssMY43bGDtrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_03,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060052
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Explicitly add non NULL checking before calling
hdev->get_codec_config_data().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2cee330188ce..d647eb4606a7 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -346,7 +346,7 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	/* for offload use case, codec needs to configured before opening SCO */
-	if (conn->codec.data_path)
+	if (conn->codec.data_path && hdev->get_codec_config_data)
 		configure_datapath_sync(hdev, &conn->codec);
 
 	conn->state = BT_CONNECT;
-- 
The Qualcomm Innovation Center

