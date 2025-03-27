Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0DD207E1F
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743064898; cv=none; b=XZ9k6PHRrLg33jI5llWZnfblEp3kUMYsRgganEIhuqSXiVHwun/eKKTqfOgbNFBqAQK8pDjjNnfSEKyLo2eu5Edlmqy+KSya9FlC7NyY4NNunIe6+pxHc9YvegnxBv6ram8rBBdgVi2eAMA4VwwkcqhADJzzSiXFxD9zgGFNWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743064898; c=relaxed/simple;
	bh=dUcDMfeI5H4ywpx5kx0qh1jViiwOPZCMfyr8fysg0M0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LBfG5U8/rQkdXmzmk8OVVaVMC0g+CogUAvHKNkyKttcHNRFoNPrq9G74PilYx1R+tLGnLA81Z0iiQ+tl3yXP9y1xdJUNCXQc5yMKqRhxhzYWeSbR9+tYmKWphlGF3/+pzTAn+YnCKAFo6zQ19sVHx24IS9eeBnpisXP//Fk2D4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LLah7PKU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LLah7PKU"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R5jFaD010192
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 08:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oUe35kkA15tCUL50WVex/AH7EA29Z9wdrUy
	7yBf2alQ=; b=LLah7PKUjuhgAALJLF4s1mV3WKFsvwAZVsp+3iXSqOD4d/eo6MD
	m2laYQ3t6GWd/oRVVqeNgNonYlzBiXABX2zs9F1yzYSeK5PhEQjBrtiNhb7mWdVj
	rHHTWVtJYhTBw6b34iwF+ph7AaR28LcX0sMuOvwVFyDlx/w+8VEqPn3Ju4GSLGuv
	seIgF1i/yqX2uY22xpgNOckISMUXvYrv/E/EuLT7G9BEKCAhWAUDKwttN53R43PM
	u+yhNBGIqyG6Yjyg7UKLpuPctHJLb8uCjqz6jT4KQoZ7J4x6XVOz3da1r4go22ud
	hOWsoc5k7TPkm4bpuVbw5tCVo2cK7IOJrrQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmcyfw97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 08:41:35 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 52R8fWR7009015
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 08:41:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 45hp9mfsm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 08:41:32 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52R8fWBY009010
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 08:41:32 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 52R8fWjG009009
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 08:41:32 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id 303E22260D; Thu, 27 Mar 2025 16:41:31 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: linux-bluetooth@vger.kernel.org
Cc: quic_shuaz@quicinc.com, quic_chejiang@quicinc.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com,
        quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
Subject: [PATCH v1] dbus: Fix add invalid memory during interface removal
Date: Thu, 27 Mar 2025 16:41:28 +0800
Message-Id: <20250327084128.3315736-1-quic_shuaz@quicinc.com>
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
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EZ3IQOmC c=1 sm=1 tr=0 ts=67e50f3f cx=c_pps a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=Yilk4jFxLBpVIceRAnQA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 6kdiOHDHU8lMhucHElBT-Crc_kZXJy1I
X-Proofpoint-GUID: 6kdiOHDHU8lMhucHElBT-Crc_kZXJy1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=612
 spamscore=0 lowpriorityscore=5 clxscore=1015 bulkscore=5 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270057

test setp
register_service <uuid>
register_application <uuid>
unregister_service <uuid>
unregister_application
register_service <uuid>
register_application <uuid>   
core dump

invalidate_parent_data is called to add the service to the application's
glist when unregister_service. However, this service has already been
added to the glist of root object in register_service. This results in
services existing in both queues,but only the services in the
application's glist are freed upon removal. A null address is stored
in root object's glist, a crash dump will occur when get_object is called.

Add a check for the parent pointer to avoid adding the service again.

0  0x0000007ff7df6058 in dbus_message_iter_append_basic ()
   from /usr/lib/libdbus-1.so.3
1  0x00000055555a3780 in append_object (data=0x31306666,
  user_data=0x7ffffff760) at /usr/src/debug/bluez5/5.72/gdbus/object.c:1117
2  0x0000007ff7ece0cc in g_slist_foreach () from /usr/lib/libglib-2.0.so.0
3  0x00000055555a37ac in append_object (data=0x5555642cf0,
  user_data=0x7ffffff760) at /usr/src/debug/bluez5/5.72/gdbus/object.c:1122
4  0x0000007ff7ece0cc in g_slist_foreach () from /usr/lib/libglib-2.0.so.0
5  0x00000055555a3630 in get_objects (connection=<optimized out>,
    message=<optimized out>, user_data=0x555563b390)
    at /usr/src/debug/bluez5/5.72/gdbus/object.c:1154
6  0x00000055555a51d0 in process_message (
    connection=connection@entry=0x5555639310,
    message=message@entry=0x5555649ac0,
    method=method@entry=0x55555facf8 <manager_methods>,
    iface_user_data=<optimized out>)
    at /usr/src/debug/bluez5/5.72/gdbus/object.c:246
7  0x00000055555a575c in generic_message (connection=0x5555639310,
    message=0x5555649ac0, user_data=<optimized out>)

Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 gdbus/object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 7b0476f1a..d87a81160 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -809,7 +809,8 @@ static struct generic_data *invalidate_parent_data(DBusConnection *conn,
 
 	if (child == NULL || g_slist_find(data->objects, child) != NULL)
 		goto done;
-
+	if(g_slist_find(parent->objects, child) != NULL)
+		goto done;
 	data->objects = g_slist_prepend(data->objects, child);
 	child->parent = data;
 
-- 
2.34.1

