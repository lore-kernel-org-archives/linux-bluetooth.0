Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849E171E75
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713475027; cv=none; b=t4fzgDeJLAjrYZYfxBXxsRGa5xgglQYwCbL6WJKMmK8lcCc4GkDUxQnBG3kLr5EYxDjg3r6f2oBpYwfTguaaE+tlVoJEvO/PmCSUZDXYwXxHUMQFpzeYXDuJreTLw7TOSch+jL8mJoSEMMqZmCoe9iGjp9lpl5dWM4GPDZytFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713475027; c=relaxed/simple;
	bh=fYhcAd+1or0zBcc0RrR9HlovoYXdKVBf0WH47DuFNag=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZdxqmPLR2eMbMRduOE5ZfqJgGkn8iGaBO3gptUXegMpaBVwuuAsOhXTsNOEC6AKKiOVf+ZklxWQm5FsGPd+HLMZqqzJcoDw1HPMlyevuDPXZ5oO9EgpOT3TdEeuiLzlzyJSaS5TiwxmyVB3BBWHvximYF32ujKjwRunGLgMeigk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MVwlFPrA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MVwlFPrA"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43ILGsR3009630;
	Thu, 18 Apr 2024 21:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=T53Ukuiu8uxufJ4jqjOnGeEhQaFXdlAmlu9vAF5YFgg=; b=MV
	wlFPrAPNJCxeH5n4cxlovKhwDvsHes3HXSgxXDsZqUvB9/zTvJ/3r/nC0yTN2h2y
	vtNXKUFgB85csoiyBNNIM2jaDXqP98uNPuioQPWew/E50z2qV+yl4zTcQ/1L32QD
	4hxOYFxMzSN4sh4aOqzpCz0j2h7o97FjgpCTohIX9dicPHqbOVLEQqkYkeqUwAMb
	Cl48jTJetme2lhr3C+0crxzjhVqVa8InaanvBVEmoFN0weuKzsn6OFJOjtjwYfD2
	thNzTZ4tCokweL25KUofkm35qca3FfrCRp1nz7dx6X3YnCulR0Rqec/TzNkf+XOF
	EyfTM8g4yvgX4pkwLfAg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjupht954-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 21:16:54 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43ILGrSn032421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 21:16:53 GMT
Received: from [10.253.9.141] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 14:16:51 -0700
Message-ID: <7c5b85ca-e897-4798-97e7-955478c57d12@quicinc.com>
Date: Fri, 19 Apr 2024 05:16:49 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <wt@penguintechs.org>,
        <bartosz.golaszewski@linaro.org>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <83a1c837-e403-4da2-83c6-ee3dedbc1fe0@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <83a1c837-e403-4da2-83c6-ee3dedbc1fe0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6qPzPEXaZmz_drMDIEEmw7Y8bJ7hli5k
X-Proofpoint-ORIG-GUID: 6qPzPEXaZmz_drMDIEEmw7Y8bJ7hli5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_19,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404180155

On 4/19/2024 12:52 AM, Krzysztof Kozlowski wrote:
> On 18/04/2024 16:06, Zijun Hu wrote:
>> This reverts commit 56d074d26c5828773b00b2185dd7e1d08273b8e8.
>>
>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>> with gpiod_get_optional()") will cause serious regression issue for
>> several QCA controllers such as QCA_WCN6750,QCA_WCN6855,QCA_ROME,
> 
> The pin is required on 6750, 6855 and maybe others. You cannot not have
> the GPIO.
> 
> This is no correct fix. You provide wrong DTS and, instead fixing it,
> try to revert kernel code.
> 
> No, fix your DTS first.
> 
no. your point is not right.

1) do you have any evidence that the hci_qca driver must use reset GPIO?
2) why does original design do error return when get GPIO error if GPIO is mandatory?
3) i meet many customer cases that BT are working fine without hci_qca operating the GPIO,
there is why HCI_QUIRK_NON_PERSISTENT_SETUP are introduced.
4) does the reverted change solve the issue your mentioned ?
> Best regards,
> Krzysztof
> 

