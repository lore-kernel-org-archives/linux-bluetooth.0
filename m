Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6153D6CCF
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769337; cv=none; b=rVynzTChviTEgsrtSXUiSHgqf0dOnU2rF2+cilHKs3oM27NS7zhi29/xIeuDoVpgpsjzrBkWVwVyyRqByZHKk1hDeoRVgLG9BOYTKOXRZnkS1Kixr7Pa7cYMJmedRqrI264G5k+0MKIX5suGOom7ShP6tXL9o9RuFjlZRVjoy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769337; c=relaxed/simple;
	bh=T2EeJYQc1AoTp6kz1EfordRu10yhYgjWCQm9ijwF2+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A9qP75LxV3JVUd4ETiYX3cKqr5kl28IqRN+YnGQptgDNgzx1iyTlMWyaIj5tNrQDICuW9OOtsXiulewF4qXpuNf0Mzpc4nedXxnpItegx+Gme6zraaMf1ihFQmR7oO4XkCWQjRrIvuKzRkDrvFLvfsMcLaMqRm8Q6jvsL9oDb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V5ilwXXe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M0NMa4a3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V5ilwXXe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M0NMa4a3"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I4BNSq3577368
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 07:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KmB7Y5ff8dV06gZVWn+gLAe91hTwSJeX5Ap
	ofYl547U=; b=V5ilwXXeEtRwkSCRCHikz8gY25G/KZbzB/TXNil4F2DeBXrfM3F
	NFcCwgfW9PIH1IhhTBdXj66LhDXG4LoDb+Tyx8LK1GO5s2rS00Y3nZKQM5u0aUJm
	QFjvY56tcv0yHgkoKkjCqBrw8++vPxFPNiZL+FRkP7XUG/AmPisVm7b4lDO5rCUl
	Iz9rRP2ivFQMPpaiGEhZMl6D0fOuk63/9DZxZBq+cIYeZq9LGPRla1O3iVKlz6hE
	CAZ+gJFctWeFRFpg15K1AuXGup9eIH0OBn/cA/2E9D3i5xMVDDkuDnOyRgnJgwDB
	D2Snr7YIF8NeQzRqXRefkdUlHfSDNq9ncgQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7jndt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 07:55:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c10cd7df22so11423615ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781769334; x=1782374134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KmB7Y5ff8dV06gZVWn+gLAe91hTwSJeX5ApofYl547U=;
        b=M0NMa4a3Isi+VUf06JkIlfu2cl6bLpfLTY9bag/1PaXbMirK6IC4bdoh8SecWM/u75
         Vi8Q4LNkDo8QhC8PJALXqi/44oeACnM0dYQt1GzFFUrPe0gF0BxMdFKdmpuio0cmDn04
         O5K7roXgwLv+1x/2ZFd/eVVke6GbK22Z7kuPe3UctCR5Hwh/n2k0UFpwvfRqKsoUWq97
         IeL1oFo9u0sj9oT7biD/8WEDyYJqF503xfxUlpB0qfBVgPPXiA29iT/vFQc+CzatWVtJ
         t1odkIexMweOGiCynYx7JOWMBdGYCfk/8BU1H/HryYwcK9x5Dub35qiEet+UgMw2kdXI
         bCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781769334; x=1782374134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmB7Y5ff8dV06gZVWn+gLAe91hTwSJeX5ApofYl547U=;
        b=ZFA0mdG2/KYSDTH01xrfmil4lx12kHGGjXVbM7y2pV4xwRonMU/VLlTXMjoz1vpIZV
         dxsv0LUwI3qpXIf4ZRqW3t/90oG17wjPF1f2n4vwJhIXERHCzjg1kAKmkKJzm6hDIRpd
         JCVBL+Z2HGcgBk8AMPEPrePrYe6yXkY4JHrsaXsNboVjfoFn22CJE3FZAt3VKeI6HL8e
         8t7O/ur8/Wa0ghFxu8INZRw9xp0YH+DmOqiu0Gxp7UbQN+B4bWhrThiHF0DrYStc8IB7
         ls+AXy+bOi9Ldn0DysaIMPmScm2ea0BNOEUVgg4dBlbpUSPT8qjiLI97a69qggk/N9Va
         z7GA==
X-Gm-Message-State: AOJu0YwP9IBtFXfg8slEYzk2B7WaCuzLMRfADhZnGV1ZnRRbTLn++gKh
	1StUtr0D1y/nhTscjy0aXosf1eKp2diBoSlcQobv3Cq34uJH1ZYcDWeunqExP9j5fznpH5VVtjT
	lCwXvrENpRq+pUXfihmWuIfzci7xdniALXdftK0IpmeTrmL2nybGfP5hdmJpeRo4iotRu3kahNc
	3H8Qo=
X-Gm-Gg: AfdE7cmkqkSqsqLrqP+ntDLbL02wf3rSlc7L01B55lALCkdFkit62271jgppTpYzTqP
	ro9/qnUSy5PYJk/YFsg3jwBvMsZloBvzszURiomhdAM5Cm6u666QIe0Y+Gr4gbzTFrzys47uXxP
	0X9K8J0WG/90kpIjwUcCof4xcw2U4AldPOBoz0G3pP04gwe0dCb9+2lw8+3qXcBPN/47Xi9eZRh
	F0vD9cznY1Wb2DnJAgqu0l/mJfpwPAi4SP2iaBzDrzqc3PwcEDkQWJdMU4HIiQFWZDDUGPHeWK2
	+RrrYem8RSQioW/r61xIdXDCOCXymglyGiiuuLl/l0ZpxHctdE/b7W4RJK0KGhdXsBIWT4AGxqt
	rio41sBiqu0GFV6onSz0qTjIrJNfmI9Fd
X-Received: by 2002:a17:902:fc84:b0:2c2:245a:3368 with SMTP id d9443c01a7336-2c6bc0b6e67mr82647045ad.14.1781769333965;
        Thu, 18 Jun 2026 00:55:33 -0700 (PDT)
X-Received: by 2002:a17:902:fc84:b0:2c2:245a:3368 with SMTP id d9443c01a7336-2c6bc0b6e67mr82646715ad.14.1781769333438;
        Thu, 18 Jun 2026 00:55:33 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c75c3sm180851215ad.27.2026.06.18.00.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:55:33 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v1] shared/rap: Fix Mode 0 step serialization
Date: Thu, 18 Jun 2026 13:25:29 +0530
Message-Id: <20260618075529.98419-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA3MSBTYWx0ZWRfX/rystmY35m7d
 nshQkFGEFE/5VgI7abUWhbFChzFUXOLk51fi6xyoJn7PLKlz9wYcrLldFKC1tZLDHCoAq3Gcj6F
 Ecp6bpal+bAOf9iyebzCmwCXdYreTj0/VxNWSKOGorqWvQdy9VeZkpDaYLK6zfdkNWoOLo5KKsS
 tvb+WLjJqZ1gizqqdls1T4E7LJNdvFX7bG5cDsjtOsg7RGVZNQRmTgbpJ0f6XrMdkADj3OFM5hf
 zBtkxGZcAoK5suEg7+XuIHqbltQVDq7zaCbzfDXcted/BD8TSFzgx+dUBM0zb1mY4gM0UjC/rxj
 83fnKfOwwuIQ9Ih2x0jUgtUN3SiyZsXFRGETf1pVxwJTpFfw6sYfz1gs7vKVj3uLXVAI/NRNuAj
 ah7pedXLTnjZTVRvJkoTxiBVAfG+T5m5O5sP3Bq7zJ2MEM69rScN93Zu4DMsfsXUdZ2CtnyOZLh
 lMmPWXwNZG8lAn1g9jA==
X-Proofpoint-GUID: og7LvMxr2DL_nV1zrKYXNe2Qq9hC18GD
X-Proofpoint-ORIG-GUID: og7LvMxr2DL_nV1zrKYXNe2Qq9hC18GD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA3MSBTYWx0ZWRfXz0LmZVsspgVX
 OLpclRAxRch89QHbUUX6xnRpp4kTFAVRY6g286PcfF/ADXOSdW0aLWwrD2337TbkNSKvmloaX7Y
 17CnhNtTPoFdInQ39RGOL+ALBpdjenE=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a33a476 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=AtKqa8B5-W2iMbd9070A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180071

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Replace raw struct byte dump with field-by-field serialization
that conditionally includes init_measured_freq_offset only for
the Initiator role, matching the RAS wire format (5 bytes for
Initiator, 3 bytes for Reflector)
---
 src/shared/rap.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index 390fd3080..ecf7df5a7 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -1307,15 +1307,40 @@ static void process_cs_mode_zero(struct bt_rap *rap,
 				const struct cs_step_data *step,
 				uint8_t idx, uint8_t mode_byte)
 {
-	const uint8_t *payload;
-	uint8_t plen;
+	const struct cs_mode_zero_data *m0 =
+		&step->step_mode_data.mode_zero_data;
+	struct cstracker *resptracker = rap->resptracker;
+	enum cs_role cs_role = resptracker->role;
+	struct iovec temp_iov = { 0 };
+
+	temp_iov.iov_base = malloc(8);
+	if (!temp_iov.iov_base) {
+		DBG(rap, "Mode0 ERROR: malloc failed!");
+		return;
+	}
+	temp_iov.iov_len = 0;
+
+	if (!util_iov_push_u8(&temp_iov, m0->packet_quality) ||
+	    !util_iov_push_u8(&temp_iov, m0->packet_rssi_dbm) ||
+	    !util_iov_push_u8(&temp_iov, m0->packet_ant))
+		goto done;
+
+	if (cs_role == CS_ROLE_INITIATOR) {
+		if (!util_iov_push_le16(&temp_iov,
+					m0->init_measured_freq_offset))
+			goto done;
+	}
 
-	/* Mode 0: use raw structure bytes */
-	payload = (const uint8_t *)&step->step_mode_data;
-	plen = step->step_data_length;
-	cs_pd_ras_append_subevent_bytes(proc, payload, plen);
-	DBG(rap, "step[%u]: mode=0x%02x Mode0 payload_len=%u sent",
-		idx, mode_byte, (unsigned int)plen);
+	cs_pd_ras_append_subevent_bytes(proc, temp_iov.iov_base,
+					temp_iov.iov_len);
+
+done:
+	free(temp_iov.iov_base);
+
+	DBG(rap, "step[%u]: mode=0x%02x Mode0 serialized payload_len=%zu "
+		"role=%s",
+		idx, mode_byte, temp_iov.iov_len,
+		cs_role == CS_ROLE_INITIATOR ? "INIT" : "REFL");
 }
 
 static void process_cs_mode_one(struct bt_rap *rap,
-- 
2.34.1

