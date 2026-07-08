Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B42D7BF
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518474; cv=pass; b=J4prPitohsKtcqESHIhtjWm2YqIP5TE11+ZTI3F8fdCERgyGfM3XsbDr7qNk9W71jelwWw8INig6ui1vK3S0adSM9LECd8goxM66yKT/G9NuCd1I1AP/FbgDB9eQLxKslqmMgAu05CaTlS20cOIFfKtvAFO5q5nni8cvtvdet7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518474; c=relaxed/simple;
	bh=ipT6BzyJuea1k4IBEkenEjSXQJxzYqnhYn26bqsgGEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wiv3XuPVctXoywJKOkxUXfyFj37rn/Gmp3n/L297edeflULh0WzjPO+UF1hTVEGOzYn1WW5rlSDPztds27YdnieS86N7QwyL0qV78FIM7aG/UkZja4TftG45W83CYh+BX41Hxmwx1CWp0sR3iI2E0SAnI+nIeQSP1VqGQcuyeWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XA20iODv; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA20iODv"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664b05d408bso585343d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 06:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783518471; cv=none;
        d=google.com; s=arc-20260327;
        b=lEsyRBMH3v9Xzc1QKx7R6Ub846XE1gDfNTJXT1HBN50IHCAciUj/kyMpOApOZVCmJj
         41xppwhTm/XIA0L9Ycth7JETxp9TJbCj96zD1XoEi+dC5o8CiDYFy6ulc0FWjU/FN6Vt
         oAvI2sZwD655GbgpX9a/q7ARawr4B4zYHzRYUYXkrtVv5xvFhSimGT1yrIefe574ilps
         FlxIE4DMA4VgR5pZka8Oxk3xgtd28cwyoBHCKixHmnsBvgtPaN9EYC6zwuCYAuh9bg6N
         8rG9Gtm8q2ZbmGwDLnrq0Wu9GPye5nrWOVg+YYoZzJtpRBz1vF+xiX6Z+XMa851Gjf8b
         veCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1w6hW9BD1fbTonytRJPzp3tb2X14fbpqkKIcIMtlpFI=;
        fh=TxHmgKhQfYbogoK+vmJQIDCo2t34N8xamZxfQlSL1ls=;
        b=sAghYfvKWapbCpIvCYaNOh66ZRVo5Vrv9EimuypOLezHYK2aYfvatBg8yLlb4LJJKz
         8YdZnlANSf0EotR7OQlHD9gn+LWcwTB+H5uVYnU7LGZs9petkSXkOBFlhvrRYQl+j/ho
         g5gT88Mvy3tyUftB70eeD7zCZIqc78hj15kH3meUFQQ8Aw/MBxMwVeO7xlosHzUcX19e
         2CRx16gBuyd/So/wat4Lp6Biv6rJyKy9Ml3jrgzNlJ1m6RAC8hqiu6nt1/JA281zYhpH
         Mslx/0MPCZ3lTmAYMl165rtYCnDRariBReUbnBdp9rTlqg2XWZn3qppf4lwqWs0rkBdd
         m77A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783518471; x=1784123271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1w6hW9BD1fbTonytRJPzp3tb2X14fbpqkKIcIMtlpFI=;
        b=XA20iODvK3C8Xp0NFZ4AXp3HcncquwmMWJIw/j4/5IN5wbcvet5e9G8L3+1QMaTxCV
         bRRn4ML4PhsBiKX4M9fcppbX90QK6IB0Vjv49u8pBiryhNKvHK94hOx864RyDuvS0PAf
         923w0X9aT3ulxRCnyMtUkfWqRBph8vAqwZp72GokPQ9WVUjebcIPULUy09KdJyW13QB1
         A/6NnFvO2KQGAJmDQkeBfFuGmO5LN0NNjJIi0ehGBAew5ApVMkqVIcXxVd3SCVv0d1YT
         7MeeLySDCigy8hHMAQ7qqMeh2bdOqzXC9crhgDb72suyP/a20g8esPHYykE/WvRx9CZ3
         01TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783518471; x=1784123271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1w6hW9BD1fbTonytRJPzp3tb2X14fbpqkKIcIMtlpFI=;
        b=klqlH1NPhluH16cPmFnWJ0jQDOccV6ket0FoIGxmEYsRdH5oBBUHxy7EPUgLHuX6ix
         6ywQkPBNmpw4A10wwMG4X4qzQSDQKJhzYCySx0ZGxFlz8FVXLO6McHYwLImW08UdQjRL
         yPtHuExVs3sOHTkMs3/5mKCmWWZ4IntlwuUJs0o1KLbaewi4444qrV4oFRxCzszG6rbR
         PQb22UUAWPWscWQTanovdha8swlagpmAFZsZjo/i1kmt9nn/AhlMXloBSMIyMV0sybjo
         A50Y74fRvGPjSzp9ia7hvS/iOj6SIZlzsxmbBmGzLsbuVYUStB2FTDeXti8hhZhjEtf1
         zk6Q==
X-Gm-Message-State: AOJu0Yx6Nyw9OgIDvjP3F1dnkgg7hRYa8S5PqCb2lKlNaohJfs6ObVWV
	s1aF11/4mjIlgTRehP2rJeS1cajjGJQngBdkGCNUhh5yAv7PHlqlgFKBLEAdfTAM9UUCVUWH7Fm
	na8j6g2CcFdIDgbOu2zaScqHP4LUKllw=
X-Gm-Gg: AfdE7cn7nJEzVQkI0Fni+rzKVvBtfD8fdl3gROhWGKwqZqYrc3giNS06u/b+TvnyIf9
	HrxYwAtvU38vNSOwgIjJqhh2ARwEiALfSdVDNtTHKK42sCBGyIlKmLE/oqD+AN2esmsTZf+4c64
	CL24mdwIHUdk0hrVKhmpxYEsjN0VzEZpCaco4xJoNuyFtCyng4ewuRuOwMYuCKvZI4BZiZ8t9/G
	7K2jGYAxXK/tl1qQUjmsiFxKvLHWNDq4CjJI9YMW9CXgySGrwVxGnSDgHvxHq7DREael6owAX2z
	Fp7UvGvlXMShzy3JNr1/EhxKEX1n9zYY6i951a4siOPsJ8twBKHhPEze/C0=
X-Received: by 2002:a05:690e:4888:20b0:664:d899:e3a9 with SMTP id
 956f58d0204a3-6679f000e9amr1480224d50.20.1783518470422; Wed, 08 Jul 2026
 06:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706161603.2744459-1-naga.akella@oss.qualcomm.com>
 <20260706161603.2744459-4-naga.akella@oss.qualcomm.com> <CABBYNZJvWyfDSk9vAUpuwSU0fQ6V7pi799__izO3b+CB84EZfg@mail.gmail.com>
 <4de0246d-f773-42d4-988b-40281d15cb84@oss.qualcomm.com> <CABBYNZ+8BWpFA-A5oezZmETjLJNVdy0ujk+xxxr_Fyx9pNXnkA@mail.gmail.com>
 <b7fdd257-5f0d-4cf4-a8b5-8b4e57b3f19a@oss.qualcomm.com>
In-Reply-To: <b7fdd257-5f0d-4cf4-a8b5-8b4e57b3f19a@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 Jul 2026 09:47:38 -0400
X-Gm-Features: AVVi8CdwkkDZiRaus_KZtjU_RKtBgOW3toB4-BeUJMhQL4FTdhCBViNTdkos4bw
Message-ID: <CABBYNZLwfsGXtck_692Pb3gGqvJCu-V_E83sdW89SC7GVk3YjA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 3/5] doc/org.bluez.ChannelSounding1: Add Used by
 reference and Examples
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Wed, Jul 8, 2026 at 4:53=E2=80=AFAM Naga Bhavani Akella
<naga.akella@oss.qualcomm.com> wrote:
>
> Hi Luiz,
>
> On 7/7/2026 8:13 PM, Luiz Augusto von Dentz wrote:
> > Hi Naga,
> >
> > On Tue, Jul 7, 2026 at 3:34=E2=80=AFAM Naga Bhavani Akella
> > <naga.akella@oss.qualcomm.com> wrote:
> >>
> >> Hi Luiz,
> >>
> >> Please find the comments inline
> >>
> >> On 7/7/2026 2:06 AM, Luiz Augusto von Dentz wrote:
> >>> Hi Naga,
> >>>
> >>> On Mon, Jul 6, 2026 at 12:16=E2=80=AFPM Naga Bhavani Akella
> >>> <naga.akella@oss.qualcomm.com> wrote:
> >>>>
> >>>> Add :Used by: field linking to bluetoothctl cs submenu and
> >>>> Examples section showing corresponding bluetoothctl cs commands
> >>>> for D-Bus methods
> >>>> ---
> >>>>  doc/bluetoothctl-cs.rst            | 278 ++++++++++++++++++++++++++
> >>>>  doc/org.bluez.ChannelSounding1.rst | 302 ++++++++++++++++++++++++++=
+++
> >>>
> >>> These 2 needs to be splitted, each file on its own commit.
> >> sure, will do that>
> >>>>  2 files changed, 580 insertions(+)
> >>>>  create mode 100644 doc/bluetoothctl-cs.rst
> >>>>  create mode 100644 doc/org.bluez.ChannelSounding1.rst
> >>>>
> >>>> diff --git a/doc/bluetoothctl-cs.rst b/doc/bluetoothctl-cs.rst
> >>>> new file mode 100644
> >>>> index 000000000..c16c89298
> >>>> --- /dev/null
> >>>> +++ b/doc/bluetoothctl-cs.rst
> >>>> @@ -0,0 +1,278 @@
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +bluetoothctl-cs
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +
> >>>> +--------------------------
> >>>> +Channel Sounding Submenu
> >>>> +--------------------------
> >>>> +
> >>>> +:Version: BlueZ
> >>>> +:Copyright: Free use of this software is granted under the terms of=
 the GNU
> >>>> +            Lesser General Public Licenses (LGPL).
> >>>> +:Date: June 2026
> >>>> +:Manual section: 1
> >>>> +:Manual group: Linux System Administration
> >>>> +
> >>>> +SYNOPSIS
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +
> >>>> +**bluetoothctl** [--options] [cs.commands]
> >>>> +
> >>>> +This submenu controls Bluetooth Channel Sounding (CS) distance meas=
urement
> >>>> +using the **org.bluez.ChannelSounding1(5)** D-Bus interface. It all=
ows
> >>>> +starting and stopping measurements and inspecting the current param=
eter
> >>>> +state and active session identifier.
> >>>> +
> >>>> +CS parameters can be overridden on any **start** call using inline
> >>>> +``param=3Dvalue`` arguments. Overrides are applied to the local par=
ameter
> >>>> +state before the measurement is started, so **show** reflects them
> >>>> +immediately after.
> >>>> +
> >>>> +
> >>>> +Channel Sounding Commands
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >>>> +
> >>>> +start
> >>>> +-----
> >>>> +
> >>>> +Sets one or more CS parameters and starts a distance measurement on=
 the
> >>>> +connected device. All configuration is sent to the daemon in a sing=
le
> >>>> +**StartMeasurement** call. On success the device path is printed to
> >>>> +the console. Multiple simultaneous sessions across different device=
s are
> >>>> +supported; each is tracked independently.
> >>>> +
> >>>> +Calling **start** on a device that already has an active measuremen=
t
> >>>> +returns an error without starting a second session on the same devi=
ce.
> >>>> +
> >>>> +Positional arguments are optional and must appear before any
> >>>> +``param=3Dvalue`` pairs:
> >>>> +
> >>>> +- ``duration_secs`` =E2=80=94 auto-stop timeout in seconds; ``0`` (=
default) means
> >>>> +  no timeout.
> >>>> +
> >>>> +Any additional argument of the form ``param=3Dvalue`` overrides the=
 named
> >>>> +parameter for this call and for all subsequent calls. Array-valued
> >>>> +parameters (``channel_map``, ``min_sub_event_len``, ``max_sub_event=
_len``)
> >>>> +use colon-separated hex bytes with no ``0x`` prefix.
> >>>> +
> >>>> +:Usage: **> start [dev_addr [duration_secs]] [param=3Dvalue ...]**
> >>>> +:Uses: **org.bluez.ChannelSounding1(5)** method **StartMeasurement*=
*
> >>>> +:[dev_addr]: Bluetooth address of the target device (optional; uses=
 the
> >>>> +             only available CS-capable device when omitted)
> >>>> +:[duration_secs]: Seconds before auto-stop (optional, default 0 =3D=
 no timeout)
> >>>> +:[param=3Dvalue]: One or more ``param=3Dvalue`` overrides (optional=
)
> >>>> +
> >>>> +**Settable parameters:**
> >>>> +
> >>>> +.. list-table::
> >>>> +   :header-rows: 1
> >>>> +   :widths: 35 15 50
> >>>> +
> >>>> +   * - Parameter
> >>>> +     - Default
> >>>> +     - Description
> >>>> +   * - ``role``
> >>>> +     - ``0x03``
> >>>> +     - ``0x01`` Initiator, ``0x02`` Reflector, ``0x03`` Both
> >>>> +   * - ``cs_sync_ant_sel``
> >>>> +     - ``0xFF``
> >>>> +     - CS sync antenna selection (0xFE/0xFF reserved)
> >>>> +   * - ``max_tx_power``
> >>>> +     - ``20``
> >>>> +     - Max TX power in dBm (signed, range =E2=88=92127 to +20)
> >>>> +   * - ``config_id``
> >>>> +     - ``0``
> >>>> +     - CS configuration identifier
> >>>> +   * - ``main_mode_type``
> >>>> +     - ``1``
> >>>> +     - ``1`` Mode 1 (RTT), ``2`` Mode 2 (PBR), ``3`` Both
> >>>> +   * - ``sub_mode_type``
> >>>> +     - ``0xFF``
> >>>> +     - Sub-mode within main mode; ``0xFF`` =3D unused
> >>>> +   * - ``main_mode_min_steps``
> >>>> +     - ``2``
> >>>> +     - Min CS main mode steps per subevent
> >>>> +   * - ``main_mode_max_steps``
> >>>> +     - ``3``
> >>>> +     - Max CS main mode steps per subevent
> >>>> +   * - ``main_mode_repetition``
> >>>> +     - ``1``
> >>>> +     - Times main mode steps are repeated in a subevent
> >>>> +   * - ``mode0_steps``
> >>>> +     - ``2``
> >>>> +     - CS Mode 0 steps at the beginning of each subevent
> >>>> +   * - ``rtt_types``
> >>>> +     - ``0``
> >>>> +     - RTT measurement types bitmask
> >>>> +   * - ``cs_sync_phy``
> >>>> +     - ``0x01``
> >>>> +     - PHY for CS sync: ``0x01`` LE 1M, ``0x02`` LE 2M
> >>>> +   * - ``channel_map``
> >>>> +     - ``FC:FF:7F:FC:FF:FF:FF:FF:FF:1F``
> >>>> +     - 10-byte channel map bitmap (colon-separated hex)
> >>>> +   * - ``channel_map_repetition``
> >>>> +     - ``1``
> >>>> +     - Consecutive repetitions of the channel map
> >>>> +   * - ``channel_selection_type``
> >>>> +     - ``0``
> >>>> +     - CS channel selection algorithm
> >>>> +   * - ``channel_shape``
> >>>> +     - ``0``
> >>>> +     - Shape used in channel selection algorithm
> >>>> +   * - ``channel_jump``
> >>>> +     - ``2``
> >>>> +     - Channel jump size
> >>>> +   * - ``companion_signal_enable``
> >>>> +     - ``0``
> >>>> +     - ``1`` to transmit companion signal, ``0`` to disable
> >>>> +   * - ``max_procedure_duration``
> >>>> +     - ``1600``
> >>>> +     - Maximum duration of one CS measurement procedure
> >>>> +   * - ``min_period_between_procedures``
> >>>> +     - ``30``
> >>>> +     - Minimum time between consecutive procedures
> >>>> +   * - ``max_period_between_procedures``
> >>>> +     - ``150``
> >>>> +     - Maximum time between consecutive procedures
> >>>> +   * - ``max_procedure_count``
> >>>> +     - ``0``
> >>>> +     - Max number of procedures; ``0`` =3D no limit
> >>>> +   * - ``min_sub_event_len``
> >>>> +     - ``00:20:00``
> >>>> +     - Min CS subevent length, 3-byte LE (colon-separated hex)
> >>>> +   * - ``max_sub_event_len``
> >>>> +     - ``03:20:00``
> >>>> +     - Max CS subevent length, 3-byte LE (colon-separated hex)
> >>>> +   * - ``tone_antenna_config_selection``
> >>>> +     - ``0x07``
> >>>> +     - Antenna config for CS tone exchanges
> >>>> +   * - ``phy``
> >>>> +     - ``0x01``
> >>>> +     - PHY for CS procedures: ``0x01`` LE 1M, ``0x02`` LE 2M
> >>>> +   * - ``tx_power_delta``
> >>>> +     - ``0x80``
> >>>> +     - Remote vs local TX power delta; ``0x80`` =3D not applicable
> >>>> +   * - ``preferred_peer_antenna``
> >>>> +     - ``0x03``
> >>>> +     - Preferred antenna for the peer device
> >>>> +   * - ``snr_control_initiator``
> >>>> +     - ``0xFF``
> >>>> +     - SNR control for initiator; ``0xFF`` =3D no preference
> >>>> +   * - ``snr_control_reflector``
> >>>> +     - ``0xFF``
> >>>> +     - SNR control for reflector; ``0xFF`` =3D no preference
> >>>> +
> >>>> +:Example Start with all defaults, no timeout:
> >>>> +       | **> start**
> >>>> +:Example Start on a specific device:
> >>>> +       | **> start AA:BB:CC:DD:EE:FF**
> >>>> +:Example Start on a specific device with 10-second auto-stop:
> >>>> +       | **> start AA:BB:CC:DD:EE:FF 10**
> >>>> +:Example Start with 10-second auto-stop (single device, address omi=
tted):
> >>>> +       | **> start 0 10**
> >>>> +:Example Start with no timeout, explicit:
> >>>> +       | **> start**
> >>>> +:Example Start with 5-minute auto-stop:
> >>>> +       | **> start AA:BB:CC:DD:EE:FF 300**
> >>>> +:Example Start as Initiator only:
> >>>> +       | **> start role=3D0x01**
> >>>> +:Example Start as Reflector only:
> >>>> +       | **> start role=3D0x02**
> >>>> +:Example Start as both Initiator and Reflector:
> >>>> +       | **> start role=3D0x03**
> >>>> +:Example Start with Mode 2 (PBR) main mode:
> >>>> +       | **> start main_mode_type=3D2**
> >>>> +:Example Start with both RTT and PBR modes:
> >>>> +       | **> start main_mode_type=3D3**
> >>>> +:Example Start with LE 2M PHY for CS procedures:
> >>>> +       | **> start phy=3D0x02**
> >>>> +:Example Start with LE 2M PHY for both CS sync and procedures:
> >>>> +       | **> start cs_sync_phy=3D0x02 phy=3D0x02**
> >>>> +:Example Start with reduced TX power (10 dBm):
> >>>> +       | **> start max_tx_power=3D10**
> >>>> +:Example Start with companion signal enabled:
> >>>> +       | **> start companion_signal_enable=3D1**
> >>>> +:Example Start with a procedure limit of 100:
> >>>> +       | **> start max_procedure_count=3D100**
> >>>> +:Example Start with high SNR preference on both roles:
> >>>> +       | **> start snr_control_initiator=3D0x01 snr_control_reflect=
or=3D0x01**
> >>>> +:Example Start with custom channel map (all enabled):
> >>>> +       | **> start channel_map=3DFF:FF:FF:FF:FF:FF:FF:FF:FF:FF**
> >>>> +:Example Start Initiator, Mode 2, LE 2M, 30-second timeout:
> >>>> +       | **> start AA:BB:CC:DD:EE:FF 30 role=3D0x01 main_mode_type=
=3D2 phy=3D0x02 cs_sync_phy=3D0x02**
> >>>> +:Example Start both roles, Mode 1, no limit, custom step counts:
> >>>> +       | **> start role=3D0x03 main_mode_type=3D1 main_mode_min_ste=
ps=3D4 main_mode_max_steps=3D8**
> >>>> +:Example Start on a device, Reflector, 60-second timeout:
> >>>> +       | **> start AA:BB:CC:DD:EE:FF 60 role=3D0x02**
> >>>
> >>> This approach is too complicated, and users will struggle to discover
> >>> available commands without consulting the documentation. Although it
> >>> offers flexibility to specify only necessary parameters for a session=
,
> >>> this quickly becomes an individual setting abstraction similar to
> >>> `defset`.
> >> We already provide default values for all parameters and expose them
> >> through the 'show' CS menu option, so users can easily see the
> >> currently configured settings without referring to external documentat=
ion.
> >> If a user wants to modify any parameter, they can do so through
> >> the startmeasurement option. Additionally, only the
> >> remote device address and timeout parameters are mandatory.
> >> All other parameters are optional and will use their default values
> >> if not explicitly specified.
> >> This keeps the command usage simple while still providing the flexibil=
ity
> >> to override only the settings that are relevant for a particular sessi=
on.
> >
> > I have to disagree that it makes the usage simple, it doesn't. It
> > makes its implementation more flexible but there is no way to discover
> > the parameters via tab completion, etc, The parameters are only
> > available via documentation because they are not commands themselves.
> >
> Sure, we can add tab completion.
> Alternatively, would you prefer these to be separate commands?
> Earlier, we agreed not to split these settings into individual commands,

I don't recall saying that we should make each field an individual
command, actually, I'd rather do that since it makes tab completion a
lot easier to implement.

> so I followed that approach and included all the parameters in the start =
command.>>>
> >>>> +defset
> >>>> +------
> >>>> +
> >>>> +Sets the CS default settings (``role``, ``cs_sync_ant_sel``,
> >>>> +``max_tx_power``) on the connected device without starting a
> >>>> +measurement. This is required for the Reflector role: a Reflector
> >>>> +never calls **start** because it waits passively for the remote
> >>>> +Initiator, so **defset** is the only way to push these settings to
> >>>> +the daemon before the remote side initiates the procedure.
> >>>> +
> >>>> +Any ``param=3Dvalue`` arguments update the local parameter state an=
d
> >>>> +are immediately sent to the daemon via **SetDefaultSettings**.
> >>>
> >>> I don't think this is going to work. `SetDefaultSettings` would need
> >>> to remember what each client has set in case there are multiple
> >>> clients, otherwise they would overwrite one another. Instead, this
> >>> should be stored locally and then set as properties to
> >>> StartMeasurement.
> >> We have introduced the Defset option specifically for the Reflector ro=
le
> >> because Start Measurement is not applicable in this role.
> >> If users want to configure default settings while operating
> >> in the Reflector role, they should have the option to do so
> >> through the Defset option. Defset command also accepts the device path
> >> as an input parameter, which allows it to distinguish between multiple=
 clients.
> >
> > Well that means SetDefaultSettings needs to work as a registration
> > method, something we thought wouldn't be necessary. In that case we
> > should rename it to RegisterCapabilities and the command should be
> > cs.register and we will need to figure out how to decide which
> > capabilities to use if multiple capabilities are registered.
> > Alternatively, we could allow only one, but then we need to expose
> > what the default settings are.
> >
> > Anyway, the point of having each setting as a dedicated command still
> > stands regardless of whether we implement a `cs.` namespace.register
> > or perhaps make cs.start work as a reflector in which case it will not
> > need any parameters.
> >
> We can update the implementation to remove the defset option and
> use cs.start for configuring the default settings parameters instead.
> When the role is set to Reflector, cs.start will not initiate distance me=
asurement,
> it will only use the provided default settings.
>
> We can also add role-specific hints in the menu so that users can easily =
identify
> which arguments are mandatory for each role.>  >
> >>>> +Omitting all arguments sends the current local values unchanged.
> >>>> +
> >>>> +:Usage: **> defset [param=3Dvalue ...]**
> >>>> +:Uses: **org.bluez.ChannelSounding1(5)** method **SetDefaultSetting=
s**
> >>>> +:[param=3Dvalue]: One or more of ``role``, ``cs_sync_ant_sel``,
> >>>> +               ``max_tx_power`` (optional)
> >>>> +:Example Configure as Reflector:
> >>>> +       | **> defset role=3D0x02**
> >>>> +:Example Configure as Both with reduced TX power:
> >>>> +       | **> defset role=3D0x03 max_tx_power=3D10**
> >>>> +:Example Apply current local values without changing them:
> >>>> +       | **> defset**
> >>>
> >>> Like I said above, this will make it hard for users to discover what
> >>> to enter without consulting the documentation. Instead, each file
> >>> should probably have a dedicated command, eg `cs.role
> >>> <initiator/reflector,both>`, etc for all the settings necessary for
> >>> cs.start to work.
> >>>
> >>>> +stop
> >>>> +----
> >>>> +
> >>>> +Stops an active CS distance measurement. When only one measurement =
is
> >>>> +running the device address may be omitted. When multiple measuremen=
ts
> >>>> +are active the address is required to identify which one to stop.
> >>>> +
> >>>> +:Usage: **> stop [dev_addr]**
> >>>> +:Uses: **org.bluez.ChannelSounding1(5)** method **StopMeasurement**
> >>>> +:[dev_addr]: Bluetooth address of the device to stop (optional when
> >>>> +             only one session is active; required otherwise)
> >>>> +:Example Stop the only active measurement:
> >>>> +       | **> stop**
> >>>> +:Example Stop a specific device when multiple are active:
> >>>> +       | **> stop AA:BB:CC:DD:EE:FF**
> >>>> +:Example Stop a second device:
> >>>> +       | **> stop 11:22:33:44:55:66**
> >>>> +
> >>>> +show
> >>>> +----
> >>>> +
> >>>> +Displays all active measurements (device path for each) and the ful=
l
> >>>> +set of CS parameter values that will be used on the next **start** =
call.
> >>>> +When no measurements are active, ``none`` is shown.
> >>>> +
> >>>> +The parameter output is divided into three sections:
> >>>> +
> >>>> +- **Default Settings** =E2=80=94 role, CS sync antenna selection, m=
ax TX power.
> >>>> +- **CS Config Params** =E2=80=94 per-procedure configuration fields=
 including
> >>>> +  mode type, step counts, PHY, and channel map.
> >>>> +- **CS Frequency Params** =E2=80=94 procedure scheduling fields inc=
luding
> >>>> +  duration, period, subevent lengths, and SNR control.
> >>>> +
> >>>> +:Usage: **> show**
> >>>> +:Example Show active session and all CS parameters:
> >>>> +       | **> show**
> >>>> +
> >>>> +RESOURCES
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +
> >>>> +http://www.bluez.org
> >>>> +
> >>>> +REPORTING BUGS
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +
> >>>> +linux-bluetooth@vger.kernel.org
> >>>> diff --git a/doc/org.bluez.ChannelSounding1.rst b/doc/org.bluez.Chan=
nelSounding1.rst
> >>>> new file mode 100644
> >>>> index 000000000..73f484507
> >>>> --- /dev/null
> >>>> +++ b/doc/org.bluez.ChannelSounding1.rst
> >>>> @@ -0,0 +1,302 @@
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >>>> +org.bluez.ChannelSounding1
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >>>> +
> >>>> +----------------------------------------------
> >>>> +BlueZ D-Bus Channel Sounding API documentation
> >>>> +----------------------------------------------
> >>>> +
> >>>> +:Version: BlueZ
> >>>> +:Date: June 2026
> >>>> +:Manual section: 5
> >>>> +:Manual group: Linux System Administration
> >>>> +
> >>>> +Interface
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +
> >>>> +:Service:      org.bluez
> >>>> +:Interface:    org.bluez.ChannelSounding1
> >>>> +:Object path:  [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX=
_XX
> >>>> +:Used by:      **bluetoothctl(1)**, **bluetoothctl-cs(1)**
> >>>> +
> >>>> +Methods
> >>>> +-------
> >>>> +
> >>>> +void StartMeasurement(dict params)
> >>>> +``````````````````````````````````
> >>>> +
> >>>> +Starts a Channel Sounding distance measurement procedure on the con=
nected
> >>>> +device. All configuration is supplied in a single ``a{sv}`` diction=
ary.
> >>>> +Any key that is omitted retains its current value in the daemon.
> >>>> +
> >>>> +The device to measure is identified by the D-Bus object path on whi=
ch
> >>>> +this method is called
> >>>> +(``[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX``).
> >>>> +Only one measurement per device object may be active at a time. Cal=
ling
> >>>> +**StartMeasurement** while a session is already active returns
> >>>> +``org.bluez.Error.InProgress``.
> >>>> +
> >>>> +Supported dictionary keys:
> >>>> +
> >>>> +:uint32 duration_secs (Default: 0):
> >>>> +
> >>>> +       Duration in seconds before the measurement is stopped
> >>>> +       automatically. A value of 0 disables the automatic timeout.
> >>>> +
> >>>> +:byte role (Default: 0x03):
> >>>> +
> >>>> +       CS role to use for the measurement.
> >>>> +
> >>>> +       Possible values:
> >>>> +
> >>>> +       :0x01: Initiator
> >>>> +       :0x02: Reflector
> >>>> +       :0x03: Both (Initiator and Reflector)
> >>>> +
> >>>> +:byte cs_sync_ant_sel (Default: 0xFF):
> >>>> +
> >>>> +       CS sync antenna selection. Values 0xFE and 0xFF are reserved
> >>>> +       by the Bluetooth specification.
> >>>> +
> >>>> +:byte max_tx_power (Default: 0x14):
> >>>> +
> >>>> +       Maximum TX power in dBm, treated as a signed value. Valid
> >>>> +       range is -127 to +20 dBm.
> >>>> +
> >>>> +:byte config_id:
> >>>> +
> >>>> +       CS configuration identifier.
> >>>> +
> >>>> +:byte main_mode_type:
> >>>> +
> >>>> +       Main CS mode used in the procedure.
> >>>> +
> >>>> +:byte sub_mode_type:
> >>>> +
> >>>> +       Sub-mode within the main mode. Set to 0xFF when unused.
> >>>> +
> >>>> +:byte main_mode_min_steps:
> >>>> +
> >>>> +       Minimum number of CS main mode steps per CS subevent.
> >>>> +
> >>>> +:byte main_mode_max_steps:
> >>>> +
> >>>> +       Maximum number of CS main mode steps per CS subevent.
> >>>> +
> >>>> +:byte main_mode_repetition:
> >>>> +
> >>>> +       Number of times the main mode steps are repeated in a
> >>>> +       subevent.
> >>>> +
> >>>> +:byte mode0_steps:
> >>>> +
> >>>> +       Number of CS Mode 0 steps at the beginning of each subevent.
> >>>> +
> >>>> +:byte rtt_types:
> >>>> +
> >>>> +       Round Trip Time measurement types for the configuration.
> >>>> +
> >>>> +:byte cs_sync_phy:
> >>>> +
> >>>> +       PHY used for CS sync packets.
> >>>> +
> >>>> +       Possible values:
> >>>> +
> >>>> +       :0x01: LE 1M PHY
> >>>> +       :0x02: LE 2M PHY
> >>>> +
> >>>> +:array{byte} channel_map:
> >>>> +
> >>>> +       10-byte channel map bitmap. Must be exactly 10 bytes.
> >>>> +
> >>>> +:byte channel_map_repetition:
> >>>> +
> >>>> +       Number of consecutive repetitions of the channel map.
> >>>> +
> >>>> +:byte channel_selection_type:
> >>>> +
> >>>> +       Algorithm used for CS channel selection.
> >>>> +
> >>>> +:byte channel_shape:
> >>>> +
> >>>> +       Shape used in the channel selection algorithm.
> >>>> +
> >>>> +:byte channel_jump:
> >>>> +
> >>>> +       Channel jump size used in the channel selection algorithm.
> >>>> +
> >>>> +:byte companion_signal_enable:
> >>>> +
> >>>> +       Set to 1 to transmit a companion signal alongside the CS
> >>>> +       tone, 0 to disable.
> >>>> +
> >>>> +:uint16 max_procedure_duration:
> >>>> +
> >>>> +       Maximum duration of a single CS measurement procedure.
> >>>> +
> >>>> +:uint16 min_period_between_procedures:
> >>>> +
> >>>> +       Minimum time between consecutive CS measurement procedures.
> >>>> +
> >>>> +:uint16 max_period_between_procedures:
> >>>> +
> >>>> +       Maximum time between consecutive CS measurement procedures.
> >>>> +
> >>>> +:uint16 max_procedure_count:
> >>>> +
> >>>> +       Maximum number of CS measurement procedures to run.
> >>>> +       A value of 0 means no limit.
> >>>> +
> >>>> +:array{byte} min_sub_event_len:
> >>>> +
> >>>> +       Minimum CS subevent length as a 3-byte little-endian value.
> >>>> +       Must be exactly 3 bytes.
> >>>> +
> >>>> +:array{byte} max_sub_event_len:
> >>>> +
> >>>> +       Maximum CS subevent length as a 3-byte little-endian value.
> >>>> +       Must be exactly 3 bytes.
> >>>> +
> >>>> +:byte tone_antenna_config_selection:
> >>>> +
> >>>> +       Antenna configuration used for CS tone exchanges.
> >>>> +
> >>>> +:byte phy:
> >>>> +
> >>>> +       PHY used during CS procedures.
> >>>> +
> >>>> +       Possible values:
> >>>> +
> >>>> +       :0x01: LE 1M PHY
> >>>> +       :0x02: LE 2M PHY
> >>>> +
> >>>> +:byte tx_power_delta:
> >>>> +
> >>>> +       Difference between remote and local TX power during CS
> >>>> +       procedures. 0x80 indicates not applicable.
> >>>> +
> >>>> +:byte preferred_peer_antenna:
> >>>> +
> >>>> +       Preferred antenna to be used by the peer device.
> >>>> +
> >>>> +:byte snr_control_initiator:
> >>>> +
> >>>> +       SNR control setting for the initiator role.
> >>>> +       0xFF indicates no preference.
> >>>> +
> >>>> +:byte snr_control_reflector:
> >>>> +
> >>>> +       SNR control setting for the reflector role.
> >>>> +       0xFF indicates no preference.
> >>>> +
> >>>> +Possible errors:
> >>>> +
> >>>> +:org.bluez.Error.InProgress:
> >>>> +:org.bluez.Error.InvalidArgs:
> >>>> +:org.freedesktop.DBus.Error.Failed:
> >>>> +
> >>>> +Examples:
> >>>> +
> >>>> +:bluetoothctl set role then start:
> >>>> +       | [cs] > start AA:BB:CC:DD:EE:FF role=3D0x01 main_mode_type=
=3D2
> >>>> +:bluetoothctl start with defaults:
> >>>> +       | [cs] > start [dev_addr [duration_secs]]
> >>>> +
> >>>> +void SetDefaultSettings(dict params)
> >>>> +`````````````````````````````````````
> >>>> +
> >>>> +Sets the CS default settings for this device without starting a
> >>>> +measurement. This method is intended for the Reflector role, where
> >>>> +the device waits passively for the remote Initiator to begin the
> >>>> +procedure and therefore never calls **StartMeasurement**. It allows
> >>>> +the application to configure ``role``, ``cs_sync_ant_sel``, and
> >>>> +``max_tx_power`` ahead of time so they are in effect when the
> >>>> +controller processes the remote CS configuration.
> >>>> +Need this to set default settings in Reflector role.
> >>>
> >>> There's no need for this if StartMeasurement already accepts the same
> >>> parameters. Each client should be capable of remembering the
> >>> parameters it used, so we don't bloat the daemon with them.
> >>>
> >> We have introduced the Defset option specifically for the Reflector ro=
le
> >> because Start Measurement is not applicable in this role.
> >> If users want to configure default settings while operating
> >> in the Reflector role, they should have the option to do so
> >> through the Defset option.
> >>>> +Supported dictionary keys:
> >>>> +
> >>>> +:byte role (Default: 0x03):
> >>>> +
> >>>> +       CS role to use for the measurement.
> >>>> +
> >>>> +       Possible values:
> >>>> +
> >>>> +       :0x01: Initiator
> >>>> +       :0x02: Reflector
> >>>> +       :0x03: Both (Initiator and Reflector)
> >>>> +
> >>>> +:byte cs_sync_ant_sel (Default: 0xFF):
> >>>> +
> >>>> +       CS sync antenna selection. Values 0xFE and 0xFF are reserved
> >>>> +       by the Bluetooth specification.
> >>>> +
> >>>> +:byte max_tx_power (Default: 0x14):
> >>>> +
> >>>> +       Maximum TX power in dBm, treated as a signed value. Valid
> >>>> +       range is -127 to +20 dBm.
> >>>> +
> >>>> +Possible errors:
> >>>> +
> >>>> +:org.bluez.Error.InvalidArgs:
> >>>> +:org.freedesktop.DBus.Error.Failed:
> >>>> +
> >>>> +Examples:
> >>>> +
> >>>> +:bluetoothctl configure as Reflector:
> >>>> +       | [cs] > defset role=3D0x02
> >>>> +
> >>>> +void StopMeasurement(void)
> >>>> +``````````````````````````
> >>>> +
> >>>> +Stops the active Channel Sounding distance measurement on this devi=
ce.
> >>>> +The device is identified by the D-Bus object path on which this met=
hod
> >>>> +is called =E2=80=94 no session identifier is required.
> >>>> +
> >>>> +Raises ``org.bluez.Error.NotConnected`` if no measurement is active=
.
> >>>> +
> >>>> +Possible errors:
> >>>> +
> >>>> +:org.bluez.Error.NotConnected:
> >>>> +:org.freedesktop.DBus.Error.Failed:
> >>>> +
> >>>> +In **bluetoothctl(1)**, the device address argument may be omitted =
only
> >>>> +when a single measurement is active; it is required when multiple
> >>>> +measurements are active.
> >>>> +
> >>>> +Examples:
> >>>> +
> >>>> +:bluetoothctl stop the only active measurement:
> >>>> +       | [cs] > stop
> >>>> +:bluetoothctl stop a specific device when multiple are active:
> >>>> +       | [cs] > stop AA:BB:CC:DD:EE:FF
> >>>> +
> >>>> +Properties
> >>>> +----------
> >>>> +
> >>>> +boolean Active [readonly]
> >>>> +`````````````````````````
> >>>> +
> >>>> +Indicates whether a CS distance measurement procedure is currently
> >>>> +active on this device.
> >>>> +
> >>>> +Set to ``true`` when a procedure starts =E2=80=94 either because th=
e local
> >>>> +Initiator called **StartMeasurement** successfully, or because the
> >>>> +remote Initiator enabled a CS procedure on the local Reflector.
> >>>> +
> >>>> +Set to ``false`` when the procedure stops for any reason: the local
> >>>> +application called **StopMeasurement**, the measurement duration ti=
mer
> >>>> +expired, or the ACL connection was dropped.
> >>>> +
> >>>> +This property emits ``PropertiesChanged`` on every transition so th=
at
> >>>> +clients can track measurement state without polling.
> >>>
> >>> What about the results? Shouldn't results be announced when the
> >>> procedure starts?
> >> This is still under discussion,
> >> as the measurement calculations are handled by a separate daemon.
> >
> > Ok, well without it this is not very useful, we only be able to
> > start/stop but the result won't be visible.
> Agree. will add signal for announcing results in the coming patchset.>
> >>
> >>>> +RESOURCES
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +
> >>>> +http://www.bluez.org
> >>>> +
> >>>> +REPORTING BUGS
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +
> >>>> +linux-bluetooth@vger.kernel.org
> >>>> --
> >>>>
> >>>
> >>>
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz
