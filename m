Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1EE7BAE5;
	Mon,  3 Jun 2024 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419269; cv=none; b=s/Qiq6zKdSACDoVnl50t4qSKKOV9BNw8aI5tyeFC5quoGjKcBdcunjST0sU8FUB70W6DI37RYvQB/ct6PlkChBTlThUpU/3+WiAjarjn7ACocMXC7VwY1YtpiMgo0YbxeXfN73cD2Z6wKGNdrmFzmQ7A4GMJbQqUVvrjAbKeWM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419269; c=relaxed/simple;
	bh=/yZub1bVDRZFGmIeir+Bk0hP3RognHpEYbN5NZnu0rI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qJeZ67rj4r3zAvfGPQX+zOKYcOZzBVqp+CbljNO6ZGAK/fH+Y2IogYyeKgxMVMxZdW+NEd/Q8H6IkuSddQivnQKNRA94eN094oXDMfagX3SZgPsePau0Yc0Oh77sjmLgwBO3ysoVrZkgaBxHuwJ0oDQhYvHo/nJK4+Km3RKR1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VDj2r9zT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VDj2r9zT"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4538kw8D027095;
	Mon, 3 Jun 2024 12:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=XFrkMwa8QhZ9jgdNkVDzESUcvGxzFBA04uy+9WMA22k=; b=VD
	j2r9zT6GAQ1hHr1EkMvoVQYCE09+I83kPIzcDQCTGkNHzlHYaBra4nYMCzzncvxg
	XCVwVT9+5n1tHw0STRVxfC7Ht3Wf6XJQcv4bqep6suXODbIQpDqtkrHigfuxGfqG
	noIeump5gHxmsMWOFQf8UHSMNvgq/u7yY08pZg1WhH8OY0te61JDDzHo2ZCdU4OP
	VO0zpWJPhGtYZJ+gkutjAWuI1dmJGilhaG7rjWA0v6fGF1L1k1Mb9XtdVDKL9Fme
	vpgs5dq6ntfd166T5dWnT/4yCSIv6VPuqGEsuWuEyP8e3Fh2K8oGrC8FcOdDTDWn
	6fB6WYpcRfpSKQh+TeTg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4bbwxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 12:54:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453CsMNc003824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 12:54:22 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Jun 2024 05:54:20 -0700
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PENDING: Bluetooth: Increase settling time for baudrate change VSC
Date: Mon, 3 Jun 2024 18:23:56 +0530
Message-ID: <20240603125357.3035-1-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
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
X-Proofpoint-ORIG-GUID: QgyskmBdHtP3jHdnJJRvMgEsMdxi0lgL
X-Proofpoint-GUID: QgyskmBdHtP3jHdnJJRvMgEsMdxi0lgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406030107

From: Harish Bandi <quic_hbandi@quicinc.com>

This change is done to align the settling time and
synchronization for baudrate VSC for WCN6750.

In logging disabled builds and few devices
baudrate change and flow control is taking time
so increasing the wait time to controller and uart
to handle baudrate change request properly.

Change-Id: If0631cb886e53817f963f075e626c89a791b7be4
Signed-off-by: Harish Bandi <quic_hbandi@quicinc.com>
---

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index eba9165..a59b35e 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -600,7 +600,6 @@
 		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
 
 	if (soc_type == QCA_WCN6750) {
-		msleep(100);
 		qca_send_patch_config_cmd(hdev);
 	}
 
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index d8abd27..0b41214 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1356,11 +1356,13 @@
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
 
 	default:
 		msleep(300);
@@ -1904,7 +1906,6 @@
 		qca_set_speed(hu, QCA_INIT_SPEED);
 	}
 
-	usleep_range(1000, 20000);
 	/* Setup user speed if needed */
 	speed = qca_get_speed(hu, QCA_OPER_SPEED);
 	if (speed) {
