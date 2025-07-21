Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2EC2C15A8
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111463; cv=none; b=rnRUw/41Fd8TK3Ajwh4RubVIDP8Ju88hwvX1azuVp93rX4BDVuFCajtEMYzzjQFx38DYzjV9dobgzm237zEmcYQCTbCeL5KkU5/HptOj0XZd8e9f1q+TO/NI96INmUI85qSXtNWZC0PawbHuWwKwjRJcNcjsTWUtGV/UieU3r4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111463; c=relaxed/simple;
	bh=tvhG6Yyjmj+KvTBxPnXfvslJ7pDk0MLkvB5N9depl6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZ5cZ+5TRkpfu0hSQAn1y5A7GBx9M7Ip23R7SuBZo641OP3vmZ8zzI2gU15fp2KxwQN8A8UNRkVin26a56R8ExoERiKmXYpdjVhDNk/Baq6WkdexKsy6+Mb8b+3hckX0eif+9fWuyD6JZesvQ87eltEh5FYHMH2vJcmQNzsdPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A7lHvn9/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A7lHvn9/"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LAMin4001048
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aPBMWwaT1bvKSh3DeadVk6ANlxrqSVj8H+/zeLQQEDA=; b=A7lHvn9/mO1COkUm
	CTo71pAWgSvt+UW+a2Fcn1JarSuKd+c4TGWwZcN3oBej576vRiWwko0aq/t/1vUJ
	tJtrLxIr4EDe8z3ehA3auIKJ6/owrr42+N/tQqTw69xrUhOwVMg2grhdJKxvNCBO
	X8unvOdUkdRRtiNHiupyVyYdwMJahjv0LWbQzW2vugYFnMLDAeW38BuGiyD9hK0U
	1ko4GULRzgygEflg9vQUiI9PKkCYH2Ua/hLoWELhSXzQy4CbmVgDwccXMQA0G9zh
	UL9uiZgPQkHklWIVNFiijiRBT+pX/L2jsQDJ+ttAZnYUTUPXpbaGzb/Kl0GLE0In
	87CHRw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044ddtgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56LFOFD5030384
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:15 GMT
Received: from FGIANCAN1.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Jul 2025 08:24:14 -0700
From: Francesco Giancane <quic_fgiancan@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Francesco Giancane <quic_fgiancan@quicinc.com>
Subject: [PATCH BlueZ 3/3] README: document `--enable-bluetoothd` flag
Date: Mon, 21 Jul 2025 16:22:19 +0100
Message-ID: <20250721152219.517-4-quic_fgiancan@quicinc.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250721152219.517-1-quic_fgiancan@quicinc.com>
References: <20250721152219.517-1-quic_fgiancan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687e5ba4 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=89HUT-0ORYKBgiq-nqMA:9
 a=0lgtpPvCYYIA:10
X-Proofpoint-GUID: hoEfuE373Y8OXIk0TSMj7CnW3oIMENxb
X-Proofpoint-ORIG-GUID: hoEfuE373Y8OXIk0TSMj7CnW3oIMENxb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzNyBTYWx0ZWRfX89HK3oZzKno+
 Hn0VcZbfouKpTHyydm/87RTAvpq7CjvRVckK0gwRCvvjcBia3UdCBdpTKp8WYQwrA/6fzBH5+TH
 xjbjd4yZuovNK/Q/wSNzW9/GuZO258q+gpoi2CBviGVnTSuPzmeEIoPIPHjucdepRz8QIL2WcTU
 fEpbReN0Y+FHJTZabgTlTauMo49/O6oZ+oP9evropD8rh9CHcLn7HkEzazV0JGEnYlnxSLJ6e7e
 4IKntsgEplLVt78xvssUFMZCX34Dh5OeqLjvR5oFaXcde7CoeMI7QhVmPYE6OXtRV87b3lK0YHA
 CLyhGyapXICf3c2DccqOwO5fNxNlM+cahMygltjz3aUOccQCOqWnwCh/WeBxesH6vQ1DCU/+naf
 fqqq8CwFQcFliYaIMsa5yvBqx5+lDUHUxjauWFSZx9455WvUhhf7eX3DJrF39CEN0yLxSS3+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=989 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210137

Document how to enable or disable compilation and installation of
the daemon `bluetoothd`.
---
 README | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/README b/README
index c68f12de3..057f60794 100644
--- a/README
+++ b/README
@@ -107,6 +107,20 @@ For a working system, certain configuration options need to be enabled:
 		idea to use a separate bluez-library or libbluetooth
 		package for it.
 
+	--enable-bluetoothd
+
+		Enable installation of `bluetoothd` daemon
+
+		By default the `bluetoothd` daemon is not installed.
+
+		The `bluetoothd` daemon can be excluded from build.
+		This covers cases where standard BlueZ distribution
+		and tools or libraries are to be provided separately.
+
+		When the daemon installation is enabled, it is a good
+		idea to use a separate bluez-bluetoothd or bluetoothd
+		package for it.
+
 	--disable-tools
 
 		Disable support for Bluetooth utilities
-- 
2.49.0.windows.1

