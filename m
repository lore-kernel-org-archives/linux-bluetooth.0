Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390279;
	b=wrqm0c+0OQb2AWrLq/iS0RiVilVkuqHgymWYlHPwonI2l1Lr/g5yuJpkOJISxpX/rb0Z
	 Kb99uJbggDWc/lfcuwCLAjs8ODdszPu/LXo0o7VLWYR8LJThSvRQ0MsP0wrPYyJY26/S9
	 j/bDy/n/OqAPQI7T4n2ddlOUAEf+RjXcROgLtumnDStF9BEf5B1RM9p8qPMT1ims1yDH0
	 5TpaL0XpX+thYkvB/To6BdFp20jL110Z5l7LqfMzG+CfRwEKMuu7jKkRnBOXYCGar8heG
	 qkznWKok/w9BbPi7qqatloGaouCdrNF8TgZwOkCBtKTo1iuPE+htOv3qOaV3SB44Rwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wqp8/eH2TgHBG574tI4yg0fKJ3ptLqR4+grMk1//fg8=;
	b=TVWMag/OX2G0nZujP1dwrfAKmKMKbq4PcWYiUPeRE1ULJoZ1AjLBPh2Z3dpoWudfFuji
	 hX7lUBEe0bGGM7Y81U3ny9D2mRyuiD3d09CoZ/NSioGUHUskefgTfiE1lrwdZhQFhpo8h
	 m1AB2RWbhpxp4F7m/B6aXd/G6mTHqrGzMTSESunHyXDzT9rWijNe56e8emp2kzj5RzV5D
	 7Sk+7ZSp3iyDRCLmWR/0WzCw5WAaJR+84dZHLmf6DKBVfZLmguEHyKeF7tlZt2vPh54ly
	 QJLOKOoYtWkCnwtkRUNvGZE9p1kwNOJi0Cl7vS/rFZL/NJAU1mrlUhX/GjlVBJUf/og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IOtzQ07e;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1683606A327
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1683606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IOtzQ07e
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KIJL2350799;
	Wed, 11 Nov 2026 09:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wqp8/eH2TgH
	BG574tI4yg0fKJ3ptLqR4+grMk1//fg8=; b=IOtzQ07eH1//fu+e9cFYi4aAS6G
	rqK/BhuM7gZds5n387OBm8VIJ5thmhC1wGIJNkiWI+Dt6ITIHS46GTJFMEy0ierQ
	NOsEOUr/aL/caPGHV4ZkCsDXcH4l6AM+5x1+xZvSLz1DTF4A9+oImWeq0rWRBOCF
	PHd6mo7MxGYGVDEiAKXMsl/zrVotTfLGt/dpRCzTuFs0HqWB5gKLxnWpboZOvtEv
	8rNQu2jXqEnqkRHEUgQgnJDHA5eswHOEepejqon5hhRG87BD2qJloVWaFvFUUL6B
	pz/PGml5N3jlVY/Cu4lwmu3IxNQt4fvt/6VCQDNJzhmjP8y6YVvWy0995hQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnp1x90-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iZ1i2424220;
	Wed, 11 Nov 2026 09:44:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AB9iZdk2424176
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 42515243C8; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 06/20] obexd/pbap: Reject PullvCardListing without Name in telecom folder
Date: Wed, 11 Nov 2026 17:44:11 +0800
Message-Id: <20261111094425.1444893-7-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX4dXbogyy1/20
 X47eHIYVh38k2u8Zr+nZqQmtqkyPuu0l4wcDMdMll6MaYReoPhi8/PO9iD5Q57cPgxwWp8Pmfbk
 KQI7rKvZQkf0ECB4fN5GGI/7uyIxzCnbKpXtPE4cm9cVqPXUkQGST7RDwslTZ/sz9Xo4D/cjiwX
 K5z9Mq7r6BJUSFvSeukdzsKbEHV4433061mMwW+OuAP0uX+etRDM8GGGK9pWZVaM9t0ITpP4Kdu
 rasSb1FfQZOXmpn15u+NzVtAtgRXKUOI1fAOG/i0lAMBbrRqvzZkcvyJXuup5D9lpArHsc3PDkF
 aVwJl84s/9Qhsr6zJsBHyStueVPmcWTnk/MZt1poRyqscrSf69aK8M0FGamaP520lRpMHvoLWnP
 rzbyA7dCfqHP1Uf9fAhYMdP23NzOOe62HU8HgmVP3fzhOWdnQMhf+xr0NCNjkkxDDELyvGEsA8l
 t5Detp+ZZd1eYxDRnsw==
X-Proofpoint-GUID: JLY3znsMEZAW4Ny1w9n2jWeVth6w2Z3f
X-Proofpoint-ORIG-GUID: JLY3znsMEZAW4Ny1w9n2jWeVth6w2Z3f
X-Authority-Analysis: v=2.4 cv=NK1AaE6g c=1 sm=1 tr=0 ts=6af43905 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=tXj-jVEF51iBFPFnddoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX++FMiuNIMsTz
 O+URMXXjCRxYPSbRKMbmvSltF05z6eX8g0EYiqVqXqzBXaIV9lfdiIH5Wm/R9URBLqueSNswSWf
 v8lw2/a8u97jRjBMoig4hoVWNbNa7Ts=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

Return an error for a PullvCardListing request with an empty Name when
the current folder is telecom, which has no vCard listing.

Fixes: 2e2c48dfc234 ("obexd: Initial support for mimetype drivers on PBAP")
Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 3ee54f1fe..436981a4c 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -544,6 +544,10 @@ static int pbap_get(struct obex_session *os, void *user_data)
 	} else if (g_ascii_strcasecmp(type, VCARDLISTING_TYPE) == 0) {
 		/* Always relative */
 		if (!name || strlen(name) == 0) {
+			/* telecom has no vCard listing. */
+			if (g_strcmp0(pbap->folder, PB_TELECOM_FOLDER) == 0)
+				return -ENOENT;
+
 			/* Current folder */
 			path = g_strdup(pbap->folder);
 		} else {
-- 
2.34.1

