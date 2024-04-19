Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3135813D2A1
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564325; cv=none; b=N5fY41gF8Dkso5sDvmFznqPYbKCeleih5xELatNacBmw6vxr8Cibker2IGiI/vPuwh/h5Sa46P6vFnp8N01hRb+XzjWH29uDGCEwx1qWuIHRc/kjaQJVshPohhXNiOxWkXsIzVEym8WOT1CWQr0hoinFNaPog/IYMr4POmE6MAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564325; c=relaxed/simple;
	bh=12EH309Ly9LZrAlrmM+v3SNZLxuc5WWvIH3NovhI9kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=brZzfuCB8tLfId0VkEG/o3fEOU6rZ3BVuTp3JMEuZJATaPynDtF+o+C43ek5ml0uvBVsCzMntOdcxxyngVO+1EoNh2AoJaO/Q7e8hWneeQAC1i7CMc7Am80W5T16GKffpF9x3R3PvcBccq7c+qrd2j8E1u/Xt0EwRzyxnA+Mcn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OPbShyor; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OPbShyor"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JLaN7k002209;
	Fri, 19 Apr 2024 22:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lJfQsK0FVtM3pN9RIjr5RL4fBA72+G1H6TYRuNDwOKQ=; b=OP
	bShyor+uVQ7W1qloseR7EVE2QUy2MB2od098mEQIV4oBXvhmtC4UJDezg+o5Gh1S
	VPklFnyRVMmTYPC0/wiIJVEPwZBtbReytMW55wMqw3utd349h271idzLmk55tV+A
	E2vuARQcL3+QHbBfdkFhTx+t0Lm5XrmByDe9lBkDZfz07LjVzd0RPvPC43P/38p0
	N0ekbKZbe8BP7h5LBZtDAbvxp0pA2Q6qcfAeeYo7v4vb+dIeaXWA9ZudSXevfVaB
	3mct+raDzLFP3sac4x6ksSgo4J7GGf15jpLLyA2sRQ0/n9y+oRgG6BQJyUsLQJj5
	fgE7QO2huH/Pxp3k8fxA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xks6s918x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 22:05:17 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JM5GQC018655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 22:05:16 GMT
Received: from [10.253.76.25] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 15:05:15 -0700
Message-ID: <1bac8595-4ca4-43f9-ab20-e0dd55d93d8b@quicinc.com>
Date: Sat, 20 Apr 2024 06:05:12 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Bluetooth: MGMT: Fix failing to
 MGMT_OP_ADD_UUID/MGMT_OP_REMOVE_UUID
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <krzysztof.kozlowski@linaro.org>, <wt@penguintechs.org>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713563327-19694-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713563327-19694-2-git-send-email-quic_zijuhu@quicinc.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <1713563327-19694-2-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v-KIOeFM-q5QUGiB-Dp_AOuDY2OoI6ga
X-Proofpoint-ORIG-GUID: v-KIOeFM-q5QUGiB-Dp_AOuDY2OoI6ga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_15,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404190172

On 4/20/2024 5:48 AM, Zijun Hu wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> These commands don't require the adapter to be up and running so don't
> use hci_cmd_sync_queue which would check that flag, instead use
> hci_cmd_sync_submit which would ensure mgmt_class_complete is set
> properly regardless if any command was actually run or not.
> 
> Link: https://github.com/bluez/bluez/issues/809
> Fixes: d883a4669a1d ("Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/mgmt.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 7129e70a0253..68deec968405 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2623,7 +2623,11 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
>  		goto failed;
>  	}
>  
> -	err = hci_cmd_sync_queue(hdev, add_uuid_sync, cmd, mgmt_class_complete);
> +	/* MGMT_OP_ADD_UUID don't require adapter the UP/Running so use
> +	 * hci_cmd_sync_submit instead of hci_cmd_sync_queue.
> +	 */
> +	err = hci_cmd_sync_submit(hdev, add_uuid_sync, cmd,
> +				  mgmt_class_complete);
>  	if (err < 0) {
>  		mgmt_pending_free(cmd);
>  		goto failed;
> @@ -2717,8 +2721,11 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
>  		goto unlock;
>  	}
>  
> -	err = hci_cmd_sync_queue(hdev, remove_uuid_sync, cmd,
> -				 mgmt_class_complete);
> +	/* MGMT_OP_REMOVE_UUID don't require adapter the UP/Running so use
> +	 * hci_cmd_sync_submit instead of hci_cmd_sync_queue.
> +	 */
> +	err = hci_cmd_sync_submit(hdev, remove_uuid_sync, cmd,
> +				  mgmt_class_complete);
>  	if (err < 0)
>  		mgmt_pending_free(cmd);
>  
> @@ -2784,8 +2791,11 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
>  		goto unlock;
>  	}
>  
> -	err = hci_cmd_sync_queue(hdev, set_class_sync, cmd,
> -				 mgmt_class_complete);
> +	/* MGMT_OP_SET_DEV_CLASS don't require adapter the UP/Running so use
> +	 * hci_cmd_sync_submit instead of hci_cmd_sync_queue.
> +	 */
> +	err = hci_cmd_sync_submit(hdev, set_class_sync, cmd,
> +				  mgmt_class_complete);
>  	if (err < 0)
>  		mgmt_pending_free(cmd);
>  

sorry to send wrong patch sets please ignore it.
