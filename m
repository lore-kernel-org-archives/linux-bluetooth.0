Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559D31DD871
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088799; cv=none; b=LfRWh6UZXVW+7xRn1l4x3ELoWyQKnTdra3uJCSLnH3qrdI8+hGQmoYhEPR6MbceI+2uVTdzA0UkdpmqDQogTYoUheBfOAnQ2F+574arDC62FmRotwe92X3G+qWrnrEM76Fbk5NZacT5xt+ulryBTueK/S0a/wpKJvxnu7rtDz6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088799; c=relaxed/simple;
	bh=i59JDSP/CTCN0Rwh4Xe2xionjtNcYNTRNGFecD71usI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A0tY7CJQoFKrC4jNqcMjr+SRP8E1c109blGdV37uiCPdD5KZQzj0Z14TVeOCVGzjAbTt1GzWSMe8hzgNBufN7jB23yZgE63Q4XYXB62PZ6UkUgae6TxfpCaRmIV1byn0csEOlMDgYK+tBuoMiQn+i/QBj9rDdSLr0SIIDmqVK4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D5YthQe5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D5YthQe5"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDAfg1K028140
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 11:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lhjYg0tthSn9Y7/kVOruxZ
	1nZtS0rtVxiSLpraMolcg=; b=D5YthQe53UUpRCkPquCZx7yDOWQT/sD0OSL9Ln
	8SJ/Kk+SK3JNsxUD6En8SPbIjM4lfi6h3y1wZiI5RwK/ktiRye3rPqGh5L5DCklX
	hUJzfaYaeoB4Lw4TmRyo+YZO6F3eEt7LcBCwZxIiDo1TwF6Gvyhg9PuyKnIt5Kdc
	5pfGGq3DXMoWjj+ZPcfPw81jkglvGS1VTXVSOQ2GfkVuAmwS7vvNP+1tdDze7hM4
	iEvo5aoTB6xwEHWI3i+6vl1skptCESkOcaxmW9Z+ucfBkM9RGuFtUiMJCtQbt6n/
	jH/7APxjgdoq0T7RwYF33dZREyknyfgK8+h40cZwT0RJQTBQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fxw4uebq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 11:19:57 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDBJuxb029092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 11:19:56 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Dec 2024 03:19:54 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obexctl: Enable Map folderlisting operation from obexctl
Date: Fri, 13 Dec 2024 16:49:40 +0530
Message-ID: <20241213111940.3475051-1-quic_amisjain@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lhO5Tbqs6f-jkoK3M9gjdJL3mD8AdTyT
X-Proofpoint-GUID: lhO5Tbqs6f-jkoK3M9gjdJL3mD8AdTyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=714
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130078

This change is required for passing below PTS testcase -

1) MAP/MCE/MMB/BV-01-C
Verify that the MCE can retrieve a Folders Listing on the MSE.

As of now, user is able to initiate only map messagelisting
operation with command 'ls' and there is no way to initiate
folder listing from obexctl.
Adding a way to initiate it with command "ls ."

---
 tools/obexctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 9adf8088a..304950763 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -1265,7 +1265,7 @@ static void map_ls_messages(GDBusProxy *proxy, int argc, char *argv[])
 
 static void map_ls(GDBusProxy *proxy, int argc, char *argv[])
 {
-	if (argc > 1) {
+	if (argc > 1 && strcmp(".", argv[1]) != 0) {
 		map_ls_messages(proxy, argc, argv);
 		return;
 	}
-- 
2.34.1

