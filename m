Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC3397338
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594590; cv=none; b=Y7R3WydMwGhWoDRK+0vSu7BBqcZLxvk+qCDIpLbOSe2Gm6kW0kihJ75uxIKtiT5OCQJoGeurLyqDUteW7wY5iJCVurXCZwAJSMNDNJpkzBvJp1CMdowXL7d+3B+Br9x6gav1CFk5x4CUwg8a5n1MxWy6RbVLvUWCSJu+51pN5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594590; c=relaxed/simple;
	bh=OfnxlrQu3zZvNXWxRd4GFgpu0dcdiGo/gFWo+ZCMsq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZanwjQ+TMnCmE3OSbZm9FLZKuOYCIFJH1KgA7Kt0JBWUOGqB6EU3Yi5RcGIlZgKodmK7S5QL1SdwtndOAJOOVcqgEgyK0by/YEF/3RCw9hOzmCmuk4M3wnKUbX0D27XK9YHzAyDzwbA7vtGEiTzu0fbxDJPpUbcZQxSsrzOlBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxjVVAfI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=haMaXJ1X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxjVVAfI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="haMaXJ1X"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G64X6H2336921
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 07:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4UWFPgBgkV3
	0UGI8Ubgxp0yzF83aG7nzSfZodfDG6t8=; b=GxjVVAfIuezEKTDbPTGAOAgiMhT
	gCYLosMrCXnb8Ah1exPbJPwIPtVkuc/17Uk+pqxvFjSWQH4a/VF8jNB+BUP4VlWk
	dZ42YBkqmUb5cV/ZtKAu4Xz0Umd496m43rKs+cgKSZumRrL3Vpxan6EtzutNLzFd
	L32x/sVO4Z8qPJRkzawHkRKq8g3tPVRdsegzPO2zyhDyBcnZIDgbpGt2nQ/xHUpr
	puD3jz8kN2L9hLBaTJGwHSHj40cijzeIRnJiUZ+OYLtKo7jz7qWaFXazh856eJc5
	5ZiMu0tDb7cYUazyIg48nLEboBzPqgDCICfkc1kZibRN4g9j57G0sEM8hpw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0ng1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 07:23:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8423f6247c6so5002802b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 00:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781594588; x=1782199388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UWFPgBgkV30UGI8Ubgxp0yzF83aG7nzSfZodfDG6t8=;
        b=haMaXJ1XYp9Q7ROx8tfkJ1r9aCZADfRRGVnarPM5xjRL6E3hzASd1ejbefXuPos8YI
         +NDZ7JKRagnwKbj/i/vxIIbnAAQB1Jbaf+kN3g8fMVN8j8Q/GGojZ0FY2SUM6jzi6ETA
         r3qgG6o/EmQgB0TfUpzPLiG6ltHtXSXuWsD9CEjwoR1Eh/ZgLWo1/ZuuOL6vzv6g5YYo
         LHY+YSZBTdtOY+P0w8czNFFyzaBLUOpjiyn2bXhkplhbTP0m2onniVafqRNjRIqi4DXH
         leEEGISPoEyp8Bdhb+71ng7Co8DIJRHt+YbinB3tDf64aVOW0og99T0jvOlG8H5y1AN3
         4Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781594588; x=1782199388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4UWFPgBgkV30UGI8Ubgxp0yzF83aG7nzSfZodfDG6t8=;
        b=Vzrlb2tJ4CpIDRhHCfkg2z0aR+1hqsZ+XJYkA7vwC4gQejHT+ZZUHgQ0LSfgb1561F
         67UiGN9L8wJWtZJ1ULm1Sy3J8qzuaiLFFRYBj6t/Mv2sE/5ybm1OtpRuOOE2JXSNuhcK
         KI55MS03wLD7VBFo+GsmScfGSvQW+Lkt7dOo/0aTyMUZEGrFHeEmxFOVuUuVa5eAcVM1
         P1/zyrcSCamIpJ+K1m48jVQM2Wtriao3WMQaUWCQa8ozmawkbZ2vYwlku1s1Lbk1pDq3
         8wwMr+2c+Ys6KHgiejD5dMO1SsJNLyVor4cJ+OrtasAPKMylS35TEH1LrVISitX29vRi
         U7cw==
X-Gm-Message-State: AOJu0YwkirJSI/WyIHtC1w5GE3uUKUXEtpK82pDQVsZA3FQck1mr0D0v
	KqGS3a1oLfjDpOD0m43yjhraLbdeniIBa0Ct5lhBoogKNg8WhFkVHBY6yOqjFIa1xhJE8BOai2A
	5dxqM3diHizZ1VRs+NNAETfiLQkrifCwy4nLjiJUbWBeYt3vEnHWb+CYJqYiv4/nUVIwP3dDt0D
	hrv8A=
X-Gm-Gg: Acq92OFdLIcpEtUOKmfn6VGltyaYLIGk1ZtilvlmJPj7wmUngcOPvtNteZg80MtYoC8
	JSsoC5uJ7z6pzIZ8XvOVTZ0QnOh1TA760GciBNq0sLIZgeUcm09RyT/VxGBqr+2ev65CRz4tQs8
	T4mHwXzIsyBTbAsq5momXboJrcYbep1asdzPxez88s60XJuAjenyRsYukWNzU1TRLHT3wgekJI8
	xHJttNEp2W+U08JJumvV37BrTDdTbmHSOC5x3Zake/XADlvscfirNoaK1dAI/aOZUXtp1thH3pQ
	rBCI4WY/JWqZX6bNF876XCSjrVOG19s1iRRWJ8JkP/zupYOmFi5Vkg+MdnRbDdCoJewJV77R51w
	jyn9wjBfcxYqJZAlb4dH1y5kdssvV+XbqUEJQU37i36IJav+BFt4=
X-Received: by 2002:a05:6a00:12e3:b0:82f:425b:4c27 with SMTP id d2e1a72fcca58-845154fce9emr2401438b3a.14.1781594588016;
        Tue, 16 Jun 2026 00:23:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:12e3:b0:82f:425b:4c27 with SMTP id d2e1a72fcca58-845154fce9emr2401419b3a.14.1781594587687;
        Tue, 16 Jun 2026 00:23:07 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b057461sm14394934b3a.58.2026.06.16.00.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:23:07 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 3/3] shared: rap: remove the old wrapper API
Date: Tue, 16 Jun 2026 12:52:45 +0530
Message-Id: <20260616072245.3700010-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616072245.3700010-1-naga.akella@oss.qualcomm.com>
References: <20260616072245.3700010-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA3MyBTYWx0ZWRfX+7fx5KUwU4Q4
 75P1w7WqWy8JEhgTA/sfle6AHkl6ZnScPp7rTLqUcH7jbUBVj6lQvX0bNOHtNIQMGpbM9OEiBwL
 gpzcYiPtVX8LTZl9Bd9fiJ+1k2kU3Eg=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a30f9dc cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=S_ld5syL9isSlWfUGIQA:9
 a=zZCYzV9kfG8A:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA3MyBTYWx0ZWRfX4vkwoJ7SPdpv
 35G88aNuAFJ2lyAtlmgTFtWx2LMQY6msztiI4JYPA3wICSqETZmnbaafc0Z5ehPYzwh6eZYm4jt
 gVV13mrZNGuCOTTyyxU+4xHrgNSf1kwG3lqsUCWex+HFzggVVM+Qccq/M5YyFskERZ+mmK2Lv63
 xJup38v/SYbeRgPaOjrtCIMtT14Y41c5h+3SpX+f2DbWFuYVxhg0AOlR8CteQonsXcQeswR0RhB
 L/i5I6KDQvwm/auljJy3Iaq6gWuBidy2wrOo2Rlg4A7fxqDFIgjDU4jEl1c49IicLeElPiAngLC
 kl2RiBKAteVK0slFatS9ApkvOw1dIKafkEcylx0Z8fWJrCnFaFOBDX0ewA25BDNfxn9PbhiG/eK
 YWjGxyE5kSelIGWdk2TkobOJTYm6YjMJYD7/MIuOU1ZSwfrIjlAIfbMr/yFWexZ7HIw3XK96M26
 Fe0yLwNFuvhgChpCjBA==
X-Proofpoint-GUID: tlwfleztx2gG94ONpHJ_Lzq53Z83xjP6
X-Proofpoint-ORIG-GUID: tlwfleztx2gG94ONpHJ_Lzq53Z83xjP6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160073

Replace API bt_rap_set_conn_handle with
bt_rap_set_conn_hndl which has extra parameter
to avoid compilation error for individual patches
---
 src/shared/rap.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/shared/rap.h b/src/shared/rap.h
index 7db68478c..7bc49f03d 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -212,10 +212,6 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm);
 
 /* Connection handle mapping functions */
-/* Old API preserved as wrapper */
-bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t handle,
-			const uint8_t *bdaddr, uint8_t bdaddr_type);
-
 bool bt_rap_set_conn_hndl(void *hci_sm,
 			struct bt_rap *rap,
 			uint16_t handle,
-- 

