Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E4212548
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601522; cv=none; b=WpFN8/apz+9+0z8v0rP4TRxhG9ICiZ31eWa+d+/nUaCJ93Mv1jXbNnkeeIkRhnUREOYbjQI572fH9QFICOzQKi+25IxdUQuh4z99S0anP3MQ9Gzx53Ukc5aOQmxZbuxmWurhFFEhaR27wnzknwtANx7MOMBoNzVJgYlSDb4dWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601522; c=relaxed/simple;
	bh=qM7j/gHaANJLA8Lt2vJGvHDFsEqZIx8aEZ6TdPzAlV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMKdA9pE95Odidq62qw0HB0M7Xi5SDSxeQy0NrsoBtDXNJhq4DY4tdcdj3yM8FAm/lAYMR0CenKwaz0mD0+1MHntS9CNl8ajGhi0+9gmttqNSZvttj8LXwgeQWe6KBX+OzKYwHTbTBFOvXkuOLj7HGHvJo0O5l2dVscvvqX277o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FZkGPowe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TbuJV1Sx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FZkGPowe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TbuJV1Sx"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNb7v1489241
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 12:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oJJTauyhgQ9rh7/q1B/jgRArmU3Fecl7cljMZyfEjJc=; b=FZkGPowebnRYU06K
	aQxoWbvQnm9B5l3fJ3VDpw3yWDy37LRRwyU+rWbnKinc+zo9q4JBB/raNHCBf6rT
	xQ3zsckoJOMNitOm8XrUql9xUdExsRlyQhptw4ptvuPlayBryB1TdIF4noGBwGf0
	dV32A00iLLRyPmB9poAYBODR6Xp0cdSAxmgaWLnxwNCWIayjzSMQoolImmxCVUfo
	Yq9AOfsuYCHR0TmMspDwsIa2Qw9wVJ1SWAXfNWmvRSeKzNFexkPAApzQXFBPNs13
	ry6q4mipDiC3WAZgWRrXqXTukZXlwYyAiPiFtQmIQ/AGxE2HGYcsSP5K8i8ONsk+
	nUDg0A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwfu8dn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 12:51:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3810960140eso3600492a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783601518; x=1784206318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oJJTauyhgQ9rh7/q1B/jgRArmU3Fecl7cljMZyfEjJc=;
        b=TbuJV1Sx+pEnkilInvH8kB71tDSGHfGwWLtQGZLr92lqoldfFPSvMvd46sH3c/JPd8
         MK0QvpDUMp0RvbWVS7kzsRusAUcwW7212b75eEHww50LAAdctu25Q9XGKsrpXD7j9G9w
         Kqq5M+ast5ho5JlqmaxgsPJYQ7aGm2XFlGgPTem/+327fl8cbuqBZy9e68W3YP+Y3Njk
         9DKoJax1cf3zB15D5dnXN4s9y9JbchEOoe8N/aWpOobYihecvSymVtr4jbqKfowLTWWP
         Wf1xLN2qIV6tU7btk22nyJNnTAsM2oO7R0WerQZHG1AbKEOuE5jsxb/rEQWCBNsJ9ZTG
         GxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783601518; x=1784206318;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oJJTauyhgQ9rh7/q1B/jgRArmU3Fecl7cljMZyfEjJc=;
        b=lca4Dg4oGQHwVCdWuj8TFPB7qIVRaXq99TBQ+OvfVk7O4zcjB2R3/3kzL3uRGPN1x7
         FrEVo+QyDT4JCAsyJVKyvZXB5IgvQZmvB38bQhY9L+JkbsosTTQXH4jKRtgVc4WwoQzv
         1V+cjj0ietasLU/Jmd9dmRLmYF3Ecg7h1udoyFbNTVra06vnEUyLchrAEycMzYmz+sSZ
         MeXb7EwX4rqh5s0a/pfk742zorrD0GGpmLX07HFjgreF71djtwo+z3RnqEJ6P5B5i852
         nRxJ1fG5fiWrVWnpfH8M0tQrCkzEzY8o0B9s3hUqyyZB78+wXoSBJDw3zw+GFczbosSj
         OLQA==
X-Gm-Message-State: AOJu0Yx84fUGG8ubcr2DckWnd4DF+2yG7Tv5zjaUUtGTAJ0tQbNsGSsW
	eMsF59ddtLevOurrgqJUj9S7lnVCc9dJj8eZ/kp44aEPZ9rvatbUPXpCHLJCiSL5ovJgSwUPOf4
	jACRk95KsC/BPgZQrfDzC5iHJp/4ugsi9sLQpr/S1PJLnSnzouLkBF+RLdujAGM+28I/YYywwPm
	bIWBQ=
X-Gm-Gg: AfdE7ckNYLQQ7+v5DDa3DDTBAUUDf8CD83Ri7qteJOHHgMUSs+StYzcuBryMoUoEJEU
	Acz81KyP2859U8zpMuhePyjJC7Mum+Msfiaq0jcKNLo+woO/AtOc7aPj+KVJ/uPCGZoRWGamLX0
	W+rkb39rRF3G9BNh4DNdghMYSvDyqYrTWN+XgsUlMlQdSQcRBKRQSNCt+aclMQjpRN0EDB5hEbg
	DmGWA5lyVswqAH/4oJJ3Oa+vn73hi2bcrjeG3dYGk1UOfS2kWDa1EyWAkqxnNW4QWiSlvkk+6PX
	gv8f7MCD4g9ZLQ6zZi39O/bmNTD987BVIKGurECs4pYWgwU5h0l7JI4nPP91mTbDqP/WJNI1q5W
	VJYpsTbduAxc1XG2AK4Il4qKgHhRcaqETMiWR4A4V
X-Received: by 2002:a17:90b:5190:b0:37f:9cdf:f0ac with SMTP id 98e67ed59e1d1-38941cc77a9mr7387051a91.27.1783601517847;
        Thu, 09 Jul 2026 05:51:57 -0700 (PDT)
X-Received: by 2002:a17:90b:5190:b0:37f:9cdf:f0ac with SMTP id 98e67ed59e1d1-38941cc77a9mr7387007a91.27.1783601517196;
        Thu, 09 Jul 2026 05:51:57 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm28875679eec.18.2026.07.09.05.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:51:56 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 1/3] doc/org.bluez.ChannelSounding1:Add Used by reference and Examples
Date: Thu,  9 Jul 2026 18:21:40 +0530
Message-Id: <20260709125142.2655974-2-naga.akella@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEyNSBTYWx0ZWRfX3IQgmpg7g9hS
 38Xsg0Zyqa3K3V8/z3GMBooP5YFuOx3KNAsxb62y+/VWLGBf4Q5IKD0pyN124isR+uddACTsZEO
 lp7mGCstvnzZVVsD7ohac2+5DkLF/ZPHTe+7OG+g9YT7AMZvgQ/hdkkGHdAA6u6YRYP3NvKJ/Vh
 2iUdqxpYfSnSGrOvslygpKsyxQIIEcms0IfqaxlCdjeD1PJDGH6ama9bR/yXdKJTDkE6bGAY3L+
 UV+LJqkAGO+DTb0gTaVY5N6nzfT/W2zM4lFFlax5KC/k3Zmuo7AwALI+45Aojm3NwdoM8tR2oJP
 f+YWXU0HfWHs2j152J9/I3LgnV87yYJYLYgo3xBZhB7Tf7yGSBCYtCePmjfXZuiAx7JjWmuzTF+
 rvRMhJ0+saM6AxfSL7i9RDmFaWQWUIalHPKdY+oGYS5ngdCuNH09Dyd7hZytdmFke8PIP8H6tOV
 /1hwc7BJdSP2GGEc8qw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEyNSBTYWx0ZWRfXx9b61WKWvikA
 CWCH0FsqJRi2gokZaV8DcydusQPuRU7dVAdtKt1vfcBXxwsUyLpdBKh4+2cQFxx7Ps8WZ83dgGJ
 udmRKl+9vLvropiLVAqTXmbuIK5JLUU=
X-Proofpoint-ORIG-GUID: ephizIWKzH7K3MRUYAfAxNPWCnuTDboX
X-Proofpoint-GUID: ephizIWKzH7K3MRUYAfAxNPWCnuTDboX
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f996f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=wa7QpaTpAAAA:8 a=VwQbUJbxAAAA:8 a=40pO8VyNcexSgXVS1NwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090125

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing corresponding bluetoothctl cs commands
for D-Bus methods
---
 doc/org.bluez.ChannelSounding1.rst | 532 +++++++++++++++++++++++++++++
 1 file changed, 532 insertions(+)
 create mode 100644 doc/org.bluez.ChannelSounding1.rst

diff --git a/doc/org.bluez.ChannelSounding1.rst b/doc/org.bluez.ChannelSounding1.rst
new file mode 100644
index 000000000..a573a635f
--- /dev/null
+++ b/doc/org.bluez.ChannelSounding1.rst
@@ -0,0 +1,532 @@
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
+When ``role`` is Reflector (``0x02``), this method does not start a CS
+distance measurement: a Reflector never initiates a procedure locally,
+so it cannot start one via this call. Instead, all given configuration
+is applied and stored so the controller is ready to respond once a
+remote Initiator begins a procedure, and the method returns success
+without arming a local measurement session. The ``Active`` property
+only transitions to ``true`` when a remote-initiated procedure
+actually starts, which may happen well after this method returns (or
+not at all, if the remote never initiates one).
+
+For Initiator role (or Both), ``duration_secs`` and the device object
+path are the parameters that matter to start a measurement; every
+other key below is optional configuration with a usable default. For
+Reflector role, only ``role``, ``cs_sync_ant_sel`` and ``max_tx_power``
+are required or have any effect — the remaining keys are accepted but
+otherwise unused, since no local procedure is armed.
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
+	| [cs] > role 0x01
+	| [cs] > main_mode_type 2
+	| [cs] > start AA:BB:CC:DD:EE:FF
+:bluetoothctl start with defaults:
+	| [cs] > start [dev_addr [duration_secs]]
+:bluetoothctl configure as Reflector (applies settings, does not start a measurement):
+	| [cs] > role 0x02
+	| [cs] > start
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
+Signals
+-------
+
+void ProcedureData(dict data)
+``````````````````````````````
+
+Emitted when a Channel Sounding measurement procedure completes on this
+device, carrying the raw CS procedure results as reported by the
+controller. Consumers such as an external ranging estimation daemon
+subscribe to this signal to compute distance estimates.
+
+:dict data:
+
+	:int32 procedureCounter:
+
+		Procedure counter value from the controller.
+
+	:int32 procedureSequence:
+
+		Sequence number of this procedure.
+
+	:byte initiatorSelectedTxPower:
+
+		TX power selected by the Initiator, treated as a signed
+		value.
+
+	:byte reflectorSelectedTxPower:
+
+		TX power selected by the Reflector, treated as a signed
+		value.
+
+	:uint32 initiatorSubeventCount:
+
+		Number of subevent results reported by the Initiator.
+
+	:array{dict} initiatorSubeventResults:
+
+		Present only when ``initiatorSubeventCount`` is greater
+		than 0. One entry per Initiator subevent, each with the
+		fields described in `Subevent Result`_ below.
+
+	:byte initiatorProcedureAbortReason:
+
+		Reason the Initiator's procedure was aborted, 0 if not
+		aborted.
+
+	:uint32 reflectorSubeventCount:
+
+		Number of subevent results reported by the Reflector.
+
+	:array{dict} reflectorSubeventResults:
+
+		Present only when ``reflectorSubeventCount`` is greater
+		than 0. One entry per Reflector subevent, each with the
+		fields described in `Subevent Result`_ below.
+
+	:byte reflectorProcedureAbortReason:
+
+		Reason the Reflector's procedure was aborted, 0 if not
+		aborted.
+
+	:dict procedureEnableConfig:
+
+		:byte toneAntennaConfigSelection:
+
+			Antenna configuration used for CS tone exchanges.
+
+		:uint32 subeventLenUs:
+
+			Subevent length in microseconds.
+
+		:byte subeventsPerEvent:
+
+			Number of subevents per event.
+
+		:uint32 subeventInterval:
+
+			Interval between subevents.
+
+		:uint32 eventInterval:
+
+			Interval between events.
+
+		:uint32 procedureInterval:
+
+			Interval between procedures.
+
+		:uint32 procedureCount:
+
+			Number of procedures configured.
+
+		:uint32 maxProcedureLen:
+
+			Maximum procedure length.
+
+	:dict csConfigParam:
+
+		:byte modeType:
+
+			Main CS mode used in the procedure.
+
+		:byte subModeType:
+
+			Sub-mode within the main mode.
+
+		:byte rttType:
+
+			Round Trip Time measurement type.
+
+		:array{byte} channelMap:
+
+			10-byte channel map bitmap.
+
+		:byte minMainModeSteps:
+		:byte maxMainModeSteps:
+		:byte mainModeRepetition:
+		:byte mode0Steps:
+
+		:byte role:
+
+			CS role in effect for the procedure (Initiator,
+			Reflector, or Both).
+
+		:byte csSyncPhyType:
+
+			PHY used for CS sync packets.
+
+		:byte channelSelectionType:
+		:byte ch3cShapeType:
+		:byte ch3cJump:
+		:byte channelMapRepetition:
+		:byte tIp1TimeUs:
+		:byte tIp2TimeUs:
+		:byte tFcsTimeUs:
+		:byte tPmTimeUs:
+		:byte tSwTimeUsSupportedByLocal:
+		:byte tSwTimeUsSupportedByRemote:
+
+		:uint32 bleConnInterval:
+
+			BLE connection interval in effect during the
+			procedure.
+
+Subevent Result
+~~~~~~~~~~~~~~~~
+
+Each element of ``initiatorSubeventResults`` and
+``reflectorSubeventResults`` is a dict with the following fields:
+
+:int32 startAclConnEvtCounter:
+
+	ACL connection event counter at the start of the subevent.
+
+:int32 freqComp:
+
+	Frequency compensation value.
+
+:byte refPwrLvl:
+
+	Reference power level, treated as a signed value.
+
+:byte numAntPaths:
+
+	Number of antenna paths used.
+
+:byte subeventAbortReason:
+
+	Reason the subevent was aborted, 0 if not aborted.
+
+:uint64 timestampNanos:
+
+	Timestamp of the subevent result, in nanoseconds.
+
+:uint32 numSteps:
+
+	Number of steps reported in this subevent.
+
+:array{dict} stepData:
+
+	One entry per step. Each entry has:
+
+	:byte stepMode:
+
+		CS step mode (0-3).
+
+	:byte stepChannel:
+
+		Channel used for the step.
+
+	:dict modeZeroData:
+
+		Present when ``stepMode`` is 0.
+
+		:byte packetQuality:
+		:byte packetRssiDbm:
+		:byte packetAntenna:
+
+		:int32 initiatorMeasuredFreqOffset:
+
+			Frequency offset measured by the Initiator.
+
+	:dict modeOneData:
+
+		Present when ``stepMode`` is 1.
+
+		:byte packetQuality:
+		:byte packetNadm:
+		:byte packetRssiDbm:
+
+		:int32 toaTodInitiator:
+
+			Time of Arrival / Time of Departure at the
+			Initiator.
+
+		:int32 todToaReflector:
+
+			Time of Departure / Time of Arrival at the
+			Reflector.
+
+		:byte packetAntenna:
+
+		:array{int32} packetPct1:
+
+			In-phase/quadrature sample pair, as
+			``[i_sample, q_sample]``.
+
+		:array{int32} packetPct2:
+
+			In-phase/quadrature sample pair, as
+			``[i_sample, q_sample]``.
+
+	:dict modeTwoData:
+
+		Present when ``stepMode`` is 2.
+
+		:byte antennaPermutationIndex:
+
+		:array{int32} tonePctIQSamples:
+
+			Interleaved in-phase/quadrature tone samples, as
+			``[i_sample, q_sample, ...]`` — one pair per
+			antenna path.
+
+		:array{byte} toneQualityIndicators:
+
+			One quality indicator byte per antenna path.
+
+	:dict modeThreeData:
+
+		Present when ``stepMode`` is 3. Contains the combined
+		fields of both **modeOneData** and **modeTwoData**.
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

