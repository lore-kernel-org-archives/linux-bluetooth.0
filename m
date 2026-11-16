Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820019;
	b=prCpF2IvwPjWyL1kCPEagyt4tJGz+K1cFcVeinS2zkGDN6p2LD43rwn+ZGW4gyPyHI+a
	 mObb0ORpwFLEZtCMcGTSj70nrVdT5K9MgjXmwOeUaksVsAMssoJ3E/P2NO8GYxnAqmF5e
	 hfzWy3qduUzKqw7NK9ZRkAwk41ToskV2mrNJ/A91rW98gOzzYEpjeeQH+c6cDDiz+3yvO
	 GDI6zEQOHfyUMDLcL81f79pXbiCEE/5NJPtrEkQMsXC1xQILvKs8KG6rbAQ2/+GF0/NcD
	 rfv2GqNZHxv7XKHExLQPzp2mnxgjAR/otzTUSM0shTk5U9tZ3X1N40bqGR36dDY1Z6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820019;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=w/aHSqtU+ZIiYdNCwuWLVHpnTBji2okTt4YCUNYEjqE=;
	b=Ee9SiXS9lZ7GLjRBY/LKiAQqocoyh4iHnms/6YJ+Ly9/WgzXdv8XWBlBs86LMiicX1jd
	 GRnBOomMXsG2wklQe8bNXmg5t7XjUcyXbghPo/Tmo2MCMuS1+KQUhmtQ9mQLVIZkWTmga
	 f89EP69xWnyZc1jgmmMnV/OAU18aOp63aCwhn63uW4Osv1y/7CZf7phH3rkT8FjtU57ws
	 +UGi7RBFrOd+zrxJ0mvVcd7D/sGc+sqLgvFFMvCri6xZvw9tAccJp6rCZW/jwUuJSphCx
	 vBZ1eBxi246ywXzzF09pzF9J+wJTA/Yir47uNAGp7ksrupBnHECts9JteKXPHP7e3Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jmwuHirv;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68EA606A336
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C68EA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jmwuHirv
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG8Tp4R2650609;
	Mon, 16 Nov 2026 09:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=w/aHSqtU+ZI
	iYdNCwuWLVHpnTBji2okTt4YCUNYEjqE=; b=jmwuHirv0qPDU0nFqnFrPuojlhe
	Ndxvupvbv/Gez0imOr/9Qur705JKLkL9toDEJ54KQmNy2RMgkt1FC8crqhuudU1W
	En4BgWAEmsHN8d6+c+Q9p51Ap11Pr47hVAUBk9G9RCqkVbm5rsyyiSLEcDQGKgh5
	lhZAEwQlH39VTRjj3I7UT7r3QzjcO4Z9imLgeW9XbMzzhSdzv1rkoltI6eF+VeiC
	N/UekMWvqWleg408CGEqfrIbfvVSlOdcUzCTaU5KyUyNvomNvfRTONbd2xPnhcU7
	yawIBPYvSeomgMBzzEsmyK4nFuUDSNgjdBxMdSTqJ32T9HYPBA51hwAah4g==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxcf04c0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:56 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96swc2942824;
	Mon, 16 Nov 2026 09:06:54 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AG96spe2942793
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:54 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 81D4B245C9; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 01/20] obexd/pbap: Fix PRODID property name
Date: Mon, 16 Nov 2026 17:06:15 +0800
Message-Id: <20261116090634.1222593-2-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
References: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfXyXQR0jaIPv3g
 TWNFXVJdJAjw1H0wiZCm7eBNOX65UYiLrXTcTi3lupk314cPi+Wf8Zf8CcroCMI1Z0gBj6IRwWj
 FRnzgo8YrepvSBpEMozGaa3whIzApmImM0mC3uoJdxx65t51OQLfzryFIYA0/vKpcZm5JWaHoN3
 l5TZXk/ypfylNr+AyOvjWR06N0ie5rX7mytT2Nx47p1Se91R8sumxTf5iSgPrfqSHJtR1QbqzZM
 J5GvXbOGFhyMM4r5kpfqPdaXdnSOEh/oRYQMsyzts+I6HHWlB+6gX8xcblSJfxO/0GdLds/9uNM
 6IUdWJFRCLTSoGDNzXKXQRc+FVQYChBOGvhdkQxOEp1A6/SAEJrc4vXuZV+9UhBgvfj8g+QCFVO
 P0lsaOcfNAxb4CrrCyzQTCVzrQLlcA34ThA+qrMtJ66XusnyqD5d+PGYq5VZD/uIevmbeYOA7bi
 W80fpzW6tOAfk5LjRmw==
X-Authority-Analysis: v=2.4 cv=RtZQvymK c=1 sm=1 tr=0 ts=6afac7b0 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=gN9dK6AwCwxm5ZE0OCsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX2RNRRSVt5orv
 JtGGuPj+aH7ZSHKlp7c1dUNDlZtagPiMzon7lfF1OKzD2ogXEp63b8DVcqt3CwSATPWhQl0/HWi
 Vabx6h6yPOa+kTg+sS/+evPMCuJcEgo=
X-Proofpoint-ORIG-GUID: qq7lB-vh8kG4qXHOaBrD_SLSYJoBhyIt
X-Proofpoint-GUID: qq7lB-vh8kG4qXHOaBrD_SLSYJoBhyIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160036

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

