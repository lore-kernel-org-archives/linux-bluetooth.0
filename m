Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84B14F1E4
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713409928; cv=none; b=gyJs77mRKil7X2lzelVbKSpDU5NMAWka89pzq2TFJ2gNiTI3/dlTH1xSdJ8jOAeCaryS0xNEF2sMO14O7P+HIgxlCGAH1PFAde0LWMrPx7HR+0zyUoRBXVSM3cZcEDfMYGL4hdCmjdTST6Z/e2DWmapsb6OxC7EWsZFVIHBmQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713409928; c=relaxed/simple;
	bh=0d5arXP8lvP/dxEQvt82+muvNMWrRWY3vvYNL0Q7jQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDICwPkp7yyeU0YuDqH1zBsByy4LX+h5nwpMXpPKaNfUhtd1Vys1tVJqv3eozcdNZ1dZVSDCHONbuRVfIddOJK6UpEPUPCtvFuOCDO74fKAIlgBuNUSLG4WTmG9BujGYT/3KSiNbZymWky8ojddT/+o+VWdvoqB6RU2DmszYsa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mAie4cvG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mAie4cvG"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HNluOv015162;
	Thu, 18 Apr 2024 03:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=dyWAwATH1r8Ae0zJr1a8
	vD/BH6JjhAIuLfNgwLmOWaI=; b=mAie4cvGcUX7p0k1FmY3cy3qndcBeW358MwF
	1GJz3Izh7U9elGbtDjhtVHb/Fstomi0M8A1c3Dsw2IK8L76QTJAZ1CmgGAIzhhcj
	NkIDHnyX4/5WREZZyukaWzICZyPQrAyb1NvR8+e6hKqUq1B8dR870d/9UZsbPaWr
	FCokqMNHx/mTz8kxh5uV46SdYDX4exvCoa1sI93Ipt05gYxPchI9Yi9Gc24ep5/y
	5oER2Rkc4UMn+ureRMQRLv7pGRMQxWPKEPV/AgpIJofoOzf1bh3cNPK43pizClYh
	/LaYh3womnK6D1RPQsvZDaKAM2mVry3Ms4FVdt3YfR09coSoDA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjrdbghpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 03:12:00 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I3Bxn8003717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 03:11:59 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 20:11:57 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v3 0/4] Fix 2 tool btattach issues for QCA controllers
Date: Thu, 18 Apr 2024 11:11:49 +0800
Message-ID: <1713409913-13042-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: D54rgK2mMe7GSrsmfszV74vD5AUWcWt0
X-Proofpoint-ORIG-GUID: D54rgK2mMe7GSrsmfszV74vD5AUWcWt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_02,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=779 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404180021

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

Changes:
V2 -> V3: Correct commit message
V1 -> V2: Correct commit message
 
Zijun Hu (4):
  Bluetooth: qca: Fix crash caused by tool btattach for QCA_ROME
  Bluetooth: qca: Fix nullptr dereference for non-serdev devices
  Bluetooth: hci_ldisc: Add a ioctl HCIUARTSETPROTODATA
  Bluetooth: qca: Support more soc types for non-serdev devices

 drivers/bluetooth/btqca.h     |  1 +
 drivers/bluetooth/hci_ldisc.c | 10 ++++++++++
 drivers/bluetooth/hci_qca.c   | 19 +++++++++++++------
 drivers/bluetooth/hci_uart.h  |  3 +++
 4 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.7.4

