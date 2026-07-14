Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18C3DA5C3
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019053; cv=none; b=CMnQroQZVpYt1ItIcLHAmKW6hl5w2+rQO0qcsEueD4dmMzmqVUOtf9HXDmTqGSeYpavo58M1+9qKYrPkuVCVZ2PVZbxw1quNOJrB/1YaqmQcfSDsPNYPBeiFXH2hmv/P0CHdYBEKf+ShxzQMTtl1GWuW9gbXF1DfYZmM/CPMAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019053; c=relaxed/simple;
	bh=MtOo9xRmFEHW8vRqCCGSLGH2Q7eMPRgH0HD2Hsrq06g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5gItY1OJW/BB5Fg66NEdOpSJJiJFDXp6h94QPiBwNb3HFNmey8olwfgFUQxxT25RsBahOJjOVA0Vfj0JlOF23A30BTA67tSheTtqnfM6jEX/RwMygd4k6+OMG1Ubtj/f9Hv7+uEiKGCyTxKYb3DKYv8MGjGNSm/ixlVamZPfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ayVH0wuZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YCBTfKaw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ayVH0wuZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YCBTfKaw"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6SZ8g3740809
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 08:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zMHrlDqaM0ETaGbYw5hxseuhItVEebfJfStVYMf+x44=; b=ayVH0wuZtOtW97Gt
	3p3vTpdcVLNeEcxMByKrxVJWfy8qt200c+PuwsH+6A+MfB2QK/ZdUC38UZpV2yX/
	ArCdIE+M2JdnU2quPJEQpsCsUcC4FzxGAOT/6PTmGm0IDIABDyX5PjuuTB8Ub7ld
	mgoQKuhGTTR8eDeeFvLdqahmNnAx+4OoAXIvGc3sNf7QOIrQW+u0YsEhrCJB3CBx
	ODeE7hq/zxEkQq9eX/H9tRcf4H5gDhvVhg8jr2uHfOkLDG0oyysq0jW86rqQYgnw
	+PFozzi/+ypLiR3EaoWM/GEjIGW5YFRVgopXOvOUor75iptuLoqLWnmmyrXL8PRu
	TGmukA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdde094vw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 08:50:50 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c894391f000so1761741a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 01:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784019049; x=1784623849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zMHrlDqaM0ETaGbYw5hxseuhItVEebfJfStVYMf+x44=;
        b=YCBTfKawswG7wi26NvNHQPG2C6IsN7EWjb5BPZWzrjUhwX2ncC2HGoZ8sFXCrQZ5CW
         NScnjUkgeDUxgfRshXJ3ESleu/liyY0xrKMpM+9j6AEhh+oz2xzVrP8X+/I76jxPdSWp
         Os1AGWIrSdSOQ++iDAg6EoWCnJ8MDI3pkuOVxzSb1pKT5/YCcm00gwhC1WOuilEKxGYa
         Ej2mRAf6mmhEFq7Dbq6XPqSTfO3CIIozCdtNGVe0gfVt0uuUWzN4D/eJmv9I6/AGvwK2
         zAXZhENq7cgtdhpFGpLSOE77DKTh1UoOcpvIGIYF8f9D6OdCFjsydw9pFeRA4kv8CWNS
         r1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784019049; x=1784623849;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zMHrlDqaM0ETaGbYw5hxseuhItVEebfJfStVYMf+x44=;
        b=b1CsAcYrg1lzhZxWaA1p5Q7XUNltOWYL7YElZly45sIsg8OBQtTMHz6I0FbjRM08ij
         LNkgWzbfXScbzfAA63OqHaCxFO8K7odG03ptJOYBIcTYPKS7QWVWZhGXZ0PDE0QU4oWJ
         aPZBqAa51zsbGv451GIXD0m7fuj8JHtt0EBGqqUCeoDNzrRnHeKMFpTiaDPhBICedh87
         fiLny8bqHKKU+RClPH/ZvcstDlgwje9NPZPRtE2ggMojB9E0quvKV8XK7O0eqXkIUzFD
         5VAzkLuskw0zHSx2fpky3isvzX0wZAHxUCzysVY5SnVwdVQP3r5JHpbrtz3t6efSitTZ
         Pgcg==
X-Gm-Message-State: AOJu0Yxz3wcNPZ4eV2tbvTLwOyVLHjmfp0F7hJ429sdGnkHI/i1CHK2A
	2uDKcVo1tTe/XEbM4V8BJ49KlF0G6t6hAG4bttKajKL3WJ55VF/qYgn14bKD52jbNYSeoxs24EP
	sSDCdFJOxuSZnkopVYJOaC9fwTlDKXpQ5D3XHPSJseR9X1TtxvOCygOZftnJN87lJ3T4ZKrm3G2
	Zvbo0=
X-Gm-Gg: AfdE7ckfhLX3UHs2xK+d4g+q9aN7NFO5Zi32Hma5mRT2AyWBLNww+SawCUCJKYMVp1a
	SMVvgJJ6515jkJWIFHfnep+XiWenpFu44LO+aYvHzCcSHtyVTwfR514Dd+BtK8pbsBiDghh/SMA
	JagPFzKZld2sBGiL3H1urE9g/MtVUJSpNtdQvBZQx4dbKSkpjz7t1eMUknq4F58AbIzmIswu5cm
	Y6nnjZs47fvB0nPj+ujRVTA26rLZddVFV18GhURQnT3uJUvP9gN44lSsUdVzdYTkxOWZ1E+XP5g
	jDlaOASnoZR7f2fotwy1NpIHkK0/R/20G0MjB0lgnQRDDs+RJ+Tvvq9aOnYgyNy83d/rEF06yCz
	bEgsxC7aVzdbokdf/Ue7FsbzPh/DG7bFKkgQjBFEx
X-Received: by 2002:a05:6a21:389:b0:3bf:95f4:dad7 with SMTP id adf61e73a8af0-3c11077486dmr13284200637.41.1784019048929;
        Tue, 14 Jul 2026 01:50:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:389:b0:3bf:95f4:dad7 with SMTP id adf61e73a8af0-3c11077486dmr13284162637.41.1784019048372;
        Tue, 14 Jul 2026 01:50:48 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b9081d5c3sm27645721c88.9.2026.07.14.01.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:50:48 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v5 1/4] doc/org.bluez.ChannelSounding1:Add Used by reference and Examples
Date: Tue, 14 Jul 2026 14:20:34 +0530
Message-Id: <20260714085037.1285756-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714085037.1285756-1-naga.akella@oss.qualcomm.com>
References: <20260714085037.1285756-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5MSBTYWx0ZWRfX0dSaAFL1i3ht
 hWSP9hoTbMs51eTYBFzb9HqE5xQPQlue69Qc1x/CtimQMgSCLKG2F6/zzKLGWBofk6lmIcHKP5q
 JDm9CK0a4Gf1WikvsHb560SrxGqzKIo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5MSBTYWx0ZWRfX5TGwIF42OZqQ
 JAKaOGzJLvt9Fy6FjEIhp2hdPuLz2Z2QJ9+zeTStMhzWlQgCSS1RmKc51mJ9Nhb6CsT4Wfc7CL5
 PrX7IqbO9oEOcShGuXlmjgfxHHwuWlNmdbX6eBfc7/mf3s5GGwkdZz+xxSuPBJfu7tfBqJwt9xQ
 nMfwHcT7yjtyAaK1cGd95kPGW/Fe08fn9PoJj5qdwkVAKX7hgyXKUFSVmU9G8o8ahEB2hMlU/zl
 6l9POrg9u/UU2hJBTPkowHShIciWHfl7gDDAOyL9Lo/USNN2uRasZxw1o1kLiSu4nVtnqkZl43c
 gFi7+WoySIgLLfp8VPx2V+g1eJlMhA4u6x4ODwSv3/MF3lnU4gV/8YaXDIsiydcmETTBFNGxBL5
 Vd8ILm2gwQ5DwAnunMWt/SghT1dij5zUNVk7gFKaMKUs2DAYKmHfWeG+7fdlqPOTdZH+8tljLYw
 MHlotg0A7+PBKLRDsyw==
X-Proofpoint-ORIG-GUID: m4VZRbHJ06jF1aGIAqo-bp-kgg0lmRdG
X-Proofpoint-GUID: m4VZRbHJ06jF1aGIAqo-bp-kgg0lmRdG
X-Authority-Analysis: v=2.4 cv=F/FnsKhN c=1 sm=1 tr=0 ts=6a55f86a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=wa7QpaTpAAAA:8 a=VwQbUJbxAAAA:8 a=40pO8VyNcexSgXVS1NwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140091

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

