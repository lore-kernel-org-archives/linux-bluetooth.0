Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0F91DB13A
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520323; cv=none; b=b0B8kqd4i/By0wqTGsoWMgg6laj1cfn8c7sj5H7AI+YpAngQ1288pb3s28KvSWN2qSrpTI8CA3kk8he+AxrUuEUA5Cy+/AGjNepqj4BQq/q2/wpDrC7W6ATzrlzAJEkeNvay/rLpJDkm/CvtGfj54I0L9DYqQf75qOfEQGqgeA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520323; c=relaxed/simple;
	bh=/ualJ36g/GRML1wPkjZ/IQV1HNUK73VIhXEHUi6Wfuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOHaWs2EXuUBSp556Cg1M1uGuE38zCBhbf7VLM+PlPvpKaFLhpfnTf5FyuVfrNHJ7xJlLTg51GRNfcLjkIUGEBD+VUaelfbyMdc+E0CclG830x970/jdqVWG3Pg1AdB3pkhtIRuYeZRAuuTRUiDjnKl/vg/5JeuHHMmErfs44/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cG+PuOq/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Id+HF/Ip; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cG+PuOq/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Id+HF/Ip"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3Dqn2751270
	for <linux-bluetooth@vger.kernel.org>; Wed, 8 Jul 2026 14:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F1+KBLeV1nrecELa8XnyGYk5AwjbMdX59zmckIXJMPA=; b=cG+PuOq/yxLfUPQ6
	5Bqa2eB5zSwCrZqHeyBgiKuQdZFlEKH1K8TUbhJ+U0gi3iflss0GHrnAC8+1wM0/
	qIIRK1EoPwL7pYkx5iMAp4QIsH6XX5iHCcX7wgQ2+UXOPg/vaLhvOZyQzQrPqClS
	MbhvqNBdrIh3Lwp5niFGhMZv1qyLDeVzxDrq5DsTDU0uBebW1wM7Z6AX4j5nJUJp
	o4JTuKYIad8LK52l3C4uX//M+HHYbYG0Ox2zPAXREzmQ64xzD3mSOWPQVouYJ9x1
	+DCrWAJf2gScRNyHp4lmWAn4EmH01FSOtkmOp8HFRseM/TIGpTCd1gcM6klpYGls
	gTjpbA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9g7hj29r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 14:18:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-381e93bfcacso1707087a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 07:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783520321; x=1784125121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F1+KBLeV1nrecELa8XnyGYk5AwjbMdX59zmckIXJMPA=;
        b=Id+HF/IpTG2q4Sgf5cAMB1cR5OBzbBPt3gJZuL7B+h1lLEKiWlGAuXYj38JdvHLLjs
         m6FMIALxXY68/RkBwh1NyBCgws4Gq/4Fiw41t87lAJqDTkKHWyUqWWRTjIKAlZGvLL9Q
         aGAAeUTqV2+93V6kGjR5ruaWUWLWULqIgY0NiUqqRcTIWQE7mR5pWCrcdSooVNBFEKQi
         WtD2nfabZvQCRoaYJM7tzB7sHX5/iIqZTfJaxKq6PL5e8bZd4ehevPh4JzRo570vBtVr
         xF+F4isKdlglRRBohW75QBrrdGaSoRhdxracRfnK7lbbbgZ/sBcamMeWa6wuDmGFOfvK
         taZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783520321; x=1784125121;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F1+KBLeV1nrecELa8XnyGYk5AwjbMdX59zmckIXJMPA=;
        b=oYY16FSKe6WnPn/chxWD2mi4phoIc767M6mvsJds+ixgp3ArBJMcjKqoByIU5bwcwO
         IySHYfWh0EtXGn9kWNYDOSHfao6UojXEwCGZnFiKqGZJ0vVDzFmUZLXG3oM+YkuaTbMz
         NXKWabkuaBzRCGXyN1Gk7Y1xznb2Zd/VMsNSXRz6V2fSsSZLUMu6vRmaQ8AiGhTkLtac
         j4YHF9O29oHyPT0U11fOjMv4BZ/i9CIO4n6ehHQCQHCfGyv/e+JIuz30eNrrc4oLrj33
         VUW6YQ5cxuVbQQqRhI8jX48qx98uQ+au3+VAw8VR06DoaJ4lJ47/uSGTDMOHSEx2DdjO
         Dg6A==
X-Gm-Message-State: AOJu0Yw6MIMRUBjP66TWBMjsXdQLTGkBvIfTla0WbXrfE+Kxb+sSZCvj
	lbEsv2wyN4/cjd/T4dUDVFrvHdOZ/qo91KpTk/e6/kT0hWBfhXUr552RJoj+HZzJP6YFJYNqgZA
	qEmKBu9IhDI6fru0u2FzYdDE1FrPqQgQC7Se1NSrPFIM76ddsPWvBj2TbIk18jBWiBwn3/v26qM
	Uu5xU=
X-Gm-Gg: AfdE7cmCAkEIe/tXbaeCNZwHV2x8Eb4rWhdJlUt5p6wmTmuimzNYtm/oPXiAH8OUyxq
	F95cjE2mHRzuGYUkKRNGIAsHxEld+6G5pdN/qKCYE1eC0ll79ZbAG217PdcF/WimKCFRG7N4LSM
	e8KXRL540GcSfbCE5JrdaKCWmBJq6i/BfHibCLksrua68Zhawyeds+bVunENMTKuh8Wp8SenCtp
	MMd3G7m6p0n40TzgBt4ibBGFptHvGA2crkhVOg0fMDVUiM8WAki9/827BSrTXrbeqHXtZmW78tf
	sof1OlffwE4ivm8Z+bGRzlXLrJhwiVjLdKHKZwdukQrE6QO1U6eDzEZyUkxo1d6xGWYH7uoFZdi
	/aQHvr5q0YxHabr8dj2G/q/Oh93DTp1jxEGlHzowp
X-Received: by 2002:a17:90b:510b:b0:381:bc4c:da74 with SMTP id 98e67ed59e1d1-3894239bef3mr3259921a91.32.1783520320533;
        Wed, 08 Jul 2026 07:18:40 -0700 (PDT)
X-Received: by 2002:a17:90b:510b:b0:381:bc4c:da74 with SMTP id 98e67ed59e1d1-3894239bef3mr3259861a91.32.1783520319997;
        Wed, 08 Jul 2026 07:18:39 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5982sm22665427eec.5.2026.07.08.07.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:18:39 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 3/3] doc/bluetoothctl-cs: Add :Uses: fields and document arguments
Date: Wed,  8 Jul 2026 19:48:19 +0530
Message-Id: <20260708141819.1284821-4-naga.akella@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX1c93romX2Dwi
 tRw1e7N9UJWH4y0mC1vnXRmeqpPWxwy4dy6cK7y5kSgMkssodGwuNY7kV4LX2GcOzM5f7PIUMKs
 4q2545DaeazQAKyDCH+UZa3JutStkK74E4gt9+KQBEzZXZepu2fmpQzcijVQapBuWtrp7PCGWeq
 aMCMliLxTklYcq3GNycaU8RFADX0YfGGofCm2kBs2Xo+511kml7KA8FBC3dAs5gItxXPaxLSTUa
 CqhV/C89rCqz5aAJo+j9aL/iFMLNLHgPovlL0nqdOw51UGMvdnlYiQcrDYHHjWvmHHkAs37fWpp
 m47itxwhR4IGdMUG1ydZ1FZMbOKVrtQVbQ3AghaCbIAXcCksMecJBKvNN261/eNwI3T27UBGsxP
 BGhbyTVmnA3miMlE65/VpJD3FAP0tG3Oz9RuxXdUmwHqq+V/OPzhCFFcfFMkFfV4UYK+f8HNYJT
 9FTVQx6wAN4oJmnLttw==
X-Proofpoint-GUID: PlSwnuv_w87aPdR0g3IO1ZZR7KO8nz0Y
X-Authority-Analysis: v=2.4 cv=TMp1jVla c=1 sm=1 tr=0 ts=6a4e5c41 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=wa7QpaTpAAAA:8 a=VwQbUJbxAAAA:8 a=H4Wi6FJYl_R2Nt5VnFUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX+qqwqkm1J1Qe
 J+ejTH5jWgALUwxdHp1IYGPVnr1kTyMpruiQ9/v61bTkUBciJrfZbKC2Oi1TzNnsa39fN0pyL7u
 gW7LVPKmkuDEbQoaM8RIroQ3mWfI2M8=
X-Proofpoint-ORIG-GUID: PlSwnuv_w87aPdR0g3IO1ZZR7KO8nz0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080140

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.
---
 doc/bluetoothctl-cs.rst | 277 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 277 insertions(+)
 create mode 100644 doc/bluetoothctl-cs.rst

diff --git a/doc/bluetoothctl-cs.rst b/doc/bluetoothctl-cs.rst
new file mode 100644
index 000000000..0a6ce395e
--- /dev/null
+++ b/doc/bluetoothctl-cs.rst
@@ -0,0 +1,277 @@
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
+Parameter names for **start** support Tab completion: pressing Tab on
+a partially-typed word completes it to ``param=`` for any recognized
+parameter (see the table below). Completion does not apply once ``=``
+has been typed, nor to ``dev_addr``/``duration_secs``. Completion is
+role-aware: while ``role`` is set to Reflector (``0x02``), only
+``role=``, ``cs_sync_ant_sel=`` and ``max_tx_power=`` are offered,
+since no other parameter has any effect in that role; for Initiator
+or Both, all parameters in the table are offered.
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
+For Initiator role (or Both), the mandatory parameters are the
+positional ``dev_addr`` and ``duration_secs`` — everything else in
+the table below is optional configuration with a usable default.
+
+If ``role`` is set to Reflector (``0x02``), **start** does not begin
+measuring distance: a Reflector never initiates a CS procedure. It
+only pushes the current parameters to the daemon and arms the device
+to respond once the remote Initiator starts one; the call still
+succeeds. Use **show** or watch the ``Active`` property to see when a
+procedure is actually running. In this role the only parameters that
+are required or have any effect are ``role``, ``cs_sync_ant_sel`` and
+``max_tx_power``; every other CS config/frequency parameter in the
+table below is accepted but unused.
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
+:[param=value]: One or more ``param=value`` overrides (optional); parameter
+                names Tab-complete to ``param=``
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
+:Example Start as Reflector only (applies settings, does not measure):
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

