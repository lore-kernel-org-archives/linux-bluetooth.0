Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781279;
	b=cmJwfuBkXax+gQsFTzq0LJeKcmv9IgciC16hU/msP8kLAP9NkgEqZkad1miNOJfqhm5/
	 wlcJA7RwTsf0H0/i3+Omf9qjYudzIvCfgUPqrWvgI9gdStyAKEKgHPzrap1qke2YAPA6T
	 md+wmV+vrgm+DqLrKAK6qVirOrkWg4tie9tcaa3h/158ihfFYLQzIQTTJ6GZfvMbVXPv8
	 HEPDBsbPv3PTPnCCIYEr/TFRySJULCYrE7RRkrlFL1gizRaecbvN2yhR/UbEQ+6db9R9Z
	 C6yJzbsQ51BjCA57A1Aj6RUkS4QLu8C45zfPsfkyepBqaP9LeKJ/Mi7h1FhxFU7xGvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=t4ywO/tpxwJairUDsNvNMEhxX6BlQvs9pFLBDVnDn1A=;
	b=x8hdSANX5gGJvjxnf0L4lvB1M0XQY9CtCqCHbQAcmpCmMWchxRWUADindu+pLj8IC7Dh
	 BdvkQ+z7lFYRvXGrzJugFHYpS92QB8zlS2UYuljHQR4IoKQSrzV2Ry9eLCIxXvxF0NAHf
	 dNsbMVBOjyS19rW/3GWoxrBkyvt4tt7Z/yglvDuHxAJl0P6fwS3v07gqSKx4olTFf4jt6
	 Z9mlLzTIDk5ecMr6yvAHx2vHY2UdFgxOWJAwQpcDDHfUYqAnk7aha2+xY4vvjLzLT3rT4
	 ym22PfT3VkDMQGF+4WMk6NQ/J4nMuxx8EH1BoCUqA5TbpPS3Q+Um6LV+PcjaGA7bc4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BYREVCIB;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E59606A329
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21E59606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BYREVCIB
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48KeMq1849220
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=t4ywO/tpxwJ
	airUDsNvNMEhxX6BlQvs9pFLBDVnDn1A=; b=BYREVCIBT4A3MCG4jmTdfdRRWyS
	vZIWB1hUKqN4G+GUpV60BM/4PAhTt/Dez+AEcqUQg4de2/L+ROFP/2nCra1Ocbb8
	5H0eUB4XAr7RAp7tn9gDfz9pdq0o2ETr5/iZnpuLRoCANpMXt0uGbEa3l5RWZoYd
	5NWorx455+juDVmVDF7J/Ap/+9JIwVF0loS18es1VqKtD2tzEQf+azPa1iH2fpU7
	sW/Dtc24L1s1+197ehduTJxLh+OAV8lhERUJO4tPZy/vpzO1KyI0XV1AGHEjvJwe
	OizeNq96wz4ulEqnHUnxWeDypSXEatLyBzIyWgAKaFWE1LjaY/VSh9OCWdw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqkgpbfwq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48YZp42686401;
	Wed, 4 Nov 2026 08:34:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6A48YZVA2686388
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 556DD279B4; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 02/18] obexd/pbap: Fix Tracker contact grouping across requests
Date: Wed,  4 Nov 2026 16:34:13 +0800
Message-Id: <20261104083429.4111632-3-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX96hE/hpjy3E3
 u3GXGwrlvHuek1VDPARNCD4WFj8TVCdTCGShhW0y458yy1rXy7fAzb5QBTyfdBzB8H/MJeR6C9D
 cRqe90W/Iuieo7jFl5QFrWGAHWNyiLAjnH9h6BPUWWkdd3TxSPxg2XqkWs0hCm2iMN0WmFMCsSi
 y0qwrpw1UVlfygz7TPxPE+qhakA/qyU1xi1yV6xNtVCE0w7K/pZSJGtPzjpOJWFHLSrTc+5UEc5
 jVDmJqKC0yhQS/XPtltClEZZu9+J7lP5RllFwP3itKnceqA/6xEg8jrmRkkuGJMUW8n+/NMewm5
 n+vSQJG5tEEwYh/0+5ddF63wT51iSrT6ECq71ZCZxgNmRJ/q/fl2KUETcJYNGoHcZATS+95d0qg
 RB3IkpSEDg1PJvvtx3Scc9Omx6kiM50MNwisqraN7QYJzMfVHIp9hM+fxZgwGvkQqs7OrpllFAw
 JbcL8uQ42EkiM2xpihQ==
X-Proofpoint-GUID: IwzH7lKZ2Q9UZ8fIEwlJSNrChSNjbuH-
X-Authority-Analysis: v=2.4 cv=Yoya1IYX c=1 sm=1 tr=0 ts=6aeaee1d cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=cF6jKGQ7yb2NdpciS_AA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfXz6W+zv6Qy5XF
 7RGoOBzgL3tQqwTku2WYvQbOkxksAk7rJPNBUev04frTed7HwdKeP6sRcwOVGwiybOv7jyV2NLT
 4dQ6hj4gHzT2Mt42Xi27wwIZLw2QZIA=
X-Proofpoint-ORIG-GUID: IwzH7lKZ2Q9UZ8fIEwlJSNrChSNjbuH-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040033

Keep the contact grouping state in the request instead of a static
variable, so it does not carry over to the next request.

Fixes: a8eb063b1db4 ("obexd: Fix pull phonebook with non-zero offset parameter")
Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/phonebook-tracker.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/obexd/plugins/phonebook-tracker.c b/obexd/plugins/phonebook-tracker.c
index ba0940c40..5adb52a11 100644
--- a/obexd/plugins/phonebook-tracker.c
+++ b/obexd/plugins/phonebook-tracker.c
@@ -491,6 +491,7 @@ struct phonebook_data {
 	uint8_t newmissedcalls;
 	GCancellable *query_canc;
 	char *req_name;
+	char *last_id;
 	int vcard_part_count;
 	int tracker_index;
 };
@@ -1250,7 +1251,6 @@ static int pull_contacts(const char **reply, int num_fields, void *user_data)
 	struct contact_data *contact_data;
 	int last_index, i;
 	gboolean cdata_present = FALSE, part_sent = FALSE;
-	static char *temp_id = NULL;
 
 	if (num_fields < 0) {
 		data->cb(NULL, 0, num_fields, 0, TRUE, data->user_data);
@@ -1288,10 +1288,10 @@ static int pull_contacts(const char **reply, int num_fields, void *user_data)
 						TRACKER_DEFAULT_CONTACT_ME))
 		return 0;
 
-	if (g_strcmp0(temp_id, reply[CONTACTS_ID_COL])) {
+	if (g_strcmp0(data->last_id, reply[CONTACTS_ID_COL])) {
 		data->index++;
-		g_free(temp_id);
-		temp_id = g_strdup(reply[CONTACTS_ID_COL]);
+		g_free(data->last_id);
+		data->last_id = g_strdup(reply[CONTACTS_ID_COL]);
 
 		/* Incrementing counter for vcards in current part of data,
 		 * but only if liststartoffset has been already reached */
@@ -1359,9 +1359,6 @@ done:
 	send_pull_part(data, params, TRUE);
 
 fail:
-	g_free(temp_id);
-	temp_id = NULL;
-
 	return -EINTR;
 	/*
 	 * phonebook_data is freed in phonebook_req_finalize. Useful in
@@ -1568,6 +1565,7 @@ void phonebook_req_finalize(void *request)
 
 	free_data_contacts(data);
 	g_free(data->req_name);
+	g_free(data->last_id);
 	g_free(data);
 }
 
-- 
2.34.1

