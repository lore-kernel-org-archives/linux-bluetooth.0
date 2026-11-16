Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820018;
	b=H2Jw3l9ocx0lnVqH8y+p7CZyEyyZYuHRiHOGTb2jMJGAR9l5rK7k9zdAfmqtvlnCwKHe
	 w9SoYUD2DGZNftlMJ4ZLgAmxNbVGO9rPLSgnLRYEvT1tQjZR+a3es6lAY6lMRPgm1XNTF
	 SjA9fqDynCcSqx+VZqJddoEeRQffJYfwP/FGLq8SWWBr1sbOM3VliFBYntUJi3WYgz9xP
	 HJSxlLcIztgMLn2sYL2+/DVh+AT5D2/XmaisHyWsHTj+itwUUXBJnBmB0AVaLLw0HswpR
	 zCOg8fvVLUtvMdIEsWf3ILu7Vz+uFmZk3cA7Q9FvnJMPVIZc8tjbQH4Ktr7EXzc5Rzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820018;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=t4ywO/tpxwJairUDsNvNMEhxX6BlQvs9pFLBDVnDn1A=;
	b=T19yBQyKfrPax9W7FyBwfgKIkhuXGkpVfMiv6xkoqFm7yWoKiJyFAHZEdHeCtWORpdxF
	 XdEXdDxkbOET3r96z0G0oqkBObOLVYJHxvlSLEU4qJTBCJu7t5hE0zTrePnguNcBS34dZ
	 PhhrG/OxayEgqdQ+hmgFZ+Dpidy6NdezGcZ/NNKyiTxKhGdTqG1SICbUmUCneg1bRpbcf
	 0KhjR0yrILlbFzBaxn7sscwfFe4gQ+o1ErDGWzQVhECq7I6qIPsL4OFDAjLasy3UcJ7my
	 3ry39OQ/KdCFsEWvFstxa/0wDcdUY5exRZTooJserdDpZRDqLtBk8cnM771LaW7K0Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="VG/p0W+G";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35E3606A331
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D35E3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VG/p0W+G
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7esh7903121;
	Mon, 16 Nov 2026 09:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=t4ywO/tpxwJ
	airUDsNvNMEhxX6BlQvs9pFLBDVnDn1A=; b=VG/p0W+Git7eQEoLdY2hdMOJsk6
	W02mv9lG+4KS9TVF1tmAO2aqGYTPOIYNeAOcrq2CFaspH16TETIVqZMzZNM3bePF
	0HMABiwYocf6mJPssP0CWjNku2WEQtrqnO3YK7tqehtSmO2X6S9f35oqgMA+bKIU
	VQQN3+KaQOFNA/37sSWGlgfYXfJTBoR6WE6NADKe/rtNiTq5qum4GQQM4XtkwVyz
	XovXhnQ3P1QxN1Brpe1NRVN4mF3mCJuE7Jt3VzMtilE3s9b/hlKngG1hYXOPY956
	p1yy0K+SV6sdLAKeN/Ual9Bpy04qXNWX39zC4CBaQdzc5kh5OM1jEqQ/4cg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjwr8c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:56 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96ss52942729;
	Mon, 16 Nov 2026 09:06:54 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AG96snN2942707
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:54 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 8E25C279FF; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 04/20] obexd/pbap: Fix Tracker contact grouping across requests
Date: Mon, 16 Nov 2026 17:06:18 +0800
Message-Id: <20261116090634.1222593-5-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
References: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfXy/ittgYm3jAg
 uL1zZCFmhXbFzV5MdUYtntoR/FRHf3jSAO1BcD4YV6xB8TGW5cyUGm8x5FWrsSJU02AdO4iuIPS
 230xg4RZ8TK8BHLGa5VIcYFdLzQ5oBMfoZlEfxGj6XtbCzE9J84iVhw6NtOGRcm1uI+OEYKpQVk
 1nTlVNHgpfBouMBUo1WE/50uPDM0ChLg7XHZbEvw9lUaCJCauwvrJGaL1KoDwKRbx2AM4Zhakyh
 1nIQS5jgJRnAHCmywl1CZxND6OOAwfjPHHDclNGCCf3WKN9eapVbRH2HMN9/tmTv6PHxssWpdyN
 NQ3HwGcA2edcDqzqrQp1NZznqvb81nreSIiIFeug5Scdu2lYJZhelUldIPv59mchC0fmUy89W2f
 hDIJWeW+6p4JPzh15AcAsefBv7NgnuxibPonhrD+kirD6132i9My0WFHtcLV+oAM49qUaGI/epj
 9WGelS3nA1C+5oBF57A==
X-Proofpoint-ORIG-GUID: JLyYjGoLjVvbp0fN2GKa3z8tJW0467Hj
X-Proofpoint-GUID: JLyYjGoLjVvbp0fN2GKa3z8tJW0467Hj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX3AlAtLjHeDu9
 efm3S5ChcyPexUiRcjIZ7BVfSWwq8CA6doSw0GxZuxQNMOWFNeMTklVqUiTbHZ/3PUqAyghsR3H
 /dfwyawgEiktfu1Ibd200RfEIllN0X4=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6afac7b0 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=cF6jKGQ7yb2NdpciS_AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

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

