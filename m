Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777549;
	b=AtgzfQJGghFt9pzPh+R9e1O3K39IxVpzw1eQXt2RLR9P4gRyBvPA95Fh+wv1c0bFs4Zl
	 E7g9MjKdy64flbMmfbd8Yl539LX7oj9d4I6gg4aRN/W45V0mqUV9DKMKENUtwIC1SNoVC
	 YNPnz4wTgX0g9oguEzlUBEOPIEG6wssPaSsdsTAWLpuDIaRZeDfbUa/0+FHXXxi4/7TVr
	 MbI7Bo6gysefQuc+p1TKUi3cv3nTNzZmxujjwdFvU6bxSWyPdWsjcXM9oRk3sFVaWu26q
	 B0wt89rdUigDZTSzhdPayRZQn8znSDqhN9w7nKZR8ZAQCtJYimkjWme2x898zqfWMjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777549;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=owlQsvn0PmojMGqPqSKfTW41wMd4rUtUuLQTIAmMrHU=;
	b=4gXASWnWEQiRnZIiwVStmx4+oBDu4dSVHJuLPvcWjSsYGhpN784ss4FYHiixVJZ3yK+/
	 /ZrTCf8H+1QxKIIA6gS0L0nyvanCmrIN7fZoWUniO2ND5eTq68QkuPNyZAFZJSC/kJyUk
	 gz2Wg6StMi+uFUXcZavyJelZYhj/HDsHpkkqg1AMIfiYet+tBicybflPInTm1v9yxKrap
	 tdenCWDA0chBVdicSHfdw7nvItLs62KyZoScC5wO+ZZR91Vv+94sDrvxQVj1SAmqWy7xL
	 VtvTnaE2mEXOy8bMJwcRTFTOID05NDucNkviRPspj4M/jv49PfzZt6WecqNs8Dz0dmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q30LwWTj;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51823606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 07:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51823606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q30LwWTj
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A46qt7Z222113
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 07:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=owlQsvn0PmojMGqPqSKfTW41wMd4rUtUuLQ
	TIAmMrHU=; b=Q30LwWTjqqbrsNwrKNgnB2+HPK0MmIQShcDoqDTwMe2+p5jiJg/
	42cCktmWZuu0cRBmYozwiSNU4rrDuBPiSCXGlQR2uktqz1hhBUdTTYuJ7w91RzsA
	X2JiKXqA2hSVT3SwjYkvXxqh/nuQFX55oLXDz7TVuZiA/wGrKW1y9IKf3L5DUoxm
	IBRdtzqYH5MsojCZh2VojjlZ/4HT2KRF+ey0jFK4FWTumr1NAtn0BQAwXNwKJ++k
	/EiSmnrN0FYwBmXvOmHlNzohVjjOPRCyr30itT5tWyxlOaX6cfnpfUvndTU7ygc3
	feVUO/WrjGHW8hHXUTXyym6L4RRapAEz6Sg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqjubkcrx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 07:32:27 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A47WPog2611467;
	Wed, 4 Nov 2026 07:32:25 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6A47WOIp2611462
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 07:32:25 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 00A502468A; Wed,  4 Nov 2026 15:32:23 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3] avdtp: Fix use-after-free in connection_lost
Date: Wed,  4 Nov 2026 15:32:10 +0800
Message-Id: <20261104073210.3995738-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyOSBTYWx0ZWRfX1uGK1yNg/EVP
 KsjWNhwniNcnKymyBwkS7ihw+EU/WKMIYFk8BuRFOzSkBMdKdpgwMT6zWyjD5i1UcZRmBS7Crgp
 evQePmY6PaT7NcHU9S7BMf8QWvl4L5c=
X-Authority-Analysis: v=2.4 cv=JeUpPkKV c=1 sm=1 tr=0 ts=6aeadf8c cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=UmovLC3t0AQPfvzBjLEA:9
X-Proofpoint-GUID: U2tbmc7UQBEblN0B9wYn2I4m1lx7P0PK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyOSBTYWx0ZWRfX8Rk7GFP8b84o
 b2kzw/MOs2mzt20BM+/MQwF0HVDTIsbB3Y2J4NJz5XiH7yIujP7u2FIWBdGa5TSEDk03eosoqr+
 nc+SiTZYqKk0aluLzGqbxUCxQTaHua8wzspJOeT02K24xykSpkN3u5GLmGEZjbwaKMCBl2QOv67
 ss+Sp4WM1R4C0/+odSHbW6eOzk/EmEFTv9pTUSUCXjBcCS8Uuxya7jUkMjEuRaqOOqhGAYhLJSR
 wh2jFaLtYAwYPxOoZswbSWn2L70tvWdkMlYsdv8nnevBoTuSuLK5fH6Eg40maHiiWq3oMOw3gZy
 xKwnq3jHsJ7YNyIh0JLmPWwZB62QUrqqDTlIL+/vSReA96ypk2SNRwC1sJTeCK1FA5zuSaIRX7u
 mKebCgowsfykJZJnbn5txQv94z5fMB3viFGqYIg2CjLKs3uBvJfMPwM4owfHMh8/UlFxgifC7LJ
 IVHXRXh2RDVx7XiwhLw==
X-Proofpoint-ORIG-GUID: U2tbmc7UQBEblN0B9wYn2I4m1lx7P0PK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040029

A sink may start reverse discovery when processing a remote stream
configuration. If the signaling channel disconnects after the stream is
configured and discovery holds the last setup reference, stream cleanup
frees that setup before the pending discovery callback runs, causing a
use-after-free.

Complete discovery with the disconnect error before releasing streams
so the callback runs while its setup is still valid.

Assisted-by: Claude:claude-sonnet-5
---
Changes for V3:
 - Update commit message.
 - V2 link
   https://lore.kernel.org/all/20261016071408.2961576-1-jinwang.li@oss.qualcomm.com/

Changes for V2:
 - Rebased the patch.
 - V1 link
   https://lore.kernel.org/all/20260807095809.2584501-1-jinwang.li@oss.qualcomm.com/

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

