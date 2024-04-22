Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874AC14658A
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785136; cv=none; b=fAfDHmO3zVhut+Q8utwNH7I5d/jMkgA53eSGnWtxp81wfUvvoMonNa2efAsqSFQqBaD/qPnEBlF23Uxjbg8UTCIzsqw7hBxDzXIQts5cYgLBVktrY9FQ1CcIOX5/161O9hEDmrtffowQRaOWlLsnxqc60ApfVH5sXBkavYZTKN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785136; c=relaxed/simple;
	bh=6Ek475WwciTCayxC7hTVryHZ9ciAMChJIzEQhexou8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FgTAaw9k0M7rSkIk9MMJMirYi5dmU2z1c+R7kOXelzGrs5xroxJVjgsvOV4t1Y6Wx0qxQOkzvX4Z1Rmo7sEROjcaHcb8V0zu1auZMJSzChFwr0AmFW7ojEIDKGkhYLhsS+QWKsgWJVtwBhfRtU1Gf6BsLnlfurcrAnIHBhFzHNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FQx/1GR6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FQx/1GR6"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M25eCM027623;
	Mon, 22 Apr 2024 11:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=NPBMpPfIcMcS6UBtC3uaHZr+ggmmAMSiArb1Bh8gW6M=; b=FQ
	x/1GR664wERmwMauO2XgV4ZZUmBPQKVCpXPy91Tq3dbnVTqZX/BGHDTz2E9iII0y
	rU9zavLsS4Tbv7n7JxKF/eVOvPqnCGivYC8mn60aggtjidMdo10o8vnarapleyvR
	llIxDgLfploACqb+5f/ihWuU03vzp54FBCK3wpqw2GVIW8KBA2iCewj+RoaazdNP
	7W2Tp9jWjiTNM63J1pOhX0Zxpsl9Twwwn6aBWkk8p8Q5YFPfNbGJVPO66TeUPC4y
	CFMLlynT+/tB0cleKwyhV89ki0M9XyZe8WMIjEQfgBJHb3OfL1rSRk8H5wG0fNnb
	4Fn/SAF5JNBOxoXZgCYg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnet794cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 11:25:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MBPQXm030547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 11:25:26 GMT
Received: from [10.253.37.80] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 04:25:24 -0700
Message-ID: <930736f3-696c-4076-93fb-d879691bac66@quicinc.com>
Date: Mon, 22 Apr 2024 19:25:22 +0800
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
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <f744a2ba-f842-454a-a04f-76207f0db9bf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iKZPNFHNsp_-b65oXtW_0ZlJJ0fJXEBo
X-Proofpoint-ORIG-GUID: iKZPNFHNsp_-b65oXtW_0ZlJJ0fJXEBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=561 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220052

On 4/22/2024 3:42 PM, Krzysztof Kozlowski wrote:
> On 22/04/2024 09:38, Zijun Hu wrote:
>> From: Zijun Hu <zijuhu@qti.qualcomm.com>
>>
>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>> serdev") will cause below regression issue:
>>
>> BT can't be enabled after below steps:
>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
>> if property enable-gpios is not configured within DT|ACPI for QCA_QCA6390.
>>
>> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
>> during reboot, but also introduces this new issue regarding above steps
>> since the VSC is not sent to reset controller during warm reboot.
>>
>> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
>> once BT was ever enabled, and the use-after-free issue is also be fixed
>> by this change since serdev is still opened when send to serdev.
>>
>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
>> Reported-by: Wren Turkal <wt@penguintechs.org>
> 
> NAK. This is way too much. Previous discussion is going, I asked there
> questions and before any answers happen, you keep sending new version.
> This leads to previous discussion gone/missed.
> 
> You ignored several questions and feedbacks.
> 
> Best regards,
> Krzysztof
> 
i believe my commit message explains WHAT/WHY/HOW about this issue.

1) the qca_serdev_shutdown() was introduced by my below commit
Commit 7e7bbddd029b ("Bluetooth: hci_qca: Fix qca6390 enable failure
after warm reboot")

2) then Krzysztof's below commit was made to fix use-after-free issue
but also causes discussed regression issue.
Commit 0b7015132878 ("Bluetooth: btusb: mediatek: add MediaTek
devcoredump support")

3) my fix will solve both this issue and the use-after-free issue.
