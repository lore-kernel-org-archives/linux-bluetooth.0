Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422FE48F85E
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537938; cv=none; b=aabQjYaChVVuwbfKvDwO1nTTf/WD/mx1h7Wp9MCgYLgU+1Md3B8CphdNTtfGKeYjkfKmwY4xubkol7b+I1QaW0RVVS4Pbpks4AwB/jYhlq6oDHDhThpq6BDQ2OzbZa0HD3wUAoQd0uTbSyZW6GkhSuoINGwwiPjVmM1ee4LF8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537938; c=relaxed/simple;
	bh=pWAEnNLU6aLoaMvSBf3YdAYb+sZzZHgxdcdlAphBEjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+DSvb2h/QccpToawStqRL9AcyIPC0KlfrnHVNsYZugN/70mjr5I3LSRjbwmDx8T3Vwmw/Q8APg0bbwA2ZX3RXsDCTIwtR5Q0sDqUY30J3a43wgp0iEQoTmYwZ4sIGYqHL4qGU9eeIRWhYlPvHlH3JfqYjDdghS7q0WqSvH1ULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GizBmYrC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GizBmYrC"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KBMF2256899
	for <linux-bluetooth@vger.kernel.org>; Fri, 9 Oct 2026 09:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=TR41/fDvrwIjdTLKpB6p5Kn528PQj5/mzPy
	dBuTcGGo=; b=GizBmYrCZliJl3za0/oTnz0VeTJDIaqKZIGRTAmvQ4Fpawnz3hE
	gU1ePVituDNg8Wf94wUQhBg8WD5aNwa41ORsnEcGW+HcXtRoGEgeHEGSx1g0q9TY
	kKxQyMg3/FbFqnabsWDNEBXqzxCqABtTb7GWFzDXUROHhTAi/BJVmiEBiLHjVtzD
	C9pXY38Kl51Vq8V/xx9bJwEpIWcOvgrA1fDez6iRZ33JbKi5Q65ZKrJOl1imG7Rj
	4Fnsu2WFrA+iiSwV346V2K0WrUAipe0vwm0uP+1XqqGGp6y9VJpMcrIykPrqgwEV
	KcmKE0uuQ67ObCtLVVrBChBh2KJAFlepb0g==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6nufspfr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 09:25:36 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999PYA43497407;
	Fri, 9 Oct 2026 09:25:34 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6999PYCG3497391
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 09:25:34 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 6DFB349BB9; Fri,  9 Oct 2026 17:25:33 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH v2 00/14] Ranging Profile and Ranging Service PTS fixes
Date: Fri,  9 Oct 2026 17:25:16 +0800
Message-ID: <20261009092532.3600749-1-cheng.jiang@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=afn0Dhot c=1 sm=1 tr=0 ts=6ac8b310 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=Js3yRN_O2fk3irKhZPwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfX9NSPyrO87Xrv
 w66QAJV3PHb2btYEBxOe9x9UZx/K8Gg7X8ngv6ydMW1EACfOzgD7qBE+1sDTg0VUg3EJTRlLPHw
 vJPaArQYKEnQZDjFExXV4D2NkkXj4zk=
X-Proofpoint-GUID: iqEgHDxRg0iTwEfrtvvs9H7bACROEd1v
X-Proofpoint-ORIG-GUID: iqEgHDxRg0iTwEfrtvvs9H7bACROEd1v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNyBTYWx0ZWRfXw+yI4cNgPRtU
 tboyQ4/78wrhBeXjvA/AfPspOyw4cluTg077nOTMykhD5uDJVsZNH5dptDsPut6/nfq6N+kpVPS
 IOzqhqqi5qcOTs3u3x7wyAmQ9SYkh4SeFn4L9gNAjP8FFf/GyA528Su7xvDzIgeziaq7ublZyj0
 r3AtM0KUtXIDqlt02ctiQwsvt9kg5uacby0WRJGUgYJXIgv02NOqpE+vC1nJJUuI6Y4WqAVHWQ3
 XcIoIdfxWN6unmwK+6TnKKKSagF8onD27A2HVYawfbSYi3Lr3Qiqo0KFhzyoFf6OkFurCO/D7NO
 9lwS2tSUJ2uSIjCi5vbQCr29TOhLhSdT40LWRDuB0LuGwF5iFsUEzkV28GkLGtoiOZSY8mDfH73
 O70m+EW88cArb4xdEAgXPZu19VxwpjA7rXLGAl2fboJ0n6yg+QlXkL1uP1wv79OOueD5fpJIKCc
 0Ohq1xN3hvOlawRFzTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090037

Changes since v1, from review:

- src/ and unit/ are in separate patches throughout. Two of those splits
  leave the unit tests broken in between: patch 2 changes gatt_db_notify_t
  and patch 3 updates the test callbacks, so on patch 2 alone they do not
  compile; patch 6 advertises Abort Operation in RAS Features and patch 7
  updates the value test-rap expects. src/bluetoothd builds on every patch,
  and the tests pass once each pair is applied. Squashing the pairs would
  avoid it, if you would rather have that.

- gatt_db_attribute_indicate_only() is gone. gatt_db_notify_t now takes the
  ATT opcode of the operation it is serving, the way gatt_db_read_t and
  gatt_db_write_t already do, and gatt-database reads the transport from
  that argument instead of asking the attribute what the current call is
  doing. The test-rap hunk that read the old getter turned out to be dead
  code: that callback is never reached by any of the 25 cases, and dropping
  it leaves them all passing.

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
specifically. Patches 1 to 4 add an entry point for each case.

Patches 5 to 9 apply that on the responder and fill in what the RAS Server
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

Patches 10 to 12 add the requester side the RAP cases need: an API to select
Real-time or On-demand reception together with the transport to configure on
the peer, exposed as org.bluez.ChannelSounding1.SetRangingDataMode() and as
a bluetoothctl ranging-data-mode command.

Patches 13 and 14 document the new method and command, and record the
results: 19 RAP and 31 RAS cases pass with PTS 8.14.0.4, run against PTS
pre-generated ranging data (TSPX_test_method), since the PTS dongle in use
does not support Channel Sounding. That covers the RAS protocol behaviour
above but not the HCI Channel Sounding entry path. RAS/SR/SPE/BI-02-C is
listed as not applicable, since RAS.TS Table 5.1 selects it only when Abort
Operation is unsupported and the IUT supports it.

At the tip of the series, unit/test-rap, test-bap, test-bass, test-mcp,
test-micp, test-vcp and test-gatt all pass.

Cheng Jiang (14):
  shared/gatt-client: Allow registering notify with explicit CCC value
  shared/gatt-db: Pass the ATT opcode to the notify callback
  unit: Take the ATT opcode in the notify callbacks
  shared/gatt-db: Add gatt_db_attribute_indicate()
  shared/rap: Honor CCCD transport for RAS on-demand ranging data
  shared/rap: Add RAS Control Point Abort Operation
  unit/test-rap: Expect Abort Operation in RAS Features
  shared/rap: Shorten the requester Control Point response timeout
  shared/rap: Add real-time ranging data delivery on the responder
  shared/rap: Add requester ranging data subscription API
  profiles/ranging: Expose requester ranging data mode over D-Bus
  client: Add Channel Sounding ranging data mode control
  doc: Document Channel Sounding ranging data mode control
  doc/qualification: Add RAP/RAS PTS qualification results

 client/cs.c                        |  87 +++
 doc/bluetoothctl-cs.rst            |  24 +
 doc/org.bluez.ChannelSounding1.rst |  32 ++
 doc/qualification/rap-pts.rst      | 180 ++++++
 doc/qualification/ras-pts.rst      | 135 +++++
 profiles/ranging/rap.c             |  36 ++
 src/gatt-database.c                |  10 +-
 src/shared/gatt-client.c           |  43 +-
 src/shared/gatt-client.h           |   7 +
 src/shared/gatt-db.c               |  21 +-
 src/shared/gatt-db.h               |  15 +-
 src/shared/rap.c                   | 842 ++++++++++++++++++++++++-----
 src/shared/rap.h                   |  23 +
 unit/test-bap.c                    |   3 +-
 unit/test-bass.c                   |   3 +-
 unit/test-mcp.c                    |   3 +-
 unit/test-micp.c                   |   3 +-
 unit/test-rap.c                    |   9 +-
 unit/test-vcp.c                    |   3 +-
 19 files changed, 1335 insertions(+), 144 deletions(-)
 create mode 100644 doc/qualification/rap-pts.rst
 create mode 100644 doc/qualification/ras-pts.rst

-- 
2.43.0

