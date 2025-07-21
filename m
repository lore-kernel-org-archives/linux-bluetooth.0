Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364532DF3EC
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111459; cv=none; b=GU15igR/GxSKxBkcgyMhaGYsza2G0E8/ynaqdmGbPTdlmh81dZY49o9kkaokDKIo0PP9EtQqlSkjafp8CB0EYBLOXze9Ch8c22Tf+o5l5ZJ6ce2SxaX0BlcTpBFDT8V2He0gAuLFmwXzVnEnZqTpZulB1xrz/31Sa3tJlZ4k4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111459; c=relaxed/simple;
	bh=wdZduuUMxDc1PslwUGPZzgTUQnc7rJJMFj4QM8wDGbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfPpmKQa7Rbp1LnKD0KtR/0SQz//RfLKITg2rgXwTN5rrt//CwM8AnULbIrzLk1wc9AHp1sHJwlbrs8DHRwoaDF9CLg0mwdcfjgw0Cvw2l2UWJDUW54pZU7US+wro8yM5iBca3cLsY9Yuxj2MdV6/T3DSY9s8em+67JdlS96ngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hxrt8QZn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hxrt8QZn"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LA8ZmQ029270
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5oUXL8pbJPQsw9LqXPMXO4Eu68Bp+4ywyqHjR9ejEwk=; b=hxrt8QZnT6KxdYVg
	c/8FqoXKOgvrNbTWZUOEMcxjwU0/MurmFWuzejLOhUfU1LWrJLkXjFs8yZRo7c6o
	J9/fnGTPuFRSmuaqN+MNRNVxMKvQhfdwP6rSzbXp5CoUlb+Vn9uDeu1YR3Q7kJKQ
	daBlxLfydl2QIObLZYPG++obeadyRLR9DiDk8LRY3Cmcd5a64f4YwEHkLtHBaoi6
	BpGecEoUGz+PE0uulpmZzWFC3VZ3dAzN0XWfa8eOcA+3BVOnNgQ3SkXJALa8n0QY
	ynxSYljqNr+ROw2ySf3SQmYlwehRXxBEaYwwCmHmIl2EDcdeukwGYPVBFNswVdG3
	8I3+zw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048tdt3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:16 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56LFOEwY030994
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:24:14 GMT
Received: from FGIANCAN1.eu.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Jul 2025 08:24:13 -0700
From: Francesco Giancane <quic_fgiancan@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Francesco Giancane <quic_fgiancan@quicinc.com>
Subject: [PATCH BlueZ 2/3] Makefile.am: build `bluetoothd` if enabled
Date: Mon, 21 Jul 2025 16:22:18 +0100
Message-ID: <20250721152219.517-3-quic_fgiancan@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzNyBTYWx0ZWRfX9XdhVV0Ilfk/
 NaGHLDsvhhISgwR+FK3nt5xnZnkiy6pMKoR5mCkUgQMywa69Gc9sq30075k9B4UMJLU9BF+iDUI
 BHSiOuGEKO9hw047u1GMEv8S/f7MlRn3IuJEmh/hRx+99NbFwsOo7EU8OW6X9xtVOozai9fZ5Xx
 pSGmpRYWOajXYw8d8gbL3QfB3KakY2Hun7ktZP5jlelux2m5eW3JVY9+2fYnkUVGNyEtkYVHKOI
 TiuXJ0F6D5Ex4720dfXzaeRyWY2Y5HAamW5x7wV8pAskZxzIXwlZDi65laxEEr+UUCmE/bZD+Jr
 k6ZUBeoCy0pa7pbUEeiBGNiCQpMcedjx0PgI/1redz+HmD7/yC4W8iAtMpI0ecUOWi532I9xKKW
 esPJRUBfHrdMQFg8tPYuOHDPQLnE63gUUbEnhbdwE1t3qezNbjZbxK3iuziAbvx00dbmjQnm
X-Authority-Analysis: v=2.4 cv=Jb68rVKV c=1 sm=1 tr=0 ts=687e5ba1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=-83cLicZ2TOdKBctj5gA:9
X-Proofpoint-GUID: PU4uHB5Pybin_-DVNZU-Yyn-fw85qV2N
X-Proofpoint-ORIG-GUID: PU4uHB5Pybin_-DVNZU-Yyn-fw85qV2N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210137

Keep daemon compilation and installation steps separated.
---
 Makefile.am | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index fa1003a2f..af30cf6ae 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -31,9 +31,11 @@ AM_LDFLAGS = $(MISC_LDFLAGS)
 confdir = $(sysconfdir)/bluetooth
 statedir = $(localstatedir)/lib/bluetooth
 
+if BLUETOOTHD
 bluetoothd-fix-permissions:
 	install -dm755 $(DESTDIR)$(confdir)
 	install -dm700 $(DESTDIR)$(statedir)
+endif
 
 if DATAFILES
 dbusdir = $(DBUS_CONFDIR)/dbus-1/system.d
@@ -301,7 +303,9 @@ builtin_ldadd =
 
 include Makefile.plugins
 
+if BLUETOOTHD
 pkglibexec_PROGRAMS += src/bluetoothd
+endif
 
 src_bluetoothd_SOURCES = $(builtin_sources) \
 			$(attrib_sources) $(btio_sources) \
@@ -441,7 +445,11 @@ include Makefile.mesh
 if SYSTEMD
 install-data-hook: obexd-add-service-symlink
 else
+if BLUETOOTHD
 install-data-hook: bluetoothd-fix-permissions obexd-add-service-symlink
+else
+install-data-hook: obexd-add-service-symlink
+endif
 endif
 
 uninstall-hook: obexd-remove-service-symlink
-- 
2.49.0.windows.1

