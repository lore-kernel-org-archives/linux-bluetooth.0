Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E433A6F1C
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451204; cv=none; b=Mf9WC6Gu0O7f4P62wvsWGTzh6DC3UjUDvgQ/qm/FiwB0xRrXsn+Rtdymm0naoAyGIW1qgOdheX8wqt6/UgTGzF7PYwsALIFXdpKb3itu8HAGdePZVA+ouFLt8RueIC4doW/cjHKReYiK2wxUZ731SENAUXHreDzXZQmVKUTW/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451204; c=relaxed/simple;
	bh=2YjVjrPaycCrqOLQL1JI2zg14+YaOO2rcb06GzOcsTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IxuP9t7F7K91SYtRzVOJnZypskhbz/D3/DgGnQrZdAyZaj00+PpAESqaaj6fZykaULRm/F1vvZ1wLe+oa/1RcHFonQwhfHMkGeUPtrX+aZkv8Jlju4QD+6zZr+mzSJgUB952zcCuanhSLVMsX5EpLmEhu95um/CUXE8VbCVDwDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VjSEEJPa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RL17uv2L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VjSEEJPa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RL17uv2L"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2jAOM3734496
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3TeElaidC7wbFnX8sGpOSxYLOegsMSCKkcm38P6ttgI=; b=VjSEEJPaxUDnK298
	5UtKIQPhF2NU/2oy+0WnQ/wuwjvPZts7zkf+SzjBhUdpvm4di5vQZrOD/los6vVf
	lQ5LeRNRYSz64agcHbx+WaT1FUTZCZPxdCdzR8gERl7OSG55QWqXtbf1RMlVWKjW
	8c9/c39fzvzufpfxN/eo0SBrDeFDf9KEOsVoK8kWEzhCXf9PGgbyVaFgoHc3Jcr8
	u+c/WDjpdWu77dIZa0ZJJeKHFpxnSS8E+uldQc5/R/vaRl8JaAhCtRbV47wMVR+K
	Q2b4s32sYJVaOLHGnAcB3UiRN3gLHhaHJX28iuu8xRvAg0hd4S6PajS+483wzj7C
	pKKqbQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f16ukb2n5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c93c21752so54474eec.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 22:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782451202; x=1783056002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3TeElaidC7wbFnX8sGpOSxYLOegsMSCKkcm38P6ttgI=;
        b=RL17uv2L9o8ChLjU/vNIXJPhkGcp6K2YekE0XY72DWphmfI2eGA02fWYy96Ne2guGt
         KsC8VjlQqtJ2FNFc1ZjrvkW8OsMvkOAQqvxtWayIuUwpaRwl08P3/bqYXfwcs+De0Mwm
         DpTl0mDeBR+h+qFKivVka3UW0sz8HVHgFcYcgsmusprMy3nUQ7CYLfr6s8l9I7jHVJeP
         Q+K//G2NHifwJgn1It2pXIN+7qvEyfxRjtZ6ASCXK97kyUJvOJJrQJqx3vaJV+ixz7hR
         Zmn3Jsoc+1jV+v7B6HkLVoMy+Aqd9q2OYaRSddgqSPSPRhAJ+5DocYnLj8W3sgUuhNCU
         6wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451202; x=1783056002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3TeElaidC7wbFnX8sGpOSxYLOegsMSCKkcm38P6ttgI=;
        b=K3rxTh0bNr6wZwaWe3T4qGDkUuNeWvzBA2zWfYRNT/sif4GpmtiRYqKTYKBNj0P69w
         o1aCVBKJsolQQMbyC/vhbM5iNedT7YGd5V1bvUEPc16wxlLyNVecEzKi7KXpTCEbXhTC
         mYeCZCnBmu8UCa5TAn3aXhCKccwMaKMeo+nCBWr1+TwUMCKaMsnroV7mxqd++AIvfcKH
         DzVAjXoxRxaW3sZ7OrKz3nQQtDtr4uLHv7JHkrYErKASqCnhzH3emsFrI3LI+Sgvdje/
         LVDTbLZIeoHP34ANI4FU3iFsMfnY3Kq2rCXUuVCdVwApeal/bL+wxu6JoRFTm7CjpYsi
         llgA==
X-Forwarded-Encrypted: i=1; AHgh+RqdwOfaPvmjiLx//jBHA0huWADVE3uxvVHVrXtf5n+lNYHeCiaA9pohBuwLRV4FUkSK2joCv9F84h2pEJVHYw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynjsDZCHSoSQgHR9qarS/Te1TcyCuMGBFOcEGVewVUXzxTynYR
	ii+eLflYlTVEvgSRIh2Okmt6cw8wcWXRV3yijo/b+ZCNYlPDN45Y7pX6VUkYYV38er0vuu5ddsC
	qN043hR4MDwxLWfAXveT3cHMj6yXYG+vc6h/Bpbk1vfH+xWCgz1wNnEV+3ssS8Yf/4Ltk40w=
X-Gm-Gg: AfdE7cnNymT0OXaCAW0yl361Cxrkr7EY9Vbtt0Ct8Ifnd/nwRvVwhrhLtMOxaHv911X
	qdMqV7Pbe50gnNFVA6KEzSGFKLj5W4gU38sQZvzdQYyG+tzoR5BL5LvP+gy8olsHTWj534b1VSa
	lVRLmQ84hEmj0qmwdFjnB4+LFZFj8d3W2k16+b6EaOzBTfiNpFuUrUsW/CgDmyByiRobYImYj1+
	1zWQcIIsfGkJp7Buo2LPy0WF1liUf1amJWs7XIXtfJfg4cLkvoOsSDzM1XfP4FuxdM+SegZYeID
	DYAlI2L0uXAF51N5Cuiw1BN2ToFLnqwBZgwjGefbAb7ThABQT9+KlHwmPafAblsq5pCxK2/repf
	p2FvtF7Dj/LYS5ir7V/ga3yBJ0dEcnnRZu1n1mxNUKDIt1dgQGkL0MMzqSA==
X-Received: by 2002:a05:7300:80d0:b0:30b:d2f5:d503 with SMTP id 5a478bee46e88-30c84d6c82emr3141128eec.7.1782451201853;
        Thu, 25 Jun 2026 22:20:01 -0700 (PDT)
X-Received: by 2002:a05:7300:80d0:b0:30b:d2f5:d503 with SMTP id 5a478bee46e88-30c84d6c82emr3141116eec.7.1782451201313;
        Thu, 25 Jun 2026 22:20:01 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm14345291eec.4.2026.06.25.22.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:20:00 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 22:19:54 -0700
Subject: [PATCH v2 09/12] Bluetooth: hci_sync: Simplify hci_reset_sync()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-bt_bugfix-v2-9-93396a6f7d5e@oss.qualcomm.com>
References: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
In-Reply-To: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tim Jiang <quic_tjiang@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=VuMTxe2n c=1 sm=1 tr=0 ts=6a3e0c02 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Hgocxy9eVv-WOgHqIg8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: a-THkaYq2xYkPNLIXYfAgnN2dUrVPyTG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX2NsKZ9ZE2tX4
 ZYJf7aV7dcneAI+RPatVhGgcFORIV86SxhshtHXzlic7S/oPtHugg+9YF/t8FM6XLkUPGgKpXPC
 +GbiAW/lleYrKLC6ayiSkUjP+yyJ9oMRMhL0H0QOxM1dzPHLmUrINjlvCNpIcL3qYOTHW2l+2NI
 5cauqIseUXaZjmS0sTAxrrUBFXXTtX+K08IxBBOwTcTf+6JUMsb23ebyKSTyvt730/1sSMsy7SC
 pcbnxbqdQrzn12vdC03JQ3ez0uhFjY+q1XWeMLb3PTe9jciF1BF8Oozw9iTW8BqK/GEitzmTiHR
 A1NomMy1+fhmSsvjBSms+789431gv6bDI1ObxBYho1GrWIuy/DKfVCQlSDfUxKqpcts9gFHXw0q
 W+GCaN8wEYOaKNqxW3m/0VClNhqM/lQ03oBTN5Uvb7ekfpUbORpUdtccegy/9g/cf4aHZ34aETZ
 Yr5CBLY9Q6RnOujW+XQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX7VJOwXYv81AA
 OrFiyEBkpRYYDJxyyOHRtWZ//IexYyVWFG62fflhtCcwjetbvbybdASr16B43IF/hLuIaOWPh3S
 5fDUTwOdiYhEwYU6ZccRrVYrEZMoyu4=
X-Proofpoint-ORIG-GUID: a-THkaYq2xYkPNLIXYfAgnN2dUrVPyTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260040

Return the reset command status directly instead of storing it in a
local variable and using an if/return pattern.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 net/bluetooth/hci_sync.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ca1ee6c89739..97caac7a1963 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3672,16 +3672,10 @@ static const struct hci_init_stage hci_init0[] = {
 
 int hci_reset_sync(struct hci_dev *hdev)
 {
-	int err;
-
 	set_bit(HCI_RESET, &hdev->flags);
 
-	err = __hci_cmd_sync_status(hdev, HCI_OP_RESET, 0, NULL,
-				    HCI_CMD_TIMEOUT);
-	if (err)
-		return err;
-
-	return 0;
+	return __hci_cmd_sync_status(hdev, HCI_OP_RESET, 0, NULL,
+				     HCI_CMD_TIMEOUT);
 }
 
 /* Send a raw HCI reset for use by vendor drivers */

-- 
2.34.1

