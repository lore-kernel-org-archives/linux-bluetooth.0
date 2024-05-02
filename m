Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6801E17984
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646891; cv=none; b=ZDuf7rw4y51QAAnksvkbnRpYEZzeAtYEoI7KY0KpHNNwRAD5oljS96rMHMVRww5rD9oX0uQo+qsj/kpXxAWj6lOlsXxMXjk/Ef6wiIGn3rCkHkc/u186jlzNTrLJOGRPjKOXvmzMssPJNITVYIxyn8J3Iqxybn+l50a3+XppBlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646891; c=relaxed/simple;
	bh=o114AsTLbALxohhrrolNHw6grJ+8INXCJ8kkTiqiiPI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ShIH9KVV9ZfStNJB372yn9LSbFr1bq+0iajS6L9gwJ0Wdlz3eTOdcBhJwfxC/BLMgNm0YRMp0yUROMoFOrBwXY9a8IVQctusHmU1YU3frPkKpQwTWha8ev7IEG4w439gE0ZHtdT//HqEGMgNf8TZjqbXoMEs/yeG9nL/GlCPUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d3uCXnK+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d3uCXnK+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 442AWeY0023037
	for <linux-bluetooth@vger.kernel.org>; Thu, 2 May 2024 10:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:to:from:subject:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=KV9pl9fDV+ljVD0mbzSr
	m65WEWRiyPCBvi+j10u4WDg=; b=d3uCXnK+nRncEEdZjkK78T4aF+M5OiW/sRQi
	pEesEdUMsXXkMo2hwUSKDgi6alOo7rfFMmyqZjrbdyCiO3xr9YNh7NnY8TShDqPd
	22J67P/JkKh7VtSXFJ93XnI2dyghygdnsQes3yT7YyD2+iKxvag/qJ7z8o0R4vYT
	L2T/iXP5Vv4DUfUW+Cees3eDv4H2qZ1asiFBn40xUNazFzG78wnNdV7bfbCplb6h
	K/SjDbwoV2xkfcp4A6HSfrAPh5wRYnSYjAwWKC+2jy2srJyusrxuxFMn7pxxXIU0
	dJT020SKUZVs/r+KG01UtX5KflkwCzWhJ8hi8Kqxard+BoMYIw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv3crgqtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2024 10:48:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442Am8IW023608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 2 May 2024 10:48:08 GMT
Received: from [10.216.59.126] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 03:48:07 -0700
Message-ID: <c14d0862-f101-46fd-8738-c877474a557a@quicinc.com>
Date: Thu, 2 May 2024 16:18:03 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: <linux-bluetooth@vger.kernel.org>
From: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
Subject: {Pulseaudio] Reconfiguration is not happening for HSP/HFP codec
 during initial connection
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IP9E67km0cYjn4qfz3BusOfVZxOEYPmF
X-Proofpoint-ORIG-GUID: IP9E67km0cYjn4qfz3BusOfVZxOEYPmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=742 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020065

Hi,

We have tried connecting only hfp client profile with mobile device.
During connection source and sink cards are getting configured with CVSD 
codec and when we try to initiate a sco connection, the codec 
negotiation is happening with MSBC codec. But the existing cards didn't 
reconfigure to MSBC codec and due to this audio garbled issue is heard.

This issue is seen only during first connection(Initial pair and connect).
 From next connection, source and sink cards are getting unlinked and 
during sco connection,again they are getting created with correct/proper 
codec.

Is there any solution to solve this issue?


Raghavender
