Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE781372;
	Sat, 16 Nov 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731773451; cv=none; b=ZRTqP9NL2joP4EQdwrAQ7zBF7q9JcRti33Bs2nMy6JwPSPEshuwN0L9izTaLhMLLfL8kvooYUpQK/p/Wg+NEf5KcQgVsKdrnXPXNdduOBx9jyxfjGrT/8oHE+t8Q2FRNMkRYbtaydJXyqckl6VBTKL/tXGiOmy3EZN2BeyC7EJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731773451; c=relaxed/simple;
	bh=bE9I7jbo7EwEHmnSYuS78gyXK8w7LqS9iHRxarfkXQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d12kknWiu0BoUqJuoHjbw3zKLZEM55K2baelTNcAKbbo/4MVfnkqZpoRnR1ZcL/ZYbKKoWr3UWORdxP5d8TNrOwZQQjcxqO2AC2lgxVVfoGYutcUt9TS0KzQa9Lz1LK1BE14yOHtt8pm5GeQvXiT5t+gRw+wFzUlqxe5LM2Z9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K/MhkdMp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K/MhkdMp"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGDP2Ox004445;
	Sat, 16 Nov 2024 16:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gy9U9UPyHSzhnf5nC9s9djsgQ2Xgc1/T46oTs5+stjg=; b=K/MhkdMpzi8w7M+s
	JG0iYSLK1YohVxa//Mg1qEw8xw1wDiZDfv4hMMv26YDKVGI76z2TGsn8RA2omG6P
	QFNDIifcOHG8wz/2BPCKMUTldhkqduMfOjMiI3G7yJGxCvMWjc6zUQFeEyT0+d/X
	9LN1C6JtMifzjAaA8mTikfTy1r5j3LiwXBNo27y/Y8CDuPkNTtTv6X/++Cnfs2GW
	HNTzyuH2wXDzpe1tc/kITzFPTQTDIL8HqQBGntXsNY3ISBtECS3U7oe4Yt3uvmBV
	zKhJrzXTvu61FQQJvQlsKIHm1ol66O7vRWtWUojs3DrWp52+GzuLT5d0Sl76Ir/3
	6t5TxQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42xkv9s14g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 16:10:25 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AGGAOPc003017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 16:10:24 GMT
Received: from [10.253.8.97] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 16 Nov
 2024 08:10:21 -0800
Message-ID: <de0c487a-b1bd-40ac-bb9d-eaf97d655e4d@quicinc.com>
Date: Sun, 17 Nov 2024 00:10:19 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: Support downloading board id specific NVM
 for WCN6855
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Zijun Hu <zijun_hu@icloud.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Bjorn
 Andersson" <bjorande@quicinc.com>,
        Aiqun Yu <quic_aiquny@quicinc.com>,
        "Cheng
 Jiang" <quic_chejiang@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        "Jens
 Glathe" <jens.glathe@oldschoolsolutions.biz>,
        Steev Klimaszewski
	<steev@kali.org>
References: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
 <4d973d61-27be-4830-880a-a3d74c4bbbc7@molgen.mpg.de>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <4d973d61-27be-4830-880a-a3d74c4bbbc7@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1BKg7lZq_Nzv8bv3fXrIP3NFf6vaIUnp
X-Proofpoint-ORIG-GUID: 1BKg7lZq_Nzv8bv3fXrIP3NFf6vaIUnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=904 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411160139

On 11/14/2024 5:49 PM, Paul Menzel wrote:
> 
> Thank you for your patch.
> 
> Am 14.11.24 um 07:26 schrieb Zijun Hu:
>> Download board id specific NVM instead of default for WCN6855 if board
>> id is available, and that is required by Lenovo ThinkPad X13s.
> 
> Could you please start by describing the problem/motivation. What does
> not work with the Lenovo ThinkPad X13s before your pacth.
> 

will do it within v2 as you suggest.

> What is variant *g*?
> 
> Maybe also describe the file naming convention in the commit message.

v2 comments under --- will contain reply about this.

thank you for code review (^^) (^^)

