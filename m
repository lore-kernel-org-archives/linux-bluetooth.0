Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594782599;
	Wed, 21 Aug 2024 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724213777; cv=none; b=bS33WzBVpBgI63YtGJfg0RRIn135C2cJhp2cPnVMqLgUmDhX9RWwlrebo1ifaOuzrwMxPyyQud8uygdqL4+hfG/G9vLvtfwbXpCIP2iWjS+BsIym+0WUYNUBIJFrjk4A7pdsC3Bi63INT4J4DRLY+Uqthrnqq7wVn0SkVOQ/En4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724213777; c=relaxed/simple;
	bh=fcb8W/36ubfc+gGKRsB7vY+KskPeQNEaLuIcW7TjOE8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Wy2Wp6ZmBqjgyv8hIVMUFlt5u93eLJgpzmrgZYm4yQpyLe94XfROzu0a7HJjBIwZ8O0jLsemb5bmgnjGOe3BulTUlD5zrYMCZc60VBBIkIXpTdRR4qs+Yy+MskJh64pIGFKZMo6t+IDuD70s5V++UsTW6ygmy2zNfIh5IJBxSe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YVoNi6ur; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YVoNi6ur"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KEqX9Y019502;
	Wed, 21 Aug 2024 04:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S5PGvNFc85jqmrGlrsScyVAG4hF8skxfLF6Oja0FmRw=; b=YVoNi6ur+bgkbDM0
	UZy+R2WssJtEitWBlju6pDWk0N7zkjr5LFK6MzyCzmjzTV7E5G9pgI2mH7idPna6
	U8H/J57/RB0bH8dXTxF1udljiOzY5NnwNufdhC9NHwcAlqYbNspxR7nsy/5NhLiB
	aeps4w/h8g35dqB/wRHwdYmlGjkaSX4Rx1KEaHTDFx+WjJaMZzq75xJU5guXnPIu
	IRNIG7fzlEg2+v/nBm3VHxQ+cO/PLNO9q7UGn3Y5LK9TPyekhbJ/P2wwk2OkB8PZ
	Z+UiLSM3gWQGEI++JDB2VJOOjX/IKx5EjyLTwk8L3xrm1h8/6EqZE3s0O8CVdNgl
	oHl2Vg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414phvax1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 04:16:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47L4G8kG017154
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 04:16:08 GMT
Received: from [10.231.216.175] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 20 Aug
 2024 21:16:07 -0700
Message-ID: <15472cea-904c-4d79-9195-3063ce7f1e2e@quicinc.com>
Date: Wed, 21 Aug 2024 12:16:04 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Drop unused event during BT on
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240726095828.2707111-1-quic_chejiang@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240726095828.2707111-1-quic_chejiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8NZs7Fgp_wy1GYWQyzpqlBQj4wWIPwYA
X-Proofpoint-GUID: 8NZs7Fgp_wy1GYWQyzpqlBQj4wWIPwYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_04,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210028

Dear receivers,

Is there any comment for the changes? Thanks! 

On 7/26/2024 5:58 PM, Cheng Jiang wrote:
> For the WCN6750/WCN6855/WCN7850, the vendor command for a baudrate
> change is not sent as synchronous HCI command, controller sends the
> corresponding vendor event with the new baudrate. It needs to be
> dropped, otherwise it may be misinterpreted as response to a later
> command.
> 
> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index ca6466676902..f497d601e035 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1206,7 +1206,15 @@ static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>  		 * vendor command).
>  		 */
>  
> -		if (hdr->evt == HCI_EV_VENDOR)
> +		/* For the WCN6750/WCN6855/WCN7850, like the WCN3990, the
> +		 * vendor command for a baudrate change command isn't sent as
> +		 * synchronous HCI command, the controller sends the corresponding
> +		 * command complete event with the new baudrate. The event is
> +		 * received and properly decoded after changing the baudrate of
> +		 * the host port. It needs to be dropped.
> +		 */
> +
> +		if (hdr->evt == HCI_EV_VENDOR || hdr->evt == HCI_EV_CMD_COMPLETE)
>  			complete(&qca->drop_ev_comp);
>  
>  		kfree_skb(skb);
> @@ -1497,6 +1505,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  
>  		switch (soc_type) {
>  		case QCA_WCN3990:
> +		case QCA_WCN6750:
> +		case QCA_WCN6855:
> +		case QCA_WCN7850:
>  			reinit_completion(&qca->drop_ev_comp);
>  			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
>  			break;
> @@ -1531,6 +1542,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  
>  		switch (soc_type) {
>  		case QCA_WCN3990:
> +		case QCA_WCN6750:
> +		case QCA_WCN6855:
> +		case QCA_WCN7850:
>  			/* Wait for the controller to send the vendor event
>  			 * for the baudrate change command.
>  			 */

