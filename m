Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0D155389
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190023; cv=none; b=R+7kWNVB0rnYizZt6EtzIbPhVtYe4Y0kJCfqvzuP0FrHoDzYydeu4Ryjm9xPj3RDpH5AMzHgJ3ZRv/VQyL/PbH8jjJgbVmYuGMroOzhm+5RRFgYzVJsyZaluubBTng23YnnqZ5Sh/7INt1ZrKCcSumCaPaa6teAJYXxOV8BkP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190023; c=relaxed/simple;
	bh=8fZwI/eRBIXvZRLmDrLalQ5mWW+Km8RGPdzuA7Nbzkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=awCLG1614rM956OPAxwuqGlZw/3QzU9o6wiTTnIZYz2UWpXMlKqPBlHc92b9iuUe9h+G+FNh7mlwqNCnh8FcLS2bjYqw+njra1WulPyebSmvYcZB5xa8sJkUYURuIbRXSuLajvmf2plWZhURCoCBG7O9hOkAfqCprrWFc+21ldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SpyTn3NW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SpyTn3NW"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5398WDvF030143;
	Wed, 9 Apr 2025 09:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ltlx+ZpYd9ishGl90KhlA/AhjRtKUtKKfiJdC9uaC6Y=; b=SpyTn3NWBuYCkwpK
	oBts6CPORgqP3GhajEr3aGsiGbE57KwR/EPtarkad+fIBrTq37mIYAIAAbDatJ3g
	rgqfqMI/emQqPAz8XRNBpTWkSYSGHB7F7jBFJlFu3ccjm+NHjr3khjEc74XtiWmv
	F4orP8ZUhMvjRu3p3Hc7yZ+XXQuSwbbH94hCoRlm6afOpRISgyHBY2EtLjP4Z8lf
	DAZytqZDYYLTYioulqGlrISgTpX+fFKj1TOWys4ottk4flBki5ggLOziJxCM3qRG
	t9c0qsOze2yMUKFOi7av6UwaunxIAL/P73kkzEL3TbwPOyCcCaRzmfojej347XgP
	778RwA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpmap4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 09:13:30 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5399DTQf010077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Apr 2025 09:13:29 GMT
Received: from [10.239.96.215] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 9 Apr 2025
 02:13:27 -0700
Message-ID: <46521c87-ed61-420d-bb2d-d5499d119f5c@quicinc.com>
Date: Wed, 9 Apr 2025 17:13:24 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Prohibit establishing of ACL
 links during poweroff
To: <pmenzel@molgen.mpg.de>, <linux-bluetooth@vger.kernel.org>
CC: <quic_bt@quicinc.com>
References: <20250408115146.2300584-1-quic_shuaz@quicinc.com>
Content-Language: en-US
From: Shuai Zhang <quic_shuaz@quicinc.com>
In-Reply-To: <20250408115146.2300584-1-quic_shuaz@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UUCJTx-2Nqa-p2-140Nn2YrL5z5nxD12
X-Proofpoint-ORIG-GUID: UUCJTx-2Nqa-p2-140Nn2YrL5z5nxD12
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f63a3a cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=RH_zFzTfHqndo64rMlwA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090047

Dear Paul

On 4/8/2025 7:51 PM, Shuai Zhang wrote:
> If turning off BT during pairing, "hci_acl_create_conn_sync" has chances
> to be left in cmd_sync_work_list. Then the driver will try to send
> the HCI command of creating connection but failed.
> 
> bluetoothctl test step:
> 1. local device pair with remote device
> 2. once pair is complete, local device will immediately perform power off
> 3. powe on local device fail
> 
> Check if the device is not starting up, that means powering off,
> when establishing the ACL link, and cancel early in this case.
> 

Do you have other suggestions? Please let me know. Thanks.

> Change-Id: I72802f306a20d43282dd374dd33b8cb1a22f48d8
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  net/bluetooth/hci_sync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c553b637c..c4f1c0f30 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6755,7 +6755,7 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
>  	struct hci_cp_create_conn cp;
>  	int err;
>  
> -	if (!hci_conn_valid(hdev, conn))
> +	if (!hci_conn_valid(hdev, conn)|| !test_bit(HCI_UP, &hdev->flags))
>  		return -ECANCELED;
>  
>  	/* Many controllers disallow HCI Create Connection while it is doing

