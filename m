Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B21AA1D5;
	Sat,  5 Jul 2025 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751712790; cv=none; b=NX8JaqimPzJ4+wuB9sIKyXcfmHJCB4Xis9Qkpt9Hd1MPPTVvrqDOwQOvFTLFYrKdM+VPyQp79J4JEvhv5SAQ9ClKb2iq3SRcbocdyM3+Oye/yO/5RoQhplu6mxy1C97i8uniI4QFfyW3i5Eap1sQe0LzOBWSwf71u1LpLJHq4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751712790; c=relaxed/simple;
	bh=HWqMPf0ct2JxVB3YfJqAjYssB4wcEEoarU810J1bKBk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dangANhVclWlYeWxdmFYbbVDBE4FyXWPpofYeYIA7xMvJIYQHSt521iTdvUBzAQbkM0AYfR0O+CWLelcPHyKsH5KQ/5UMbYy1ozR2qeXmndNsCVRX02XLtYF1CVdEw5NBIA9gfN8sCP7d1hoifr+pe8gKAtdzbNv8mkhr2jpkxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OiiQtgPS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OiiQtgPS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 565AZjEm010296;
	Sat, 5 Jul 2025 10:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PtHhBJNOI6ng26wlUfJkZY
	JjbhjN5WwxVspdt+Us3lw=; b=OiiQtgPSQ59CVIqyd5vhERXJfejbjDwjRose9S
	qg3W+cav7W20e/JrquATC8PkPDQ5feogoSYoIJpJzlBOAmM4u0/uqZGiYFfnKryx
	7wYeeil9aNBO1INDMZbWmLncilWDvSs3CRa7T7qjHVyVwNnOH1an7ZcUTjg2hemz
	1qsRvdkEduWidV5QaIGWBGneG3wFZ7z3A+UI6KYECcxfmWn4uGT7ahaeuVhl93oT
	d90QmiYcsGIFr0E5uqm1d+ki/NGlu1BCOUnDzblZ8JaYMxPqpDm0msRT9nc1gXDL
	lBoDcWZrJtAz7Ra3sbP+wxRqeblNlI2I5x6DD4OuKE7SJt4A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu0vrrde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Jul 2025 10:53:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 565Ar13O032216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 5 Jul 2025 10:53:01 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 5 Jul 2025 03:52:59 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <marcel@holtmann.org>, <luiz.dentz@gmail.com>, <chharry@chromium.org>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH] Bluetooth: btusb: Fix potential NULL dereference on kmalloc failure
Date: Sat, 5 Jul 2025 18:52:46 +0800
Message-ID: <20250705105246.1383084-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qF1UFGmp2zPzASL9GQx81BwgbExevGXt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA1MDA3MCBTYWx0ZWRfXxSySlgLU07kj
 OdewIcaN06SQEoRhPf7sqcuJDcVMnyNpUQV5bfaXGS3OmnTOvq1pE4MbLwOUneB5uQib1SvC6gL
 yd44066rvON0+azjmlsChuO+zO1AsnI8bYY4L/2AEMYnfhJ2s5DMBX33ZvsHViu+Tf3Uzq3rFk8
 ffUPnXQ7aYzu/aOx27dOlCLv4nZ7ktw6rEUfilCSCpPzb2NllMpDB1c15jPYO/S0OQh/SUW6r7c
 PcW8GQkoh+ONyWZ9+BjEhj6xEDye+lrnF3yUgKbENwYV6PuvMkzBvi8WLf7wtPuY3ogb+5iaoSL
 yNxed15ftDugs7DDTG3C45clTGbcwX7wIQbs9kl8Hy2eLW3NW524MzDjWXCFpgxj/4kdCwkqlt7
 grexyPXSc77EObfqBE1365Y4sy4JywEx8NjoBe63kHOo/WgSJWkIGuJHjQKcYD3S66aMMIne
X-Authority-Analysis: v=2.4 cv=Rd2QC0tv c=1 sm=1 tr=0 ts=6869040d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=kCdYwly7LSaV7O0ZGUsA:9
 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qF1UFGmp2zPzASL9GQx81BwgbExevGXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507050070

Avoid potential NULL pointer dereference by checking the return value of
kmalloc and handling allocation failure properly.

Fixes: 7d70989fcea7 ("Bluetooth: btusb: Add HCI Drv commands for configuring altsetting")
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f8f256ff79a3..642b3238ea39 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3799,6 +3799,8 @@ static int btusb_hci_drv_supported_altsettings(struct hci_dev *hdev, void *data,
 
 	/* There are at most 7 alt (0 - 6) */
 	rp = kmalloc(sizeof(*rp) + 7, GFP_KERNEL);
+	if (!rp)
+		return -ENOMEM;
 
 	rp->num = 0;
 	if (!drvdata->isoc)
-- 
2.43.0

