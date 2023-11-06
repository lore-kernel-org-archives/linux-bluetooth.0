Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC06DC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Nov 2023 06:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjKFGTt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Nov 2023 01:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjKFGTs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Nov 2023 01:19:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B115DB
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Nov 2023 22:19:46 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A66Hivl015318;
        Mon, 6 Nov 2023 06:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Bl6iF9eJIsEbJmgKZ0MjEE3N3vdxKzaefKFT4glOBb0=;
 b=FHUhnRm/a0MZKxvY8Cix9VQqYqZZPGxWLUxPPaJfbve5GvXMaCs+a8hApBciCTdc76SV
 aM5Ms4i+Pm5N8O9C27dS1IQ37Pp5rLEbrhL2INaSPNE5C8HLVxi1mAHc/tq+cUIzlnfw
 F+9k/mBQg1DrQdLwfNqNnv6p/D7X3IYBBNylGbPbvK9ZmqmmMftdpbN8CSWjSopd3wNM
 JkXdjcR4kBD0jBKO8/+Yu0vTHtSfw9ux9cOHy7mRC5gkQFHgjc98A7AAdiER5zYmsf+e
 rMMhM0BIn2v1MQyh+0InS7H+DyThBWJpiFhRQ1GMnztobu/59AwGKME6tK6Xkm2uy9dT Gw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5eg3u82f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 06:19:42 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A66JfvS027256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 06:19:41 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sun, 5 Nov 2023 22:19:39 -0800
From:   Zijun Hu <quic_zijuhu@quicinc.com>
To:     <luiz.dentz@gmail.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 0/2] Bluetooth: Support SCO offload for QCA2066
Date:   Mon, 6 Nov 2023 14:19:23 +0800
Message-ID: <1699251565-28759-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vUjkgDVXf1efLamhkJ16mT5aLvfQWxVy
X-Proofpoint-ORIG-GUID: vUjkgDVXf1efLamhkJ16mT5aLvfQWxVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_04,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=523 clxscore=1015
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060054
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series are to support SCO offload for QCA2066, ALL BTHOST
needs to do is specifying both Input_Data_Path and Output_Data_Path
as 0x01 for HCI_Enhanced_Setup_Synchronous_Connection, does NOT need
to configure data path by HCI_Configure_Data_Path at all.

Zijun Hu (2):
  Bluetooth: hci_conn: Check non NULL before calling
    hdev->get_codec_config_data()
  Bluetooth: qca: Support SCO offload for QCA2066

 drivers/bluetooth/hci_qca.c | 19 +++++++++++++++++++
 net/bluetooth/hci_conn.c    |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center

