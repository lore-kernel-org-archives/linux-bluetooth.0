Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE1512DD97
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564374; cv=none; b=Xh4jksaDsCDdtvH5rmNAOS8uCpvxxYPwAT7ezF32pTmMZPPegP5Nqhd++AcM1w+ihOcs5p7Um8A8icmHzk+a8CC5kwRNY9UXsPI7cqelLzPxtpfLcGyUjH7J8rezWog6I6opyQFkz9UwzWDqf9PyqpZa2TfeZmWQ6a0cxTXfgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564374; c=relaxed/simple;
	bh=FNJKF9cR6qmEraw+XJ6BIBhb5tbdjZOOEnTTn1yLCGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JuesEupIAfQGWiajHH8G2B1xIhvGSS+mAqPZeTU52tF4YmLH4Yg4y8GoTnL3M8enDj+LEsVSSYwWwxTfUISLy/BxHC6IMVX17tRdI0BFdW9nFwU9MN+wJ21/bUaPWuAT/UnOk+BY7tsgzdDJymxJKms1lzg0pHnquIPkkV6DZbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dtAgWTyS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dtAgWTyS"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JLfBtP010920;
	Fri, 19 Apr 2024 22:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/it+HoZbSkVoRHaekg4QTZ9tq7GNnprbq251ej/+xtM=; b=dt
	AgWTySThSO8JTGGG7jH99JMUfjlIf/fmd1c3BIpLOfoWYe3yB+7DVuxrWJwFOTSD
	VnGekSm0lAs/19JXDsJB3tGMD1nOhA0gY4VQMA2/U1pN5C7mDJ+e+E/MN67Il5WM
	TqsY8Qjnk5S7pvLjgBgJRtZH/loZbATmndVio8d4Qem+Ej8Sa79MFioazW7+W5E2
	udDuV3CUQQh1uswg1kyqJfbgQqcqsbdFJmkYikCvGzLxl6+S2TTowP/e4hQu2o5q
	dAhvxsw8s6wyB/Nfpk/4qnGVTrj/QPXPSJ2Zoe5UbjiYBR3h9QB0n6CZ0LldvKVS
	pZiGH0HP/EpUwEhwQAdw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xkkss9qfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 22:06:06 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JM65Ro011185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 22:06:05 GMT
Received: from [10.253.76.25] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 15:06:04 -0700
Message-ID: <d076ead9-f209-43e9-ba6a-854a873b80ed@quicinc.com>
Date: Sat, 20 Apr 2024 06:06:02 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Bluetooth: qca: Fix BT enable failure for
 QCA_QCA6390
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <krzysztof.kozlowski@linaro.org>, <wt@penguintechs.org>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713563327-19694-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713563327-19694-3-git-send-email-quic_zijuhu@quicinc.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <1713563327-19694-3-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WXAFEwKBAkrUdL_dkicyLZlQR2si1oub
X-Proofpoint-GUID: WXAFEwKBAkrUdL_dkicyLZlQR2si1oub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_15,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190172

On 4/20/2024 5:48 AM, Zijun Hu wrote:
> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
> with gpiod_get_optional()") will cause below serious regression issue:
> 
> BT can't be enabled any more after below steps:
> cold boot -> enable BT -> disable BT -> BT enable failure
> if BT reset pin is not configured within DT|ACPI for QCA_QCA6390.
> 
> The mentioned commit wrongly set quirk HCI_QUIRK_NON_PERSISTENT_SETUP
> within qca_serdev_probe() for this case and cause this serious issue.
> 
> Fixed by reverting the mentioned commit for QCA_QCA6390.
> 
> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Tested-by: Wren Turkal <wt@penguintechs.org>
> ---
>  drivers/bluetooth/hci_qca.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 92fa20f5ac7d..0934e74112a6 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2357,7 +2357,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  		if (IS_ERR(qcadev->bt_en)) {
>  			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>  			power_ctrl_enabled = false;
> -		}
> +		} else if (!qcadev->bt_en && qcadev->btsoc_type == QCA_QCA6390)
> +			power_ctrl_enabled = false;
>  
>  		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>  		if (IS_ERR(qcadev->susclk)) {
sorry to send wrong patch sets please ignore it.
have send right v3 patch sets
