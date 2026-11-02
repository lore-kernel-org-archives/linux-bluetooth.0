Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607569;
	b=KBqzIYClH8I6vZEdympK/jmOdWG/WQzWMW0J2vZ3rIRpT7p4BJbnLuHUnp54/OlNcZOn
	 /WUvAWapo6KX5blnylhkzbISnGFyZkYl3mBsvYCfH7jUrdhWwvV7dvRYOqA8Mc56njAej
	 tprMhUsLrGS1zfRqnJRGlyOPKBGNHVUq+Xe2hijsR57yitA0Lu5zUknLtzGclBTMQjU2y
	 Z3txUen+xH46xMbTpeqoN4FRF8MefAXlz4OADLKB6p+DgroXxxjzuqeyv1k7LMsfvCO7S
	 FB1y6vaiSrZ6QfEJqnU0W+H1C9jqWcYvRGq0cgvkeR1t5itQDBsDpf8AK1sWbiWmwyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607569;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Pp9SwEoF0w7UqYrW1i1U3dpRO98tswqTnqnM3qM33tU=;
	b=Yf5FEvro2yXmRpefV/wry0nrlbZMd2OdfouHDF2ScbpgjWhrBHgvi1V6ADJOJ4WDH6yU
	 t0YCeKuYN2e05HgdXR+sZbGIojk0p8+qA4EdnqZMzuVzksfLQj+Zucg41mC5paEky8JBk
	 371N/7p3U+rsJpkWf3wL2YPLumIbz0uRMfjmrsh69tRLH1zCVgD4ksgqwZKaDl8fyzVg+
	 768NLqq2Yd0yURSyX3XlYOm9QvvgUITUs/20T47HfsM4IOI+xz+wv4Dn5o6BpcTXD/lci
	 RUuJV8IpKeiNK3rcNjk+OXLd3uSV8YPXg0a8Jz8dDbIzmZrcbHNZrDcX/ABVff5WqVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="N+84/u3E";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B6606A330
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E6B6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N+84/u3E
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A23vHMD3324636
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Pp9SwEoF0w7
	UqYrW1i1U3dpRO98tswqTnqnM3qM33tU=; b=N+84/u3EB2zBHT8vRwG64ylpSBQ
	JcpofvkPh35nG5a4eWRbraeRiMHgoKFWH2xylvapdv9/lqceCK/yw25mkw7o38t/
	ClF9557WTrrBZXbLeVQb/g3FdPw0sHmZd7p1RQcYi9w9JD5U+gVXYWnazRJEiysP
	WagQUF+8r76qhpVPlS8t3mcZK9TOY9oh/XrcDoisA7VnoTDQMfXAKNShtxP5rRWu
	3b3ddtarQ00IINof6mK1Lz6C0NR2GppY5TblIWAhlKpDyydm4zF32M3oV4Hfk73L
	S0TOskjhxLjgbn2rjIAPw53QyG0l7Oy+Bb8AkHbeMiQCoi6PB4pnCj1Jsvw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6p1a0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:27 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JLa93331080
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:25 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJg63331043;
	Mon, 02 Nov 2026 08:19:24 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 11/15] profiles/ranging: Keep a peer-driven setup from being rewound
Date: Mon,  2 Nov 2026 16:19:08 +0800
Message-ID: <20261102081913.1623864-12-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
References: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: vGJprlFhe1lkiwm2TyDI5QLJnglLCXSh
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae8478f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=fC1j6ta4CTHgTbqikQcA:9
X-Proofpoint-GUID: vGJprlFhe1lkiwm2TyDI5QLJnglLCXSh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX68qjE0MpQnKs
 CUV7SpX+eVhxghaMbpk++S9ZPx0xptDHGfQnE9eAJ/jd8Npta0dU0sYAxxiI83BCeOnLH3dWeog
 v10Xtf32XoeBdbayB7s28ZsB9VsdQsw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX0zCQ6sBI+xhZ
 LtzdlrhkR0VVVavpDRTzzvBHuAdk+VdZwjyAEcUuGPnx+0bUscykt2FiLIECIpncE9YimaNw3TV
 NWhMdTkselVV4RxrUJbuhhq7qx8gLYB6zC+k5f4Q/n1WUdYAO5FvqjdbL7HFj5+s98eT2FuIzwU
 TF+x6qKS2TSchYODdguILbrhT/RIkhHbOGqic2a4gxg9pkd7lefgVnNnnAH6CfaFNXxbbAVqRP8
 MHpLGD5YWcoXAIlWBglsSLKkDG3n/4O5r90mk9HGkFan+I6MwUXN6wvVAczoEdcozSTJA1ihxP9
 Hr/8SkHDrtAe9OO7c0x41lrkpjWXNeHV7sOPkJ2rxaUmwa2vB85fX04HIH+Xh5vTBKO5jGLfXah
 ehwZ0fERK1966kSsB+fNaGEsYv7coMsDRoFO4axr5WzWTb7wiXpLsdnOQzyT7hB8zr60uCUd1Al
 ZEEA42p5HxXN/ODMptw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

The Set Default Settings response moved the state machine to
CS_STATE_WAIT_CONFIG_CMPLT unconditionally. A remote Initiator does
not wait for the local setup phase, so its configuration can complete
while the capabilities are still being read over the air or while
this response is pending, for instance when the local Controller still
has a CS role enabled from an earlier StartMeasurement(). Its Config
Complete now advances the state on its own, so the response put the
state back and, on an Initiator, created a second configuration.

Only advance from CS_STATE_INIT, the state the setup phase is in until
then.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap_hci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 39b167ba8..8ce7f32f1 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -537,6 +537,16 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 	}
 
 	if (rp->status == 0) {
+		/* A configuration created by the peer may have completed
+		 * while the capabilities were read or this response was
+		 * pending. Do not rewind its state.
+		 */
+		if (cs_get_current_state(sm) != CS_STATE_INIT) {
+			DBG("Setup already advanced to %s",
+				state_names[cs_get_current_state(sm)]);
+			return;
+		}
+
 		cs_set_state(sm, CS_STATE_WAIT_CONFIG_CMPLT);
 
 		/* Only the Initiator creates the config; the Reflector waits
-- 
2.43.0

