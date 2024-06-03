Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB84B84E1C;
	Mon,  3 Jun 2024 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419271; cv=none; b=AEdBDu8RKrZySHU11rUOl4SbM1/V4tvh3fIAJnpZvsdoBNzoKV4yp0/2G7ZJBqveQuQYXRm8K/FImdCSKAQW2u/RNuaSDyaa9flDbXg2LpZoO5EWb7fBnj120RsLhbs/fgJjtZywLBSVmApY0HTxSVqIOLR/irg1446xnvzOQ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419271; c=relaxed/simple;
	bh=Klr9xhZV+I6k2FQesG4sY2yBk1nNGSSVrtAem4YIPz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKPK0QnHN2HsQKwWOletl/3BVcIwPKW7sG1+T4gc8LgS0+5gPz7DTFDbFM535D+TDZVqWQQl4OgxdLLYpw+QpDwT1J6uH9GSvJUZeM6u4rNC2loMPeY8D+5VjxeigdhUFeU5MGmBS/OT3T7pTOiEWe3v2zQsz04ExBvUQ28u29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jXoErLu0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jXoErLu0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4530GX70020269;
	Mon, 3 Jun 2024 12:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WmU+f25Abmug8NQIuVhV19e7
	A10T3q8jZsyCdyPsYG4=; b=jXoErLu0CM8hUoC34eCAe/tXIvyV9atui4Bv3qPN
	PczbIxgh9mhYQqAjRV/pQSgStXjRUKFdX1IsExMMnoCJ4JRnAfMKTIuo4ZxQ3g3A
	Km/wZOsX3mCU4FdCSfR0fpxGdJLbgpzxeOH2Y9o1kVNqcr8ZFtC1SMfwTm3WZbjh
	kp9FWChNioWTo+l5OLgpqWqfjJ1QYRwMG4UlA2QtYSaIEgew/ndLaXfmUetvfIno
	Xs6pGUPZ9fPYIGJ8MjDhuynmMB1uARu/en+HECZiCXIPhS0pjFC5zM0/ZWL2HQmK
	4FsOGY4fAGnBMXD0V/bHh6oXoku0vc/QAUmb/H/JZcr6Lw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw42uvt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 12:54:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453CsPoF016732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 12:54:25 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Jun 2024 05:54:23 -0700
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] Bluetooth: hci_qca: Increase settling time for baudrate change VSC
Date: Mon, 3 Jun 2024 18:23:57 +0530
Message-ID: <20240603125357.3035-2-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240603125357.3035-1-quic_janathot@quicinc.com>
References: <20240603125357.3035-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _9JXeD0hPCGutFbA8X4JaK6M-Ppvrk-H
X-Proofpoint-ORIG-GUID: _9JXeD0hPCGutFbA8X4JaK6M-Ppvrk-H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=928 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030107

This change is done to align the settling time and
synchronization for baudrate VSC for WCN6750.

In logging disabled builds and few devices
baudrate change and flow control is taking time
so increasing the wait time to controller and uart
to handle baudrate change request properly.

Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 0c9c9ee56592..667687835306 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1356,12 +1356,15 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
-	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		usleep_range(1000, 10000);
 		break;
 
+	case QCA_WCN6750:
+		msleep(30);
+		break;
+
 	default:
 		msleep(300);
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

