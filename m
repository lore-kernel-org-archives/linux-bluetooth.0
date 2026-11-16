Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820020;
	b=BobapO9M1ubimrXMzNYwDuuz6J7ixG/+zRl88fSW4/D9VnSqq8TwIpOCyL72h53KiVpI
	 bx8XcTOWJ7OxRGpfl3Cx3VWJ//ZGIHfR3W7qoHHmHuNSOYD6WigE3L1038VeeoWIEnWT/
	 j7kRYHeDb2M49d9waS/KIkTQcY7Sn72Q1/XVQzj/v66fI5H6uK0b7RLhVcnSE503GVV3y
	 nJpzVx1PRToBNnndcG/kOEkZGWVjdcoL6PyoPqfSnfZ5sZm/DYQ8OiidpT2+hIGd5gNCC
	 KLpp+8oFb/IpF29JKpHYwgDPk2oPIf92ZHrITDIPPPnRq077UxBbO8LChQ4KUNWrHPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820020;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8kyvHvun/dMp5JznRGICSb26xQz5uH9bwGZ4qf/ZMpA=;
	b=cJbphS0n1aUUb3kgQHj9L0EE/lJxHCKaOCbyRWTu4sskJ3mRsWJZOeoaKmoByV+ycgTv
	 DaPptVgz3XBATrq/DBUn0BLlao35btX7MoFXUsw1jg2g3Z/0K1mrdWOo2dWm4fd/KNPsn
	 ITQashGaClDUcg7VR0YndFFi2IhsNsEERrX/Q40G5E+GnRHnvjeN4jp7pFZDEp3CUKWHR
	 eoBP3sYmVvnw1O7ad1YWN/dl9Le2evCVoU8aUSwnSW/8FLyYJOsem0XWw4tBJai0o4hIY
	 1/GoQ2IEjBZAMEFPzLWhi9E6viroNXgcYUVSgpFznWWiHesDb5RDfI2eR0CsjlcwP1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KeLE81RW;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7B606A89B
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FF7B606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KeLE81RW
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7ev3O1110039;
	Mon, 16 Nov 2026 09:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8kyvHvun/dM
	p5JznRGICSb26xQz5uH9bwGZ4qf/ZMpA=; b=KeLE81RW7mIO9+f+2n46/KOtiIq
	AoxYBk71JmVV/MULetsnabp+E7cIRWJgCWw886nJcAwMPdwtKkXZnrGMByCQBODe
	0VbQdTM0V0pB1z3hc+tyQI+J+zGGy3FhUpcyOVWe+5swUK/qORoHqvjK1m61Sh8Y
	3iBXIFyVDfSam+Qts6L/PeJtXwuCOOCjjKihS+TsOQ9LYpkzVA1g0uLnjlwCUHl5
	T3CJcLeSvtt+vrkjrmp+YNP7KFfKlfndhJm0EOFDIwIML9gEvCto8UxHjuQ8dPEY
	3GTDgdH2eNYwl9nkOtcEdNbTd9LIoiOpexFhanKH1OtBWMxNHhXySui6Y4w==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyrmc1d7w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:58 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96snj2942810;
	Mon, 16 Nov 2026 09:06:57 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AG96uoC2942916
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:56 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id D27B827A0F; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 20/20] profile: Update PBAP PSE version and features
Date: Mon, 16 Nov 2026 17:06:34 +0800
Message-Id: <20261116090634.1222593-21-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX4eqWksM2SrkL
 ItYUzuAylpGfKmjdvN2qAA1fczsDgtsVGry5QUJpliwU4MMoSyTv6OjX+uuzogf16g/EYAWntto
 G3XfIC2EYepUGHMg8JZ9Q89jf47X9vQ=
X-Authority-Analysis: v=2.4 cv=C9N8WgP+ c=1 sm=1 tr=0 ts=6afac7b2 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=3kB7jyYCzrIlwtjniwUA:9
X-Proofpoint-ORIG-GUID: YMf7xCOh_WMUdZ0x53XskSi6bbeeYVJx
X-Proofpoint-GUID: YMf7xCOh_WMUdZ0x53XskSi6bbeeYVJx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX4bcwcyQSuUXd
 rU32wbQsZbhmGNz4+GEWKFFerFNkPxrzn2SPAw62CE9qrzIwHC3UTPGhxQisZ704yKy+lpvozi3
 E2gtZ3RjUbxZsZ9RuFVKl7MvB0bI+ATTvADaik1ak2BJVM8ZR/0/ZLbUGkcXWyvYTu/QY68MrOK
 U4I3+8mk9Q9ELuBwjnd5IHV+SevoI4DzOMvh7AiNLco3nfa5fli+ihzYsx9D9q9su64v2i5flmg
 osKBa9+l8VCstUSa44xtjHvogYn59VbgOeZTMTIY6/BYJKGiRaMClHLTS8ishGE1TRrKl+1Epv/
 23Npmahs6LaAjBmmJdwHfGuebQcL3E/PIcnMFnCKy92Bmp6S24ywU+9yKRU5WaD/FVe14290P4v
 TG4D91PJnfkQxd2JtUQYaYIe2UbFwc3xKqgwetOfj96R0/1JomWmYhkHgaFLtqKCQ6krShppDRg
 td3izAyt1Vmjyp/ZN4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160036

Set PbapSupportedFeatures to 0x0000021f and the PSE profile version to
0x0102.

Assisted-by: Claude:claude-sonnet-5-5
---
 src/profile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index e5b1cdfc5..d9dc92be5 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -469,7 +469,7 @@
 			<uint8 value=\"0x01\"/>				\
 		</attribute>						\
 		<attribute id=\"0x0317\">				\
-			<uint32 value=\"0x00000003\"/>			\
+			<uint32 value=\"0x0000021f\"/>			\
 		</attribute>						\
 		<attribute id=\"0x0200\">				\
 			<uint16 value=\"%u\" name=\"psm\"/>		\
@@ -2208,7 +2208,7 @@ static struct default_settings {
 		.mode		= BT_IO_MODE_ERTM,
 		.authorize	= true,
 		.get_record	= get_pse_record,
-		.version	= 0x0101,
+		.version	= 0x0102,
 		.imtu		= BT_RX_MTU,
 	}, {
 		.uuid		= OBEX_PCE_UUID,
-- 
2.34.1

