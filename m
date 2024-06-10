Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF8524F
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718018175; cv=none; b=j6S77B8IXbJwkNk79XxiFpPC0T5Y2tqXq212jcsLSB2gJqYMnuiq5BRlH4GFY8ePaKi/jEDXeZTTSuKHkDVVsPZdISzSayRd31mHQe8D3TR2X0/CGya0qC2xDiWKb+RgZgVue+9JKgk7UVZRWTcAflAiWmu+koH1/gNzU9g5eeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718018175; c=relaxed/simple;
	bh=6uZ0Xm11XME7cMc25tdJmKcWaXObG6jG08Ld07IJac4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XhHtkXQtho95qEFFFV4yzgUG7w8+oZUVc+hqKgywZCTFt5PM3mEBWJaZq3FtdkZhNRF/2iUdlKu63G0ITXsulFKILypNYrdzpbfJHFRXFsBe/dUvUIrcrqgh9vTJNgzxhCxe7Nu1FADSA4waNZqkRSI9WqoSGlq9iCPXaHTWNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BIWCVWAm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BIWCVWAm"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A007I6005752
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 11:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HER/i2W8TA6shVbeVq5IqacpNYQj9LhF63N2CqejuiM=; b=BIWCVWAmnkgjBI7O
	Ao4OxSzeefHWD6hNBU/U/qJCZnhbb004dRDTMQ/58Jyoc0VO7OhSPek923/7QGrp
	zJdIrxLe3HhaJ/yFEcqwE2X4pn+lzexhAa2XYL0AGUb62aTuwGXFXK3YLao0phQX
	jH2PUQd3NCxfeTqO9fbsTWzFb9Oh0H2nYRtN8lC1GyVlx7fZqHyKN1BNhLcwTiGw
	onpuHaaaMwQ9W4NbTdtbCxM6ozWZONOs6/M01qOV4K1DyRNGYsEvttqlv0rCVro/
	6Q9y2kraUmgMhP4hFG1zOUjEpKJKAyhGvRG7dQM4omlkbCcVT8a7bezevhjYlWVu
	iHS9+g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymd0ebup2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 11:16:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45ABGCq0027430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 11:16:12 GMT
Received: from [10.216.27.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 04:16:10 -0700
Message-ID: <fd4690a4-97a2-4d28-9850-db21ecc8fc26@quicinc.com>
Date: Mon, 10 Jun 2024 16:46:05 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Permission for pulseaudio to use ofono.
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
References: <20240510064456.24101-1-quic_rbujala@quicinc.com>
Content-Language: en-GB
From: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
In-Reply-To: <20240510064456.24101-1-quic_rbujala@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ez-t8pkZH1Ld9tTs0ITlHSaZPLb5PgJE
X-Proofpoint-ORIG-GUID: ez-t8pkZH1Ld9tTs0ITlHSaZPLb5PgJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=991
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100085

Can someone please update on this. This is a blocker,
we are unable to proceed further without this change
and please suggest if there is any alternate change
to way proceed further.

If not please let us know is there any plan for
upstream this change.

please consider this as a reminder.

On 5/10/2024 12:14 PM, Raghavender Reddy Bujala wrote:
> When pulseaudio is trying to Register with  ofono
> on interface org.ofono.HandsfreeAudioManager, dbus
> is throwing org.freedesktop.DBus.Error.AccessDenied
> with string "Rejected send message".
> 
> To allow pulseaudio to send messages to org.ofono
> service over dbus added this rule.
> 
> Signed-off-by: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
> ---
>   ofono/src/ofono.conf | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/ofono/src/ofono.conf b/ofono/src/ofono.conf
> index 6c5483ce..c946e822 100644
> --- a/ofono/src/ofono.conf
> +++ b/ofono/src/ofono.conf
> @@ -32,6 +32,10 @@
>       <allow send_interface="org.ofono.intel.LteCoexistenceAgent"/>
>     </policy>
>   
> +  <policy user="pulse">
> +    <allow send_destination="org.ofono"/>
> +  </policy>
> +
>     <policy at_console="true">
>       <allow send_destination="org.ofono"/>
>     </policy>

--
Raghavender
