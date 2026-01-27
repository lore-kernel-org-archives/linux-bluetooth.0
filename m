Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9621ADB7
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536146; cv=none; b=D60nAiR15A0M+UHyvE7AOQQv0Sp4HcUfKt+8ezIE7RT1X4bIFkCteEeiYpw8KhdESp2sqr1adoU4JO0B+7ZWrzHF+2EJGjoraXoTwOdp2Hm5LAp9F+eFUTxsPJt92sThcbff4PeIyb2TXb2KzjqD4perr7evGGsm7fSxg1nVFZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536146; c=relaxed/simple;
	bh=HyqZ6H8iaHSaMQjpLn7CstKrs18MwdC/Xui/fO3y7N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCvTICC97inSzBfAz1Es2kShJPGMHAGuPIHqRBJqT3wO+YgWrgDu+rVRuDYjR8nPCdxSlR1uMWHKotl3SHXGcWDyXCeWty3AeoRNmBs+irKmZ58FovZUzhgdDffwKjZFdtPancJbPuGZKrTeazEXlyYjD24C2t0rmV8hmYzfeEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LVRIOOuL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GXSh7cMF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LVRIOOuL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GXSh7cMF"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RH4nBu1195254
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=W8RsW3EFTEl
	jseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=; b=LVRIOOuL9V7Fi3SnYtexamRkmkB
	3F8KqWw1O9cAaGKb13fVoLKRYdlsU/HfvnVt+qRhDvpfGhRfQ/DlOejhbrSpm6Y0
	NNJrWWk551NIDtxOiDcpNHVxvyhkoAU/K6g9L3WYDtWaS7J1kpBUdiiWBunShtmU
	XmghL6B8XrWje0OoDyb/dWimUwS75qJnKVUqujmEOjYRQPne2pOTxKgBzo9zljCP
	GVYTfyzLu4Fj/Wx01QHYNtyYKXuqn5qQ8RkqFFp2AqIw+edShW2Szo+hC3GjHni9
	tuj+1hw3J42JXUIuWbV5GqviNPv34g5oIazdZdVgw/eY2V7LbHALjsl8Wjw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by1etg4pb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f1f79d6afso60491375ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769536143; x=1770140943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8RsW3EFTEljseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=;
        b=GXSh7cMFZk+nzX4qpHQBTX+LsfI63rmFDglpWBuxR2wmbmXjzWIn0nQtP0zdZERlON
         H+T7IUwRaJFbpARikq9zcAPgnwAE2m/JhFr/WEFio1eAZoD49UcpwmKKwXHyEAh2nNxd
         P3MSZecPag5AW6JLyulCqmkloYUuN3y4XcR2t6xA6Xln7sLKPkDR3hghUKQoDAMuFo7w
         5PD19hanu330Scw7g1FhswN9gctZ/8eYLtTVWUGIT7SiD3qAH0StLq0IajDwzzJwyS3j
         26dWTqODWUAbSlG4HxpRlIXZTt1Nrm46DXdyvyMfdHSJpyi604RJufLFec+o3NE4IoQ9
         qRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536143; x=1770140943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W8RsW3EFTEljseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=;
        b=rSYxBWEMdiu/GDsieCxuI+If7q5Kmh9K5zQunyudVc8k7amEffpI7P4JZyl6AZgKUl
         OPitvaMEGDP1JTnvkftEG2NWd1ZwxlL6G5Xyt6WR66l1DFpzBBKarCtf33nhu+Nn1gwZ
         eMuusOg+e/6vPyfOpSVtGxw5Qd/gVuQeFv0U0Wey9HmGnJE8y0mjNc0swkHjFVLt+ZGg
         zitdy+VJG0pFB1QRq15MTDYY6VOEiSAPh3hDcHhrjhXjRAAtEOXSnQtUeo06fKzlgr2r
         1geEKQfWHJ1M/DEIDiYJkBLXHdGrvaC3Ec/eFun6C+9kdFM668unnLaTlLeN998ruk9N
         PuFw==
X-Gm-Message-State: AOJu0Yyp+Lan8V8hoevp6gi2BEwmIu/eSQGcCZeFUftLvB8QLLyz7FIA
	X2uk6VMITbwb2ExH/UvEG0DGAAc7q2YyvpfqnC5sHb4fHtdyaKtmX2anHXKHxRa9qtFRtwYTs9m
	iZINguZvSsc8f8XlbmGuGhiNB3DqbcRL5Qv+/ODQC5qm1BnrT1Z4PcuWgQKDSvWGH/cI3wnpbUX
	qtp1A=
X-Gm-Gg: AZuq6aL93W86H3OLY/mGZMHBRXaYiubrRyy18ex0cz1KuKi8ORmJHUzBs7xqV2hXigA
	De+9Kg3bY6pUukCFC5xGlrTTmhSPVZj/X0eNE9f9TQtMDibYJGJt9wlWNn2WlMhOlpYwc/kliU3
	5l6PRg0nFFCfYgc2Q2vsfpnJmGwJ4XbX9Fv6L02xZQ6ruu7P55g2SMS5fvNI0snVvhItXKsZ35H
	Fil4Ju6Vq5OFDBkzQ9hdh36TUSvXi0AoWRDm5fVbIDWWlv3VgbD7p9dw0hAA6K72ZcL78YawC04
	dpvY0DPYExclmhOFjNAhlMDgRfjmdx2X1Vh5h44c6eyl5WsyIIHzVlITMtEi1Y4ZIH/x4iSDPXj
	wVwO8aubp5aleQApRNaBcyUt3iYOx95snVQm6hPY5TidYjXYt
X-Received: by 2002:a17:903:2ece:b0:29f:1738:348e with SMTP id d9443c01a7336-2a870d65001mr25608955ad.15.1769536143165;
        Tue, 27 Jan 2026 09:49:03 -0800 (PST)
X-Received: by 2002:a17:903:2ece:b0:29f:1738:348e with SMTP id d9443c01a7336-2a870d65001mr25608675ad.15.1769536142606;
        Tue, 27 Jan 2026 09:49:02 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e5fb0sm110385ad.91.2026.01.27.09.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 09:49:02 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v5 1/5] lib/uuid: Add RAS service and characteristic UUIDs
Date: Tue, 27 Jan 2026 23:18:52 +0530
Message-Id: <20260127174856.3418323-2-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127174856.3418323-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260127174856.3418323-1-prathibha.madugonde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xNopryBO4KgrAG-1el8d64tC2kToTtKe
X-Proofpoint-ORIG-GUID: xNopryBO4KgrAG-1el8d64tC2kToTtKe
X-Authority-Analysis: v=2.4 cv=Tt7rRTXh c=1 sm=1 tr=0 ts=6978fa90 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YpA1fJgtMS17HfsGp3wA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0NSBTYWx0ZWRfX7utox3J6iAU/
 IdWUwhahjSFadm3igqF6bdK4dTaWqceOpsvVFFVDRerfF2mVF/Saw3xdFKWSKkq1V2DsgjXCIiA
 7bRFw6tglqzdxuuHZK4Z8LisTKXrgAgd5/83tq2KqhhWJWtn8EpmFHxl8hvhMxsjuefAw7zLNKM
 KS+4KeX0TVyM/9wklcg5WnbCF3kVyZV9IjQkl19jfifi0cyN/jp4S1Jj+TAcl+9AhBmRHG4r8QQ
 NPPDOHb4B2O9cDvT1U90sQ4/wABOPUjArtEpPYnwKwRuZm5G7DnwZqJl82PozW8XXWTlImAaHo/
 0NHprLH2IAjPONBF4apKQYGKPDqeDbIg5WR2tfunwiss0l5Ol5IotwhtpJHRuJ28zNGemRmF1mm
 2nbV2tq0tE756s4rN/HFXAtlP9GvrZ6SfdtLMoAHz76KJWSdvLKyWuzsJef7HFXI3qkOoL4QJnX
 n3TJqV6eNvpCDwQt5MQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270145

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

