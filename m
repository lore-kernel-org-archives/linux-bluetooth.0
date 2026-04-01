Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F4375ADE
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775043579; cv=none; b=mADX0wRsVdfy1wJrya7dSIrHn3rqV3Qw/LKZiuJN9ySEPMbizqjVeB9Mtc4mXwdHlWLJNlq6dFCYuJHob2hjf9HOXeNq6mXkwLq6JYQcuyGWS98ZRrbyJolxIjm7Rz+I9z3bOaWEOcJczrzPN3erKroMdYGoEY8QGRrrpbZ/LYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775043579; c=relaxed/simple;
	bh=qx5TdtkzuQ8sxNCnzL6QTGHZBFjBu2j9Q9j9w0x1+e4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=COMI2CBBN1RRphN4utfShIWFSqkPXJLjROewemR7C5qWSK/o2YeuvHkX1CxvglaNgaMhUB6B7+wGyOIigIJQ1vQsUB1+NNf1dsJFa1mklD2WxVzmiix6mEbWMx9IuDpAcVd3vvHrKp52z+WQnL2896CoeeNiqFwWf6f7gCLcBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T+XTY4y9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T+XTY4y9"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631APwut1579977
	for <linux-bluetooth@vger.kernel.org>; Wed, 1 Apr 2026 11:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jXUDfOp1gaPCyy0ZitiJQ7
	zIJ1KBq1FJhFD5AOGU0I0=; b=T+XTY4y9yGTmR3vS4LZ1rXb5bAFjFJPkPoL1OG
	AeEJodzePmAT7Ipj5OS6HYuHKKFq4OUPt7B5S8EfvX+zUi4fzSpCFLoY1s5pbHnD
	bZ/HaSrZc+nwDKm5gqyMQbZjTYufyKLzCuC9jeobwWuRHzIkoE83xn474S/YQekU
	isnwAIk4V1GDggT+qsUkRzBOFH8IBq7GVZasG4P7OSqMrNHJHozMTyzicXfkCLPw
	I795pbyMyM4y6SkbaZD57RJ42nJA9AUc6IcE1kyixdlbnraKTsRbdMkOt8Oovlma
	suJE9ANig6aLNUmC1rBv/H52JPXUWy/98aUjEzmTTgAi7L3A==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2u9qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 11:39:36 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 631BdYef000608;
	Wed, 1 Apr 2026 11:39:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4d6qhp8hvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 11:39:34 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 631BdYGq000605;
	Wed, 1 Apr 2026 11:39:34 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 631BdXcn000603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:39:34 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4766378)
	id A5EF52358E; Wed,  1 Apr 2026 19:39:32 +0800 (CST)
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: shuai.zhang@oss.qualcomm.com, cheng.jiang@oss.qualcomm.com,
        chezhou@qti.qualcomm.com, wei.deng@oss.qualcomm.com,
        yiboz@qti.qualcomm.com, jinwang.li@oss.qualcomm.com,
        Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Subject: [PATCH v1] src/device: Fix stored gatt cache DB Hash value not update
Date: Wed,  1 Apr 2026 19:39:30 +0800
Message-Id: <20260401113930.1430598-1-mengshi.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69cd03f9 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=AfVwg0ywdl-PmPNAfqsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aShpRfDcv5T8eMVzrOY1Vh0YyUPsGS_C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwNiBTYWx0ZWRfX1Q83jmEUXEMT
 QRt+hHYNlLBYWPlfg3Tf8fy+NL8lg5uPE2Ke+pMjjnHmSTnqhgMooz9rqJa6Tk94y5nyqwWChlv
 9EHTNiHIQs8o16C4g6l5q7JMhzF3RM6d53OBjHFTYUrXxZ4/oWdZTCx+9fAKdWKJlw/mvA+MvWW
 69d2MNutSIJ3tFbnrX6v5cCu2qYMl0QpqQfcu8MWF5ctUIszi9v1C5GGmyMwg1I6CAri5fGjmFa
 QqhBv+VC1OSA3WTs+JLt2NVJ+B8VfWQntTNmj9n0fI8jViX73aX4QesFqCsjGMgGUY4ElCX2k6m
 k5v9zebFGH/+Sx3fqy1YuBqmYokxVkneCc9ITMQMo6PysS0VkaVJyxokdmovE7m7SN/pyRoZuQK
 aR9uEenynQliSc4D55IqxzR/7kf9Bo8KBxrf5tJTogEk1UFq3kfbVIiFtMEPoo8eSzwLmjCqMKQ
 gsSQ+GLvA+D/WyLvOlQ==
X-Proofpoint-GUID: aShpRfDcv5T8eMVzrOY1Vh0YyUPsGS_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010106

There is an asymmetry in behavior: when services are added during
the same connection (via Service Changed indication), the persistent
storage (disk) is not updated with the new DB hash, but when services
are removed, it is updated.

During the same connection, We check DB hash value stored at
/var/lib/bluetooth/<adaptor addr>/cache/<remote addr>.
When established connection, the stored DB Hash value is A.Then we
add new services, the stored DB Hash value is still A which should
change to B. However, if we remove the existing services, the stored
DB Hash value changed to C.

When performing addition, it goes like this:

discover_primary_cb()
  └─> gatt_db_insert_service()      ← NEW service inserted into db
        └─> gatt_service_added()    ← callback fires immediately
              └─> store_gatt_db()   ← SAVED TO DISK (hash still OLD)
  ...
  └─> discovery_op_complete(success=true)
        └─> read_db_hash(op)             ← sends ATT Read By Type
              └─> [ATT response arrives]
                    └─> db_hash_read_cb()
                          ├─> gatt_db_attribute_write(op->hash, ...)
                          │     └─> hash UPDATED IN MEMORY
                          └─> discovery_op_complete(true, 0)
                                ├─> [no services to remove, no
                                │    store_gatt_db called]
                                └─> service_changed_complete()

Whereas removal perform like this:
discovery_op_complete(success=true)  [1st call]
  └─> read_db_hash(op)
      └─> op->hash is NULL → sends ATT request → early return
...
[ATT response arrives]
db_hash_read_cb()
  └─> gatt_db_attribute_write(op->hash, ) ← hash UPDATED IN MEMORY
  └─> discovery_op_complete(true, 0)          [2nd call]
      └─> read_db_hash(op)  → op->hash already set → returns false
      └─> gatt_db_remove_service()
          └─> gatt_service_removed()
              └─> store_gatt_db() ← SAVED TO DISK (hash is NEW)

There is a timing issue to update DB Hash value.

The gatt_client_service_changed() callback in src/device.c is called
from service_changed_complete() in gatt-client.c, which is invoked
after db_hash_read_cb() has already updated the hash. Adding
store_gatt_db(device) here guarantees the db is persisted with the
correct, up-to-date hash for both the addition and removal cases.

Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
---
 src/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/device.c b/src/device.c
index 3ea683667..cfbde307b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6267,7 +6267,11 @@ static void gatt_client_service_changed(uint16_t start_handle,
 							uint16_t end_handle,
 							void *user_data)
 {
+	struct btd_device *device = user_data;
+
 	DBG("start 0x%04x, end: 0x%04x", start_handle, end_handle);
+
+	store_gatt_db(device);
 }
 
 static void gatt_debug(const char *str, void *user_data)
-- 
2.34.1

