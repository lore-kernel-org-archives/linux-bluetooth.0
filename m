Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E662BC001DE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 09:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjGaJaH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGaJaG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 05:30:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D748F3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 02:30:05 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V7tgW5026390;
        Mon, 31 Jul 2023 09:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Zn7EspLMJURaKiY5Gjn5zv2wVyOyzZar0tbAp0hZ2XM=;
 b=LrcfL9eqDA4ZNY9GpXVH3fh0Fowy4kn5UzT+ulNNd1P+gJnKytpI50d8drqsmAgYiNZk
 sN+5hYAvJqS1XrtLYaXB3zrZUDJyvKoxdIHFTZPhoNsGACEdoUsXKidSnIwQSWacIpvH
 KEovaPO1fxI7zzNFp97okBAafs/QK6+q5ZJCmoTCPdq5A9OhAzhjUj86mlHpraZ/wYSh
 Zhe290XAJBmWKqWQLIy/zUz4xSMrCHXVRi+Yi1FnemoWvyOgnclQCcyCcDZNc7J6d/RI
 JZRM2/nlvjnO1cULF2bHWJCq+3+775FXzId3vOcsolGTKU8HjGNYpqaUgZGWKAI8bd4S AA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4uanu5wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 09:29:53 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V9Tqao027639
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 09:29:52 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 02:29:50 -0700
From:   Zijun Hu <quic_zijuhu@quicinc.com>
To:     <luiz.dentz@gmail.com>, <pmenzel@molgen.mpg.de>
CC:     <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH BlueZ v2] main: Fix integer configuration option parse failures
Date:   Mon, 31 Jul 2023 17:28:42 +0800
Message-ID: <1690795722-29873-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690789604-3576-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1690789604-3576-1-git-send-email-quic_zijuhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SEFLG3o-J0ibU99TgiXsvY9ArCYJkHJi
X-Proofpoint-ORIG-GUID: SEFLG3o-J0ibU99TgiXsvY9ArCYJkHJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_03,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310085
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

parse_config_int() has a obvious logical error, so causes many
parse failures of integer configuration options, fixed by this
change.
---
 src/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index 150a5af4cca4..13501440b052 100644
--- a/src/main.c
+++ b/src/main.c
@@ -458,7 +458,7 @@ static bool parse_config_int(GKeyFile *config, const char *group,
 		return false;
 	}
 
-	if (tmp < max) {
+	if (tmp > max) {
 		warn("%s.%s = %d is out of range (> %d)", group, key, tmp, max);
 		return false;
 	}
-- 
2.7.4

