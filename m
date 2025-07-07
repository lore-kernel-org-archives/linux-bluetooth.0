Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD54277CAD
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872936; cv=none; b=lxubV4EFL5/jjsqWyA4+qkk73EuLbObw3FpkNSIkIjKG3hGH4wNCbxD+kGkLWMlUMn6pqecCe45VnzaShiP+DbxvfsagpYZup+32/sn7+eIBlti9xtK2aLOUP35fB9kNGZ4ZLNOSs0VJMq4Je2clFGVMNQQbgOgm7cOpKIvaSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872936; c=relaxed/simple;
	bh=AbztHw4bC8fVFDaBi6RPkt3yTFa9nQZ/CexraX/bvR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BGpA7bRUqO8TN1eyCGkNR00+1OlbPIF4cka9Qsx19EsBFCQUyt96apNBGQotEZ895N/6kG8YOXtFiO9HQH1x75VA8lmdI0sAuxUCJafXqR/iNeUAmmxJtoEe2X+bCOaUKYWobyYSfTiemIvUmYXlEyDwxKMpOg6Xjx54ySFK7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TdeRSJ0c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TdeRSJ0c"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566Kg2sN026088
	for <linux-bluetooth@vger.kernel.org>; Mon, 7 Jul 2025 07:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N3QwEv/EwHM4vJ5gtE+evd8RSAV9P8rEvcL8vYyHScU=; b=TdeRSJ0cEnrjlrD5
	FNYG6zRwJaflfg2Mpi5LRfnlDq21EfpvhZPWJngywmShB/6HOmx+JVUYs58+Kxrz
	N9Ff3xD4LfqOLleCEJcxt8jkAFBwdPtg7Ti+T4oyL6hMxIayBUUHEXpryr0LoPsF
	1NN2fufIt5HZDzXGFEgDyiDq+Go/AuVahk7LHd+kY7s7BgRnW0x2cyj9uiQpd5YN
	lJx2qhultyrRHBpKj/1Kwv1MboZLfp5kobxsjMfZV0rhNNdLvWXnsbvwtPuAKz9a
	yeIS/RxJtaRSlxyeQNdJ7M1aIye+hXP2Vgj9nHWPlyYRbripFlyScH9nXhMS/A8p
	656lNQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psdqk5h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 07:22:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5677MBvX017739
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 7 Jul 2025 07:22:11 GMT
Received: from [10.239.96.215] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 7 Jul
 2025 00:22:10 -0700
Message-ID: <71aa21d7-795d-4709-899f-4b1feec810b3@quicinc.com>
Date: Mon, 7 Jul 2025 15:22:01 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver: bluetooth: hci_qca: fix ssr fail when BT_EN is
 pulled up by hw
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_bt@quicinc.com>
References: <20250627061707.3631422-1-quic_shuaz@quicinc.com>
Content-Language: en-US
From: Shuai Zhang <quic_shuaz@quicinc.com>
In-Reply-To: <20250627061707.3631422-1-quic_shuaz@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ffSty1QF c=1 sm=1 tr=0 ts=686b75a5 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=dMowEvKKoQjkIwZx51sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: kRexUl4jUXob7iT6i6hksTgfwpV9Ujuw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA0MSBTYWx0ZWRfX3rkXieVpO6Ei
 KlHRFvjaPVY/j63T6j0NdFl0vjgV9PeglzqQCLWmUytnJQaYiJCjV6q6oIiv29gmKAXEcqX8ZhG
 UEYTYgPLwU9rquDgZ3WPwT7w3pKMe9n12hH5EOnsRSw4b0obVLbN1qCvjPWwVh1JgAhbKUzED4A
 FZ19Gsj680ifpmlYhcAjSt++eVBqb6cxSL7MSzCh3TY6FO+zm7fOlicrSDE6nBX2pXG0z6fK0HG
 aEZaxPgLSREhIFL5Zja0TJjvmkZGYH/TIDUQu6WTMDSvxoB5VAzYM8aKb7mDwPeeHS/fAY+hl6v
 N3m8prGy4n94AsPUa8vOaZoTkZcZuS6i3v9sjKUE3i4UwWtwcnC43QhdxRzq7GQ3F/mme9UHrmG
 VqQ1219vfhw2PBJJEZJrj2wpj/3yRDq6Dp/SdZ4025QMpTU+Qo0U85PceMRvY3cc5L+ouh0B
X-Proofpoint-GUID: kRexUl4jUXob7iT6i6hksTgfwpV9Ujuw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070041

Dear all

On 2025/6/27 14:17, Shuai Zhang wrote:
> Q1：
> If the SoC always enables the bt_en pin via hardware and the driver
> cannot control the bt_en pin of the SoC chip, then during SSR,
> the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
> This leads to a reset command timeout failure.
> 
> Fix1：
> To address this, clear QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits
> after the coredump collection is complete.
> Also, add msleep delay to wait for controller to complete SSR.
> 
> Q2:
> When the SSR (Sub-System Restart) duration exceeds 2 seconds, it triggers
> host tx_idle_timeout, which sets host TX state to sleep. due to the
> hardware pulling up bt_en, the firmware is not downloaded after the SSR.
> As a result, the controller does not enter sleep mode. Consequently,
> when the host sends a command afterward, it sends 0xFD to the controller,
> but the controller does not respond, leading to a command timeout.
> 
> Fix2:
> Reset the tx_idle_timer after SSR (Sub-System Restart).
> 
> Changes in v2:
> - Modified the format.
> - Add changes to fix tx_idle_timeout
> - Link to v1: https://lore.kernel.org/all/20250609105553.3756688-1-quic_shuaz@quicinc.com/
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4e56782b0..d415a3f31 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1653,6 +1653,24 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>  		skb_queue_purge(&qca->rx_memdump_q);
>  	}
>  
> +	/* If the SoC always enables the bt_en pin via hardware and the driver
> +	 * cannot control the bt_en pin of the SoC chip, then during SSR,
> +	 * the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
> +	 * This leads to a reset command timeout failure.
> +	 *
> +	 * To address this, clear QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits
> +	 * after the coredump collection is complete.
> +	 * Also, add msleep delay to wait for controller to complete SSR.
> +	 */
> +	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> +		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
> +		clear_bit(QCA_IBS_DISABLED, &qca->flags);
> +		mod_timer(&qca->tx_idle_timer, jiffies +
> +			  msecs_to_jiffies(qca->tx_idle_delay));
> +		qca->tx_ibs_state = HCI_IBS_TX_AWAKE;
> +		msleep(50);
> +	}
> +
>  	clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
>  }
>  
> @@ -2478,7 +2496,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  			return PTR_ERR(qcadev->susclk);
>  		}
>  	}
> -	
> +
>  	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
>  	if (err) {
>  		BT_ERR("serdev registration failed");

Is there any update?

thanks,
Shuai
