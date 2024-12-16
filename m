Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC149146A60
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362630; cv=none; b=sCYWFgblAKLyq8YaUi91mJI4cmVmeFkBc1pNhxU03Pz2M/X6nKdLUzkzsEwr6ncjzir/c1p0HY3ZD0T9d7oW8SPumVEn7uPsZeL6AkQEbQOAqL3OV3jAg1mnwetED6QVoEzDkbsXKhdspIQs6SQYPkxvepUAQEhsLETURcBVdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362630; c=relaxed/simple;
	bh=oNaJ+VcArlPvBvkDHl0FO1uozo75zxpx92i076KDv3w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Srgb/9o+bFkXn25nJiPvz79pasdNc49kvileycH9HSsZEQiAZlaURvWe64f2bKfq8gEOyBvZHNsmkbhSoOhg0HvNEoARmt1TXQkwsc2Wrc4LhB/J0hUlsZTTz28p4htultZky7u72QJ+MRLz13dS5lm/P4Gbb+ob0/7VukiiwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OdrDcLP5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OdrDcLP5"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG86kHb008709
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 15:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rfo00E12+1jv2HiY7pdW5q
	mVQETDDc7VMjry/k8j28Q=; b=OdrDcLP5p5sCnGNrAbEwDjvkNQksdiArD9Tl3l
	UFYthc5656kB5cP2mg0LWcRHuTPl/3b0nM/6LNKLi3aFRZIsk2Lc08W8PZX34E9z
	vOAiJfyq05ZNZ9NJss1acplcXfUCeaJit6lOwAVIMdpPNlMFboBqntOyrJv3PQBQ
	HbEt1BhcaaohVcGuHSMMybRDHizmN1u5acCJvPrywS26q8ZsfLmYzLIdnWwMDI4k
	opeI3iM4g48I9Pm49r4BPaKrag0m9lqhGnaykSfUNQfjO+CSnd3In7cEBSyOhAOG
	gstSFHU6qD3em217BMmyuEnAZF72s3+jVGuw2knhGCgwktzA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jgdj16wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 15:23:46 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BGFNjVs032298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 15:23:45 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 16 Dec 2024 07:23:43 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v2] obexctl: Enable Map folderlisting operation from obexctl
Date: Mon, 16 Dec 2024 20:53:30 +0530
Message-ID: <20241216152330.2579138-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-GUID: FK9ZQpnf6hmpEKWEngD_M8-Fl_UXRCif
X-Proofpoint-ORIG-GUID: FK9ZQpnf6hmpEKWEngD_M8-Fl_UXRCif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=872
 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160129

This change is required for passing below PTS testcase -

1) MAP/MCE/MMB/BV-01-C
Verify that the MCE can retrieve a Folders Listing on the MSE.

As of now, user is able to initiate only map messagelisting
operation with command 'ls <folder_name>' and there is no way to initiate
folder listing with 'ls' command as second argument <options> is
set as compulsary.
In the obexctl code, map folderlisting gets triggered only when there is no
arguments followed by 'ls' command.
Therefore in 'ls' command, make the second argument as optional.

This change will also enable pbap vcard listing operation which also
gets triggered with 'ls' command with no args.

---
 tools/obexctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 9adf8088a..0965762ce 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -1873,7 +1873,7 @@ static const struct bt_shell_menu main_menu = {
 	{ "pull",	  "<file>",   cmd_pull,
 					"Pull Vobject & stores in file" },
 	{ "cd",           "<path>",   cmd_cd, "Change current folder" },
-	{ "ls",           "<options>", cmd_ls, "List current folder" },
+	{ "ls",           "[options]", cmd_ls, "List current folder" },
 	{ "cp",          "<source file> <destination file>",   cmd_cp,
 				"Copy source file to destination file" },
 	{ "mv",          "<source file> <destination file>",   cmd_mv,
-- 
2.34.1

