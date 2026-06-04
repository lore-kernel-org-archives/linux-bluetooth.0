Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79773CAA5E
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567362; cv=none; b=XPVw+16DSogxeXRCYvy9Bn59nLHZ72Uk4dQWkcDXhI+SIArEtgZTuJ/GUonwrRZCdld3Rd3ot2xVjteHsot4I+5YoIcrKc0/NrJM+t53u7d22dc8iTHPzEn8oqb8hJ7VQ8Mf/oRgAVWKzq5BLNHDxnqwhzRuOer5Gl1/1jFFxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567362; c=relaxed/simple;
	bh=oYKqjkhZlj8ckuik4w4o2J0eUXI8fGwAEUQEmSudjos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gVSwK8I7Vcc24s/Ybu+OSQZopndS83ulm89a0/AnJixY/N8xqh8cAEsijLRMbDmL9X14zrjbf81f1QJJ9O+B594OE9iAbtSt8rlIwKbylZSsNLdCgG4rv0XcLe9TbU/992QipBsjrvzrTIPLKcnXHJ9rTaiGbzKUTY2hNO+2Ee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e8zfNko/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EBz5HyRg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e8zfNko/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EBz5HyRg"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6548UX3L1132195
	for <linux-bluetooth@vger.kernel.org>; Thu, 4 Jun 2026 10:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XHroN44Kh/kUEbIYx6JTVlckmM5o11w0pIP
	O3s/fXg0=; b=e8zfNko/8VV6qorYamuvPD6rgdEzEyRfDILF5/TaBk7WAVr4nOe
	dogTbckDKFs5us1rBtXcmcmP7Rhez647GJSgQzkt1z64btTThZgmLZ/s5487TD+f
	Wpr5xumJ9Oee4jmiuf9FZ2W9v1ZjFvy7ABifIrznfieOw2SFobnFem783LhTpZgS
	VYl4cYg9uff7OCjqQ0M3Hdk9nnFn2scG1fBPDAkJKWc12i8RNJIa9WNV/ofDCSRj
	5YLyDchPsQxqT8SLwNozjoPZcDGysT/WUiZgAfjmxGYy81NJYg+byEk8rBTtFA1K
	oebO34NYN+S6MD+y9XVJAbDwnRDRkviBqJQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek5wsgbc7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 10:02:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf004bf8beso6523335ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 03:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780567359; x=1781172159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XHroN44Kh/kUEbIYx6JTVlckmM5o11w0pIPO3s/fXg0=;
        b=EBz5HyRgKUCf6GlOsV9DtZv8jpwXUIorZiSEPzWewVIFSqti5eDncNsV5YSIwbRrEm
         BF+BNxQCBQYQwBOVtcoo7si7oHG2lIpS0yfXZz1VhW1c8TFjC7laqBTDkSrr++I4kj0e
         nGEY0i6GovRry11jZ3/zyLK7q+3Xmsq4MTErR0fJpSRAaku3IaoLPDSqfSunyTKMh5d3
         lbXBJHOYL59BKj0EqJP1MHXcIOFMxa+Gbrya2vLE9A8SbFdJ9v19UquZTGlG8BpslE7r
         Z6D1/tgQ/qGy/QdrHGIskWLcOcXgzJxN8eP56tHCtBN09aOZt8n4biHoFLc4E1XH5MN8
         fh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567359; x=1781172159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHroN44Kh/kUEbIYx6JTVlckmM5o11w0pIPO3s/fXg0=;
        b=SOFAC5tLM3TGlsc4L966mlVpaUBh3TtrS9T0bGBi+tVAWVV3qtVPo6oHLYbubb4z/b
         0P81zPluL8SciTW3kARV8cDnyny+FlRv81uf+TRfXVsgSFmP3Y3x0hw/7YVS7bC+LQHn
         Dxdx3lKbaVCuwFnXiYp/eIyHSpfDyZ4D05A5/2pC4ST4j/8LZCv6XoiF6ge5wCk40eMF
         PpqyzTI2p1C0q8BH/2EC7E8p+LGSnhKnQMffYUpgFUkK2g3UzQA7jCCNu0b1GtlZlXnl
         h5Tz4EmmD1crFLECXvbIq+W4bEik38fFaS8EWc3CCMzdEJaT6szsR4Iaofl6E95W2gWc
         K4hw==
X-Gm-Message-State: AOJu0YzvIr6nMId68HwmfAt/QdX4nHciax2AwRdNLmnfVA7Xd2E4hy0X
	vRdeaMwtbvb9PR53zcD1eWwC0mDPwZc2JbqgdMX9XrH58ZJQ9zvB/9sCBfMHVgyfG4OWJiRiR7x
	HULdD6zKOL+zV+jVf8fE9/GcUNhap/gdemY/GY3i+ppkEjWjssutyIzNzsRNYgReXW4quAuzknQ
	Z8E2A=
X-Gm-Gg: Acq92OF31eoynvgVakMMbGSntgEtKjzwHkc/FrpRjc8hEKJu3sk8H3g88PgPF5Q9F8L
	m0Y2fNN76tBbdxXt2L9Shbwzs8buyjYMLuIJjMhTXezMOsCOSf3xr8o37hftn0Dz5Jk8U8rFJof
	OgxzPuRLjt3T9wflBwynXPwZw8D9ySmsZ7dcH+wliRUuOG4wzUlncqolkAIIrEWi2GNPhuC1QOR
	+vebRQ6UlB63X3nCG0ecy8R4CJMR4gvGsKXsF7lvQb1tJD3VZiTQ1RL7WvUZargg0iGf4/kfkdu
	LzBtuYIPZCQdKMKn8U3Md7E745Kh5O9qsTEyBSttmKxIARsCEUqy0z49yqdc3uild4lhVdRO3W5
	dyqkhaKF1IUOk5Q0IumdTCa5B7G+QtgM6hdogdKsTyDnQqJ7g1zYScQ==
X-Received: by 2002:a17:903:178b:b0:2bd:907:2cf0 with SMTP id d9443c01a7336-2c1644aba78mr79212305ad.32.1780567358800;
        Thu, 04 Jun 2026 03:02:38 -0700 (PDT)
X-Received: by 2002:a17:903:178b:b0:2bd:907:2cf0 with SMTP id d9443c01a7336-2c1644aba78mr79211945ad.32.1780567358314;
        Thu, 04 Jun 2026 03:02:38 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d45csm75615105ad.14.2026.06.04.03.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:02:37 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v2] profiles/ranging: Read measured_freq_offset field-16 bit as per Core Spec
Date: Thu,  4 Jun 2026 15:32:33 +0530
Message-Id: <20260604100233.4193077-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2Pq0w-VOcXvi-8iq5rvzpDEaeBKVhFWp
X-Proofpoint-ORIG-GUID: 2Pq0w-VOcXvi-8iq5rvzpDEaeBKVhFWp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5NiBTYWx0ZWRfX18r7vKbusjOM
 Esi2f5v4tlOY0L6zY5OkqHXF7YShRDLwieuRr8/tBKpamXGeXjml0ApDHVyeB3KXnruivB+tywt
 TCPC6RDS8Y6EQ8Yf92srtUxo2tmF1GNiYXJtrBWZSUsq7dFbwBDZoqGsPKWK6Gj0Ir3M8DkKNpT
 jXkiB7SlUpJP+2gqWZs7fx7NCjsHNMrF8XnTOzrCH07U2wJM27d6Fr2/ctyuHHkRgSJ6EhuH1xb
 PHCTBFkEFce16CmsqgoErQ2h5qQ8LjgiiHc1mScKLTv36/eVbHjwEXLuF6lQ9xZk5AV3geMmZNW
 f0RsGp4qxvqk9yl2kGc2o3N1/Q3q7UkiFjJwfMpvABOjdplCVSTS1nGRawMbrxNpeLaYB0C5Mj2
 LdiEebuScbWhPCX4DHzC1XbY0dr2DGfDhb7MzFBY4JIKd0guROzXnZSJk63wFquZIhlSI/2FeOq
 cnRG9iJK5lNNIOViWEQ==
X-Authority-Analysis: v=2.4 cv=POc/P/qC c=1 sm=1 tr=0 ts=6a214d3f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=E5Skqz63k400YZ54I58A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040096

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Fix in V2:
Fixed compilation issue.

---
 profiles/ranging/rap_hci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 8e65e5ef8..febe23384 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -601,7 +601,7 @@ static void parse_mode_zero_data(struct iovec *iov,
 				 struct cs_mode_zero_data *mode_data,
 				 uint8_t cs_role)
 {
-	uint32_t freq_offset;
+	uint16_t freq_offset;
 
 	if (iov->iov_len < 3) {
 		DBG("Mode 0: too short (<3)");
@@ -614,7 +614,7 @@ static void parse_mode_zero_data(struct iovec *iov,
 	DBG("CS Step mode 0");
 
 	if (cs_role == CS_INITIATOR && iov->iov_len >= 4) {
-		util_iov_pull_le32(iov, &freq_offset);
+		util_iov_pull_le16(iov, &freq_offset);
 		mode_data->init_measured_freq_offset = freq_offset;
 	}
 }
-- 
2.34.1

