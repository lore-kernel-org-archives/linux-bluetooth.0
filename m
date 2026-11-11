Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390279;
	b=YDevsdXM9xFKGBDmGRaW3rQFWlQ8dy42rKJGiI7qBb6482m+Usx08gjcfuvZMcUdghvA
	 melQu9t33YKZ6E5wTLxi7mueoqOkX5K50SSlChMR6x8pzxVCdpGTTwoPJUsTzdfkmWc64
	 DCmntSVlg0Kio8admDsWkYvhwRpjrHwti1Mw2ukUXzOL+P+KWEDNwv9s5TnU8v18dDyEB
	 ClcyG6RD8jKf3PzLFkZz0nzuSHTjCTf6fB8GuQh2jT45XxnQ1N0qFK+m1Wo0l83vxEOkp
	 tIqp8Czq+9SgTvtBORw+QeaZQSr2FQZnfNvTrPErXgYgLyXUWNRO2fs3c4Wy9Kndqng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=t4ywO/tpxwJairUDsNvNMEhxX6BlQvs9pFLBDVnDn1A=;
	b=ypxL0rrNzvbyowpok2r9tq1RCTS6wFSy9miFnmpdOn1xXPygt/BdCRMWYKNiWsbM6LGr
	 lf2b3/yG+l7WsPnxWMGZpjX6asT/sUONYl03fSyiedY5eWdWrKkg9NgSYiywnWfVdKusA
	 C651C72gD0v1+A3Yp+uTNx8bxKC8Xx/r07mcHyCYFWH7epHXTzO1d/qOjsw/SW3rXoW3p
	 5kjZYQbrxGzvLVahnQJDVEpMFsNWDwk6TZ/ARRvKU/hRtzixmAoe3owbM1pZVWlvxF09b
	 psIWYoAjKDjqKg4DiR8zmyDviK/R5xHzagWC7TZojEjG9fVhxErngygA8YKWZeya3zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f4UjHg1q;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A43606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1A43606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f4UjHg1q
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KPsC864189;
	Wed, 11 Nov 2026 09:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=t4ywO/tpxwJ
	airUDsNvNMEhxX6BlQvs9pFLBDVnDn1A=; b=f4UjHg1qmD8HEzZ3daVPKPpXPKO
	tZvFH1aknMCIvxcNiu88ljM9Fnk6johFASgN1cpvUwglCB48iIbEsL2DjFREr+49
	yNeCUu0baQsLm6cAYk3nmC/Cz76GTytfNpb9Ns9DRIve+KqJl5AL/m3gIr/rHkjp
	81nHUKxGcDgMNVB1pbdFoNwjEBQ63hAkF3Ct6uUXXmE4AH5CkvmN1MVMtMKGQWOy
	RW36wPkwhXn3GULwrM4xmA6YOHFv5Mz4fzNMnBJ3X0eokzThgHOCkK1kSWR3u45h
	6og1tR6JsZ4AiVQG+NDjHs8rVFGSV3BCtoYEsMByhLGGjmtfj/HkD3KJYzw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawhjct-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:36 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iYEx2424158;
	Wed, 11 Nov 2026 09:44:34 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AB9iYmj2424138
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:34 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 39B9B243C4; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 04/20] obexd/pbap: Fix Tracker contact grouping across requests
Date: Wed, 11 Nov 2026 17:44:09 +0800
Message-Id: <20261111094425.1444893-5-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111094425.1444893-1-jinwang.li@oss.qualcomm.com>
References: <20261111094425.1444893-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX3qQo9N9Cs2iy
 CeTEVKsp+Eoarz2eu8N2+vdHWfRXqX5KZmd9stdwERtXOMQRXHVScPdN1DOspWUal9Z+B8P4Vye
 5zmPSbR6DxLKuMYE6DyL6FtWmLKPuPU=
X-Proofpoint-ORIG-GUID: yFBq7TBX6Zr51_qGrXJoGNFj0gz4iEpP
X-Proofpoint-GUID: yFBq7TBX6Zr51_qGrXJoGNFj0gz4iEpP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX6XAH7ybUdlTG
 AO5vYDbMki93IcG+l0odiXzADT5hxjwwiBUWqrAUMlcdSBJFSuOIe+khju2v08aFu0ckjcTtLlq
 gSqmHb4QX6OARuo+58o9BjjXih0F4t/JD/LFVxqRACv97f78oEzd0utfTEZqQ51G+FEbxDorGMN
 4R8nB8/KjYHLlT2BvXpaKSyMuuvh2w2LVU6a+dt+7XBO4qAPEU/zeWibM9hwHPo47SHdPr2KZzr
 9n/iES/Kqr2XUe544bHuXUkR5ZEaqQwfRfnsa/MB4ASGco2Or7dNt+O7EvWzC0jGZY5nQjFAR74
 oz8/0nDuQ4tZAozXlFG8GSf9Cr58bK1kyC5dI0iNbxoqc56982z1A1T56SRFvJN76TWi1YIzXie
 NIu3Q50Cds1Yq0EmhzOpSfoJXVyXaZqrDbc7aHoAHJeaUDlGX+JUpydkJalIlyhsO28/m0myb4Z
 s7mbPV56Z54inPtmB/A==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af43904 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=cF6jKGQ7yb2NdpciS_AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

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

