Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020520;
	b=q+8QTocoDbjk17Ixf+h92MLqNhP5kcyUF7UmDHCxx+dA7piX6ZkoSJxc7UHMfsPEhVBy
	 dcSUgQE4m2/5cCebFkZ4+g+xAB90fCrHaaAAv5fyLYfhnWgTClMFi8nQeVIdytKyKb7+A
	 54vTRUm2lo/mIvU0GYI2JFyHeqMP4mNYbLsZMgFbh83yyJ7cshreNgg6bYOhEdlfMls7Z
	 8LZ/dh5DsXiZfUij4FI5g2szwJ8+sXyYzN+xQSI5DdDCjRsWvyJD3YK0rnO4iBrstZsYs
	 7EjHsUjkdIRsKdlICwm373FQy/qzktqmLbs/nhtIfV7+iWqncRo7vPWiZlUFpkoBp5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020520;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kUkyUSuIgjE/j/ihfOPBaBYIjQMXWBPFs3B2zaeEruc=;
	b=eaf/AfWbvG5J465m4fYAySEzqJUSJKE6E/93iGmh72Ed0KuEVxwOYI7UFT4/jdd7jG+z
	 c2FVwIFbq83EsbJIz8Li5bmcrKk+Zrnb/uAfXZw6bPCzICz96iN02YJFbSsfL2XnIPyRH
	 BGAh2CPGiPV4A+SqgQgNIq2yBx2+yuE+PtCxe4YXVA6HwMR9O6CgFMBUka+mmB6RYdNsf
	 /5SrgMvSrz4YQaZkUtdXk2B88XFMaBvpWS2MvQlPiEiuMe3gvyTcmzhz3cTtmj69p1ifp
	 QNSxruWOJAF81nLxVKpnBwAcE9seM4xgDgIUfvmLYGWZwaQF7KkGn8ujS90lLW2F9zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VZMQtoLo;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26D606A320
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 13:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F26D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VZMQtoLo
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAtJE02541787
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 13:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kUkyUSuIgjE
	/j/ihfOPBaBYIjQMXWBPFs3B2zaeEruc=; b=VZMQtoLoGoX8PN1YxBfH4fycOXL
	rvAHX7qvFQlbu+M8/Qw6Rh/d0kvgABc9mpD6PH5fqmX1qO1P+ETGO/HiGCtZPEqR
	6RkihXRBfzFSm4QsakUqbx7847zX3Sew+qLt65anj6JIBw6KDOpo3LWO9Us8i692
	3zJ5xdMRmjGjNqZYIM4mIWCgmrVxrg+ajFg/QzAiUtiK9S7w3GlgVbnPirdaIICj
	7OU6EIHYDqDmUIkOYYQjEPZxuYCgo+sP8tnGSIQj5X/KpbfJcb3MvCu+6qUozGcG
	y5e9vXtCLoZkWBCN+wfCHzweZFO9djwdF+Lk0nyO5RA6Y23hdPVphPpsVXw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsjdajy5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 13:15:18 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QDFGL84072114;
	Mon, 26 Oct 2026 13:15:16 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 69QDFGmS4072101
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 13:15:16 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 5CFC424352; Mon, 26 Oct 2026 21:15:15 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 2/2] obexd/pbap: Report NewMissedCalls for mch
Date: Mon, 26 Oct 2026 21:15:04 +0800
Message-Id: <20261026131504.1016687-3-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026131504.1016687-1-jinwang.li@oss.qualcomm.com>
References: <20261026131504.1016687-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: -hUly-CS8L11-h0GPMU9BjVn_zIIXfo5
X-Proofpoint-GUID: -hUly-CS8L11-h0GPMU9BjVn_zIIXfo5
X-Authority-Analysis: v=2.4 cv=a4elZkSF c=1 sm=1 tr=0 ts=6adf5266 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=RC0GDIPlSjbg_uvlC-UA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MiBTYWx0ZWRfX7z1rxRlJzUCL
 311QY8BC5ZnqpD35SsQ8L9Nll0YH4jiYhDfjUHlIJnreMp1DgypH3xyBjK8ZGV51ZOec8znenYD
 m60TUhu4mncHV3MCJIzAG3dXJuY+1Oc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MiBTYWx0ZWRfXzraoBjDA3h00
 jxUB0R2NKdxoMmxqdYvHdnTH14JBwqkFB1l7eRE/HZIz9SvVAlbhGLHp8zJfQvVBW4C7MGH84JY
 QLk9zbXqaqwmZe2q0fAG+i/DT47QJWm9eO5+AubQaRGra/f04book2hGqgIWSovFLNe7kx9jtLV
 8pgdClOOHhOGbb3nJHtqJSonupUeW1llC1xYeLW9juJu8SGQejM3fMl8jIr0PdWryTuc8bGw47L
 ypfUhBW5c2r//nG3HA4C/MoKtt5vulwwBJItIACRxE9VzsibG04RAe/v0QG9gFigmDjnODaExIP
 04jBLIZfhN6HwCIRw9V/hnqQ9+bU5XjiRqIhAK1KFAkkhiXuXImFGLdTpVHufIfF79+1H82y86f
 38Bcf0U5+xUsu5BMQVek/eCdaqsYd9BYHiPmivmsNzcW5DNiOEtsU6fBzHdKqFwXSs21OnK5TYz
 0tuNrG9N0KsHpn7OLcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260052

The dummy backend always reports zero NewMissedCalls. Count the
vCards in the folder instead, capped at UINT8_MAX.

Fixes PTS test PBAP/PSE/PBD/BV-05-C

Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
---
 obexd/plugins/phonebook-dummy.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 782b8948d..0a0ae24ff 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -41,6 +41,7 @@ struct dummy_data {
 	char *folder;
 	int fd;
 	guint id;
+	uint8_t newmissedcalls;
 };
 
 struct cache_query {
@@ -244,7 +245,8 @@ static gboolean read_dir(void *user_data)
 	closedir(dp);
 done:
 	/* FIXME: Missing vCards fields filtering */
-	dummy->cb(buffer->str, buffer->len, count, 0, TRUE, dummy->user_data);
+	dummy->cb(buffer->str, buffer->len, count, dummy->newmissedcalls,
+							TRUE, dummy->user_data);
 
 	g_string_free(buffer, TRUE);
 
@@ -360,6 +362,22 @@ static gboolean is_dir(const char *dir)
 	return S_ISDIR(st.st_mode);
 }
 
+static uint8_t count_vcards(const char *folder)
+{
+	DIR *dp;
+	uint16_t count = 0;
+
+	dp = opendir(folder);
+	if (dp == NULL)
+		return 0;
+
+	foreach_vcard(dp, NULL, 0, UINT8_MAX, NULL, &count);
+
+	closedir(dp);
+
+	return count;
+}
+
 char *phonebook_set_folder(const char *current_folder,
 		const char *new_folder, uint8_t flags, int *err)
 {
@@ -490,6 +508,9 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	dummy->folder = folder;
 	dummy->fd = -1;
 
+	if (g_strcmp0(name, PB_CALLS_MISSED) == 0)
+		dummy->newmissedcalls = count_vcards(folder);
+
 	if (err)
 		*err = 0;
 
-- 
2.34.1

