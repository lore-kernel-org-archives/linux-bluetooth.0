Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48C717A303
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609517; cv=none; b=TPXkO1MYdk4nDZRO7uSrFd57rlMTQWfFjO9llVAT3ciIF/qxlizOYxTFcM9UaI6bCniDlWF4oe9jOt7k89iFcDQUKpOHzQUm2F4RuU9J8BJE+67p+R+zALBd0V9v8QVq98IUgrfjo7cqkDgPtPQWLpH5r7onaQujGC50vU3sYbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609517; c=relaxed/simple;
	bh=eICmaTYkcEXXxxfQrLH6IWRPFrqs3//uD71yxJGp+tg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AIZBWtRlGXEUfzbyKxaJvh25JRIUzVD7S2vO8sIQzLWInttWAfxcjafbWtcoFDL0SbOpxm3Z8mfXqFsTeZuelYWV7sZYDM2DUmr+4uSPqIqm17QlTakI/FZzEUvuUXfkhLnTT3ea4mCn5U+R3C4y0EVB1G73cwt6p8cm7AH5n80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LxcePAr6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LxcePAr6"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6055ZQMR4031674;
	Mon, 5 Jan 2026 10:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uKJsV7ajmZOeh5IiJeFT5Rqd7MIyvMMSCH8
	r0Oq0Mis=; b=LxcePAr60NpTHu6u+2tNIDOoZoem1ZmnFVh6yfApxudfKc6/R0J
	dCN7UuqvxN9vdO3XNUDqtxOVlgWb91Cf2Vjf2rYRMh7jOhOcchjaY9l4AFtdgf6m
	KmNDdh5V1rxVd5cbIxwiUhv0tzey9MjwBTLz/fH81AO9WLwQZDazFb6MFs1MznCc
	i2ysbPG1BTr0JIRd2ygtxslGHXDzOJi92BQ2MhLdcpmm/K7F64bo9Z99eCbeXPX9
	NbD59M1UtLCWzYevU0qn0z/nufdBbCVc5pgKhn1wRoNGRC1YAZLFz/wRkb2Hh0E1
	pad14Ug1H+eRMwmSf3gDAfP8+RQqacV7QfA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg79ngw2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:38:34 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 605AcVtV019287;
	Mon, 5 Jan 2026 10:38:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4bev6kry99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:38:31 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 605AcVVv019282;
	Mon, 5 Jan 2026 10:38:31 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 605AcVNm019281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:38:31 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4766378)
	id 48ED8237A3; Mon,  5 Jan 2026 18:38:30 +0800 (CST)
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com,
        Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Subject: [PATCH v2 0/1] gatt-client:Implement error handling for DB_OUT_OF_SYNC in GATT caching.
Date: Mon,  5 Jan 2026 18:38:27 +0800
Message-Id: <20260105103828.105346-1-mengshi.wu@oss.qualcomm.com>
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
X-Proofpoint-GUID: r968mxliSM64bauCRz0BTR-g8nsxMZf4
X-Proofpoint-ORIG-GUID: r968mxliSM64bauCRz0BTR-g8nsxMZf4
X-Authority-Analysis: v=2.4 cv=Y8P1cxeN c=1 sm=1 tr=0 ts=695b94aa cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jQMTAWt6YVLlqYqpKcEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA5MyBTYWx0ZWRfXy+57zUKM7TRE
 TqqeLvkUJ1ZgGtxnvKKHDMRPx+SeBEiorOHnn6NqAv9+TaEWoXIiSkSLGtj07X03UJo86+w/MDc
 Db/tn/2/jp4HNOPVqtJFGOj98sZdkBUiJrI2YM8EI4ajXy8ZJr5VWLR4Ocz9bf+uu8hpgtsj65S
 VAySRc39QJw/ZVJ3WzWOdlJJgOz6tC0bTqcbe2/uus9eNywfOtTYktU8EHhfHCI6sWAKiHKPExi
 VQWod/w2J8nmOkJHA5/onGtQUp+1x8ErvvIic2P46ZGQ4TK1OWvXYiwMT7U7ujmxLjfYhJEZrmo
 Y/QVL5wAGowMImrCbPwht8eR6uTlVMeyIe1+RPxVSWnmIrlny/fYGyqOKEV2e1clbl1d6MCe6Bs
 JZ3VNi7/e9ftVaZp7SoVyHRIcfb/C5Olp5yAN4yjs/dgpzYoNXnDJYTxI/7n4GAzJvDbybO0cWC
 uulXkuq+Dtc8/qdauLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601050093


Changes from v1:
 - Implement automatic recovery when ATT_ECODE_DB_OUT_OF_SYNC error is
   received from the remote device.
 - Link to v1
   https://lore.kernel.org/all/20251208101915.247459-1-mengshi.wu@oss.qualcomm.com/

Mengshi Wu (1):
  gatt-client:Implement error handling for DB_OUT_OF_SYNC in GATT
    caching.

 src/shared/gatt-client.c  | 376 +++++++++++++++++++++++++++++++++++++-
 src/shared/gatt-helpers.c |  16 ++
 src/shared/gatt-helpers.h |   3 +
 3 files changed, 392 insertions(+), 3 deletions(-)

-- 
2.34.1

