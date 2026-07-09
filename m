Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802641DF74F
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601529; cv=none; b=FinrsG9L7gtUSw7y13L6L2OTJnW/RaVH/GlmDVQIYNtzDulgZSzEv6uTWweWJUj2bYVTnMyZqpbmMFu26wqcePjM2zWrNJYcnPnlb9W0wFWHwJedPPp1Ntrsjors6DWr3l70q9sMO+BbacP5JMV+49RGu/Lgmh9rA0lUG+igZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601529; c=relaxed/simple;
	bh=wJY5AL12qd4ekZyqUUQbwp+0OACvk+cTFbvdymZuFhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRbGVWK9AHicNFIqGNlY7vghRTvUHkuG+LeOtvJIljzwK2ECOtjMKjLqt9WMTNu6gsCVGsTnJaX8HR+KgHMYBdV78j9VU1OIOAjOTY9oNa8bZmosLrDhlxZKinC+QT5iqPolxjGoh17xeR2AKfvDhxDOhRm8cawgaFTmqoRFJos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GZAyfcKu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gz1VNZNp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GZAyfcKu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gz1VNZNp"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNDfp1450534
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 12:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5jSdnOUWIjubXNtxLWdPykeLHwfwoRixGMQvXLr9toQ=; b=GZAyfcKuH/vWhxgE
	M0LJQMpsnGieN+sUZJTzdPzYmj9Gv6BYwQXFxNl7j9VlReFQpgWJtO9s45BhXr+1
	LZNPZZsUOPPp+5AaDyd/Y/5NnAQXMbz1oVQjOPIeEhEvxzmIUYg5+ovGX3ViKv+O
	niU1KsZut4aguqaFFmnoLaXjVQ59Txx22QU5EbErnC7/13uPf5s4bEHWCIXtWWb7
	Egy4wYuoel1vCfBAmZhAPs132ac2qBjpiTR14bEawAxn068sCfTWxyuLqrKyQueL
	C0zYCmUSEouKWgLZMC208tm4yLk9aNXDTCkv6dy4Ncr5kuXSeWsRxrvIey5MHg0o
	Q1t4qQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa55vj0kx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 12:52:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37fca5f21b1so771921a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 05:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783601526; x=1784206326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5jSdnOUWIjubXNtxLWdPykeLHwfwoRixGMQvXLr9toQ=;
        b=gz1VNZNp31tdawxCYgmau/jZ0VSAPnjlFMGBbM6j53o6pXzkrv4+qd0RKQHK6Fa6q2
         dMc03SGjr3ujTlOlhTHmiamYoC8qRTf5O5qatfpNSW2rQ2EsjeCHeNOR2Wbqi/8bmB1d
         /t14f4lLZugQ7+V7yIgUeZDA4dK1Mu1BKxicitmVVPAF8USFjBYnXz2BjTQ1+lB5nEPf
         qssgOsxxT3pR9bsmu0PKAopAhi6NJZrDhSximRlk7jUP9ULZu45/rzgMUsEjEfUQFPrN
         K71tcRp/8vlINCEBJCKAqF4OqnWyTZHRNHYIs9/jctW8PgDdemXWopPefmC21Q2a0soI
         NItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783601526; x=1784206326;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5jSdnOUWIjubXNtxLWdPykeLHwfwoRixGMQvXLr9toQ=;
        b=OYdFpsfQopIqJW5EPHVDjpySGxIjUbW9tkaSYt+YyRNLjSM73dFsuk/40v2FzM3Rs0
         PUXW0S/aGca3cU99gPVXGkO/3NAcTc1qrD6uTuhMgBeciOyYGYqbjKsHOWSc3o+Jb819
         2liP3QpygWJnM9WsJhmUne3MHXfvU9cAgGXEfEYlLuTKmpExbH3ZwKD7yiOwNtsnMRKF
         KI1QvSpxgRlp/kywR89VYRGehJCMwETK5qsoA+qypwu60S854qlOqD/38WN17oGyS/dW
         D1EcRHuOn+++xjQzyxVYGdz2QYNtE5jbmq3eUztqm0LkP+jxtFNwSd6XI4jxcBQH0moO
         Irpg==
X-Gm-Message-State: AOJu0Yy3RO5oSKOYofPlDRoifHKEj/Zz8jY1KPSaPOHD/bFPDX4Hewbt
	iDaCxP+/w2GFq0nirVrsvXl7RiImAutCQ71cqs5dvuB7RNI08Lafti5sqXidhWDGOkMJruMMuNi
	f7SzSW0sVcLCMksmAmSgDjSSIBjHu4NIMGnO2Li6A8PbfO72aKPjVBjc6Dqq9hp9OHESG587aIx
	Bve48=
X-Gm-Gg: AfdE7cky/6MWY7fjCnwsU/dwCqdJLmGuwaykeoCr3goI1U6GBTf1H20AvWfDJLp1XNc
	u+U9bbaAqlsYtd79JWnAnqKaw7Zm5KJF9iaymgBY8ugi41EGWL2w2j5C+ynITw3Zpa7+qFYhW3C
	w48/K2UdgF/O/Q1g2vtkZYnLQm1uyqtm3LPojUn4EbCbUw7ShL7Kq89AnWrkTQ2PZNgn13ucdMk
	UzJZZRrIoR/PgBcik5N8/ZzFww7Ew2XzM8GITXn4rY9E3avlE8P+HdnE8FREUa0QGURuca+XtRk
	px8lVUJjX8aCsxLa+lpnE1KL14XMBHIAiQ+t6NBVFoSphVQipnlSTRTAJqFBKvAHitc1mE75kfh
	MG5Kg+TNBa2ju3SqAy+jWrODdkYu8kp+t+50rFesD
X-Received: by 2002:a17:90b:388a:b0:36a:caf2:3815 with SMTP id 98e67ed59e1d1-38b7532ff04mr3096041a91.15.1783601525849;
        Thu, 09 Jul 2026 05:52:05 -0700 (PDT)
X-Received: by 2002:a17:90b:388a:b0:36a:caf2:3815 with SMTP id 98e67ed59e1d1-38b7532ff04mr3096003a91.15.1783601525159;
        Thu, 09 Jul 2026 05:52:05 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm28875679eec.18.2026.07.09.05.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:52:04 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 3/3] doc/bluetoothctl-cs: Add :Uses: fields and document arguments
Date: Thu,  9 Jul 2026 18:21:42 +0530
Message-Id: <20260709125142.2655974-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709125142.2655974-1-naga.akella@oss.qualcomm.com>
References: <20260709125142.2655974-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEyNSBTYWx0ZWRfX8fOLPiOAbAOV
 G7zXQ5FZ/5hAPoL5uEHlCpFMBf/HTqfrms6LonSctlwX9zodlCpgWOIb356jogiocc7PjKw/jhX
 hd8wNgjFSgD9UF7mgSBoeHlhzoUkoHPtBc9qchEwinCdhISRwns+76HO3lpaiONQKo/X/geHBLK
 0NBKHL7X1PK9xexFxWP6Z0VUfE5b3MlnaiNNji/SvkAIufKMN3A+o6FrlnDc8l/lCSrj9jnKWpa
 UPUTV/RZeTZ5SrKJre8ryvfsD95jFav2Q/K+VSJkbEXBcjyWa8hihu5AugmINd0L6Gm6rSBlFqv
 9wzZOF4oXBCp2dSDLiE6I63TUy3HJPwxR4OSdPXNb9j2D5n3JfF0Gn6RjMsU94gvfvll3L9njI4
 N37IIGeFW/maiYCHlubwaGHpOIoSjZ1iPgGVoe2K6Iwp/ZIfCJjKw/K/Zemuk5tsgBkXARu7s9P
 efHySdwodMxQ8lp50bw==
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a4f9976 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=wa7QpaTpAAAA:8 a=VwQbUJbxAAAA:8 a=Jy1yxQYmBQnJ9gfxIfcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEyNSBTYWx0ZWRfX4o9pTVuD+zXM
 TNLkvnQ4gq2u28rpmNdaibzFOls4ObSqx8xFruELtjqvQIZVBbTyurIRL5cf4q5IslukwfZ0+NC
 lzpLif7RUSoX8A3AEOuePKBMdzbI6Ck=
X-Proofpoint-ORIG-GUID: 8yDdeSSn6qWBL-1orHuPIfxuEzp2gk25
X-Proofpoint-GUID: 8yDdeSSn6qWBL-1orHuPIfxuEzp2gk25
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090125

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.
---
 Makefile.am             |   4 +
 doc/bluetoothctl-cs.rst | 281 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 285 insertions(+)
 create mode 100644 doc/bluetoothctl-cs.rst

diff --git a/Makefile.am b/Makefile.am
index 76c4ab5d4..84d0ff1c0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -405,6 +405,8 @@ man_MANS += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
 man_MANS += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
+man_MANS += doc/org.bluez.ChannelSounding1.5 \
+		doc/org.bluez.ChannelSoundingRanging1.5
 endif
 manual_pages += doc/bluetoothd.8
 manual_pages += doc/hci.7 doc/mgmt.7 doc/l2cap.7 doc/rfcomm.7 doc/sco.7 \
@@ -445,6 +447,8 @@ manual_pages += doc/org.bluez.Telephony.5 doc/org.bluez.Call.5
 manual_pages += doc/org.bluez.ThermometerManager.5 \
 		doc/org.bluez.Thermometer.5 \
 		doc/org.bluez.ThermometerWatcher.5
+manual_pages += doc/org.bluez.ChannelSounding1.5 \
+		doc/org.bluez.ChannelSoundingRanging1.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
diff --git a/doc/bluetoothctl-cs.rst b/doc/bluetoothctl-cs.rst
new file mode 100644
index 000000000..05a7c8170
--- /dev/null
+++ b/doc/bluetoothctl-cs.rst
@@ -0,0 +1,281 @@
+================
+bluetoothctl-cs
+================
+
+--------------------------
+Channel Sounding Submenu
+--------------------------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under the terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: June 2026
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**bluetoothctl** [--options] [cs.commands]
+
+This submenu controls Bluetooth Channel Sounding (CS) distance measurement
+using the **org.bluez.ChannelSounding1(5)** D-Bus interface. It allows
+starting and stopping measurements and inspecting the current parameter
+state and active session identifier.
+
+Each CS parameter has its own **cs.<param>** set command (see the table
+below). Overrides are applied to the local parameter state immediately,
+so **show** reflects them right away; **start** always uses whatever
+values are currently set.
+
+
+Channel Sounding Commands
+=========================
+
+start
+-----
+
+Starts a distance measurement on the connected device using the
+currently set CS parameters (see the **cs.<param>** commands below).
+All configuration is sent to the daemon in a single **StartMeasurement**
+call. On success the device path is printed to the console. Multiple
+simultaneous sessions across different devices are supported; each is
+tracked independently.
+
+Calling **start** on a device that already has an active measurement
+returns an error without starting a second session on the same device.
+
+For Initiator role (or Both), the mandatory parameters are the
+positional ``dev_addr`` and ``duration_secs``; every ``cs.<param>``
+command below is optional configuration with a usable default.
+
+If ``role`` is set to Reflector (``0x02``, via **cs.role**), **start**
+does not begin measuring distance: a Reflector never initiates a CS
+procedure. It only pushes the current parameters to the daemon and
+arms the device to respond once the remote Initiator starts one; the
+call still succeeds. Use **show** or watch the ``Active`` property to
+see when a procedure is actually running. In this role the only
+parameters that are required or have any effect are ``role``,
+``cs_sync_ant_sel`` and ``max_tx_power``; every other **cs.<param>**
+command below is accepted but unused.
+
+Positional arguments are optional:
+
+- ``dev_addr`` — Bluetooth address of the target device; uses the only
+  available CS-capable device when omitted.
+- ``duration_secs`` — auto-stop timeout in seconds; ``0`` (default) means
+  no timeout.
+
+:Usage: **> start [dev_addr [duration_secs]]**
+:Uses: **org.bluez.ChannelSounding1(5)** method **StartMeasurement**
+:[dev_addr]: Bluetooth address of the target device (optional; uses the
+             only available CS-capable device when omitted)
+:[duration_secs]: Seconds before auto-stop (optional, default 0 = no timeout)
+
+:Example Start with all defaults, no timeout:
+	| **> start**
+:Example Start on a specific device:
+	| **> start AA:BB:CC:DD:EE:FF**
+:Example Start on a specific device with 10-second auto-stop:
+	| **> start AA:BB:CC:DD:EE:FF 10**
+:Example Start with 10-second auto-stop (single device, address omitted):
+	| **> start 0 10**
+:Example Start with 5-minute auto-stop:
+	| **> start AA:BB:CC:DD:EE:FF 300**
+
+Setting CS parameters
+----------------------
+
+Each CS parameter is set with its own command, of the form
+``cs.<param> <value>``. Setting ``cs.role`` prints a note reminding
+which parameters matter for the newly selected role. Array-valued
+parameters (``channel_map``, ``min_sub_event_len``, ``max_sub_event_len``)
+take colon-separated hex bytes with no ``0x`` prefix.
+
+:Usage: **> <param> <value>**
+
+.. list-table::
+   :header-rows: 1
+   :widths: 35 15 50
+
+   * - Command
+     - Default
+     - Description
+   * - ``role``
+     - ``0x03``
+     - ``0x01`` Initiator, ``0x02`` Reflector, ``0x03`` Both
+   * - ``cs_sync_ant_sel``
+     - ``0xFF``
+     - CS sync antenna selection (0xFE/0xFF reserved)
+   * - ``max_tx_power``
+     - ``20``
+     - Max TX power in dBm (signed, range −127 to +20)
+   * - ``config_id``
+     - ``0``
+     - CS configuration identifier
+   * - ``main_mode_type``
+     - ``1``
+     - ``1`` Mode 1 (RTT), ``2`` Mode 2 (PBR), ``3`` Both
+   * - ``sub_mode_type``
+     - ``0xFF``
+     - Sub-mode within main mode; ``0xFF`` = unused
+   * - ``main_mode_min_steps``
+     - ``2``
+     - Min CS main mode steps per subevent
+   * - ``main_mode_max_steps``
+     - ``3``
+     - Max CS main mode steps per subevent
+   * - ``main_mode_repetition``
+     - ``1``
+     - Times main mode steps are repeated in a subevent
+   * - ``mode0_steps``
+     - ``2``
+     - CS Mode 0 steps at the beginning of each subevent
+   * - ``rtt_types``
+     - ``0``
+     - RTT measurement types bitmask
+   * - ``cs_sync_phy``
+     - ``0x01``
+     - PHY for CS sync: ``0x01`` LE 1M, ``0x02`` LE 2M
+   * - ``channel_map``
+     - ``FC:FF:7F:FC:FF:FF:FF:FF:FF:1F``
+     - 10-byte channel map bitmap (colon-separated hex)
+   * - ``channel_map_repetition``
+     - ``1``
+     - Consecutive repetitions of the channel map
+   * - ``channel_selection_type``
+     - ``0``
+     - CS channel selection algorithm
+   * - ``channel_shape``
+     - ``0``
+     - Shape used in channel selection algorithm
+   * - ``channel_jump``
+     - ``2``
+     - Channel jump size
+   * - ``companion_signal_enable``
+     - ``0``
+     - ``1`` to transmit companion signal, ``0`` to disable
+   * - ``max_procedure_duration``
+     - ``1600``
+     - Maximum duration of one CS measurement procedure
+   * - ``min_period_between_procedures``
+     - ``30``
+     - Minimum time between consecutive procedures
+   * - ``max_period_between_procedures``
+     - ``150``
+     - Maximum time between consecutive procedures
+   * - ``max_procedure_count``
+     - ``0``
+     - Max number of procedures; ``0`` = no limit
+   * - ``min_sub_event_len``
+     - ``00:20:00``
+     - Min CS subevent length, 3-byte LE (colon-separated hex)
+   * - ``max_sub_event_len``
+     - ``03:20:00``
+     - Max CS subevent length, 3-byte LE (colon-separated hex)
+   * - ``tone_antenna_config_selection``
+     - ``0x07``
+     - Antenna config for CS tone exchanges
+   * - ``phy``
+     - ``0x01``
+     - PHY for CS procedures: ``0x01`` LE 1M, ``0x02`` LE 2M
+   * - ``tx_power_delta``
+     - ``0x80``
+     - Remote vs local TX power delta; ``0x80`` = not applicable
+   * - ``preferred_peer_antenna``
+     - ``0x03``
+     - Preferred antenna for the peer device
+   * - ``snr_control_initiator``
+     - ``0xFF``
+     - SNR control for initiator; ``0xFF`` = no preference
+   * - ``snr_control_reflector``
+     - ``0xFF``
+     - SNR control for reflector; ``0xFF`` = no preference
+
+:Example Set role to Initiator only:
+	| **> role 0x01**
+:Example Set role to Reflector only (does not measure):
+	| **> role 0x02**
+:Example Set role to both Initiator and Reflector:
+	| **> role 0x03**
+:Example Set main mode to Mode 2 (PBR):
+	| **> main_mode_type 2**
+:Example Set main mode to both RTT and PBR:
+	| **> main_mode_type 3**
+:Example Set CS procedure PHY to LE 2M:
+	| **> phy 0x02**
+:Example Set CS sync PHY to LE 2M:
+	| **> cs_sync_phy 0x02**
+:Example Reduce max TX power to 10 dBm:
+	| **> max_tx_power 10**
+:Example Enable the companion signal:
+	| **> companion_signal_enable 1**
+:Example Limit the procedure count to 100:
+	| **> max_procedure_count 100**
+:Example Prefer high SNR on both roles:
+	| **> snr_control_initiator 0x01**
+	| **> snr_control_reflector 0x01**
+:Example Set a custom channel map (all enabled):
+	| **> channel_map FF:FF:FF:FF:FF:FF:FF:FF:FF:FF**
+:Example Configure Initiator, Mode 2, LE 2M, then start with a 30-second timeout:
+	| **> role 0x01**
+	| **> main_mode_type 2**
+	| **> phy 0x02**
+	| **> cs_sync_phy 0x02**
+	| **> start AA:BB:CC:DD:EE:FF 30**
+:Example Configure both roles, Mode 1, custom step counts, then start:
+	| **> role 0x03**
+	| **> main_mode_type 1**
+	| **> main_mode_min_steps 4**
+	| **> main_mode_max_steps 8**
+	| **> start**
+:Example Configure as Reflector with a 60-second timeout, then start:
+	| **> role 0x02**
+	| **> start AA:BB:CC:DD:EE:FF 60**
+
+stop
+----
+
+Stops an active CS distance measurement. When only one measurement is
+running the device address may be omitted. When multiple measurements
+are active the address is required to identify which one to stop.
+
+:Usage: **> stop [dev_addr]**
+:Uses: **org.bluez.ChannelSounding1(5)** method **StopMeasurement**
+:[dev_addr]: Bluetooth address of the device to stop (optional when
+             only one session is active; required otherwise)
+:Example Stop the only active measurement:
+	| **> stop**
+:Example Stop a specific device when multiple are active:
+	| **> stop AA:BB:CC:DD:EE:FF**
+:Example Stop a second device:
+	| **> stop 11:22:33:44:55:66**
+
+show
+----
+
+Displays all active measurements (device path for each) and the full
+set of CS parameter values that will be used on the next **start** call.
+When no measurements are active, ``none`` is shown.
+
+The parameter output is divided into three sections:
+
+- **Default Settings** — role, CS sync antenna selection, max TX power.
+- **CS Config Params** — per-procedure configuration fields including
+  mode type, step counts, PHY, and channel map.
+- **CS Frequency Params** — procedure scheduling fields including
+  duration, period, subevent lengths, and SNR control.
+
+:Usage: **> show**
+:Example Show active session and all CS parameters:
+	| **> show**
+
+RESOURCES
+=========
+
+http://www.bluez.org
+
+REPORTING BUGS
+==============
+
+linux-bluetooth@vger.kernel.org
-- 

