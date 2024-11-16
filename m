Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E89EAF6;
	Sat, 16 Nov 2024 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731773686; cv=none; b=dl7krvDdz1bBoIL+JKqAdFb6cKybL5IaiNic0NeBGHCIt3wsSsTaAD5f7MDT6coWzFFP3YxyIuorBvmkmXk4xi66GiqVNMx/yLtPpF2G04Ssc5h7QWF5clZX+KOweGGJRR+ouYbdE/H+Pyx1y5bophLMVd/N1g/1xmA/u+lTD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731773686; c=relaxed/simple;
	bh=Z+FS3aH9ns/09plAyTBL04srlqkqXUqce8PfMIJ5Qoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WN2AGAA/NK5ocRceCp59sgxT/V9BOCeXQJxaQ8scz0DIb7gIr3O4ZnjXwBpTOHN7+4sD5bzwR7EJwiyJ1d11kp4RUSCPpcNRxwOhMjOE1zbURl6YnLkCPFpnG76Luen+ftUa6J8PahT7ESpsIqLCqPsbv5/c2MPSPlBZVr3/6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hvfaQCI3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hvfaQCI3"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGFJbA9013107;
	Sat, 16 Nov 2024 16:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YniZ3f1E+sc5s0E3erFuJzdfsAgutZY81DqXchcGWr4=; b=hvfaQCI3nRIYjMo0
	A3AkWBo7VU3DVlMVMTiMayzZ6enKd7yi9GEOHQiABdlvLp/XrutunQguHNSnmJf8
	xuf8q172LH2NKq+oyGpfZGpKXhsJ/0OM96rFU7AY7OYN+NgV2+VVF0nW1r/5iXcg
	ChE1wPsEITHyXekok05Gy434ARQRgyQfnatbqzr/boEaOZYGCGHKTWuALt2OmUuA
	jkuSr9l7NxT3ToCxEhTlP3Ldvmmxc764jSsjagGFWbtekBxmIcalbNn2D7C7sE+S
	luZIxzC/A58nkUkXwm9+lrkTDTKwg9GWoEizwQeeKpEbk6u62ZpDVpwRIteLgHwP
	mkyJNQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42xkrm106e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 16:14:31 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AGGEUmK007646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 16:14:30 GMT
Received: from [10.253.8.97] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 16 Nov
 2024 08:14:27 -0800
Message-ID: <a63ae3c8-cb5e-4155-87d3-b448d09be9ae@quicinc.com>
Date: Sun, 17 Nov 2024 00:14:25 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: Support downloading board id specific NVM
 for WCN6855
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Zijun Hu <zijun_hu@icloud.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bjorn Andersson <bjorande@quicinc.com>,
        "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
        Cheng Jiang
	<quic_chejiang@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        "Steev
 Klimaszewski" <steev@kali.org>
References: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
 <41966d59-063f-4848-9776-399ee348069a@oldschoolsolutions.biz>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <41966d59-063f-4848-9776-399ee348069a@oldschoolsolutions.biz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lPI5UCGA22RLYFZ6ziDeudRbVxkhpYtg
X-Proofpoint-ORIG-GUID: lPI5UCGA22RLYFZ6ziDeudRbVxkhpYtg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=870 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411160140

On 11/15/2024 2:40 PM, Jens Glathe wrote:
> Hi Zijun,
> 
> I tested his patch on the HP Omnibook X14 and on the Windows Dev Kit
> 2023, it works well. Thank you!
> 
> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 

thank you Jens for helping verification with your machines.

(^^)(^^)
> with best regards

