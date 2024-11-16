Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5467718052;
	Sat, 16 Nov 2024 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731772682; cv=none; b=ltFS63fSgGg3fBZSsGydJsRFEXd5rVS5TSHKk/Y2rNlhIE8Z8NWYOB0FLu4i0YW4jtYn2VRLGlzSXPF0TFmuwhgT4xdgHmXcPiqw+/DDI1SctT8+VZ7rzLKVO0aas17X8pRdllPU2AVj+tuqc6fhBCI4KfYpIdxRsvzHMHejWKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731772682; c=relaxed/simple;
	bh=qk7bCmQcrnN9WrLj4gnzvx30ml8SMJ2mcbxkOj65Q0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pxyb7MIV7Df1SbwJzBOBUkX72WOm21e7mOWOq9PGzSfXRe2xmsZTaw8QjJACI0khqMINQsKKclFJXNbgojjhujlS05DKaDgvzXw1cnesQPwxGv/p2f/AAarEjBe7U9iUmwFGF0nzb3CQZ2yp+sPrsoq1kTKfDxM2QtO/fx+gImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jZQBmKJf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jZQBmKJf"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGCnWIc032525;
	Sat, 16 Nov 2024 15:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NQy2WynApfeMW0aClySMjhMlPLSEjgDF4S2cE+td76M=; b=jZQBmKJfCUUp5feT
	jRWFHiKLRcclQPCnJ4ynQEFSMWmGbx926/iEoGev7CbbxuRZD0NHh+O0RIefXM35
	ZqqW6Rcy4KAGXbTRwe0qOtCxMqYXDdf5bXVl7BqrAwADISQxxO/hS0A2dba0MWDA
	+G0V4Moqk4yYsYquqyRlaMUOTSZuISULSZ3s9Jr928QKGguHgGO55aS/slko2tqp
	ULOlrS5MviJjndFRTVA0NrVt6mblfuaLtbJomrdQUpVbAvCV4VP5j0EBTcTdPPBT
	d5xEAURhcvCkVHAVJvge5oMQrRlXx7g0IlNxOb30AxlT5SrHdzoj2OCx6g/VP+/a
	U1lT4A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42xkv38y1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 15:57:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AGFvmMG025768
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 15:57:48 GMT
Received: from [10.253.8.97] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 16 Nov
 2024 07:57:45 -0800
Message-ID: <77e10e15-57d5-4fda-870a-6dd95fd4a2ea@quicinc.com>
Date: Sat, 16 Nov 2024 23:57:43 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: Support downloading board id specific NVM
 for WCN6855
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bjorn
 Andersson" <bjorande@quicinc.com>,
        "Aiqun Yu (Maria)"
	<quic_aiquny@quicinc.com>,
        Cheng Jiang <quic_chejiang@quicinc.com>,
        "Johan
 Hovold" <johan@kernel.org>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Steev Klimaszewski <steev@kali.org>
References: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
 <CABBYNZJQGCnsKtdKaByLJkgV715oOorOQLLK8Z+g1BYz9YovNQ@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CABBYNZJQGCnsKtdKaByLJkgV715oOorOQLLK8Z+g1BYz9YovNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GFTY4jxFONjH3OK3guAY6WTfxuladtVQ
X-Proofpoint-GUID: GFTY4jxFONjH3OK3guAY6WTfxuladtVQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411160138

On 11/16/2024 12:40 AM, Luiz Augusto von Dentz wrote:
> Hi Zijun,
> 
> On Thu, Nov 14, 2024 at 1:27 AM Zijun Hu <quic_zijuhu@quicinc.com> wrote:
>> Download board id specific NVM instead of default for WCN6855 if board
>> id is available, and that is required by Lenovo ThinkPad X13s.
>>
>> Cc: Bjorn Andersson <bjorande@quicinc.com>
>> Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
>> Cc: Cheng Jiang <quic_chejiang@quicinc.com>
>> Cc: Johan Hovold <johan@kernel.org>
>> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>> Cc: Steev Klimaszewski <steev@kali.org>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> How about adding the following:
> 
> Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI
> Bluetooth chip wcn6855")
> 

good suggestion. will add it within v2.

> Not sure if this would be simple to backport given that there are
> things like 691d54d0f7cb ("Bluetooth: qca: use switch case for soc
> type behavior") that may have to be backported as well.
>

i will help to backport this change ASAP once it is mainlined.

thank you luiz for code review. (^^)(^^).

>> ---
>>  drivers/bluetooth/btqca.c | 35 ++++++++++++++++++++++++++++++++---
>>  1 file changed, 32 insertions(+), 3 deletions(-)

