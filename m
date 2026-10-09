Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B8495AC4
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537940; cv=none; b=KsXDBF4riqCNrmrEFdXMpMhxqrIMVAnkZ7sydlqz2f9r373a//lEl3cQHi8J9ilm5JWY0Q4Z1UfSqOSh6EPnGnhh/ArjdLYLRaxXj7GVGUDidXbuxAznfszcjgE6/Ve0jxF8lFDf03J+3apSQPNV4tIzyP56h6WU1TxRaIj72Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537940; c=relaxed/simple;
	bh=QkJZkAnCdPQmj4mEdbZS3W8EAcejwFNHAvpUQHzes5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEzdd0dVIcQry2udWquNZdWqCnFZntw79IKdZsQhDKI1j2UVjgVCS5Xx8ePmfk45LZ5tEcng/YEeZKfIljFj+Bwf3RFEoqzMWiw/nDgNAdhw6Jt+0yCBmDgcc2oP+WlI4snzN1oACw2azBPfeG43wko7w4H9pQQH0f7LjUX8sao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gkIMO0WQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gkIMO0WQ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KBeo2256985
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Feq3SifI9wN
	9VTwCINMnM4Canyu7rXe9uzZu/Iz+6kQ=; b=gkIMO0WQKYQgcVumbU+e5o2TTZL
	LNbtpytwPu48r8Q6jtImIi6BgH5GpDm4MGzNAXV/IphvKvHIzmWX59TUYcE7i91d
	ps3CnaakfdJrPqiWAP+hfgPocQ9rSo1dJSKvzj1gPUtNj+RwQNHb6BWF81mfbghD
	D0v0Qpl5Ttu26UGwwNldbf0VdGNTwz315/WOXiLaUY+CsQ7+Uy2fNi82Wm2P4Biw
	mBmdpha+XDOPrLflPvd/JWIs1EqZo2PpbkWJzzdE9u9LBo+7394RhEgwW2DvhJze
	5z32R0AXwPikkqTEzmPmVp/vpQdaDTgBHjldzL/JS7jE63vQUJ6tLNZlJng==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6nufspfu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 09:25:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999PZ3U3501234;
	Fri, 9 Oct 2026 09:25:35 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6999PZbP3501204
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:25:35 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 84D8249BE0; Fri,  9 Oct 2026 17:25:33 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH v2 07/14] unit/test-rap: Expect Abort Operation in RAS Features
Date: Fri,  9 Oct 2026 17:25:23 +0800
Message-ID: <20261009092532.3600749-8-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009092532.3600749-1-cheng.jiang@oss.qualcomm.com>
References: <20261009092532.3600749-1-cheng.jiang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=afn0Dhot c=1 sm=1 tr=0 ts=6ac8b311 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=5uBmgQ58hZ1Dj-jkIT8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX2OfmEWYYP71y
 pW3A7nGOzO8Mt5S6BZij1u4Ek9cyMRHk2mIYiMSorQX7TLzdFFDC8K4TlExEf2h6vHUzG5CkAfj
 a4SwLeofwD7z3dalAJxociibiUPOX8s=
X-Proofpoint-GUID: mTUWZJbW3to7t6ZSxA1rvA5gCSrpxint
X-Proofpoint-ORIG-GUID: mTUWZJbW3to7t6ZSxA1rvA5gCSrpxint
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX83GAOHJQYsSm
 58Fr59iYoJlLyg/AhKj0ri9PdpST2OrrWoirixLFwEtuz7MlS9d8teZsZcIo+gwzXj/F+Y93TXk
 mHkCJaRbLFyQBYijepuM/4qMl4Th1jCZdx9Lk2wuTT+cgYz/5lyOuu0QKKs7sLk5Ck3DGQO7cgh
 XsJ+jifIAezgZGYbZZ6sab05dGnLDijIJ0ChP/fWK0Q2ZVOys7FQKoUEHDPpmbmJ65J1SY0JPIt
 RR9Qm8nNKIkTJvH00kOm+1cukr8NdrY+yi6kJyVpEHJyjJ19F65kSJVTO1tWAPdIb/zXhP+Gc6p
 fdtLm6T785IZWxbV44URv0njlpImrwZG4GCqMcAd6PulrNoQAFWVQFypZEl2qrBhptp9z7k32+t
 6XpRKBs+wp0HKEmYTEp6L9uHQRirLZ/651GBfbndKkaXhHCcY+VrYofGxnvKlvChMYPnjWmo1Tv
 OKXZwr+v+gf70yMAIbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090037

The RAS Features characteristic now advertises Abort Operation, so the
value the Features read returns is 0x05 rather than 0x01.

Assisted-by: Claude:claude-opus-4.8
---
 unit/test-rap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/unit/test-rap.c b/unit/test-rap.c
index 8e2759654..b05edf203 100644
--- a/unit/test-rap.c
+++ b/unit/test-rap.c
@@ -798,11 +798,11 @@ const struct test_config_rap cfg_cggit_discovery = {
  *       Handle: 0x0003 (RAS Features value handle)
  *
  *  ATT: Read Response (0x0b) len 5
- *       Value: 0x01 0x00 0x00 0x00
+ *       Value: 0x05 0x00 0x00 0x00
  *       Feature bits:
  *         Bit 0: Real-time ranging (1 = supported)
  *         Bit 1: Retrieve stored results (0 = not supported)
- *         Bit 2: Abort operation (0 = not supported)
+ *         Bit 2: Abort operation (1 = supported)
  *
  *  Note: The RAS Features characteristic is registered with
  *  BT_ATT_PERM_READ | BT_ATT_PERM_READ_ENCRYPT. Since the test sets
@@ -813,7 +813,7 @@ const struct test_config_rap cfg_cggit_discovery = {
 
 #define ATT_READ_RAS_FEATURES \
 	IOV_DATA(0x0a, 0x03, 0x00), \
-	IOV_DATA(0x0b, 0x01, 0x00, 0x00, 0x00)
+	IOV_DATA(0x0b, 0x05, 0x00, 0x00, 0x00)
 
 #define RAS_SR_RCO_BV_01_C \
 	ATT_EXCHANGE_MTU, \
-- 
2.43.0

