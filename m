Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68882DFA29
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111460; cv=none; b=RwMuRdOEF1CCmfurdWrXBufYbMjD++UdFXhwxdbdTq8zTNrS5qpPo2m7zOTZqkl5mIRlMHH3KijPPH0DbCrx5rbFlunVc6egfg5Us1p/RepShNavV36o4DrQvFy1YUAR+A/4XxNev/XK750CRCsCKtIiTu9P2OyIFltGiLfBIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111460; c=relaxed/simple;
	bh=CBAhNkNHwtfhpo4wPw2bS+RDJNDV67jwBmC/pAqwmVE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UV13HSRdV1VYNHcIV4nX8xEuuSdb5lJTNAMyI7e+T4TXL7azbkKeahTMEJYS0RDYazLL8g2+1bpFBOX+bedaq7RjO9HEoUDRrVbD0IISnDbxIrIXdqDS+QPgVx2xhJJEcdNDeRtEA/I7GYxyeL0lWm/tBCqSosNJ3i/hNGGOU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nYEalOEO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nYEalOEO"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LEf5bC012733
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Xq+0/mz7ZwRwvCtprx0Sa7
	Fnzqmrk0YHOsShnzB/Erc=; b=nYEalOEO+K5ocmXbNUTxmb9iY2OGwaCyT9ZT9i
	kkA5O6ry6ZkE8Vpk4w50fTODUcDaQPtgWrhbevbCU80XetqO70zgFUVeEn8LR2Cq
	hMrxRubpX4GXLCG8NkUgunfgxvTreJxerc1Vf9IkqRKhikDXduUKjAzk6boJ7DUW
	HWo3fGhl2id8ODBFrX7QCo9WuXp1AJhURyamTCM2xRJVvcVopcEdRTl1neFYvx8f
	BCRAGsPDtBkQVZe3lH5hjlvdTwO9HtOYOhduQgeIgRK5+jKFNln8FG2dSMKoJ+My
	pjg2ZNcrHZTdowq+p2q9ZI6D/d510slMSkx0S8UaJ7YcsBgw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6g6fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56LFOC7l010007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:12 GMT
Received: from FGIANCAN1.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Jul 2025 08:24:11 -0700
From: Francesco Giancane <quic_fgiancan@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Francesco Giancane <quic_fgiancan@quicinc.com>
Subject: [PATCH BlueZ 0/3] Keep component `bluetoothd` isolated
Date: Mon, 21 Jul 2025 16:22:16 +0100
Message-ID: <20250721152219.517-1-quic_fgiancan@quicinc.com>
X-Mailer: git-send-email 2.49.0.windows.1
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
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=687e5ba1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=12QLjomOgqP_XMqTEIEA:9
X-Proofpoint-ORIG-GUID: C38Guc4D3mUwxe-3PfkbQB3kr1n3czZS
X-Proofpoint-GUID: C38Guc4D3mUwxe-3PfkbQB3kr1n3czZS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzNyBTYWx0ZWRfXyffjw3s3euck
 h/OPfWmTW/2meUoWQAbjjeocp8v7O0JuabKCIpYVJQ0bGVRSJL/YaScqm6qafzfQgW10spHxfu1
 tcuiIAGNlmWsy7AyA9lAoDgHZKkmzO6dpS3vbY5BSd3xPLNmgempGfKDNL7mme34JBhq6+0A66J
 cxffiZtB6KD9ntlSxZ2agNhJ2kxFv2c3NmaYa6++Bu+p28SWABF3hqyuOvin7Qe8btJhq/2THx/
 eYkmlqFS3F/oiuLSG7/Jdf3iVzJCdV6OgEt7dBmwcTjpKbtclNdqc7v2wLXOBR7pUDCr/T+k9NW
 7yec9dc/lBbhhwFjfgbzydYEUFcb1gtZl1WbY6v/TryJJo5Skq0rLYYHotYEX1Efunae4dURO7D
 5b6Cn1C7eFtWz4p/zzrAMCJA+NWovU8iLbMfa7Y3OogAHEjK2s6aIrb3saPv82fBcZEla5gS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=967 impostorscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210137

Hi,

I am posting this patch series to better decouple `bluetoothd` daemon
and `libbluetooth`, as mentioned in the subject.

I am introducing this change to make new BlueZ more granular.
This will allow more control on which components are actually selected
to build.

Major use case for this change is fixing circular dependencies when
bootstrapping new builds where the whole build root is to be recreated
(e.g. Yocto Project).
In these scenarios, to have Bluetooth support enabled in Python,
`libbluetooth` is required at build time to be present but the direct
chain of dependencies would require a Python installation available,
thus introducing circular dependency.
Separating the library and header files from the rest allows build
systems to break the dependency loop.

`--enable-bluetoothd` flag is added to the `configure` script and
it is keeping the same behavior as other flags.

Francesco Giancane (3):
  configure.ac: introduce `--enable-bluetoothd` flag
  Makefile.am: build `bluetoothd` if enabled
  README: document `--enable-bluetoothd` flag

 Makefile.am  |  8 ++++++++
 README       | 14 ++++++++++++++
 configure.ac |  4 ++++
 3 files changed, 26 insertions(+)

-- 
2.49.0.windows.1

