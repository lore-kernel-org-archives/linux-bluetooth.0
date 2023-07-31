Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539B8C001DE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 07:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGaHrT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 03:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjGaHrT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 03:47:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159F9FB
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 00:47:18 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V68KiP020453;
        Mon, 31 Jul 2023 07:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=jkLJmUmNKpa5bf90i9fyjdxIwxYGZKNJa2b8L4nYPK8=;
 b=VIt44RHCHvveAg+4GmOA9RF8Xx9AIJB5hU9fUancRylVsELLlpWvC5eOczyArjWt5bUj
 ttl+xTVhld18H3mkkK3dmJuhBYVkGLQi53hmpkp3CW90/D7mv3hReKImdDYahg8MPPd1
 noerRCiG2Ya0CuSa1GkptsUs9gNSscmT5byxFK0GQQpiwN8GDkzK4ipccG5iyctnsekP
 9Go6vp3xYDUxmB1DieXiCyZe5E1+4XCz0wxwjvBWYI6OwVG6leUFmW2BtbLLrBRgRUpk
 C33msobExOVCIuwyj8sMEBy2xoJ00hm33AkXl6WOZhsHy1xOgAMhLjG4VA5liMdB4f16 DQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4urxavm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 07:47:16 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V7lFp2010930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 07:47:15 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 00:47:14 -0700
From:   Zijun Hu <quic_zijuhu@quicinc.com>
To:     <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v1] main: Fix a logical error within parse_config_int()
Date:   Mon, 31 Jul 2023 15:46:44 +0800
Message-ID: <1690789604-3576-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J0i7szLRQ5lJy7xFQM4rtlUgkUqGGV9Y
X-Proofpoint-ORIG-GUID: J0i7szLRQ5lJy7xFQM4rtlUgkUqGGV9Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310069
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix a logical error within parse_config_int().
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

