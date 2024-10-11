Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C242030A
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638169; cv=none; b=aDJNWEpcMTOnXLa4VAjZ8bDpVRIw/8xn53YVZJXN6Kdw15d2I4aI+Nwfh+VXt+YC9JOkrDeeFMbJ+QV9tTNASM2awJ/72lz0wCvKzGiJ0/2BPftgC9e9Oc5YnxNmE/Y3U6YxDn07HIzbp9ga4dn2zyZdf3vxysWfB9D06OuTS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638169; c=relaxed/simple;
	bh=Gta4L6vCQPXC/um40gEtqHuHXdvU2Je5H7IilpkI+GI=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=rsyfdaFEqgcDaiFek2cO98vb8UkX7A+sjidsTd/h4Z7uzp64Qlq+D2hU36xQTKNtEhUmRXXYRIE3jwctCFlfAxTOVzYfa8i6sPOtJAej3MnjYqFlG4nt/veoRvcll0LSa8UaEeKSA9R8nVTVM8ty2+z5+sOojp8zlrWoK7jXQ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nPFCX1qC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nPFCX1qC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B50ohl029089
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 09:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rUqKN9kkztDy1ZbkV12VT5
	2dwAL+tjsEJMiYw6C1/5I=; b=nPFCX1qCbSFu9voOaOJx9UTSaN8oL0Vlc14iy/
	M6uOCw1kC5ImZ9Xs0YPvWJfvbT2LhhIOTJdpFS0nNgfLYSgcrTkkSCwKwt8P/yhf
	DriJoDst9Y8+MEDptqTjYRLmIqjNbw346SurnEDbg0gll2asdOASjux8urFyBwlX
	xUFp19SFn447NHB9vSDrp75NNz5v+A3fq3Gwg7xqhja6TtZCtG2um6tsjhPSqQd4
	nLYVzzbwcf/HPrb+zZF7fbxv5/bLsufYooyGw5+jaiSlBBXi0D421eJyvQyxLPpi
	hj3Rk/ESJ/t+DlEy8koaAQWIde5QSp1vs86TAh+Iqwmdf1jA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426g6nam35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 09:16:06 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49B9G5Jw013023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 09:16:05 GMT
Received: from [10.218.8.166] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 11 Oct
 2024 02:16:04 -0700
Message-ID: <a1062c42-9e58-465b-ba27-079d3c18af11@quicinc.com>
Date: Fri, 11 Oct 2024 14:45:30 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: AVDTP connection timer is not allowing to wait for send
 setconfiguration error code response
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uMS-HLEVH28RB2zx9V1i3y9wVvcr_I7x
X-Proofpoint-GUID: uMS-HLEVH28RB2zx9V1i3y9wVvcr_I7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410110063

Hi,

We are trying to verify the below PTS usecase, where remote initiates 
the connection and sends AVDTP setconfiguration with unknown sampling
frequency.

PTS case: A2DP/SNK/AVP/BI-03-C

Description:
Verify that the SNK IUT, acting as an AVDTP Acceptor, returns error 
codes when the Lower Tester, acting as an A2DP SRC and an AVDTP INT, 
configures a stream using an invalid configuration 
(INVALID_SAMPLING_FREQUENCY).

(TSPC_A2DP_15b_1 AND (TSPC_A2DP_5_6 OR TSPC_A2DP_5_4 OR TSPC_A2DP_5_1)) 
OR TSPC_ALL



User prompt:
Please prepare the IUT to reject an AVDTP SET CONFIGURATION command with 
error code INVALID_SAMPLING_FREQUENCY,

then press 'OK 'to continue."


Results:

Expectation: DUT needs to reject the setconfiguration with invalid 
sampling frequency error code.

Behavior: When PTS asks for user prompt to prepare and press ok to 
continue. it is failing, because in bluez there is a 1 second timer for 
connection. this timer is getting expired and avdtp signalling(DISCOVER 
procedure) starting again from dut.

diconnect timer source link:
https://github.com/bluez/bluez/blob/5.65/profiles/audio/avdtp.c#L1202

due to this behaviour we were unable to send setconfiguration with 
invalid sampling frequency error code from dut.

Is there any workaround for this to fix?

Bluez version: 5.65
pulseaudio version: 15.0
kernel version: 6.6.38

Note: We are observing avdtp connection failure with iphone due to this 
timer sometimes.


Thanks & Regards,
Raghavender




