Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B4E36B065
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769164888; cv=none; b=eGDkZBsAK5L+/BRO8wpGgJr6ksSC7CjT81MoD9a56W8wMnxFcF6AGj5o3dJFxqqbfHaNrcj9LqvMcaIrkM3BnavGw+PNAGmPn68eKyT+7/PY4IBxaynVZGPFthk5XNP9hW7HT7U4lsGSx4WxVPpbd4tQruITpNdQTYpv5n8v77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769164888; c=relaxed/simple;
	bh=HyqZ6H8iaHSaMQjpLn7CstKrs18MwdC/Xui/fO3y7N4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SNKo3ZL4PujMZphyBmUxDDKew0tRQHc7RYNaunN25mMHSE/J5E20QGtDl718eXLvM9dBXG+lKcQPR1o4zfalicYz5c1U2b2GW2N4qkKsNwOBU05pdnGYa/7TNQhcquKmr7I5A2NBcZ4EBpRmPTaG0RS6eIcGE6TLmoT+VLSUHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ap8wwa+d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JDL3ap20; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ap8wwa+d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JDL3ap20"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N8Qsfa3649050
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 10:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=W8RsW3EFTEljseWxMw4h8H+g/k3PDw/TSEs
	A7IhyF0M=; b=ap8wwa+dLsjZls5m1O8vk0jX1D+MzOShiEt/jYcbgwhs6vzAlZQ
	y36KAf7PLw/OLNGncfEUKIkYyawK6duyUmMNuigliyxt76imxA5v97LRq9Vrosgw
	8KkzuqmTs0mG/loqByBpSpbevfgCGch425v67e5jCJGQqxMai9Vf3N/Gsq0n3djX
	93DWseFGjynX60grkuldgFSo1IvgL7K0+Ot8oH+pR9ufDUD3HPE21Uio1jpLVcv0
	H9D7sDcEPmhCj1FAZOTd5ZZIfq5zl2LvUxbIh0Cnd03xPAFVT1jWdp8GoBn5FhT3
	6SdfWDWBRmwXIgG4c1pCw6LXjEbw578RT5g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buy4nsxyf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 10:41:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c43f8ef9bso2811263a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 02:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769164885; x=1769769685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W8RsW3EFTEljseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=;
        b=JDL3ap204vOrwXXQOAyKYnx2kGpVideR85/EeGuLAiFXvQnGXTEj4iLXWvQwjTRfjA
         BnP7TkzCT+YChsNS64Cg1x5mHiZywGZvj9N18+Vp0gSKCQ3uavMkHeJDxxWcEMkEFpTU
         xePR4/fDem9nIsLcRpVbe7S4+B6d+oQAuNM8//HHGQL57mkUv3XMBxnVE3CCGuqdFpAe
         2e+3xry02y84uuobywBxh1Z5rzvZOrKST7vbewrnHL+cWj4XCSiRqHZQBXfmujIBu10w
         Pn6cDWeGtSlClkLTAy4+q/8foyf6YrsvjR5f5SJnrDopdYvzSEcZ20eCh3IgdChITEr2
         bgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769164885; x=1769769685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8RsW3EFTEljseWxMw4h8H+g/k3PDw/TSEsA7IhyF0M=;
        b=WETCLyuy8/RzJGsTHb68k3o0gh0Fugx/ZunKmwruOzilA83D5bKub27iEMehui1xMo
         7nmA1oYR3sZ4+dx3vYC4Dum6Xp/JwkoLLLxsIldEtaYTDT3xZpND1RqO8CfFnEca599q
         ElE7fsw9GRP5A072EVnreViXmAn2L+gSn+yn8sdfxfZRZf5mJDkJIqn5mrzfkOtOoYc3
         UKAaZoGDFN0Y4vmLy37uCH6YrHBVc0Ul0oHlftX+vZlGd1pNcS1fjrljXbLxlBZLjaq8
         Brqu5ljl7vglGLbgmC1MsXAesNuXFIkWGcEjcO+mGPxq7FhKFiX7AeoDhBFO12nf8QFJ
         zMZA==
X-Gm-Message-State: AOJu0Yy0o7J2bRv3DLt/Qs+z5mrrhCjjRny37rDF1Cx15rGZRhK8r6zf
	uABgsXDaUTKioTUP/fWc8oQgJNHwfncj6Scbd9XNc04vzRNQweb8caZmafeqmiO0MCTnD6DnKyq
	/fmuBpAHmdI2ZFwBQE/GgqWrjtVil2ijDBHiNmVAv87a59eFb0Ldo/3Ku/BE3q76ayiiHMnm8dg
	DwJiQ=
X-Gm-Gg: AZuq6aJE/v1MYXtAspnl8JCNmqS/9wdeJhncrnnNPlRDG8IR0utYE0jrJXRfocmyleh
	BiKZb4oRD9Lj6s0gPY0KL/cFnRhLlXHrwdlh9CG0wpv5OAz0kfU6Ocy6EwOr1u8rf8JBDu60K/s
	p45XNtNK//Q1D290AdpoRNst2Mr1N5evJyQSHZTI/tOrAFzYsoNNPja/mg993yshNySNGDAPZ/t
	JmeNPxWM8yjM0rDZqeD9hU+DzBR9KrORvNPRT6T9qSYhkKrOARQRNrLlPkFkfKF59H+CjFIdvo+
	S7eO1wUtoFFd/8EbPuqyF0QZNylev7dlPZs7OYzOywX+vZQ9prejCxvvQsSnhgyv+zT9IJfE9u6
	UMawKhCrN0QWRKjp0rt3Iud+/bhqzggtQDx3f3+rrHEZ1mIkk
X-Received: by 2002:a17:90b:3f0b:b0:34c:2aac:21a7 with SMTP id 98e67ed59e1d1-35335384038mr5265658a91.7.1769164884898;
        Fri, 23 Jan 2026 02:41:24 -0800 (PST)
X-Received: by 2002:a17:90b:3f0b:b0:34c:2aac:21a7 with SMTP id 98e67ed59e1d1-35335384038mr5265646a91.7.1769164884401;
        Fri, 23 Jan 2026 02:41:24 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536dc50813sm1763798a91.15.2026.01.23.02.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 02:41:24 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ] lib/uuid: Add RAS service and characteristic UUIDs
Date: Fri, 23 Jan 2026 16:11:20 +0530
Message-Id: <20260123104120.528321-1-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2s0Gcq0uYFcUxbHmbWcfEuhECl75lVpB
X-Authority-Analysis: v=2.4 cv=I5lohdgg c=1 sm=1 tr=0 ts=69735056 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YpA1fJgtMS17HfsGp3wA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 2s0Gcq0uYFcUxbHmbWcfEuhECl75lVpB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA4NiBTYWx0ZWRfX1M+auQOtwbGA
 W9XQAgYvhs1fGK+U7TgKaAYva1eSb1jc0ye9DWWoJbABBShyrQtsneSZZFTSiUbw3KPKn3xMb2e
 eIfJBzQiNvrhWI8T6Zthii+vphgj8/twGr6o2oxvPnftVkdGTqwl5g9JWa4/+UpEruTYbkThuBS
 tH//SLn8dJDvsbXgLsz51vZ9FzSP0PqXHVH+0K81EEHr3BQWlp5uUNwiL8TjdZTE5s+PhPa+oRY
 s26g/IMmYT3hE/ABJkRdpUf/cX4rpKB284+FSrSe9Ai+XSp0DTLUa+kp/8Xl5GnTYVtu+Pmz93Y
 9SGgyjRiGd/kmmLdjGs2fwSpkuIxCbxK78LY5Yhihx/NZCpgT4hYWnZLyCJJuNiWFj6EAirM6RZ
 1GjHRSC/QEfQnMVDj0kCYM3h6Ro5eWWwLtsYsANEBMk2ELzkOfDsOzgKsg5go3oxEUEDOOXhsmQ
 H8te7VnKZi24ScKxOHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230086

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

