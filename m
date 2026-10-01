Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B9E4B4887
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860763; cv=none; b=kYr6648/C4oiQP5ZjwRtBUkP3F4Gyippw+2SxWRvnU2IR78yiKro3v/hi+CSgzXRyt2o3oARKLpcWVq5D0GbtpzPPAupJqY5MJL1qXHs6PY5bvANGtLMuesbwDWf8fVnhImzif2TzUyDi64TrgHXg6R084hSEbn20Fux+1J5ES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860763; c=relaxed/simple;
	bh=CEKz3PTFEzGwckajQdbV+bE6+77p4at5nEnE1V4btSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXEq5fCtdFfsVRV6spduEJbdxPSW7ijyasY03zKVEOlUaVv9huObNohOcZdMyj9Yx5XQMqspXA7WOZYXAd4KBu2GcO+z9mVvMiQkTTW0YBNNM/sWyHkaaZTJjNkfqwB3BDNLDatUSDTyTwHGShWgYaxyFzc4Tu9Y2CpoRUTP+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U9vaJgBu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U9vaJgBu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691AkQTv3390761
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TT5S8/9Qw4jJMOxbyiJJxhsSHoeV2LbtyKsVN4Oj45E=; b=U9vaJgBuXUfHVfM9
	qPKxQRkp0TD2adzTv5GLB/uBk6W4yNpv+kvyXWq2n49H1LPrgekm1LiSbOln2bU1
	BqTPHYhTDhZ/a5/xF8cxEVdDCH0gXiGIUvSZZl/Gh0qnDH39ZHvsobSJXAOOgCBU
	IsurroZRvCkYPT9FZmV+bqtG39W77m29Lt+T2eICYWNYekOMwNIPZFqYcq9uzc1k
	nIyJICvEgpIDTgfnGTR7BULVDhAiSR9P8JUB7uBYn7lAs16ZMT78R4yy06IjQZhK
	vTAlw4M+/R8mbtjOnC84PZiZgYDbg5f0ZpLr/MK8Q2T/LwgFbAD7vO7FB0QCrIGp
	m2EppQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1p2b8k17-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 13:19:16 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 691DJE6x2496306
	for <linux-bluetooth@vger.kernel.org>; Thu, 1 Oct 2026 13:19:15 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 691DJExo2496335
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 13:19:15 +0000 (GMT)
Received: by bt-iot-sh04-lnx.qualcomm.com (Postfix, from userid 37913)
	id 2451A49BCC; Thu,  1 Oct 2026 21:19:13 +0800 (CST)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH 11/11] doc/qualification: Add RAP/RAS PTS qualification results
Date: Thu,  1 Oct 2026 21:18:57 +0800
Message-ID: <20261001131900.707485-12-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001131900.707485-1-cheng.jiang@oss.qualcomm.com>
References: <20261001131900.707485-1-cheng.jiang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: XWW0exBcKYdUtirdbYTpKgo6dZBQ_orK
X-Proofpoint-ORIG-GUID: XWW0exBcKYdUtirdbYTpKgo6dZBQ_orK
X-Authority-Analysis: v=2.4 cv=O8SsLx9W c=1 sm=1 tr=0 ts=6abe5dd5 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=a1ePAV2U676HVhJO_w8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfX/x2ug0xs98YI
 3G8UQoBY/4k3pFzPdsczR2dGXGmu1/jPoIoeyhQPmX7OHOS4r1rRa/WN65GviJ4Rw9hU1BZFWG4
 3v3o9sPj1KX1NS/2SzSdSY8vbZHleV8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1MyBTYWx0ZWRfXyoXQm9J25xGy
 5Da/TmzEuAVeHMMdW6eq707P50LkZfaBMNZ98puCTb28q4CFjpXTdxHybVveSrx/bcA50+vbBIl
 9CyXUerETateKuphfs3IgOklWV0Cy/1Vjf200aRmOWIn1h3kEzxhGh1QGhFpzVBvurl4Tq78Slp
 7gxG16AxM9bp5ReiTaSr8J8+LY/jgIOgDHoNKys5W2wt76RWhbsOt/IYXQNtN4gcHn/SMyMyDqE
 RVEcSxiyV90PR9TYgIoKtgWLsPYhre6K191cfHIFw1xiyrtARLEdIR9yeJOUtWVqjqnIWkSUC5k
 0zfQx17d50no/D/wNVKMpEJqTiHZgIpXrmKDXokklVM+o8sgd3uJU/uWm6u7S8oZVuQXerHSQGH
 vhspm/nhoYAjpKSBw0hUgH1WgVyN11lJvtT+2JjOPQQM7AiIgomA6F1fq2Do7Amjq8VmZRXqDkw
 kVdxTqtxTGmca+obhoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010053

Record the PTS results for the Ranging Profile and the Ranging Service.
Both are split per case prefix, as the other qualification documents are:
rap-pts.rst keeps the 19 RAP Requester and Responder cases, and the new
ras-pts.rst carries the 31 RAS Server cases.

Every case is listed on its own row rather than collapsed into a range, so
the file states which cases were actually run. RAS/SR/SPE/BI-02-C is
listed as not applicable: RAS.TS Table 5.1 selects it only when Abort
Operation is unsupported (NOT RAS 3/4), and the IUT supports it, so
RAS/SR/RCP/BV-03-C and RAS/SR/SPE/BI-05-C cover that path instead.

ras-pts.rst also records which transport the server must pick when a
client enables both notifications and indications, since the rule differs
per characteristic and each variant has its own case.

Assisted-by: Claude:claude-opus-4.8
---
 doc/qualification/rap-pts.rst | 180 ++++++++++++++++++++++++++++++++++
 doc/qualification/ras-pts.rst | 135 +++++++++++++++++++++++++
 2 files changed, 315 insertions(+)
 create mode 100644 doc/qualification/rap-pts.rst
 create mode 100644 doc/qualification/ras-pts.rst

diff --git a/doc/qualification/rap-pts.rst b/doc/qualification/rap-pts.rst
new file mode 100644
index 000000000..a2647f701
--- /dev/null
+++ b/doc/qualification/rap-pts.rst
@@ -0,0 +1,180 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2026 Qualcomm Technologies, Inc.
+
+================
+RAP test results
+================
+
+:PTS version: 8.14.0.4
+:BlueZ: 5.87 with Channel Sounding support
+
+RAS Server test results are in ``ras-pts.rst``.
+
+Setup
+=====
+
+- Enable ``Experimental = true`` in ``/etc/bluetooth/main.conf``.
+- Use a ``NoInputNoOutput`` bluetoothctl agent and make it the default agent.
+- Before cases that establish a new encrypted link, delete the DUT bond and the
+  corresponding PTS LTK/bond. Removing only one side causes authentication
+  failure.
+- Do not use the bluetoothctl ``gatt`` menu to write RAS CCCDs. Use the
+  ``cs ranging-data-mode`` command so RAP owns subscription lifetime.
+
+Requester results
+=================
+
++----------------------------+----------+--------------------------------------------------------------------------+
+| Test name                  | Result   | Notes                                                                    |
++============================+==========+==========================================================================+
+| RAP/REQ/RRD/BV-01-C        | PASS     | Configure the requested Real-time notification or indication transport.  |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/RRD/BI-01-C        | PASS     | The Requester disables the Real-time CCCD after 5 seconds without a      |
+|                            |          | first segment.                                                           |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/RRD/BI-02-C        | PASS     | The Requester disables the Real-time CCCD after 1 second without a       |
+|                            |          | continuation segment.                                                    |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/CGGIT/SER/BV-01-C  | PASS     | Discover the remote primary Ranging Service.                             |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/CGGIT/CHA/BV-01-C  | PASS     | Discover the RAS Features characteristic.                                |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/CGGIT/CHA/BV-02-C  | PASS     | Discover the Real-time Ranging Data characteristic.                      |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/CGGIT/CHA/BV-03-C  | PASS     | Discover the On-demand Ranging Data characteristic.                      |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/CGGIT/CHA/BV-04-C  | PASS     | Discover the RAS Control Point characteristic.                           |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/CGGIT/CHA/BV-05-C  | PASS     | Discover the Ranging Data Ready characteristic.                          |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/CGGIT/CHA/BV-06-C  | PASS     | Discover the Ranging Data Overwritten characteristic.                    |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/ORD/BV-01-C        | PASS     | See the On-demand ranging data procedures below.                         |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/ORD/BI-01-C        | PASS     | The Requester sends Abort Operation after 5 seconds without the first    |
+|                            |          | On-demand segment.                                                       |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/ORD/BI-02-C        | PASS     | The Requester sends Abort Operation when a continuation segment is       |
+|                            |          | missing for more than one second.                                        |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/ORD/BI-03-C        | PASS     | Ignore Complete Lost and RFU Control Point responses; receive normal     |
+|                            |          | data and ACK the subsequent Complete response.                           |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/ORD/BV-05-C        | PASS     | Configure On-demand notification transport; PTS validates Ranging Data   |
+|                            |          | Ready notification handling.                                             |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/ORD/BV-06-C        | PASS     | On the PTS MMI, promptly read Ranging Data Ready after PTS suppresses    |
+|                            |          | its notification.                                                        |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/ORD/BV-07-C        | PASS     | Configure On-demand indication transport; PTS validates Ranging Data     |
+|                            |          | Overwritten indication reception.                                        |
++----------------------------+----------+--------------------------------------------------------------------------+
+| RAP/REQ/ORD/BV-08-C        | PASS     | Configure On-demand notification transport; PTS validates Ranging Data   |
+|                            |          | Overwritten notification reception.                                      |
++----------------------------+----------+--------------------------------------------------------------------------+
+
+Responder results
+=================
+
++----------------------------+----------+--------------------------------------------------------------------------+
+| Test name                  | Result   | Notes                                                                    |
++============================+==========+==========================================================================+
+| RAP/RES/RSPF/BV-01-C       | PASS     | Discoverable advertising includes the Ranging Service UUID (0x185B).     |
++----------------------------+----------+--------------------------------------------------------------------------+
+
+
+Before ``RAP/RES/RSPF/BV-01-C``, advertise the Ranging Service UUID so PTS can
+discover the Responder::
+
+    menu advertise
+    uuids 0000185b-0000-1000-8000-00805f9b34fb
+    back
+    advertise peripheral
+
+Stop it after the case with ``advertise off``.
+
+On-demand ranging data procedures
+=================================
+
+Some RAS Requester cases are exercised against PTS's SIG pre-generated ranging
+data (``TSPX_test_method``) when the PTS controller does not support Channel
+Sounding. The procedures below use the ``ranging-data-mode`` command to select
+the transport PTS expects for each case.
+
+For ``RAP/REQ/ORD/BV-01-C``, set ``TSPX_test_method`` to ``pre-generated
+ranging data`` and select the ``2_procedures`` input.
+
+After connection, pairing, and encryption complete, run the following in the
+same bluetoothctl session::
+
+    menu cs
+    ranging-data-mode <pts_addr> ondemand indicate
+
+This configures indications for Ranging Data Ready, RAS Control Point, and
+Ranging Data Overwritten. Segmented On-demand Ranging Data remains configured
+for notifications so large pre-generated streams are not stalled by
+per-indication confirmation pacing.
+
+The Requester reads the Ranging Data Ready characteristic, waits for the PTS
+Ready indication, writes ``Get Ranging Data``, reassembles the data, and writes
+``ACK Ranging Data`` after the PTS Complete response.
+
+For ``RAP/REQ/ORD/BI-01-C``, use the same setup but configure PTS not to send
+the first On-demand segment after ``Get Ranging Data``. The Requester writes
+``Abort Operation`` after five seconds. For ``RAP/REQ/ORD/BI-02-C``, have PTS
+send only First Segment; the Requester's one-second continuation watchdog
+sends Abort within the PTS assertion window.
+
+For ``RAP/REQ/ORD/BI-03-C``, use the same setup and allow PTS to inject
+Complete Lost Ranging Data Segments and RFU Control Point responses during the
+transfer. No additional DUT action is required: the Requester ignores them,
+then ACKs the normal Complete Ranging Data response.
+
+For ``RAP/REQ/ORD/BV-05-C``, select notification transport after security is
+complete::
+
+    menu cs
+    ranging-data-mode <pts_addr> ondemand notify
+
+This configures the Ranging Data Ready path for the PTS notification round.
+
+For ``RAP/REQ/ORD/BV-07-C``, select indication transport to receive the
+Ranging Data Overwritten indication::
+
+    menu cs
+    ranging-data-mode <pts_addr> ondemand indicate
+
+PTS can log failed attempts to send an indication during this case even though
+its final verdict is PASS; record the final PTS verdict rather than treating
+that server-side diagnostic alone as a DUT failure.
+
+For ``RAP/REQ/ORD/BV-08-C``, select notification transport to receive the
+Ranging Data Overwritten notification::
+
+    menu cs
+    ranging-data-mode <pts_addr> ondemand notify
+
+For ``RAP/REQ/ORD/BV-06-C``, after connection and security complete, first use
+indication transport to enter the PTS On-demand flow, then switch to the
+notification transport used by the lost-Ready round::
+
+    menu cs
+    ranging-data-mode <pts_addr> ondemand indicate
+    ranging-data-mode <pts_addr> ondemand notify
+
+Wait for ``Ranging Data mode updated`` after each command. PTS does not advance
+to the lost-Ready MMI until both transitions have been completed. It then
+suppresses the Ranging Data Ready notification and presents an MMI asking for a
+read of the Ranging Data Ready characteristic. Complete the MMI promptly, before
+its short timeout, from the bluetoothctl GATT menu::
+
+    back
+    menu gatt
+    select-attribute 00002c18-0000-1000-8000-00805f9b34fb
+    read
+
+Selecting the characteristic by UUID avoids depending on the handles PTS
+happens to assign; ``select-attribute`` matches characteristics before
+descriptors, so this selects the value attribute and not its CCCD. Use
+``list-attributes`` if the remote database needs to be inspected first. Return
+to PTS and continue the MMI after the read request is sent.
diff --git a/doc/qualification/ras-pts.rst b/doc/qualification/ras-pts.rst
new file mode 100644
index 000000000..3b9bfd0d0
--- /dev/null
+++ b/doc/qualification/ras-pts.rst
@@ -0,0 +1,135 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright © 2026 Qualcomm Technologies, Inc.
+
+================
+RAS test results
+================
+
+:PTS version: 8.14.0.4
+:BlueZ: 5.87 with Channel Sounding support
+
+RAP Requester and Responder test results are in ``rap-pts.rst``.
+
+Setup
+=====
+
+- Enable ``Experimental = true`` in ``/etc/bluetooth/main.conf``.
+- Use a ``NoInputNoOutput`` bluetoothctl agent and make it the default agent.
+- Before cases that establish a new encrypted link, delete the DUT bond and the
+  corresponding PTS LTK/bond. Removing only one side causes authentication
+  failure.
+- The DUT acts as the CS Reflector. Set the role from the bluetoothctl Channel
+  Sounding menu before the first case::
+
+      menu cs
+      role 0x02
+
+Tests
+=====
+
++------------------------------+----------+----------------------------------------------------------------+
+| Test name                    | Result   | Notes                                                          |
++==============================+==========+================================================================+
+| IOPT/RAS/SR/GATTDB/BV-01-I   | PASS     | RAS database validation.                                       |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/SGGIT/SER/BV-01-C     | PASS     | Primary, unique Ranging Service discovery.                     |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/SGGIT/CHA/BV-01-C     | PASS     | RAS Features characteristic declaration.                       |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/SGGIT/CHA/BV-02-C     | PASS     | Real-time Ranging Data characteristic declaration.             |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/SGGIT/CHA/BV-03-C     | PASS     | On-demand Ranging Data characteristic declaration.             |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/SGGIT/CHA/BV-04-C     | PASS     | RAS Control Point characteristic declaration.                  |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/SGGIT/CHA/BV-08-C     | PASS     | Ranging Data Ready characteristic declaration.                 |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/SGGIT/CHA/BV-12-C     | PASS     | Ranging Data Overwritten characteristic declaration.           |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RCO/BV-01-C           | PASS     | RAS Features read.                                             |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RCO/BV-02-C           | PASS     | Ranging Data Ready notification or indication.                 |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RCO/BV-03-C           | PASS     | Ranging Data Ready read.                                       |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RCO/BV-04-C           | PASS     | Ranging Data Overwritten read.                                 |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RCO/BV-05-C           | PASS     | Ranging Data Ready, Indication transport.                      |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RCO/BV-06-C           | PASS     | Ranging Data Ready, Notification transport.                    |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RCO/BV-07-C           | PASS     | Ranging Data Ready, Indication and Read.                       |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RCO/BV-08-C           | PASS     | Ranging Data Overwritten is indicated when the client enabled  |
+|                              |          | both transports.                                               |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RCO/BV-09-C           | PASS     | Ranging Data Ready is indicated when the client enabled both   |
+|                              |          | transports.                                                    |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RRD/BV-01-C           | PASS     | Real-time Ranging Data delivery.                               |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RRD/BV-03-C           | PASS     | Real-time Ranging Data is notified when the client enabled     |
+|                              |          | both transports.                                               |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RRD/BV-04-C           | PASS     | Overwritten Real-time data restarts on the new Ranging         |
+|                              |          | Counter.                                                       |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RRD/BV-05-C           | PASS     | Real-time subscription is dropped on disconnection.            |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RCP/BV-01-C           | PASS     | Get Ranging Data, segmented transfer and ACK.                  |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RCP/BV-03-C           | PASS     | Abort Operation stops an in-progress transfer.                 |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/RCP/BV-05-C           | PASS     | Control Point state is reset on disconnection.                 |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/SPE/BI-01-C           | PASS     | Op Code Not Supported, Retrieve Lost Ranging Data Segments.    |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/SPE/BI-03-C           | PASS     | Op Code Not Supported, Set Filter.                             |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/SPE/BI-04-C           | PASS     | Op Code Not Supported, RFU.                                    |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/SPE/BI-05-C           | PASS     | Invalid Parameter, Abort Operation.                            |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/SPE/BI-06-C           | PASS     | Get Ranging Data and ACK Ranging Data errors.                  |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/SPE/BI-07-C           | PASS     | Server Busy.                                                   |
++------------------------------+----------+----------------------------------------------------------------+
+| RAS/SR/SPE/BI-11-C           | PASS     | Real-time and On-demand CCCDs are mutually exclusive.          |
++------------------------------+----------+----------------------------------------------------------------+
+
+Not applicable
+==============
+
++------------------------------+-----------------------------------------------+
+| Test name                    | Reason                                        |
++==============================+===============================================+
+| RAS/SR/SPE/BI-02-C           | Applies when Abort Operation is not supported |
+|                              | (NOT RAS 3/4 in RAS.TS Table 5.1). The IUT    |
+|                              | supports it, so RAS/SR/RCP/BV-03-C and        |
+|                              | RAS/SR/SPE/BI-05-C are run instead.           |
++------------------------------+-----------------------------------------------+
+
+Pre-generated ranging data
+==========================
+
+With ``TSPX_test_method`` set to pre-generated CS data, the whole ranging data
+arrives in one go rather than one CS subevent at a time, so the On-demand
+notification path sends its segments back to back with no air time between
+them. ``RAS/SR/SPE/BI-05-C`` writes an invalid Abort Operation mid-transfer
+and needs the transfer to still be running when it does, so the per-segment
+delay has to leave the peer a window: it fails at 0 ms and passes at the 5 ms
+``RAS_SEGMENT_NFY_PACE_MS`` uses. Feeding the test data one subevent at a
+time rather than in one go does not change that, since the segments of a
+subevent still go out back to back. Raise the delay if PTS reports Complete
+Ranging Data where it expected Invalid Parameter.
+
+Transport selection
+===================
+
+When a client enables both notifications and indications on a characteristic,
+the transport the server must use differs per characteristic:
+
+- Ranging Data Ready and Ranging Data Overwritten are indicated (RAS 3.4.2 and
+  3.5.2), covered by ``RAS/SR/RCO/BV-08-C`` and ``RAS/SR/RCO/BV-09-C``.
+- On-demand and Real-time Ranging Data are notified (RAS 3.2.2 and 3.2.3.1),
+  covered by ``RAS/SR/RCO/BV-05..07-C`` and ``RAS/SR/RRD/BV-03-C``.
-- 
2.43.0

