Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650CA3D88FC
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563232; cv=none; b=S3Ou1p22k8G49WyCThXWcurYQC0vz3LJCDV5M9c0qGbaP9IiUX70GjhDv7Yqhvnq2iPwqFw7RI+DAB8W8dGmLZMTjfOCprrShMsY3UjL0lPP0u5+eFXfAFXEA4s2mxiflt4OdP8VBgzACHZR3BDzJWFh+08seIGQPUFCUm8GBLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563232; c=relaxed/simple;
	bh=dIiMryYUw5Mv6nmZs7bwuYgnOCyqej9E4eqjLRZGidY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XoYJ+xJ5USdcT4qbXADhg0ZCwlURBlqAHmZBa7gXg1DWCZX1YV4LMzNgJlorJb87XU+nyiUGCVw54hqqhfeEHuE6bYOFo9o1sEx6O2sGHPNIBbgfN/9V3pmzlIiZfeZk3EnWocI5VbldcUUu6WSxbZ9fXTI7ip6zcCrTYV8BgqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dc3+aIbR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V7uyNyLO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dc3+aIbR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V7uyNyLO"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6548UaEw1132273
	for <linux-bluetooth@vger.kernel.org>; Thu, 4 Jun 2026 08:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=yYpJ1gy3lLFaLRpcQNikyGtUus4UkjRx4lU
	r54+HldM=; b=dc3+aIbRC6RuciIeJzLZl+e9bfzAYWmcis8Bm+hbcB8+d8bLS0X
	bCYms3m5rlmFiC9QrtUSmBIL2qmyUIWX+gYQg+T6ibiRVTsvpTkD6qsDK7ipkVNj
	MqDbIDJgUoFYmVkJ3oadcfAFCNa5s+B7Ry/6vcYLAzkUU90UVrtTpGtJQMFfC6s1
	T8a6ZwwbOd2kJRq/B7noCFnHbycHkgchW+DCd0DDM1fruTBu3Tdce06hSY+oCnRy
	7FyAI0o73+DdN6LQnGAq5lszgDJ52M4heTac6vKDFmiJH7KDEoiG6JqHS13bvB+s
	sG3IDuioiW+En7AGb55JX+NnAHeylmBCnmA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek5wsg2pb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 08:53:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf004bf8beso5769135ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 01:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780563229; x=1781168029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYpJ1gy3lLFaLRpcQNikyGtUus4UkjRx4lUr54+HldM=;
        b=V7uyNyLO6tRwrop1+fBAr8cMVaTSRqw1Gm5/xbQ9Weqx1ex+9zGwXPg/PT+Sb7TATn
         tE5h6TgeWHQVmg+xZ1/LeWjkYC5wgJdvHC/cXeTNieyUPKlR8zsz+hlDIQ9M+3vWXtFA
         7A7fJXqZeRgzC4SS2MfMVstjoNPKkR4SJ1/3RCm9Sw4+jwAeoj+ARZ8IZOKKU80Ul59B
         h/jo88FRG22eYgeODeND1GqV55rEbZp6HM3jZgygMcET6cuLGpIeDGd+RPzp8XXIFV8K
         xwKD8BeTOVsQirp5qI7tXHLFkmORzuM1BozpW/nakfBbxSC3tLgEH25ikvP4epZnpptz
         i7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780563229; x=1781168029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYpJ1gy3lLFaLRpcQNikyGtUus4UkjRx4lUr54+HldM=;
        b=DAysuDm6FwCiH8CULHViewtqKxPfh7oC4m78BBQ4cUBfZ5RrSKBoPRLx0z9/DlUmQW
         D/yxJmAJeXRJXRtcMezPSeNEDJZWJdSiccVIJbRBTwp4oBDioBSCPWlmBFsNRtml16eK
         F4gv3uU63az2X/NA5XcF7kEW64czykubeJDUkv9ZOcxBMlqszhU/TXy9P3Xllb22LW9z
         8ZocmincLhqQX+jbbdRRoQ2Bj1COggxb1T1s26QVxHKkzK80r3a10T1DZRjnGRFVpX57
         9iaizm88JNhZTHPKoJouR7QIw/CU5KBekD3GoDsXh8SvF9S5aBk6qvJpJ1FYdUViEHo3
         43dg==
X-Gm-Message-State: AOJu0YxCTuTNXaYMJH+nw0LmqTi1rW2h0wniT1KKGWCVY0kxepy4XhTg
	YY4FvcyEZVtBGQm0ApmYc9S3RHWrDYhtPFflRw8IW4362uvOYlD+tsbNsxBXGffDbZaze5BuntO
	lywXTFGprqXjBl2dhROy98ZDzrW4RRsvMpi0cTtLhTvZySKzhjAb7djmq3JHfZmIxhOxJbnyXLL
	8QyFw=
X-Gm-Gg: Acq92OFqVPWM31DroHQBGxEHxl2qYO+6/AVLuLGI7nZ2ebn14QfG5so487IFQ8zjWC3
	ONHfTvcxoYbGZ42dSysKBOfGKD16UifRxOLeYzDPVM+uNQTEa3VsuwqvdfcaeVZQis0o8EXiJdJ
	NRzxJYKvJ6FkUHmOqOPU/BnjqSYMkX1UUzs3/zvzObzYnylPewtK7ZDoaWfXDx16l7mTXj9ITBP
	Pd04ll7ELbSFk5j5vRMNQt1h9RSOY8BBeGt673JcBu9k3usFnHJ6Ht/l1DbrufUUf9vDRze0v0H
	6bJWmSgjCfxe6UyBCP7EAxK5rCTDg2+sl3u0di407izZjN5KmjO3wdVcYrVZghWRtU2tIvxneg+
	0cjczwfc/NKsFVG5rFtfiS/66DnErls4C9T4gYGDsdhk03YjDHfhSgg==
X-Received: by 2002:a17:902:ecc9:b0:2b2:3bb6:fbf8 with SMTP id d9443c01a7336-2c163c5f630mr71433025ad.16.1780563229177;
        Thu, 04 Jun 2026 01:53:49 -0700 (PDT)
X-Received: by 2002:a17:902:ecc9:b0:2b2:3bb6:fbf8 with SMTP id d9443c01a7336-2c163c5f630mr71432795ad.16.1780563228707;
        Thu, 04 Jun 2026 01:53:48 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8792bsm50910925ad.23.2026.06.04.01.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:53:48 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v1] profiles/ranging: Read measured_freq_offset field-16 bit as per Core Spec
Date: Thu,  4 Jun 2026 14:23:44 +0530
Message-Id: <20260604085344.4135265-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Dgwtf0UdxMqOmAieTyZfaO9FXqDoVvnS
X-Proofpoint-ORIG-GUID: Dgwtf0UdxMqOmAieTyZfaO9FXqDoVvnS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA4NSBTYWx0ZWRfXwRmD9lgeezjd
 Tc/SUn4iTsu9AZlbsmlo9Wi/KauFFZgNBHaWMTIJ+q8UBQjkQCC0k4M2zmCKBoLKjYAbhsfj2Yw
 m2bQAcrlspZy2ZW2GsdSaMW8H6Zm90ajOjSu2+V/Eh/fXuDwTILE2OBztaPgDB1KT7OCE2lPnRY
 DsMUfXNxgOyioeiiPzLMxB78p3ZbyGXhT9RKu7L7YSXUtA7lMTt9cBJPHOVreNjt/TQkFu/M+3r
 WxjXOLi5a9g9lrxCPI9VefqVsXl7mYdb9iylsF9EJrU6VT9DI3/55bQC8EurEwqGYAz/E0489zg
 lwmVed7tLHSIk6IX6j/W8dfqbgb19MlyiG4u23V0mh8SKkemvppv7TPom7VhNGPf4xgRMVUmj2J
 ZMeUodtVlDOV+q4uzs07HFhFtSlx0gjfvlMMArRsrPESXh7959byphhfxG411AnIiYXIgSeFIsk
 FYUMJvKDw3gY182ovGw==
X-Authority-Analysis: v=2.4 cv=POc/P/qC c=1 sm=1 tr=0 ts=6a213d1e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=E5Skqz63k400YZ54I58A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040085

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

---
 profiles/ranging/rap_hci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 8e65e5ef8..23678ed98 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -601,7 +601,7 @@ static void parse_mode_zero_data(struct iovec *iov,
 				 struct cs_mode_zero_data *mode_data,
 				 uint8_t cs_role)
 {
-	uint32_t freq_offset;
+	uint16 freq_offset;
 
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

