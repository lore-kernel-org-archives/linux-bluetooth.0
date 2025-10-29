Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DAD351FC7
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759696; cv=none; b=OSe8t/1Qxszyqw14dYKcN7FmHQc4oxuT7tztligx/ZQ6b1BpW9J4XgZi+O8BzY65iwTnITRhU9Ye+2NG4/saQNCV5km2SQXUK+f7Ezp2iZOBXD6L2c+DVPIK9eCp/4nB+eVfVdIvEcn4z0JYioYNulOoI1t/4uKw3LKylgGW+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759696; c=relaxed/simple;
	bh=Na4vPgKmid4FMLS307q9qmzwvFHM7Swm9obvkkVxCdo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NCjfdzpwbOTEQXNYuv7/h0lVT8h77m6xoAphc+GMHn0MuVUwdybpDil1nubl2rCs21qv7CgqHgFxp4mH2lQC6Wu/xbhCNIp6mMyUPUBmH7bXcu2efAAXpie22eJmiv2IK4Zv/K+g2HtixRJyPzc532M8QQlEcg1IaXX/9uzT024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Agh5ssrd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Agh5ssrd"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TFrNSI4135361
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 17:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Na4vPgKmid4FMLS307q9qm
	zwvFHM7Swm9obvkkVxCdo=; b=Agh5ssrdgUaSZGHBpvQyJzP09oBsWtvHkz7e5f
	vMzgry4M+TkLO6MNit2xombpIQPc9IP02jYEuVQuvjp8QllG2RKZqwJ3tePYzmg7
	LAt+QxW1AdFKempS4tS6bYviGRJO0jRXso3WyDN+wTNwaAuFgWFj7N6L1T6+YTwW
	S97KMoyZXOtxZFpm78QJj5T3LQqqylcJWtEi6hJGXexqvvkYvB63fdzMDLB1KWom
	JCW4yBuHf45GTOjxcBvdkI71Wgne1PMwILG9+EypviH+CG/mx0+PFph4Mnyh0H+j
	uwYZMvz5VRr+XUoVyiyoHM/jIWsOu1IOhbGWzQzo/2/w6Zcw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ff9sqdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 17:41:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59THfVMB031871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 17:41:31 GMT
Received: from nasanex01c.na.qualcomm.com (10.45.79.139) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 29 Oct 2025 10:41:31 -0700
Received: from nasanex01c.na.qualcomm.com ([fe80::4cf6:99fc:3209:f4b8]) by
 nasanex01c.na.qualcomm.com ([fe80::4cf6:99fc:3209:f4b8%13]) with mapi id
 15.02.1748.024; Wed, 29 Oct 2025 10:41:31 -0700
From: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>,
        "Mohammed Sameer Mulla
 (QUIC)" <quic_mohamull@quicinc.com>,
        "Anubhav Gupta (QUIC)"
	<quic_anubhavg@quicinc.com>
Subject: Enable SDP logging
Thread-Topic: Enable SDP logging
Thread-Index: AdxInCI/V1vnRKrcQoCAV7sbsZ7NEw==
Date: Wed, 29 Oct 2025 17:41:31 +0000
Message-ID: <fe4bfce13d684757bb506301a08c5bf5@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qoF8msPZJCw9HnbW1lRcbxOizBd-9kVE
X-Proofpoint-GUID: qoF8msPZJCw9HnbW1lRcbxOizBd-9kVE
X-Authority-Analysis: v=2.4 cv=Cf4FJbrl c=1 sm=1 tr=0 ts=690251cc cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=xqWC_Br6kY4A:10 a=CXhX_D7DexwA:10 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=SPzTFMxfSesD9TQGdw8A:9 a=CjuIK1q_8ugA:10
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX95McJTumLulV
 Ygru5cMTb6hDP0r8a+rTU4yEFUeNZGEUNgTeCUVTaEivnOOVF0teFxsnPnlzKfVfuVSNzfz8Rrx
 4R2k5PMRjqZwfZmJBhhN8NoG4H9ePUuJ8b6zNtUhT+8h1BXJXhYlni2WViZxgURjJPaljlg6dz3
 E8xPsn83mLrrvfg9EUHcw2tmT8jjSuebUxGmtrVPB+BY2KnQs7i8bH+toFbWyC0JozX54l6i//4
 HZaZr6b36X2FxvFBDuDtaNCGKwtSahYFet2KvQ5evGy6SUgmXuiQVByrC71WdGTCQIoREJd3lio
 Hy1eKo20To3e0IW1qlsP+8tjFMipNQKYpaiPTHP7CcH3bTqxcplrqZlXGtBzDzkoyNuIs+kIbjW
 QwAFWxBorljNlrlzmJzVecGDua0Ufg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290140

Hi,
I need help to enable SDP logging when '-d' option is set.=20
In most sdp related code files, there are 'SDPDBG()' logs added but we cann=
ot see these prints while collecting logs.
Additionally, these logs depending on below macro to be defined -=20

#ifdef SDP_DEBUG
#define SDPDBG(fmt, arg...) syslog(LOG_DEBUG, "%s: " fmt "\n", __func__ , #=
# arg)
#else
#define SDPDBG(fmt...)
#endif

But this macro 'SDP_DEBUG' is not defined in any file.=20
Is there any way to enable logs without need to change or update code local=
ly.

Thanks,
Amisha
