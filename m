Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3914C630
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790782; cv=none; b=Gl3vdn+I6CYfYKuxHE4uU6cJK5F3zLV4JXouIBBjljFEwKVq9Rmb/Obsvbw/poM9aZnKprF20DOkt/qp1Z/O8cUf4NnA7Uf0PJxoaJAbqs6wDsl6MmoVHEFqr39KL8048DmVRuskQ4herK8UkPA/xP+B8QIq2xNji4Ey1mjfBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790782; c=relaxed/simple;
	bh=JkRtCItjT4NMSrbW/cfwXoeV8pTXaXLRZxT9BbtPJpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G2E24eu5RUuGxDGmq4QTSiSA5l63GinuECbLKRRERA/x8RbayAS3BQwxxb/NCx3Ylu/CcoiuEXTtG56RLtUE9u33X+kS5fbCIbUxIk2e6+wH221pzxb5Z26EKPeE4y0FsLy0qKlSwh137mtfv6BGo1U8mUOCjV3tpnxOnkhohdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jcGJzdEx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jcGJzdEx"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M9cRd4006564;
	Mon, 22 Apr 2024 12:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8wrVt0/VjRkt1zb9z5YMK3jk5u7j2B45htwyCqFXlv0=; b=jc
	GJzdExp6K+/kfWOay9z8KeXDfOjZktqzknxXzohvbIScMtMuqhvenQw3js40ltF1
	Ln2idpepDQKEP7kgkoFTDDBpBDbteF4+qW3bSlppomVcPsFW07OYeT0UeWV6RZFy
	uzts5xGi4hczD5+qEBLvuFGXMyGQgRXEWrdsU80HQM/hLZy05Bz05Tnxl37KUoXh
	Nxvzmua7KPRXjVNeHSGI7oYoZp/2tV5cYlVlOFjvZaEQGlJLe48METRINfHGtSD6
	Tkr5uOr6qjM+nWed+XFpkotJbeXiu73G2wpjv31AeNfwAGe267IdWaX8e3W7qW1H
	K2faaPdQAB5+330Q1Ejw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnne28dyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:59:33 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MCxWfd030679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:59:32 GMT
Received: from [10.253.37.80] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 05:59:29 -0700
Message-ID: <9ac11453-b7cf-43f3-8e46-f96e41ef190d@quicinc.com>
Date: Mon, 22 Apr 2024 20:59:27 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] Bluetooth: qca: Fix BT enable failure for
 QCA_QCA6390 after disable then warm reboot
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <wt@penguintechs.org>, <regressions@lists.linux.dev>
References: <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713771497-5733-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713771497-5733-3-git-send-email-quic_zijuhu@quicinc.com>
 <f744a2ba-f842-454a-a04f-76207f0db9bf@linaro.org>
 <930736f3-696c-4076-93fb-d879691bac66@quicinc.com>
 <01b0f63e-55f0-4396-bb8b-521bbe9b060e@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <01b0f63e-55f0-4396-bb8b-521bbe9b060e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7P5UiZAPTQtkCccWb4_CJ_zdaVrIdgVV
X-Proofpoint-ORIG-GUID: 7P5UiZAPTQtkCccWb4_CJ_zdaVrIdgVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220057

On 4/22/2024 8:22 PM, Krzysztof Kozlowski wrote:
> On 22/04/2024 13:25, quic_zijuhu wrote:
>> On 4/22/2024 3:42 PM, Krzysztof Kozlowski wrote:
>>> On 22/04/2024 09:38, Zijun Hu wrote:
>>>> From: Zijun Hu <zijuhu@qti.qualcomm.com>
>>>>
>>>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>>>> serdev") will cause below regression issue:
>>>>
>>>> BT can't be enabled after below steps:
>>>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
>>>> if property enable-gpios is not configured within DT|ACPI for QCA_QCA6390.
>>>>
>>>> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
>>>> during reboot, but also introduces this new issue regarding above steps
>>>> since the VSC is not sent to reset controller during warm reboot.
>>>>
>>>> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
>>>> once BT was ever enabled, and the use-after-free issue is also be fixed
>>>> by this change since serdev is still opened when send to serdev.
>>>>
>>>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>
>>> NAK. This is way too much. Previous discussion is going, I asked there
>>> questions and before any answers happen, you keep sending new version.
>>> This leads to previous discussion gone/missed.
>>>
>>> You ignored several questions and feedbacks.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> i believe my commit message explains WHAT/WHY/HOW about this issue.
>>
>> 1) the qca_serdev_shutdown() was introduced by my below commit
>> Commit 7e7bbddd029b ("Bluetooth: hci_qca: Fix qca6390 enable failure
>> after warm reboot")
>>
>> 2) then Krzysztof's below commit was made to fix use-after-free issue
>> but also causes discussed regression issue.
>> Commit 0b7015132878 ("Bluetooth: btusb: mediatek: add MediaTek
>> devcoredump support")
>>
>> 3) my fix will solve both this issue and the use-after-free issue.
> 
> I had to keep reminding you about answering to question multiple times.
> So one more time:
> 
>> You did not address original issue of crash during shutdown and did
> not clarify my questions.
> 
let me explain here. original crash your commit fixed should only
happens with machine for which property enable-gpios is configured,
which also results in quirk HCI_QUIRK_NON_PERSISTENT_SETUP is set. for
this case. for this case, serdev has been closed when
qca_serdev_shutdown() write the VSC to serdev, so cause the crash.
your commit fix this issue for this cause but cause regression for the
case my commit message described.

>> Anyway, any explanation providing background how you are fixing this
> issue while keeping *previous problem fixed* is useful but should be
> provided in commit msg. I asked about this two or three times.
> 
i have provided it in this v5 commit.
>> BTW, provide here exact kernel version you tested this patches with.
> Also the exact hardware.
> 
we can provide the kernel version in the bugzilla, as explained above,
for the same soc_type, different machine have different config.
different config have different result.
> Best regards,
> Krzysztof
> 

