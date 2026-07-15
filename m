Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF9F3C2B80
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104820; cv=none; b=r8moMReTx6c3GR1s+4J5Z0thwMfl+KXOyIRozlD0vC36pV7HxiACWk4yelr1gnBr5s8P/ETQXqD0ef6CLIkXpebo9DaFr5ywsVEzmrWkWlH/BueNUpoa8HTyDfBgPL7hGlATTDNMsKHDs3jFawq/0lEMhGk7emA24AsZuTzNKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104820; c=relaxed/simple;
	bh=7O16GIF19Q/QzpdXhMPaFCP5z6zyuc99Lela93ewS+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2lUtIvrKMtN6HD22Y2pe6RzQPbmOnL3fMw9EML3Dg79hk/K8zM1sbEq7YesvG/ACB4VaPhsxZN9xORtw4mgBczQ2Xu+feAwflKveKpzZkTgkZ+Ub5yaAQm/HUhSqct1Rgua8ptDx3545mQTUNnDUV9SVzr8q5blUU7j3B8/S0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fyl+SYj4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kJeeHdpm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fyl+SYj4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kJeeHdpm"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lJdB2621249
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 08:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jErdnoopuqAihKNJLLXSkeEYwCLjyO9zQsDrw9PVcis=; b=Fyl+SYj4Ju0+uP67
	ObcUlu5r0aLo1BeMHeJmvXTLzGoNF6wUCCflAyh/0EqvxbYV+10515HN4xOHUiPk
	aoSzdzoVdFRa//mW8UJbG92Kod6Eq378LDp51xCueeMRcUIXFcoQZX1BSnU+hY+3
	XKA8plSuusiMaUIWtj4jvScCkFfBgo5DKeyXZV8l0TQYEmPZKDnCkvMw56couEeC
	C2bK52FBK/EUrezaZuTIzQ2wgDTRbkHGYVX7SMzuQ8wMYk5PSy+wr3wU1TbNpPTP
	Wh0d0IkBtsJZIvzeWVGp2s5K6LPXOttTR2NIpFjkNVlnutSLCyxnQYEl7cFTnahh
	0lt+rg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe03vhdac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 08:40:15 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84859a64079so9363151b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 01:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784104815; x=1784709615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jErdnoopuqAihKNJLLXSkeEYwCLjyO9zQsDrw9PVcis=;
        b=kJeeHdpm0gn6Dis4MDCX9cgVFsLzlJuMsYQdsz6ISFEmNiCDW6SIEn/QMxLEC3Ffp/
         zemP/sPSZeSOkgMenV1NwJ5O8qEg9Tx1cgdMe8O+8Vr7+gvdUBSYwgJE26lKH5IcDJza
         ZkWJYSfTnKnbD9QOuKzW3NNuK2VmhECOgpPzpTf0DmDw+UiSYRQSVjAgkH/mhY9msrMR
         6CRkT762XGQDFHfYSRJJytH50ukygL1n5ex7b1tsMAw8HFuvTebs7nkuAK0kUGQG9u3/
         XMvvq7Q0gSPdfTGh61fqQnAAnSb6BFctig6EzDoszVz/HZccGSa22r+B4VK60OrfkbkT
         Watw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784104815; x=1784709615;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jErdnoopuqAihKNJLLXSkeEYwCLjyO9zQsDrw9PVcis=;
        b=gElfGZOa2zc0j7tGvddWw5MmmM2msyByMTEwItwvceo27FB459PjZ0ssNM7YPSSF5O
         mhjgFYe7D3sNCfLSmwCiVns1ce40t7QiEwz57v4f3Vh1EfndxzD1A8N9UuEcKbcq2I70
         LpdT3b6OTAcI7ALVPsxbNY/2jXuAVsAf1Hu+/ZIuqr+FCqy+dFYlqh21xj4/72bwv84I
         FMH+cONgerrRZRjR8sLLwfWiyWiGv8Q2w5u6tWK74mMOFe+hDRdPXooCuCaGfK8u/xtE
         n8+RsTmRdwV72kN3xJMhxSY770yt3R3oSaAdBeuSGMySW2+cU/nPNWEgbYu5MTak1Ear
         tmUg==
X-Gm-Message-State: AOJu0YwUyMURWICnVkqhMwJ55URiJ8L34qISAwY4aMGkSml7+0MVkvSL
	+w4nesMUsf7whm0x0Pu/6uDlheDlf6ERKdCkdVDvLSNCYkE90H+CaPTUGsXeTkWxJeDML8CptbP
	20Yw+sKUjKgFfcM919AygCI+CbPpRrDUfc+lkqkH6XjSfJ4BAjNcmPTeHlYmd/CnM8eW6ROCfgl
	nIyMU=
X-Gm-Gg: AfdE7cmXFYH3JTOzTqvSD7TncfEMQpCZhagxrJEnDArkIxd//Jh5EHl2TSrpFe/eR5I
	2J/ET5McTZgNE3Kzzc8eexNrmr1aCQt+zhh4p6G6zieus6kVQcVjzsnM85dkswzzuNRIMb8gsld
	ai23gDBhlWiKHPUY7D5fMVe+eqOcj5Fo4NTF6Fb4ZylI7KHMBcqcNJRsKWpGSCZdfx/SqSiy5LH
	COMkVC6YMrAiUk8OHLJuY8FVwRrZP+6j59k20+c/BkFasoSCfkTeHBYHcEvqPO1Ky7pFB00L3dF
	XtHs6xv5oExcPj1Fg9LX1GRYWAHwUYGQpqUSnLrPVeEwK3iw3bPY91q4mHqTx0EgMemHZ7vPTBR
	YFEAuMXQUUK9KA7v5HJpO9cpbL8mozwubESbpuBb1
X-Received: by 2002:a05:6a21:3a45:b0:3b4:b216:2b26 with SMTP id adf61e73a8af0-3c35731432bmr6381667637.5.1784104814383;
        Wed, 15 Jul 2026 01:40:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a45:b0:3b4:b216:2b26 with SMTP id adf61e73a8af0-3c35731432bmr6381647637.5.1784104813722;
        Wed, 15 Jul 2026 01:40:13 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm163872322c88.14.2026.07.15.01.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:40:13 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v6 2/3] doc/bluetoothctl-cs: Add :Uses: fields and document arguments
Date: Wed, 15 Jul 2026 14:09:57 +0530
Message-Id: <20260715083958.2723407-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715083958.2723407-1-naga.akella@oss.qualcomm.com>
References: <20260715083958.2723407-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ife3n2qa c=1 sm=1 tr=0 ts=6a574770 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=wa7QpaTpAAAA:8 a=VwQbUJbxAAAA:8 a=qJO27Cf_UnHSzW8ZJLUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-ORIG-GUID: AlPM5J0df67BjZyPzRr2hYPdCwkfTv1W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA4MyBTYWx0ZWRfX58iI8tSjBsuB
 Wno/3oVRV+ZOQ9BAgW2L3dUOsFeRuiN+J+Tz4BSfUm6kvON52CA53eSn6Jm0wyL6FnzP9by2P9b
 XwhNcF2jFFdwBgDdobjqOa71tvnOwUTBBlczVXBZoysZUJSrUBiImrLu3aia9wYy8xYakXJXEnQ
 ieuOx09PAFjq8J2pR1yhn14NVhxX36QmboCMwB4bgOXSd+wkp90SHnJGLj48FcCn/VgoqiXGC14
 cxZBG8BWaflcz69+Zf3E2RN1nuthii4wNW9CO//ZmcQUHVnyLkMJ+pcZ0QDCgCiulU5vx5O/owT
 drSh3KsSGXvgo2AnD9M/SVeTkjQrqfGKT8j5/EnagveonvI5MOpl6T8Eq3ID+XeckPSjRucSGJW
 vuFrnjyfxsr1jDTNLs1mXnxkWqbez+KQJksPyuQ5YoodlCrJ++b37FYS4fWTP89dKIFdy4OpNus
 tQ4BmLjf7Isqpu1imJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA4MyBTYWx0ZWRfX86X+ieDRX1Fk
 hThBpCVs6AjDqzin6yyQf4lbTHr6NXPMIyKWix6YRWmVN6QsdTG1dYXzPB11fgDgDVfGm48C62Q
 sKk+OBJ8VOhz+3rPnANwhuO3JrmK69c=
X-Proofpoint-GUID: AlPM5J0df67BjZyPzRr2hYPdCwkfTv1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150083

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples
---
 Makefile.tools          |   5 +-
 doc/bluetoothctl-cs.rst | 546 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 549 insertions(+), 2 deletions(-)
 create mode 100644 doc/bluetoothctl-cs.rst

diff --git a/Makefile.tools b/Makefile.tools
index 6188449f1..0646d52e1 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -359,7 +359,7 @@ man_MANS += doc/rctest.1 doc/l2ping.1 doc/btattach.1 doc/isotest.1 \
 		doc/bluetoothctl-gatt.1 doc/bluetoothctl-player.1 \
 		doc/bluetoothctl-scan.1 doc/bluetoothctl-transport.1 \
 		doc/bluetoothctl-assistant.1 doc/bluetoothctl-hci.1 \
-		doc/bluetoothctl-telephony.1
+		doc/bluetoothctl-telephony.1 doc/bluetoothctl-cs.1
 
 endif
 
@@ -465,7 +465,8 @@ manual_pages += doc/hciattach.1 doc/hciconfig.1 doc/hcitool.1 \
 			doc/bluetoothctl-transport.1 \
 			doc/bluetoothctl-assistant.1 \
 			doc/bluetoothctl-hci.1 \
-			doc/bluetoothctl-telephony.1
+			doc/bluetoothctl-telephony.1 \
+			doc/bluetoothctl-cs.1
 
 if HID2HCI
 udevdir = $(UDEV_DIR)
diff --git a/doc/bluetoothctl-cs.rst b/doc/bluetoothctl-cs.rst
new file mode 100644
index 000000000..bbc1d8565
--- /dev/null
+++ b/doc/bluetoothctl-cs.rst
@@ -0,0 +1,546 @@
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
+Each CS parameter has its own **cs.<param>** set command (see the
+**CS Parameter Commands** section below). Overrides are applied to
+the local parameter state immediately, so **show** reflects them
+right away; **start** always uses whatever values are currently set.
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
+call still succeeds. When the remote side starts or stops a procedure,
+the console prints ``Measurement started``/``Measurement stopped`` for
+that device — use **show** or watch the ``Active`` property to see
+the same transition. In this role the only parameters that are
+required or have any effect are ``role``, ``sync_ant_sel`` and
+``max_tx_power``; every other **cs.<param>** command below is
+accepted but unused.
+
+Positional arguments are optional:
+
+- ``dev_addr`` — Bluetooth address of the target device; uses the only
+  available CS-capable device when omitted.
+- ``duration_secs`` — auto-stop timeout in seconds; ``0`` (default) means
+  no timeout.
+
+:Usage: **> start [dev_addr] [duration_secs]**
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
+CS Parameter Commands
+======================
+
+Each CS parameter is set with its own command, of the form
+``cs.<param> <value>``. Entering a param command with no value shows
+its current setting. Overrides apply to the local parameter state
+immediately, so **show** reflects them right away; **start** always
+uses whatever values are currently set. Array-valued parameters
+(``channel_map``, ``min_sub_event_len``, ``max_sub_event_len``) take
+colon-separated hex bytes with no ``0x`` prefix.
+
+:Usage: **> <param> [value]**
+
+role
+----
+
+Get/set the CS role.
+
+:Usage: **> role [0x01|0x02|0x03]**
+:[0x01|0x02|0x03]: ``0x01`` Initiator, ``0x02`` Reflector, ``0x03`` Both
+                   (optional, shows current if omitted; default ``0x03``)
+:Example Show current role:
+	| **> role**
+:Example Set role to Initiator only:
+	| **> role 0x01**
+:Example Set role to Reflector only (does not measure):
+	| **> role 0x02**
+:Example Set role to both Initiator and Reflector:
+	| **> role 0x03**
+
+sync_ant_sel
+------------
+
+Get/set the CS sync antenna selection.
+
+:Usage: **> sync_ant_sel [value]**
+:[value]: CS sync antenna selection; ``0xFE``/``0xFF`` reserved
+          (optional, shows current if omitted; default ``0xFF``)
+:Example Show current antenna selection:
+	| **> sync_ant_sel**
+:Example Select antenna 1:
+	| **> sync_ant_sel 0x01**
+
+max_tx_power
+------------
+
+Get/set the maximum TX power.
+
+:Usage: **> max_tx_power [dBm]**
+:[dBm]: Max TX power in dBm, signed (optional, shows current if
+        omitted; range −127 to +20; default ``20``)
+:Example Show current max TX power:
+	| **> max_tx_power**
+:Example Reduce max TX power to 10 dBm:
+	| **> max_tx_power 10**
+
+config_id
+---------
+
+Get/set the CS configuration identifier.
+
+:Usage: **> config_id [value]**
+:[value]: CS configuration identifier (optional, shows current if
+          omitted; default ``0``)
+:Example Show current config id:
+	| **> config_id**
+:Example Set config id to 1:
+	| **> config_id 1**
+
+main_mode_type
+--------------
+
+Get/set the CS main mode type.
+
+:Usage: **> main_mode_type [1|2|3]**
+:[1|2|3]: ``1`` Mode 1 (RTT), ``2`` Mode 2 (PBR), ``3`` Both (optional,
+          shows current if omitted; default ``1``)
+:Example Show current main mode type:
+	| **> main_mode_type**
+:Example Set main mode to Mode 2 (PBR):
+	| **> main_mode_type 2**
+:Example Set main mode to both RTT and PBR:
+	| **> main_mode_type 3**
+
+sub_mode_type
+-------------
+
+Get/set the CS sub-mode type within the main mode.
+
+:Usage: **> sub_mode_type [value]**
+:[value]: Sub-mode within main mode; ``0xFF`` = unused (optional,
+          shows current if omitted; default ``0xFF``)
+:Example Show current sub-mode type:
+	| **> sub_mode_type**
+:Example Set sub-mode type to 0x01:
+	| **> sub_mode_type 0x01**
+
+main_mode_min_steps
+--------------------
+
+Get/set the minimum CS main mode steps per subevent.
+
+:Usage: **> main_mode_min_steps [value]**
+:[value]: Min CS main mode steps per subevent (optional, shows
+          current if omitted; default ``2``)
+:Example Show current value:
+	| **> main_mode_min_steps**
+:Example Set minimum steps to 4:
+	| **> main_mode_min_steps 4**
+
+main_mode_max_steps
+--------------------
+
+Get/set the maximum CS main mode steps per subevent.
+
+:Usage: **> main_mode_max_steps [value]**
+:[value]: Max CS main mode steps per subevent (optional, shows
+          current if omitted; default ``3``)
+:Example Show current value:
+	| **> main_mode_max_steps**
+:Example Set maximum steps to 8:
+	| **> main_mode_max_steps 8**
+
+main_mode_repetition
+---------------------
+
+Get/set how many times main mode steps are repeated in a subevent.
+
+:Usage: **> main_mode_repetition [value]**
+:[value]: Repetition count (optional, shows current if omitted;
+          default ``1``)
+:Example Show current value:
+	| **> main_mode_repetition**
+:Example Repeat main mode steps twice:
+	| **> main_mode_repetition 2**
+
+mode0_steps
+-----------
+
+Get/set the number of CS Mode 0 steps at the beginning of each
+subevent.
+
+:Usage: **> mode0_steps [value]**
+:[value]: CS Mode 0 step count (optional, shows current if omitted;
+          default ``2``)
+:Example Show current value:
+	| **> mode0_steps**
+:Example Set Mode 0 steps to 3:
+	| **> mode0_steps 3**
+
+rtt_types
+---------
+
+Get/set the RTT measurement types bitmask.
+
+:Usage: **> rtt_types [value]**
+:[value]: RTT measurement types bitmask (optional, shows current if
+          omitted; default ``0``)
+:Example Show current value:
+	| **> rtt_types**
+:Example Set RTT types bitmask:
+	| **> rtt_types 0x01**
+
+sync_phy
+--------
+
+Get/set the PHY used for CS sync.
+
+:Usage: **> sync_phy [0x01|0x02]**
+:[0x01|0x02]: ``0x01`` LE 1M, ``0x02`` LE 2M (optional, shows current
+              if omitted; default ``0x01``)
+:Example Show current sync PHY:
+	| **> sync_phy**
+:Example Set CS sync PHY to LE 2M:
+	| **> sync_phy 0x02**
+
+channel_map
+-----------
+
+Get/set the 10-byte CS channel map bitmap.
+
+:Usage: **> channel_map [b0:b1:...:b9]**
+:[b0:b1:...:b9]: 10 colon-separated hex bytes (optional, shows current
+                 if omitted; default ``FC:FF:7F:FC:FF:FF:FF:FF:FF:1F``)
+:Example Show current channel map:
+	| **> channel_map**
+:Example Set a custom channel map (all enabled):
+	| **> channel_map FF:FF:FF:FF:FF:FF:FF:FF:FF:FF**
+
+channel_map_repetition
+-----------------------
+
+Get/set the number of consecutive repetitions of the channel map.
+
+:Usage: **> channel_map_repetition [value]**
+:[value]: Repetition count (optional, shows current if omitted;
+          default ``1``)
+:Example Show current value:
+	| **> channel_map_repetition**
+:Example Repeat the channel map 3 times:
+	| **> channel_map_repetition 3**
+
+channel_selection_type
+-----------------------
+
+Get/set the CS channel selection algorithm.
+
+:Usage: **> channel_selection_type [value]**
+:[value]: Channel selection algorithm (optional, shows current if
+          omitted; default ``0``)
+:Example Show current value:
+	| **> channel_selection_type**
+:Example Select algorithm 1:
+	| **> channel_selection_type 1**
+
+channel_shape
+-------------
+
+Get/set the shape used in the channel selection algorithm.
+
+:Usage: **> channel_shape [value]**
+:[value]: Channel shape (optional, shows current if omitted; default
+          ``0``)
+:Example Show current value:
+	| **> channel_shape**
+:Example Set channel shape to 1:
+	| **> channel_shape 1**
+
+channel_jump
+------------
+
+Get/set the channel jump size.
+
+:Usage: **> channel_jump [value]**
+:[value]: Channel jump size (optional, shows current if omitted;
+          default ``2``)
+:Example Show current value:
+	| **> channel_jump**
+:Example Set channel jump to 4:
+	| **> channel_jump 4**
+
+companion_signal_enable
+------------------------
+
+Get/set whether the companion signal is transmitted.
+
+:Usage: **> companion_signal_enable [0|1]**
+:[0|1]: ``1`` to transmit companion signal, ``0`` to disable (optional,
+        shows current if omitted; default ``0``)
+:Example Show current value:
+	| **> companion_signal_enable**
+:Example Enable the companion signal:
+	| **> companion_signal_enable 1**
+
+max_procedure_duration
+-----------------------
+
+Get/set the maximum duration of one CS measurement procedure.
+
+:Usage: **> max_procedure_duration [value]**
+:[value]: Maximum procedure duration (optional, shows current if
+          omitted; default ``1600``)
+:Example Show current value:
+	| **> max_procedure_duration**
+:Example Set max procedure duration to 800:
+	| **> max_procedure_duration 800**
+
+min_period_between_procedures
+-------------------------------
+
+Get/set the minimum time between consecutive procedures.
+
+:Usage: **> min_period_between_procedures [value]**
+:[value]: Minimum period (optional, shows current if omitted; default
+          ``30``)
+:Example Show current value:
+	| **> min_period_between_procedures**
+:Example Set minimum period to 50:
+	| **> min_period_between_procedures 50**
+
+max_period_between_procedures
+-------------------------------
+
+Get/set the maximum time between consecutive procedures.
+
+:Usage: **> max_period_between_procedures [value]**
+:[value]: Maximum period (optional, shows current if omitted; default
+          ``150``)
+:Example Show current value:
+	| **> max_period_between_procedures**
+:Example Set maximum period to 200:
+	| **> max_period_between_procedures 200**
+
+max_procedure_count
+--------------------
+
+Get/set the maximum number of procedures.
+
+:Usage: **> max_procedure_count [value]**
+:[value]: Max procedure count; ``0`` = no limit (optional, shows
+          current if omitted; default ``0``)
+:Example Show current value:
+	| **> max_procedure_count**
+:Example Limit the procedure count to 100:
+	| **> max_procedure_count 100**
+
+min_sub_event_len
+------------------
+
+Get/set the minimum CS subevent length.
+
+:Usage: **> min_sub_event_len [b0:b1:b2]**
+:[b0:b1:b2]: 3-byte LE value, colon-separated hex (optional, shows
+             current if omitted; default ``00:20:00``)
+:Example Show current value:
+	| **> min_sub_event_len**
+:Example Set minimum subevent length:
+	| **> min_sub_event_len 00:10:00**
+
+max_sub_event_len
+------------------
+
+Get/set the maximum CS subevent length.
+
+:Usage: **> max_sub_event_len [b0:b1:b2]**
+:[b0:b1:b2]: 3-byte LE value, colon-separated hex (optional, shows
+             current if omitted; default ``03:20:00``)
+:Example Show current value:
+	| **> max_sub_event_len**
+:Example Set maximum subevent length:
+	| **> max_sub_event_len 04:20:00**
+
+tone_antenna_config_selection
+-------------------------------
+
+Get/set the antenna configuration for CS tone exchanges.
+
+:Usage: **> tone_antenna_config_selection [value]**
+:[value]: Antenna config selection (optional, shows current if
+          omitted; default ``0x07``)
+:Example Show current value:
+	| **> tone_antenna_config_selection**
+:Example Set antenna config to 0x01:
+	| **> tone_antenna_config_selection 0x01**
+
+phy
+---
+
+Get/set the PHY used for CS procedures.
+
+:Usage: **> phy [0x01|0x02]**
+:[0x01|0x02]: ``0x01`` LE 1M, ``0x02`` LE 2M (optional, shows current
+              if omitted; default ``0x01``)
+:Example Show current procedure PHY:
+	| **> phy**
+:Example Set CS procedure PHY to LE 2M:
+	| **> phy 0x02**
+
+tx_power_delta
+--------------
+
+Get/set the remote vs local TX power delta.
+
+:Usage: **> tx_power_delta [value]**
+:[value]: TX power delta; ``0x80`` = not applicable (optional, shows
+          current if omitted; default ``0x80``)
+:Example Show current value:
+	| **> tx_power_delta**
+:Example Set TX power delta to 0x05:
+	| **> tx_power_delta 0x05**
+
+preferred_peer_antenna
+-----------------------
+
+Get/set the preferred antenna for the peer device.
+
+:Usage: **> preferred_peer_antenna [value]**
+:[value]: Preferred peer antenna (optional, shows current if omitted;
+          default ``0x03``)
+:Example Show current value:
+	| **> preferred_peer_antenna**
+:Example Prefer antenna 1 on the peer:
+	| **> preferred_peer_antenna 0x01**
+
+snr_control_initiator
+----------------------
+
+Get/set the SNR control for the initiator.
+
+:Usage: **> snr_control_initiator [value]**
+:[value]: SNR control; ``0xFF`` = no preference (optional, shows
+          current if omitted; default ``0xFF``)
+:Example Show current value:
+	| **> snr_control_initiator**
+:Example Prefer high SNR on the initiator:
+	| **> snr_control_initiator 0x01**
+
+snr_control_reflector
+----------------------
+
+Get/set the SNR control for the reflector.
+
+:Usage: **> snr_control_reflector [value]**
+:[value]: SNR control; ``0xFF`` = no preference (optional, shows
+          current if omitted; default ``0xFF``)
+:Example Show current value:
+	| **> snr_control_reflector**
+:Example Prefer high SNR on the reflector:
+	| **> snr_control_reflector 0x01**
+:Example Prefer high SNR on both roles:
+	| **> snr_control_initiator 0x01**
+	| **> snr_control_reflector 0x01**
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

