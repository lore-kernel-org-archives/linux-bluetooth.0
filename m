Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781280;
	b=TTNw/5MlpXMNZfxbdSUvfaPiCWlJG8qrkU1NsNbzxbe+YczB1JDYOMkMZCmryf9MpNMA
	 1EqZxYGSr4+fRZcZo3llRY4KeH/pe6p2uH/BfCFozBNGfrR1SXqXcmHhY7n2xw524xTYW
	 g+xKL/Cc4fyYZtdXfVwxfj808KBBtVz3GUg9MEM3oI1LYEpX4SwFKELJ18SzfCqp6x71Y
	 ZAS+SdRF3mFNvykWsH5RYHOWAefQWYRPFr7NdQvzcAbe0mL1prFuM679QFVgJ2ha7sAbK
	 DUmcnV/aamSHuBR4suqLfx7WlJctnjeNhwlIJSV+0j63SRtoNqE6FCYP/Xjht3CzNkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781280;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=i7k5dkzs9bhcsn5aw2WwpMgQujfmFRjmu+0bnYfsQIs=;
	b=HoXmn8QonwMr4qnNC/RDhJrrhvzE8hm5kanaC2W4Bf9ypXJLS63KtiHt+KK8VPfYvENq
	 pVtJJp3pOPFCtKcVr3hgHmMEH8udQ0l/Im7D7gD1RNXXaaiLO6/fdbOQtVnSwVul1Psdz
	 XZ5MWFoLOhK6dN7PfIWIbWwxg4dWwn7xn6qjyO8DreW1LzZW2RYJcoojoOwyIpjdiJ1vl
	 dPyBHCANntMxYLOzbjelZmF5tKp/Zhmi8ePaDQz6jdakDaU51+JKsJcZhNcG2oyS1dS+P
	 JuVTXxwWB3YdAd/FglcEcBrTWhuC5o48OVnoaNcxjWXovbALsEmJTbGirjsGMUKd5Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MpukoI2q;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778B606A33B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2778B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MpukoI2q
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48On7Q309849
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=i7k5dkzs9bh
	csn5aw2WwpMgQujfmFRjmu+0bnYfsQIs=; b=MpukoI2qnhX8K7gjbWJIzz2ibPe
	+ICTAIVXcXSkuk7NoMzg7NkczXb6cIgPRhLVmR2/5w0n5ASfajilk4cxiG7hW/vL
	PFsaKBdmr3NdhOJZXm8b66+skxudkv7lgkbg37Wt9JO4XPc9hShkp7DbR44rwZsQ
	Pj8mIFesEWbgFzgUxgwQP+xBXswzObYBoIvO74u9XQnSDq3TldUlp68E8qQYOF+Z
	L66q+3J4BFsii3enWMw9Qdj7d25bfOP8TtXT5vxmh8LC2/+5xKH9DI7S5iQP0Vrc
	7qV7MLHBVhvmhfAWywrJPeqncbSjWneTXlWB/hTzRZSoYe7IBMDUUqhMpJQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr163g17k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48YZp52686401
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6A48Ya6S2686434
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 66D5D279B8; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 06/18] obexd/pbap: Refresh cache for each vCard listing
Date: Wed,  4 Nov 2026 16:34:17 +0800
Message-Id: <20261104083429.4111632-7-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: f9ptqTdngKi3yT-tUU6OGJp9VQlJGmc7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX1u7k5JPpPQT8
 BzomlB3li0lmjfEbCEldpHfit2quISZIf8efzyiCWrKz8XdwTYm0WYdOmxTQHDRejXuNCT5UQ3H
 IhRe+E+McvrthRQXyfu483c2TjJexp4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX0b0wxQHtoOHf
 UXO/VoW5bH8uGXapOgdUk/vUwBK+rbuRxohs0JMo5geGaC2+IN5uWmCjKRxh/FIkeF+r1bkH85v
 //lDVOKR4O2LqejBXMnYcFTVPnCimer2wE1+7Uw9wtPI5kcgXkqild2jgm4Hr7QjG7uYZtADtpu
 ZPfnnuomvv8JCp+ZccQxLC+ghTyq4/f4wbw11pFbqZ3QLjhbwFIivqqxKQzm3fGXr7tYKveUxYJ
 xYjznzTdN9lYTlLzXrlGMWLY8/6iIRAN+pvRpTZmWrDrnt4oZ4B5takNSFEukErTg9FuVjcB0Ex
 650on4QKwuWgGn7oCKAhBI3tx/GYRVu28F2y6hMFIaOCzVOjAL90jfaEwvBjO6h25OuIQNnNJgb
 NGB3aelW3/ppdCwLHiuHOcnx7DNl/8aQiYuGx6zq1HFpF+U/reCbCYj4CUGXwanhjl9jIG0hDbh
 kx3GG949/XjwVxR0Nhg==
X-Proofpoint-GUID: f9ptqTdngKi3yT-tUU6OGJp9VQlJGmc7
X-Authority-Analysis: v=2.4 cv=O5OsLx9W c=1 sm=1 tr=0 ts=6aeaee1e cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=0w67O7jM8qCzAa_46VwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040033

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

