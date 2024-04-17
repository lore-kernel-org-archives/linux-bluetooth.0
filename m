Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64C3D72
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358378; cv=none; b=N0XDw37iSjNGBk020WLUr7dXxwx1fa/A20ZS0XDdztFiq4PUHQB61cB+cVoIcKrgCym5+dbYS63pAacvj9oRF+fFBl6f4BLmNAbDThKuGzR3/coqAl9nY+yMX2oGjjmxx62Sf/2xLC8L7aJf+ep4pRT/BejcPd6JkSV3o6pULVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358378; c=relaxed/simple;
	bh=w8YQS5mT+rKI0opeUDO5W4CYsfM4yrMUGgduJNi2uQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwkMy2ndhLQAdtZO3+zVRpYorNpdr0jXQK2G8R8rAR2/0yIymKmfv6kkZvkT9+ieBO1YEH1P4BRA/RdZDC2WfSLP2qLFvutHC9olgnNPxqGc3M08nIeOhtEkqseh2ewGjB00xSH/bpoFeb6kED6RJt6B9aBVkrwjtnwm9Bh+H7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WIONhiac; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WIONhiac"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H77qJZ008077;
	Wed, 17 Apr 2024 12:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=ETUSX80kD8gMNDXPqGy/
	hIQkxGtSwRGjMSzgY8dlk3E=; b=WIONhiac+DOW8ab8xaAQ8Jvz9EpBKsJ/egWT
	wVwn2pnPVU6N42CVjmj+ItpO3RZrFh/CPFrPnsOCLcBz8TJQmLtGkSCg7HS/iwEw
	YtXMkdTpluqAsMtTCsDiZytk18hAxTCObLx6zUvSPNSYoRDGYXH8WJzfB7RH+6+F
	+sBmMatqrV5C0Rhf6nvaMIppg6oJSHtRn40V7NxI5dh733smOw0pLKsoVhLcIijP
	CAjd0HMlAq/YQZccqdrcom114sh95bD5POFbWlPFwS8r7Ok1uog3hzGg+qmPn7yY
	Ur3CszbajSsWse5roI9BPHLBqUjuqLfrYkqAXtxsHP5sJ2X4EA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj9rm8rfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:52:52 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HCqpPv021046
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:52:51 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 05:52:50 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v2 0/4] Fix 2 tool btattach issues for QCA controllers
Date: Wed, 17 Apr 2024 20:52:12 +0800
Message-ID: <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GTZwgDprpIikNAL4bJkRcfkpjYhnVtG6
X-Proofpoint-GUID: GTZwgDprpIikNAL4bJkRcfkpjYhnVtG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 mlxlogscore=793 priorityscore=1501 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170087

BT chip vendor and customer often needs to use tool btattach to perform
various development,verification and evaluation test for vendor's BT
module, but tool btattach is not working fine for any QCA BT controller
currently, this patch series are to solve this issue.

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

Changes v1 -> v2
 - Add patch 2/4
 - Correct cover letter 
 
Zijun Hu (4):
  Bluetooth: qca: Fix crash caused by tool btattach for QCA_ROME
  Bluetooth: qca: Fix nullptr dereference for non-serdev devices
  Bluetooth: hci_ldisc: Add a ioctl HCIUARTSETPROTODATA
  Bluetooth: qca: Fix wrong soc type returned for tool btattach

 drivers/bluetooth/btqca.h     |  1 +
 drivers/bluetooth/hci_ldisc.c | 10 ++++++++++
 drivers/bluetooth/hci_qca.c   | 19 +++++++++++++------
 drivers/bluetooth/hci_uart.h  |  3 +++
 4 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.7.4

