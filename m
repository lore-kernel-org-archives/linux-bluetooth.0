Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64197248F72
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565432; cv=none; b=ppf+dKQU/fxngYY97SIdnGjo6Mbsv5XnZ33I1Y4NMqsnunFXxY3Gzt0mMQInu8ti4puwb0P1K0ojOA4o8XW3vQcUTJrfY7SWZbMNZ1ZmuTc7uLCIwwvy78WOC07pSOEHu81Ip+BqNobweQWfOYxL/B52+ATLNjltPMO8jAWa+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565432; c=relaxed/simple;
	bh=pHarEEcsvd84YtIqnX3zYncoUratGZsrRDis/zPBkDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jK20wFRxWMaraZ3jb4tumLM8vJgDxB5eVwRau/D8SOc2iUl+xN38WCKR03TTQDuJMzj3YD9R3O7CpoilsVIsFYijRQAgXOvJXxYNCXQ3u8Zl78rfiNVG72KBEI5pxXAbyKXiu2z/2iztxhTeRZaBVR69f82fX4jU9fRcCEpMefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MFaEnSgE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MvogfLy7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MFaEnSgE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MvogfLy7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6548PsK8313659
	for <linux-bluetooth@vger.kernel.org>; Thu, 4 Jun 2026 09:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=I+tuEXuy0im
	rljJY8A+muoiNI1FBSf0RF8WEW7NZSbM=; b=MFaEnSgEFp9cBxjeeTTAPpyzthc
	+b7/SibTUH5gru6TejlAb5Yn8YHsBmpC1YO8raSxj8cNOvww5NkfZWwPWaVskCDL
	hvNG2D0KIqlqBMfr1HGUJEcIrrpNaT7VnQhL8ez1EddXtKSI5uOocSsBXWlFIwfH
	9ycMYCBuFt+2HPRYb2dYpcrf/+69MqS+JgQtFdvGXwMZ4rTJlpMDWYr5tAvsqjb0
	lfPNkYQPRjfTb9g+bcuIshZfZoGuVO7yrMGguVeOiPSGHhjopghEH10/6UKnuFMf
	BuMzzC5oN296R6cWAbdkRzWZv39dPVfkK6ce09LHP7O7q4LQLzmh+ZcXSBw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy5v1p3v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 09:30:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30715229191so26363eec.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 02:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780565429; x=1781170229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+tuEXuy0imrljJY8A+muoiNI1FBSf0RF8WEW7NZSbM=;
        b=MvogfLy7CJ9XTWgqLCNL7kqdb9kghQg03M/sbAaTInPSbsUBOIMd7oK108w+3XjKv0
         q16ipTgYeKVWEx4ohZVypNEZJ68VVvF2jjmJxz9DJY4xJexMR86Fees3Gp8usegG1BC3
         6UbFCSG0w8RxZOLX4cF5i5e8/h+Qkc2lCOvPC/1tCuee9te5B3D1AfT4t7XPycgtL9Nl
         9+45mv8NusHDJ/PZTLsQUNM/QDC/UuN33zMynZh3VmFoX9ywVgTH+iUsgavyZmiz6otY
         3HBJZYvhmBbencPuk0pvnVRJoGdfnznWRhnGne5v+ABFoVpTZYZUPIwI+LHTvwDzv6Te
         Bsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780565429; x=1781170229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I+tuEXuy0imrljJY8A+muoiNI1FBSf0RF8WEW7NZSbM=;
        b=eLswGQkCVpngcSlH0hbX3pXtAvmblEpPG1JJYQCDOHW78ORDsy88x+g7emN6hvmZJP
         LiFaV7GBG4/3u+dxUpCzjpP/gbS3g8ZZi5vKxi4mBvQHx8hdP/w0P3oEBagBID19GY0U
         Q4OfC1qeucCoEPhJKQC9TSvlKw2arb/KAkncr8yP5Psr7I30zJbOKaqnVjFIQpKE0u6C
         rwiAHS7bVa6eZPBuHZa9TO+K8z9IJdJdsADyR/ibvK8BlHImhRCuEc7M2FD3TXPVWkmB
         8Z/ez9hLBIEcdvqzezBGQPx5Tn535Cq+T+ulHOOx6eW+K+xjanOojssgUFqZcWKiIwL7
         8GWQ==
X-Gm-Message-State: AOJu0Yx7uNRntC3pXsMfPQWRimLcXD/YbohnPDES/Z1bOaU3cwLwp3vI
	zMN5ZgKjVlguBjZqRaYcmtKkrMCwnuRuHOgDV9LDOFltBJ60KDJI8o//4qO2PCZSyKr/88XxOxV
	iex0zWg7CKUlOSXMJpa8PX1djzCSU+Wf/m+zSKq2g1x9srUXY2xSwDdEvcOMTMhOmzTpoHQ6Ywh
	cOXiN8nA==
X-Gm-Gg: Acq92OGQkuUsGm1HBiI1FoYV3n9/uhWaOmSxM4Mr+j4yoSiZPQ77GoOqzifhaIktjNe
	i/PsJYUm4f9PhgDbWcSEnHiGYAP9Jy9EsSd+fI3PyF6yR1JLy8hZliI9lT2a6dJBnQXZwBLRZu+
	yYhN3+DcelC2MTHmCEH2SoeWf0N4KEETz4/TKuCJawrL0wLn2sfgi9ZZHvpVttY1hg7MSGcK0Vg
	E4uVduyB+4G3sTqTf/Cx+2556UYeA+ZfmPO1MO11rgRihelwc1GUMOgONOlz/FO5qgeWyDTep1y
	TBNSiQ6ze4jpuYV04HhHET5NkcvPZRitz6+C3vyUWzCpkJaU62zyXd1ffOh6vQBGiuNllCJORET
	ZGiimkMxijQeKIp4kabpcICeBtMaJ0tM0sVJCuwVR8a0lJcDi+J6PdfgsTLmkiGq9qoMM7M83ip
	eObE3fPQk=
X-Received: by 2002:a05:7300:fb96:b0:2d8:7302:d3c with SMTP id 5a478bee46e88-3076a622258mr382415eec.4.1780565429241;
        Thu, 04 Jun 2026 02:30:29 -0700 (PDT)
X-Received: by 2002:a05:7300:fb96:b0:2d8:7302:d3c with SMTP id 5a478bee46e88-3076a622258mr382407eec.4.1780565428491;
        Thu, 04 Jun 2026 02:30:28 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df64eb9sm4096116eec.25.2026.06.04.02.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:30:28 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, cheng.jiang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com
Subject: [PATCH v3] profile: Set L2CAP IMTU for OBEX profile listeners
Date: Thu,  4 Jun 2026 15:00:24 +0530
Message-Id: <20260604093024.3594022-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602031719.679979-1-wei.deng@oss.qualcomm.com>
References: <20260602031719.679979-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MSBTYWx0ZWRfXxtOQZN9xrIly
 nIE3X048NQ678z8rwiI8iu3HsKO2Glb3YwdT/f9pG3l9tNHF69hR7mBzoq5LdzOzeCTMNBwe2j0
 cdOcs2POMlrtPxlk5WpGxNuzm8s6tVGlCWcgbd5GIcY7EG3x+eLVO6W53MomSwuSYHnY/acdGK5
 SkdSF4J+9bKvIckv39Kd57aT350ZXLTvC3BON/k3P4hAv3NZOu9wUDzxn0dWU7lb6ZvQfOou5GQ
 C3lBAOS1gM7oi55/DqwOGgNIG/S8Ot3i1++z80NBuHTzc0O/VJEkBvp2GOJ6PPqRcr6Hl+x54i3
 FpLTM+5d+b9kSfJQfAzxGHSU0NLtnkNCbM+VhE27N1926qAH9rQkYXTyNS/0GCy5/SdPiGcbjJe
 LsBIsNpXFD7G6jvPfSCVaDtxdungh9OhJc827Or/wbBP9QgcUxGjuzUYrOqb5UnrZqN08H6oDQH
 4ygDzFfwT/xrSUUjAAw==
X-Proofpoint-ORIG-GUID: Xio8EWodI_8wrUL1vquOyMUAP-d3x03Q
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a2145b6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Dn_zmuI-H6WiX4eIlCEA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: Xio8EWodI_8wrUL1vquOyMUAP-d3x03Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040091

The default_settings entries for OBEX profiles (OPP, FTP, PBAP, MAS,
MNS) have no imtu field, so ext_start_servers() creates the L2CAP
listening socket without an explicit IMTU. This causes the socket to
advertise the L2CAP minimum of 672 bytes in L2CAP_CONFIGURATION_RSP,
limiting the peer's outgoing PDU size and degrading Rx throughput.

Add an imtu field to default_settings and set it to 32767 for all
OBEX profiles that use L2CAP. Copy the value in ext_set_defaults()
and apply it to the listening socket via bt_io_set() after
bt_io_listen() succeeds.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 src/profile.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index dfc5f7161..65df0f7a0 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -55,6 +55,8 @@
 #define MAS_DEFAULT_CHANNEL	16
 #define MNS_DEFAULT_CHANNEL	17
 
+#define BT_RX_MTU		32767
+
 #define BTD_PROFILE_PSM_AUTO	-1
 #define BTD_PROFILE_CHAN_AUTO	-1
 
@@ -678,6 +680,7 @@ struct ext_profile {
 
 	uint16_t version;
 	uint16_t features;
+	uint16_t imtu;
 
 	GSList *records;
 	GSList *servers;
@@ -1423,6 +1426,9 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
 			if (psm == 0)
 				bt_io_get(io, NULL, BT_IO_OPT_PSM, &psm,
 							BT_IO_OPT_INVALID);
+			if (ext->imtu)
+				bt_io_set(io, NULL, BT_IO_OPT_IMTU, ext->imtu,
+							BT_IO_OPT_INVALID);
 			l2cap->io = io;
 			l2cap->proto = BTPROTO_L2CAP;
 			l2cap->psm = psm;
@@ -2075,6 +2081,7 @@ static struct default_settings {
 					struct ext_io *rfcomm);
 	uint16_t	version;
 	uint16_t	features;
+	uint16_t	imtu;
 } defaults[] = {
 	{
 		.uuid		= SPP_UUID,
@@ -2142,6 +2149,7 @@ static struct default_settings {
 		.authorize	= false,
 		.get_record	= get_opp_record,
 		.version	= 0x0102,
+		.imtu		= BT_RX_MTU,
 	}, {
 		.uuid		= OBEX_FTP_UUID,
 		.name		= "File Transfer",
@@ -2151,6 +2159,7 @@ static struct default_settings {
 		.authorize	= true,
 		.get_record	= get_ftp_record,
 		.version	= 0x0103,
+		.imtu		= BT_RX_MTU,
 	}, {
 		.uuid		= OBEX_SYNC_UUID,
 		.name		= "Synchronization",
@@ -2167,6 +2176,7 @@ static struct default_settings {
 		.authorize	= true,
 		.get_record	= get_pse_record,
 		.version	= 0x0101,
+		.imtu		= BT_RX_MTU,
 	}, {
 		.uuid		= OBEX_PCE_UUID,
 		.name		= "Phone Book Access Client",
@@ -2182,7 +2192,8 @@ static struct default_settings {
 		.mode		= BT_IO_MODE_ERTM,
 		.authorize	= true,
 		.get_record	= get_mas_record,
-		.version	= 0x0100
+		.version	= 0x0100,
+		.imtu		= BT_RX_MTU,
 	}, {
 		.uuid		= OBEX_MNS_UUID,
 		.name		= "Message Notification",
@@ -2191,7 +2202,8 @@ static struct default_settings {
 		.mode		= BT_IO_MODE_ERTM,
 		.authorize	= true,
 		.get_record	= get_mns_record,
-		.version	= 0x0104
+		.version	= 0x0104,
+		.imtu		= BT_RX_MTU,
 	},
 };
 
@@ -2249,6 +2261,9 @@ static void ext_set_defaults(struct ext_profile *ext)
 		if (settings->features)
 			ext->features = settings->features;
 
+		if (settings->imtu)
+			ext->imtu = settings->imtu;
+
 		if (settings->name)
 			ext->name = g_strdup(settings->name);
 	}
-- 
2.34.1

