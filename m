Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820024;
	b=isHVSGmTbYJaFAZactvz5FjUfO1o2bCNxjs5jXicb78zDfXiNbvFxorhnnK+5Y6mZjn+
	 Yrv7Cx5QLgSR2Z3qSBDEvMsgCvz+F81TFgfsxQPdLh0bPnarPU1/fB+Br4R4I2yKHEDzo
	 VFPH1R6A5bt4dBSnjd5nnh7G9RZfmY4tj8othJqzAltjsNjtPki72UowIRDzq/RwYTUgJ
	 t5aWn/HJ8anTMyNDsrVzSLp5j+OKB8mup3OQ2Gk89ZOwFVTVQwSj0d4BdrxDOmHrou7dK
	 fkO7PNIlHt3ZfbMmdjMuPno9oyQpv/HxwU/5AM8FBkY6IlsFhyNsCs/FiXSydbM8tPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820024;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=60YbiL8YjKNSy3ZuLIi0mpklF2WzebRBqzE7QPAh7pA=;
	b=d4zsvSbp01qjip+WsKNVM2OfmAfjucWezfym0y4/u4oQJnwDaWWU4edmoU1ADd4LUEuF
	 TtJ6S40yBPwM5drrtA/1OVIA/JabOmOU3MGl8yvQKVbGHQ81ZOeP00CnxdvR91H0yz9H+
	 ewSTjnHjfY6yJJbbNgLZDuiaDJ1jdnwrMogU1piYuP2y5mlboQ9wAe1Y2yIbUaXqqmAD6
	 bdAn9AJS/hc1UTeUOkZHlTgZeyy63wT2dh6HxqeOerL0buRAzypyH+B22RKlMQ9S2XlhA
	 6n7zgnEB6iECgPudmVt8OQq86mzb97vZTJN++Vh4x3QknUFu8tBOCujJj3qmplf+33g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bZb+yam1;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D6606A897
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 791D6606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bZb+yam1
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7ewpi3488782;
	Mon, 16 Nov 2026 09:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=60YbiL8YjKN
	Sy3ZuLIi0mpklF2WzebRBqzE7QPAh7pA=; b=bZb+yam1A7/GZgAav96jpdkFP8v
	Mq4TKwSG3DSdopCVsFMgMUXBu/wqk1GL0If0NAI+KFjUPg0WRy0ah08pm7poNF0o
	DmzF92mvs9mwHmSSG2OjOE1QaqTUoOlUb6bYj50/yLKRCa9ZKZ9dw0HogeDnFXgn
	SvHlIDfki9YnthCxZAsN0aSsU+ZLbhINZHB+KXozm9LeGAQR0pazq1+LTnwZNNda
	zVU8DI4qZfGD4FLerBEBuWTtSBJkrDfHr/+8WANMGVzqjm0vTOir8VPBp+jT0f4O
	+R2hUOEzY/BXDAaZRzYOTi8RsNo2LDIdOeWV8AG3G/mW4LgAruCoKyQPV6g==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmcdmvc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:07:02 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96sd02942728;
	Mon, 16 Nov 2026 09:06:54 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AG96sdG2942708
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:54 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 89D88279FE; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 03/20] obexd/pbap: Fix crash counting vCards in dummy backend
Date: Mon, 16 Nov 2026 17:06:17 +0800
Message-Id: <20261116090634.1222593-4-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX0RiN8X8qjvmi
 zerjJKxuN2qNHlSv8OftuCKsA1iiCCKkWy0eDjSrfwqiJLms32T+a5ZSq6k6GL8FaawdTR/LNJZ
 FUhd7ukJOGOkpQXlA2hyIosne/Dsvmw=
X-Proofpoint-ORIG-GUID: ESd1GYVe6i4X5y4V__YMjTp45FSjMAXD
X-Proofpoint-GUID: ESd1GYVe6i4X5y4V__YMjTp45FSjMAXD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX/oWBY1Sm37qY
 17qTBLRq4id0zs/EFWlfBrq8kD4JEcmOplBXACq32gn/htkZc+xa5jbm1sVAU++sncokgJyeosC
 35N0tNyqoQX1bem3hpG1csqa6l8ee75cQxAlI7yE6Fdc/9K5C3yvtLt9ZVfoeRlTdV8+ebaf034
 GOFwD6xm02tYddZrKeGZdtEgj9/kU8Ch683N57KWUggW0+OkNMellf3FdI8Mu2rkgvQZ5JqIgOx
 1UfqGIl3L/HtAZs+6oSe6NvG4SQxXVwhF1NnOlFtqNcZB918oxls+qhgSBgNcE0HxpWkOw/UAWe
 Ibv293rrnEPy10mktBflAaFO5+TpBJDNLSPTqemY1zOD1WV1le7HfqLFZ5QqMha9z03fjJQPpy6
 bC25Drxej+tbgAL++xPwSoxOGRxkrj1KxVipcdO4iQSp8bTZrqp1nmHqQrhomEr2RBWX5wRMdDU
 rKjgpPj+BYs+mjUaz4g==
X-Authority-Analysis: v=2.4 cv=Vpy2kO2n c=1 sm=1 tr=0 ts=6afac7b6 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VAP3BKsw3AH9pjT3LMIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

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

