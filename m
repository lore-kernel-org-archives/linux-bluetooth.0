Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0B171CC
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 04:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932830; cv=none; b=D32ZURj8U6whCIAaysCOF4q9dZYVn+vqndE1MtxSWtBff2zHJLyeZYA7x78gmPi8qISFaATpIcfRSnug1lqLJtwkp6P+D66qgPxsyybs/0I97iERHTdSYbI+uqv0w0PnF5wEtLxAX340McPIyMTp9tweYfgEsLDzF6u+auztWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932830; c=relaxed/simple;
	bh=m+4t+n04fNPB2r3xJc/ax4cimPbuAuc7je+hD0cshgk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nfdOR5I1D69HphvkPK+D7zVd7gkv+CM8XI72xDBEy6pae5NCbZCQeN19TZbwLYUGt0NQKHsJGWpJzBramcCztrzAFMEtXqOVTk4xt0GxNldIdjG7BUPTHBDQJPhGp3nwVa9lTczj8jsg2SlTv0mQ6PBPyhelfrYxnZVJ/3ROg4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QdVu+X0h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QdVu+X0h"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0jCoR006734;
	Wed, 24 Apr 2024 04:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=EG1vevawofFBe9G4rQrx4xXfr5FP3aV82TQJbNRjHfQ=; b=Qd
	Vu+X0hxVodaa5ygS8Q7pQ2lGFBgz0mxG02R9Acm9GLI5zOlEug2Z2mQagSchYqhY
	/AZwxkdlpoi+HCKKqq8HoXB0Hj/gG0hkW0D3R4x/HYW8apnoLhdTjw0nZSM0Onzd
	dUjjLc4SZpubxgwP4MZEByeFtBXhd2odVz8PmA/a8cgdRr+FrHB5oHyal6VNP2rf
	Cp5VNCcxjsdLtygUMa6XUAUFlLQ6kuA6tle2FpRcZW3MvvOZ6Fk4PAMZWEP1etzS
	FCVYO374aHw9N81dM9zGO8UpRmUaSQE5C12xSQ0mwRkeRXfo1sKuB6LMHIM4MgJa
	TMzO76TRTqIXBZrRIX6w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpcxejdsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 04:26:59 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O4QwaR015646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 04:26:58 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 21:26:51 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>, <regressions@lists.linux.dev>,
        <kernel@quicinc.com>, <gregkh@linuxfoundation.org>,
        <stable@vge.kernel.org>
Subject: [PATCH v7 0/2] Fix two BT regression issues for QCA6390
Date: Wed, 24 Apr 2024 12:26:45 +0800
Message-ID: <1713932807-19619-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: wwBkY_ukJ4fw3Cm4mqGNqx1NqSBM_28V
X-Proofpoint-ORIG-GUID: wwBkY_ukJ4fw3Cm4mqGNqx1NqSBM_28V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_01,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=973 phishscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240018

This patch series are to fix below 2 BT regression issues for QCA6390
1) BT can't be enabled any more after below steps:
cold boot -> enable BT -> disable BT -> BT enable failure
if property enable-gpios is not configured within DT|ACPI for QCA6390.

2) BT can't be enabled after below steps:
cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
if property enable-gpios is not configured within DT|ACPI for QCA6390.

Fix solution has been verified by the reported device Dell XPS 13 9310
laptop over below bluetooth-next tree commit as the last bugzilla comment
commit 6abf9dd26bb1 ("Bluetooth: qca: Fix triggering coredump
implementation").

These two issues were initially reported at below link:
https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
then reported to bugzilla as shown by below link:
https://bugzilla.kernel.org/show_bug.cgi?id=218726
the previous discussion link is listed below
https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/

Zijun Hu (2):
  Bluetooth: qca: Fix BT enable failure for QCA6390
  Bluetooth: qca: Fix BT enable failure for QCA6390 after disable then
    warm reboot

 drivers/bluetooth/hci_qca.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.7.4

