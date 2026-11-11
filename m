Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390281;
	b=dHpcJLRTHydjrgTQCBzsJIA3pwXS1/OnEYDNIabJqccwz9UEjvonlXsyUirMX7R4NDUx
	 EUCjguU4ZQ98VwJqWSDV3ZyefNgsQ2y05Ey0jDrginSskuDaufRvU2IFSDpjEtQ2M85mE
	 21dA5pOoow5Q+W75/zqvDgqtQDTeF+Qg6lyxQ8W/px1Db4+S0OQNrF6czVc6dJCoWIzuj
	 wK79He01YSVi9j/JivjWe3ipTzrDcw3W6fipgsfg7onc8oSDIR/DLkMYelDFdJ3nBM620
	 8Ix6PxiKKZPnr8lwGh8C7ug07PyAeXMotaVDwpcHPnFje5gMVlLm8mUF7LHC8A+O7AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390281;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PwwZ24pmv9E+3grE1ALFO+z+b1+yrppFdcs304GPfRY=;
	b=crgTKxsTUVr+/0zEgN/x5Yr/q8WYf1LlzIzeZwUQuSmK1IfX9GFldTddkXot6VXTDhCc
	 mjspiV5bhcus8v1YWCG6udAaLKaRkWut53THYYJA3rJnjeeq8LHY/6fQCCcXyugWctScT
	 qCz9sPvVBHrfUsH2R4RMFrIcYYgxANwIVEAIJGQ6Sy9nuI/7CdFc7rg/F80ONf8Lkbgc4
	 6HwvENQe6aaM7GPMyKLAdJX2/UPdHoM8hurumQWL/o+P/smki8Zy0QVkBvTL7P3SB/NM4
	 /5thKH985tkn/qgEdowDV0OI3+XcJroQkpuzWyr49S7LhfoCDHjwRxHzzlimsoNT9Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gaz2DDAq;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF260A261E
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94CF260A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gaz2DDAq
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KMM12017384;
	Wed, 11 Nov 2026 09:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PwwZ24pmv9E
	+3grE1ALFO+z+b1+yrppFdcs304GPfRY=; b=gaz2DDAqwU7vme19kw4nSx4yxWq
	tjwNgV69vSJaV4w9ZY5yAScNBJR18D9IRMYLep91fmMLpTGtQLnpej1HGUPi4YRw
	4chCI4k6KkKLU2e2JARTLpkKsvjA1RmwChmSHfiDZJTWjVW4YqoS0ewPBsHUEfP/
	37dw8mlOIZ+/FC8kns/LyMPyd/hBbOblL2gCANGbjRFlrSin9JfwYhZS2FHKIdi+
	V9+bEttn+7V26HsQ+jozXv3T529/8QaKj0Xhjfgss+prkFXFP6ZaHiXL4Sa0K7BV
	avVy0+VIA+vClXSZg64fNVu9dl+uVacBi5A2E3f9U/I2POxl62gIE7SyiKw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv97cb3dc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iYGC2424157;
	Wed, 11 Nov 2026 09:44:34 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AB9iYur2424139
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:34 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 312DD243BB; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 02/20] doc: Fix PRODID property name
Date: Wed, 11 Nov 2026 17:44:07 +0800
Message-Id: <20261111094425.1444893-3-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX10iP3t5WXz5M
 pnJ2QjoVG558M8nSacgM24zJfb5cHtOBsm5Q5Vyj0j8JTyS66YBQSRKS3Ibho4XMU43U12QYxRi
 PffmQ52sC9cu0UqiviecINHGi0zFBAAVMiV6wZZwF+qbaErTShZ+Tr6jHa5SzpKTy8v0hTettJC
 VcALwh54Al3EEiyozSZ5tCb+tcPWyhPuGyS3+gQo5W/GIz3MXSxTErFec0Z4S/uRWI2Nle4/+8E
 FRORcwo4YOFsyPv7GLqy3rhd/VELM9AndShmP3ZqfPk2JlRCTZrJehVL53cS5kGRnBVklVFTfbk
 wa0aQhOEpx5wOwKyHisgW2s7EOH9/DBAqJbvZDkyz3qi5Z2GnYKBSvIpKzRakDAFUcB8A2pUA2G
 SR/mCpw1boDfcXztLSxc+BZpQr7pTM4ktg7vfi+9USVknwA62CVWHIM81LUtXknAexeN0rzn4yH
 VjX7Azy4tGHvcBPI+XQ==
X-Authority-Analysis: v=2.4 cv=cJl1IVeN c=1 sm=1 tr=0 ts=6af43906 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=fK_377rzG6kPcQo8kDQA:9
X-Proofpoint-GUID: TecwlmUcDhjwR4tkkiTvN43AV0qGgi3o
X-Proofpoint-ORIG-GUID: TecwlmUcDhjwR4tkkiTvN43AV0qGgi3o
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfXybWVK0hJFGS8
 pMyd6MuTb7TkvEpH7lbNC+t9qRWOgtkTs3rwfCKDWAUpAFGWe0VAGQilHu8XukA65VLxM564KUP
 vzFYfTOgv2Gwd8w2pdFQla3HvyK6mfY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

Use the standard PRODID spelling in the PhonebookAccess filter fields.

Assisted-by: Claude:claude-sonnet-5-5
---
 doc/org.bluez.obex.PhonebookAccess.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/org.bluez.obex.PhonebookAccess.rst b/doc/org.bluez.obex.PhonebookAccess.rst
index 5b22d67f5..eb5142d86 100644
--- a/doc/org.bluez.obex.PhonebookAccess.rst
+++ b/doc/org.bluez.obex.PhonebookAccess.rst
@@ -329,7 +329,7 @@ Possible return:
 :"KEY":
 :"NICKNAME":
 :"CATEGORIES":
-:"PROID":
+:"PRODID":
 :"CLASS":
 :"SORT-STRING":
 :"X-IRMC-CALL-DATETIME":
-- 
2.34.1

