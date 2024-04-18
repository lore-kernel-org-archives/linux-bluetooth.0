Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA9F2F30
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713478544; cv=none; b=VslqDPdjTV3KSNJS3/1XOg9bHitK/vhRijnelO4CsKWegE3sJrefVmo3Papgebakj2nd6eBhRAYmek7mhSdr8w4P6u658nxBjl1iRdKazMkVa+xRBir8BLJuZtWPzZArPynurf5wjnZ8XbHJ3A1CFDfM0zacaSlKgPQzHI0ZkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713478544; c=relaxed/simple;
	bh=eqM4lHvQC0uHuFn7CS/V8Gafl3Ht8Z2bjicolvHViks=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nkZXMLKxGDJeumblmBb4zph8aRF5hmvCu092PExtj+uV3EOktLmXMy9D1TBeqmq1HnO3EvTo70djjXn6toZB4HoW01u2ydz22fMZu6uk4bOiK26JznEpW1EbM83k2GoDQ7OEqTVW9HGrJFgKgDRasG3ap2gWYFT/gBuXxRPBg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dU/KB7rK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dU/KB7rK"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43ILOt55014250;
	Thu, 18 Apr 2024 22:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gGLqSWNAHLw/3oc0ShwySuNtXEmvApf4LHJWclqHqmQ=; b=dU
	/KB7rK1zTXB/vSBPXsHaZ8IbKAcK0Gt//xBXfrqeD2UrzKZoVpWnbqCKPoQt0NeZ
	UhOxcA6iy/WMczgo1oz7E+WtA9CrRuqDM7TiHNSN8Q7XtkC3CjFzawVLahU2aV9s
	L2n+HYcG+OFDb32y43D2Nh9woBroPIk/6IdN8Szfm9kHK6QMx/Z8P/oDgb8H9+Va
	aNIWBENbUxGL6afzwX9Oznp2VYnvI3jCnfxM7Qypo08CUqs2+8wVzLhiIOXnVOgA
	23r/utjExyE/Hpz55Ip6gGB1qre93r5Djy+W4QwBVeNO0FA8z1X0bBpLAOXuo8L/
	CHIKwQzNNuvSHvHi/LWw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk3chhb5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 22:15:36 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IMFZcY022762
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 22:15:35 GMT
Received: from [10.253.9.141] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 15:15:33 -0700
Message-ID: <f46e5046-326d-4afd-a303-31c185aef150@quicinc.com>
Date: Fri, 19 Apr 2024 06:15:31 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] Bluetooth: qca: Fix nullptr dereference for
 non-serdev devices
To: Johan Hovold <johan@kernel.org>
CC: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>
References: <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713409913-13042-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713409913-13042-3-git-send-email-quic_zijuhu@quicinc.com>
 <ZiFFa1JxVZuByuBZ@hovoldconsulting.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <ZiFFa1JxVZuByuBZ@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kD8KEFykBCkDMhT_4bMPlAxItGaoK1cC
X-Proofpoint-GUID: kD8KEFykBCkDMhT_4bMPlAxItGaoK1cC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_20,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=917
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404180161

On 4/19/2024 12:08 AM, Johan Hovold wrote:
> On Thu, Apr 18, 2024 at 11:11:51AM +0800, Zijun Hu wrote:
>> hu->serdev is nullptr and will cause nullptr dereference if qca_setup()
>> is called by non-serdev device, fixed by nullptr checking before access.
> 
> As I explained elsewhere, this is not a fix. It is only something you
> need *after* you added the later patches in this series. This needs to
> be reflected in the commit summary and commit message as I already told
> you:
> 
> 	https://lore.kernel.org/all/Zh91zq13nZvH3-Yj@hovoldconsulting.com/
> 
i have removed below fix commit sentence from commit message.
Fixes: 77f45cca8bc5 ("Bluetooth: qca: fix device-address endianness")

let me also remove work Fix|fix.
> Johan

