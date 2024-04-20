Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9214174A
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713648537; cv=none; b=cW45YX7DVMbhT9knwxQYKpZ63s06SYYfm3IwC5b6lE41Ze7sFxVNNzT38BXzkZYUPEYsy7ds2FpQqPc/aretHY5boHWZR7YPIsxbMq86/LBXtRKgaFmj26Njza5KiaSDqPAf7723+lK5c3U2UtPXN8ojeKqbsh6CAvz+ogpXn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713648537; c=relaxed/simple;
	bh=0evxANIIpa7VBUU0S4OvTLd+zhix7KlSdSHw9CpFOqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VzK2C4WezF1lOAMtVL0gyjYcQMDsyJCWWHH9ityR1zL8bZQ64t0CmbEJ8mSuqU/UankvVZMrDSb5/+cvPV0uIKP4v6XgrIkOgM6kbHE8tE62c3jStC+8w5JSPOciLIYrEJ2JLtAZt8qBF9Teb2Hpx0uHQ4m9WMSnGxNQ8za6mbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gDnIp29Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gDnIp29Y"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43KKPV0a021525;
	Sat, 20 Apr 2024 21:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+BHBFqfyv/xKGMeij8CRpzIc2qQSIsaUB0SQgLpS1DQ=; b=gD
	nIp29Y2CL5ApTj7BUjgDccwCnoBgxPj0V4dS+IMlMWIoqlXbeC438Zv6gb4KkcZi
	kTVoGEMCAIcm0DwW0MUGervA3CBoVkB9rrfIppCS7TJJgfSkJe+UxH58rBwSQ9kj
	eeSzfb08ymhqeUarhwuddN0TvThNEPoBmTg3d5c61eBsnnKNOqg/Yt1jBd37CmGu
	qodzadhcByROkUBomCHmwT1QfG48cO3HMKNqb4SzCbONNtB/nl7WOVHjIjMQZvb7
	tX6Mxm/GxRfm+aKM2E/mOI2YLeC9BPdbXtEvx2DWBy4hUfIJGUmk7dBo9cCB3Ml1
	xUwNSXqj+bvzxCPCKdkA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm4nuhdk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 21:28:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43KLSeOv005333
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 21:28:40 GMT
Received: from [10.253.76.25] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 20 Apr
 2024 14:28:39 -0700
Message-ID: <81a1d17f-3992-4b33-a877-973593b0c03b@quicinc.com>
Date: Sun, 21 Apr 2024 05:28:37 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Bluetooth: qca: Fix BT enable failure for
 QCA_QCA6390
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <wt@penguintechs.org>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713564212-21725-2-git-send-email-quic_zijuhu@quicinc.com>
 <5e2ffea7-556e-4623-bc25-e23367e61846@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <5e2ffea7-556e-4623-bc25-e23367e61846@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Bfb_u8Cwde6GuXUHjxwMJvkDQmWak3Q5
X-Proofpoint-GUID: Bfb_u8Cwde6GuXUHjxwMJvkDQmWak3Q5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_18,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404200159

On 4/20/2024 7:03 PM, Krzysztof Kozlowski wrote:
> On 20/04/2024 00:03, Zijun Hu wrote:
>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>> with gpiod_get_optional()") will cause below serious regression issue:
>>
>> BT can't be enabled any more after below steps:
>> cold boot -> enable BT -> disable BT -> BT enable failure
>> if BT reset pin is not configured within DT|ACPI for QCA_QCA6390.
>>
>> The mentioned commit wrongly set quirk HCI_QUIRK_NON_PERSISTENT_SETUP
>> within qca_serdev_probe() for this case and cause this serious issue.
>>
>> Fixed by reverting the mentioned commit for QCA_QCA6390.
>>
>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>> Reported-by: Wren Turkal <wt@penguintechs.org>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> Tested-by: Wren Turkal <wt@penguintechs.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 92fa20f5ac7d..0934e74112a6 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2357,7 +2357,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>  		if (IS_ERR(qcadev->bt_en)) {
>>  			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>  			power_ctrl_enabled = false;
>> -		}
>> +		} else if (!qcadev->bt_en && qcadev->btsoc_type == QCA_QCA6390)
>> +			power_ctrl_enabled = false;
>>  
> 
> Please use kernel coding style, so {}.
> 
i will correct based on  your suggest even if "checkpatch.pl --strict"
don't give any warnings for present code style.

> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.
> the only warnings is that
"WARNING: Reported-by: should be immediately followed by Closes:"
we don't need to handle this warning for this case.
> Best regards,
> Krzysztof
> 
> 

