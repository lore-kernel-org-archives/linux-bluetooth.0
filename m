Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEBC421F00
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354594; cv=none; b=X/jNQQ7/CcYTWF1N2lFV+a+FU8Fy8xGGMKBFbNbpghxK5oSgBY7bv0v8uF66gtxURpimKynOBNFvq4bqR+/zrlh/dd1UlK7VOHMCotXLk00M0qS2tZJqbejvJNwvmwUKtvZ7R+QcfzgxMqNL8DVvpJzZzJZ33kpo2ukBoLjmPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354594; c=relaxed/simple;
	bh=r6s5rcKyjiOB6g67YnIdS7cHaeByKCpGrIrJJMGeEic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rN0xhrDbKKpeox1k7oRCljsgpJqFQMmnN7y6ZNu+UX0guS4CAaXnb1zFm1F1H8BtF+iSLokYLd42IboxyHvnohiSa94lxjqumL6ZfQEkBIll6mCB6UVPVzdHRayRdO9p+Tgw1kvAg5hXZng4QwAnoDdYIrQ0WOIyJHJ3BuqEQ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n/GTMOxL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Usw9Ie+s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n/GTMOxL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Usw9Ie+s"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF617832946
	for <linux-bluetooth@vger.kernel.org>; Mon, 6 Jul 2026 16:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HriuJxWLCo/+5whrWs0Ax9LMcFbbxDLsldAv8A7+NF8=; b=n/GTMOxLeqhXS9i3
	ioBd7ot+T61wDUFtMTS0cN2bR/Zp2xyX/YwwWgJ3wsRx/OsPBuCMNyYege5IBtWp
	i8XJUYwtEFibPfePybyBS9HcHf7ijatc9Hb5fRfQYMQ/NlONr6pE32NY3c8SVovh
	NF5wgzAmrakI2kBn6rY1bzqIQGJecwtfEcs3saFiQg675Jn20W1Q8GwA0cP+35Ah
	TAjqlMNA9esyYEm1CfjHbLu6ECdJFdCg9shUj6/2vdByHJZZ1IPqVLn3MqbXr4i8
	zSFW1OrNHI2QgqbPg+TA6NRAzZq+nG2QKPvMav8ceHt8JKCREAMvMFt6MjKLS2p4
	lS25qQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98hpbk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 16:16:31 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso5094420a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783354591; x=1783959391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HriuJxWLCo/+5whrWs0Ax9LMcFbbxDLsldAv8A7+NF8=;
        b=Usw9Ie+sutkijRYezviPdvVn3fy9QN4rD1iMjO7n2p3iY8XOdP4uzT9HTVQIz4ZNft
         H7BCrYog/weXWhz09n8UGIp8OFTsMx5ni6TDBk9zk+6STfCMbF1YB3J5QfwrvwpM70YZ
         NrDBgW2v5nlbJhlYwQtK4ra/lEcOoJDu97FigixBsIvsEse4y+im+zTe3gitu2OZjZkR
         tHNSdKzx74gt9SujM/b1lcNcbBTxrPZjvgId5RYCZBx+lV4Owls2kIEtEviaoP3i4lEN
         uULIQw8NtxVkv+7b9Pxruitm+VLmGSoDOmy+emv+9N2WFNpURTDwRWKRUf7TjU2kJBLw
         i0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354591; x=1783959391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HriuJxWLCo/+5whrWs0Ax9LMcFbbxDLsldAv8A7+NF8=;
        b=rprhDHx0X6SnamRfG/OjYSTPSZkg8unCePalUq9dOh6hu1zYFPcHFUf2Pc1sUE7FfC
         q02ZG+7GvROtFfOHREVFdBRhFYeQyvWKGMgW3ZMU/tU9EBmtpFkSmJMZ9sMpXnmLD6LX
         p+4tgt9wvCPca0JPdyOQ3CJzkbw1ORUiILmrj8rsGsi/xwtRXRU53K/lj8nGQmsZZyYn
         E2P3WVCfFjOLb0akAmgq9PKpF3y56BOtEJ+dpDfWkmMjnEqb0WqQrw5112xHrdg+MY0a
         zaG6sL8juWWGw7i3GxiY3PPKwoK0iul3HHJtQBLpbifAmEyF0R+ftRwr2jsMtEw3MfTj
         tBWQ==
X-Gm-Message-State: AOJu0Yz3WafKLgkLKwu+ejCJdqL+WF7QsonPdqnTKxczJS2SveTZbOHj
	JIqqSFLMWVidC1fgWxcBInfZ6QDsXgSemilCWSxUZVtzFXhXiCbusfasItheUFnlJTGIvpnf8Q6
	Waibx1wDca2ZRBqGh0JBvaS/+ys0L2cynu5g+vp+OPu8TPdpwtBMSOkICr6x4Xnk+RvBwU2wEfg
	qw60A=
X-Gm-Gg: AfdE7ckR2Mt9g+rFkTvZd/YlhmcLHBEtPj4PLhXEyqs61iS6ttozagfruSNkqKFDuu7
	fBZR0axR7ssB1l07Z+wSVrYgAFR3F+SES3SemxAlcBy4vpd4l0We3pMarB309CgSQAWP2TLeSxH
	iS5z+gWOW8m3g2J7E1xSb1WcD7BMnoKCrc0ObZkvYIaM2tNPAz33GY6GR7DL9QYFFpp0wapTSLk
	LmCvzWvaJZXmaw0nlWv9lxlU63xuzgA9ClCKs1dJa/iu387CM4s0ehlNMu+NmNJQYzfUOJTv4RQ
	z11Z2NshfL51o2HCN6ZjewghUelxhKGlolWpreNsISa3SoM7CH2zFEoseZ8l0AkpcCopR3PDFuh
	jPsmc7zr5WxjcX5M5QCF1bj+Ypnk0K9uZytAYpLv8
X-Received: by 2002:a05:6300:67c7:b0:3bf:b5fb:d7ac with SMTP id adf61e73a8af0-3c08ed4062dmr1503939637.10.1783354590215;
        Mon, 06 Jul 2026 09:16:30 -0700 (PDT)
X-Received: by 2002:a05:6300:67c7:b0:3bf:b5fb:d7ac with SMTP id adf61e73a8af0-3c08ed4062dmr1503648637.10.1783354585880;
        Mon, 06 Jul 2026 09:16:25 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f31e7a2a8sm40022434eec.25.2026.07.06.09.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:16:25 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 3/5] doc/org.bluez.ChannelSounding1: Add Used by reference and Examples
Date: Mon,  6 Jul 2026 21:46:01 +0530
Message-Id: <20260706161603.2744459-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706161603.2744459-1-naga.akella@oss.qualcomm.com>
References: <20260706161603.2744459-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4bd4df cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=wa7QpaTpAAAA:8 a=VwQbUJbxAAAA:8 a=RreBWJL54Kam1S7jYLkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2NSBTYWx0ZWRfX9YJMiCYXiYzZ
 L0PkWHS27aUoCqV9wmc/lpPMb9cIBOnQbM2dANuEXHTIF+l1mR1Zt4j/5xqUmc1nGecsHOfunGJ
 IkEHHdItsmZ6cFrtMFdsvjJtW9mkAv07todvpNuFEc8tnMFuODMwjGwkBhAagNh5nkmSWBy5XBA
 IkLxZcmJTXhghI5euULY4Z1MzKDQFCwJg5ZEJ4n2QVM+7G4hwztWmDKckFYUJK4PjS5HiStSNGY
 YN+2F6F86LdG15kxkUt8P9H5jT1oS+KgYTmtvw4EpNWSMK/3o7k06oLtJ4ppHnxMoPSoyncAFJr
 VMDG8Pbd7jqZEcLosbuE/reXOw2fRO6olzFQzzl0FFe9dR/BUcQzfr2YFkCsvSv2Csre1sSfGAO
 u3sPQmoJEZwXfVF60O05zj0mBjzguFdCBFTbPDJ8yJdR8nRIDcD14ptzKAT8Rd7RhQwAgKQ9r7w
 xSBGnkqJKO19N//ljGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2NSBTYWx0ZWRfX1NsChMPjB36L
 DDfQAGSFQJZRzzIVRK7x9gMtDD08joFnISa+l/OhghJFpS34n9/a69JiuywMLbd58k560QIqIKq
 gtNbmbFL3nxPioXkr342GN1nFkZf67U=
X-Proofpoint-GUID: oVgxy-9RmfBLUtyyHR2_e5-n4pnkrF46
X-Proofpoint-ORIG-GUID: oVgxy-9RmfBLUtyyHR2_e5-n4pnkrF46
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060165

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing corresponding bluetoothctl cs commands
for D-Bus methods
---
 doc/bluetoothctl-cs.rst            | 278 ++++++++++++++++++++++++++
 doc/org.bluez.ChannelSounding1.rst | 302 +++++++++++++++++++++++++++++
 2 files changed, 580 insertions(+)
 create mode 100644 doc/bluetoothctl-cs.rst
 create mode 100644 doc/org.bluez.ChannelSounding1.rst

diff --git a/doc/bluetoothctl-cs.rst b/doc/bluetoothctl-cs.rst
new file mode 100644
index 000000000..c16c89298
--- /dev/null
+++ b/doc/bluetoothctl-cs.rst
@@ -0,0 +1,278 @@
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
+CS parameters can be overridden on any **start** call using inline
+``param=value`` arguments. Overrides are applied to the local parameter
+state before the measurement is started, so **show** reflects them
+immediately after.
+
+
+Channel Sounding Commands
+=========================
+
+start
+-----
+
+Sets one or more CS parameters and starts a distance measurement on the
+connected device. All configuration is sent to the daemon in a single
+**StartMeasurement** call. On success the device path is printed to
+the console. Multiple simultaneous sessions across different devices are
+supported; each is tracked independently.
+
+Calling **start** on a device that already has an active measurement
+returns an error without starting a second session on the same device.
+
+Positional arguments are optional and must appear before any
+``param=value`` pairs:
+
+- ``duration_secs`` — auto-stop timeout in seconds; ``0`` (default) means
+  no timeout.
+
+Any additional argument of the form ``param=value`` overrides the named
+parameter for this call and for all subsequent calls. Array-valued
+parameters (``channel_map``, ``min_sub_event_len``, ``max_sub_event_len``)
+use colon-separated hex bytes with no ``0x`` prefix.
+
+:Usage: **> start [dev_addr [duration_secs]] [param=value ...]**
+:Uses: **org.bluez.ChannelSounding1(5)** method **StartMeasurement**
+:[dev_addr]: Bluetooth address of the target device (optional; uses the
+             only available CS-capable device when omitted)
+:[duration_secs]: Seconds before auto-stop (optional, default 0 = no timeout)
+:[param=value]: One or more ``param=value`` overrides (optional)
+
+**Settable parameters:**
+
+.. list-table::
+   :header-rows: 1
+   :widths: 35 15 50
+
+   * - Parameter
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
+:Example Start with all defaults, no timeout:
+	| **> start**
+:Example Start on a specific device:
+	| **> start AA:BB:CC:DD:EE:FF**
+:Example Start on a specific device with 10-second auto-stop:
+	| **> start AA:BB:CC:DD:EE:FF 10**
+:Example Start with 10-second auto-stop (single device, address omitted):
+	| **> start 0 10**
+:Example Start with no timeout, explicit:
+	| **> start**
+:Example Start with 5-minute auto-stop:
+	| **> start AA:BB:CC:DD:EE:FF 300**
+:Example Start as Initiator only:
+	| **> start role=0x01**
+:Example Start as Reflector only:
+	| **> start role=0x02**
+:Example Start as both Initiator and Reflector:
+	| **> start role=0x03**
+:Example Start with Mode 2 (PBR) main mode:
+	| **> start main_mode_type=2**
+:Example Start with both RTT and PBR modes:
+	| **> start main_mode_type=3**
+:Example Start with LE 2M PHY for CS procedures:
+	| **> start phy=0x02**
+:Example Start with LE 2M PHY for both CS sync and procedures:
+	| **> start cs_sync_phy=0x02 phy=0x02**
+:Example Start with reduced TX power (10 dBm):
+	| **> start max_tx_power=10**
+:Example Start with companion signal enabled:
+	| **> start companion_signal_enable=1**
+:Example Start with a procedure limit of 100:
+	| **> start max_procedure_count=100**
+:Example Start with high SNR preference on both roles:
+	| **> start snr_control_initiator=0x01 snr_control_reflector=0x01**
+:Example Start with custom channel map (all enabled):
+	| **> start channel_map=FF:FF:FF:FF:FF:FF:FF:FF:FF:FF**
+:Example Start Initiator, Mode 2, LE 2M, 30-second timeout:
+	| **> start AA:BB:CC:DD:EE:FF 30 role=0x01 main_mode_type=2 phy=0x02 cs_sync_phy=0x02**
+:Example Start both roles, Mode 1, no limit, custom step counts:
+	| **> start role=0x03 main_mode_type=1 main_mode_min_steps=4 main_mode_max_steps=8**
+:Example Start on a device, Reflector, 60-second timeout:
+	| **> start AA:BB:CC:DD:EE:FF 60 role=0x02**
+
+defset
+------
+
+Sets the CS default settings (``role``, ``cs_sync_ant_sel``,
+``max_tx_power``) on the connected device without starting a
+measurement. This is required for the Reflector role: a Reflector
+never calls **start** because it waits passively for the remote
+Initiator, so **defset** is the only way to push these settings to
+the daemon before the remote side initiates the procedure.
+
+Any ``param=value`` arguments update the local parameter state and
+are immediately sent to the daemon via **SetDefaultSettings**.
+Omitting all arguments sends the current local values unchanged.
+
+:Usage: **> defset [param=value ...]**
+:Uses: **org.bluez.ChannelSounding1(5)** method **SetDefaultSettings**
+:[param=value]: One or more of ``role``, ``cs_sync_ant_sel``,
+               ``max_tx_power`` (optional)
+:Example Configure as Reflector:
+	| **> defset role=0x02**
+:Example Configure as Both with reduced TX power:
+	| **> defset role=0x03 max_tx_power=10**
+:Example Apply current local values without changing them:
+	| **> defset**
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
diff --git a/doc/org.bluez.ChannelSounding1.rst b/doc/org.bluez.ChannelSounding1.rst
new file mode 100644
index 000000000..73f484507
--- /dev/null
+++ b/doc/org.bluez.ChannelSounding1.rst
@@ -0,0 +1,302 @@
+==========================
+org.bluez.ChannelSounding1
+==========================
+
+----------------------------------------------
+BlueZ D-Bus Channel Sounding API documentation
+----------------------------------------------
+
+:Version: BlueZ
+:Date: June 2026
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.ChannelSounding1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+:Used by:	**bluetoothctl(1)**, **bluetoothctl-cs(1)**
+
+Methods
+-------
+
+void StartMeasurement(dict params)
+``````````````````````````````````
+
+Starts a Channel Sounding distance measurement procedure on the connected
+device. All configuration is supplied in a single ``a{sv}`` dictionary.
+Any key that is omitted retains its current value in the daemon.
+
+The device to measure is identified by the D-Bus object path on which
+this method is called
+(``[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX``).
+Only one measurement per device object may be active at a time. Calling
+**StartMeasurement** while a session is already active returns
+``org.bluez.Error.InProgress``.
+
+Supported dictionary keys:
+
+:uint32 duration_secs (Default: 0):
+
+	Duration in seconds before the measurement is stopped
+	automatically. A value of 0 disables the automatic timeout.
+
+:byte role (Default: 0x03):
+
+	CS role to use for the measurement.
+
+	Possible values:
+
+	:0x01: Initiator
+	:0x02: Reflector
+	:0x03: Both (Initiator and Reflector)
+
+:byte cs_sync_ant_sel (Default: 0xFF):
+
+	CS sync antenna selection. Values 0xFE and 0xFF are reserved
+	by the Bluetooth specification.
+
+:byte max_tx_power (Default: 0x14):
+
+	Maximum TX power in dBm, treated as a signed value. Valid
+	range is -127 to +20 dBm.
+
+:byte config_id:
+
+	CS configuration identifier.
+
+:byte main_mode_type:
+
+	Main CS mode used in the procedure.
+
+:byte sub_mode_type:
+
+	Sub-mode within the main mode. Set to 0xFF when unused.
+
+:byte main_mode_min_steps:
+
+	Minimum number of CS main mode steps per CS subevent.
+
+:byte main_mode_max_steps:
+
+	Maximum number of CS main mode steps per CS subevent.
+
+:byte main_mode_repetition:
+
+	Number of times the main mode steps are repeated in a
+	subevent.
+
+:byte mode0_steps:
+
+	Number of CS Mode 0 steps at the beginning of each subevent.
+
+:byte rtt_types:
+
+	Round Trip Time measurement types for the configuration.
+
+:byte cs_sync_phy:
+
+	PHY used for CS sync packets.
+
+	Possible values:
+
+	:0x01: LE 1M PHY
+	:0x02: LE 2M PHY
+
+:array{byte} channel_map:
+
+	10-byte channel map bitmap. Must be exactly 10 bytes.
+
+:byte channel_map_repetition:
+
+	Number of consecutive repetitions of the channel map.
+
+:byte channel_selection_type:
+
+	Algorithm used for CS channel selection.
+
+:byte channel_shape:
+
+	Shape used in the channel selection algorithm.
+
+:byte channel_jump:
+
+	Channel jump size used in the channel selection algorithm.
+
+:byte companion_signal_enable:
+
+	Set to 1 to transmit a companion signal alongside the CS
+	tone, 0 to disable.
+
+:uint16 max_procedure_duration:
+
+	Maximum duration of a single CS measurement procedure.
+
+:uint16 min_period_between_procedures:
+
+	Minimum time between consecutive CS measurement procedures.
+
+:uint16 max_period_between_procedures:
+
+	Maximum time between consecutive CS measurement procedures.
+
+:uint16 max_procedure_count:
+
+	Maximum number of CS measurement procedures to run.
+	A value of 0 means no limit.
+
+:array{byte} min_sub_event_len:
+
+	Minimum CS subevent length as a 3-byte little-endian value.
+	Must be exactly 3 bytes.
+
+:array{byte} max_sub_event_len:
+
+	Maximum CS subevent length as a 3-byte little-endian value.
+	Must be exactly 3 bytes.
+
+:byte tone_antenna_config_selection:
+
+	Antenna configuration used for CS tone exchanges.
+
+:byte phy:
+
+	PHY used during CS procedures.
+
+	Possible values:
+
+	:0x01: LE 1M PHY
+	:0x02: LE 2M PHY
+
+:byte tx_power_delta:
+
+	Difference between remote and local TX power during CS
+	procedures. 0x80 indicates not applicable.
+
+:byte preferred_peer_antenna:
+
+	Preferred antenna to be used by the peer device.
+
+:byte snr_control_initiator:
+
+	SNR control setting for the initiator role.
+	0xFF indicates no preference.
+
+:byte snr_control_reflector:
+
+	SNR control setting for the reflector role.
+	0xFF indicates no preference.
+
+Possible errors:
+
+:org.bluez.Error.InProgress:
+:org.bluez.Error.InvalidArgs:
+:org.freedesktop.DBus.Error.Failed:
+
+Examples:
+
+:bluetoothctl set role then start:
+	| [cs] > start AA:BB:CC:DD:EE:FF role=0x01 main_mode_type=2
+:bluetoothctl start with defaults:
+	| [cs] > start [dev_addr [duration_secs]]
+
+void SetDefaultSettings(dict params)
+`````````````````````````````````````
+
+Sets the CS default settings for this device without starting a
+measurement. This method is intended for the Reflector role, where
+the device waits passively for the remote Initiator to begin the
+procedure and therefore never calls **StartMeasurement**. It allows
+the application to configure ``role``, ``cs_sync_ant_sel``, and
+``max_tx_power`` ahead of time so they are in effect when the
+controller processes the remote CS configuration.
+Need this to set default settings in Reflector role.
+
+Supported dictionary keys:
+
+:byte role (Default: 0x03):
+
+	CS role to use for the measurement.
+
+	Possible values:
+
+	:0x01: Initiator
+	:0x02: Reflector
+	:0x03: Both (Initiator and Reflector)
+
+:byte cs_sync_ant_sel (Default: 0xFF):
+
+	CS sync antenna selection. Values 0xFE and 0xFF are reserved
+	by the Bluetooth specification.
+
+:byte max_tx_power (Default: 0x14):
+
+	Maximum TX power in dBm, treated as a signed value. Valid
+	range is -127 to +20 dBm.
+
+Possible errors:
+
+:org.bluez.Error.InvalidArgs:
+:org.freedesktop.DBus.Error.Failed:
+
+Examples:
+
+:bluetoothctl configure as Reflector:
+	| [cs] > defset role=0x02
+
+void StopMeasurement(void)
+``````````````````````````
+
+Stops the active Channel Sounding distance measurement on this device.
+The device is identified by the D-Bus object path on which this method
+is called — no session identifier is required.
+
+Raises ``org.bluez.Error.NotConnected`` if no measurement is active.
+
+Possible errors:
+
+:org.bluez.Error.NotConnected:
+:org.freedesktop.DBus.Error.Failed:
+
+In **bluetoothctl(1)**, the device address argument may be omitted only
+when a single measurement is active; it is required when multiple
+measurements are active.
+
+Examples:
+
+:bluetoothctl stop the only active measurement:
+	| [cs] > stop
+:bluetoothctl stop a specific device when multiple are active:
+	| [cs] > stop AA:BB:CC:DD:EE:FF
+
+Properties
+----------
+
+boolean Active [readonly]
+`````````````````````````
+
+Indicates whether a CS distance measurement procedure is currently
+active on this device.
+
+Set to ``true`` when a procedure starts — either because the local
+Initiator called **StartMeasurement** successfully, or because the
+remote Initiator enabled a CS procedure on the local Reflector.
+
+Set to ``false`` when the procedure stops for any reason: the local
+application called **StopMeasurement**, the measurement duration timer
+expired, or the ACL connection was dropped.
+
+This property emits ``PropertiesChanged`` on every transition so that
+clients can track measurement state without polling.
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

