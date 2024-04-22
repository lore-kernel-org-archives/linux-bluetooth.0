Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A82233A
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771513; cv=none; b=UruPCI+Ho/4S6fqseSea08Ykwza9YVPIk++A93Wi/jf+e3BkLLtspXF6fUyFzdaFPtjy/1WS6zZxvXonTD7+ggKAgZO+v5AUuNSGNsrq2KY9BkgTBl8F96K+7ftz2NZ5lNKzZFboixj5m4swbuJyyD7pWdKJeLBLxSZDhWpBblc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771513; c=relaxed/simple;
	bh=gb9hQcL6bYHU0rWieFXOhuwb6AThMlQLtenW2LMvxZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVwXeZZx5DqpwWCcX8Dk0LjN2BDygeUggsZk3D3yoRWDMMtuz+ZPXPFPQijxhUpYhHFgi2y3UNZRFlsCmIj7ZxvbQ2LRNKGaz8GGk0sZf9nvN5zyJy3A0DAzaylJVnxTE8CeTaMsmcW2lVB1NwqvCW4q3VFPBQGeVPmkmY1lOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OuzmnDAD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OuzmnDAD"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M4hLDX013143;
	Mon, 22 Apr 2024 07:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=TwkxB1uMs/xEoT/J51Q5
	/3pUv19KFpVncsKIro/ltyA=; b=OuzmnDADkbBVagvX5udPpV1FLXKZc5TfUKMx
	N3FCPqtLrwz3zIygQlCzKjY1+XDGHAkTw8uYlROf8cvMlPjXzDmXqGScKQbb/XJE
	kkDAgJKlUp2282/7EHlNRj8lgOe1t/ZPWFbL0kbKOJTh1YLDPn+Hx2wWp1A4bb1p
	xuzGPyZnqBZtIGUIZxlp9OdPG+qGDsM6aw2OU5NKts6qYaz4bxkRtUCU9BZSMLPR
	SOystuBjwfT/Nmf5YINcIDeM2YnWkvV8XqTNAG0AkjF3ZzNM8dEYG/VwFWnqtS+E
	zBWzMMipn9gv5gtaIU34Xa8q+ic8znexEG9r8ak1tw3Gmlgt5g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm4qdbp31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 07:38:25 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M7cOOv031819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 07:38:24 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 00:38:21 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>, <regressions@lists.linux.dev>
Subject: [PATCH v5 0/2] Fix two regression issues for QCA controllers
Date: Mon, 22 Apr 2024 15:38:15 +0800
Message-ID: <1713771497-5733-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6j4FMfI_azKmRUq7qUXAstDpT8zNLq2_
X-Proofpoint-ORIG-GUID: 6j4FMfI_azKmRUq7qUXAstDpT8zNLq2_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_04,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 mlxlogscore=914 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220034

This patch series are to fix below 2 regression issues for QCA_QCA6390
1) BT can't be enabled any more after below steps:
cold boot -> enable BT -> disable BT -> BT enable failure
if property enable-gpios is not configured within DT|ACPI for QCA_QCA6390.

2) BT can't be enabled after below steps:
cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
if property enable-gpios is not configured within DT|ACPI for QCA_QCA6390.

Changes:
V4 -> V5: Correct commit message
V3 -> V4: Correct code stype and commit message
V1 -> V3: Remove debugging logs

Zijun Hu (2):
  Bluetooth: qca: Fix BT enable failure for QCA_QCA6390
  Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable
    then warm reboot

 drivers/bluetooth/hci_qca.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.7.4

