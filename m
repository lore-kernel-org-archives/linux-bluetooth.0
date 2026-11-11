Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390279;
	b=JxyvCnG0FHmIfz6or5cSAJTPyCAE3gsBArjmzzHkn5xYl23ZCxofzlnp3ePFSVrX0WuU
	 kxivEiP2PzPqb6CKm/43yQiGVkrQSOarvfbjsIuW+SWSGmXquhDKv360WEo5BU3kyVwOG
	 HG98UeDxhw5O4Oy3HV3ePwfYIApyn+ePnuotIYz195VBQ5+LRnvZihs3pUNT1LwGkArvz
	 TS/P3ShImFk9jy5Mln/IH2cdE6GfVkAxG6EYsLR1WmsPcFjuuKWrZMACt5NweVxZ1Fwxf
	 73jbtJp4nMm/2y+oPol9xdAXJIgfWd7AIe1J83qW0iAF/QTeuFtq0oEKhb50QigEU7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=60YbiL8YjKNSy3ZuLIi0mpklF2WzebRBqzE7QPAh7pA=;
	b=hDEOQLbz3XcnnvAWndNHYUkUYJTs5yFjSf0ycZdxA2fTE7KSb+1VbogD7mQrv3xS4An+
	 2cT9WLY2Pi3RFZOF6vmkG6RPC2iJ/FxSdvorDH4ElsnTLu7/oUecg9DYb6TV6E78dcOli
	 ncXrXx5cUIUCs0yvL4Ws0k1LFdZeAlolP3mxRUZTwjPTObE0hIuFIAbKuTDqPM28IOhmU
	 aztzmoQQFJkgDZxpdnXEv0F7t8eppy33UA2YmvJbbc8F7vwIbRRV/QcSOkICbmYEf63oz
	 PKuVdSOMCsIIz89qzVVUEIb2rvb5xzLFZ7McqVjYtEGzHfB1gBBxFPUxkjkkaPJ8TeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Em4loG4S;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D095606A333
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D095606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Em4loG4S
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5Klgf300856;
	Wed, 11 Nov 2026 09:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=60YbiL8YjKN
	Sy3ZuLIi0mpklF2WzebRBqzE7QPAh7pA=; b=Em4loG4SuRtN7HF5cM628TGe4DE
	6wW9LGtK2NNsBCY1f/SpczSAn+HCG7BlKCfl2cZC4tmHOkJ3udtg6RMSiPzzbUwj
	LP5QmJDX2hkv1e6aAuqjAPYYTFOs3rW6cpXh3yLbJLxmnqPhsHu+pti7AQSjE7BJ
	p8QMhpZdrSNRtuP7cv25DTgGC41b6o9bNygA6iUrT4wtlc6wHREHxIW9/R79CJ40
	v2QYlGxBlYPP+ky+2hHeRfX3oW6X0ZISZyPymEwFT8fPEJXchro2j6C20OPCb7sK
	mDDdBWNDpVEsfpwrROFa0wPnlSJcDuVZyRvFOUPsqjrM/BtmI3wv4Lz2+IQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5kmke-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iY3m2424353;
	Wed, 11 Nov 2026 09:44:34 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AB9iYvn2424342
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:34 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 3576D243BC; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 03/20] obexd/pbap: Fix crash counting vCards in dummy backend
Date: Wed, 11 Nov 2026 17:44:08 +0800
Message-Id: <20261111094425.1444893-4-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX0AuqFV8b8CtI
 VZatKYt+LV0wg4NOjUiA0RQ7OoL4J2VswBfxR/0uaBT2ZizHRlNyg5ae+ataPYZPC4fSOQ8h3og
 pjSBHXTDBxR3Rs4b3BMnDlNjsAuul6sJO2G8EmRQiuw/ZgJufuTouJAGYVzSDzTOE9/KBM/eAMQ
 YW54kIovL/kPsjBRfiMDcBzxS5tMEldGZwr3lhBwdZPDI8KXCX8bb/vERdh1CsT0MAzxjQtaKkK
 TjRfzeCDe4XlauAeHf7PdBq7viZPtSaswjYBl8RdjVoriRkF+JQJbiMxMC5xQyuTwJuAS5zTmxJ
 o5OwYyuEki87iU6GgOqbyYKxfgy01dOxRqZm60umwtQHgZwtkkHOQBD7NmZmvLAeBlkdL2D4wrm
 dT4uw8Ng069Dvflp504oalQy9Co8fN+nsJw6gYFB96IxxeSfHGUAUErLCUZGnwLr2z6k8B3347P
 B1tJIEFt6KkC00PcOTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX/HjVgF2yANdH
 e4am4ndIwZT3LjaevG33GgOjH/vL96YH/YBluWjpCrlN6/3iA5sDpX5op752d4qhPgMUk0d8MTB
 oxzWLUw1CnWu2vs1n3+93mbemAt10C8=
X-Proofpoint-ORIG-GUID: A4dF4mIfP46kt1lpQH6dVqHhJ0mkY3oy
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af43905 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VAP3BKsw3AH9pjT3LMIA:9
X-Proofpoint-GUID: A4dF4mIfP46kt1lpQH6dVqHhJ0mkY3oy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

Skip the vCard callback when none is given. Counting the vCards of the
missed calls folder passes none and crashed.

Fixes: f34bc5d924ec ("obexd: Add PBAP PullPhoneBook function for dummy back-end")
Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/phonebook-dummy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 0a0ae24ff..14075b502 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -175,7 +175,9 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 
 		v = Parse_MIME_FromFile(fp);
 		if (v != NULL) {
-			func(filename, v, user_data);
+			if (func)
+				func(filename, v, user_data);
+
 			deleteVObject(v);
 			n++;
 		}
-- 
2.34.1

