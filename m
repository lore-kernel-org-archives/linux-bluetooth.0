Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E1C2FF15F
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856204; cv=none; b=QzZcMRp/h8m3GLxDcAwQepwUbshOAjgnPxy8nh4XG3rRslcK3P69ZcWHFmEsSGc3efCqtSNQ0Vq13IAh05j5zvkuXM+I3f1JSblrR24noOcNcmY00+FFRlvFjaihJqY85d4buMnQThIF1UD41nXHkYaupRVhdgwMMUyOBx+eHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856204; c=relaxed/simple;
	bh=P+HfOPveKwwfM1SjISgxVCTRQU0DCHze2vEA8+4M46A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jZvZz4Z5OH5eLdsxgA/zTp/Is2cc2imwXcw2XKvI/R+T0P2kaQw5sgQe747M4vYMk1fynKsVIicMbjltJ+fwQofEVAriGJPS0VcKH9nUvG83jfVzpHuVtPp320RcUA06x1z3ukJtuXr4ay+vm8m5R8XSuZGQwDLDWuejTcTnYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DmplFI7L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DmplFI7L"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UHAo000975;
	Fri, 22 Aug 2025 09:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	soCWzjvWscVoYkfUaLol28MB7Wj9YERYDsofOEB85Vw=; b=DmplFI7L/LKLCns3
	i8e/YDm3FuJTGwY8vX0ppw5/83xOWOAPt03MO16gDvHWm6jtqHaNdKtSTMGKsarN
	LOXoBZL6wtQfJc5Rl4EgIfluAHHWDXYNjU22ls7c5hDpQ/jBez8DeW8qCqxgW+BR
	nlz80dG2mEObOJmrfHJHDa7xtHV5XskMg/j1kp4uNDUisQ9RAqgkGDcERlYsKD1V
	7z15LaehcYWy/+JDDiTkH22eoZIGk0SZG49XgIEKqwZmXJ6CKio5+dylq4a+5iqa
	COWOZjFzmGV0DsefdpORMHkY/yAeA3cZnP5x+2TLKiKj+yBs5wtBAgfbspBdzAkn
	iee8iA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5298stc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 09:49:39 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57M9ncYK030217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 09:49:38 GMT
Received: from [10.239.96.215] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 22 Aug
 2025 02:49:37 -0700
Message-ID: <16a21382-4984-4250-a770-ea39ddeedd3b@quicinc.com>
Date: Fri, 22 Aug 2025 17:49:35 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] driver: bluetooth: hci_qca:fix unable to load the BT
 driver
To: <brgl@bgdev.pl>
CC: <linux-bluetooth@vger.kernel.org>,
        Stephan Gerhold
	<stephan.gerhold@linaro.org>,
        Luiz Augusto von Dentz
	<luiz.von.dentz@intel.com>
References: <20250609105500.4083963-1-quic_shuaz@quicinc.com>
 <CAMRc=MfF7d9+cJi12G1yxPpMoe8K5N8tEO9kfCRJejHWt2DkXw@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <quic_shuaz@quicinc.com>
In-Reply-To: <CAMRc=MfF7d9+cJi12G1yxPpMoe8K5N8tEO9kfCRJejHWt2DkXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N0OxGEbDX9Ci5e2bXJlfYhdmaTyxRLao
X-Proofpoint-ORIG-GUID: N0OxGEbDX9Ci5e2bXJlfYhdmaTyxRLao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+Ots5quDsMhE
 TwfUWd9dGgbqc1GjAOUf/CCfozcsa9hFCjrGbARzv42VBTnbG5N4OM+RfWgVBu07Wu5BavJJIyV
 YZSirukhh2Hxu7sZX17P8gFQtxweOl8qF/TauAj7unJgJvg3YPEq2ru801dyAB9yYCMjCCPpl3g
 vJLgzGQAGVApRA+ruHvWQex1gmAHGTY4T5C6GbrfnxQBg1oloIPWHRUdxCScTabQLugReJ/HEVX
 +kSTjpZPJvzLiv3zlndfmxuN2TiVk3KyYqHE2588oXK+IgEb4GHPPCsZxU9reeYOY4W/hGo5csv
 shO928uZTwt8CVopoHoapWCpXKQqw0oP2IhNOPRDjsZ2uvMZqHUl8AGN/YB9m+6yyVzL3JMHQbm
 5Jngvh6rJ9iIoULwdFyAe13GlL0Ytw==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a83d33 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=UQjBgCM3aO4ULV_0GCEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Hi,iBart

On 7/2/2025 6:23 PM, brgl@bgdev.pl wrote:
> On Mon, 9 Jun 2025 18:55:00 +0800, Shuai Zhang <quic_shuaz@quicinc.com> wrote:
>>
>> Some modules have BT_EN enabled via a hardware pull-up,
>> meaning it is not defined in the DTS and is not controlled
>> through the power sequence. In such cases, fall through
>> to follow the legacy flow.
>>
> 
> Thanks Stephan for bringing this to my attention.
> 
> Shuai: you have not Cc'ed arm-msm or even linux-kernel and so didn't give us
> any chance to object. I will separately send a MAINTAINERS change to add
> arm-msm as the mailing list for this driver.
> 
> What is the problem you're seeing? The bt-enable GPIO is optional in the power
> sequencing driver and if it's not there, then there should be no difference in
> how this driver works. What are the offending platforms?
> 
>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>> ---
>>  drivers/bluetooth/hci_qca.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index a2dc39c00..976ec88a0 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2392,10 +2392,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>  		 */
>>  			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
>>  								   "bluetooth");
>> -			if (IS_ERR(qcadev->bt_power->pwrseq))
>> -				return PTR_ERR(qcadev->bt_power->pwrseq);
>>
>> -			break;
>> +			/*
>> +			 * Some modules have BT_EN enabled via a hardware pull-up,
>> +			 * meaning it is not defined in the DTS and is not controlled
>> +			 * through the power sequence. In such cases, fall through
>> +			 * to follow the legacy flow.
>> +			 */
>> +			if (IS_ERR(qcadev->bt_power->pwrseq))
>> +				qcadev->bt_power->pwrseq = NULL;
>> +			else
>> +				break;
> 
> This is wrong. It just effectively ignores all errors - even -EPROBE_DEFER.
> This patch should be reverted as - depending on the run-time ordering of driver
> probing - it will surely break existing platforms.
> 

I'm very sorry—due to my oversight, I forgot to update it.

The updated strategy is as follows:
Handle nodev separately, while other errors will still be returned.

case:xxx	
....
....						   
if (IS_ERR(qcadev->bt_power->pwrseq)) {
    switch (PTR_ERR(qcadev->bt_power->pwrseq)) {
    case -ENODEV:
        qcadev->bt_power->pwrseq = NULL;
        break;
    default:
        return PTR_ERR(qcadev->bt_power->pwrseq);
    }
}
fallthtough;
case:xxx

>>  		}
>>  		fallthrough;
>>  	case QCA_WCN3950:
>> --
>> 2.34.1
> 
> Bart

BR,
Shuai

