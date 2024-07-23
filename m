Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06CF36130
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721721340; cv=none; b=FS9QeZPoAO9dxmL7WxyG3ld8SXpT7WoRaYj/Ia0vbEyhHaBM+eL0IxDfY8gYOXZaD2AQ49fSE/bjwhDaWL1hdt3fZZ7EF5WnBm7Yzihix2FRkf48ZxojET7zJB+9lkyuInQRqZJ+Lu0wrr+ksrhO0M+2OT8NOrn0g++Cbpjlqrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721721340; c=relaxed/simple;
	bh=FKZCz6p5KfHUfd303XFauklORdYsGek5gNEJrMDfW88=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MmAYAI59ZBUe2CcW+GS+5zFSjN8xpUx+g5+6bIj4QCD5oxczSkUHXgo6UrrHraC+bOCqDUHF4AFLzZ+tPsAg38ttJ6TliJv+FG2qpNF3+TNXzGLOclkp+yI/420x/akfICU8R5AV/vCbPxz+E57JxnTRy14Dz7xxMKXVjrsLIw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GuTRgERE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GuTRgERE"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MNF2rK024464
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 07:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=oGXBFb9XU+IdShEHgmfuAi
	O2XApbJN1Epk6W/VDHHkg=; b=GuTRgERENPKql8gL4+ge9E45OKFxzxB9iOGJVv
	PIL5tlzcX5N+L8pV8yASgIC0+Da7ZL+0E0FnNfTpaee2kuY0wam75f+2QC5jZyQ9
	mPyNUYLBFitJdNj9Ggvjegyl2/Ox1Qxhw5tT/k09lR7b4IBI+PCn6PzqnhSTzezm
	N1ND7ynD1gyua7jiuciORoIFbebuanKLtEas/dE/4omwpetzuMFqLiHPbZUtSWjV
	ljz4SCT2o+AeutNpR9Bxz5TVe+m+bP5uOi24AVPZkBBJgJOC/bi22vdtLZveVVou
	YI6QHeYKn297JPhJl4VU01atYjWqKXd/59U5yyYDapzGszlQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487e0rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 07:55:37 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46N7tDFv025271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 07:55:13 GMT
Received: from hu-dgangire-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Jul 2024 00:55:11 -0700
From: <quic_dgangire@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH] build: obexd: Add system bus support for obexd
Date: Tue, 23 Jul 2024 13:24:55 +0530
Message-ID: <20240723075455.2934376-1-quic_dgangire@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fSrXbnruZqY0PbJfozv5PLXvrCs95ovH
X-Proofpoint-GUID: fSrXbnruZqY0PbJfozv5PLXvrCs95ovH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=808
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407230058

From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>

Currently obexd uses session bus.
Distros  where session bus is not supported and still obex profiles
are required in that case use system bus instead of session bus
which can be configured with new optional feature

Additional optional feature has been added to achieve this
with name --enable-use-systembus-for-obexd

steps to configure system bus
./configure --enable-use-systembus-for-obexd

If this optional option is approved  will add other patches
on how to use system bus based on this option

---
 Makefile.obexd | 14 ++++++++++++++
 configure.ac   |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/Makefile.obexd b/Makefile.obexd
index b7e9f2d33..87432cc37 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -2,6 +2,19 @@
 if OBEX
 
 if SYSTEMD
+
+if USE_SYSTEMBUS_FOR_OBEXD
+
+systemdsystemunit_DATA += obexd/src/obex.service
+dbussystembus_DATA += obexd/src/org.bluez.obex.service
+
+obexd-add-service-symlink:
+	$(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-org.bluez.obex.service
+
+obexd-remove-service-symlink:
+	rm -f $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-org.bluez.obex.service
+else
+
 systemduserunitdir = $(SYSTEMD_USERUNITDIR)
 systemduserunit_DATA = obexd/src/obex.service
 
@@ -13,6 +26,7 @@ obexd-add-service-symlink:
 
 obexd-remove-service-symlink:
 	rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
+endif
 else
 obexd-add-service-symlink:
 obexd-remove-service-symlink:
diff --git a/configure.ac b/configure.ac
index d31eb1656..cc9a55f4c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -283,6 +283,15 @@ if (test "${enable_obex}" != "no"); then
 fi
 AM_CONDITIONAL(OBEX, test "${enable_obex}" != "no")
 
+AC_ARG_ENABLE(use-systembus-for-obexd, AS_HELP_STRING([--enable-use-systembus-for-obexd],
+		[enable systembus for obexd]), [enable_use_systembus_for_obexd=${enableval}])
+AM_CONDITIONAL(USE_SYSTEMBUS_FOR_OBEXD, test "${enable_use_systembus_for_obexd}" = "yes")
+if (test "${enable_use_systembus_for_obexd}" = "yes"); then
+	AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 1, [Define to 1 if you want to use system bus for obexd.])
+else
+	AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 0, [Define to 0 if you want to use session bus for obexd.])
+fi
+
 AC_ARG_ENABLE(btpclient, AS_HELP_STRING([--enable-btpclient],
 		[enable BTP client]), [enable_btpclient=${enableval}])
 AM_CONDITIONAL(BTPCLIENT, test "${enable_btpclient}" = "yes")
-- 
2.34.1

