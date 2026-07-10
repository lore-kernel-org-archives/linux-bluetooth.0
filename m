Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B8039F190
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663168; cv=none; b=BXXV6HG0O09QlWfsMc1ulQ0vx5ZWPfD/EoV+vBGutr/4VfgzoJjVt0KqmVrEeRMrGpya2AZFeq2GK/auk4LlbzauJPOCrH9LMPvNA3GRkDhwjOrIfXUX1QPCUA0ZZdKq5qwmKT+/32Ir0hI2SXBw/4OSYEf7R1dJJai03nps8xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663168; c=relaxed/simple;
	bh=MtOo9xRmFEHW8vRqCCGSLGH2Q7eMPRgH0HD2Hsrq06g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5g0wo0Ofu9SapjFnzRAez2bGyfNdQyS6bKeN5JjprU3bMO2efVmntNko3MSWobHRtwfPJ/7el4gcPib+4rmJeqRnMPjlAi8UexWtdhhexD+3GOonUzFkSgmIZJjdkWwbSDfP5Q8o48LZbXs5oMUIbQ/iu3cTo9syZrBGCukw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W56nE49u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eE2CqEc5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W56nE49u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eE2CqEc5"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3mh603721078
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zMHrlDqaM0ETaGbYw5hxseuhItVEebfJfStVYMf+x44=; b=W56nE49uYscxDdWz
	Pzf63z1kCIdQBvgGTaC3H0sfsxf3nUIJwh2HTFbq6kXANUaAUKMKs56hB+DyRHkH
	HbMppGGQKCiwJrnYq25oMGTc4Ix+QUiDA4L726SZicNVYLb78jGRB9SOT8B0EKEO
	IaTZ5NshXW6sw+n8GGJFdyJcQYFDNpDFeBICDZEbST8wNDbRfuMFUXrTVN8jMcJc
	jiLz+ptO2Q1nrtkFWJY1G6c9ommNrWJ5mn0Tdyqzax4DvUqtyDL5zZ8/TTkx2WhZ
	7s2ke04rtIosv60xgs7P9E+cs73zOKjsu3ELiw3MtDS/U6/3ixLPY3D4FKAJvxHm
	ZDyrCw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajwt9jht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:59:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso928880a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 22:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783663163; x=1784267963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zMHrlDqaM0ETaGbYw5hxseuhItVEebfJfStVYMf+x44=;
        b=eE2CqEc5LXJmo9yKD9nBpbb589xc/ioq2VImmEGpYdRKKkz2uNwnSsTWalG09JPT9+
         7am7CQiBa/mjQh47YIEhsNSCBodM9zubYxal7wQKZEQ3wBzPKpSzahZmaKdIDaROG5E8
         MqzMD2WHHiMP7Z6V9MpTpP8FHTOzscv2+eSBciANbxY/HtE8YkHXJWkGnUO35V7gP3ZH
         M+M6DD1Le4OiX+SdgKrKrDbiK/w6oRHuFhNTzs0uRWAtjfkl+wHRZCBcYgjKgoKv8fSK
         IqkWXWyZDnS7K2iO1ENhcr7XnxTo51PAv1M5CLk+iul9wED7CsOorny+3c3ibNuS8x5T
         x7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783663163; x=1784267963;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zMHrlDqaM0ETaGbYw5hxseuhItVEebfJfStVYMf+x44=;
        b=OXyC11LiLGptYBhO1Mh76WU57eXBbpWQy8ftFkZVvJ9Ldvi/PzPWBQ5oV4cVoj1T/a
         P3DXsbBDDTIL24J180D//TLs9tuUCeiq5pwCsnG1SCGeZ+yIHX6tPY3hPxp77UvERBcN
         09lP1wubD8krWYRf+zCGGk3RdWvZvs9Fj2fmVUCd1FAdbGQYUtIYLVbJcgXpee4uKy+F
         9hhsJ2M/20RMaECBwPcI3aBrYAU+clKAWPwaapmsM15p7tBZHVlkCoREKdOU/VPqVe5t
         t3L9HfkK58ou6q2eUUDU7FY4c/oCMyz/HjINiYlUp3ZSpG6V/0x4eiflpixdBVM84lE5
         kBkQ==
X-Gm-Message-State: AOJu0Yy3xDIWL0zGSPS10E3M7ksYw6obHqfLvt7H6CIJWzu4GLEs5OpB
	aF7PWyaApN8/pb13OdA2PIDk2/IOH+lpsBhmEO0GZtY7jZQ+tWHWvYw6S81rKEUtbbP13x9r/cY
	PtBA+JstI4ShFZiaFEhYqmZgrbf8YGP6UHpAS5wPueQOxtafemdOA8AlnEUpIqvJUUmJ5zGRXnI
	v/fOM=
X-Gm-Gg: AfdE7cnA9U9xv/fCVo4MeZ5OWIMrKE514vRdiI1KsScvNPbnCSQ6AjOX0F5TN0SvkCd
	P/B+qggol7WQxI8lkOCcDXDW6m2uxytnAkIlTEbx12hZjr6DvwdvmW/Gh1L7t2+go6w4NJA7vAJ
	+oZkLT3L7tg+SrJBKGlSx3tYhSiPoNjdNoXexg32qe1r363thrz7kbpsQo1qi2GGojnvn2pz7h8
	kmN27Shb3OOqcMWHg0rcXPuZ2ie3FqkyWN/PWaoG3kJEDx93xv2/+s94U9f7vEbuiXOl3ua1k+v
	6tkTeD1s+XNj6aCT98xsoFi+6MPHomSZQWvx8tX2Q3XyONXg7FFu1bjOn/GNHz4cGazd0ldqxNI
	vuTY3O3t7WdbaJpcKKnf0TeQ/eCPrHra3lydIVzCv
X-Received: by 2002:a05:6a20:d529:b0:3bf:6c08:fb8f with SMTP id adf61e73a8af0-3c0bcbc5c4dmr11752771637.49.1783663163148;
        Thu, 09 Jul 2026 22:59:23 -0700 (PDT)
X-Received: by 2002:a05:6a20:d529:b0:3bf:6c08:fb8f with SMTP id adf61e73a8af0-3c0bcbc5c4dmr11752734637.49.1783663162557;
        Thu, 09 Jul 2026 22:59:22 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm39678529c88.12.2026.07.09.22.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 22:59:22 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 1/3] doc/org.bluez.ChannelSounding1:Add Used by reference and Examples
Date: Fri, 10 Jul 2026 11:29:08 +0530
Message-Id: <20260710055910.3691701-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710055910.3691701-1-naga.akella@oss.qualcomm.com>
References: <20260710055910.3691701-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XOYAjwhE c=1 sm=1 tr=0 ts=6a508a3c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=wa7QpaTpAAAA:8 a=VwQbUJbxAAAA:8 a=40pO8VyNcexSgXVS1NwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-GUID: rwjWqIsiyFLBTzyn5fx5pk_OUXzzn-2O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1NCBTYWx0ZWRfXw0PsTijRQwod
 0TkrQfmg2AnVKUNsGOoxVHpryq6jSpCqUakdVAYuwvW/6pKICd5VruV20r4RN4qu49C43rU5a5Q
 JQhXBiNd33DSF6+a4Xvma1vj0efufX4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1NCBTYWx0ZWRfX6UNRIyJZ4iv1
 DPmpscz7UBT2HchU+s8tr+58DUMtUNTia5at9vXQyEttgQhzN/yeagAU2tOA4AjQJL26jQn60NB
 lqXgxaTUxwvBHtxCliq47nMgnjOaL1c8gX0AtL5j/4ExdljAqfQuyOqMk+jnFqQy8DSBHigISKh
 QCn0To7+qeHVENSHjbg4G4XfXT2khKZTiY9XgnZWC1AcFYer2uI0ld5h8fZOx0U5dCd3bRfe+bm
 g4PBK2Ku5maPyz+JRRONJ92xRynqBBnf4Mwr0op9QXCSXGcVgNMgLe4Kcdl8TYmhxZUhx0ad5vO
 GfM56u49L+jQxLfciCOAltsQhdFeEseEj66XXW3f87hPGsHNJbeSHpdPnpZFUZOcbmCT9ek6s1n
 +xPgpJYe84xvGH7hTgykWGlFUfqeiY56D8bqogqZSQ5LT3Kp9OnnRvXi0qrtnmQyOz3fy4lOpdn
 D4170WVLn5m5RxS4Iew==
X-Proofpoint-ORIG-GUID: rwjWqIsiyFLBTzyn5fx5pk_OUXzzn-2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100054

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing corresponding bluetoothctl cs commands
for D-Bus methods
---
 doc/org.bluez.ChannelSounding1.rst | 534 +++++++++++++++++++++++++++++
 1 file changed, 534 insertions(+)
 create mode 100644 doc/org.bluez.ChannelSounding1.rst

diff --git a/doc/org.bluez.ChannelSounding1.rst b/doc/org.bluez.ChannelSounding1.rst
new file mode 100644
index 000000000..c06e1d728
--- /dev/null
+++ b/doc/org.bluez.ChannelSounding1.rst
@@ -0,0 +1,534 @@
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
+not at all, if the remote never initiates one). Clients that watch
+``PropertiesChanged`` for ``Active`` (as **bluetoothctl-cs(1)** does)
+are notified of both the remote-initiated start and its eventual stop.
+
+For Initiator role (or Both), ``duration_secs`` and the device object
+path are the parameters that matter to start a measurement; every
+other key below is optional configuration with a usable default. For
+Reflector role, only ``role``, ``sync_ant_sel`` and ``max_tx_power``
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
+:byte sync_ant_sel (Default: 0xFF):
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
+:byte sync_phy:
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
+	| [cs] > start [dev_addr] [duration_secs]
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

