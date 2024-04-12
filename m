Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A91487E4
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939242; cv=none; b=FZyOTTmCO4LY2EO7MfdoFckGOlLMXtDCtCWfRJrd/DLCgFl8KE/tvrHvWfYrOEhjy08Dyk2pJ/CW6xZgy35UWn9vQ9Ps8gkAl24ar7UO6OJYy0r8p3z3YjQrQH/xPuF/MqrMVGsAiGubBTcZiAZVf6KLuaGThJujRpPJSpqeIDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939242; c=relaxed/simple;
	bh=IaWTs3foOVJYe67XxUfQPiOK48fr7V/D20gbTH4kUX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrIouHfpzGl8gAcZj5Gab2fWm6UoDhk6UXPrChbGvovyUazEsiAL5WbZssuERmbI9GpEoNaVZAdx/7It2c7UqAJ7UlGN48zLqh0HaDohihStRyx7cyDQF7QU6K2h1ZB0uT+5VyHBeUGxCF4Q+iIBpZtlMdqeCzaIY2nfYms5/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FeK6m+c5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FeK6m+c5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CFuo6r029422;
	Fri, 12 Apr 2024 16:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=umG5tSiOKH2/Q3/cgGRZ
	nBFa1Zanj7XVsR/VsaA0pd8=; b=FeK6m+c5VDqdLF8qUk+5vCjaEEcCCYswSeuQ
	s4XjCs8J94sxz8hRz43RK3ZqyUYeJTyProjddiPpWZDZZY9LQRFwWhkDJrR9QkcK
	Eb0dra5vI6RzWIp7yWkbbt+MYsDONwx7/OD2eeV4o2jVOneUxPJvk+UMEDrftXxw
	ovUeMUEEOU4hU5EGx4pVWRYjP/K29rpvrZB5X6+pmbkrFbzUvWNe8Ag2avVWahJL
	uFAXBfCngyNG59yhzmhGOWNxi11nUTbfVEwjSkml20DCbSLBpDAakPH1tR5M+Zpz
	fc6/905L8Ms/sST4uezHSJVfaErHHL6O8Qz/JEL8dlwAPWLq4Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xewr39drc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 16:27:15 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CGREYr007189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 16:27:14 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 12 Apr 2024 09:27:13 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <jiangzp@google.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 0/3] Fix 2 tool btattach issues for QCA controllers
Date: Sat, 13 Apr 2024 00:26:24 +0800
Message-ID: <1712939188-25529-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6VNgx0w40FokejvnWdu-2vVkqqNP3GUd
X-Proofpoint-GUID: 6VNgx0w40FokejvnWdu-2vVkqqNP3GUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1011 adultscore=0 mlxlogscore=758 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120120

There are many QCA soc types defined by drivers/bluetooth/btqca.h
enum qca_btsoc_type {
        QCA_INVALID = -1,
        QCA_AR3002,
        QCA_ROME,
        QCA_WCN3988,
        QCA_WCN3990,
        QCA_WCN3998,
        QCA_WCN3991,
        QCA_QCA2066,
        QCA_QCA6390,
        QCA_WCN6750,
        QCA_WCN6855,
        QCA_WCN7850,
        QCA_MAX,
};
and every soc type stands for a kind of QCA BT controller, this patch
series are to solve below 2 tool btattach issues for QCA soc types:
1) tool btattach will cause kernel crash when used for QCA_ROME
2) tool btattach does not support any other soc type except QCA_ROME

For hci_uart derived from tool btattach, it is allocated by hci_ldisc
and is Non-serdev device, its @serdev is NULL and its soc type is
currenlty hard coded as QCA_ROME.

The 1st issue is caused by dereferencing nullptr hu->serdev, in order to
solve the 2nd issue, a new ioctl is introduced for user to specify soc
type by a new added tool btattach option.

Zijun Hu (3):
  Bluetooth: qca: Fix crash caused by tool btattach for QCA_ROME
  Bluetooth: hci_ldisc: Add a ioctl HCIUARTSETPROTODATA
  Bluetooth: qca: Fix wrong soc type returned for tool btattach

 drivers/bluetooth/btqca.h     |  1 +
 drivers/bluetooth/hci_ldisc.c | 10 ++++++++++
 drivers/bluetooth/hci_qca.c   | 10 ++++++++--
 drivers/bluetooth/hci_uart.h  |  3 +++
 4 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.7.4

