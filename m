Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE835F180
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777463345; cv=none; b=DNTRiUsW93SxE/mKoWHaSypIzisfKIjeZK7d/A4ZmMUHq2ttoSP1TDsbVR/RWzD5gtBvDiPYxE2qf8RrF4W//X86cLIddIk3J71if0YZOvoWJHWZXkfsydzXqs7dzXGKl6Ea6DS0LlpXEkHodbPStQfvqKaXikfjrb0ucEHqEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777463345; c=relaxed/simple;
	bh=zUSSTjyWT8HcNhmb/fH4BZVTlyDefK97Pt/QddigXI4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VFGgMWkKbQ8d4tp27nLpB6kMSaD1Ik7ukkvPsT6mRhyarFZ6Fk9AvOXxx7V9rzlWkStOtdeCeJpQowO+QFNOhpWDpu0a1JwGVpMAtznCbKckhQjbwVekJyJjoaYlZGkDuNrRWnx2rFJu7RHTnZZcN54GwMAH5/HUEs5pDTPvVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=moj9OXtk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="moj9OXtk"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8qjds2016313
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 11:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9301AaYueTtLcg5Emshi4LuU++xJ2F60j2x
	dF+xnejQ=; b=moj9OXtkvHJBgKJJJzIxTqHINzqfTQhq5h01I9nzdcbCch1aYfX
	HaSsunRdtsn9DVgFc/eyq7W7ZNTduURCf1KMoZEq8RUNsDMbNEhcR0P0L9n3VKT6
	wP0En4PvwKFf8O0bwFMDH3ILvkQiDlQBIsyAHt2R39rYDxUmXeLEEbg2uQcVkD2b
	8upohUuOdsea6xXLv3g3CWtrNOA/sqSXo8X3QByzeW9/dYYk1Q3P5pEM5F72FaUX
	F+4El4M39Do87zTloYvZiWpLPtMUu81ggicMiX+V2ixEafiO603LTscmsSaXgLE+
	VsRgqcHNt7VSquVctxspmJwr8u73JVTgucw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du1eebm91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 11:49:03 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TBn1Gi017723;
	Wed, 29 Apr 2026 11:49:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4ds69w9kuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 11:49:01 +0000 (GMT)
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63TBn1Zo017718;
	Wed, 29 Apr 2026 11:49:01 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 63TBn0ef017717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 11:49:01 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id E7E9D23B8C; Wed, 29 Apr 2026 19:48:59 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
Subject: [PATCH v1] gatt-client: Fix use-after-free caused by reentrant client teardown
Date: Wed, 29 Apr 2026 19:48:06 +0800
Message-Id: <20260429114806.2337081-1-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=C/7ZDwP+ c=1 sm=1 tr=0 ts=69f1f02f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=PBEFc830ok6r-yBR5OgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDExOSBTYWx0ZWRfXyUUrsaDiQWCU
 oPiRRmoOyW26Zg4YMca/0oI/YBv4QxUFw5aAZUNgWQ95LAuDMpyDHcaFVqlfCHxY3Mx2QblugYf
 lRoOeiyD1lc2Y/W51a7lUgirrPMfP5COSnpzxBc3sHxPBek/P61mu+FKAZ8WQQSZgy0nOPvitlW
 8QpbDCTqQ7ruN/gclkAHBvcvFEPrzC7CYhIvaeh3V7gRu1/wl7B0eJ71E0an6gwfs89Kp45pMZ+
 YQaKxjZqICvH9aFy3D00FsgdZXGf53kshTdKRXw2Cfl6unp1BxJcqzwnnOg6FkS/I7+o1eQ540m
 6W2yFMpWQ/hA94Awvs0ZExz7k2QSMziAWNJQfZmZlSUcD965BGql6NGklaHnW0jmweGRspy3EsF
 v2LCGGwYTOHR0JJ0BdAXwbYB1COU/62RGDqWQkn60CDHErCKNOR4Ot/liaaqUjEXNZ/bIpebcH3
 qwWGAMTs4s9YsVQLQ/A==
X-Proofpoint-GUID: 32ivthgOGZ1eMpaOTjLMd0oH2HjqRsKj
X-Proofpoint-ORIG-GUID: 32ivthgOGZ1eMpaOTjLMd0oH2HjqRsKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290119

btd_gatt_client_service_removed() can be called reentrantly via
bt_gatt_client_unref() after the services queue has already been freed,
resulting in a use-after-free.

Reset client->ready to false before destroying the services queue to
prevent reentrant calls from dereferencing freed memory.

This was found with the following backtrace:

    #0  match_service_handle ()
    #1  queue_remove_if ()
    #2  queue_remove_all ()
    #3  btd_gatt_client_service_removed ()
    #4  gatt_service_removed ()
    #5  handle_notify ()
    #6  queue_foreach ()
    #7  notify_service_changed ()
    #8  gatt_db_service_destroy ()
    #9  queue_remove_all ()
    #10 gatt_db_clear_range ()
    #11 service_changed_failure ()
    #12 discovery_op_unref ()
    #13 bt_gatt_request_unref ()
    #14 bt_gatt_client_cancel_all ()
    #15 bt_gatt_client_free ()
    #16 bt_gatt_client_unref ()
    #17 bt_gatt_client_free ()
    #18 bt_gatt_client_unref ()
    #19 btd_gatt_client_destroy ()
    #20 device_free ()

Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
---
 src/gatt-client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 374e67c34..3baf95c4f 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -2261,6 +2261,8 @@ void btd_gatt_client_destroy(struct btd_gatt_client *client)
 	if (!client)
 		return;
 
+	client->ready = false;
+
 	queue_destroy(client->services, unregister_service);
 	queue_destroy(client->all_notify_clients, NULL);
 	queue_destroy(client->ios, NULL);
-- 
2.34.1

