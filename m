Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390280;
	b=SHzIv/IocXkz28nS/v6tTb1UoHJg8BDbC04vDrgrQ/mJ5re330TbWpnG+LZs9xjNHcGP
	 C80cQGeqcExZeP6r8CWo1yuvqO+ZWJvlHlfFTvY5UmZkSEvgkR8C5UrdF36oqveP6qGaW
	 c+f5JQObD765OX3hOzeROd1Yi42HyWCjff2wO2nS5THi+quaSbQJ6mJrgp0y/aprgx39a
	 7fwyVv0on6mw5pX9x3gD4ZaGIG/8Sn54Mo8Kge+IcI2/ZKSQZxZji0XYh7GosyZnXea45
	 QUIwCLcekG7gZseFjfQ5FHCVv4OuVdkV8Q5i0HgD3GQrIWeIzpFrTVHS5UvX0F257RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390280;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8kyvHvun/dMp5JznRGICSb26xQz5uH9bwGZ4qf/ZMpA=;
	b=C18EkkKqS85jv5zUw42NV4lZgTOT60wOzUXybkUlSo7FGsNriudP5513TTX8BuWyBPf1
	 zqkagp5D6cE10LDxbZxh2SFr4Gdn0irFBk6ge2V73Eat2A7+Ow+Z20yCJvBo1pLSMq6I6
	 XIy4n80WQD7A3m7dvElNlJ22IZ/8V14Fhzoa7U1enZB1M1eqKa/b+TlcRTEaCYDuHqcu7
	 J1FfvcxmXooAhk/a1TWDEs4ZBi15XEfXhVP7xaDq9TQoMW10OacBwv+d8KFGAkCNvpVs/
	 mMRiOMk0JQSYVte2La0MKDaZUFDFFZR+pha9ECvV5Bi23L3d5xVR7GDwfn4f5j32MMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N1cBqt0P;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499F60A262B
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6499F60A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N1cBqt0P
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5Ko9n1052607;
	Wed, 11 Nov 2026 09:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8kyvHvun/dM
	p5JznRGICSb26xQz5uH9bwGZ4qf/ZMpA=; b=N1cBqt0PH8q220tixnl0GHNTZPJ
	1ffZRtxlw8wwYBK0dmasvsOnl7jKSzjMbPl1hwUHljmDAfJXQ+ucecAVABg7CwSb
	juXMdSTcOxpYYSVdjermKvXTU4fPsdpCrWrhZfw6vky3yEgi05WpOXBuCOuQKjBd
	cD2xZvBdhCuV2mGbt1zZm/y7SrXCgI9F8ngD18mREJIllOQnF2u3IcboQLEIyaba
	qPFb+gDYUJVPWDeezGjObo0R/5N5f+pA6QuOnzvL2WWJmPdRK/XXh6+23iPbwqWy
	QCgWkUy0lCfLygCRawhijBMsqbkmVlRrP8dHMgJ8RYCyTF8e1FJcqkDkFuw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdrh1xm6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iZSk2424198;
	Wed, 11 Nov 2026 09:44:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AB9iaTi2424270
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 7CB1B2441D; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 20/20] profile: Update PBAP PSE version and features
Date: Wed, 11 Nov 2026 17:44:25 +0800
Message-Id: <20261111094425.1444893-21-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX1BK/U0O27h7m
 tSDiU+SuhUVGcrUa+ATm4/0th2O4uXt/Locltp9p6eCUZoYXEduHUarI12GCjqBpBZLwnZZZJTP
 Aq7WFeZ4cTmuHridgZYJhxdVyXXG9Rw=
X-Authority-Analysis: v=2.4 cv=PoQG/AM3 c=1 sm=1 tr=0 ts=6af43907 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=3kB7jyYCzrIlwtjniwUA:9
X-Proofpoint-GUID: GPq20nM1hXm0WAkNVfCBeIyD9ZPh-XIS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfXxIB3BYEaF6Q4
 iGVt13FqKEiq3gSbdPF4mMeG4+GgrLef80fzHUJhH1GGkvRIVwjhGYbS+hei3udKlk0h1R0lt5x
 TLZiPYnZrdTUqqPETzyHylQX28HMxjqu30e9Sy2i3fzRdu28+pPDqFrSjMc3LkOCXr46vn7u76p
 4spzNmda5CL1DJuw7FvLFx/FSC0IzHeETLPOuogsWM8AM8hvCqi8O3BijV1QitA3fR2xnvs3EUD
 CuUOaRag8MD1Bp8o3aKcjO41gsYVbVZPXUY+w7r2i66oeh4Bk4wV1DOKWuR0K+S0oyghqolPsw5
 aVbNO/HQ7QIwX6+vm473lyIxT4rIl40RKKmZOY2kGQNZLKJRlmsH8LGB7+QzhVisie0SPxTXhUs
 wdYKF4nZSt+1+NJTkPnKNwWjBsL6XTy5XnGcKWyh04KJJuYwEFt8vqmaBDZPj6Dm+GG27rcVZ7M
 AYeOjNMMZ5CxYf1G4hw==
X-Proofpoint-ORIG-GUID: GPq20nM1hXm0WAkNVfCBeIyD9ZPh-XIS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110038

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

