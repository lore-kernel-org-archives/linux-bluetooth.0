Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C191038E119
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002239; cv=none; b=NZN7iYZj1ioqKngtAuSqBDfp2kw7MtqQGTi2XrpK+X6Q6Z/GjIl2j9BUO5mSOClvKxIvYQcRJs5LKWjZcWg1o+wWwisNJwUz10m2O934JFBUlvsahWlor2St9juyzyXBJMXwE32XEYnNYe7c1FXFs5mq31yrdGo1xaSCuAFDWPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002239; c=relaxed/simple;
	bh=WJe70tuDz70/xUsazicHVRuusJOt3NqoG654y7rP64Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pad01XH9P4ZQ+7bY3SKZzmvE1N+vHickyaNNrsWE42NlpB1hO2gTEGWmrCABkr6Lzl0vmDAsT78F87hH4zEDVaSxqMx4CeR4FO4kN7qB59gwp9dkGepTq17aJ+N5zU6z5nao0vrS24E+EDGMq0X4QrlMBQg810773MssL73hpKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MyQ9x9B1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C5eJhliw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MyQ9x9B1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C5eJhliw"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599vMSo264835
	for <linux-bluetooth@vger.kernel.org>; Tue, 9 Jun 2026 10:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=E4d8V+mxYd4
	rqdFng/dh0WCKeKJ7pdVtLOyb0QqSCS4=; b=MyQ9x9B1KaUTOFSIJsR03Dm8BN/
	bZK7HtruvrvR5WoJWC8ajXs34cjYq00CxwiyMJaEV2w8HYxGkR3IbWcLEI7+/3dL
	lnVuFTZ9/9QgGqN9pJEB2kwRUvzUp4PedIb1ab2UnvskhCXvXqnckiNavncytYWD
	1w5vGUExKVUU+E0qAIrYqkZyAeeNrFual1khHA13Hdtp+2MkIfjoJZdo7TLPUKz8
	/y1//WC44MlBVEPKPUzDECc25GuSnh050Z72uzpWG51dla8m483tGLw64eSwiFs3
	w+1wyt0kQXoWODaJOHHvqA+33u7nLz3XQZc/n3Mv7fuQ4R4nGfXW7Rmn6AA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epf0srnj1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 10:50:38 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36e09ec696aso9229832a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 03:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781002237; x=1781607037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4d8V+mxYd4rqdFng/dh0WCKeKJ7pdVtLOyb0QqSCS4=;
        b=C5eJhliwLwcMKRhlDpF85DDC/n/mGJCyePVrdqUOi4LhZoYo2DWXbgE0TgEB3JR5CL
         2Fw2yYH1XX0B2qaWEBGHwNv0+16wd+9erbOppFEVT41gN7b+nvp5mcuy+SGZAO6d3Xja
         0lxp/dhGs1uOdfFiYYJLi4BmQmg0RohS5OaG+sx2vI6aEsie+YyynTcWQERMNOYBg9Xl
         /I/UyEaxpTyr+EwCpcWKOTom/RrU/TLSW3eOnaQrfEuigvhKcoSa8eOaLnHIW265Cyv9
         xkm3YlgwYfSdZvT7/0Ek4g1867cd0acXgzUaijyjzstnWEFy/MP8h6ScMVZoF9LXr1VW
         GWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002237; x=1781607037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E4d8V+mxYd4rqdFng/dh0WCKeKJ7pdVtLOyb0QqSCS4=;
        b=QunZqf4+PJZWd3YOFcvhL2tM7rVyDZR7s9tA97N2wDZ5xEQe2nfNevt3cMYP9NJS7w
         vW4BJofcR7zizn84BIyVjmPRNrOGF7HvIsrK/rMuhvx/ldxfUfMt9jd4RC1oQ1WDFiU3
         7lQ7CWxffXN+7kOZ/NEji33IQ8rV2bOegWmr8QcVHmyvB1wN6vw05CKX5azifWJhoHhm
         MRRE75KrIBbCjUptLGiO83SP64h0jcqBor1KJpY0h4WIriy+vnLd89ws1aITCoyBAwgX
         duO3G12Iv7YvALFIAF3Eqsb/7TErHBniAea7erBmQE+uR1aX2cXIpIV4w8EsKo30Ut2j
         htNw==
X-Gm-Message-State: AOJu0YwJcNE9JAZacz8qgAukjl7Rw3BVfjxMxi5KXKCvNS6p3+c4nHFU
	1GUKYxp+SZv1uaXNAi319CA4XSqlt/41ekw3rXlJ86yJLhZtAlBmO6BIlscJBVDgweUoKn+c20c
	SRq/LxvinNXcCy2A0xj7gSOjv9vmXt+HkiwBXnFvmivmyOOZZVI+gj6lfsH5z0plut1QuBXk08x
	bymng=
X-Gm-Gg: Acq92OH/IWdPKQxnHzQA7/Vn1JUPKZOrsrld92Qu/ilt2NuoyWMEAMCjk8dUZ32IacO
	TQb7P5GQdwx+dIHeGKihEzFa4vSkawSPACa80AZBmeiHIRMucWwUTBFNasp6Spce0dvptVT8Cmy
	noa9ky4cbYgSseY1t5ahrJustKhMvLQm8QtAoMOmbQscC8UIMpLC+x9EGB3lshAFUxjkCM6r/Pv
	R+BHQ695ct78Wf6nLKCpIUHsiJ1ri7geW/+pAZ4ZljUhTGiVARDXFamaYRb8GkrSQHxR6n2HDl4
	ULjQWHrgtlrgSIu8OHTDujKqf/U7qnn4FAEp2Q182ca9iZwL+WbkvE8HYcL9gni4ycEOIRVMGIW
	gufzjNggOnvMnGSXbnpbDPh4JxVDSHk35zfr2nZ/DFY6tHz4GGpAtPou8x4Nziw==
X-Received: by 2002:a17:90b:4b84:b0:36b:9c4a:e05d with SMTP id 98e67ed59e1d1-370f0772022mr20719957a91.17.1781002237529;
        Tue, 09 Jun 2026 03:50:37 -0700 (PDT)
X-Received: by 2002:a17:90b:4b84:b0:36b:9c4a:e05d with SMTP id 98e67ed59e1d1-370f0772022mr20719927a91.17.1781002237083;
        Tue, 09 Jun 2026 03:50:37 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371341170c7sm8864573a91.1.2026.06.09.03.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:50:36 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 1/2] shared: rap: Add the is_central parameter to verify whether the local role is central before sending the HCI CS Security Enable command.
Date: Tue,  9 Jun 2026 16:19:52 +0530
Message-Id: <20260609104953.3122718-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609104953.3122718-1-naga.akella@oss.qualcomm.com>
References: <20260609104953.3122718-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEwMSBTYWx0ZWRfX012SVtCdkD2v
 8RDl4+gOnHjzdH5owDG2lt8baKIjNfyNb+zfY3dbZyuMAkCY3xclrdyIEoL7/wG1gaACJfL6IPd
 JD8I+7J1bW8FZb8BgF99WMRWy0AmzWM6emoGdrm5tT54E4b9v7ZlYdZJmDHPlMm4G5FKvAssISz
 RU1+4bIk7ZCpS2SkqeXDGkRSyf0gbiZ7BvYmbL4PqgAnCX0O78XvC3inY/ORy/Szm+UmpYOFzu8
 z8STd3JlaNIIam2WsYIcTBVvRBtn+xoibhvnzbA83x/Vz4j2vdVjtEbnSUFQy+Us+Q9pjaKDfld
 za5XiGeDFyne8y3ZoNVPec61c+tTcU79FQTmaoc4qs5H9L5NcYUxQte8npQSdIDFoJPVLuqpKk/
 nTtOcczfxeHM0wt7NKFI2/ErHqCwxtA4iMhrght94cxhSl7q7Xxw8a9FK6p5GFuwE+4OFW0/AIH
 ywXBOcNDc5PBl5syU2w==
X-Proofpoint-ORIG-GUID: bl07pretwgFxNVnL1fQ2hS6Mqmsh2-9_
X-Proofpoint-GUID: bl07pretwgFxNVnL1fQ2hS6Mqmsh2-9_
X-Authority-Analysis: v=2.4 cv=GeonWwXL c=1 sm=1 tr=0 ts=6a27effe cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=dAp4Xmy9JdVdgdok:21 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=3zutJasFZMgI2A8EhPAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090101

---
 src/shared/rap.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/rap.h b/src/shared/rap.h
index d3ced61b1..4d6a3d1c8 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -213,5 +213,6 @@ void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm);
 
 /* Connection handle mapping functions */
 bool bt_rap_set_conn_handle(void *hci_sm, struct bt_rap *rap, uint16_t handle,
-				const uint8_t *bdaddr, uint8_t bdaddr_type);
+				const uint8_t *bdaddr, uint8_t bdaddr_type,
+				bool is_central);
 void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle);
-- 

