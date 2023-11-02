Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDB4C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Nov 2023 09:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbjKBJuj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Nov 2023 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345746AbjKBJuf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Nov 2023 05:50:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282BC111
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Nov 2023 02:50:30 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A29oJ3v026664;
        Thu, 2 Nov 2023 09:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JXWSk6Pn6NtotY8aFaBrBVyxr4qqNwRBPyCIBCVdBaE=;
 b=Qy1lwqJkJtPvvne5V49mw0bruEteFJhGUEa/gWpOwB1qyVOZjT9CXbVhWTwboAqxhKhq
 TfzZl65IrcTi4MmIGqG6J0Vk5bErPTVys2/yMruAq4u5oVy+TgwVlwekwOWTcKcxTkja
 UOf9dd8eOM1llQLEPjl1VIYb1hnWFgyxV2SXV0MWoh9VtNPfASYCruj7fONxrRICxDbw
 GdscFC9ozdVdl8hXPDa5bPkfOGjaUsWZlhQdXrCSIS7twkMGxDN3932nMVOysaSWiKX9
 QbX/pngIlWsCsYX15dTMtD/FpqguP6SOuljXYAeUITOlt5TzXgi1MWLUXa96IV9aiAQF lA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u477pr930-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 09:50:25 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A29oOmq025932
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Nov 2023 09:50:24 GMT
Received: from [10.253.10.80] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 2 Nov
 2023 02:50:22 -0700
Message-ID: <ab123049-1272-9abb-87f7-e75015a55bf5@quicinc.com>
Date:   Thu, 2 Nov 2023 17:50:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix logical error when enter
 active mode
To:     <luiz.dentz@gmail.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>, <jaikumar@google.com>
CC:     <linux-bluetooth@vger.kernel.org>
References: <1698917302-28018-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Language: en-US
From:   quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <1698917302-28018-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mtqrOrwT9TpraCWdNB5BuvGlJm0tr-pr
X-Proofpoint-ORIG-GUID: mtqrOrwT9TpraCWdNB5BuvGlJm0tr-pr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 mlxlogscore=876 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020078
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 11/2/2023 5:28 PM, Zijun Hu wrote:
> it seems HCI_CONN_POWER_SAVE stands for active mode based on
> hci_mode_change_evt(), but hci_conn_enter_active_mode() does not take
> this flag rightly and failed to exit sniff mode potentially, it is
> fixed by this change.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  net/bluetooth/hci_conn.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 929d0e313db2..302fb5eaca55 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2582,7 +2582,12 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
>  	if (conn->mode != HCI_CM_SNIFF)
>  		goto timer;
>  
> -	if (!test_bit(HCI_CONN_POWER_SAVE, &conn->flags) && !force_active)
> +	if (test_bit(HCI_CONN_POWER_SAVE, &conn->flags)) {
> +		BT_DBG("%s: hcon %p is already active mode", __func__, conn);
> +		goto timer;
> +	}
> +
> +	if (!force_active)
>  		goto timer;
>  
>  	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags)) {

not sure what HCI_CONN_POWER_SAVE stands for. or change as below ?

@@ -4596,9 +4596,9 @@ static void hci_mode_change_evt(struct hci_dev *hdev, void *data,
                if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND,
                                        &conn->flags)) {
                        if (conn->mode == HCI_CM_ACTIVE)
-                               set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
-                       else
                                clear_bit(HCI_CONN_POWER_SAVE, &conn->flags);
+                       else
+                               set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
                }

