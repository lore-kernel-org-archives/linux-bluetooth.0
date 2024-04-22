Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F81F61C
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773268; cv=none; b=pl7gVWOeKhWW3LmiUFst0G63q1ln0HLsJ3iQ9k4QDnphL+bn0YdCfk4OsIK0ZsqMFPnbkkgwFh2XV1C9+scI5vvjtL3tpjHK9PddigLS/WnxllCfsKdWVWWxkTpM/L7eZcoM7ehYjyJMYyV5kLtJcZkkmtQ2f6v6JuTGvvj5Gfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773268; c=relaxed/simple;
	bh=yAUtvNWEx3VyucjySSC3xkJIFaQIzjg+CPNUfQKLwoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kFY75lEh+7RuWxnxHIlIKciO2BSRD32wnAfbQ6eIunc4NnmE4XnXhvEglPV3Ysu5reL2GAtB8Hlxf81Aj43+5UFLC3Pq4axemrZT1kviVQaN289iwxOXV2TiVWYTNx3vobMq4b4Fa6LnkmKG7mfjYSKxYGW+E8HgvBgzQiQaIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N7fTbFGy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N7fTbFGy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M4ZYIN007895;
	Mon, 22 Apr 2024 08:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dIBC4Ve7Fav5BtS7pd9GyB+QbsEYDldFgyRNtmVxrKY=; b=N7
	fTbFGyihk8GQRgo+wsZ/9oRV5q4ZvK3/qgZD/LQMZkw+EhRmohYU3FtxnmYy5d/l
	BzEyJZYqRq4ry3uTuI24uIKVhF6QSQoIc/oaLcp5mVwo68O62VxMTquqMAL1dYPO
	mzdNEhTiGHdbtnUuXy04SOLVGtTizmRbh8Lostlditx8N5CqxSChXyxPrrg4XA0/
	RVDrwqY3JCPbmpypdmNYOm+7udKASEsMUUrJKmGXKDIQXcLX620Mh0MHcR7iO3M/
	VksvJ2HuT+MjbAwyrg1+sUgv9/yALpDhi+YlIVsxeozKHo9JQ9ifJEvPX8UPYZHp
	w5A9yumalqck0ZY6t24g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm70ckft5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 08:07:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M87Zl6023405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 08:07:35 GMT
Received: from [10.253.37.80] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 01:07:33 -0700
Message-ID: <04211e34-5a6b-45ec-91f7-60aaf0b6e2c5@quicinc.com>
Date: Mon, 22 Apr 2024 16:07:30 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Fix two regression issues for QCA controllers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <wt@penguintechs.org>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <3ab33f9c-206a-4c77-816a-471769591b6c@linaro.org>
 <8e2b0731-fc0e-446e-af83-478e6e86a7ad@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <8e2b0731-fc0e-446e-af83-478e6e86a7ad@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YtrjRTFu6kaOz9biK72XrktfX3qHMYnF
X-Proofpoint-ORIG-GUID: YtrjRTFu6kaOz9biK72XrktfX3qHMYnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_04,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=936 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220037

On 4/22/2024 3:44 PM, Krzysztof Kozlowski wrote:
> On 20/04/2024 13:01, Krzysztof Kozlowski wrote:
>> On 20/04/2024 00:03, Zijun Hu wrote:
>>> This patch series are to fix below 2 regression issues for QCA controllers
>>> 1) BT can't be enabled once BT was ever enabled for QCA_QCA6390
>>> 2) BT can't be enabled after disable then warm reboot for QCA_QCA6390
>>>
>>> the links for these issues are shown below:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>> https://lore.kernel.org/linux-bluetooth/ea20
>>
>>
>> Provide changelog, either in cover letter or in individual patches under
>> ---.
>>
>> Do not attach (thread) your patchsets to some other threads (unrelated
>> or older versions). This buries them deep in the mailbox and might
>> interfere with applying entire sets.
>>
> 
sorry, not notice this.
in order to send vN patch sets.
do i need to --in-reply-to  v(N-1) cover letter or v0 cover-letter ?

> How did you implement these two feedbacks?
> 
actually. i don't understand that two feedbacks so ask above questions.
> v4 and v5 are still bad.
> 
> Best regards,
> Krzysztof
> 

