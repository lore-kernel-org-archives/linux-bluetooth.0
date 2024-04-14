Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDCF36B1C
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Apr 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713095843; cv=none; b=AMBo3v1CcuE83ABXVYebPybJP5kuG8i316SG8ieVcDSgNJBkmQ5CyUjlqvpTtrUalifdQqIDsOKwu+8zbiCUia8sZO5VnoP4pMoSPVqDdEQWSsVX/cSS9k6Z+pVu00zGt/3JVtQuM7JW6QT9Umbf58o9jAVe70/IuwatYAwsWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713095843; c=relaxed/simple;
	bh=1IASOUPj3xfbecbguSmttzi/NSKDkvnGf5FlqSeHE+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CkuWmjeeZfQri/RXMwsA+hSk05oXrC9AHvNFMngcIKA/ftDu6i6H+p+7nfaXqucexxXDV2L1TNNxtSvUYv558DAnpVc+982BY6WekHUEj97bmMj+lKJGMgEch9OGud21GetesbLBwfJtpm7n5H8tjRZwo9koBdWdOjgREKprpZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jqbBjE9R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jqbBjE9R"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43EBhYHN016062;
	Sun, 14 Apr 2024 11:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=3n41Tt9gsgzfgtUHUk19LTgafprXe+uW2NbJm1i39zE=; b=jq
	bBjE9R509t4SiTdjol9m+Ip0HLU9KEojyumOIIfK5EsZ0rmyzU2eU3BPYjU/GIAA
	E4tum3PhUgT2hUShn32lDrQDv1xAXneALyuGQm4Vr9Rqf2CyIcBX55RcONYusFvU
	Fq8Yqi3OqeQuegdTNTv1QWbVnyAtUKAtFS2oyBmkogtUgQYFYy8wFkVaOmUfcd4u
	Y7RUrbZjRRXgPFmtCJQ4lsfiyd6KIaXgODu/oZ/tDYM1Wocif/FEC1EKPQ9iEUhv
	sOHbZHuqpS9gEW6rrbCrdRmlaLRM7ifFUaRL/Dd6Fbx+n1saYfctAiPTF3MvwN5L
	MyFAyv+NVquo2BVTdDJg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xffrka1dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 11:57:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43EBvBFT002080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 11:57:11 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 14 Apr 2024 04:57:10 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <wt@penguintechs.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v1 0/2] QCA6390 enable failure debugging changes
Date: Sun, 14 Apr 2024 19:57:03 +0800
Message-ID: <1713095825-4954-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6JLjdwInZgUW9cNhkK_maIOUQPiWNcMT
X-Proofpoint-GUID: 6JLjdwInZgUW9cNhkK_maIOUQPiWNcMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=891 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404140086

This patch series are to debug below QCA6390 issue:
QCA6390 bluetooth doesn't work after warm boot or disable/reenable
https://lore.kernel.org/linux-bluetooth/31bb6e18-ecee-49b3-87d7-50ab53e07447@penguintechs.org

Zijun Hu (2):
  Bluetooth: qca: Dump more config info for debugging
  Bluetooth: qca: Fix QCA6390 enable failure after reboot or disable

 drivers/bluetooth/hci_qca.c | 78 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 6 deletions(-)

-- 
2.7.4

