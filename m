Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31054314D13
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754006; cv=none; b=Cw42usK6+4y3/TTy74dniwl1ZevwwAgSBp9iYRJfNB+aqAat/ZFHn1SuXM0sApSvFyBozr9jg6GZynwAIZLAyzjupRO1HoYyTGmTvORQ3KICHM3CJfLcnuRyGVfsWgBQ+FMadkdBwQw8e+njQUXwJ1WE4/1YN5iXepZFQEzsqag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754006; c=relaxed/simple;
	bh=hzonGxIowFUXC7GDNUxBxpE/UvBL8YFC07BvTKZ/ymc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q/8EGRvhIQds6r4gkSw1iHTEn36q4Crcvn8hcAhZqOsFNWNjbpRgw0TeTIgQ6JX/uTutNYTOKo7aFENwyczSvi3zovyr3QUjR5vLSxFeW1+0hGKf/0b5GVlg9yqlrgM9gzHbHZmIl99dXvVPizZjHbIPzB4CazNISjuwU+Bnds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WJOj5BUp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WJOj5BUp"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7dduh3489291
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Z1CmVigSTVwdLmAAU4RDDOfCyjhtN5I/aNY
	gsS1o1mc=; b=WJOj5BUpBJDjmWUsKZGytFn0GnS2msdogcKD8ubHJ/deHcOhbD3
	fABcECVIUkjwXY0Gz3zTiEEOj9drlLDDEGilDUUdJVbnrs9kq4tYKSD6dXw0DuDx
	YAc3kIhS5H+ASS3ENA0OZMEI981qDDl4/dWJmk0keN1aK+4xdSLBHqM7skDcrYTE
	uSrv5SE+auhzWdR6MLfXQbsAuYJiXc8WwHsqNDJ10txWmFTdPKCd5b43iIwFkYbi
	0RQhbGwb0HES5bSiNaJEUGlAyJnNy5orvwHhXHS8C6318YereY8UmSxczYGz53Vx
	ZIVZd4w7A/snAS4NQqX30ks7Dutdh1SpNYg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j97u0yx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:40:03 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7e14h344794;
	Wed, 30 Sep 2026 07:40:01 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 68U7e0pP344790
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:40:01 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 0E857235D5; Wed, 30 Sep 2026 15:40:00 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1] obexd: Fix FILE* leak in phonebook-dummy
Date: Wed, 30 Sep 2026 15:39:53 +0800
Message-Id: <20260930073953.266930-1-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: Ni5Izp2Ni0w2S_UjAXgKiJKBNRIh9Rj2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzMCBTYWx0ZWRfX6rPbt+lUZvXF
 Me43nN0mY2ivKE2cFkt6BW21QW5WHljJng7xpfNSNfCulKXEdxCcg5KZYV6+aYHnel0EbaoQAlU
 0SwvMKf05/wGsAWuN1rFb/nsaBYUJO6ZIQ58Qn2cGGh06JEEKZ0W2WSODwAIoRSekWkCHcNzQ5m
 PXGmN1q2tJ1b2MENDxVDP83NANzjcSQi9Efvz65izOLx+34I/1PmwLdDzlvTQ6wZB2OE0EPbMCR
 +GJql51oijF7Ae9zYivn8944fNo/JiraWNmlHkZs3GX1CpUxAU3Jl9+P+et9A39thARYsYS7qM/
 3r++MfSlOGEB+0mj8tQlHXSFwVu3CUzIEXzOacpvB0C04+GsQSsIF15BmMG+2QS1c5mBX2j6ve7
 2EPLNRsCiboZlb/7vEi8gOLQMyB2/W+dI4NcUNoyhr7Cj64qn/n8UPQj+LFxrP7wbZHORK8RYif
 eUJnt+8cijHcHdL9zAg==
X-Proofpoint-ORIG-GUID: Ni5Izp2Ni0w2S_UjAXgKiJKBNRIh9Rj2
X-Authority-Analysis: v=2.4 cv=BPImP1QG c=1 sm=1 tr=0 ts=6abcbcd3 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=lzL0-26TpD2ytX6A3hAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzMCBTYWx0ZWRfXzCqBu9zDNY6e
 5Le3Xs1cdS0cSz4fXI6kaS+x5zo2r567qCx2cuvJ1N4D9yKzFkxryD/Cj/ji5ccMcjrP6HYdbsp
 9ItDAyhGiZi2S5b4bFoNksQiYQLWI4s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300030

fdopen(fd, "r") transfers ownership of fd to the FILE stream, but the
loop was calling close(fd) directly instead of fclose(fp), leaking the
FILE structure and its stdio buffer on every vCard read. Also handle
fdopen() failure, which was previously unchecked.

Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
---
 obexd/plugins/phonebook-dummy.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index f308ea701..43be956a5 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -164,6 +164,13 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 		}
 
 		fp = fdopen(fd, "r");
+		if (fp == NULL) {
+			err = errno;
+			error("fdopen(%s): %s(%d)", filename, strerror(err), err);
+			close(fd);
+			continue;
+		}
+
 		v = Parse_MIME_FromFile(fp);
 		if (v != NULL) {
 			func(filename, v, user_data);
@@ -171,7 +178,7 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 			n++;
 		}
 
-		close(fd);
+		fclose(fp);
 	}
 
 	g_slist_free_full(sorted, g_free);
-- 
2.34.1

