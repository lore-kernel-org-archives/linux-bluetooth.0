Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085076;
	b=gdmZGvq80KfLeDWECyKGMM2ynQmrCyLQWEQh7oVl2VqOg8Oat4G8FD8dpT7xdwgwWWtJ
	 MS0fqO+TDqv63RuoDoNKHNVDmxbstkcBB6wToM5C+Ik8rlmV6AphviIDxWtZqSrjx1gNM
	 31yrUbcpQBKFAk9KhZJ2Pn6OTP1M8yiunMcZoQpLoazbFKu96c53goa7WxPS36FovHs9Q
	 2MVrq09s2NAluuGjF+GR9maRrsEOlOhokkSYGBBH/loJqBFwIwDa+0ohWzQxojj7pRVFE
	 KBzAzQjBeScJh839mL+kr/b+D+Us2uu6CCA2iQKa4H8pCskxZPrX1ZhCC0vQ1EXAJpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085076;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kUkyUSuIgjE/j/ihfOPBaBYIjQMXWBPFs3B2zaeEruc=;
	b=qtJhsxP4kmukCGjsl1ij5SV+VTwamacLNTE3hph1Bm28tCljLDcB8eCAQPexhAwmSwVG
	 z4JXITDQYKpge8tGOhvrteqpgfBM+C1AtrepZ1DMmtrQohUYQ9mVhXl7VtOE6GMA8h6MD
	 thbQXvjCNJ2DWvLlpxRkV8d9WeLEL0hfaOZq7aBJbx9IUB4vcYJUsb4Wlav8HbgEJtbbk
	 Y+EmEA7BUoVzcpGDXreBLQAWWIdvcl8l5h6s9dMVWXfUfX8wiJJKmQOoa7gp7CFZByOI9
	 Ol0o5YZt+rwAX1DbeEdKUvgY7qYc9QBsCJum3L41haWuWG774vpz4Tcxauc++CF+4ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eSOhbWzN;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E42606A323
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 07:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0E42606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eSOhbWzN
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5Z0up1244798
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 07:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kUkyUSuIgjE
	/j/ihfOPBaBYIjQMXWBPFs3B2zaeEruc=; b=eSOhbWzNe8SZM6P33p/QTZtDYNE
	ujaV35bRPZfy429FNEPFI6SMTpip/y+Hkyl+o9yxAQTN+UfBjTZGhd6thaLIu1hJ
	NGcBS5D3lXpxZSb4hxT8Lrj4gLIcyJAAbU8xoS0HarR9EznK6vxmLMtoWcF+6rTb
	F59/+CO+cleUaQUisJsC/EIGAmgZilZUEipLNf/SASuSUrWW1kX6GHQ3fPR+4I/J
	cvHosuBjHusjx+Wj8xpAR3tyzycjK1468KOCGdkKGTnqxJ1itPyZJ4ECfLn8sLJt
	6BEcLKC1evZwtwzQMYLs86i69nbcfJdmEYZnxKR7uNrMOWWFoKXKPXi2z7Q==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y43mt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 07:11:14 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69R7BCE41202837;
	Tue, 27 Oct 2026 07:11:12 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 69R7BC9C1202827
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 07:11:12 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 4B261279A5; Tue, 27 Oct 2026 15:11:11 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v2 2/2] obexd/pbap: Report NewMissedCalls for mch
Date: Tue, 27 Oct 2026 15:10:46 +0800
Message-Id: <20261027071046.2272116-3-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027071046.2272116-1-jinwang.li@oss.qualcomm.com>
References: <20261027071046.2272116-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyOCBTYWx0ZWRfX0Az1HGrrg10t
 uez7EM91w/TaZxZaiMUGgGjvDq8WBQbvh2QxGQ85L0k++8mt+7holGpPsvLIgfyGvvty78k+oLM
 QFMgcg8ARwVv7FQIthU/qfXMVTqFnzA=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6ae04e92 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=RC0GDIPlSjbg_uvlC-UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyOCBTYWx0ZWRfX2ENJja6DfhLl
 dmjJxs7DJG0mDLuwltmCjweLabLpC4NFVFOnSGVBmCPqHhBroH29/otG/hSqzTkpsshScpWVWIW
 04gKHzKy2iXaM4Jez8UkbiN4kTawJOh2pCCxjDZSZZnbKxLBHylOoL3BAbPeCFgegq2DQHPzmq1
 HupgHr6Y1uLVERbASEzDd+sjllwBG8zK58eOltaF4KB+lczrd9IuZ39hK56BeMD0Q1fWoJ5f1sr
 Lmgn7oLfxIqYxE6rnWD6jwmPkE0i5wtdLRnistymi5kXlmFKezw5+K5sgngNd5GiqcYVDrWTKMl
 cERWRylMOFQNxPLJ2lN0bezHg12XD4idjLsv3eKMY0YtA6l+IXpgWdiN6uQF5WS2YtN+I77RT43
 VHDeMn3aJW4u89U9JpRgX0naKL3eDuUhOX4Twq3uC7yTnSjpv+MZLfvrxMljG7U3BdsfByYosou
 necxK3FR7hnwvDuW13g==
X-Proofpoint-GUID: Eiz-12Fav6tjk0sTOH3bNPWA5uiykxkw
X-Proofpoint-ORIG-GUID: Eiz-12Fav6tjk0sTOH3bNPWA5uiykxkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270028

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

