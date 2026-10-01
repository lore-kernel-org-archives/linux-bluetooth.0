Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700A4AAC66
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860749; cv=none; b=g461eVmF7cvh2xh4V4pYHiFgMEgbiR8X8tVexCcM3QCxSKp+ZttTI1JYujixHW8gzlDTfgSairzaSvm2wSXVs3e34yNoiRBed/u12VLteSgGzWNTjzmat+iyNj9eQMsh+A/hLUUUdwvuR16pPQHioLY/jtJJT886S/tdc5I9CR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860749; c=relaxed/simple;
	bh=xN05hoVy6QAUNnKLkhOUTWokcyzE+Nd8t6RM6ock7BY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPZxy2HmziX0DSR/4jjosNhL6uwdsORORZk3KEl5vGUAFK5j8YlEfiYSAc+x/UE+QOVxL6/vp5w21ahEpnkcWVKMJrDHKJJiGGiOU0KRxDB14MDkK9o2K+xpIdP6J8iWVgl4J6nT9WpSrkT0CbWPuYr9h9yC584tjtvLUzD8hoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R70S8Etg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R70S8Etg"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691CqJ6R1933080
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Nks71KvS3RP22kUqC2hM/xyFdLWmkIQ1rf8
	1FZkk5OY=; b=R70S8EtgTF36zJ1vt17xPwT+OA86koXkoFbRxDXm/bydnVqtIuh
	K4kPbWP/kVPpkKplpuMnzxrTSR61WK/vxTE1BS6Q+PiCEnMx66pzxVCLD28Q7c5q
	d/BCR8+7+/zCo08gl8HMyVTnp3eoI/gS6FDe++QyH74wwxTZjSLvuWvH1MgJr87Y
	UP20Yh8JlKtcl7P2UKGLwjyQccq4JWRnX0LVXD5rO4uhAyy6MNDFB70lG8R9t4JJ
	gVYpCFXOCtgoB8JDykQj+TgiamLKa002RG732TJBHvgz7HHGpzexdCxyIoSI1zEM
	ZoCpe8XuR9wqo6YJZPUCNFJ32K+r2ay9bug==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1jcfsppw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 13:19:06 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 691DJ49W2501384;
	Thu, 1 Oct 2026 13:19:04 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 691DJ3iJ2501377
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 13:19:04 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 1D0AC41C78; Thu,  1 Oct 2026 21:19:03 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH 00/11] Ranging Profile and Ranging Service PTS fixes
Date: Thu,  1 Oct 2026 21:18:46 +0800
Message-ID: <20261001131900.707485-1-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX12v1Otm4Vcav
 5O8t6I7539LP32O3xBt3+Q/LsGGLTzE8vYFpYAQvDK059gmcFWd1csqKtuH0Z6BwDu6j69CSiKb
 YNh9ZIXjzUs+NQ8xNV+8OdmiOQ5cpGI=
X-Proofpoint-GUID: HlXYrLDGP4_EDICQpV1LUQH6mrim6LwC
X-Authority-Analysis: v=2.4 cv=b4YncdGx c=1 sm=1 tr=0 ts=6abe5dca cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=1rL_R2W-7Xot260rqawA:9
X-Proofpoint-ORIG-GUID: HlXYrLDGP4_EDICQpV1LUQH6mrim6LwC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfXwGBKxN0WKN1Y
 Ul1v3h7aCFyLfbdBcxe49ZJtmv4WZRc0iMcYurnroc3e0HEUJ8qvMTc61DBP9A7de6ixF0D0jq2
 JgoVAhhzwptG850ZQuXrvr0IqZRBOSc+xpmjsq7BBJyQrij3S5elxtfFTYHfiTzZ/SS+TXObuaU
 ZNjsh4j7c33hO0RLRM4wnIoF5Rb8AtvVXa37FXScHOUtRr3oCRTdfx7dMy+9nDc/CoD/sogXFnn
 jLHWnRz8vwFQgEx0dKy69OH+MKq/phv0ojxxP9vaNsnS0m7KTYZAPMHIc4jymkZj1yUYzxGH7n6
 0i4b9/wqo38ECXrUUVPvKlfn3bT8u5WK6zf3TaQxgDyYlWwXQMzssQAGf9RwdixkpoBk71PNqjN
 h7ckgp0yPIof2T+Zg0EV3iLHiIWXSB6YYNcdFioJM/xWuFxInsnWybCsBk3VcantUSEF+ZpeYQ6
 3bN+bxbJHRrg9AEsB2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010053

Qualifying the existing Ranging Profile and Ranging Service code against PTS
turned up behaviour that does not match the specifications, plus procedures
that were not implemented at all. This series is what the RAP Requester and
RAS Server needed to pass, and the PTS results it records.

Most of it comes down to one thing the GATT layer could not express. RAS
picks the notification or the indication transport per characteristic, and
when a client enables both, the choice is not the same everywhere:

- Ranging Data Ready and Ranging Data Overwritten must be indicated
  (RAS 3.4.2, 3.5.2; RAS/SR/RCO/BV-08-C and BV-09-C).
- On-demand and Real-time Ranging Data must be notified
  (RAS 3.2.2, 3.2.3.1; RAS/SR/RCO/BV-05..07-C and RAS/SR/RRD/BV-03-C).

gatt_db_attribute_notify() prefers notifications whenever the client enabled
them, so a server cannot honour the first rule, and
bt_gatt_client_register_notify() derives the CCC value from the
characteristic properties, so a requester cannot ask for one transport
specifically. Patches 1 and 2 add an entry point for each case, leaving
gatt_db_notify_t and every existing caller of both functions untouched.

Patches 3 to 6 apply that on the responder and fill in what the RAS Server
cases exercise: the transport of every notified characteristic now follows
the peer's CCCD, Abort Operation is implemented and advertised in RAS
Features, the requester's Control Point watchdog uses the 5 seconds
RAP 4.5.4.1 specifies, and Real-time Ranging Data is queued so segments are
not dropped when a procedure completes before they are all sent.

Segmented ranging data was also queued a whole transfer at a time, which
starves incoming ATT operations: notifications land on the att write queue,
which pick_next_send_op() drains ahead of the request queue and with no flow
control of its own. It now goes out a segment at a time, gated on
confirmations for indications and on a short delay otherwise, so an Abort
Operation stops a transfer the peer no longer wants instead of having to
wait for it to drain. A real flow control for the notification path, driven
by how much the att write queue has left to send, would be better than that
delay and is left for later.

Patches 7 to 9 add the requester side the RAP cases need: an API to select
Real-time or On-demand reception together with the transport to configure on
the peer, exposed as org.bluez.ChannelSounding1.SetRangingDataMode() and as
a bluetoothctl ranging-data-mode command.

Patches 10 and 11 document the new method and command, and record the
results: 19 RAP and 31 RAS cases pass with PTS 8.14.0.4, run against PTS
pre-generated ranging data (TSPX_test_method), since the PTS dongle in use
does not support Channel Sounding. That covers the RAS protocol behaviour
above but not the HCI Channel Sounding entry path. RAS/SR/SPE/BI-02-C is
listed as not applicable, since RAS.TS Table 5.1 selects it only when Abort
Operation is unsupported and the IUT supports it.

Each patch builds on its own, and unit/test-rap, test-bap, test-bass,
test-mcp, test-micp, test-vcp and test-gatt pass on every one of them.

Cheng Jiang (11):
  shared/gatt-client: Allow registering notify with explicit CCC value
  shared/gatt-db: Add gatt_db_attribute_indicate()
  shared/rap: Honor CCCD transport for RAS on-demand ranging data
  shared/rap: Add RAS Control Point Abort Operation
  shared/rap: Shorten the requester Control Point response timeout
  shared/rap: Add real-time ranging data delivery on the responder
  shared/rap: Add requester ranging data subscription API
  profiles/ranging: Expose requester ranging data mode over D-Bus
  client: Add Channel Sounding ranging data mode control
  doc: Document Channel Sounding ranging data mode control
  doc/qualification: Add RAP/RAS PTS qualification results

 client/cs.c                        |  82 +++
 doc/bluetoothctl-cs.rst            |  24 +
 doc/org.bluez.ChannelSounding1.rst |  32 ++
 doc/qualification/rap-pts.rst      | 180 +++++++
 doc/qualification/ras-pts.rst      | 135 +++++
 profiles/ranging/rap.c             |  34 ++
 src/gatt-database.c                |   7 +-
 src/shared/gatt-client.c           |  41 +-
 src/shared/gatt-client.h           |   7 +
 src/shared/gatt-db.c               |  35 +-
 src/shared/gatt-db.h               |  17 +
 src/shared/rap.c                   | 824 ++++++++++++++++++++++++-----
 src/shared/rap.h                   |  21 +
 unit/test-rap.c                    |  19 +-
 14 files changed, 1319 insertions(+), 139 deletions(-)
 create mode 100644 doc/qualification/rap-pts.rst
 create mode 100644 doc/qualification/ras-pts.rst

-- 
2.43.0

