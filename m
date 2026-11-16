Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820019;
	b=UsjlJl1nMV+bfGEU1LI4KN93+bXikvzMzg7J/qKL/HDsmOl4MGQn8iOeVBgQXT1iyuX9
	 u0fjjUP0HxDb/sLf/dtN8Wcdj2Ou/2E45iC/5YI8gm4qe5ikm3cjNbmWadO1Zk7GO2KgP
	 PLG2T8IoGH6HPgzfcds97iMzH762EA5qvup8oY2BF97h4MevaUdQAG6hb3qduNUe0au8Z
	 lsIqryrxbP8zXM6t/MH7cBv2mTc8nNoQGQGmXLaaxkVyPv9sUjfkheMFdNoxsprAXtXo1
	 IzAJTMuOO4S3M8J+O98Gms4gYIBWaOs3BmTHxB12PyU95gpK8BYnaUBH6AFpn9bCJLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820019;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PwwZ24pmv9E+3grE1ALFO+z+b1+yrppFdcs304GPfRY=;
	b=VP8BlEwUVhrKorMOXr+F36475XkdKZYFhC1SaykgqDhzKI9e2JXVG0vx0dtIP0BjSmS0
	 TwyELa5JJBftNK0ReFEgIkVmyVi8XFVk2c4rOzqKAfMhmnU4h/0zS0m4fv8E/xigpStOF
	 jRH0MdfL4W2vWl2F89PgGL+S/weIenrQrfsz3CzT4yVrdWK5UTALnV9qqqLuIOSbrpZta
	 C/sycPIOvUP4Dbfyik4GwoxlCuXwJcHK1b3r58ugy1F4megy/8U7leLVZbUq1P2IUnOSq
	 cUQtUKp9N4Na3PmxJs8I+CWAIK555HtpKcP0xPqwb9Wwg5kVzTptJQtJGgHzITkjNfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AXcMmKyB;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6929606A337
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6929606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AXcMmKyB
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG8TrNf2650619;
	Mon, 16 Nov 2026 09:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PwwZ24pmv9E
	+3grE1ALFO+z+b1+yrppFdcs304GPfRY=; b=AXcMmKyByEbk2TCpuVhb36lGzXT
	R1BEE+wliDR0ZVvRHZU9cKuxEZrtZRnPXnYlGM1b/CaCbMEVS7DdiIlgtPOPuAJP
	vZH1GpbexpOdKp22fCvqth9FEByP4+A/OBqYLhJTf+L/yWVg/Y0zteEofVc4NpUq
	FwRUzi5QNWDh8LSVdqlk3k/OzgU5QZbc5TFdSx1ixor+pK2L5j9Lrrw6ftAvBWSU
	Wl4DcjelhSPS2VrvY9DHgTt1rbGogNsIIeaC5CRsQYjNGrCVX5f3R2dz3y5LUbDK
	i7Xqe87NW5AejR1li7vh7xm+TatsASRKhWZeF8Zv7GQ5HioJBRxAQoLB1Ow==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxcf04by-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:56 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96sXq2942823;
	Mon, 16 Nov 2026 09:06:54 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AG96sK62942795
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:54 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 855A1279FD; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 02/20] doc: Fix PRODID property name
Date: Mon, 16 Nov 2026 17:06:16 +0800
Message-Id: <20261116090634.1222593-3-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX8TYSt744Iyip
 98uuGInPiu7ZsszOhiFh/ahsd+lEcTo4ETOCwGVZbDAgZ36BQq8jz+N7oZeajy3sFl3pKXyhdCw
 E1Uz9Ezvyf1An0seTEGMkxIV9Bd1RGm2+haNgQ7fUXIxyXxnDOXP2m8zz0iwLBslTiAyJE+KJoV
 I1H7ah25dbKH890dxx3nBey/k+nxXIv1Z8bkwID0djLhZDOaiCkZoLc8pC+qqqsJTPSkvz4bz+l
 0QcYz7v0UJNMAtwLqlu9eIEx9+MZqwl6H6EFf4bM+kPqsmPoO2EdKZrN5HrQIksCvS5YYrXEImZ
 NqJ7LXpFZS4qPMHXFJOYjg6lQCWpjDx8mlSt+neGMGUPVedEMKV7t+VBwFr7a19yle5fqQt5VbI
 gkiusNWr0sDRln3i4MAIIStRiYZe7mLMEZCbW4xAITjfK3hIs1WJeIDZDV8j+LwqFznkM1IJPtV
 GbBfXGS5tmw5U5cmGtw==
X-Authority-Analysis: v=2.4 cv=RtZQvymK c=1 sm=1 tr=0 ts=6afac7b1 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=fK_377rzG6kPcQo8kDQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX69cf7/AU6Nd+
 mUclVMy/rFUHJMEH5BgE4sEAm5ORtT2LBmgL1Aaco+TpDUMoCGimHCyS7OKscLnHhENMbiJkaFK
 UU3dbzIZGp7lusUEtBLSl2bumreOAjc=
X-Proofpoint-ORIG-GUID: Fwd3BnejEJU6U0jsL02zKjGwDlfjAjeH
X-Proofpoint-GUID: Fwd3BnejEJU6U0jsL02zKjGwDlfjAjeH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160036

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

