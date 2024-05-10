Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61EA5490E
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323518; cv=none; b=V7pbs0ne8fZpf2PhYj9J2Yv9UOUQnWyP3ZeiCXuSkw7ZfSK5+MjHFcBC5qIpfJD6W95tNwidUhA2QIFN9wtCDm+R8cPCVcWaKWIZI91XM6f5rCKsmGQZ/CYzwU/IV1loLfjEud/gvrOk6eVysi64qpxh618y+0vu0hW/yznusxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323518; c=relaxed/simple;
	bh=y96GLAfCjDFA4/+yLm8gb6N5lw9ko5Cbuar6qPhAkec=;
	h=From:To:Cc:Subject:Date:Message-Id; b=l5QrDeBLfNO0ubvqzEO0aOqUlDgEtV0zECAP/T+pTP2i7Ks6RY0kLt3zQ3Re/TS3LnIt0tN9S6Y4nOKXM7nPnbcQa0AVylBTjj2jlJ0/RPd0OXQEb8yqF0Ph15g7qlsYtWP5R4DFqfGeRsjLzZOFQDkG75EzYIyDWtZv+STav4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ojLbbJd/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ojLbbJd/"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A2tiwR000751;
	Fri, 10 May 2024 06:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=Z9Pi8bnqwpsy
	PQFP0DUrjJ45pBDbOiVb4kma2f/24T4=; b=ojLbbJd/5f51SgrJ3OaESD8R8r7B
	1iCWuQ1fTWICcRFyAZDdNetJwmaM8BhP0yBMPqfqev2PNMNMj6TdQY+T3tDe/LH2
	c5JHFWmhxw0tN1ZF0GnZm8d8w1DNjoHYtekbiFAl6g50athLFs0TA2/tQKOJQukp
	GUksJSWLpb2lz/foUoYKmhCRhejuyvUBCOgib1YpEY4/qIIWCbQ2eWiAH0cDTpFl
	4ieRbsXSa7yEpxdBHQNPPVaDxO7Qsg0fzW0zs9sRZ8H0lVzO24gHgVq//I9/dF12
	YYmi4coWejgALCqGMt2lDh1g6d96pnBH8z64avyCtHgQpgzpIMUNCmcbwQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w0rsvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 06:45:14 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44A6j9gL028514;
	Fri, 10 May 2024 06:45:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3xwe3krpdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 10 May 2024 06:45:09 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44A6j9Ro028505;
	Fri, 10 May 2024 06:45:09 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-rbujala-hyd.qualcomm.com [10.213.107.103])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 44A6j97S028504;
	Fri, 10 May 2024 06:45:09 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4130939)
	id 895D0609546; Fri, 10 May 2024 12:15:01 +0530 (+0530)
From: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
To: ofono@ofono.org, linux-bluetooth@vger.kernel.org
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
Subject: [PATCH v1] Permission for pulseaudio to use ofono.
Date: Fri, 10 May 2024 12:14:56 +0530
Message-Id: <20240510064456.24101-1-quic_rbujala@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fn-NRKJnRqOT4BRi9ETWqpSW5N5Du8VX
X-Proofpoint-ORIG-GUID: fn-NRKJnRqOT4BRi9ETWqpSW5N5Du8VX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_04,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=801 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100047
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

When pulseaudio is trying to Register with  ofono
on interface org.ofono.HandsfreeAudioManager, dbus
is throwing org.freedesktop.DBus.Error.AccessDenied
with string "Rejected send message".

To allow pulseaudio to send messages to org.ofono
service over dbus added this rule.

Signed-off-by: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
---
 ofono/src/ofono.conf | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ofono/src/ofono.conf b/ofono/src/ofono.conf
index 6c5483ce..c946e822 100644
--- a/ofono/src/ofono.conf
+++ b/ofono/src/ofono.conf
@@ -32,6 +32,10 @@
     <allow send_interface="org.ofono.intel.LteCoexistenceAgent"/>
   </policy>
 
+  <policy user="pulse">
+    <allow send_destination="org.ofono"/>
+  </policy>
+
   <policy at_console="true">
     <allow send_destination="org.ofono"/>
   </policy>
-- 
2.17.1

