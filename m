Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BBC154439
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323809; cv=none; b=HlYDEP79xWGtAFUT9NSpHFO3lTxUSISzIceiWrFKD/9+ns6RvGnC9OmHcoT+NWfdxXDj+fKZwFsYVxG19b69qxCFc2rdBIY7in4UbZmRKo6iqR5b++yfyZPxA4KggH9LO/V6APkBpQzxmTAfjSFTNAaf0Aj9BKs+m+qdmV61GOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323809; c=relaxed/simple;
	bh=OVBoDIlGPVWvyzHhZ5lrSGCkUCZN/fN6DMH59liHJ84=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HNkUiFB5++aegMPyw/I2EWurVR2kPw4j1iBKnZ2cxwa97KcqtJ8U85MKQX1d8dUAgQkDJX4pzoiQMUCV44w+pGkVZUfd2bkLlFXelaRs6Ej7JWSNfipYrLbyQZfDscXEWPrYvqwmC8Z+GJ7terO4ukn8wTM4Curv0QHlkqRdszM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vtmv4ASm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vtmv4ASm"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAMoqWp003117
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 11:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PSsZJJd+eaRImVgxohDCcl
	5K59ngsn4L1Gcd5PJhpmg=; b=Vtmv4ASmvLQOZPX79qZhu/nKADGDgAZjHh3zsg
	tDd2rawp7YTpRA0S7j3ca9oGpD1083T6MCocbOMvlRfamMzOCHBpejk8rZFknAxd
	CLZnJnKa9exqm4C0MmcBRTv+A+9Pv1M7rRsFs1NBZ+zYQvNRVM4WyODGLLaEzlAW
	lHxR48V8mbdA9uLdPfvObWrjeTuoLvo8IJML/Kdh5veGtk6pf63Lierm5AJBr6VP
	QB70j6JephzjBton6JPOFLt2u5eKWMxhbNudPCodMH2zR7Ln/Ynt/1aW185CXmft
	MJd4WGtZ8rru2RJiBxErYsM6kDj6e/Pey7nJOVtZodWrvfyA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sxr5v3he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 11:16:46 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ABBGjPs005343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 11:16:45 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 11 Nov 2024 03:16:43 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Fix the PBAP GET request in PTS testing
Date: Mon, 11 Nov 2024 16:46:25 +0530
Message-ID: <20241111111625.1887695-1-quic_amisjain@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Tt4hVbEuUEWNjVy6tF-w0s_bFuRX1Xu6
X-Proofpoint-GUID: Tt4hVbEuUEWNjVy6tF-w0s_bFuRX1Xu6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=966 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411110095

This change is required for passing below PTS testcases:
1. PBAP/PSE/PBD/BV-02-C
2. PBAP/PSE/PBD/BV-03-C
3. PBAP/PSE/PBD/BI-01-C
4. PBAP/PSE/PBD/BV-13-C
5. PBAP/PSE/PBD/BV-14-C
6. PBAP/PSE/PBD/BV-17-C

PTS sends all the GET phonebook requests without extra params.
Therefore, the PBAP server is rejecting the requests with a
'Bad Request' response.
So append 'maxlistcount' as default param in GET request to
avoid testcase failure.

---
 obexd/plugins/pbap.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 4175f9de8..64641c798 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -438,10 +438,6 @@ static struct apparam_field *parse_aparam(const uint8_t *buffer, uint32_t hlen)
 	GObexApparam *apparam;
 	struct apparam_field *param;
 
-	apparam = g_obex_apparam_decode(buffer, hlen);
-	if (apparam == NULL)
-		return NULL;
-
 	param = g_new0(struct apparam_field, 1);
 
 	/*
@@ -449,25 +445,28 @@ static struct apparam_field *parse_aparam(const uint8_t *buffer, uint32_t hlen)
 	 * should be assume as Maximum value in vcardlisting 65535
 	 */
 	param->maxlistcount = UINT16_MAX;
-
-	g_obex_apparam_get_uint8(apparam, ORDER_TAG, &param->order);
-	g_obex_apparam_get_uint8(apparam, SEARCHATTRIB_TAG,
+	apparam = g_obex_apparam_decode(buffer, hlen);
+	if (apparam) {
+		g_obex_apparam_get_uint8(apparam, ORDER_TAG, &param->order);
+		g_obex_apparam_get_uint8(apparam, SEARCHATTRIB_TAG,
 						&param->searchattrib);
-	g_obex_apparam_get_uint8(apparam, FORMAT_TAG, &param->format);
-	g_obex_apparam_get_uint16(apparam, MAXLISTCOUNT_TAG,
+		g_obex_apparam_get_uint8(apparam, FORMAT_TAG, &param->format);
+		g_obex_apparam_get_uint16(apparam, MAXLISTCOUNT_TAG,
 						&param->maxlistcount);
-	g_obex_apparam_get_uint16(apparam, LISTSTARTOFFSET_TAG,
+		g_obex_apparam_get_uint16(apparam, LISTSTARTOFFSET_TAG,
 						&param->liststartoffset);
-	g_obex_apparam_get_uint64(apparam, FILTER_TAG, &param->filter);
-	param->searchval = g_obex_apparam_get_string(apparam, SEARCHVALUE_TAG);
+		g_obex_apparam_get_uint64(apparam, FILTER_TAG, &param->filter);
+		param->searchval = g_obex_apparam_get_string(apparam,
+						SEARCHVALUE_TAG);
+
+		g_obex_apparam_free(apparam);
+	}
 
 	DBG("o %x sa %x sv %s fil %" G_GINT64_MODIFIER "x for %x max %x off %x",
 			param->order, param->searchattrib, param->searchval,
 			param->filter, param->format, param->maxlistcount,
 			param->liststartoffset);
 
-	g_obex_apparam_free(apparam);
-
 	return param;
 }
 
-- 
2.34.1

