Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A02187337;
	Mon, 17 Jun 2024 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607703; cv=none; b=WfBpzdftJ6neRMZlBZPfAkTHJfnWNyrzkZ/jKP4hbXQ6LI5V9KzTiAhWqb6zihSVwQEoIdeHWF5fHKkCCxkJ3JOfcSheOE3htH3gqVtyFeI5YBXaqE/lcuxGBZxhNLYYDcBRAsVs2NeSCGmoXMx6oID+jOFkRqEa9ZM10D8Y1Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607703; c=relaxed/simple;
	bh=Klr9xhZV+I6k2FQesG4sY2yBk1nNGSSVrtAem4YIPz4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fsT22vI5EjWxKSJviUnjWu5ov/RZJCa+Mrj1IbYVnR8SuXrMTfizC1LIoJ4sR+ypYL9FRh3D8Som58ErEqEqpKoUYBBoBW64btTaw54oK3E1VLrplPo1hMPLNMd3C5Hgma2+dovsIOJ1Bz3CJKqI5mg3nK/GsM1nqlYBvHPa10I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jiknG06i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jiknG06i"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45GN0rFc003898;
	Mon, 17 Jun 2024 07:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=WmU+f25Abmug8NQIuVhV19e7A10T3q8jZsyCdyPsYG4=; b=ji
	knG06iJcJm1DWQqEFvc2zoX0rV6fSaCBUKG8shE62QdYpqcVRzDQFHDyFQNb5NDa
	pH7h8PDtLuT/v2ikp1RD4fIgxRFrlztoWqc/v8BowmdB5dniqGcbAaGu7BJVTyku
	xa9Jau9Vl29S0srp5cCYUxQJZx4cMceG0zpuXgpNHL31IURrCOJ8MPLrsl0m3eJ3
	yGoSeCq7uxMGpdHrnUCSaoaof+P2B2m2XrR62v7u+zCHqSPPjrXr14zwXHWha1US
	Lhd33iQPhQk3i006nIGdosdsiOkWuJtFZfJ8tkMEaG4Bzp47vkc/AjOgsviYsEZF
	pM2OZDu6Uxg8Ykx34Qww==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys1y6u0bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 07:01:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45H71af7028423
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 07:01:36 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Jun 2024 00:01:33 -0700
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] Bluetooth: hci_qca: Increase settling time for baudrate change VSC
Date: Mon, 17 Jun 2024 12:30:39 +0530
Message-ID: <20240617070039.30824-1-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NcExvQ2p5c1vLvDKhQn5usjxX87fbp-h
X-Proofpoint-ORIG-GUID: NcExvQ2p5c1vLvDKhQn5usjxX87fbp-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_05,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 mlxlogscore=887 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170050

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

