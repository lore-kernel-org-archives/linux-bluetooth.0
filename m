Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F52E285C
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508210; cv=none; b=sizerbXmaVsCasbaaPX2e0CzFKVU/NDj2Po+ZDNSbzex609eoPX/B9FLvVCM3gmZ8A9UuqznTGWzXgyEa4BzmMuZwTLyRDvfJbWX7mcVgFkeMSGwFhKbAxA+lVx+g2m2P/YeVqsr8YkaghA9sGMDpnsF3CbHRKnD7K1qnThD5Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508210; c=relaxed/simple;
	bh=HyqZ6H8iaHSaMQjpLn7CstKrs18MwdC/Xui/fO3y7N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cO4ABBRjzGYHoBC9zlDMVDMdcfWztCcHvP/ZSAcaJkk9nONqGJcrWovM+zvXlS+iU8YtG/DVq0KUlFICk9P6BXO/LlAmizmCiFUfXdCdwQABY83sFYa7mS7iLC+KUHkx/eqVY294vf1swJaumpNsDoDXNE/pv9VQoYeKiN5Ev5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i5+qdKi1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U+TFDSSW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i5+qdKi1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U+TFDSSW"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R7RweH112650
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=W8RsW3EFTEl
	jseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=; b=i5+qdKi16sZu04nNlRZryLAippN
	/aKrLoC23hMkcOWJSnVSh/nOXe+WYLjXS7556fg0gSl7bNS9fRM0vo65a/x4AJEQ
	f2tusV6u3yw2yI5JRnFhNr//NcYmJgWaRvrop9CV3slLOUtoO5/jaPlimwppkhAU
	Gv3zB4Q1+llbpSq95bTT2RRsX1b6tsb50PRHsOpRfA6OsYaa65uGgfganAAjc4zX
	VBkf4odt9Z7xrXgBmLWMe4uqIMVVsTFiAoAyCVhwke/tbiBXvOdqs3NCPY5yClhO
	3BjCvcP/wrzMxjZMVjZbtQY+ltS9Y1ZEjoYdNM+CjCOYca9Ax0nCyjgpizw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxs0e0kxt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:03:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a79164b686so58524235ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 02:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769508207; x=1770113007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8RsW3EFTEljseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=;
        b=U+TFDSSW2ZRIgI5I8VQu9QAgUEPavjp6MibQsTtewO7dWQK1Faa9Fdrv3ttakySNzz
         P1KngwQiwsUbKoQD2V8koQzg2EQVlqqvn8fAHG6k/tnWICpWGEWAtF5NsnrZ057GuZNp
         +zOXVCPa464383DL4pq2xAuyyo/1dmPbq3iTXROJ3FO0/u9QtmndGGFKzNuRPvxxlU6t
         Vu5PdkSe5or6IFZuBBumOZSIjHKqAuQErsFusPqhNOgoUvNn6KHWLKvVmmREni3it3VS
         Qfl2vgOgbPgFXrfHXhTBuJwV5YgroLbqdQ3YqJG+lYRg09Egy8WaGCDmS+xD+wMoGurM
         VeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769508207; x=1770113007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W8RsW3EFTEljseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=;
        b=inPtpxhf2EtVTiVgJe08887tQ+hwnaxLYZUglsIKVWKtCKbXj5vUUY60i+w8EECj4g
         6weEmIMehjujw9cQ7VS/OCwRlxFrqNCfgWsfYljOqD30UOmNP7/myX84AeAw6BBwzLG0
         64WHaqSj5XJQIPwLpwMELVxBA1B/FEbcglAoFaElm091wb35/RMDxuCy5zlYWR7sJ1+7
         JtmLpixJ1sZ0L9CtO0yJ5zo5Xchfot4oUz9nnEv3+3CbDjKLqDDL10dUTdpGP2gU8b3A
         ucl5/IsufHwz3oRtRC65Jr9myne9r5liXYa/JVRwL/zgRcFiqaXhKyWF/Q9JkIvZFaUm
         zdmw==
X-Gm-Message-State: AOJu0YzEykuCOOW3tTi0zH5mIF6T1HkvRwBU7JvAbXlSG9NWCznQVIC7
	6K72g7cKhbrU9bf/ghDBTR5i2VofHT1zes2K/tll5C1Yy/TwQ9D/mU0uoJ3H5Sqa9HtLN5V4sWj
	PIGXm8Hz3xxXni7Bwy6ZnLLgOr3HfY29DUUWkni/7IsVIsZOSj5FY6cws/5Ug8FTsJh/Gfxm4+D
	EBClg=
X-Gm-Gg: AZuq6aLlttQ8lOF7t02ypWRpDHXJIYj0cC1USrW5NO9A/SYrUTbuC/LVN0wueyiRYeg
	i/BSvdTIOQsMzwxifZI9lzH70FeuTVNCV6q06oR9xAMLej+Che/4fMWJWh2bWimQSxh7gEKCrmG
	6Q1lWg4I5jdv7ipktrkpEnzDwGzJctP/aPNeaxCuB2Vu8AScYccaViqL+mCPcAR7nBxTMU36Mjr
	7FYEM0t3RtOEmu4N6kCmcr1MHB+/wIOvN6gailPv6pH9gDfL1YzHgcksDy0gGzvduZeI5YUmBYZ
	kSIvjLnc0pg4wX1Z0eiWthDsPZZYCLcX2THEPZnrg2tu74KLRJZDxgnD/qTm6zBKe8YgA2SpXzt
	kkJHT6C42XiJmWSGMZUIxPpMYuwxTzhJduuuDrBH1a+HjHu7l
X-Received: by 2002:a17:903:2d0:b0:2a0:d629:9032 with SMTP id d9443c01a7336-2a870d2ca0cmr13636215ad.3.1769508207284;
        Tue, 27 Jan 2026 02:03:27 -0800 (PST)
X-Received: by 2002:a17:903:2d0:b0:2a0:d629:9032 with SMTP id d9443c01a7336-2a870d2ca0cmr13635955ad.3.1769508206682;
        Tue, 27 Jan 2026 02:03:26 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a87842538bsm7619455ad.60.2026.01.27.02.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:03:26 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v3 1/5] lib/uuid: Add RAS service and characteristic UUIDs
Date: Tue, 27 Jan 2026 15:33:16 +0530
Message-Id: <20260127100320.3055119-2-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127100320.3055119-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260127100320.3055119-1-prathibha.madugonde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA4MiBTYWx0ZWRfX6i8cho4xjCkP
 Bk/I++QN0DiVu6KKMIx3e6aj6it0qH29OsMX5X1C5e5oS6jE1fUSbr6tsLoVduT3GYBJWF51dHu
 kjhip32plvQvs5xGMIAJF5mzMBq5MbVPEIHOYEt2q0MSpxjg7FdlkhoIZPkN7aWtp0FGunz/4pG
 5CKwrBVtkJSsF/7JQ8tphC6PH7tiIm8Niii9BM4Hxt7c++GdumaTpnMbamRGloY6+EpXUtCbQkS
 vk9V6zaZzkMlq6J9OFDv303tZYhqizuNCqCpuX4AuSncM1AUaWvkpjDhzQ+1RY4L3IFR3h7HpZb
 GBjv7LsY6fV3jm1x36RGfo1M8RYABuHkTL+QP5+/Bom6Lqmn7ZVsgglUPfjtcl8FX3IDqCaPSgo
 6PJzRzfP08PdvxDE+Oq2gU3NBx4Fg80oPhBSWvkbTEO3b920YlkzxywYPxe7++7xf08e9VvZZab
 oMbodry3XPcjgCZg42A==
X-Proofpoint-ORIG-GUID: 11ZUg8N8DKMTBu8yu5We0xryjW1q0vCk
X-Authority-Analysis: v=2.4 cv=Hvh72kTS c=1 sm=1 tr=0 ts=69788d70 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YpA1fJgtMS17HfsGp3wA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 11ZUg8N8DKMTBu8yu5We0xryjW1q0vCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270082

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

