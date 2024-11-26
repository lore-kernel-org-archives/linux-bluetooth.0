Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0C1D5175
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629122; cv=none; b=tL2Dyv5qEClm/KIqDjLEAx2v5cXzdocs/2BbpVrK/WwDT7YhyEw2EpvBEA4PFdNNibAExsBBUpgOYCWQLI1aSbuigyA8uz+FBw46OfFdAnbN8k9dzOfaBTs2XzwlLQkW1IwGsZMej2MY7UyhTgJ44uGyxMp5Drf91sh0WRHghNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629122; c=relaxed/simple;
	bh=N+Paf9BcurCQRdaGQLcHZ5wCo6x79tkIqkWg7Ishz+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=A5ksBAv4XZmJHAYbXfRXfJE72ofInegrT6PDJ6Btv6+0BRevfFsAiLIHWYM6ws+hk9xYJq7yEZM/WfrVFPdC6FJz2UYrlClgwCI1ur2PLGuRXxSbQae2swOwKf9iR1rwE7HuN992ojl2fwiYecw909CvyzmJ77S1XrjPYOLhsnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=li8IqVMz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="li8IqVMz"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ9VF1N021756
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 13:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SIlqDrz5fuRjleoMS6SWFb2/JqJSHxPsrWxLCaqIaFc=; b=li8IqVMzS99kzdkF
	Vgw5Kh6t8XYmqtgTg+1cfGFJgxa42dfmNe5JkVxRqf5u0Zmwe4xTftRKNY0UwlAP
	aiykMThiahKXZ+CyQPoptJSB+akOtzupOiCj2H549Roo0D3nmYrdQPrhTEyZZ4bT
	QnelzXLHPAQ84KHgOzfgZVVuEMnb6QBHj1jhn+4Z1Zf2Vv0z16av7cqEBSStkC0O
	MNNRKKDDymJCfkFkq+TSNb84DD4SjLbh23oPTuhJq2PCwTL1MbvfEuDdE1Q57HWY
	qUDmFEqHD4NdOkk71hgO3jRPeQhmYT2yqeHk0eN0W0/NrSQ/PrKsGXvdVY8jNCBo
	8lK+FA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4334rd8hgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 13:51:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AQDpwA7008207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 13:51:58 GMT
Received: from [10.216.10.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 26 Nov
 2024 05:51:56 -0800
Message-ID: <fb8909c9-1eda-4da5-8360-2456b8166149@quicinc.com>
Date: Tue, 26 Nov 2024 19:21:53 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BlueZ,v5] tools/obexctl: Add support for system/session bus
To: <linux-bluetooth@vger.kernel.org>
References: <20241121094852.2666939-1-quic_dgangire@quicinc.com>
 <673f1605.0c0a0220.11852f.65be@mx.google.com>
Content-Language: en-US
CC: <quic_mohamull@quicinc.com>
From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
In-Reply-To: <673f1605.0c0a0220.11852f.65be@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FLkW1-XbuaVFIk_QxiTIUkEUej5HQZWP
X-Proofpoint-GUID: FLkW1-XbuaVFIk_QxiTIUkEUej5HQZWP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411260112

Hi Team,

Please provide your inputs/suggestions on the patch.

On 11/21/2024 4:44 PM, bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=911469
> 
> ---Test result---
> 
> Test Summary:
> CheckPatch                    PENDING   0.16 seconds
> GitLint                       PENDING   0.25 seconds
> BuildEll                      PASS      21.20 seconds
> BluezMake                     PASS      1631.79 seconds
> MakeCheck                     PASS      13.89 seconds
> MakeDistcheck                 PASS      161.44 seconds
> CheckValgrind                 PASS      216.19 seconds
> CheckSmatch                   PASS      276.31 seconds
> bluezmakeextell               PASS      100.75 seconds
> IncrementalBuild              PENDING   0.26 seconds
> ScanBuild                     PASS      863.14 seconds
> 
> Details
> ##############################
> Test: CheckPatch - PENDING
> Desc: Run checkpatch.pl script
> Output:
> 
> ##############################
> Test: GitLint - PENDING
> Desc: Run gitlint
> Output:
> 
> ##############################
> Test: IncrementalBuild - PENDING
> Desc: Incremental build with the patches in the series
> Output:
> 
> 
> 
> ---
> Regards,
> Linux Bluetooth
> 

