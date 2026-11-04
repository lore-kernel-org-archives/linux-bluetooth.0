Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781279;
	b=ndXbX3cVddiFA/5lqdQvFK4yNs93hA3g9ZdoQgvgWMPnnaOauBAZ2b4AeXdr7HHYceYD
	 /Xlm7SxWT/LBjL/uccP47fExA/U4PYwWTAyKXE5FI7Ag+GKCWmQNByXmagXa2st/lyRB+
	 pPELj5TKjD5JEAEktEAuIa0Ri38kSXrDIUZVXx0rGvJMEjAXaXtillQOQOlQjmLyZ9FYW
	 6CswlDS2cOWW04W3C6RLCQQHI7/pcOxI7oedQrM1ophS1Cbff2wMEvLJIvDK0KCcpsn5B
	 0cOuaKkNcUXcMdI5dV5kb+lYlP5NyMh0ld0IWmyHjeqjGsiDXwmFjRrI+HuoWIKkOkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wqp8/eH2TgHBG574tI4yg0fKJ3ptLqR4+grMk1//fg8=;
	b=bZc+1TsLFcD0gifbZfz3kyy0HL55tqfJimxOnjXzloNJrQBS+8KUcQxKWTx5XPKnlN2l
	 AUKCoUefvTz4EflJBPHkWw+oRNovVjuvS5yWt6O19GGF3l+0kQgQOp85/6O9QD+jAJBCt
	 Fsa7DcWvHzLwpYjwM0VO2C9ELuwvkiW3zOEe3eAyHK/jWc5grGh5KpB4qsGH9P256zKBG
	 8y3QN67dWQMiF5L+PvVfRh0ty7xYpuHnfgj1eaVRT5Rot/LZx34iorz70mEs8h9krs1Ir
	 rOcargLxVD8UyOkix6HLmvV6QlVVxIGrhWXPQi9kyfYEegkwCCzBLtwWl/fL+RqMRtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lvB5qISm;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EF8606A336
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5EF8606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lvB5qISm
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48KNGl2290379
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wqp8/eH2TgH
	BG574tI4yg0fKJ3ptLqR4+grMk1//fg8=; b=lvB5qISmm0tVUfzD4lhfw4skD6G
	ZPgND0E3SkEESyLjTEV8RvfPsKMgL9QEAymDWxyyIkE46DEE4kZSeFUnJozoa/ou
	2iRex9yAzKle8DJyuixukYem+ezOugF8HiQYFnzJNUeRqkoTBk0sHAp60phVKfpi
	1oU4ewCCiHX3HEM77sVimNfZxitcQd/q/F1b2MgbLvoaAcy32iFixtdzfx/NAx6R
	p45kkWXp6irS4hhHt88wjJWZgLkmEoAO99k8++U7dCpyf/mgPPeDpUXPYQIEgAY5
	mFFa2uCpVJcatEelsPh/i2oCKeoW1UpLBEAeugOutk164ht1PGGpWrNRyiQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqpuvadqq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48YZQf2687993;
	Wed, 4 Nov 2026 08:34:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A48YZGV2687985
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 5E38E279B6; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 04/18] obexd/pbap: Reject PullvCardListing without Name in telecom folder
Date: Wed,  4 Nov 2026 16:34:15 +0800
Message-Id: <20261104083429.4111632-5-jinwang.li@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=O6SsLx9W c=1 sm=1 tr=0 ts=6aeaee1e cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=tXj-jVEF51iBFPFnddoA:9
X-Proofpoint-ORIG-GUID: 1ys6a-3l5ExDhOPW7jTvh70GTIfi3yee
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX3zP/RuWrJxta
 QtBDQx2IHcf6+/YBP8mU30pexSnYJtKzS9+JefAtfj1K+vtGE0GyYiI1P/tFCwg1RMYU8B+hyrm
 HKGukc7jtgT6YoafiASialf/tamgoFc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX3w1Ip89SRv42
 4qMNaiBxABaZj0Dwpt18xajTnRLz47AAb7g3yN7iIOB16xHrYzUWmhzFGQGBtpjBGeDvwjsmcyF
 xxDm3TI/VYQz3NfdH23pQPcpgVBXA2J2Js/WdEv1elvoG+I/HsaXoFzJ6tgfChNPdtIeqzYKJSt
 eejE7oILCoiLTIGBDHRZH7D8xHd6HOER1EqwohhnJBXYBiTvrkDeeLar5A86wX7DXPnjZSYqvOW
 AEvmxheBP9LBSZE/dqRA+L0GeOZiWt7PQag0CLGTWScYUsTFmMIxS+RRPBt9RhV88DubW9qroDh
 b16JIKyRevLh7G/xPN6D+Eyg67om/Nx5+CpMGRv+pgCKdDdrtwUr+7/boIyx/M2+YEnEcKfTs8x
 G56fhIjkXV+Q9XiIInc+d0H+PsrqlLgGVvIIZnN0JIWw27Q4B5KgjrI/n4ViPin+hnLf84JMPcC
 b/vO7jqSJipiRJSwFIA==
X-Proofpoint-GUID: 1ys6a-3l5ExDhOPW7jTvh70GTIfi3yee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040034

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

