Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CFB36998A
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780370246; cv=none; b=us10eogHeZuN+VGha7hoVtHZZ1KGh2MdO2AjnMaSqtCpuSFOX6LWVy7RU9DQGteSeHCBUPWPFVW81jnh+Nl+04fplFjCoV0ReiK8nL3Tg/lkd1LcXKdmpBUNt8iKrPsDGkBdK6aUNxHcrOd/i6ZvUOMrbU2S3onvyNeW+BVjnBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780370246; c=relaxed/simple;
	bh=oVbV5Su2s+v2hXNEnT3ZEtMwbOvcuilYpNB2wUdKosk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XCfzDYjfCqTyWpXd3k+Zywi5ZigeeXAITkj0YZAtSQBVwHuuZ+3wZgqm9JnzjUHRYKwBumO5UfAG4kc3WMyrgGmJzndLCYMLl0JgWm5PdbZbmVGevSgI5PbzW1dJK48/7MhNibGIYkPCImX9EfTyv9pIiz5h+rN7isi5my+u2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ama8WOF0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RZJz5jM1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ama8WOF0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RZJz5jM1"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6520IGOJ1214107
	for <linux-bluetooth@vger.kernel.org>; Tue, 2 Jun 2026 03:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UDDvKHgxFBn
	1S8syfq5ZSeYI9idGHW4qeyRW1wcXkzk=; b=Ama8WOF0UGbJHXTzdaZcm7GXFjT
	C3nAQ7CdFVYAywOcv4GF2kUp6/G5kSkJI9eoqA57qm8P1Y0GoEc9CcMBQaXdPZ+p
	4HNQqqVKT8LVWekhk67JimCNiO8/JdrrJ4ClKoCDzu2n4/OhgWc3RTD1lS3i1SS0
	paDzsCjWovkqDcU7ZYlyRiSvheZfLq+UJGS8/VGyRY9XJvaxsuJh65V6PCyOWlY3
	r/EIM5tpVsDF8TBzZF3t5vRo8a8Ko6DJ7FBA4xVVyvqurLYmxhNYIqHZW+PfS9AW
	USe4EXI3+oN2D4jkkxcj/HGwHi2/92mD1mvPMBgAaAOLQhrF4w1tpKK4ylg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6s9c91d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 03:17:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304d063f80aso234807eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 20:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780370244; x=1780975044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDDvKHgxFBn1S8syfq5ZSeYI9idGHW4qeyRW1wcXkzk=;
        b=RZJz5jM1LZzta8vCrQ+p9DhP4RxSvPLzdWJ1AcI0NiKCNuYXINHDCVHikGUYfzxxfo
         2XtKQkVBldpei90z+WeJ5UhoTYob0ALfGHShiimOSt3oHiOJVDTQ8/GvmoEBu5lpj2aL
         fe4Mv9SgbHYo/1lEEZ7QLlxCN+owrLKwTpiq6Z5j0cXV5QeOD5Enazjoeqw1hUcoIS7D
         V8saTfktlEI6M8Rv9Yk8S1X65nxy7KXVPgXU2e2AM1J3tlyCMPjo+wYf77pmk80VSsaD
         fAtlMOftZlw0KrWDduD7h+HWjXXYVoIfS/lVMQbdnBPnlxB9+b4FvjPQAUVz18vMB83l
         SaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370244; x=1780975044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UDDvKHgxFBn1S8syfq5ZSeYI9idGHW4qeyRW1wcXkzk=;
        b=bErwauh+p5q98DCeCBzqv6xnetKZWDK4JDoJ9ceOwLFOBb15XmkQnZiyc3Trx85Q+r
         BdGf/BliPIcIIUb7fdTBPbW6SPqZ9crTrapW+5TdCXFudJWJzWPhyiOljqRkE1Vgj0Qn
         dGBFsFLJ+y2UUMGsiHkDWL/89VQu0kF6RNqVoZ8zqCuIX9kzG+xEc7ybloN459Yteece
         WOUsUNLDzg1QRYa23vRFSlj2hjv5AUxrkZM8SH8rJvYHozymghycZmwal/jHLV9Kbcub
         6mRy9/Ctj2QYsxRl8U7K/BWPKSvR3uB83XQj45RqJVxAon8ATRWnWh7tTYr4Vc6mbcLQ
         zkew==
X-Gm-Message-State: AOJu0YwkfsgITPYpY1I4YlHDidwFGYZ4eha5oaSI94yjU/uCM4D/IR9U
	+DOcOIoNa3K2MeK7RIOrcl7BD+ChT8+GhdA7ZKGdXn07VbHoNOGnlQBJ1luHAWBINdGGrcYfH8L
	W9gjfjSyLSpgCdWSdJUuo2McpH+gMSYRdZqKiEpmNwyLcdp5A48U7Y6CQp5nICmrkUcjWU68T65
	XBHUg=
X-Gm-Gg: Acq92OGEPolVkw96uZWR7b3THIIDQzunzPPUVa7hzQ7JDVkx4+ylWx7+gHJvpAlzf4G
	NsuHOrCMr58FlMqDWxhqp7tX/nNIFdGAHcTP9MloFP6XN5EFWzv7AxjF8uygMweZgZsJJr3ki+h
	90sHWbg771JVv/l5BVKgXEl6mU51cbkjg3WPnHZ1S0bSNOweAO7mJCbRvRtfDpexfm2+PJ7s+NM
	GYRDrrzlts1u1t3IXm8+Q8fMvTl3KNevGqTpA59AfUBGh348CEmJB7FLQ3Or0ro/T6jBCzeUSfp
	q+Zq4/o2Yw8oRp02F2ZWGnk/7qU1JNfIgWgnp5F5aRgauYGNe9uSX1sPB0ilotTERTny3n3Sy7g
	4Zn7SAEKHtI2FhNg2CcwcPF4vlam4M7ivJNiNEckzVL203fKJy8uQ+mWuSXr7t3tkOW4dOe58Vs
	cmkifX6Js=
X-Received: by 2002:a05:7300:d508:b0:2e6:b55a:76ca with SMTP id 5a478bee46e88-304fa30cb81mr2943660eec.0.1780370243589;
        Mon, 01 Jun 2026 20:17:23 -0700 (PDT)
X-Received: by 2002:a05:7300:d508:b0:2e6:b55a:76ca with SMTP id 5a478bee46e88-304fa30cb81mr2943653eec.0.1780370242989;
        Mon, 01 Jun 2026 20:17:22 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c10c1sm10153582eec.1.2026.06.01.20.17.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:17:22 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] profile: Set L2CAP IMTU for external profile listeners
Date: Tue,  2 Jun 2026 08:47:19 +0530
Message-Id: <20260602031719.679979-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522054015.431152-1-wei.deng@oss.qualcomm.com>
References: <20260522054015.431152-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SLxJgUFoHsQw7sD4pE_1c8am0C0CEW1W
X-Proofpoint-GUID: SLxJgUFoHsQw7sD4pE_1c8am0C0CEW1W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDAyNyBTYWx0ZWRfX8MSvFB1SP/5Y
 xd8eVecbnvqUxSs19iP9/fgMCQoz0xORTarh/KsuzAgWC5pE6uGgiLyX9uLCQLNk/a6McVGctQU
 bWPGKFCqptGN3b1WVnFXwLpo3rQ4jbaVhg4uwP1k80TpvHIIKg6a32fPo6QP8KC/HaPUw2Lw3t+
 KsKFHOp6PDwlYkwdv47XQyAZoVILNXE9Rf0pks1yWN51YJaA7ZBMdsHtHC0w86afDinOeU9lTSG
 rUEgLn2D2dSj+dwULPMQ46kzcAxokvHY06232D23pDdqxl9uXbTmZg6wkESR95eBabdRnp1+55S
 NdlbHo68O+0kEN0azcAn1Tbx85gts1dYVDT2q5BcfWfrPQ0lxawyE/+vgf91To+a73NdeQq+PzG
 rgBi2wzoP42Om2NlOy4eTOrPTldzM7mtdT0o9TjRTQqUec3iwo5/TfNGll6seEnDokhJyPTBIgh
 A5AC+oMpMW4y4Eg59nw==
X-Authority-Analysis: v=2.4 cv=Zo7d7d7G c=1 sm=1 tr=0 ts=6a1e4b44 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=wPigunPxW6rjwJ9Gu7kA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020027

bt_io_listen() in ext_start_servers() creates the L2CAP listening
socket for external profiles without an explicit IMTU. This causes
the socket to use the L2CAP minimum of 672 bytes, which is advertised
to the peer in L2CAP_CONFIGURATION_RSP.

As a result, when acting as a server (receiver), the peer limits its
outgoing PDU size to our advertised 672 bytes. This leads to small
OBEX body chunks (~669 bytes) and severely degraded Rx throughput,
while Tx throughput is unaffected since the peer's IMTU is not
constrained by our setting.

The obexd client side (obexd/client/bluetooth.c) already sets IMTU to
BT_RX_MTU (32767) for outgoing connections. Mirror that on the server
side by setting BT_IO_OPT_IMTU to BT_RX_MTU in ext_start_servers(),
so incoming connections advertise the same maximum receive capability.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 src/profile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index dfc5f7161..297959f3c 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -55,6 +55,8 @@
 #define MAS_DEFAULT_CHANNEL	16
 #define MNS_DEFAULT_CHANNEL	17
 
+#define BT_RX_MTU		32767
+
 #define BTD_PROFILE_PSM_AUTO	-1
 #define BTD_PROFILE_CHAN_AUTO	-1
 
@@ -1411,6 +1413,7 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
 					BT_IO_OPT_MODE, ext->mode,
 					BT_IO_OPT_PSM, psm,
 					BT_IO_OPT_SEC_LEVEL, ext->sec_level,
+					BT_IO_OPT_IMTU, BT_RX_MTU,
 					BT_IO_OPT_INVALID);
 		if (err != NULL) {
 			error("L2CAP server failed for %s: %s",
-- 
2.34.1

