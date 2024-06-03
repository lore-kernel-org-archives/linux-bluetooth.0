Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11628839EA;
	Mon,  3 Jun 2024 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422482; cv=none; b=KzK6+nRL2LWrjYdQWTF9Tim+iTihuY4JqGPH0kraNaoYitzQyb4LxXW9I/Thqixf7nn14S6+EIyYn6y+jQFKm7FswKZKG+WF3vdQ5RKE+V6JGqY9vkBrcXaIp8xXSvE58TiXSFzf7qpOKmS2sIJI/gZYBMpObatSvLmuG1jOrm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422482; c=relaxed/simple;
	bh=B2comQGPWiA3xBp9uUkroEcDm6wjkalHIm57nIP3IqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=SdGlrVM3Lw4hV0lZMrO4lKYqjdVfNUZz/3NFe/C8PuLdCNbWNlHe4a8D0TC90U05Z1lBfL8GQwe9TPcHO8G/gvB1NSODYVUFzeOusbzvSDTY1d2KOhPSoxaja+OxCC6PbNrrUhEGDxcc4xQbqc/4vXo10KK97tRCLX/e4KUgw4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PQaseuCQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PQaseuCQ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453AvFeR026168;
	Mon, 3 Jun 2024 13:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YbV79DXRW1o1/8XJ18egV70PRdZOxFk/z/HkiX7J25k=; b=PQaseuCQDVWNUx89
	5yE3FNJYeTc1U4CVLjGbJUbIZ2iMncW/j3BDoBIpWzCc9hJ5vmbV9kwcUmU5136j
	FLDeQG/yfhoNS6DvXT7aFM+o6s69xIGdQLJLxoVDVe7WJB9baYxpIMt+bAbRCMoU
	GbF708i2ReOR8xq6vPv1jYzWa9XVIexFxjGwkmMVn0UYv9dYuVh/FMpQOyp1CezM
	8+bO4uLJ8YpoBER5T5PoZkcPwTvR7DNTqYIJeQCDK8Kll2j/PGqiJC2774wHZA6b
	bML5N85lCAqK8HGX/FAqfND8gwGC3KhQP86AiggxTYg+BaYaeKSp8pj0jYFyM9JE
	ZNhPsQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5wm1uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 13:47:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453DluaM006477
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 13:47:56 GMT
Received: from [10.218.29.219] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 06:47:53 -0700
Message-ID: <44e2840e-06b9-4900-bfe6-881d27081ff0@quicinc.com>
Date: Mon, 3 Jun 2024 19:17:50 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FW: [PATCH] PENDING: Bluetooth: Increase settling time for
 baudrate change VSC
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
References: <20240603125357.3035-1-quic_janathot@quicinc.com>
 <SA1PR02MB8694BA5D75CF5FF8C86C7274E1FF2@SA1PR02MB8694.namprd02.prod.outlook.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_hbandi@quicinc.com>, <quic_mohamull@quicinc.com>
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <SA1PR02MB8694BA5D75CF5FF8C86C7274E1FF2@SA1PR02MB8694.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t7jyk-zsv-nLGduq1CA6BH_i6UELT1hQ
X-Proofpoint-ORIG-GUID: t7jyk-zsv-nLGduq1CA6BH_i6UELT1hQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_09,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030114


> From: Janaki Ramaiah Thota (Temp) (QUIC) <quic_janathot@quicinc.com>
> Sent: Monday, June 3, 2024 6:24 PM
> To: Marcel Holtmann <marcel@holtmann.org>; Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Mohammed Sameer Mulla (QUIC) <quic_mohamull@quicinc.com>; Harish Bandi (QUIC) <quic_hbandi@quicinc.com>; linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] PENDING: Bluetooth: Increase settling time for baudrate change VSC
> 
> From: Harish Bandi <quic_hbandi@quicinc.com>
> 
> This change is done to align the settling time and synchronization for baudrate VSC for WCN6750.
> 
> In logging disabled builds and few devices baudrate change and flow control is taking time so increasing the wait time to controller and uart to handle baudrate change request properly.
> 
> Change-Id: If0631cb886e53817f963f075e626c89a791b7be4
> Signed-off-by: Harish Bandi <quic_hbandi@quicinc.com>
> ---
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c index eba9165..a59b35e 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -600,7 +600,6 @@
>                  rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
> 
>          if (soc_type == QCA_WCN6750) {
> -               msleep(100);
>                  qca_send_patch_config_cmd(hdev);
>          }
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c index d8abd27..0b41214 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1356,11 +1356,13 @@
>          case QCA_WCN3990:
>          case QCA_WCN3991:
>          case QCA_WCN3998:
> -       case QCA_WCN6750:
>          case QCA_WCN6855:
>          case QCA_WCN7850:
>                  usleep_range(1000, 10000);
>                  break;
> +       case QCA_WCN6750:
> +               msleep(30);
> +               break;
> 
>          default:
>                  msleep(300);
> @@ -1904,7 +1906,6 @@
>                  qca_set_speed(hu, QCA_INIT_SPEED);
>          }
> 
> -       usleep_range(1000, 20000);
>          /* Setup user speed if needed */
>          speed = qca_get_speed(hu, QCA_OPER_SPEED);
>          if (speed) {

Please ignore the above patch.

-Janaki Ram
