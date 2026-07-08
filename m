Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214C437877
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520315; cv=none; b=W9/m3Coksn0qDGDTBGCcmUkomaHPkczcyxvxXj7QBDIs0D+eRIiY7vsYmBSM0bcyevw9VBHWLZF54ebwNBl2s5urIGuCl7hwqbc7Cf7Kn01ykb92HcDq/maFHZTty8dlobY8aL4QGbxlstkpYyAQbrTxigVPtdrFAbpzp06qBSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520315; c=relaxed/simple;
	bh=r7lReXVS+A/ltE/USODT4sTPe45qlPFMThMKb+CyMwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZKDzY209+/GqjePeKOAWRJ/p0QC99HBeBsJ4ZDlcz59JzCBENMtSTqTCbLRIR9rmILgucfcmE5cMbfd983wxwNR4dnt5PjBTIIjAufCMczn988rjRJHR61u6QgpSIF5DLtOe81hubbrF0c6Z21teeChNwBD+MihZjDqH6+kWg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CG1klcC8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pfaa6hGO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CG1klcC8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pfaa6hGO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C49is2752250
	for <linux-bluetooth@vger.kernel.org>; Wed, 8 Jul 2026 14:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0OCKodQzEwdCiEed9W4BGC4DBD7ivBF/D0DG8atL1gU=; b=CG1klcC82sJJ0xh9
	bUABTOsk5ncNRh4/SLRzbyaVXMAma43DIOTHzO7Gn6Cfok4QcuqsGMoA+9B3/v9l
	LoS7C8K4x4mgYHv7RFVPpg7iSF9ojH0u5bBq/NC/jDNGVjvnh05oD85G5MJDpeFU
	dSM6U/fDhFn5qcs04l5cjxMfPgrbQxf6J8vOwGvlB3rcLDBvISVwO2jxaHRjJCyX
	5sgPFYx8F4zpwag7gEvB/FvZEKfd4Hc05G55dtzrHZEKZc2goLqjfHhSjbZF/FIz
	v2oqFlpbrrp36y7IKM6obTeq4+hieNvSKGwqSUtjc00Q6aYIJ8ywRLqmYK02zXOm
	J+IQOw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cssttxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 14:18:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccafc5e82cso10649385ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783520312; x=1784125112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0OCKodQzEwdCiEed9W4BGC4DBD7ivBF/D0DG8atL1gU=;
        b=Pfaa6hGOWiV+y8vhLDEuYTqOzqrmBya/vNuBKBfNIxiTNmAUMFKRDFt/AUtxpeYKDu
         sZuwY4401Hm7xct4hr5AQ53PKTuQf3hnMUng7FLaruD6ykkB3GfzPf7WuIUIGxJJNBYQ
         YqXKzP6S1QgRHQ8bC5fNEML2J1zdXJ5W4e06RpRXlC9TBMoJhjxXQSH0yD1vndO0P/lz
         OSfYyZQcUJ1QV+SVQ5ic5U5qB2J4JR7XkYFX5VWwVwVwdGfGtLzy6R7egmX/jzIMrxsH
         q7qKlAgUzgYN8qeSd1HgTIwLWXlf+XCz4cYH5NPrfmV9btWOkSifEQuXIrlhvnKFgnPN
         6zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783520312; x=1784125112;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0OCKodQzEwdCiEed9W4BGC4DBD7ivBF/D0DG8atL1gU=;
        b=EeNm5KdkfySl5aWn6vwWRjKe/TdhXoesaDEBSrfGulPfrxLdgs982Pc1eru4oVbuIx
         eG94fWXZykSnq1yX1SVWXXgjkMjq9OCEUGveK/tQ5+/WxUX1jcsTJ/uRYlLxpGhRitmQ
         f6My1gdoPcNDY5mrsCPSbLRQMupjwBcPfyH5uNcf3j9pYmRCP6X2+aGlu51sZLF9Aia4
         A8xFHFqi52N4kCeU61JKFKWnU0mnyYaQqkl47Uy0rgENvmCxMKC1OH99SW6MIfK6EBu/
         b1XUtq/FHtPaQb2DUCIWXcnZvv/nOe6TC8+bIIqePf4Ie1tHPeVrUPXD4fkLKykile3V
         FhhQ==
X-Gm-Message-State: AOJu0YxTlH4gkoqFlR1u3YIb5xtJzRPL3/kdp2xtNqSrltaAg26KtmgE
	h8bK2xPNlv4Llp9U6wd2Ww/XWhn4V0J96yn1wlDQbswKIFN7VAYuZDSi+Xz0WxWQpM6VUtwBCMt
	rGu6MtprgCRDGuwBDCCCHnhY2f2nJY63KziQjqdkxTLdd0UNrd2FGYqpOm3RnM4XdfJLhO0k6Tl
	8vEHM=
X-Gm-Gg: AfdE7cnbCqSXKcYX26czcNVGeweQMVPP88wSmXLeHSDZpRSp37P0ZJV8cmLTCTcwIyU
	8OILpiljKOZfm3kjINc8mz0xSVjgJ+ou2m/0l795DLw0LrxQvowYOssFImc7pMFAfSOyEBI0r7p
	tgmf0BBjEteU1Ihrj3Uk/qZqtpeTdRnncZ4i/9/BYQXB8yBOd5ofMeoxKLk6mV5lqZJzWo0hrLV
	BItFJYiviUua3O1KX8IvC7yqY0GbOgaAPdSn6elqGwTjR0DA9NG8XNcOE+2mHzbAQvAgpzHquSi
	hQxZsR5iHDDs+o2+rB3YYAHMyUCMfoFJmzDqyz4zBvU5ZU6fV195J8sH9vTRwCJWht6ls7hzeD6
	Csa8ISScGv4ozsD3YWZ3Yq0JVbdPu3vsgKysWZoVA
X-Received: by 2002:a17:90b:3d4d:b0:37f:9ce1:735f with SMTP id 98e67ed59e1d1-38941fb5f36mr2897497a91.32.1783520311820;
        Wed, 08 Jul 2026 07:18:31 -0700 (PDT)
X-Received: by 2002:a17:90b:3d4d:b0:37f:9ce1:735f with SMTP id 98e67ed59e1d1-38941fb5f36mr2897443a91.32.1783520311264;
        Wed, 08 Jul 2026 07:18:31 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5982sm22665427eec.5.2026.07.08.07.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:18:30 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 1/3] doc/org.bluez.ChannelSounding1:Add Used by reference and Examples
Date: Wed,  8 Jul 2026 19:48:17 +0530
Message-Id: <20260708141819.1284821-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708141819.1284821-1-naga.akella@oss.qualcomm.com>
References: <20260708141819.1284821-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4e5c38 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=wa7QpaTpAAAA:8 a=VwQbUJbxAAAA:8 a=4gOkWmRDMoXEQkgeNroA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX7Q+TLPLYGofa
 Us9L8RuuxTGsySt6N7JYX0ZrkQSgNDiR/XoaTPgjXSfQM21Q9K50Qt5iBCWTxLAmP0fVJZz1v/w
 kzLYkxKkhPj6vCqK5QCP9+2YhucaEo1RUUAoOWSPWDw5mlHJJS0EFRTpqKdRxa6H+G/JRtr/Gpp
 SxmwfR9aEZjo7WThtkjalmUKIplD0RGdZECsJVZkJ3Ko41XqWMlxec39qZ1CnPfStzfZ++3ny3E
 3BpmZweSa42NLgFIho814pOHmXxUlXY+qI2OS1O+J+72xs+YzB1sKYTGBn7MSWTXhqtix9b/MxG
 rE5m6zLIQe+ix7R+s7qplqkn06lRQyRiIheadHfqDUWN6L6uz4nY4moAwv23Kwg3DdtwdqhRc1Z
 zvHlzj6+wQ7uZl9safbG90pqMnT6GLe3eTLof76oNYbDZxMdZxO0ST7UEoTlEKiCaw3YCi9UJ7E
 osXjdxzTRMKghDHn1UA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfXz5FDoKdl3TSu
 JVuQQLNa9aH+mhugqNBJsuzDVfaB4gLEWz+G+5VX8PtTTFLqSDxWF9q/F+HGjYqtMRdAR1EHbbo
 ZBEQS8iX6bTzSUB30grXDqDhtE285jM=
X-Proofpoint-GUID: N_zugePluATT65U-9bjPKjKKWzMox9rc
X-Proofpoint-ORIG-GUID: N_zugePluATT65U-9bjPKjKKWzMox9rc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080140

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing corresponding bluetoothctl cs commands
for D-Bus methods
---
 doc/org.bluez.ChannelSounding1.rst | 301 +++++++++++++++++++++++++++++
 1 file changed, 301 insertions(+)
 create mode 100644 doc/org.bluez.ChannelSounding1.rst

diff --git a/doc/org.bluez.ChannelSounding1.rst b/doc/org.bluez.ChannelSounding1.rst
new file mode 100644
index 000000000..2c4a3e19d
--- /dev/null
+++ b/doc/org.bluez.ChannelSounding1.rst
@@ -0,0 +1,301 @@
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
+	| [cs] > start AA:BB:CC:DD:EE:FF role=0x01 main_mode_type=2
+:bluetoothctl start with defaults:
+	| [cs] > start [dev_addr [duration_secs]]
+:bluetoothctl configure as Reflector (applies settings, does not start a measurement):
+	| [cs] > start role=0x02
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
+Emitted for each Channel Sounding procedure as raw subevent data becomes
+available on the device identified by the object path on which the
+signal is raised. It carries the parsed CS procedure/subevent fields
+needed by an external distance-estimation consumer; BlueZ itself does
+not compute a distance from this data.
+
+:dict data:
+
+	CS procedure data, keyed the same way as the CS subevent/procedure
+	fields reported by the controller (e.g. step data, tone/PCT
+	values, timing information). Contents vary with the CS
+	configuration in effect for the procedure.
+
+**org.bluez.ChannelSoundingRanging1** is an example of a consumer of
+this signal: it subscribes to **ProcedureData** on every device object,
+feeds the data into a distance-estimation implementation, and
+republishes the result as **RangeEstimate** on the same object path.
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

