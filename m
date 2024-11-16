Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8470E372;
	Sat, 16 Nov 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731773246; cv=none; b=sX4jQJrXuE9IF9U09r/BbHh/xE9OuIhcPSU4csI0RIY8q4Q99jceH5XJogkBWPwD7/WsgaFgYnHd6vsw6y5DLmt0ZIHDP9GvHGW5ccOy141wElDBgm0k/FOU4WGic9dfLEA6cfZGEQqyl6ylNJXR1GbdjJKXCeUaNu9yKH5Jsg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731773246; c=relaxed/simple;
	bh=wylaWJR0acGeGX1yBxFH8MsEVHJG/4q3VPC3lfDnhZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RmVwvy8liviCPNJ33sP9vqCrKP7voxZM+QygjTS9BjTDxgL1R88ZBB7nwCZS/S2/D7wMcOnnS39D0zgayqKOLAQd8qmAza4vbbeAQz96GMoFfiDtzgyWxs6ALs7W44JtlUqbI1wFJcHRtjaVSJLKjiPzwOmqeyQ74tkx22VSJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V6wL8vj2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V6wL8vj2"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGBtLRe019812;
	Sat, 16 Nov 2024 16:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tKkHBgtzTghGd8itEi931CamhAt3K0AyD3r7RftjAF8=; b=V6wL8vj2eYMZS6zE
	NEYIo2xVa77vDwPXZy101yhCaczSnBpHBH7TNLSIG3P3IrDvE9ySDk/BdBMa0+lH
	GZqnuO65zdD89/z7CgfJa6EiI+Vkr179JqvCKVqUpqJ35fH7mkpF3QnafeC5kG0W
	C/6GqJiz7PwYukqI6fRQWOr9ROPmua4AZGvcU9qA3nzFazBwYbvwSCMZe57u3j7B
	3iKbk0bwg6J8hXXh1pml55Lmm15rcSknWrARFzV6GvNS2NS7nmIpEknfcLfw6Jgx
	w6nujRf+EhcgCXolexGG/dACy5xs2RmGogE1um5TqfBMaTFvR60loHKgUJSkNRLa
	4NAwiA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42xmp78x7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 16:07:11 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AGG7Bwc021345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 16:07:11 GMT
Received: from [10.253.8.97] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 16 Nov
 2024 08:07:08 -0800
Message-ID: <a3725b96-4811-4ecb-bad1-1e859b730423@quicinc.com>
Date: Sun, 17 Nov 2024 00:07:05 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: Support downloading board id specific NVM
 for WCN6855
To: Johan Hovold <johan@kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Zijun Hu <zijun_hu@icloud.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Bjorn
 Andersson" <bjorande@quicinc.com>,
        "Aiqun Yu (Maria)"
	<quic_aiquny@quicinc.com>,
        Cheng Jiang <quic_chejiang@quicinc.com>,
        "Jens
 Glathe" <jens.glathe@oldschoolsolutions.biz>,
        Steev Klimaszewski
	<steev@kali.org>
References: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
 <Zzcb-Yqvs3Mn2PxC@hovoldconsulting.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <Zzcb-Yqvs3Mn2PxC@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KhxicFVQsuq_ZILsTAvteWiFI_RPy5fk
X-Proofpoint-GUID: KhxicFVQsuq_ZILsTAvteWiFI_RPy5fk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411160139

On 11/15/2024 6:01 PM, Johan Hovold wrote:
> On Wed, Nov 13, 2024 at 10:26:56PM -0800, Zijun Hu wrote:
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
> 
> This works like a charm on my X13s which has the GF variant.
> 
> Unlike with the "default" NVM file, the range is excellent with the
> board-specific file now pushed to linux-firmware (similar to what I see
> when using the Windows driver NVM file). Specifically, the range with
> the headphones I use for testing increases from about two meters to 20 m
> (around a bend).
> 
> Even if these NVM files didn't make it into the November release of
> linux-firmware and therefore won't make it into the distros for another
> month, I think we should mark this one as a fix and backport it to
> stable as soon as possible.
> 
> Zijun, could you amend the commit message with some details about why
> this needs to be fixed and backported (e.g. refer to my range example
> above)?
> 

will do it within v2 as you suggest.

> Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855")
> Cc: stable@vger.kernel.org	# 6.4
> 
> It's possible to add a comment after the stable tag to delay backporting
> until the next linux-firmware release, but in this case it may be better
> to break existing setups and force people to update to the correct radio
> calibration data.
> 

i would like to temporarily add fallback logic within v2, then i will
help to backport it ASAP without breaking existing setups even if the
current default NVM are not for WCN6855.

> Either way:
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>

thank you johan for verification and suggestion.
(^^)(^^)

> 
> Johan

