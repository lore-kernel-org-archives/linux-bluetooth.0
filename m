Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA40BC001DC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 09:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjGaJEM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjGaJD4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 05:03:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5749219B7
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 02:02:57 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V7fK9q018837;
        Mon, 31 Jul 2023 09:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=b1a4U7ribxZDV2vAgEWAcD6ZMOJ13y0Kdpa0T/ZbxU8=;
 b=YezEgs7BbJBX4+ypvL40rh3vQRffWeAFZr0tOifNaBK2YEKwjdBltmO6gsRwdQjWG78b
 Mmdw1Q6CilROdD/D2NbZCn2K2hJUyC0TEaysA/XAABTtaz0ijEaxOMKWDTHtRWYGq8L0
 B1x9gtIKl0NGzE1CQNHTs/rVAbWcf9KkGXVncYeUAjL5OKbnkJRq4NiQNX7pQNV8KrrS
 YQAlH1Ac6EC3GF0lpjVX4dbwNHzvyrcaja465DM9IFM/bJV0THVGjnz9KGxySAgFpwNe
 smDG1N/RfyOpaaRgkzBPfN4xu+jowAbTyY7hAXsg5/A5ufFsru6XGbH7gilKNdGQtXPe 1Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4ug232xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 09:02:04 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V923m1011519
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 09:02:03 GMT
Received: from [10.253.13.173] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 02:02:01 -0700
Message-ID: <b2151d37-b108-7edf-e9d9-870fbde4553c@quicinc.com>
Date:   Mon, 31 Jul 2023 16:58:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] main: Fix a logical error within parse_config_int()
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>
References: <1690789604-3576-1-git-send-email-quic_zijuhu@quicinc.com>
 <698aa5d3-3261-c9d9-d754-d36ae9716eb4@molgen.mpg.de>
Content-Language: en-US
From:   quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <698aa5d3-3261-c9d9-d754-d36ae9716eb4@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4hgQSIKmAGBRgB7j1KCVmZE8jBV5Ew3w
X-Proofpoint-ORIG-GUID: 4hgQSIKmAGBRgB7j1KCVmZE8jBV5Ew3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_02,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310081
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 7/31/2023 4:48 PM, Paul Menzel wrote:
> Dear Zijun,
> 
> 
> Am 31.07.23 um 09:46 schrieb Zijun Hu:
>> Fix a logical error within parse_config_int().
> 
> Thank you for spotting and fixing this. I guess this warning was printed on the terminal?
no any warnings by following Compilation steps of README.
> 
> Although obvious, instead of duplicating the commit message summary in the body, it would be great, if you still wrote a more elaborate commit message. Maybe:
> 
> Having a config file with the line below
> 
>     …
> 
> causes the config file to be ignored, and the warning below:
> 
>     …
>
the error is very simple, so i don't write more to explain it.
>> ---
>>   src/main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/main.c b/src/main.c
>> index 150a5af4cca4..13501440b052 100644
>> --- a/src/main.c
>> +++ b/src/main.c
>> @@ -458,7 +458,7 @@ static bool parse_config_int(GKeyFile *config, const char *group,
>>           return false;
>>       }
>>   -    if (tmp < max) {
>> +    if (tmp > max) {
>>           warn("%s.%s = %d is out of range (> %d)", group, key, tmp, max);
>>           return false;
>>       }
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul

