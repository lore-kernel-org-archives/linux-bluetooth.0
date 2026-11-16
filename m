Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820050;
	b=y39AaCwrP4og9FraW/v+uwLNLhb6o6k9d4x75ngHXGbOZGlbEsEgwHkVCBhVTWGkFPru
	 +lQBqjmDYBKkNCMwnTlz+NA5E8M7DHAs47tfHsXN48yVX6aCrm1pY+SMbPGOqHyKqGjZh
	 +7Jz8V6/3JsbsfMzv46tJdKmG7NjQSCg87xzCn/TXEziFfiIe0ZKDkm8ViW4PKH3bPvx/
	 q3RDmBaOe9An0mfkzvO5m+eITSVcsCW/XJ1XZYQV2INsMp5gE/chxjF9vKowL6g++Rmvy
	 YOBsS20aL7ABmriuNjcZSgroPvclfyaF+gF07uDkcT18jURfravJgBM9Q8ILj/tJDtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820050;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1zskYXc6ChCnrOAngzUeAWB10vpIwJvojfgcqiMtX8M=;
	b=JCkqskhWkDE2tUz+kvdv3xdzNxKr7ELC4iX/Schb4JU5vMBcmZ4x807q4xEyUMhWNK0E
	 pono0+qWLIRkdSNpWnRmMzT06NSDL9jms4bIFuICjusM8r1VeA/TDbc199bXdzAnLeaQr
	 JbK6LFiItvTz/uSr66Ve7DsFjjslSTwaoPGTJ/nv/AtH/7Ur9I3u76uhicE2EwWzW2ksy
	 kZACY/ORIDa4jI9Gj87emj4r6+qmY6acwy08xy6SYN293khrbuXORgZsm2ACPhv8bHl62
	 gzLyUSX8VyGXsJLKYaVmQlyqoV62yLe77vqdMCSlVQfC4h3LJhahEqi9fY6B8ueY3Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c1aIZQtt;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E0606A31C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B78E0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c1aIZQtt
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7ewF4903239
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1zskYXc6ChCnrOAngzUeAWB10vpIwJvojfg
	cqiMtX8M=; b=c1aIZQtt9wr4m2qO64roEzmJW4bCksCK1L+oxcjh+NA2H3BPadZ
	4nIWRjMZaInYhTjnqPdmZq7tEI/0n9w9gbRQ9UVGaXRp8+XednGZJxdS2jjWCpSJ
	Q9LwKC2DKmQ4qulqkHlGIYgDYB4Z8vgUBmpP1CO6VTCNIgUbhv5tX6oH2VAOKbsp
	ywdCYaz2g6iC1jEgGQubbCLe5ndOYFIw+EtBCzLZZxFmZD2pUPkc8GW0MYBogfIM
	/5VgU6TeZQQ7PbIQZJrA/yN+QjReWpp9s+SLW3S6iifZSjAa6LXLHfcnaFG74/tK
	n0DAoWF8Z7vTkO17mZBd758PdojHH/7iHlA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjwrbu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:07:29 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG97Rx52943267
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:07:27 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AG97RbQ2943261
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:07:27 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 52F01279EC; Mon, 16 Nov 2026 17:07:26 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v4] avdtp: Fix use-after-free in connection_lost
Date: Mon, 16 Nov 2026 17:07:19 +0800
Message-Id: <20261116090719.1226616-1-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX4hXeElQFDX6l
 uVLicK+zQ/temShL9vMwasXS9nq99rJdnWB8eF86Nv1WhfTj4YRhrQVV22n4vTzOxVl1aioO/5Y
 /8YrLJ+o+kzwZ6PlWDYbTsPyI68+IZDAsYY21q8oulws8Y0Mn466Tv/RobuQX8N5fNRD/nHI0Qu
 D4ka0rxl9Y9UeEjrcYR+jfXiqhZRsk9SyT/K/D1e/RiLkNxDIXCWJRU8XImzBIlQyMC8+26Vmbu
 RQBK9XDcBrFI+nEfyTO9PYtkne01H30s9GzaH5wOJzQVwixOhROs7WpvP3BwN68asOhdOBHczR/
 eP9UUZh4zjNoyg8pxZ71OLtmqunQucnMFk4NI6tcbwOHg1UUNQHIJrXlikTaWGGMpZQoqVb5Hxz
 0B1Lc18KFuOga3msr4CJAQZm1TDzNRX4ZIJ0mNpeldQ0NFmssXKZ0yrmU1rLFlI5LyAt8eqQLyS
 X12StdTz/kYHowY8lOA==
X-Proofpoint-ORIG-GUID: eyPjOZQVE3hfoVEgNmIgLuyqlVQwqCrT
X-Proofpoint-GUID: eyPjOZQVE3hfoVEgNmIgLuyqlVQwqCrT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfXxsoDrX9lBWmS
 Je4RLgZhz9mRXpVwW3cWDkfQPWVSKOlbyA7HK6LGIng8H2TnjGIYRmZVX0rQ1sogtGSh6E53p1b
 8iTyB294IwClphVCxSS9d+NkYEXURu4=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6afac7d1 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=UmovLC3t0AQPfvzBjLEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

A sink may start reverse discovery when processing a remote stream
configuration. If the signaling channel disconnects after the stream is
configured and discovery holds the last setup reference, stream cleanup
frees that setup before the pending discovery callback runs, causing a
use-after-free.

Complete discovery with the disconnect error before releasing streams
so the callback runs while its setup is still valid.

Fixes: 02877c5e98b8 ("a2dp: Add reverse discovery")
Assisted-by: Claude:claude-sonnet-5
---
Changes for V4:
 - Rebased the patch.
 - Add Fixes tag.
 - V3 link
   https://lore.kernel.org/all/20261104073210.3995738-1-jinwang.li@oss.qualcomm.com/

Changes for V3:
 - Update commit message.
 - V2 link
   https://lore.kernel.org/all/20261016071408.2961576-1-jinwang.li@oss.qualcomm.com/

Changes for V2:
 - Rebased the patch.
 - V1 link
   https://lore.kernel.org/all/20260807095809.2584501-1-jinwang.li@oss.qualcomm.com/
---
 profiles/audio/avdtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 30f80a0c2..5ebc0c5cc 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1159,11 +1159,11 @@ static void connection_lost(struct avdtp *session, int err)
 	ba2str(device_get_address(session->device), address);
 	DBG("Disconnected from %s", address);
 
+	finalize_discovery(session, err);
+
 	g_slist_foreach(session->streams, (GFunc) release_stream, session);
 	session->streams = NULL;
 
-	finalize_discovery(session, err);
-
 	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
 
 	avdtp_unref(session);
-- 
2.34.1

