Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390279;
	b=J6ceZEvSKj3nkS56Y0yU/GDP1IF2txL99Axr4O+rg+dslTAdvx9wMyXH34NueAnZ7Y/E
	 yE9cPzvv+q024zWsQ20WMD2JxAyO1yAPib6OzxjUDqKnPq2NMTUggvqCSSZ044IvXC71/
	 RgHUC2cKDb8oSJCJGUOpPCZpgncpP0ciCh8tgK9PyOICoKJKcmB61ms9RkZrQSihq+SSJ
	 HZYduBs0DVRRe3qwyHSqxtblt9IGA6lHYkyuEcTTplq8KrJkyD41ZH1uaWpK/K0UDi2Qv
	 xBC6cx5anuhk2E49K3HvGQUeJAkZtVGMl0r+9KKRT+KGVzy8d3cBIwZxNnVfSL59wJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=w/aHSqtU+ZIiYdNCwuWLVHpnTBji2okTt4YCUNYEjqE=;
	b=EXYEySiVEeGCE6xB4M/123FdtIfxm5zXqgUgNjqbqraSHB9HrfSB01ENhFqEQnvUZ/AM
	 R5N9KOpFmz6UjkJARvv8fBbBe6ognlEyVnSyDSyWchJ2Udu8utAtxQrEeDjIyyhsjHY8D
	 pXXD9vurFVWZqqCadUJgpTg/TSTqvIhE//5c0ytAlyBUNCCNnKLcrpW7o6sMoxZhu/XdB
	 WpAXNUk5s71H//76pos/Avsmryz4tz0kkB3tZXBFxMoOI9HoxHf1T054M6/In900nVCoB
	 wy0koVjLxbZl/1YVDbhnaV/vuL4wwuHyws6xVTqL0GhF4DsvOWmltdFQeFIIWgxyWVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DUAlgWpr;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD1606A324
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DDD1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DUAlgWpr
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KIom1386363;
	Wed, 11 Nov 2026 09:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=w/aHSqtU+ZI
	iYdNCwuWLVHpnTBji2okTt4YCUNYEjqE=; b=DUAlgWpryUY2gkYJ8na/ZXJ/YHj
	MU9v1b0uMO+rgymuKV4YnxlOb3LMuFDGur9PqzoW5Iw1hKv89M1rAMnteritqv3R
	GXAF+TYn5QjIsM8DS9f0KBQ6Dy97291gAvEX1hTi3mptmtRqCiLaUKaq6PzgPu4X
	B7+i1bOoylzHNfhObVkyvi7pVPETJ9Ocpefo2/2DdFCQezAP+PsOH+JWcPwEvHZN
	Trg0Rc26sawVb7MBUilIsq6qNLyHEnJvsx1CVD/d5PzlD/SMU7ajZ+jpLWGvbjJ/
	UMjGJ0/foO0XeUVc2W//RDZdHO30CMDXdFgwhLuLaOoDE/Sh/KvaKPjgZ6w==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnm9xdw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iYKA2424354;
	Wed, 11 Nov 2026 09:44:34 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AB9iY8m2424341
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:34 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 2D06B23482; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 01/20] obexd/pbap: Fix PRODID property name
Date: Wed, 11 Nov 2026 17:44:06 +0800
Message-Id: <20261111094425.1444893-2-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111094425.1444893-1-jinwang.li@oss.qualcomm.com>
References: <20261111094425.1444893-1-jinwang.li@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: L41FpL75gANvB2xrWgbEPasW86xht1x1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX6zNfFJyFFseY
 2be7mOseauU5AFL2TT8IgRWJtaRzsM6XJVZ9heSTG6hTtNtjHh/oyHvRnDjPVb24LGENcbwWiR/
 3oxTWZcz3W8OJXHHLWUkhJTdeGM0JV8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX4AF1mkkU0xbu
 4/xLfqfo+33zPrZEqH7buhJFn1tAAM//r3Il4w+cWz1VahjUB6uZ7VQWGhgidAYAcWovTM7EyDr
 Ds1d4PBy9/fREOVGzhfiUgLw26TngcCEvqN/BwMxdgNoIqBRriff0/yp/V85MIDUykQPeVqaeFh
 QHXkENQRedSnllA1wM3DoWf82+xNpqDZ1UqMeEw4B6fOakbSIOm7vl8zWz78702ylK3HnNMvkxY
 p4kRmsfjIwLIxa5ROQRoAPGBHS7mdA6vPnBGt3zDsazBtdvjqawjSHYVOwTAjMBzFwUdsFyW4ne
 rKYQdaJd8PqTz+j5IdSRLfAGgqTTiHCrsvna4iN3HF22je5SxBVSI3wJ/Skj/hyzTWqZ09Gs0vb
 IYDVQZynL2Yi1rtYtKJ6x75BjKkbEPGhZZWtBWVtn3+C9I6I6mbztfYHxuIJ/90su5dW8G/QNhs
 V7VCsafD9HlR/eCL+cg==
X-Proofpoint-GUID: L41FpL75gANvB2xrWgbEPasW86xht1x1
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af43905 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=gN9dK6AwCwxm5ZE0OCsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

Use the standard PRODID spelling in the PBAP property tables and filter
mask so PropertySelector and vCardSelector bit 25 match the property.

Fixes: 3a1e6b3e8dc1 ("obexd: Implement Filter related function for PBAP client")
Fixes: 4f805f5e09f3 ("obexd: Add EVCard filter for PullPhoneBook")
Fixes: c8e98708ea3a ("obexd: Add support to all fields required by vCard 3.0")
Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/client/pbap.c             | 2 +-
 obexd/plugins/phonebook-ebook.c | 2 +-
 obexd/plugins/vcard.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 1970d3357..fbd843a4a 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -107,7 +107,7 @@ static const char *filter_list[] = {
 	"KEY",
 	"NICKNAME",
 	"CATEGORIES",
-	"PROID",
+	"PRODID",
 	"CLASS",
 	"SORT-STRING",
 	"X-IRMC-CALL-DATETIME",
diff --git a/obexd/plugins/phonebook-ebook.c b/obexd/plugins/phonebook-ebook.c
index beb72b22b..d8621b8f9 100644
--- a/obexd/plugins/phonebook-ebook.c
+++ b/obexd/plugins/phonebook-ebook.c
@@ -81,7 +81,7 @@ static const char *attribute_mask[] = {
 		"KEY",
 		"NICKNAME",
 /* 24 */	"CATEGORIES",
-		"PROID",
+		"PRODID",
 		"CLASS",
 		"SORT-STRING",
 /* 28 */	"X-IRMC-CALL-DATETIME",
diff --git a/obexd/plugins/vcard.c b/obexd/plugins/vcard.c
index 0a727b729..3827602cc 100644
--- a/obexd/plugins/vcard.c
+++ b/obexd/plugins/vcard.c
@@ -54,7 +54,7 @@
 #define FILTER_KEY (1 << 22)
 #define FILTER_NICKNAME (1 << 23)
 #define FILTER_CATEGORIES (1 << 24)
-#define FILTER_PROID (1 << 25)
+#define FILTER_PRODID (1 << 25)
 #define FILTER_CLASS (1 << 26)
 #define FILTER_SORT_STRING (1 << 27)
 #define FILTER_X_IRMC_CALL_DATETIME (1 << 28)
-- 
2.34.1

