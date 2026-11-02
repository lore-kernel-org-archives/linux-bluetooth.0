Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607564;
	b=U7nAfWEUd7uY0L7sDji7niHdoVRpJAtJQi1lraX4jAAXwah62DifKTbIHEiJN+cBzzkD
	 x6Wa3sn+JXxhgsotYYQ8i3fqViKGPWaBYSXWetFSvAa4jWFL9FV3BrbfZ6kT/H4yH7eYo
	 nRDfzU+jfEc017OsX5TVywn1i3KymQabEFmGiEAOAuOHN02OFaVDlJ9Iwn+24juV0LzHy
	 cclcA634Mj7AGcAoF1oNAiU6EFlknm9L8wSCClRDOprsD/7+pbN33Azv6mxxCvDPhUvbh
	 nPnjDq/wk01ZOq5D+3R7jtdQ+BC95uGxF9zIBzzzGDl3zGKSFYSNmUTLOcMQmqrtOdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607564;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7inqyLCNvp8aT5LeSSCP7MlMSlgKCLAfS3GRAOmnbeo=;
	b=PqXJwRK1pOuZVF5T49xSLtEsspKMP/Q221Jg0R/eozrp9F7zcg7PU8xFD1vJOXzjPkml
	 1EB1ID7yfA2QOlBli4ZQhUi6ka7WOi6IyE2CLLnlEZ9bHhTnu2aFsC9oAJlHZ8eXxCNF3
	 5JL8vUdszD5Ww/M6V5YEMwB0nW/yyRsuOiWvJzj4bMVKjm3n5KBSBxu3XybL5iMF4sMWa
	 PyrL57e85TopHcs6h36WiMKj3JOO8fl704ZmXqixyuinJcWOVy5JcTjZHDjeFgwD3pXgv
	 5dkaNxrH6Fcu2p727IfQMLXEQ6njS9BOWa/rKuvBUS8Iu0ziC06LbEDyoa/1w5BxNmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jeie1Wde;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559D0606A32C
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 559D0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jeie1Wde
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A23vItT3324675
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7inqyLCNvp8aT5LeSSCP7MlMSlgKCLAfS3G
	RAOmnbeo=; b=jeie1Wde05AvvwfOVdw8sS0s8v9ovFpIbicpU3afWGBm7a4G7SK
	sLhCAxznRl/rBLsixDkA82O0Q/iO7zxFPcLErPWV8efCpHjUrBaL/xUXpftxYqM3
	Ldlux6QiIJBNLtdn8yYXsIUehjv8cBk83TrA5n9NwK6/3AF+sGtv9O3AX/OmlXoo
	ePZ4Le1MNuPsC2fa74wcikNAH2bNY6ZH3vac/pez+QI8J8vOYexWKL+xOSMqSkLd
	JGR5brwHvSxPxTK2d6lMyc27tTmDnZ3foQl8ibOOpN0LdAVx6pWwZpbzjf3PJOtR
	FbtVZZ4LTVow+xhzuog5pwWrb1Vy1H3rDtw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6p19n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:22 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JKLO3331053;
	Mon, 2 Nov 2026 08:19:20 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJft3331043;
	Mon, 02 Nov 2026 08:19:20 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 00/15] Channel Sounding and RAP fixes
Date: Mon,  2 Nov 2026 16:18:57 +0800
Message-ID: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: kP_ZCMLilVhOY90cr2u-Wm5vAPueNxrc
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae8478b cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=DuaPKLnUuAEl1rpzAv4A:9
X-Proofpoint-GUID: kP_ZCMLilVhOY90cr2u-Wm5vAPueNxrc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX46HmLVCdJWPV
 RP9C2K7Mh9WgDrKsw4beW17Qwx8yWOccvyDqIxQzbFLriglenTWxj7vrnfsFveFE0ubrlavriCJ
 Yd9ignK1fA9R8re55W1jawJjKVf1Z0Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX6y3928MtTTDa
 La4K+Nm+Y+A8gdg706r6XJ7cORaZzWUUDCmHP0Tf7CQ+TTR5kjp045pHJ5/OgK/uX4cZAo/ArYr
 WRx6m/CXMm9IVz6AgiXNKqWWKYPQ6T8CCXbn9NGiuFYi0skCeN8ID5OJ3olAYeZB//SrHS4KXpY
 +PhHUcSjPzX57dVDGJ/z3iCTGYa76lCq3GjbC5x7QKIhufvy03bRrLKVCkxXPseUFgi136ngsUv
 HC5kMH6TFqpzWKFguMn2HiPrSxkDOmsrRb/RP2aorXu5I13CWXtkHteHqYDxIuTFo1Pks2/sAjr
 szFi0HK5e2S1la1L2nsgY2CaBVLb0x7CzRcAM/sRu5GFyHjVFJCXjWfS7aCUDY5qJy3EujkdGTX
 TqB7svlKhfngYsELjkZ1S9bTXk4oOhRY2puXplyfw4gxEYOBalVDveIi8MViF8XCgFmsfnD35w5
 X3t72qJYu2oY3gfIO9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

This series fixes problems found while running the RAP Requester (RREQ),
RAS Server (RAS/SR) and GAP CS test cases against PTS. So far the
Channel Sounding code had mostly been used between two BlueZ devices,
with the local side creating the configuration as the Initiator. The
test cases also cover the Reflector role, a configuration created by
the peer, peers with different antenna counts and every Ranging Data
mode, and most of the fixes are for those paths.

The patches do not depend on how the CS session is created; they apply
to the existing session set up from the RAP profile probe. Creating a
session for a peer without the Ranging Service is a separate question,
which I sent to the list earlier and is not part of this series.

GATT database and RAS (patches 1-4 and 15)
==========================================

 1. A device removed while disconnected kept its CCC state in the GATT
    database, and it was restored when the device paired again. Drop it
    from device_remove().

 2. The Ranging Counters read from Ranging Data Ready and Ranging Data
    Overwritten are scoped to the connection (RAS v1.0 3.4 and 3.5),
    but were never cleared, so a new connection read the counter of the
    previous one. Clear them in bt_rap_detach().

 3. On-demand Ranging Data was always subscribed with notifications,
    while the RAS Control Point, which only supports indications,
    followed the requested transport; with notifications no On-demand
    transfer could be requested. Follow RAS v1.0 Table 3.1: the
    requested transport for On-demand Ranging Data, indications for the
    Control Point, and indications for Ready and Overwritten whenever
    the server supports them.

 4. Reading RAS Features subscribed to Real-time Ranging Data at
    connection time, when no procedure is running yet, so the 5 s timer
    disabled it again. Subscribe when StartMeasurement() is called
    instead, unless SetRangingDataMode() already did, and use On-demand
    when the peer lacks Real-time Ranging Data (RAP v1.0 4.4.2).

15. RAP v1.0 4.4.1.1 counts the 5 s Real-time timeout from the start of
    the CS procedure, but the timer started when the CCCD was written,
    possibly seconds earlier. Start it from CS Procedure Enable
    Complete.

bluetoothctl and shared/hci (patches 5-6)
=========================================

 5. Fix a use-after-free in the StopMeasurement() reply of
    bluetoothctl, where the Active=false property change had already
    freed the session.

 6. bt_hci_get_conn_handle() always listed the connections of hci0 and
    took the first link matching the address, which could be a BR/EDR
    ACL or an old link being torn down. Use the right controller index
    and match the link type; this adds LE_LINK to lib/bluetooth/hci.h,
    replacing the local copy in hcitool.

CS role and setup in profiles/ranging (patches 7-14)
====================================================

These depend on each other and are best applied in order.

 7. StartMeasurement() returned early for a Reflector, so it never ran
    the setup phase and dropped every event the remote Initiator
    drove. Run the setup phase for the Reflector too, subscribe to
    Ranging Data as for an Initiator (the RAP roles are independent of
    the CS roles), and do not send Procedure Enable on stop when no
    procedure runs.

 8. With Role_Enable permitting both roles, the GAP role decided which
    one was used. Since the setup phase only runs from
    StartMeasurement(), take the Initiator role, and tolerate the LL
    Procedure Collision that two simultaneous configuration requests
    can cause.

 9. Config Complete overwrote the Role_Enable value with the negotiated
    role, so a second StartMeasurement() sent an invalid Role_Enable.
    Keep the two in separate fields, and do not send Procedure Enable
    from a Reflector.

10. Config Complete was only parsed in the state reached during a local
    setup, so a configuration created by the peer was dropped. Parse it
    in any state, ignore events for other links, and ignore a removal
    whose parameters are undefined.

11. The Set Default Settings response rewound a setup the peer had
    already advanced, and an Initiator then created a second
    configuration. Only advance from the initial state.

12. CS Security Enable needs an encrypted link (Core v6.2 Vol 4 Part E
    7.8.133). When the configuration completed before encryption, the
    command was never sent. Defer it to the Encryption Change event.

13. The antenna configuration was always ACI 7 (2:2) unless the
    application set another, which a single-antenna Controller on
    either end rejects. Choose one that fits both ends' capabilities
    and the negotiated role (Core v6.2 Vol 6 Part A, Table 5.3).

14. A StopMeasurement() during the setup phase did not stop it, and the
    Initiator went on to create a configuration and enable a procedure.
    Remember the stop until the next StartMeasurement().

Testing
=======

Each patch builds with --enable-maintainer-mode and unit/test-rap
passes. The PTS runs (PTS 8.14.0, Qualcomm controller) used a
BlueZ 5.86 based tree carrying these fixes.

Cheng Jiang (15):
  gatt-database: Drop stale device state for removed bonds
  shared/rap: Reset the readable Ranging Counters per connection
  shared/rap: Subscribe on-demand data with the requested transport
  shared/rap: Subscribe to Ranging Data when a measurement starts
  client/cs: Fix use-after-free in stop_measurement_reply
  shared/hci: Look up the connection handle on the right link
  profiles/ranging: Let the Reflector run the CS setup phase
  profiles/ranging: Let StartMeasurement() pick the Initiator for Both
  profiles/ranging: Take the CS role from Config Complete
  profiles/ranging: Act on a CS configuration created by the peer
  profiles/ranging: Keep a peer-driven setup from being rewound
  profiles/ranging: Defer CS Security Enable until the link is encrypted
  profiles/ranging: Choose the CS antenna configuration from both ends
  profiles/ranging: Do not start a procedure after StopMeasurement()
  shared/rap: Start the Real-time timeout when the procedure starts

 client/cs.c                        |  40 +--
 doc/org.bluez.ChannelSounding1.rst |  21 +-
 lib/bluetooth/hci.h                |   1 +
 profiles/ranging/rap.c             |  16 +-
 profiles/ranging/rap_hci.c         | 414 +++++++++++++++++++++++------
 src/device.c                       |   3 +
 src/gatt-database.c                |  25 ++
 src/gatt-database.h                |   2 +
 src/shared/hci.c                   |  12 +-
 src/shared/hci.h                   |   2 +-
 src/shared/rap.c                   |  82 +++++-
 src/shared/rap.h                   |   6 +-
 tools/hcitool.c                    |   3 -
 13 files changed, 484 insertions(+), 143 deletions(-)

-- 
2.43.0

