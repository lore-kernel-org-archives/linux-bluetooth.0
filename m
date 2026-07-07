Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F8F3822B4
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409684; cv=none; b=H1qtxUjdywgsYQXXNeFNdRmiDY7xb/hUOrJF6SrkIWFmhcknyb1zUAqVyQnmxwXAWjS65o+SRVnkWmsnu1pV3MqL+nG+2Np0w6mMZK36A59XJGHKAHK3S9phgYzK7ODcwOlTfBvy8unIIyqZst9akupccoXAYLgqbvPe4R+ma+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409684; c=relaxed/simple;
	bh=+ZtbcIQjdW8gKaAHJwe+xP9bkDT/L68949LSfGRh8Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QG8spO/BOjoJEEp8kyqm4270eBsQ8PEHdm3uxjrK3FTBcebWqdHB+8qKUOP6jLxM7k3YxNKEHiSnBF6E3wN2Fg4vug+EWew2TYdZBdmAXLmX9Z/sZi29sk5u1xvtshQeLg0+WJaYW4b37kFk8ehgHm9uBhmperC8B81d7U8NrbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n4/dDDZf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NZFtONCo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n4/dDDZf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NZFtONCo"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6676fESR2998152
	for <linux-bluetooth@vger.kernel.org>; Tue, 7 Jul 2026 07:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hLm15j8Pi4k3klHQEj2p1C25Mp6fE8XPc/ZfMIioFEk=; b=n4/dDDZfHmcTAb0H
	gUmyp8vnMpNQCC7agenBy4hFBi3uvZ4ljzVKe17eXAQ7Uf6J/m+ntMV6V8He6qKf
	pfc6M9P86Eyp6NWu4tfLbFLRRoKqrwkHuyuDL1ybpXwAjIpbeY3BJukJVfh+Gx35
	eKkZE6CeMQvC1MJHZO6Dg1aFMaWBjypHoiSA1qRMrkulQ4mSQCxti0KUh9zm+wSQ
	JP9lJaFv+3Cra364WidKXa7mB07gCKc4JNvdeGkBm8/8nWdlowezxOJbFBZlh2US
	dQlPY5y5YxLpNyxeRPfaQE9tnVYo3a+FPE/XZB3FY+X8FmNgsOD8QV6P4DXm/3ou
	JTTnbw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vdj86hq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 07:34:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8482df30da4so814686b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 00:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783409680; x=1784014480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLm15j8Pi4k3klHQEj2p1C25Mp6fE8XPc/ZfMIioFEk=;
        b=NZFtONCoQqWarUGWT4U0oHrObs/rRYApq21aBF9rg/LxiAwlqdCNA4ZTeaD9rfnGRB
         N6PtCAOKvMlt4N7H10cBHoqGY9b5QUiHE+fhOActmZFSAfcWsHi9f21VL918IAWqnPbM
         OWw9GBiovBlPsqksjpzrUcG7Ch5WUBHSjRPRHrmtXz6orkI1zPUpcKRqHlgbiEicAFn9
         1PYLL5dc7qWd6Dd9mRzJNw42DExfHbn/UaQoUlayvCiTLyYm/glL/ZSBsELzrMqbinIu
         PrUhyYdkMnWjRGO+BQHMHOv6++WrmVVi0pLi59gdCSOP/XxiQRQE8uTwaFuGmOKfUU+L
         mLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783409680; x=1784014480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLm15j8Pi4k3klHQEj2p1C25Mp6fE8XPc/ZfMIioFEk=;
        b=FKPtYaOi6s4sQEaBejqMaxb2Wx3NgEO4X0CGw9MjXVpOt1yU4nRSpnToPsn0JVMxUh
         qpbm6n/L4E1EsvqVjy+LOsqU1l4NCps/Q0SU9TIcMGi9M0aBnLkBQ858esgM5m0hYWZ/
         8LeeYxECYly97Rpp4jMjg4Xv4CQP2ADVYBJB4Xgkx5Xxq82mwtvaZfu5Q18ubu9PSf6+
         yiYltIMzzJTnYMJPWzTCDl7wDQ4L1dM9m9PQt18qXQEjxVoUGnFnqXqpQ3QBXbdRx7uN
         ikYivhCgf4PmeQ1PqUgrpMIaWVh7lyQ0//9vk8tMMU4z0s5BGc1xeuk/gyJiDMwPiHKt
         1aIQ==
X-Gm-Message-State: AOJu0Yw881sGWrtQtiAWphaSj41QdDGMb+Yq8MtXdwc0ZIoXzSjypO2P
	DiC9+jUylPsuESoNxYCiy9WDAF4sDsWpxZxdhKCbmkGbIQgGsO+sGUQdqTeRVsMIt1l9zuLOj1U
	ubhXXt0WTrVblCdjjW3AFF0ofobvMqvN9zf9HqpduPUdWRAFSz/YxcHoz3C0MA4zyOGPywAU=
X-Gm-Gg: AfdE7cmD60zthMD2UQS74ZGbTGFC3Kf2GXhESfo8inKeRK+O8A5EhEwTvq2eu/vBnlo
	b8hOU6KVL3a95kh5Jg7u/JO0AyTTYYFCBCSdn+equjKEbKBTtjf/cLs8DMVpjWRu7Am/czr+yf5
	zWTLa0dszW08xoXfXlcrn2M++9fhkp6PPgPtXQU4RhNy9gC1MkJMWm/1l1y6m4zzk2fuLBbexg8
	XZS4/8+wSqJtSVhoiLl1uqt4/msXmWavYwTmxdwvPxwF510yMgnCMd3ur6ISDnfUXWOJhcGfDJ4
	9UaeoR/AwViS4/q0KYAdX3aqd3ySTs6G7xw2bdBeK4mhNHEHaNqKuFaLm9kQyse5/UbQAkye2/w
	myP0ibqUBfGh4SLG8dOW7rfd/iw==
X-Received: by 2002:a05:6a00:c82:b0:847:8ccc:d7c6 with SMTP id d2e1a72fcca58-84826cdc092mr4072179b3a.31.1783409679627;
        Tue, 07 Jul 2026 00:34:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:c82:b0:847:8ccc:d7c6 with SMTP id d2e1a72fcca58-84826cdc092mr4072137b3a.31.1783409678918;
        Tue, 07 Jul 2026 00:34:38 -0700 (PDT)
Received: from [10.216.14.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3b25204sm533405a12.28.2026.07.07.00.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 00:34:38 -0700 (PDT)
Message-ID: <4de0246d-f773-42d4-988b-40281d15cb84@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 13:04:34 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v1 3/5] doc/org.bluez.ChannelSounding1: Add Used by
 reference and Examples
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260706161603.2744459-1-naga.akella@oss.qualcomm.com>
 <20260706161603.2744459-4-naga.akella@oss.qualcomm.com>
 <CABBYNZJvWyfDSk9vAUpuwSU0fQ6V7pi799__izO3b+CB84EZfg@mail.gmail.com>
Content-Language: en-US
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
In-Reply-To: <CABBYNZJvWyfDSk9vAUpuwSU0fQ6V7pi799__izO3b+CB84EZfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7cz39RX c=1 sm=1 tr=0 ts=6a4cac10 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=wa7QpaTpAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Xtm77HQdrskZhmOmVQsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-GUID: EuSlRLM99yEnxdgfw0UKF4CGlEQt6Pbu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA3MCBTYWx0ZWRfX1fhI+Uel+b6u
 Z3fkAxVxDDB4vsUatMAZ0vB+2wL/nLyCXBcKiOmeGvLLa+kj1GQLQSMS5hwPlICIrpeBBda0V2R
 +N/ewJDMkTI7xGytUayKIXyJQe9FFpUQprzgo/FR1eeZv26pz6uvDwolff54JgvqQYdglvxUBAa
 u8dZHaGzMAH0Mu/Cww67UzXAKjeX0L4+A+WeICj2Du4db0GuhEraWJCPid/nZavoW1tkW3on1zm
 ne73uOorWcouLEMU46cdJk3ekc0mUrDGzlm/agm4zqKMdXGNBYx/IpbYoey9G/dZjYD6H27D3tq
 MaqZABPDdYLgdPzgIMTPfcizKk/gz/kZ699QEm8PHiWY2gdMqWtDujPo/V+6lB8T2/eGogTMgIy
 8bAlh5AtbdrhFCpZqhq8xtGrXG7A8nx5M8YQ1Ypsz3TasC1l0Ohx75dv2d9zaqiwQqKoLTCkQx+
 AplxvANqicKSa4WgJEQ==
X-Proofpoint-ORIG-GUID: EuSlRLM99yEnxdgfw0UKF4CGlEQt6Pbu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA3MCBTYWx0ZWRfX3/Wo/z7JanLU
 R8Re4R7dMO/zCi4ZBr9VFw63T/AmdC7ewFi2yPkqC8NLkn02OT19cnGKsjjyvEhiaQpeUl1HS1i
 vD3jecjGeR3d17LjWjT/Q3NQi44piOw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070070

Hi Luiz,

Please find the comments inline

On 7/7/2026 2:06 AM, Luiz Augusto von Dentz wrote:
> Hi Naga,
> 
> On Mon, Jul 6, 2026 at 12:16 PM Naga Bhavani Akella
> <naga.akella@oss.qualcomm.com> wrote:
>>
>> Add :Used by: field linking to bluetoothctl cs submenu and
>> Examples section showing corresponding bluetoothctl cs commands
>> for D-Bus methods
>> ---
>>  doc/bluetoothctl-cs.rst            | 278 ++++++++++++++++++++++++++
>>  doc/org.bluez.ChannelSounding1.rst | 302 +++++++++++++++++++++++++++++
> 
> These 2 needs to be splitted, each file on its own commit.
sure, will do that> 
>>  2 files changed, 580 insertions(+)
>>  create mode 100644 doc/bluetoothctl-cs.rst
>>  create mode 100644 doc/org.bluez.ChannelSounding1.rst
>>
>> diff --git a/doc/bluetoothctl-cs.rst b/doc/bluetoothctl-cs.rst
>> new file mode 100644
>> index 000000000..c16c89298
>> --- /dev/null
>> +++ b/doc/bluetoothctl-cs.rst
>> @@ -0,0 +1,278 @@
>> +================
>> +bluetoothctl-cs
>> +================
>> +
>> +--------------------------
>> +Channel Sounding Submenu
>> +--------------------------
>> +
>> +:Version: BlueZ
>> +:Copyright: Free use of this software is granted under the terms of the GNU
>> +            Lesser General Public Licenses (LGPL).
>> +:Date: June 2026
>> +:Manual section: 1
>> +:Manual group: Linux System Administration
>> +
>> +SYNOPSIS
>> +========
>> +
>> +**bluetoothctl** [--options] [cs.commands]
>> +
>> +This submenu controls Bluetooth Channel Sounding (CS) distance measurement
>> +using the **org.bluez.ChannelSounding1(5)** D-Bus interface. It allows
>> +starting and stopping measurements and inspecting the current parameter
>> +state and active session identifier.
>> +
>> +CS parameters can be overridden on any **start** call using inline
>> +``param=value`` arguments. Overrides are applied to the local parameter
>> +state before the measurement is started, so **show** reflects them
>> +immediately after.
>> +
>> +
>> +Channel Sounding Commands
>> +=========================
>> +
>> +start
>> +-----
>> +
>> +Sets one or more CS parameters and starts a distance measurement on the
>> +connected device. All configuration is sent to the daemon in a single
>> +**StartMeasurement** call. On success the device path is printed to
>> +the console. Multiple simultaneous sessions across different devices are
>> +supported; each is tracked independently.
>> +
>> +Calling **start** on a device that already has an active measurement
>> +returns an error without starting a second session on the same device.
>> +
>> +Positional arguments are optional and must appear before any
>> +``param=value`` pairs:
>> +
>> +- ``duration_secs`` — auto-stop timeout in seconds; ``0`` (default) means
>> +  no timeout.
>> +
>> +Any additional argument of the form ``param=value`` overrides the named
>> +parameter for this call and for all subsequent calls. Array-valued
>> +parameters (``channel_map``, ``min_sub_event_len``, ``max_sub_event_len``)
>> +use colon-separated hex bytes with no ``0x`` prefix.
>> +
>> +:Usage: **> start [dev_addr [duration_secs]] [param=value ...]**
>> +:Uses: **org.bluez.ChannelSounding1(5)** method **StartMeasurement**
>> +:[dev_addr]: Bluetooth address of the target device (optional; uses the
>> +             only available CS-capable device when omitted)
>> +:[duration_secs]: Seconds before auto-stop (optional, default 0 = no timeout)
>> +:[param=value]: One or more ``param=value`` overrides (optional)
>> +
>> +**Settable parameters:**
>> +
>> +.. list-table::
>> +   :header-rows: 1
>> +   :widths: 35 15 50
>> +
>> +   * - Parameter
>> +     - Default
>> +     - Description
>> +   * - ``role``
>> +     - ``0x03``
>> +     - ``0x01`` Initiator, ``0x02`` Reflector, ``0x03`` Both
>> +   * - ``cs_sync_ant_sel``
>> +     - ``0xFF``
>> +     - CS sync antenna selection (0xFE/0xFF reserved)
>> +   * - ``max_tx_power``
>> +     - ``20``
>> +     - Max TX power in dBm (signed, range −127 to +20)
>> +   * - ``config_id``
>> +     - ``0``
>> +     - CS configuration identifier
>> +   * - ``main_mode_type``
>> +     - ``1``
>> +     - ``1`` Mode 1 (RTT), ``2`` Mode 2 (PBR), ``3`` Both
>> +   * - ``sub_mode_type``
>> +     - ``0xFF``
>> +     - Sub-mode within main mode; ``0xFF`` = unused
>> +   * - ``main_mode_min_steps``
>> +     - ``2``
>> +     - Min CS main mode steps per subevent
>> +   * - ``main_mode_max_steps``
>> +     - ``3``
>> +     - Max CS main mode steps per subevent
>> +   * - ``main_mode_repetition``
>> +     - ``1``
>> +     - Times main mode steps are repeated in a subevent
>> +   * - ``mode0_steps``
>> +     - ``2``
>> +     - CS Mode 0 steps at the beginning of each subevent
>> +   * - ``rtt_types``
>> +     - ``0``
>> +     - RTT measurement types bitmask
>> +   * - ``cs_sync_phy``
>> +     - ``0x01``
>> +     - PHY for CS sync: ``0x01`` LE 1M, ``0x02`` LE 2M
>> +   * - ``channel_map``
>> +     - ``FC:FF:7F:FC:FF:FF:FF:FF:FF:1F``
>> +     - 10-byte channel map bitmap (colon-separated hex)
>> +   * - ``channel_map_repetition``
>> +     - ``1``
>> +     - Consecutive repetitions of the channel map
>> +   * - ``channel_selection_type``
>> +     - ``0``
>> +     - CS channel selection algorithm
>> +   * - ``channel_shape``
>> +     - ``0``
>> +     - Shape used in channel selection algorithm
>> +   * - ``channel_jump``
>> +     - ``2``
>> +     - Channel jump size
>> +   * - ``companion_signal_enable``
>> +     - ``0``
>> +     - ``1`` to transmit companion signal, ``0`` to disable
>> +   * - ``max_procedure_duration``
>> +     - ``1600``
>> +     - Maximum duration of one CS measurement procedure
>> +   * - ``min_period_between_procedures``
>> +     - ``30``
>> +     - Minimum time between consecutive procedures
>> +   * - ``max_period_between_procedures``
>> +     - ``150``
>> +     - Maximum time between consecutive procedures
>> +   * - ``max_procedure_count``
>> +     - ``0``
>> +     - Max number of procedures; ``0`` = no limit
>> +   * - ``min_sub_event_len``
>> +     - ``00:20:00``
>> +     - Min CS subevent length, 3-byte LE (colon-separated hex)
>> +   * - ``max_sub_event_len``
>> +     - ``03:20:00``
>> +     - Max CS subevent length, 3-byte LE (colon-separated hex)
>> +   * - ``tone_antenna_config_selection``
>> +     - ``0x07``
>> +     - Antenna config for CS tone exchanges
>> +   * - ``phy``
>> +     - ``0x01``
>> +     - PHY for CS procedures: ``0x01`` LE 1M, ``0x02`` LE 2M
>> +   * - ``tx_power_delta``
>> +     - ``0x80``
>> +     - Remote vs local TX power delta; ``0x80`` = not applicable
>> +   * - ``preferred_peer_antenna``
>> +     - ``0x03``
>> +     - Preferred antenna for the peer device
>> +   * - ``snr_control_initiator``
>> +     - ``0xFF``
>> +     - SNR control for initiator; ``0xFF`` = no preference
>> +   * - ``snr_control_reflector``
>> +     - ``0xFF``
>> +     - SNR control for reflector; ``0xFF`` = no preference
>> +
>> +:Example Start with all defaults, no timeout:
>> +       | **> start**
>> +:Example Start on a specific device:
>> +       | **> start AA:BB:CC:DD:EE:FF**
>> +:Example Start on a specific device with 10-second auto-stop:
>> +       | **> start AA:BB:CC:DD:EE:FF 10**
>> +:Example Start with 10-second auto-stop (single device, address omitted):
>> +       | **> start 0 10**
>> +:Example Start with no timeout, explicit:
>> +       | **> start**
>> +:Example Start with 5-minute auto-stop:
>> +       | **> start AA:BB:CC:DD:EE:FF 300**
>> +:Example Start as Initiator only:
>> +       | **> start role=0x01**
>> +:Example Start as Reflector only:
>> +       | **> start role=0x02**
>> +:Example Start as both Initiator and Reflector:
>> +       | **> start role=0x03**
>> +:Example Start with Mode 2 (PBR) main mode:
>> +       | **> start main_mode_type=2**
>> +:Example Start with both RTT and PBR modes:
>> +       | **> start main_mode_type=3**
>> +:Example Start with LE 2M PHY for CS procedures:
>> +       | **> start phy=0x02**
>> +:Example Start with LE 2M PHY for both CS sync and procedures:
>> +       | **> start cs_sync_phy=0x02 phy=0x02**
>> +:Example Start with reduced TX power (10 dBm):
>> +       | **> start max_tx_power=10**
>> +:Example Start with companion signal enabled:
>> +       | **> start companion_signal_enable=1**
>> +:Example Start with a procedure limit of 100:
>> +       | **> start max_procedure_count=100**
>> +:Example Start with high SNR preference on both roles:
>> +       | **> start snr_control_initiator=0x01 snr_control_reflector=0x01**
>> +:Example Start with custom channel map (all enabled):
>> +       | **> start channel_map=FF:FF:FF:FF:FF:FF:FF:FF:FF:FF**
>> +:Example Start Initiator, Mode 2, LE 2M, 30-second timeout:
>> +       | **> start AA:BB:CC:DD:EE:FF 30 role=0x01 main_mode_type=2 phy=0x02 cs_sync_phy=0x02**
>> +:Example Start both roles, Mode 1, no limit, custom step counts:
>> +       | **> start role=0x03 main_mode_type=1 main_mode_min_steps=4 main_mode_max_steps=8**
>> +:Example Start on a device, Reflector, 60-second timeout:
>> +       | **> start AA:BB:CC:DD:EE:FF 60 role=0x02**
> 
> This approach is too complicated, and users will struggle to discover
> available commands without consulting the documentation. Although it
> offers flexibility to specify only necessary parameters for a session,
> this quickly becomes an individual setting abstraction similar to
> `defset`.
We already provide default values for all parameters and expose them
through the 'show' CS menu option, so users can easily see the
currently configured settings without referring to external documentation.
If a user wants to modify any parameter, they can do so through
the startmeasurement option. Additionally, only the
remote device address and timeout parameters are mandatory.
All other parameters are optional and will use their default values
if not explicitly specified.
This keeps the command usage simple while still providing the flexibility
to override only the settings that are relevant for a particular session.
> 
>> +defset
>> +------
>> +
>> +Sets the CS default settings (``role``, ``cs_sync_ant_sel``,
>> +``max_tx_power``) on the connected device without starting a
>> +measurement. This is required for the Reflector role: a Reflector
>> +never calls **start** because it waits passively for the remote
>> +Initiator, so **defset** is the only way to push these settings to
>> +the daemon before the remote side initiates the procedure.
>> +
>> +Any ``param=value`` arguments update the local parameter state and
>> +are immediately sent to the daemon via **SetDefaultSettings**.
> 
> I don't think this is going to work. `SetDefaultSettings` would need
> to remember what each client has set in case there are multiple
> clients, otherwise they would overwrite one another. Instead, this
> should be stored locally and then set as properties to
> StartMeasurement.
We have introduced the Defset option specifically for the Reflector role
because Start Measurement is not applicable in this role.
If users want to configure default settings while operating
in the Reflector role, they should have the option to do so
through the Defset option. Defset command also accepts the device path
as an input parameter, which allows it to distinguish between multiple clients. > 
>> +Omitting all arguments sends the current local values unchanged.
>> +
>> +:Usage: **> defset [param=value ...]**
>> +:Uses: **org.bluez.ChannelSounding1(5)** method **SetDefaultSettings**
>> +:[param=value]: One or more of ``role``, ``cs_sync_ant_sel``,
>> +               ``max_tx_power`` (optional)
>> +:Example Configure as Reflector:
>> +       | **> defset role=0x02**
>> +:Example Configure as Both with reduced TX power:
>> +       | **> defset role=0x03 max_tx_power=10**
>> +:Example Apply current local values without changing them:
>> +       | **> defset**
> 
> Like I said above, this will make it hard for users to discover what
> to enter without consulting the documentation. Instead, each file
> should probably have a dedicated command, eg `cs.role
> <initiator/reflector,both>`, etc for all the settings necessary for
> cs.start to work.
> 
>> +stop
>> +----
>> +
>> +Stops an active CS distance measurement. When only one measurement is
>> +running the device address may be omitted. When multiple measurements
>> +are active the address is required to identify which one to stop.
>> +
>> +:Usage: **> stop [dev_addr]**
>> +:Uses: **org.bluez.ChannelSounding1(5)** method **StopMeasurement**
>> +:[dev_addr]: Bluetooth address of the device to stop (optional when
>> +             only one session is active; required otherwise)
>> +:Example Stop the only active measurement:
>> +       | **> stop**
>> +:Example Stop a specific device when multiple are active:
>> +       | **> stop AA:BB:CC:DD:EE:FF**
>> +:Example Stop a second device:
>> +       | **> stop 11:22:33:44:55:66**
>> +
>> +show
>> +----
>> +
>> +Displays all active measurements (device path for each) and the full
>> +set of CS parameter values that will be used on the next **start** call.
>> +When no measurements are active, ``none`` is shown.
>> +
>> +The parameter output is divided into three sections:
>> +
>> +- **Default Settings** — role, CS sync antenna selection, max TX power.
>> +- **CS Config Params** — per-procedure configuration fields including
>> +  mode type, step counts, PHY, and channel map.
>> +- **CS Frequency Params** — procedure scheduling fields including
>> +  duration, period, subevent lengths, and SNR control.
>> +
>> +:Usage: **> show**
>> +:Example Show active session and all CS parameters:
>> +       | **> show**
>> +
>> +RESOURCES
>> +=========
>> +
>> +http://www.bluez.org
>> +
>> +REPORTING BUGS
>> +==============
>> +
>> +linux-bluetooth@vger.kernel.org
>> diff --git a/doc/org.bluez.ChannelSounding1.rst b/doc/org.bluez.ChannelSounding1.rst
>> new file mode 100644
>> index 000000000..73f484507
>> --- /dev/null
>> +++ b/doc/org.bluez.ChannelSounding1.rst
>> @@ -0,0 +1,302 @@
>> +==========================
>> +org.bluez.ChannelSounding1
>> +==========================
>> +
>> +----------------------------------------------
>> +BlueZ D-Bus Channel Sounding API documentation
>> +----------------------------------------------
>> +
>> +:Version: BlueZ
>> +:Date: June 2026
>> +:Manual section: 5
>> +:Manual group: Linux System Administration
>> +
>> +Interface
>> +=========
>> +
>> +:Service:      org.bluez
>> +:Interface:    org.bluez.ChannelSounding1
>> +:Object path:  [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>> +:Used by:      **bluetoothctl(1)**, **bluetoothctl-cs(1)**
>> +
>> +Methods
>> +-------
>> +
>> +void StartMeasurement(dict params)
>> +``````````````````````````````````
>> +
>> +Starts a Channel Sounding distance measurement procedure on the connected
>> +device. All configuration is supplied in a single ``a{sv}`` dictionary.
>> +Any key that is omitted retains its current value in the daemon.
>> +
>> +The device to measure is identified by the D-Bus object path on which
>> +this method is called
>> +(``[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX``).
>> +Only one measurement per device object may be active at a time. Calling
>> +**StartMeasurement** while a session is already active returns
>> +``org.bluez.Error.InProgress``.
>> +
>> +Supported dictionary keys:
>> +
>> +:uint32 duration_secs (Default: 0):
>> +
>> +       Duration in seconds before the measurement is stopped
>> +       automatically. A value of 0 disables the automatic timeout.
>> +
>> +:byte role (Default: 0x03):
>> +
>> +       CS role to use for the measurement.
>> +
>> +       Possible values:
>> +
>> +       :0x01: Initiator
>> +       :0x02: Reflector
>> +       :0x03: Both (Initiator and Reflector)
>> +
>> +:byte cs_sync_ant_sel (Default: 0xFF):
>> +
>> +       CS sync antenna selection. Values 0xFE and 0xFF are reserved
>> +       by the Bluetooth specification.
>> +
>> +:byte max_tx_power (Default: 0x14):
>> +
>> +       Maximum TX power in dBm, treated as a signed value. Valid
>> +       range is -127 to +20 dBm.
>> +
>> +:byte config_id:
>> +
>> +       CS configuration identifier.
>> +
>> +:byte main_mode_type:
>> +
>> +       Main CS mode used in the procedure.
>> +
>> +:byte sub_mode_type:
>> +
>> +       Sub-mode within the main mode. Set to 0xFF when unused.
>> +
>> +:byte main_mode_min_steps:
>> +
>> +       Minimum number of CS main mode steps per CS subevent.
>> +
>> +:byte main_mode_max_steps:
>> +
>> +       Maximum number of CS main mode steps per CS subevent.
>> +
>> +:byte main_mode_repetition:
>> +
>> +       Number of times the main mode steps are repeated in a
>> +       subevent.
>> +
>> +:byte mode0_steps:
>> +
>> +       Number of CS Mode 0 steps at the beginning of each subevent.
>> +
>> +:byte rtt_types:
>> +
>> +       Round Trip Time measurement types for the configuration.
>> +
>> +:byte cs_sync_phy:
>> +
>> +       PHY used for CS sync packets.
>> +
>> +       Possible values:
>> +
>> +       :0x01: LE 1M PHY
>> +       :0x02: LE 2M PHY
>> +
>> +:array{byte} channel_map:
>> +
>> +       10-byte channel map bitmap. Must be exactly 10 bytes.
>> +
>> +:byte channel_map_repetition:
>> +
>> +       Number of consecutive repetitions of the channel map.
>> +
>> +:byte channel_selection_type:
>> +
>> +       Algorithm used for CS channel selection.
>> +
>> +:byte channel_shape:
>> +
>> +       Shape used in the channel selection algorithm.
>> +
>> +:byte channel_jump:
>> +
>> +       Channel jump size used in the channel selection algorithm.
>> +
>> +:byte companion_signal_enable:
>> +
>> +       Set to 1 to transmit a companion signal alongside the CS
>> +       tone, 0 to disable.
>> +
>> +:uint16 max_procedure_duration:
>> +
>> +       Maximum duration of a single CS measurement procedure.
>> +
>> +:uint16 min_period_between_procedures:
>> +
>> +       Minimum time between consecutive CS measurement procedures.
>> +
>> +:uint16 max_period_between_procedures:
>> +
>> +       Maximum time between consecutive CS measurement procedures.
>> +
>> +:uint16 max_procedure_count:
>> +
>> +       Maximum number of CS measurement procedures to run.
>> +       A value of 0 means no limit.
>> +
>> +:array{byte} min_sub_event_len:
>> +
>> +       Minimum CS subevent length as a 3-byte little-endian value.
>> +       Must be exactly 3 bytes.
>> +
>> +:array{byte} max_sub_event_len:
>> +
>> +       Maximum CS subevent length as a 3-byte little-endian value.
>> +       Must be exactly 3 bytes.
>> +
>> +:byte tone_antenna_config_selection:
>> +
>> +       Antenna configuration used for CS tone exchanges.
>> +
>> +:byte phy:
>> +
>> +       PHY used during CS procedures.
>> +
>> +       Possible values:
>> +
>> +       :0x01: LE 1M PHY
>> +       :0x02: LE 2M PHY
>> +
>> +:byte tx_power_delta:
>> +
>> +       Difference between remote and local TX power during CS
>> +       procedures. 0x80 indicates not applicable.
>> +
>> +:byte preferred_peer_antenna:
>> +
>> +       Preferred antenna to be used by the peer device.
>> +
>> +:byte snr_control_initiator:
>> +
>> +       SNR control setting for the initiator role.
>> +       0xFF indicates no preference.
>> +
>> +:byte snr_control_reflector:
>> +
>> +       SNR control setting for the reflector role.
>> +       0xFF indicates no preference.
>> +
>> +Possible errors:
>> +
>> +:org.bluez.Error.InProgress:
>> +:org.bluez.Error.InvalidArgs:
>> +:org.freedesktop.DBus.Error.Failed:
>> +
>> +Examples:
>> +
>> +:bluetoothctl set role then start:
>> +       | [cs] > start AA:BB:CC:DD:EE:FF role=0x01 main_mode_type=2
>> +:bluetoothctl start with defaults:
>> +       | [cs] > start [dev_addr [duration_secs]]
>> +
>> +void SetDefaultSettings(dict params)
>> +`````````````````````````````````````
>> +
>> +Sets the CS default settings for this device without starting a
>> +measurement. This method is intended for the Reflector role, where
>> +the device waits passively for the remote Initiator to begin the
>> +procedure and therefore never calls **StartMeasurement**. It allows
>> +the application to configure ``role``, ``cs_sync_ant_sel``, and
>> +``max_tx_power`` ahead of time so they are in effect when the
>> +controller processes the remote CS configuration.
>> +Need this to set default settings in Reflector role.
> 
> There's no need for this if StartMeasurement already accepts the same
> parameters. Each client should be capable of remembering the
> parameters it used, so we don't bloat the daemon with them.
> 
We have introduced the Defset option specifically for the Reflector role
because Start Measurement is not applicable in this role.
If users want to configure default settings while operating
in the Reflector role, they should have the option to do so
through the Defset option.
>> +Supported dictionary keys:
>> +
>> +:byte role (Default: 0x03):
>> +
>> +       CS role to use for the measurement.
>> +
>> +       Possible values:
>> +
>> +       :0x01: Initiator
>> +       :0x02: Reflector
>> +       :0x03: Both (Initiator and Reflector)
>> +
>> +:byte cs_sync_ant_sel (Default: 0xFF):
>> +
>> +       CS sync antenna selection. Values 0xFE and 0xFF are reserved
>> +       by the Bluetooth specification.
>> +
>> +:byte max_tx_power (Default: 0x14):
>> +
>> +       Maximum TX power in dBm, treated as a signed value. Valid
>> +       range is -127 to +20 dBm.
>> +
>> +Possible errors:
>> +
>> +:org.bluez.Error.InvalidArgs:
>> +:org.freedesktop.DBus.Error.Failed:
>> +
>> +Examples:
>> +
>> +:bluetoothctl configure as Reflector:
>> +       | [cs] > defset role=0x02
>> +
>> +void StopMeasurement(void)
>> +``````````````````````````
>> +
>> +Stops the active Channel Sounding distance measurement on this device.
>> +The device is identified by the D-Bus object path on which this method
>> +is called — no session identifier is required.
>> +
>> +Raises ``org.bluez.Error.NotConnected`` if no measurement is active.
>> +
>> +Possible errors:
>> +
>> +:org.bluez.Error.NotConnected:
>> +:org.freedesktop.DBus.Error.Failed:
>> +
>> +In **bluetoothctl(1)**, the device address argument may be omitted only
>> +when a single measurement is active; it is required when multiple
>> +measurements are active.
>> +
>> +Examples:
>> +
>> +:bluetoothctl stop the only active measurement:
>> +       | [cs] > stop
>> +:bluetoothctl stop a specific device when multiple are active:
>> +       | [cs] > stop AA:BB:CC:DD:EE:FF
>> +
>> +Properties
>> +----------
>> +
>> +boolean Active [readonly]
>> +`````````````````````````
>> +
>> +Indicates whether a CS distance measurement procedure is currently
>> +active on this device.
>> +
>> +Set to ``true`` when a procedure starts — either because the local
>> +Initiator called **StartMeasurement** successfully, or because the
>> +remote Initiator enabled a CS procedure on the local Reflector.
>> +
>> +Set to ``false`` when the procedure stops for any reason: the local
>> +application called **StopMeasurement**, the measurement duration timer
>> +expired, or the ACL connection was dropped.
>> +
>> +This property emits ``PropertiesChanged`` on every transition so that
>> +clients can track measurement state without polling.
> 
> What about the results? Shouldn't results be announced when the
> procedure starts?
This is still under discussion,
as the measurement calculations are handled by a separate daemon.> 
>> +RESOURCES
>> +=========
>> +
>> +http://www.bluez.org
>> +
>> +REPORTING BUGS
>> +==============
>> +
>> +linux-bluetooth@vger.kernel.org
>> --
>>
> 
> 

