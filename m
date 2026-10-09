Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3B453A4F
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537939; cv=none; b=jdZj9qPuA04OTtMPuOphI+JLfwwBH1uaOGtmzg62MvYyXvL5emeNqR5MmfAZbCQRv2oKys+boCVVxg6CvRpgjwhVEHSNHX1s8ReLYMVFbCNU5OCySeHODwrtrHFvGIi5cR+fMML77Q/mFa6G4Y0xg7IN4blxxggLx51lEjLlwuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537939; c=relaxed/simple;
	bh=0v3qPAnzJB3CAu0TY613/mCj8rHMCP14r1mpzu7amXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaMW325qOofW6UsJeQyw9kH5k28uM/X9BGwuE6ri/Z06cbBOK0QwoN0FGSlrq+4t0bcuydw0KWPzRBMOOArkPe3Vs9DFCJHd8Ah0ImiPAKD1baiQPuLgvgMIE0wXdqLsLSN8QmPsmoAsf+sJ1J3T+G34BmVhNQeupGW9uCdo1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLEMUYj0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLEMUYj0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KkX01253043
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sCzGKqmjujJ
	n+IPCd5wcpOzEAOm6U9c0P8JmHRnSF1Q=; b=gLEMUYj0NPzxaTrqiFCtvxVQivc
	Dd2t/RCmEJMrDvtcb+8W/gfSxAFNHXZ/63CGKyFrndynup307tjFs1Akwq2upqmC
	VJDeiEqdayrNhrvrMrnaXCWGc8wHNxMb3/4OTMUsUQD/8KJG1KmXi06A6w8d6gda
	bbEe8I7VzjZqDQZ54ngvyrbPdRxHkg290vCvxBNwqHrYO52YQB9z6rKwABFieGTG
	wfMNG0FacBIhJwIlhjqX0n4DIDEUuSIk58z3rT9qeE1zUjidh5qy0ozEzS2X0KmQ
	7R/z1LJthwBbMpEwYXFf1Be5cKAV47AVuwMlucaCnNva5Ui4ukpUpwju4QQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6baj42ym-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 09:25:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999PZ563501233
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:35 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6999PZrK3501205
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:25:35 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 8702B49BE1; Fri,  9 Oct 2026 17:25:33 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH v2 08/14] shared/rap: Shorten the requester Control Point response timeout
Date: Fri,  9 Oct 2026 17:25:24 +0800
Message-ID: <20261009092532.3600749-9-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX0EQZ5oW/cu84
 V/Q617c2nIj4CzVslMEj+2dauZFwiisIJpYiQVY89lOcbXj7QukNXHndFSM+OajL6WXmFMP2LfP
 aeItDU+4TJtXxgOfT5UQGqYnWSKE9eMjTuu1vrE2i0dltphgjTISZaHeH2ytDiYpzHyA0Ssioa2
 5x7jEfV7zMMJe5AqAoU/NFH6INJpjGWoj6JDeTUz9lH4q/VVEAMNqa5YCOvjqOvhLHKR5GdyHeU
 WL61j7230I8CJdfsmpBuFwtLdZvawV7T0ivPOt48V2VcZc3pZGkkbJu268gge9q/VtAWCZma7+U
 zJaSQRFs3kYZWazcjiMUEuZS5ok/AATZ5tPeadCBrQPv/Muq0j2y0mKrVFvD/uPy5qhG8SvIhbB
 +X9qWRxT8g0yzrW+j/kGK4z6QPPa0janKdPR9608ErIMLL25ubFanYyDxwX+D1Mwghc8dThqLHG
 53AKIrqj/wKXFmBFgIg==
X-Proofpoint-GUID: iyxkZKkLceNAx4PWYwqrBGD7pHcAx_HH
X-Authority-Analysis: v=2.4 cv=H/dOUOYi c=1 sm=1 tr=0 ts=6ac8b311 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=wtTSjG_CABFjt5wGfCoA:9
X-Proofpoint-ORIG-GUID: iyxkZKkLceNAx4PWYwqrBGD7pHcAx_HH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX6pSmS5zk/TH0
 FDJPSdxXeqiBjzARb84ivCZZiYc8goi+lQql7htl2vdocumyBnHdYPeS94ZSQ3ZRI13lltH+dnb
 5QPz982/QyjQikkpbbHp0sIoyDxK5Cg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090037

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
index eddf9f0bf..7d4fa266c 100644
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

