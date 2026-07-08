Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A62405840
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500786; cv=none; b=DIY+oxwTVR03xSb/2PzqqnQmOPe92dj8KWuW+W4+G+7l00+GiNo+iVbznwXVlSRwiFdtfzoUP7DKf848bPeYmlSDMYBRKAJXwwJTdOSvzT/2GDZMcxCRcSBtDfvdQDAEQVQ1S0PCYvrwDF8QakyYX+pq2VPdd21oSYi2mNP6mws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500786; c=relaxed/simple;
	bh=a07XarbIpPsSrEZBOM7DYgxsov9DoB92tjlpNRCjXUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRw1WJ/N0NCzYKNBZbI6OAroDj7z3evnTyOPsGimmj7UYLiWfavdVgOOdVj11R5CUaGBWCazj1hqohoF12S+wK8Yr5B5xs5KSBOeRJNIrSu1c0o4BcqHc3bOjgW/bewQxgtpRPWkbfArza3QwJIazliIqnjOzUcZXzBUXZ62+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hP9dTuvA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jYaG8Bfn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hP9dTuvA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jYaG8Bfn"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668896c62258465
	for <linux-bluetooth@vger.kernel.org>; Wed, 8 Jul 2026 08:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pPXlxBXMfAkNDpgyKsiTXLrqnI9orlUXD5jdvTJdb0Y=; b=hP9dTuvAFLBdoFMG
	Nun5JPQHGQexK1qZ2gci3BxES63o01fbDXMHUqYmzHx/ikk5aLXEawdiUcR9tfyM
	sj0I/qbpx1Ek02y9ItzoUOwvvRLq9yrLUYzUb0Db6I5KIlO9jIciIcpOhRljl3iy
	+QtY01E9NDZ+KeFXfD6ywRelIct+8iznr6O+QeSeegG1cyLEBV+8NANg7vSkVtzI
	rFWdzJy0pkajZ5VfB8qknZ7uEU0thNu9/NJEWx8AsPs2tYr4UxqMr9vmPLvaxpUe
	zfSoHFsO2fOLIa9rXCzTLVUvWeen5QibLNrfYugVFSw1xXAtEzfLoEPVrZIbp7VC
	2E7FWw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9csw9jw8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 08:53:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3810e5c5871so1031232a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 01:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783500782; x=1784105582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPXlxBXMfAkNDpgyKsiTXLrqnI9orlUXD5jdvTJdb0Y=;
        b=jYaG8BfntlnCkCVePxMygnsyWRm8xVmRim93Pi+7jzjREf/Yesi4thNxPKKjM/JBYW
         lBQCA76hu7RqOTS0Cu2l89xBokAyMU8SEo1QUt736LUcScgyUCE9kIhXE2R/v4bh9ugf
         RuWDcriSItloOacoTkgLnsMkSWNZ1VFsmpsFY/mJoyCOI2W0jypUivHgNr0zrLeQWgEr
         1ktLUgX2dk3QfbL85wxsj8OLGYulTMt5tgyeIImNdNOA6y1tv1aPlXzn8bLMCQCOcjQK
         qrH3zElVYYHkXgCYO53Y1aEYjixaQN7AdaKkvfZcY/v594iOsB7gZEja2J4GBYSHle5H
         lDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783500782; x=1784105582;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPXlxBXMfAkNDpgyKsiTXLrqnI9orlUXD5jdvTJdb0Y=;
        b=aFpQ2KYd+kdA7w5n/7x0O+rtSlbWq452fpnbHK4KhvXGEX/XFEde2kEIHPvNZcriHX
         2Sl1SN/7U7Tct54VTx3BuMMjTRlzXmCLo3J8aHH5qbydn/YO3Btlmy3Cm1zk5SCLtpKT
         Ha7fd/9JeaZ27HwL4FQVRg0BCw3brBjN41YTX9sX44tmkpDORcueBEggscMeV4ZXlKmh
         6vr7EzsnUln8KvCBhQF2AlTpPoj9PiDNkUqCrEvcPa3eeyHDpI7Fo4EotC10m33jggso
         7lg3/0ROflscj+MGJtk4vMpPFIhrmgTVUhHmPOoY1pjz7D2uCXNP2jC9/CYVlhLu/XhQ
         qdEQ==
X-Gm-Message-State: AOJu0YzZZXbpWOGve9oQV8IDXm4mLUtkgRb+hcAtsIuF+ACpxwz7s4UT
	c7CIu1LDl9ScPWcBONUobCyrxXBt/EKr4QtAg7H4gmAeCdEjhsJTiDvf8v3Z4FyF+2EMDKwkK2V
	XPAAsm2fQLb7lcz1xlor/TQ7NzBU80FPFOr3MMLTSiSf+XazkFgYnlzlHgKfkgPhEEzwzrLqg+7
	ZyjJ0=
X-Gm-Gg: AfdE7ck6PxaAlSOHaF0aeyhyJKfQ4x+RLZh/gr47Jj9X8vYh/kuOe6fRFkTaa7JML2M
	iv7lUbjuylsGiB7n4jgpNBA/KSgADGg5pHQ+bQWs1esD5pCsDxUWJHMkYgnAsZer/aLRyPZ3LOF
	l2VuJjrH4g7UFfphn9UDZkTz8lKPXdHPtRIEmfFB7hfa72ZXO1ANIMIk9YW67Teh3ACGwN6EdyW
	tOq39Sg4cw0UHZenWSykkRmzpJ6xHDM/YEAC1zfp2K6tWxub2oB+b2Ksq/hk2Cn/imi4CRGimyX
	4CA5Q/ESskWUyA+EezzbVMdvFIa6auanHxfGrV2dQuG2BuScmKFVq0Ov42XcoxibjzllISMZvkt
	ONg9Oa2mV5dEpptDgkfnaS9PPAMIZCbt71Lp7Kw==
X-Received: by 2002:a17:90b:3b43:b0:381:3b5d:30f4 with SMTP id 98e67ed59e1d1-38941102113mr1662713a91.1.1783500781902;
        Wed, 08 Jul 2026 01:53:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3b43:b0:381:3b5d:30f4 with SMTP id 98e67ed59e1d1-38941102113mr1662680a91.1.1783500781180;
        Wed, 08 Jul 2026 01:53:01 -0700 (PDT)
Received: from [10.218.1.139] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3c99fsm24603365ad.68.2026.07.08.01.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 01:53:00 -0700 (PDT)
Message-ID: <b7fdd257-5f0d-4cf4-a8b5-8b4e57b3f19a@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 14:22:57 +0530
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
 <4de0246d-f773-42d4-988b-40281d15cb84@oss.qualcomm.com>
 <CABBYNZ+8BWpFA-A5oezZmETjLJNVdy0ujk+xxxr_Fyx9pNXnkA@mail.gmail.com>
Content-Language: en-US
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+8BWpFA-A5oezZmETjLJNVdy0ujk+xxxr_Fyx9pNXnkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RY2yc2GwCLJ8AMxauILUYb5ZVFpepKBt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA4NSBTYWx0ZWRfXx+djSFuoNK/U
 9tneHYN0xOUXjTwaEgF9EJCUX33Rc9YAAiw3IKpzbK1cjNWXZ7fNhL0xSm9AJpE612YjT2uXNcp
 qp2poSHJOxI1GSWyToori10LAHt0YBQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA4NSBTYWx0ZWRfXxLb3+b045Lh1
 1HwnPLaFlZMJXTqWI7BBN25LJ9o/8/Iq6E39VAqBo9unTaa/hsgcaw0UKJAOfkUqwsB8I5dGPiD
 bbfQuWkAtsXUPm5TxHz12ynM3kuu52PRnxwQ1txK03FZkA2u+Gx9cN1rYyyVeqnGQ/BK8j6sdk6
 7mdqeLONPemZUVrEGxVh5QSa6Tl81G158wUO5RFLm2yfPsD76Z2aKIi0QvJNRd/S5fIsqRGKYId
 2C6IYLVl7Y6515Fso1z8PvU6tDOlTVMtr80w7f/f+OZCJ95vhZfYKogZT+Sm8vbPiZaFYAuSKbS
 XxU1yrsfBC3P7huVs5XrAG7bZ7eFuOcVweCDzq4U/m6xgrIB0zbN44e4ARzIj9OU+TuA83mgwTj
 buDUTWTEQ89/orODWN5/8NGr3+s5a6FH8FApEMWW+1INQu+XdrAKj7gWrILPsLmXdQUWR6/db5w
 S5pbyze9A0Fuft6LpyQ==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4e0fee cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=wa7QpaTpAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=vYeMx5poCGb2o0Bk6cwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-GUID: RY2yc2GwCLJ8AMxauILUYb5ZVFpepKBt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080085

Hi Luiz,

On 7/7/2026 8:13 PM, Luiz Augusto von Dentz wrote:
> Hi Naga,
> 
> On Tue, Jul 7, 2026 at 3:34 AM Naga Bhavani Akella
> <naga.akella@oss.qualcomm.com> wrote:
>>
>> Hi Luiz,
>>
>> Please find the comments inline
>>
>> On 7/7/2026 2:06 AM, Luiz Augusto von Dentz wrote:
>>> Hi Naga,
>>>
>>> On Mon, Jul 6, 2026 at 12:16 PM Naga Bhavani Akella
>>> <naga.akella@oss.qualcomm.com> wrote:
>>>>
>>>> Add :Used by: field linking to bluetoothctl cs submenu and
>>>> Examples section showing corresponding bluetoothctl cs commands
>>>> for D-Bus methods
>>>> ---
>>>>  doc/bluetoothctl-cs.rst            | 278 ++++++++++++++++++++++++++
>>>>  doc/org.bluez.ChannelSounding1.rst | 302 +++++++++++++++++++++++++++++
>>>
>>> These 2 needs to be splitted, each file on its own commit.
>> sure, will do that>
>>>>  2 files changed, 580 insertions(+)
>>>>  create mode 100644 doc/bluetoothctl-cs.rst
>>>>  create mode 100644 doc/org.bluez.ChannelSounding1.rst
>>>>
>>>> diff --git a/doc/bluetoothctl-cs.rst b/doc/bluetoothctl-cs.rst
>>>> new file mode 100644
>>>> index 000000000..c16c89298
>>>> --- /dev/null
>>>> +++ b/doc/bluetoothctl-cs.rst
>>>> @@ -0,0 +1,278 @@
>>>> +================
>>>> +bluetoothctl-cs
>>>> +================
>>>> +
>>>> +--------------------------
>>>> +Channel Sounding Submenu
>>>> +--------------------------
>>>> +
>>>> +:Version: BlueZ
>>>> +:Copyright: Free use of this software is granted under the terms of the GNU
>>>> +            Lesser General Public Licenses (LGPL).
>>>> +:Date: June 2026
>>>> +:Manual section: 1
>>>> +:Manual group: Linux System Administration
>>>> +
>>>> +SYNOPSIS
>>>> +========
>>>> +
>>>> +**bluetoothctl** [--options] [cs.commands]
>>>> +
>>>> +This submenu controls Bluetooth Channel Sounding (CS) distance measurement
>>>> +using the **org.bluez.ChannelSounding1(5)** D-Bus interface. It allows
>>>> +starting and stopping measurements and inspecting the current parameter
>>>> +state and active session identifier.
>>>> +
>>>> +CS parameters can be overridden on any **start** call using inline
>>>> +``param=value`` arguments. Overrides are applied to the local parameter
>>>> +state before the measurement is started, so **show** reflects them
>>>> +immediately after.
>>>> +
>>>> +
>>>> +Channel Sounding Commands
>>>> +=========================
>>>> +
>>>> +start
>>>> +-----
>>>> +
>>>> +Sets one or more CS parameters and starts a distance measurement on the
>>>> +connected device. All configuration is sent to the daemon in a single
>>>> +**StartMeasurement** call. On success the device path is printed to
>>>> +the console. Multiple simultaneous sessions across different devices are
>>>> +supported; each is tracked independently.
>>>> +
>>>> +Calling **start** on a device that already has an active measurement
>>>> +returns an error without starting a second session on the same device.
>>>> +
>>>> +Positional arguments are optional and must appear before any
>>>> +``param=value`` pairs:
>>>> +
>>>> +- ``duration_secs`` — auto-stop timeout in seconds; ``0`` (default) means
>>>> +  no timeout.
>>>> +
>>>> +Any additional argument of the form ``param=value`` overrides the named
>>>> +parameter for this call and for all subsequent calls. Array-valued
>>>> +parameters (``channel_map``, ``min_sub_event_len``, ``max_sub_event_len``)
>>>> +use colon-separated hex bytes with no ``0x`` prefix.
>>>> +
>>>> +:Usage: **> start [dev_addr [duration_secs]] [param=value ...]**
>>>> +:Uses: **org.bluez.ChannelSounding1(5)** method **StartMeasurement**
>>>> +:[dev_addr]: Bluetooth address of the target device (optional; uses the
>>>> +             only available CS-capable device when omitted)
>>>> +:[duration_secs]: Seconds before auto-stop (optional, default 0 = no timeout)
>>>> +:[param=value]: One or more ``param=value`` overrides (optional)
>>>> +
>>>> +**Settable parameters:**
>>>> +
>>>> +.. list-table::
>>>> +   :header-rows: 1
>>>> +   :widths: 35 15 50
>>>> +
>>>> +   * - Parameter
>>>> +     - Default
>>>> +     - Description
>>>> +   * - ``role``
>>>> +     - ``0x03``
>>>> +     - ``0x01`` Initiator, ``0x02`` Reflector, ``0x03`` Both
>>>> +   * - ``cs_sync_ant_sel``
>>>> +     - ``0xFF``
>>>> +     - CS sync antenna selection (0xFE/0xFF reserved)
>>>> +   * - ``max_tx_power``
>>>> +     - ``20``
>>>> +     - Max TX power in dBm (signed, range −127 to +20)
>>>> +   * - ``config_id``
>>>> +     - ``0``
>>>> +     - CS configuration identifier
>>>> +   * - ``main_mode_type``
>>>> +     - ``1``
>>>> +     - ``1`` Mode 1 (RTT), ``2`` Mode 2 (PBR), ``3`` Both
>>>> +   * - ``sub_mode_type``
>>>> +     - ``0xFF``
>>>> +     - Sub-mode within main mode; ``0xFF`` = unused
>>>> +   * - ``main_mode_min_steps``
>>>> +     - ``2``
>>>> +     - Min CS main mode steps per subevent
>>>> +   * - ``main_mode_max_steps``
>>>> +     - ``3``
>>>> +     - Max CS main mode steps per subevent
>>>> +   * - ``main_mode_repetition``
>>>> +     - ``1``
>>>> +     - Times main mode steps are repeated in a subevent
>>>> +   * - ``mode0_steps``
>>>> +     - ``2``
>>>> +     - CS Mode 0 steps at the beginning of each subevent
>>>> +   * - ``rtt_types``
>>>> +     - ``0``
>>>> +     - RTT measurement types bitmask
>>>> +   * - ``cs_sync_phy``
>>>> +     - ``0x01``
>>>> +     - PHY for CS sync: ``0x01`` LE 1M, ``0x02`` LE 2M
>>>> +   * - ``channel_map``
>>>> +     - ``FC:FF:7F:FC:FF:FF:FF:FF:FF:1F``
>>>> +     - 10-byte channel map bitmap (colon-separated hex)
>>>> +   * - ``channel_map_repetition``
>>>> +     - ``1``
>>>> +     - Consecutive repetitions of the channel map
>>>> +   * - ``channel_selection_type``
>>>> +     - ``0``
>>>> +     - CS channel selection algorithm
>>>> +   * - ``channel_shape``
>>>> +     - ``0``
>>>> +     - Shape used in channel selection algorithm
>>>> +   * - ``channel_jump``
>>>> +     - ``2``
>>>> +     - Channel jump size
>>>> +   * - ``companion_signal_enable``
>>>> +     - ``0``
>>>> +     - ``1`` to transmit companion signal, ``0`` to disable
>>>> +   * - ``max_procedure_duration``
>>>> +     - ``1600``
>>>> +     - Maximum duration of one CS measurement procedure
>>>> +   * - ``min_period_between_procedures``
>>>> +     - ``30``
>>>> +     - Minimum time between consecutive procedures
>>>> +   * - ``max_period_between_procedures``
>>>> +     - ``150``
>>>> +     - Maximum time between consecutive procedures
>>>> +   * - ``max_procedure_count``
>>>> +     - ``0``
>>>> +     - Max number of procedures; ``0`` = no limit
>>>> +   * - ``min_sub_event_len``
>>>> +     - ``00:20:00``
>>>> +     - Min CS subevent length, 3-byte LE (colon-separated hex)
>>>> +   * - ``max_sub_event_len``
>>>> +     - ``03:20:00``
>>>> +     - Max CS subevent length, 3-byte LE (colon-separated hex)
>>>> +   * - ``tone_antenna_config_selection``
>>>> +     - ``0x07``
>>>> +     - Antenna config for CS tone exchanges
>>>> +   * - ``phy``
>>>> +     - ``0x01``
>>>> +     - PHY for CS procedures: ``0x01`` LE 1M, ``0x02`` LE 2M
>>>> +   * - ``tx_power_delta``
>>>> +     - ``0x80``
>>>> +     - Remote vs local TX power delta; ``0x80`` = not applicable
>>>> +   * - ``preferred_peer_antenna``
>>>> +     - ``0x03``
>>>> +     - Preferred antenna for the peer device
>>>> +   * - ``snr_control_initiator``
>>>> +     - ``0xFF``
>>>> +     - SNR control for initiator; ``0xFF`` = no preference
>>>> +   * - ``snr_control_reflector``
>>>> +     - ``0xFF``
>>>> +     - SNR control for reflector; ``0xFF`` = no preference
>>>> +
>>>> +:Example Start with all defaults, no timeout:
>>>> +       | **> start**
>>>> +:Example Start on a specific device:
>>>> +       | **> start AA:BB:CC:DD:EE:FF**
>>>> +:Example Start on a specific device with 10-second auto-stop:
>>>> +       | **> start AA:BB:CC:DD:EE:FF 10**
>>>> +:Example Start with 10-second auto-stop (single device, address omitted):
>>>> +       | **> start 0 10**
>>>> +:Example Start with no timeout, explicit:
>>>> +       | **> start**
>>>> +:Example Start with 5-minute auto-stop:
>>>> +       | **> start AA:BB:CC:DD:EE:FF 300**
>>>> +:Example Start as Initiator only:
>>>> +       | **> start role=0x01**
>>>> +:Example Start as Reflector only:
>>>> +       | **> start role=0x02**
>>>> +:Example Start as both Initiator and Reflector:
>>>> +       | **> start role=0x03**
>>>> +:Example Start with Mode 2 (PBR) main mode:
>>>> +       | **> start main_mode_type=2**
>>>> +:Example Start with both RTT and PBR modes:
>>>> +       | **> start main_mode_type=3**
>>>> +:Example Start with LE 2M PHY for CS procedures:
>>>> +       | **> start phy=0x02**
>>>> +:Example Start with LE 2M PHY for both CS sync and procedures:
>>>> +       | **> start cs_sync_phy=0x02 phy=0x02**
>>>> +:Example Start with reduced TX power (10 dBm):
>>>> +       | **> start max_tx_power=10**
>>>> +:Example Start with companion signal enabled:
>>>> +       | **> start companion_signal_enable=1**
>>>> +:Example Start with a procedure limit of 100:
>>>> +       | **> start max_procedure_count=100**
>>>> +:Example Start with high SNR preference on both roles:
>>>> +       | **> start snr_control_initiator=0x01 snr_control_reflector=0x01**
>>>> +:Example Start with custom channel map (all enabled):
>>>> +       | **> start channel_map=FF:FF:FF:FF:FF:FF:FF:FF:FF:FF**
>>>> +:Example Start Initiator, Mode 2, LE 2M, 30-second timeout:
>>>> +       | **> start AA:BB:CC:DD:EE:FF 30 role=0x01 main_mode_type=2 phy=0x02 cs_sync_phy=0x02**
>>>> +:Example Start both roles, Mode 1, no limit, custom step counts:
>>>> +       | **> start role=0x03 main_mode_type=1 main_mode_min_steps=4 main_mode_max_steps=8**
>>>> +:Example Start on a device, Reflector, 60-second timeout:
>>>> +       | **> start AA:BB:CC:DD:EE:FF 60 role=0x02**
>>>
>>> This approach is too complicated, and users will struggle to discover
>>> available commands without consulting the documentation. Although it
>>> offers flexibility to specify only necessary parameters for a session,
>>> this quickly becomes an individual setting abstraction similar to
>>> `defset`.
>> We already provide default values for all parameters and expose them
>> through the 'show' CS menu option, so users can easily see the
>> currently configured settings without referring to external documentation.
>> If a user wants to modify any parameter, they can do so through
>> the startmeasurement option. Additionally, only the
>> remote device address and timeout parameters are mandatory.
>> All other parameters are optional and will use their default values
>> if not explicitly specified.
>> This keeps the command usage simple while still providing the flexibility
>> to override only the settings that are relevant for a particular session.
> 
> I have to disagree that it makes the usage simple, it doesn't. It
> makes its implementation more flexible but there is no way to discover
> the parameters via tab completion, etc, The parameters are only
> available via documentation because they are not commands themselves.
> 
Sure, we can add tab completion.
Alternatively, would you prefer these to be separate commands?
Earlier, we agreed not to split these settings into individual commands,
so I followed that approach and included all the parameters in the start command.>>>
>>>> +defset
>>>> +------
>>>> +
>>>> +Sets the CS default settings (``role``, ``cs_sync_ant_sel``,
>>>> +``max_tx_power``) on the connected device without starting a
>>>> +measurement. This is required for the Reflector role: a Reflector
>>>> +never calls **start** because it waits passively for the remote
>>>> +Initiator, so **defset** is the only way to push these settings to
>>>> +the daemon before the remote side initiates the procedure.
>>>> +
>>>> +Any ``param=value`` arguments update the local parameter state and
>>>> +are immediately sent to the daemon via **SetDefaultSettings**.
>>>
>>> I don't think this is going to work. `SetDefaultSettings` would need
>>> to remember what each client has set in case there are multiple
>>> clients, otherwise they would overwrite one another. Instead, this
>>> should be stored locally and then set as properties to
>>> StartMeasurement.
>> We have introduced the Defset option specifically for the Reflector role
>> because Start Measurement is not applicable in this role.
>> If users want to configure default settings while operating
>> in the Reflector role, they should have the option to do so
>> through the Defset option. Defset command also accepts the device path
>> as an input parameter, which allows it to distinguish between multiple clients.
> 
> Well that means SetDefaultSettings needs to work as a registration
> method, something we thought wouldn't be necessary. In that case we
> should rename it to RegisterCapabilities and the command should be
> cs.register and we will need to figure out how to decide which
> capabilities to use if multiple capabilities are registered.
> Alternatively, we could allow only one, but then we need to expose
> what the default settings are.
> 
> Anyway, the point of having each setting as a dedicated command still
> stands regardless of whether we implement a `cs.` namespace.register
> or perhaps make cs.start work as a reflector in which case it will not
> need any parameters.
> 
We can update the implementation to remove the defset option and
use cs.start for configuring the default settings parameters instead.
When the role is set to Reflector, cs.start will not initiate distance measurement,
it will only use the provided default settings.

We can also add role-specific hints in the menu so that users can easily identify
which arguments are mandatory for each role.>  >
>>>> +Omitting all arguments sends the current local values unchanged.
>>>> +
>>>> +:Usage: **> defset [param=value ...]**
>>>> +:Uses: **org.bluez.ChannelSounding1(5)** method **SetDefaultSettings**
>>>> +:[param=value]: One or more of ``role``, ``cs_sync_ant_sel``,
>>>> +               ``max_tx_power`` (optional)
>>>> +:Example Configure as Reflector:
>>>> +       | **> defset role=0x02**
>>>> +:Example Configure as Both with reduced TX power:
>>>> +       | **> defset role=0x03 max_tx_power=10**
>>>> +:Example Apply current local values without changing them:
>>>> +       | **> defset**
>>>
>>> Like I said above, this will make it hard for users to discover what
>>> to enter without consulting the documentation. Instead, each file
>>> should probably have a dedicated command, eg `cs.role
>>> <initiator/reflector,both>`, etc for all the settings necessary for
>>> cs.start to work.
>>>
>>>> +stop
>>>> +----
>>>> +
>>>> +Stops an active CS distance measurement. When only one measurement is
>>>> +running the device address may be omitted. When multiple measurements
>>>> +are active the address is required to identify which one to stop.
>>>> +
>>>> +:Usage: **> stop [dev_addr]**
>>>> +:Uses: **org.bluez.ChannelSounding1(5)** method **StopMeasurement**
>>>> +:[dev_addr]: Bluetooth address of the device to stop (optional when
>>>> +             only one session is active; required otherwise)
>>>> +:Example Stop the only active measurement:
>>>> +       | **> stop**
>>>> +:Example Stop a specific device when multiple are active:
>>>> +       | **> stop AA:BB:CC:DD:EE:FF**
>>>> +:Example Stop a second device:
>>>> +       | **> stop 11:22:33:44:55:66**
>>>> +
>>>> +show
>>>> +----
>>>> +
>>>> +Displays all active measurements (device path for each) and the full
>>>> +set of CS parameter values that will be used on the next **start** call.
>>>> +When no measurements are active, ``none`` is shown.
>>>> +
>>>> +The parameter output is divided into three sections:
>>>> +
>>>> +- **Default Settings** — role, CS sync antenna selection, max TX power.
>>>> +- **CS Config Params** — per-procedure configuration fields including
>>>> +  mode type, step counts, PHY, and channel map.
>>>> +- **CS Frequency Params** — procedure scheduling fields including
>>>> +  duration, period, subevent lengths, and SNR control.
>>>> +
>>>> +:Usage: **> show**
>>>> +:Example Show active session and all CS parameters:
>>>> +       | **> show**
>>>> +
>>>> +RESOURCES
>>>> +=========
>>>> +
>>>> +http://www.bluez.org
>>>> +
>>>> +REPORTING BUGS
>>>> +==============
>>>> +
>>>> +linux-bluetooth@vger.kernel.org
>>>> diff --git a/doc/org.bluez.ChannelSounding1.rst b/doc/org.bluez.ChannelSounding1.rst
>>>> new file mode 100644
>>>> index 000000000..73f484507
>>>> --- /dev/null
>>>> +++ b/doc/org.bluez.ChannelSounding1.rst
>>>> @@ -0,0 +1,302 @@
>>>> +==========================
>>>> +org.bluez.ChannelSounding1
>>>> +==========================
>>>> +
>>>> +----------------------------------------------
>>>> +BlueZ D-Bus Channel Sounding API documentation
>>>> +----------------------------------------------
>>>> +
>>>> +:Version: BlueZ
>>>> +:Date: June 2026
>>>> +:Manual section: 5
>>>> +:Manual group: Linux System Administration
>>>> +
>>>> +Interface
>>>> +=========
>>>> +
>>>> +:Service:      org.bluez
>>>> +:Interface:    org.bluez.ChannelSounding1
>>>> +:Object path:  [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>>>> +:Used by:      **bluetoothctl(1)**, **bluetoothctl-cs(1)**
>>>> +
>>>> +Methods
>>>> +-------
>>>> +
>>>> +void StartMeasurement(dict params)
>>>> +``````````````````````````````````
>>>> +
>>>> +Starts a Channel Sounding distance measurement procedure on the connected
>>>> +device. All configuration is supplied in a single ``a{sv}`` dictionary.
>>>> +Any key that is omitted retains its current value in the daemon.
>>>> +
>>>> +The device to measure is identified by the D-Bus object path on which
>>>> +this method is called
>>>> +(``[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX``).
>>>> +Only one measurement per device object may be active at a time. Calling
>>>> +**StartMeasurement** while a session is already active returns
>>>> +``org.bluez.Error.InProgress``.
>>>> +
>>>> +Supported dictionary keys:
>>>> +
>>>> +:uint32 duration_secs (Default: 0):
>>>> +
>>>> +       Duration in seconds before the measurement is stopped
>>>> +       automatically. A value of 0 disables the automatic timeout.
>>>> +
>>>> +:byte role (Default: 0x03):
>>>> +
>>>> +       CS role to use for the measurement.
>>>> +
>>>> +       Possible values:
>>>> +
>>>> +       :0x01: Initiator
>>>> +       :0x02: Reflector
>>>> +       :0x03: Both (Initiator and Reflector)
>>>> +
>>>> +:byte cs_sync_ant_sel (Default: 0xFF):
>>>> +
>>>> +       CS sync antenna selection. Values 0xFE and 0xFF are reserved
>>>> +       by the Bluetooth specification.
>>>> +
>>>> +:byte max_tx_power (Default: 0x14):
>>>> +
>>>> +       Maximum TX power in dBm, treated as a signed value. Valid
>>>> +       range is -127 to +20 dBm.
>>>> +
>>>> +:byte config_id:
>>>> +
>>>> +       CS configuration identifier.
>>>> +
>>>> +:byte main_mode_type:
>>>> +
>>>> +       Main CS mode used in the procedure.
>>>> +
>>>> +:byte sub_mode_type:
>>>> +
>>>> +       Sub-mode within the main mode. Set to 0xFF when unused.
>>>> +
>>>> +:byte main_mode_min_steps:
>>>> +
>>>> +       Minimum number of CS main mode steps per CS subevent.
>>>> +
>>>> +:byte main_mode_max_steps:
>>>> +
>>>> +       Maximum number of CS main mode steps per CS subevent.
>>>> +
>>>> +:byte main_mode_repetition:
>>>> +
>>>> +       Number of times the main mode steps are repeated in a
>>>> +       subevent.
>>>> +
>>>> +:byte mode0_steps:
>>>> +
>>>> +       Number of CS Mode 0 steps at the beginning of each subevent.
>>>> +
>>>> +:byte rtt_types:
>>>> +
>>>> +       Round Trip Time measurement types for the configuration.
>>>> +
>>>> +:byte cs_sync_phy:
>>>> +
>>>> +       PHY used for CS sync packets.
>>>> +
>>>> +       Possible values:
>>>> +
>>>> +       :0x01: LE 1M PHY
>>>> +       :0x02: LE 2M PHY
>>>> +
>>>> +:array{byte} channel_map:
>>>> +
>>>> +       10-byte channel map bitmap. Must be exactly 10 bytes.
>>>> +
>>>> +:byte channel_map_repetition:
>>>> +
>>>> +       Number of consecutive repetitions of the channel map.
>>>> +
>>>> +:byte channel_selection_type:
>>>> +
>>>> +       Algorithm used for CS channel selection.
>>>> +
>>>> +:byte channel_shape:
>>>> +
>>>> +       Shape used in the channel selection algorithm.
>>>> +
>>>> +:byte channel_jump:
>>>> +
>>>> +       Channel jump size used in the channel selection algorithm.
>>>> +
>>>> +:byte companion_signal_enable:
>>>> +
>>>> +       Set to 1 to transmit a companion signal alongside the CS
>>>> +       tone, 0 to disable.
>>>> +
>>>> +:uint16 max_procedure_duration:
>>>> +
>>>> +       Maximum duration of a single CS measurement procedure.
>>>> +
>>>> +:uint16 min_period_between_procedures:
>>>> +
>>>> +       Minimum time between consecutive CS measurement procedures.
>>>> +
>>>> +:uint16 max_period_between_procedures:
>>>> +
>>>> +       Maximum time between consecutive CS measurement procedures.
>>>> +
>>>> +:uint16 max_procedure_count:
>>>> +
>>>> +       Maximum number of CS measurement procedures to run.
>>>> +       A value of 0 means no limit.
>>>> +
>>>> +:array{byte} min_sub_event_len:
>>>> +
>>>> +       Minimum CS subevent length as a 3-byte little-endian value.
>>>> +       Must be exactly 3 bytes.
>>>> +
>>>> +:array{byte} max_sub_event_len:
>>>> +
>>>> +       Maximum CS subevent length as a 3-byte little-endian value.
>>>> +       Must be exactly 3 bytes.
>>>> +
>>>> +:byte tone_antenna_config_selection:
>>>> +
>>>> +       Antenna configuration used for CS tone exchanges.
>>>> +
>>>> +:byte phy:
>>>> +
>>>> +       PHY used during CS procedures.
>>>> +
>>>> +       Possible values:
>>>> +
>>>> +       :0x01: LE 1M PHY
>>>> +       :0x02: LE 2M PHY
>>>> +
>>>> +:byte tx_power_delta:
>>>> +
>>>> +       Difference between remote and local TX power during CS
>>>> +       procedures. 0x80 indicates not applicable.
>>>> +
>>>> +:byte preferred_peer_antenna:
>>>> +
>>>> +       Preferred antenna to be used by the peer device.
>>>> +
>>>> +:byte snr_control_initiator:
>>>> +
>>>> +       SNR control setting for the initiator role.
>>>> +       0xFF indicates no preference.
>>>> +
>>>> +:byte snr_control_reflector:
>>>> +
>>>> +       SNR control setting for the reflector role.
>>>> +       0xFF indicates no preference.
>>>> +
>>>> +Possible errors:
>>>> +
>>>> +:org.bluez.Error.InProgress:
>>>> +:org.bluez.Error.InvalidArgs:
>>>> +:org.freedesktop.DBus.Error.Failed:
>>>> +
>>>> +Examples:
>>>> +
>>>> +:bluetoothctl set role then start:
>>>> +       | [cs] > start AA:BB:CC:DD:EE:FF role=0x01 main_mode_type=2
>>>> +:bluetoothctl start with defaults:
>>>> +       | [cs] > start [dev_addr [duration_secs]]
>>>> +
>>>> +void SetDefaultSettings(dict params)
>>>> +`````````````````````````````````````
>>>> +
>>>> +Sets the CS default settings for this device without starting a
>>>> +measurement. This method is intended for the Reflector role, where
>>>> +the device waits passively for the remote Initiator to begin the
>>>> +procedure and therefore never calls **StartMeasurement**. It allows
>>>> +the application to configure ``role``, ``cs_sync_ant_sel``, and
>>>> +``max_tx_power`` ahead of time so they are in effect when the
>>>> +controller processes the remote CS configuration.
>>>> +Need this to set default settings in Reflector role.
>>>
>>> There's no need for this if StartMeasurement already accepts the same
>>> parameters. Each client should be capable of remembering the
>>> parameters it used, so we don't bloat the daemon with them.
>>>
>> We have introduced the Defset option specifically for the Reflector role
>> because Start Measurement is not applicable in this role.
>> If users want to configure default settings while operating
>> in the Reflector role, they should have the option to do so
>> through the Defset option.
>>>> +Supported dictionary keys:
>>>> +
>>>> +:byte role (Default: 0x03):
>>>> +
>>>> +       CS role to use for the measurement.
>>>> +
>>>> +       Possible values:
>>>> +
>>>> +       :0x01: Initiator
>>>> +       :0x02: Reflector
>>>> +       :0x03: Both (Initiator and Reflector)
>>>> +
>>>> +:byte cs_sync_ant_sel (Default: 0xFF):
>>>> +
>>>> +       CS sync antenna selection. Values 0xFE and 0xFF are reserved
>>>> +       by the Bluetooth specification.
>>>> +
>>>> +:byte max_tx_power (Default: 0x14):
>>>> +
>>>> +       Maximum TX power in dBm, treated as a signed value. Valid
>>>> +       range is -127 to +20 dBm.
>>>> +
>>>> +Possible errors:
>>>> +
>>>> +:org.bluez.Error.InvalidArgs:
>>>> +:org.freedesktop.DBus.Error.Failed:
>>>> +
>>>> +Examples:
>>>> +
>>>> +:bluetoothctl configure as Reflector:
>>>> +       | [cs] > defset role=0x02
>>>> +
>>>> +void StopMeasurement(void)
>>>> +``````````````````````````
>>>> +
>>>> +Stops the active Channel Sounding distance measurement on this device.
>>>> +The device is identified by the D-Bus object path on which this method
>>>> +is called — no session identifier is required.
>>>> +
>>>> +Raises ``org.bluez.Error.NotConnected`` if no measurement is active.
>>>> +
>>>> +Possible errors:
>>>> +
>>>> +:org.bluez.Error.NotConnected:
>>>> +:org.freedesktop.DBus.Error.Failed:
>>>> +
>>>> +In **bluetoothctl(1)**, the device address argument may be omitted only
>>>> +when a single measurement is active; it is required when multiple
>>>> +measurements are active.
>>>> +
>>>> +Examples:
>>>> +
>>>> +:bluetoothctl stop the only active measurement:
>>>> +       | [cs] > stop
>>>> +:bluetoothctl stop a specific device when multiple are active:
>>>> +       | [cs] > stop AA:BB:CC:DD:EE:FF
>>>> +
>>>> +Properties
>>>> +----------
>>>> +
>>>> +boolean Active [readonly]
>>>> +`````````````````````````
>>>> +
>>>> +Indicates whether a CS distance measurement procedure is currently
>>>> +active on this device.
>>>> +
>>>> +Set to ``true`` when a procedure starts — either because the local
>>>> +Initiator called **StartMeasurement** successfully, or because the
>>>> +remote Initiator enabled a CS procedure on the local Reflector.
>>>> +
>>>> +Set to ``false`` when the procedure stops for any reason: the local
>>>> +application called **StopMeasurement**, the measurement duration timer
>>>> +expired, or the ACL connection was dropped.
>>>> +
>>>> +This property emits ``PropertiesChanged`` on every transition so that
>>>> +clients can track measurement state without polling.
>>>
>>> What about the results? Shouldn't results be announced when the
>>> procedure starts?
>> This is still under discussion,
>> as the measurement calculations are handled by a separate daemon.
> 
> Ok, well without it this is not very useful, we only be able to
> start/stop but the result won't be visible.
Agree. will add signal for announcing results in the coming patchset.> 
>>
>>>> +RESOURCES
>>>> +=========
>>>> +
>>>> +http://www.bluez.org
>>>> +
>>>> +REPORTING BUGS
>>>> +==============
>>>> +
>>>> +linux-bluetooth@vger.kernel.org
>>>> --
>>>>
>>>
>>>
>>
> 
> 

