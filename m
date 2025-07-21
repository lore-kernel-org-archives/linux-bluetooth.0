Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF96626F454
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111474; cv=none; b=e9/LXoYJKPQYDsRQz+rGFKQrKWX6RKSRMX0hA6stv1H1HlWtqvA8/jsNdQPYmkS5cnF9+Z9uTH+jHibzZVKyG2UPZPRd32GfFvo74QOIiZUD1yWlHbMkTeOYTA2YjNTHIHoetGm3VJtyD7Py18kcWXxJtZ+Rs8/emX1QLNbOrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111474; c=relaxed/simple;
	bh=s1pXNlC3g+1mr9sdwbLZOAlUnSPbSNIY7wjUJ3B+2NE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuHZ7bM8k7O9RlMzlta4xuE633e0jRNPDZdmQbkPrt5Nq6DD54VFKCFceqaXHTVzZc1yYBkC4du/63C4m0v8ANhqezQzjOzXXnPN9zUQJf2M7OjEDnIat4Hexz5kcMxv2zrpbMY2odTnij+jvWL9oOo4hoErMNspH8gaiOitDJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UjSenGmf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UjSenGmf"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LA8OUR015833
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NRLxu+pRVURxIc2PafSmHH9+dNV8pSDwJ9qfiGtFhJ0=; b=UjSenGmfHKwOyogF
	9wp0yQh5lGxxsWUbW/Z3LG+0dCVUxyY8SSJ6mhbMLxScDSa4ZylM2oS37ABIIdLU
	Zscpmwtlg3G+8z2N/qmGjKWvrZKxYvupVEzY/4BmDt3EBnKUDM8PMk5FQd4TLOEl
	dz1OQpV7VA3kED4PPYiE6pNPBYDg08EQt0TAcMQ8/xER+orJZCssUmet16LGevBX
	BKM/r24IbMyW7o2zazvCcjHVbpCFd1pIITGvMYXQQO9Jw07oPhMdN0mAQ8fWSYPQ
	+qu1T+Yktz7u3dkqCU4XKbRVmVRwhLE/YfpNYc0lK3CtLXbLQTK+WSpyT7HO7ycp
	busR4A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480451dsjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56LFOD3F030982
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:13 GMT
Received: from FGIANCAN1.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Jul 2025 08:24:12 -0700
From: Francesco Giancane <quic_fgiancan@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Francesco Giancane <quic_fgiancan@quicinc.com>
Subject: [PATCH BlueZ 1/3] configure.ac: introduce `--enable-bluetoothd` flag
Date: Mon, 21 Jul 2025 16:22:17 +0100
Message-ID: <20250721152219.517-2-quic_fgiancan@quicinc.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250721152219.517-1-quic_fgiancan@quicinc.com>
References: <20250721152219.517-1-quic_fgiancan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687e5bae cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=a4UwVZYBIGZpGZM9nS0A:9
 a=0lgtpPvCYYIA:10
X-Proofpoint-ORIG-GUID: HMsiPXt9Jpl_H3Q8dVeACjZ1QYvRNdz4
X-Proofpoint-GUID: HMsiPXt9Jpl_H3Q8dVeACjZ1QYvRNdz4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzNyBTYWx0ZWRfXxj35Md16iMRR
 YVbKKMmcZwqJYeB/Mt4qg9N9a3zI3gnXoW3A6awXNhXw+E4hdFd1ZLdl8lbBdvh0se8Ae+0D69x
 a5wpLFZZv1moiLi/00UjC1TgEG2NEfBqqxwbeViFonOHK3hj5d2OljuktboWRGvWC+ffuPKvw+W
 wXKgFb/DZjKdDP7CTAXWUQZmNH+nk20l9nXAPHCAX7Ky1WcgCuAihzr2g7H5aZ3kPZIP+Gh1Aqg
 OIIGyQvq8VF2v0wyxMinxyNpvw/f0BCDfSq/wpo5h5mtYH+Rw0L9DRd4C9trPmfZSL3VxVHGQXx
 XOrmf9KtZ8x84fPE0A5TVwbDr42CmUO8t0nSzDb950mmQWWr4xDaAA6BR4mXaYJPb7J5uC+L478
 tqtyNeM8skvYz8yNHO3n4aZ2SVjIW/Jidh24wLEl3w2gJlfwBreTbyW2Grf2/xNg1bro853u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=746 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210137

Add an extra `configure.ac` flag to individually control `bluetoothd`
compilation.
---
 configure.ac | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure.ac b/configure.ac
index 955908621..a6eef93bb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -154,6 +154,10 @@ AC_ARG_ENABLE(library, AS_HELP_STRING([--enable-library],
 		[install Bluetooth library]), [enable_library=${enableval}])
 AM_CONDITIONAL(LIBRARY, test "${enable_library}" = "yes")
 
+AC_ARG_ENABLE(bluetoothd, AS_HELP_STRING([--enable-bluetoothd],
+		[install bluetoothd daemon]), [enable_bluetoothd=${enableval}])
+AM_CONDITIONAL(BLUETOOTHD, test "${enable_bluetoothd}" = "yes")
+
 AC_ARG_ENABLE(test, AS_HELP_STRING([--enable-test],
 		[enable test/example scripts]), [enable_test=${enableval}])
 AM_CONDITIONAL(TEST, test "${enable_test}" = "yes")
-- 
2.49.0.windows.1

