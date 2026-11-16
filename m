Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820019;
	b=e3AeZq8ZnZ/EIAGG7v8clLaYLWeOKh693Dis2hvA752n2VKC06JtuYnM5mR6DU4fGrGc
	 /BSi5hwDnnig6VZwlEridJxRb8ANwvvh5U0hXqatPfXwAZBazsF7ULTAp99HYe3VXkOnb
	 jPt902iagmdx3/s1QmrAayviihkz5KPfPSEd6gWJ1Y9cnV9m6HatWTZc6KFf8kcDBwT+P
	 zCA0AouJWlcrL9dpoFAhtf0dcFHELASc7/xDh5lte2/HqXmtqUF1SsBA5UuTr4G0zhsl1
	 heU1RhI4wueM2ENcCtHCJ0Hed5ORTFkqYrycMMmCj7uV883Tng1UWg/l45rQ84biRTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820019;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=i7k5dkzs9bhcsn5aw2WwpMgQujfmFRjmu+0bnYfsQIs=;
	b=kgfmqVCGI7zuEoScR8dZOqmTIoucjk8z1cFLZsG0kjbTynnHzQnpWUTPK89M92UYxr43
	 W311Z+Ahxfi5wK+KOjM42vM7+OXPAPDi1LpuTbjn5mNayqGGZTqcpRLbXu/VuU13S31AR
	 rSWNYIs9Vpl/VbJACbSAQw3s7a9h2Jme1+MR0k8zJ4IY2hgCzEp6qs7BXZ6PuyqXiB+S/
	 Yx3oCCoOVfnhZqyxs0ts0yKuW3NjVVv03GQ3oG2wZZIi88AMe6OKSyqYfQcpxrK7gdZ4Z
	 Tcw6zgK02+PbC3izwm2T0YuiNja5Z1zkGfUlSyAbcl4oBMKOwTmbb6Jj3hLHi3S9sIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sjz1iOs9;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D9606A33A
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C94D9606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sjz1iOs9
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7ergn903109;
	Mon, 16 Nov 2026 09:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=i7k5dkzs9bh
	csn5aw2WwpMgQujfmFRjmu+0bnYfsQIs=; b=Sjz1iOs9hchHi2hEUUYdb+MZJ2B
	AJRDLyhkRr5yFQe03XwiCHJP8kYkuKflBHVAzlsWDpZ6y9b+EnrNiAtSUR73VL0s
	qdxgJsOUYoadgATJBYd67WLygfR2+8WQI8aziEvhSQvomzcqEE1hObHnB9nA1ZHD
	hl6k1hBmNzLTa8rG2eq4+dfv6FTq+iO+wB0SgpfMk0x1pJhaE8E0qbMR7NwzCWIG
	IsDp6VQV/eGcBNIP8LU+ZhQJjfAq/jQeQ/bVrfSiim3ovlCRujC7l+2GdDzkv4yc
	AqM7k0+wYNyxfqXhHGDnozj4pTvIN7HQ8hqLo0Xx3Gek/q5bdNHfMCuAKwA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjwr8j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:57 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96tux2942871;
	Mon, 16 Nov 2026 09:06:56 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AG96tsA2942842
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:55 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 9E81F27A03; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 08/20] obexd/pbap: Refresh cache for each vCard listing
Date: Mon, 16 Nov 2026 17:06:22 +0800
Message-Id: <20261116090634.1222593-9-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX1R0tgetVgE6H
 T0Zz3nTBwQwiqGeeCMFdgoht+0oJSkrxx6TzLSjpeFA8tKhIavwmAQImG4CifJqn4skBl8PLSWR
 38/qMefqbgigeabcJA6W1kaFSDakma7BOMbvPcttEAHB7bPXcf51bae4+YuLoRrQHYG1KgNFwu4
 6++1O5wchl9IRpJ0ciLaPZe9xufrFBTebXCjNecz+r/oA9/zQbtwAP1RmPKhLnLBw1yPETEjaUy
 TCEt6slRWz7uyQGKX2Ckhysrq1Zt0N25D5PW+hQOGCJG8wcVs+ExHf3/ObMfXP7B09VhkXlRVcv
 tIyZlnHHCxLD47BI45g3auZe/x5BmSRtKSMJ+U22J72ZcCJ3LO6DeBRAhrwjR2m68O4D7MgsPYX
 nMT3MH4Ylibvu3U97ahZBVVq4dl3WpjRUhbsZlQkYoOhXqFARd8mwasxyOsQv7vvGNjdlToo1yH
 De83zEWS9ItkZhqDjlA==
X-Proofpoint-ORIG-GUID: ORSLABk0XeFFMluZMjDLSORrJCd-ujtA
X-Proofpoint-GUID: ORSLABk0XeFFMluZMjDLSORrJCd-ujtA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX6SWmx94KMLEj
 6PCt6fHxA4Mr8tSMey9gU0j0oYebHT4d+Qdgq5Ui5g/qXgGARmxkRCrsAZH69w9FTS4TnBNS778
 Ug2wTqGHZ7ESQ0prk60MlvSzGG93oJY=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6afac7b1 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=0w67O7jM8qCzAa_46VwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

Rebuild the cache for each PullvCardListing request. Return current
folder entries on repeated requests within a connection.

Fixes: 581b305d17b5 ("obexd: Changes the interface between the PBAP core and backends")
Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 436981a4c..9176fc92a 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -735,7 +735,6 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 				void *context, size_t *size, int *err)
 {
 	struct pbap_session *pbap = context;
-	struct pbap_object *obj = NULL;
 	int ret;
 	void *request;
 
@@ -751,29 +750,22 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 		goto fail;
 	}
 
-	/* PullvCardListing always get the contacts from the cache */
+	/* The cache is rebuilt for each listing request. */
+	pbap->cache.valid = FALSE;
+	pbap->cache.index = 0;
+	cache_clear(&pbap->cache);
 
-	if (pbap->cache.valid) {
-		obj = vobject_create(pbap, NULL);
-		ret = generate_response(pbap);
-	} else {
-		request = phonebook_create_cache(name, cache_entry_notify,
+	request = phonebook_create_cache(name, cache_entry_notify,
 					cache_ready_notify, pbap, &ret);
-		if (ret == 0)
-			obj = vobject_create(pbap, request);
-	}
 	if (ret < 0)
 		goto fail;
 
 	if (err)
 		*err = 0;
 
-	return obj;
+	return vobject_create(pbap, request);
 
 fail:
-	if (obj)
-		vobject_close(obj);
-
 	if (err)
 		*err = ret;
 
-- 
2.34.1

