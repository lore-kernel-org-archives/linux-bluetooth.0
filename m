Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635D3081D2
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769500074; cv=none; b=rpn8gq7jMJe1Ot1/nsCvgHCyh9BL82CgiX4bsWT54Fo0ltAh70WIlYVHWc35lgxrMOeAplInVjQWJOaGo4A7LzAT6OGydAOeso5jXj+cV1TYc8MtzpLGNFA/+6U6QnJ/+TSjaSatLpywLUg8oWsUSkZ9ntN49WHIp14ptY55UJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769500074; c=relaxed/simple;
	bh=HyqZ6H8iaHSaMQjpLn7CstKrs18MwdC/Xui/fO3y7N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5rfxJpYpMm3mnkDMtSTgVWtGMXQ8/fuvOE1FeQMQgBHajGBmqlRruBfzPIjeZRz1u/p+u/ElTxJpEnKRfK76JB8vVnLbroRQOYXOtxd7q1jmmX48vaQEt3mvm9k2CTdaxxf+QEgODtYPmjp9u55GSXQv/b3inv2jyca0fMCmT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LoHHjQQS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YIk4yv+T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LoHHjQQS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YIk4yv+T"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4U6tW1268748
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=W8RsW3EFTEl
	jseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=; b=LoHHjQQSTU24mzzJ7v2eildZ544
	NJQUSgd2p46QAlPKBsbXLvMkHs9Oojb/lqezX19D4wCMBSHI+UTeImtCPuY4vCDD
	wtWs2lEXn2VCGzQkCoFgPvEEFtuA57J5gnhJaLfgAqU1iKXQgEjvxrtUkoTZhysn
	Xodf8slVW7i3oa6N48rzJeff1b6eh+DKUJnbPFBVOcc3mEpFRxvSzxbnLeLWSxwc
	IyVniLAv3NGkB7l4jyEbtvrX30AyV7VjvoNB2kbmcZXrRdSU8E5YCSZMsbauUFZi
	58yjKp1z/QXFQ+zPLOgiZPyCW4ydN0EUw/imjgXhzeBc0AILxh4ARFwG/Eg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxnyarp8x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:47:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a871c32cdbso2919725ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 23:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769500071; x=1770104871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8RsW3EFTEljseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=;
        b=YIk4yv+TISgXsCHVH6C9sW3+0e3I8kkrZKYAY9vY03DT4LhqZClz16M3anthiz5AeW
         HRuhU8NM5edkhP7T/sWM0l5a3WUUI1jCIc/uyg4p/FU1sodEaBRshTNUGMLUjYSOZj2a
         FoAZDSfsPQUFQ7nIkHoY/vnAwKkWqziLObLNPSN6xC48uEA3weZJDX0zpHnMiOyAH/dr
         yo8FdORTmpZsIFUcxUuwLGbD9d8H3O5ibzvEr++6eO9zkaqNMIgGzqyMyxI+C9qH93hV
         kq+IblhifwMajdtaODmOTnYv//TrT9WD7CAq+/YE3NxtAm7DT7pYVwtjTzJzdNSe392f
         QGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769500071; x=1770104871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W8RsW3EFTEljseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=;
        b=t9Kt9YHvEtyRaE3jXYonxgSeMeasKlNRnL4CPnBF75/kHhlxI6YIzGenPB5BOJ+3gm
         y5BGoU9Fg7VWH69mDK/f5bnwY1uwd+sjK4W05tBIF9um3/ILZrhPyDskMFqpe9fv1z2F
         qimsbfW1+pKoRx8cGWY/xLXbkcZtjbP9koExWA+UKa7ovh908w71+T8Q3Q909R62Lwj7
         zy+wn4hy7PttdjjQDSY3OTpLJLEtV/MpfhI4M86MzsAWdHllS/axFD7S5ROdvYGn7K2G
         +H+FW7+wlWqwkKvyw6uM45OgH1t183njWWE45RajrRins260pdHJcfby4aqkkJTSeJ5L
         879g==
X-Gm-Message-State: AOJu0YzO5SGV2APH0ntNQN6Y85bGzpxalZ1D6nrSV0tl/8ChxH70p4i3
	tNcscGIiCaVAn1zi/0p9SPCrpMvRlu6Kr/pun2FqZt2hEWhCkkDnaEJKXSnkh+PDeFyhSpIEZtQ
	2ciN43zgMhVuJ3bMf/C7Ig6xiLLjGSZNWv4WBJ+UV6u8clRhOcCFfZy+271KFbWAORaTqS1Bl3Y
	40YlY=
X-Gm-Gg: AZuq6aKsbE4BK9rk5MDsfAMmHafSqDbklX7BuZERGYfDBeY30MaO9aodCIy8LdnbHwe
	J0EAmADvCOxWXpHjdjnSY0blolCWuGkGLou81nQBov7LBohWKdeuLYrXmoMz8kDgkgKJkpGB4yI
	6P2ep7Z5bc8EBCcfwnvhFXUaKC+QMTqQzELRymTJluqHFla8429/Yi+pxbQx9KGHQPFXlwvqIR9
	VlLE9lSjk4eyapKGTkEcNyyRzKirkt//t8Kn/q4V/3PXH9wLAG3Cz+vkVmuMlSer8/flpbxWCQt
	FvsdpXu2yFb7PlEwNpBh9H9aRuiOLEiVCQK1o6J3gOaZuRC8JhC7jbT9s7ddcE3Cw0xzifKo4kQ
	+ABKfXDSHaU+JWqx6rGygpTIYFidTQXXUxoCf35yFyZTMj99U
X-Received: by 2002:a17:902:e808:b0:295:24ab:fb06 with SMTP id d9443c01a7336-2a870d645ecmr7953365ad.22.1769500071118;
        Mon, 26 Jan 2026 23:47:51 -0800 (PST)
X-Received: by 2002:a17:902:e808:b0:295:24ab:fb06 with SMTP id d9443c01a7336-2a870d645ecmr7953255ad.22.1769500070656;
        Mon, 26 Jan 2026 23:47:50 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcfaf7sm109483675ad.34.2026.01.26.23.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 23:47:50 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v2 1/5] lib/uuid: Add RAS service and  characteristic UUIDs
Date: Tue, 27 Jan 2026 13:17:41 +0530
Message-Id: <20260127074745.2984874-2-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127074745.2984874-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260127074745.2984874-1-prathibha.madugonde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wTF_pbq7E9_1aRW4IAOOBz9-DtyJVwyr
X-Authority-Analysis: v=2.4 cv=JZqxbEKV c=1 sm=1 tr=0 ts=69786da8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YpA1fJgtMS17HfsGp3wA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: wTF_pbq7E9_1aRW4IAOOBz9-DtyJVwyr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA2MiBTYWx0ZWRfXyXNjbd3EMH7I
 CfnzK+E7Z0G2CxM2TN32fGvgEtcG8A7qvW3hgYolJA2Lf19rFFi6yi5ujoHmObSciYQiHZaPics
 RjQwUGvd+hFd3t2jewp6qeXFfi9yYZ3cErE1beVl8TtQTqZ7Vrmk/Egwf7q185eC33r9XIbMjgu
 YRUWpOkNaMjCdvG5pZAnqNtLPAPKUSS17W6CizOlGXmh2hc0Hof5jCbYDOat0XEUe5hAiv1W+8H
 rVNQjmTGe9VP9Bmh/uYL5jQDz34pLASDQ3z3FXjX2aQe20g62K6BWglJq3TLKqA6dYcY0JMznJ5
 orArQE1eAm2cvj0F8J1nFlD5C+FzqzmulxVs77DdX+w9/SUJXqY1B7RuCW3/Dl7Pxu47UdQIP5U
 pdkTyw59nqJ5TzMv5q/2B2AEnuiqjUFHgr4LRZ/sDfV42Xqx4RS3odiWMgX3HyNO3QGMwk5LHUW
 OZNy7mo1hAojxy9Ln+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270062

---
 lib/bluetooth/uuid.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bluetooth/uuid.h b/lib/bluetooth/uuid.h
index 74bd83742..bd3fdd486 100644
--- a/lib/bluetooth/uuid.h
+++ b/lib/bluetooth/uuid.h
@@ -50,6 +50,14 @@ extern "C" {
 #define BATTERY_UUID		"0000180f-0000-1000-8000-00805f9b34fb"
 #define SCAN_PARAMETERS_UUID	"00001813-0000-1000-8000-00805f9b34fb"
 
+#define RAS_UUID	    "0000185b-0000-1000-8000-00805f9b34fb"
+#define RAS_FEATURES_UUID               0x2C14
+#define RAS_REALTIME_DATA_UUID          0x2C15
+#define RAS_ONDEMAND_DATA_UUID          0x2C16
+#define RAS_CONTROL_POINT_UUID          0x2C17
+#define RAS_DATA_READY_UUID             0x2C18
+#define RAS_DATA_OVERWRITTEN_UUID       0x2C19
+
 #define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
 
 #define HEART_RATE_UUID			"0000180d-0000-1000-8000-00805f9b34fb"
-- 
2.34.1

