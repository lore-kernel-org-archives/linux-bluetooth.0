Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781281;
	b=b45O/ItIafucFZODQ4+f4XCO1pkBAI1LEeYRgqzsEYOIixg4LTfZGvqufzqpyovmRmOY
	 V9MyjGeAE0lBwb4YK1J1k+wcEL/GT6CkGasohtaz8miwQIyke4TWes6LqnJePyx9v49Zv
	 3Zq9GbZYPC2+eFuqKv5ESCQhe5y+3qxHVRG2NJz5ydIJoJgGe6vR2gdueLsweRJoSViE+
	 Mz5+hO04AFTOM87R1xXVvdiUuaaJ0FHvmGDW5cm4C3KVI4JpdI28A4WYDKOdZtl3n60Ep
	 um6QH3mu+Cu7flnuNKMu8JsTE4pGWWAyHoxc79JPOfcUtl3Akz/uiW4KWGPFXYZz4SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781281;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8kyvHvun/dMp5JznRGICSb26xQz5uH9bwGZ4qf/ZMpA=;
	b=gqP+EjG0MwpsjKciGDjKBVtarfyUQHYmBgJTTYSoiQyjHk3v32Ita9vhbdDrDYgyeN+j
	 Xf55fGBpf+JymZgyyZenVsrvOFGjnxZ/2iqwvjMkDQOAxYapW74I9Cuc7MzH3+aR6OtzY
	 tGKv0whk/zPyzzqVXbRClyiJykZr4evZG44nbECGZCGUaXk7ommviaez3xYOBmLvQKZQ4
	 TkYiC1UfF6CWUFVSMpC4EEYzU8Gi8TOmmhTjR6PawLZhPymeij/aJQ0x/Q3d17I5VhkCl
	 gBZ81Z9H//blYs0NnFHvqBjJ75LO/H0GQ5xU2uGB2MNbJXLVW7tCl9yZJNRX7cR+zrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=plyq3Wkx;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62248606A32D
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62248606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=plyq3Wkx
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48Ke2f1874755
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8kyvHvun/dM
	p5JznRGICSb26xQz5uH9bwGZ4qf/ZMpA=; b=plyq3WkxbKmgYZG75NGsm5GhVts
	CfgQYzppmXCFDVo1Cd8JZMuXIk7eqQHQWIoaXZ0Q0STdaWBltwB93JiweQDljuWm
	qY/xyssXvePP0FCbYvM4/chBPmuSIB5lSVPAKu73zPUiUIjfM/BGmE/oi79VRRnI
	PiK7h6xxQdgzsLcXB27c+ycP3V0HPFTCIo7KDQwBOBEaP7wbzI6arW+0y3Ee56iC
	GFW3LWwLbd9cK8jWXAm++/DSGc3BuZbExUGSyaTVy/ewVfpsBwxTPbgZTqSxnJKY
	XgT/PRFinmI2kDltG/dMooAksWO1KqD5AXCdqSayxuJaxSv4a/JX9NzPLlQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8mtvxc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:40 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48YZCA2688007
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:37 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A48Ybch2688070
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:37 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 9B48D279C4; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 18/18] obexd/pbap: Update SDP and PBAP version
Date: Wed,  4 Nov 2026 16:34:29 +0800
Message-Id: <20261104083429.4111632-19-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-GUID: 1y1pbneFXVZwr0b9LjvUisK-N-4GYmpg
X-Proofpoint-ORIG-GUID: 1y1pbneFXVZwr0b9LjvUisK-N-4GYmpg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX6TzuZiF6foTh
 dkGqtBlP3fS1t93oX8H93Z0fHsZBw3gw5dc5IbtXmVFkQ+5aYBZ7PJWS3pnNTxWEG8+QOZjOyTH
 nchbtxEfmBIb/myhPDQ8GN3CrpJZUv4AY9ME0aZo8A319Gfkt3LLfknP1WXYm06Gkx7I/jgGfTc
 rl9xKzszrkwwGXFlA8jw7/ZGD2gu6qERuU3wThMr6+fe3luhnCSx1N9CIFeCKtysz7HsIhRRVHb
 3SP7GsTe084RvHZU7WORkcaZmbDMKjD8DdJmbL98NGFeuSBFSYWNvSYIhbrP+Ld6VgU28Ne8P8g
 BM7/1zY9eO5Gk5zPA0oCdTIIMnmTs6mvQcAfQKh2xJEm+wx30UV1ot+ML4Vt/wpj7OWJkkwKOG/
 QCzJ8hOFkT+oLq8B5qKbP1VeiMpaEjgfcYet7qmDo7LAcGrAH6MvIFyrOYwm6bdeF3F7mJzdDv+
 6XYu3KbVZPDaMk8AU6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNCBTYWx0ZWRfX1jCzLAIP38QJ
 olroirhOe9yrM2vhtzzUTQXlH07MMfV7Pi20uEVPpT0L6smTUIWRI9ox5u/5H0DyqT7blyMPFka
 dk8wGuejmCSjuO6UaYfhGZwJcZmZmLw=
X-Authority-Analysis: v=2.4 cv=HbWB3SE8 c=1 sm=1 tr=0 ts=6aeaee20 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=3kB7jyYCzrIlwtjniwUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040034

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

