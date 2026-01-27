Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A0235D5E9
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529298; cv=none; b=X0C//3bnA2eAXpBb0oc51NUmdRbbpYifDdQuqtxeuS4+cM1x7VDJZvqTHpuBGux1IZ87ZcSikWflAbvyb9pWwuHs93S35iQlPN1LAfvClizMJVkPmUsrOaJq8eiph865dQ/hU3AZnkgrgsFjcc3Xf88EicJc53t3mirDOS5AkJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529298; c=relaxed/simple;
	bh=HyqZ6H8iaHSaMQjpLn7CstKrs18MwdC/Xui/fO3y7N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUjIWcwEqWvcfSDeDaf7RBh6JOCCTtM+Mn2Z7vi1JsCruww8u9BJUQz8af1gB41L/pgyYi2SUmiHBjHXqhd1IKm0QrNN+y37G1nFIWGl7U0nuPs5H2VEhk6X9WufoamXzfXMOqiEPRZa8z2tZmBOYgy5ykrY4ehHd8gvaX1d2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HZvvvfXd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H062Jnw2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HZvvvfXd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H062Jnw2"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBwRPJ1135564
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=W8RsW3EFTEl
	jseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=; b=HZvvvfXd+yxDU5UCJ302tbqulIU
	remU8J8o8CR0CsQj+3s+qngk6Yj+tg371QTKLlFIYe0Lx/nEEOSvBYv//klp57D+
	sS9RFkuURf4qCLJ7QiOwZwbS1NGy31j01GyxS6PQQvc/Yrr8TUbJ0ruNQcpYSh2C
	NeLGai7VkpA+UdbHGr4wO7WoPFK/1aHwY1Sl8Dp/NgdyWB7pNUUWXYbgiRGOPgUA
	vgLQ6tnt1FVXQ0FR3U/aR+MPcjUgECikluWV0bV3uCehKb2TzJeeD1O4GIEyFWWW
	pCJKwGb1+Vg8ruR60+tGEg2dou76V3EEEuF2o+TudtX1FyZc87hIvogKooA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxsjehfge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:54:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f1f69eec6so55283105ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769529295; x=1770134095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8RsW3EFTEljseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=;
        b=H062Jnw2q1FWxgZgzX46UMQEp9VxIYlS7dKsb0tLQ/InXFzLrqjApHhZSeQiiTyfvp
         rQDyO7Z0Xo4qU0QNbEBhxAe88H7pamaiFkTCyjqWWVHspttLZydjAZJsE6ewxPuxwUCm
         k6FTIMJ3JrElC83nxyOMXRCFqmhnGnGE1sztDUkNN175pylzgFxdUs/00v40DEz8guKS
         nMi8eSeArQoq7bb9gxw14AcId/KJIsihKFI/5hCABF+o+wxKWdedXJ8zjMyQpNHLPypp
         Kpe/Qe8TGmgAyTyHvlJ6f/ygJ1eEpkWTp0iQZRcuDidPm8bsgIk37V8qiMQ006EFLSRf
         bcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529295; x=1770134095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W8RsW3EFTEljseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=;
        b=adbgZvDfU7zT8CQZzPmpIEP+TvayY+aHm4IvEFlkGIF7o1/vpf6Xm6VEqx77ZqgaSY
         wQBuu+Epi88/rUn1px5m2NhTuvAeetKnCwtiRgQx6Hdvk4Yz5KbefyQqf0d0Wv0f5iS0
         071EzsH9EkOj3wV6zM7rHezyFaKaQZDrPcdkYe0LYrLPfk2vvCLc19xP3ypJgV6R+WXu
         okFOaH0xdWzcPYpRwhA6WpvFGhcOZp3gIdYNjHkR7fDvS/yK1+Hjg9+FkiSSVeSFP9Ah
         UFjy0t9FgnH4t1dVQOFfVpk33uao4VuFMB4L9vo4MaYv87iJS7GxySETtZLu+fZZZJZb
         KaDA==
X-Gm-Message-State: AOJu0Yxh59z6ArI2Lj3b0ABfWC1S22ZHGE9PIde6SsjJXd9zHs17PD0C
	O8a5UA8Yf/UuaB7bS0qxqylT81RgHTd8f/7UKE1PP75GpmkupCH4n9/X4NaXnxUCTkfEwJpKTic
	u30G3lT5jJv3re7Si9soDkQ09vYj3PjeScbc0tei9t1pPfMyWMpnjb8Vflr+Un7eDv3kKUHWeK8
	+fVxc=
X-Gm-Gg: AZuq6aKAp1pqWCDLjcG1/9bsUvVmAnGxry3pDHGjPxFA+EKxuPn8LeUkZxa4fztikUa
	dc1AkkCHSy1GXqry8yOxcsZoyeIl69l3kTqsAwP+q4i0JCMVrbyZIaAT0F7y4bSKZ57F3fMmxa3
	JkVu4KcdPhjhAnKN6KGn4TzPlrOxo6yz35rdnLRbx0zDexeRcP9aYd019VLqnTthSesWC6+dupx
	8Z35ClKUrCV88h9rape0/5Zk9WChaShoDKDdXjjucNmbEjae1IBXzDOre7qxpveTVUiJ3/R1T18
	x89FFzKvv8uNqN7MtI8vmO9SUytn/af9edWbzZhv915kW4uiz53AUTtuys6V5tXrIxSnPumfDE9
	xR0UPGtnCJyemQPi8V61f6s8YZKTd2jhAI7NjEBOmgwbP831m
X-Received: by 2002:a17:902:e548:b0:2a0:d662:7285 with SMTP id d9443c01a7336-2a870c1b0dbmr20709305ad.0.1769529294544;
        Tue, 27 Jan 2026 07:54:54 -0800 (PST)
X-Received: by 2002:a17:902:e548:b0:2a0:d662:7285 with SMTP id d9443c01a7336-2a870c1b0dbmr20708975ad.0.1769529294042;
        Tue, 27 Jan 2026 07:54:54 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa719sm123292855ad.14.2026.01.27.07.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:54:52 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v4 1/5] lib/uuid: Add RAS service and characteristic UUIDs
Date: Tue, 27 Jan 2026 21:24:43 +0530
Message-Id: <20260127155447.3324706-2-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127155447.3324706-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260127155447.3324706-1-prathibha.madugonde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMCBTYWx0ZWRfX69uISW0O8ZXk
 iRrhDPFwtUBhnSQq80HCIkD0QifvSVTEwbgdNHeRXpkLjskqiRplKTQDUZ7kqHDlDuZm5wu6V3R
 ua3OaPB3hj9/sBn5dCKtz/zhg8O1CAY40hl5tn6NWg4vAMMpxHWdMfCDBGvkPYDVav0a1mJxuwQ
 0RKlNlexGgHY7dsBAXHUqa/O/8+nsQm+UdJEWIo3bsHh52BG+qwi+nCNw7YFafNZOp4tT4WwkGD
 SJ7qICb/e3ea7Ljl+dzrMthLNda2vXIxvwnNQBv+wMMI5vlO5zZseAqw9BSTRJ1SbkiBlSbew1/
 /TLSymlmoMoPTILq4fZZBhE9eFkNrQzx2v0tTUgp15ugZYbd38F8GqEuXo77WTIoZtPpW47xf1m
 BHvT3fAvMVmao86mMs0NQ7BOxCZbtOJFkHjcvr25kDjNJfxVTzADsH7n74VlsGEEqZRloVq/mgd
 VmafYjrXS2Hsn15Cgqg==
X-Authority-Analysis: v=2.4 cv=Qelrf8bv c=1 sm=1 tr=0 ts=6978dfcf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YpA1fJgtMS17HfsGp3wA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: WvgqMSMeq0v6GI-uaAxMbPLSA645nquB
X-Proofpoint-GUID: WvgqMSMeq0v6GI-uaAxMbPLSA645nquB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270130

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

