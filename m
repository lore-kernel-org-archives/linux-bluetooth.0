Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390280;
	b=x++1fRz7qFUOD0Ctod3vzmZycfEZNvwAu8ndsFEDWH2wF5zzxOdYSKOPNVE8rHylgmsp
	 yFEhBKFUfy2/1TXW7qt1f1ZHIZMZRQZfPVi4qfsG3j7py4blPsK+qepK2kRsrYRwg6id0
	 L4g/OpN68q0XRrNCO0H95F5CGGNFWH4ODh31b4eBtsvvqL224EC4pPDtqxQt9G5vPtAhd
	 Bo1y3OucPoe30QEM/HP0mT6PLOW40eSzhANz+nC2pBmdnGWU84yWtvuzXBN205gGu264Z
	 YXgv6ydUqFDxQa+nyDHOPRseUVkpB4xb3fSZI3fAwF+gp6HZMKTbW9r7h8gqkQFJigQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390280;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=i7k5dkzs9bhcsn5aw2WwpMgQujfmFRjmu+0bnYfsQIs=;
	b=LhvlE3s+XoG1gfqjSUSCd5PzFS+j1f/PrP7dZd9nyAqsnvm71QOopee8kPfJhCJ60Nos
	 CCrQ4+ae8tKhoWRc3Pujnx2RlkRzTvUMfCWUEJihBHDkgie8mnIVx4aPfrK1IpQvJxaGQ
	 tyabDH5iy2Hbog9/rFZvKI36TMHI7qerfM/yX9f22mOrYbcO6DDZJxpDpXgYz5Ai89mAq
	 Af+IhiAVZtAze63dsa/gnSwxYAeYHyEYPPv/lXRhRWvUg4tWzp1c5iv6DgqNhVLxWQ79q
	 iMyRAny5QE5X3jiwMudYaus5knT2aLiZZJLaFM1siHLw7I+gTAZ5MhL6oOPtKxWCp9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Da5e2ykL;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B22606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1B22606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Da5e2ykL
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KY192017713;
	Wed, 11 Nov 2026 09:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=i7k5dkzs9bh
	csn5aw2WwpMgQujfmFRjmu+0bnYfsQIs=; b=Da5e2ykLPmu4M7EereKvkl6rEeI
	gRVezbOZb4GUSTSFKc0j51xtblVywDcCkDQpux8+kyEIzAs8BC/SxwrPS6M1o5xK
	bgGimVOKLCquCrIzPj8gjPbaed/oei9v0hXHwCBAVebu+kG1/ToTjyPxU6YUHSa6
	pjfgRYy0pvtBKwrF5cvY+QbEUwwJ8sIummkoGCw7hV7yZpgWsgFcloBWa/ZkSwM6
	IY+iyrOsqAhaIlz1/BVHM9ZJGozugBXL2OgxQugKkaB91MDMIrG+4Aq0i2Z5W2HL
	Bi6qiv8+i488XYCf3GadGzhAPf+t0E8Z93s3cC0odV+gItrZUOK4WaJKxvg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv97cb3de-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iZQP2424216;
	Wed, 11 Nov 2026 09:44:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AB9iZEV2424174
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 4AA70243CA; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 08/20] obexd/pbap: Refresh cache for each vCard listing
Date: Wed, 11 Nov 2026 17:44:13 +0800
Message-Id: <20261111094425.1444893-9-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX+Fzx1oSq0kDV
 VExAr5opZYBGfaXAEhCVUhrJBpRnZbqV6PckD5hi6FzALD4nKfklDFeFL46289l1Oyvsje6MLMn
 lIXKGTFmrntViwY3XfrtPCUJcvXcC9nrUaS5qeTvBH4EVFFRugxlV0WvXyk9IoZbC9sk8RBoBEY
 8z8CjL5dWAuzIgYNdo0fSQT8Ie3gUG5M2cK4Uv6cSpv9dk72gm1K518mmq2YMqi0MZehj2Q/Pz7
 6oPQ/EEbWHA7Hw1uNr7ky30XhXTL2/zmcSsoE/Nkvb/4qBm+Rd5UvUl3wbwKiHdJn8hWtFzEvdk
 t0xQP9K4ORuP5ebXag8kKBsX6pX/OFPJtAVDW3F6FMcD+a9ql5yipvt3A/GXBG5KeddkkegdqLC
 vtBsCb9xQVCuYtVVPRuSThPnett4AEocLPI1H4nPj1lWG7H3DvqFOcHFQ7kva498MnHlKq6FLzX
 6APQqkNRlUHl8On9vMg==
X-Authority-Analysis: v=2.4 cv=cJl1IVeN c=1 sm=1 tr=0 ts=6af43905 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=0w67O7jM8qCzAa_46VwA:9
X-Proofpoint-GUID: yFsVCPhmWJSIfNqqtexpqqfc-vzKptET
X-Proofpoint-ORIG-GUID: yFsVCPhmWJSIfNqqtexpqqfc-vzKptET
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX465DUcShDXo5
 DKo36gcdmidg1qdqfswKGzUUhV2l6VmlqsEcUOex7JajqyfDjg5hYXviHtTwT3WZjFqeD843ygy
 n3pTyQo7MWikOg+7HRIItitt2SMTNvc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

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

