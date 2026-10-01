Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A14A4B44D4
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860760; cv=none; b=oHeFmHALu4PM8wloLeE2WR1fa07z04EXG4J2wD6spzMF6x9VR3clDx6X71+YCKf3nfp1n270w/LPET7yQCzC/BgB5w+QhqvYChTaoka7VZsPAm7vphDffOt0VdlDGpgabpStnx41a0jJ+rt9IfZ4XEZ03ffYbiB8WvOH+lLspQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860760; c=relaxed/simple;
	bh=xEetg//7oD8pLUWNeUfHrnB2Q+BGi/e/bUyUeUj0jSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2WYSgzcJaauGyZpsGv3YSDXOD5lNVEVfQbo7vYtt/3o3aTWXqftnbi0HhJqI3WAH59jOAiRzbdbAgy6vtKiLhXl1AMeQOxBDledkYQkTe3mjPRQ2yhVSIw83tIT/MPUejJ2nxZbRO2z6BqASo7Dqew/KD/5/P0pbIs0nTpFy4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nmaGOy6/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nmaGOy6/"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DBjGr1511891
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Gmcu9c3OEQT
	tO3KkeOg9YnXHqxCUqS8T185DYyJci8Q=; b=nmaGOy6/qDihI/ULS2ksUrsIr++
	BpkCX7XXKcmYFoJ7y+O/o0DqBcg1+hGU5FH7K9GncGdGYKDGwAi59wgKviBQAJNq
	8b05n8RqSO+rRFCcQj3ykUOimTujg9BCgQyksQczM5e1l668JHRJ81sb91/9ZbF+
	vKcoqcOudYr1C+LakXhbTbNuuPeuWVQBcczzDB6dnkFZU3YWk3ct5/uILUcz+MCO
	OKH3LfQ7MvG+sAiauTibLB6x2T14uf+ARKoy7r7agyNRW8reaqRKFRQ4vkjKJCwg
	Gic72DGodz3hBs2HznGEgo2lGuM8Q1jqSo5Cixf6MrIzpLinx6iPky2uo7w==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h188suw1g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 13:19:16 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 691DJEsL2501453;
	Thu, 1 Oct 2026 13:19:14 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 691DJDYc2501445
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 13:19:13 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 0E5E449BC6; Thu,  1 Oct 2026 21:19:13 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH 05/11] shared/rap: Shorten the requester Control Point response timeout
Date: Thu,  1 Oct 2026 21:18:51 +0800
Message-ID: <20261001131900.707485-6-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001131900.707485-1-cheng.jiang@oss.qualcomm.com>
References: <20261001131900.707485-1-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX24HP4BJtyoRl
 14s5l0iKCD2pi3QpJlp03r3vSupCcI4uSoC0rAB/QjaFCrINKaptKXMzrIw3NS6AbRGys74bu08
 lU2kkcaUnIrmu01nxQ7bp8eRZf5eCGI=
X-Authority-Analysis: v=2.4 cv=OozaWC/t c=1 sm=1 tr=0 ts=6abe5dd4 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=wtTSjG_CABFjt5wGfCoA:9
X-Proofpoint-ORIG-GUID: 3n8YqI1ud_NLS_RRbaFZRYWIu2fR1tm0
X-Proofpoint-GUID: 3n8YqI1ud_NLS_RRbaFZRYWIu2fR1tm0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX9PjVl+vDMxvt
 D/66ymSfYU0nzigix27YxtAyG9Q1fvfnowNgXwo+j9SU7pvZmDOgcTqf3ZLuajmAwrOemPZALjS
 P+xs1enRh4hqZBLFVVlf2deEZFlW42VVE4bumz/U2NFmMv2asX480Zw3VPkCsdYv93753k5dwrS
 REdLkYKE7Cr6S/iYQ4c1A6soqE6PLPWMbP6Hm0I2bjGhtrPsvOtz63fTXAOm+aUdJole9crGmM1
 e0wgJl8gdIa7AiOBRx0i0RLiMlhjg94bmHACGzbBengZhDTpXGo53EOZT+zybYuZIY4T9YM3PQH
 cVuS5T7pp+MmoJnJIdAfpSc0+bhXP5y6txrzRaasfDkUJqpKo79uOg9Z40yg7s9dVOkMq5I+vo9
 0f4WSuLdl0qAbXQwTLgb1Yy4UgPODl8HlkZZC4JTinuVYMagAMej2j26WhpzjQtUbrt9d0jgpyc
 anAyNq4BcOg2q0rxq1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010053

RAP 4.5.4.1 gives the Requester two deadlines once it has written Get
Ranging Data, both enforced by sending Abort Operation: no On-demand
Ranging Data at all within 5 seconds of the command
(RAP/REQ/ORD/BI-01-C), and no following segment within 1 second of the
previous one (RAP/REQ/ORD/BI-02-C).

The watchdog the requester arms while waiting for a Control Point
response covered the first of those, but ran for 10 seconds, so it
would abort well after the specified deadline. Arm it for 5 seconds
instead. The per-segment deadline is handled separately by
ras_cp_arm_segment_timeout(), which uses RAS_SEGMENT_TIMEOUT.

Assisted-by: Claude:claude-opus-4.8
---
 src/shared/rap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index b45bfc9e6..7c9a439a5 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -32,7 +32,7 @@
  * response for. Guards against a lost/dropped notification leaving
  * ras_ondemand_client permanently stuck waiting.
  */
-#define RAS_CP_RESPONSE_TIMEOUT (10 * 1000)
+#define RAS_CP_RESPONSE_TIMEOUT (5 * 1000)
 #define RAS_SEGMENT_TIMEOUT (1 * 1000)
 /* Delay between On-demand ranging-data notification segments, see
  * send_ondemand_segment_data_cb().
-- 
2.43.0

