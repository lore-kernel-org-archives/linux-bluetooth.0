Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205913A3809
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663177; cv=none; b=uaD+CJizmrk0KAXj1CqEVnadVqUzcVMp/9MTAzbcPmwaPUfBO8SeldhePz59sLGQ8yIWFj8PqmziEvxAJarLp5mj3aX3oVutrRdMx3dsgwRzlC3QuraYK6sbQNEiQtwdxf72qCdXmFY8J/XVlsYcHr2L1kb1mNzPfzynreS7KZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663177; c=relaxed/simple;
	bh=UyTH3ViTIcvUXxJSSRux9Z4RXDLJ+TtgFMrIB3d5F78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtqNSR7kud7B/u/jjKSgwaE/wBM+BVG2VSF6ul43P7dWFC+Lt4HjzyxbmcBYLh45cYbfMCENN9yBmAumxXby9uf2iHnOrxUXy0dMkuOqoDSbZDduslgGtoWkcN59RvwtA9YeHiNEAAed3uyAmhlJ4ataa1hwRzl9XDWTFK+zom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tlg3vUVW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DN+ttH1X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tlg3vUVW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DN+ttH1X"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3n1QA3661661
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OJ8nvXnXGfSGdne0DEOeVYduXNyfT1Qwx3TMRKJWasg=; b=Tlg3vUVWgWlmYXJy
	oGUk1CIK2cn/ugllD/DTfbfd0mvtft9/A+YwqXGfdKVRrAWYcCidmq6bVLKdMFIh
	LmPI51/HADcSMsKSo/OiB91HwNera4Y0C4e6N9LtS1uCJ1/Lu6HPQpCoyozCzRj5
	WZmert/TD/tLGJYWdl6kbD25uXHcf+sYEyLeO7kzb39RbW6U/oNuWgN2xbT6NpqW
	W53UWp0efFI2V6kuZCwQZCaRfRIjsnBzsDQQQE2P4fHjYe5lXBBfCJHRoFCv7erw
	tMzPF09Wew6GoFWKaCJWOYME1MqkYw/12mHjSoe2BoVBDkTQWt982ygkUayeSOZF
	4eH8rg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24ttby-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 05:59:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c890bac374eso1014299a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 22:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783663171; x=1784267971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OJ8nvXnXGfSGdne0DEOeVYduXNyfT1Qwx3TMRKJWasg=;
        b=DN+ttH1X/MbK67me6ENXdYbusYx5vnh3dQtpgFTZ/jMD7vt7J38VZHRIpJizxO0ZmO
         OTErOodzfMQNbSLm51d1CnBtB/K4QOSOgdtm8RUaCks2dH/rWzJtQhzzfNmc4vw2FwcW
         WCb+HUgtoGZl5gW6xfvABJkhdgl0KbmAgXXZYBKMeg+BuKT3DgpDxVb6yTVT29+drvi2
         knAK017QRaw3jmmDxFKOzJxv+JPFSq7K901jHsxudh+BBz2gwZgLJq7ICpJagGfrJbfV
         q/+TIt7e14UOGokxjowgwuUYB1XfGkVbwIe4Nosz0nk/N72HSCeqqVSIO2WZBjJpNqMt
         IYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783663171; x=1784267971;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OJ8nvXnXGfSGdne0DEOeVYduXNyfT1Qwx3TMRKJWasg=;
        b=MQ4CZ2gOb05mxnqhfQlNRp6n9dIm3Y5VKM0tNnZ17DVFnuxzhzBmP5ndmAWYXfj1sB
         AwrObEUJq6XzYqe17SZdgJ/Hbx+ONl+MAE+//L4+/lLxg+NrPoVVcGKz+veSvCaPr1Wi
         7h6bIKxP6fYObuzafj82aSm20s8Xd+yX3zmsxtcZt7z1op6TatZoXOO+0cNFCgyKLhar
         Sfw81JycoejBDy+n/qhc2vJfpkQljlkws3qwfO+CeutFZXswczPrbV5c34X1gRyB6Zlo
         AW4fwfMBWJR6JX5a/pl6SeFutsx2/pAs24EWks6NDKRNbtjzgtoj6RmJ25+tcY0JT9VN
         e8hg==
X-Gm-Message-State: AOJu0YyGYBs4LphLQT5pkmsxS+X+pkbqWuNt84B0PR9Nfhc8qiOadYHU
	L2vzI5rzYMNmkv8qorxkseBvyp1scl1Y502KqTajncMN/plaTPFVMcaHWE/5gJYgmQxVLvAa3DC
	O1m8QzAEUj14eKk2ignWB52ASdAWYwwESQS6bzJvexQR08sHu87D8wPGFYzcVIsAS4XN8i3YahA
	V8uMM=
X-Gm-Gg: AfdE7ckCIPM+7ZDhohAInqDVRQ9aFVASB7WDj5Zz0Uev3uxVduFw71h8pRQCaW432/Q
	PSRpl9j9EIMEJY372TnnxId/Hp7uDl57Ml8yMrkqd+J9xmczTm65B3zjUP201RPUwxy3JQ1J+fk
	2MkyuUjFQrqDPN3VbfX44KC81bLu0PO3/eCARIavtvpDnh/JU/cIzJhXokrMNYqZZ9AJESe2amx
	N7jAl+QsTpWWcrvtgWRXEyPMkBxQCJx6r3HK9m4MaaICqNmmlVuzsXmrHjCiNFEPDJYYXS1oiLy
	gr5g6BiPsz4BNnLj61IchrUdENL9tGnlPKFzi6AbfQbsWvBoVtogiqZKKMFGf0Uu9EDVca9cpfd
	wTotbwpVj75NAEYuoZ6mVfManqRBIPPiWJ1tR3qt8
X-Received: by 2002:a05:6a21:d84:b0:3bf:a624:deb5 with SMTP id adf61e73a8af0-3c0bc9018f9mr12335030637.6.1783663171195;
        Thu, 09 Jul 2026 22:59:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:d84:b0:3bf:a624:deb5 with SMTP id adf61e73a8af0-3c0bc9018f9mr12334985637.6.1783663170558;
        Thu, 09 Jul 2026 22:59:30 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm39678529c88.12.2026.07.09.22.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 22:59:30 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 3/3] doc/bluetoothctl-cs: Add :Uses: fields and document arguments
Date: Fri, 10 Jul 2026 11:29:10 +0530
Message-Id: <20260710055910.3691701-4-naga.akella@oss.qualcomm.com>
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
X-Proofpoint-GUID: Ji2_XVosnRAvm5GnLmD4K270Rd0P3VhU
X-Proofpoint-ORIG-GUID: Ji2_XVosnRAvm5GnLmD4K270Rd0P3VhU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1NCBTYWx0ZWRfX+K6eIQmp0Q6K
 TZyzCmol89cKzJle3oQY8wgQU0mBI2kiO2BqRWyFEF7X9TKt97x/tK1DawBEN8A9s9D2Ko9H5YE
 xCKkV/2vOzK02PBsUqhNJxLYgrx4+xE=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a508a44 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=wa7QpaTpAAAA:8 a=VwQbUJbxAAAA:8 a=P8ZN0akgs87_WGVAVtYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1NCBTYWx0ZWRfX9R4rJo2uTmVb
 dAoXKA0Wv2i8TQ5SCCVHLfFQoEpVbrZ+2DzCoGN+sCsNcYIckfDRleywJPgZkGBbs3+Ez8IFNjk
 RiX21f6FMKhNpTRVGn3ubvJK9JgLvLLdXgT2yQgZi2220/vxGbkb4iCdAN2ogfk9cFiFe1InqbV
 wkrCiuzPA+dN4aDpL4q6/FzrX2Le2j33mNtRkC/oYZaxa/YNs0vtGsFYio+b/SpGtOHeWacDcF5
 Bg3Sd8GDYDig/CErDdoQlV7DSyANh/COPIyABae4d7Rn5+fZp+5rO5c2zZY4mq9SxVvJiQxIzwR
 ha2s0klWoFMIRL4aCpaT0+SFd//mXiJrf7o143Ve1j6XbhrbiprY8uDkA6liwSfQ7AX/QAEHh+W
 gnzknRB/MO5Ye8VMqawVf+t/z8jqQX3cK+FeNPyv/MV479ax7kbvNi+pxE3GEl04dwVydZ/t1Sb
 5uf25uCdkd677pHhLJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100054

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.
---
 Makefile.tools          |   5 +-
 doc/bluetoothctl-cs.rst | 283 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 286 insertions(+), 2 deletions(-)
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
index 000000000..84b604877
--- /dev/null
+++ b/doc/bluetoothctl-cs.rst
@@ -0,0 +1,283 @@
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
+   * - ``sync_ant_sel``
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
+   * - ``sync_phy``
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
+	| **> sync_phy 0x02**
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
+	| **> sync_phy 0x02**
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

