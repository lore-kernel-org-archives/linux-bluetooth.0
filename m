Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781278;
	b=2pDfxw4JC4trVRw5K5K0oe0daTeqITgaHbtDv9dfUKOY5lsUf349INoJkn0HOReEKsqs
	 4nxKLlZfcPWc61f7eY4I9Sr2vFmyum0l7N8a6MW8mog7vT8CBOv18zWORF9BhXlEerHKt
	 u/vRubKRi6aVduuYbYS/RVk52pyGyyZI4vV4NyYzF0N4OcRa3LCt/ErldxdxY50QFCcc0
	 iFwzGJSqfyfHMIsHzVugrsNM8Eidw6Tv58uWOakRAIpGcq9d/udKHBP1qckPwBQXeKaYs
	 toARhQsjhsVhrfWd/hCDxC0quLQiP4dum3TY3QsHmMIexxFavddOppjcpsbXUl5/OzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781278;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=60YbiL8YjKNSy3ZuLIi0mpklF2WzebRBqzE7QPAh7pA=;
	b=CXtHlJJJJoM76AceyMcMMstgVUGg5gF3lvKFR+bhpENZ8cYh1pKTYhran6cWEPPtCblZ
	 UcJEaGCGTV1lpuBIy3VVtdHR/ZEvq/XHpBfTFp1YI8c7SVLWSYP98H4Ch7AVwBQUngqWw
	 4ysLVkfFHfFLJxxQmvjhL95a8OrL3udowzlZ3HRVZ4sno817ttMiGWb11JWNcaV8Yl9NK
	 Z1Cv2RaPqWhrkdqgjoh2sPGsBtUaRAj/9DVo0K8PiL9oNKRDtS6UjLUvyqn+inz+2KIO8
	 JaiesOFhNQa6UvejeLslMcGpXvtcB9NiwMLJOXFV+DocMK5ma+ai5vwV9uAND6EwrYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KwcE55sq;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73F606A333
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E73F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KwcE55sq
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48KWWm3875516
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=60YbiL8YjKN
	Sy3ZuLIi0mpklF2WzebRBqzE7QPAh7pA=; b=KwcE55sqksa8LD7wXlfLHo9TYrY
	AK4m6pIIMK07Sstc6wF38gKLdDckw1E9DRX7wn1tnijPtX61hJ+KV1iPYWZgyxX8
	u7MYBDqDn6HfiwGfbL0TFKTT5qy5ZhWIsqG2jl7cPkt7D9O7Pz342zbYH6wt0lGH
	er5/65o9qkuwIJBDpa6AS7cktevAS2kRF/irik8pzQKCUGuAsRffHhoqCQNni9bT
	6uAxcmomtwiudDIn0hTK51UBE87CUAWpZToOAESeylKFMMAHwgx6/cr9CH4Jkaxp
	m53+Nc9hczNW2SRiGjZ8LNIXgsjUMVHsTPXqV4FKNRRvGe/b+uF07fOCSRw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqwb091y8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48YZSH2686402;
	Wed, 4 Nov 2026 08:34:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6A48YZtQ2686390
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 50861279B3; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 01/18] obexd/pbap: Fix crash counting vCards in dummy backend
Date: Wed,  4 Nov 2026 16:34:12 +0800
Message-Id: <20261104083429.4111632-2-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104083429.4111632-1-jinwang.li@oss.qualcomm.com>
References: <20261104083429.4111632-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX4TJ7ElanLdr6
 CR1aNz3juDbzYJzJg8MGMBNbsw5RZ/cSHXIKd2XlXI1SQlPXBpmkPE7rBpDtxWzLsCL9gY1+ZOP
 oQcafXWw6gUO2BZzmrnFpBbaS0dDuYs=
X-Authority-Analysis: v=2.4 cv=OfINnRTY c=1 sm=1 tr=0 ts=6aeaee1d cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VAP3BKsw3AH9pjT3LMIA:9
X-Proofpoint-GUID: XPx9innh6x6dt1fYBgsJElAEPxF2phV5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX+V7XOVEj21eO
 jvDQwU0bQdqEdet3rnxmI5ySmi1UGc4y08qTRX4pnLegLzuTdSq6ywF6Ykt43LfqejNvtxnSq2J
 fHkVHiqgX4A/+WL7qzdfWK8w1cFPmfB61iJQSCAaICE1s5EkeJ7ca2LYC2cBaTJ13P+hOKxDVMV
 n59hcTvw7LlE02PHuYTcuAsurzavvZM+Ccbe7MLMwwXZo2wh/w4ao0ObpqWt0NDOWPLT5lfxI+a
 8Zt7KJDhBYOWNNFzVjTfY/mN2jBMcelNrlGb5bm31MvKHBzxXpCiseO2AEbJ98lCygGhtpmw6ft
 RWWnL1F1TKs0n/wlFIRRQVuuNKj1m+9BKOmn1WGCH+dtFC3ROLBrO6hJl6kVbK2WYzA9cb/Yrbs
 kBydrKSq9k/z+W4BbeGDZFblHNalPQLw6jMCV9KtoEQzWpTbslF2THFofalpXRJyvK4thETvtYg
 1+2CjaAkNc+MEf+eAiQ==
X-Proofpoint-ORIG-GUID: XPx9innh6x6dt1fYBgsJElAEPxF2phV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040033

Skip the vCard callback when none is given. Counting the vCards of the
missed calls folder passes none and crashed.

Fixes: f34bc5d924ec ("obexd: Add PBAP PullPhoneBook function for dummy back-end")
Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/phonebook-dummy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 0a0ae24ff..14075b502 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -175,7 +175,9 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 
 		v = Parse_MIME_FromFile(fp);
 		if (v != NULL) {
-			func(filename, v, user_data);
+			if (func)
+				func(filename, v, user_data);
+
 			deleteVObject(v);
 			n++;
 		}
-- 
2.34.1

