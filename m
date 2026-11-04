Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781286;
	b=ARaa8K3PqqQKe1Vgj6iU8b5lZmNFuH7giBKTbRiuLKHcbZRMk/1ckM+N5wy7d5Jng9G9
	 bfOgx8nzMf28xpnCXYadme7zVd6eBub0UItZTjiOJh4gTZiIwb52qg5QsgrAb12opVqmS
	 Dj9/6SI23MMwKyHCwEEAG+5pmuH8FqW/NG3OVFbtL0VNakSYra8MByrx8gEI26GyZVeYn
	 5nwJayBCF+N6Z0S7TRkB39/PcuvqKoHA2c8sUWX9YOBUKI01t8xACAwwJvQBx/Rg2Ahr5
	 quVWM+g1PzMTXJ9OEBSyZRMXva2k/dlG72I0fxLMxsuFEP5H8jKCY1/JZwIm+VtbmuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781286;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=lQT1WX9a8tb9weAtGjd9bd0k8x44tGD102UfrnWgnFs=;
	b=Oe15v1ZP/02vEGE0c3JoiyFeYneVf6YSGRX9oCFjtF8wynKFUmZoZ0WDlIC2FYhNYb1E
	 dQXNK3/i6gm6AbNonfdD3hXRs4gdAzuMjZszkskFJbzY9FFGsX6MaJ4cqaceym8Hu+BU8
	 dQqVbhsqkwb6yLKd8RmPUh+1HmP+NkmbrKJ1htunYSQ5ZaVwfwWRvXz1J+ZmD0/dPA83p
	 faQmzmxmOGPuqYCQmahTmzDLjQMbBYzBP7H2fnmqQKqsiIFYXkSICJnDdRDMBR01rkRRl
	 vUsQprq4wTZN0an/JMzgcQEjg+pxkW7w3S1ThHwMVU49KDqUVF2NdUAWc7zYdxhDVnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NoFMG4wn;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62678606A333
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62678606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NoFMG4wn
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48Kev31263929
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lQT1WX9a8tb
	9weAtGjd9bd0k8x44tGD102UfrnWgnFs=; b=NoFMG4wnspIlzhyZptQfttuod5k
	Is7N1l5UzxBfG2JtBxTYPwGXX2Nuhzb6p3dFSlEVgdS2Rr59F9sN1W3htkxoT5ir
	uSk97WBT1NZfy7FQ4vhvSl777jYs+dP3GQXdce+Jmmgt18lS/LTtYTVV/Ne+t01M
	aMXghfFu7UrULh4b2dIwa/nK/03tuqu3oi2z4LzpgNe7HGYnK/BcXYI63GWs14o2
	7fBpNeP6YcAxJKwqfHbukFe75Y+o5lfCXpobWiEbstR8dUZ9/MgONF7pMXfh4txP
	RjVxfQclzxllsz8G5IwZEsLlFeTICXaJCfOgOjNOkKAucbQ0zFsHdwxWBow==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqjubkn2a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:40 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48YbUv2688080;
	Wed, 4 Nov 2026 08:34:37 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A48YbFO2688071
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:37 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 972EA279C3; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 17/18] obexd/pbap: Advertise Contact Image Default Format
Date: Wed,  4 Nov 2026 16:34:28 +0800
Message-Id: <20261104083429.4111632-18-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104083429.4111632-1-jinwang.li@oss.qualcomm.com>
References: <20261104083429.4111632-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX07Lf9vuVyPnt
 OJjrYH8CEJGY546snJw7afjM1B+8QWetimkYi5MY+zHKwwxi39n1EN70h14tstAPmBRUI0Gu1ag
 jWEJqQhRztmECdNU/KNCz+sR7e9dZPg=
X-Authority-Analysis: v=2.4 cv=JeUpPkKV c=1 sm=1 tr=0 ts=6aeaee20 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=8KJYqU7MDh96SiVncLsA:9
X-Proofpoint-GUID: JyIk-ll53BhGGZ3ii1BGCqjWe32GLYTq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfXy7vff/n9UvRp
 1PVsLspERgX0/mjGDeTwN4gmHDbXP9SZl083TLfGS2Gru/TotRxAhqZNTWzHm5YJxnnCeXWMruM
 EARs1zD0zrW2jIO8vhjZBVQK/eYnCtg2lNtN4BFrw+eHe34z9QE31AxqsHYzIatq4nixolPzgrA
 D9Wk77g8jG/03fAINqpyvh46QEPD9ne6JFpn7kk9d4yUe0atKbC3sZgGW/SBNvzfR/2/VVPa79U
 deSeadA4fjuBWfPAK+GvW0AhdSUpAL7H901WB2jeovC5x1K6X5GK9cy7K7ua/0jWsYcxvntLbs2
 ktpipLDxuS7HkWc0decA/Q2C11xmlSKq8VnvB09xIuZj1XjejMIqnSbVhYrYJ3NPfsE4K1zNd60
 3EC9/kCDM5yQkq4L8J/zgdnZfCK4RCHB1m9axXBtmf4NhVSIJPMeAMrvEXPoK43OMqEIWfkoSi2
 424Lcds7yVBhlHvgEpg==
X-Proofpoint-ORIG-GUID: JyIk-ll53BhGGZ3ii1BGCqjWe32GLYTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040034

Add DEFAULT_IMAGE_FEATURE to PSE_SUPPORTED_FEATURES. The feature has no
PCE bit, so it is advertised unconditionally.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index dba05b038..fef44ce73 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -63,11 +63,12 @@
 #define DATABASEID_FEATURE	0x00000004
 #define FOLDER_VERSION_FEATURE	0x00000008
 #define VCARD_SELECTING_FEATURE	0x00000010
+#define DEFAULT_IMAGE_FEATURE	0x00000200
 
 #define PSE_SUPPORTED_FEATURES \
 	(DOWNLOAD_FEATURE | BROWSE_FEATURE | \
 	DATABASEID_FEATURE | FOLDER_VERSION_FEATURE | \
-	VCARD_SELECTING_FEATURE)
+	VCARD_SELECTING_FEATURE | DEFAULT_IMAGE_FEATURE)
 
 struct cache {
 	gboolean valid;
-- 
2.34.1

