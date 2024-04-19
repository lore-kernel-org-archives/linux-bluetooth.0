Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633C1BF3D
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564229; cv=none; b=na4qhMVTXmWcStRU9lRwQ09tU1pdTFg7vSchipfmHLQ1xW8ClvqiNtXk/me2GoLzhnWxry0urc0E7G9oIcwDmRrvMB5qTKyntBYCdoHXgepdRDLRCargvzGmFZyuzhGHHKjnfBMQx6TKYf/pP012rtEfUT+D/tS6cIc/jDpOfWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564229; c=relaxed/simple;
	bh=XkaPYUSAwUzs8Cn7BNRVTUDUszeoQJd6DQ44RwnydPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcyQsOW/aVJVv34J/sxbkuoHzdZfOe67aLHGfPgogDZQh743Avk3YYbINN1KqZL2mRWjlAaFdsPMCTr0BwzxBCxUJw5E5Zs0VwKp6CQaw0OjjHvU5FldZvu7eadqAdRY9ZrmLBBU+1LXHdCE+MGzOvZJUZwryJMVWUFY3g+/3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pmQfGmu1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pmQfGmu1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JKtPu3021858;
	Fri, 19 Apr 2024 22:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=sl26u6X2ve6vDi4Vy6tp
	uoPuQzsh68Ganvtd3enohjo=; b=pmQfGmu1ZbVC42v8fqIg9dhREICwc/Av7rSX
	qvZ52sW7K/seRHdqA3mByOypwEfWSCDB24D3HwnTNMMt5bwvzuKzQC1lJLDoPyH2
	h0sG0goJdMWYd5sDFTA0g6BYoF5pdl3z38IBJXuSS673pAx6OjLBY+YMxFofByzs
	WPWBUyDScPu5gcqnI44Fl+BVJbDEEJTm5dCXhnVk2fcmg/ESwpHh2wSdlNDxbyOu
	PjYhcr6cEng4OjGAFwpgEMDtzjOBvyF8O63WZ6q+ukmw9hAI2iIXNZh/jD1n6h/M
	EhFJWN6fp2uU0inoJ3IoQE13ZidNn37Tb11P/JzjV2eDNi846A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xknrn9f3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 22:03:39 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JM3cUL019944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 22:03:38 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 19 Apr 2024 15:03:36 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>
Subject: [PATCH v3 0/2] Fix two regression issues for QCA controllers
Date: Sat, 20 Apr 2024 06:03:30 +0800
Message-ID: <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: SiuMfBb3yJzwojsZpY3SzVQZxoCbTBiU
X-Proofpoint-ORIG-GUID: SiuMfBb3yJzwojsZpY3SzVQZxoCbTBiU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_15,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=916 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190171

This patch series are to fix below 2 regression issues for QCA controllers
1) BT can't be enabled once BT was ever enabled for QCA_QCA6390
2) BT can't be enabled after disable then warm reboot for QCA_QCA6390

the links for these issues are shown below:
https://bugzilla.kernel.org/show_bug.cgi?id=218726
https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f

Zijun Hu (2):
  Bluetooth: qca: Fix BT enable failure for QCA_QCA6390
  Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable
    then warm reboot

 drivers/bluetooth/hci_qca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4

