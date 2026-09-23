Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31144CF52
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195639; cv=pass; b=mU4uyD0fR1Tmy4lM7S7dbibKHPTftOCo5nZ07lUCxL47OPg2SoJHIkOaZIGOo4voWSIEDvmHeqtJnnbTq+h3RYIG0AX1zpexvHZeoCtbSRBP1qk4iPqRcq/BFhbnvTf6cOsst/e+XPwbgkZTB1QJo/FQBodEgZaRHqeEey73rDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195639; c=relaxed/simple;
	bh=0owRXtqaiJxq3Zt9VHDAwFoilydlO4f+WMTz6+Tmefg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VtVcKEolGIpD5k8UVRRbJzgKu8XWdhj74KOc6LMq+N6Zhlc0bWV7x+VYDhCZCDCJxUjZKEe169AGwuF0UBb1AVGLFfH+gvE7gkknpPV9z9Eyv0L/1JSKQ5VJzpmN43sIJ2a3NmDy+PJvlLMk9mxoqxpb7Lq9NfNBxs8pQeZwXaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0q0DWzz; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0q0DWzz"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66e4ab201ebso1443958d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 13:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790195637; cv=none;
        d=google.com; s=arc-20260327;
        b=nhd+j9MTUqKzbF8Gn0/VU9cNLxkk2dr6IEHPBUfvL6XlOENB/c+qbcrED+rfyjNxNX
         2IGWF6vf+KIArh7RfisHB0hwPgA7IBoVVWmAhc2Jcm0Zm3pBMTXxn++O+nyhjEWVXqqO
         06GWsacScJ+8DKdyNsOY8gTOF+JcOlOnCaxy6RDOzjRKW48glzKIniQQLH16c/BijkHM
         cye6mcgXzMBXOJk5YzvMrPLD7g/2plHaRXqj/UFJHU/7iLpul227uHAOCa0QcGqkJ3ug
         fESQ7ktedjMxXxkliVz2tWCwY8E+B6G+ZQlS1VMXbIdbEkzaheA4xpygbzydgDKHncCJ
         vLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qLqxVVI2W+5x5FxmemlcrOYOC/dc0b91pPglr10ec0s=;
        fh=cVcveKPGwWEIQ1xqIs1egkmMXBBJEtww5UlSqM/jNxY=;
        b=Iw7PgR5WLQRzLxM9CVzQZM9bNjje/RYJhjpCIZaDJQvQSEjaj0zt4Q4BPfSbZUS1Xi
         ogJzg4EMPUTLHi1qA97aPN9EcZN82nPHn6LzXz+grH9G7c3YpzwahdpX7Pi6F15oG5P2
         jlBxvhwWXKtdeY19z+Rnu60Sr1k8AaZPunyWyytJ9XWdTG8Yk1x10rmiXkauedaxp2U/
         uwXJQ5xx/GCH3EkJdE1aO/nnh3uPhbl9glUolKRHfQORot9SsQmQ3Y1BPU+lX9JcSzQ7
         sN6bpo+83/67ad93ta5KB4hyhF9d8s+jYb8qgx7SoWdwlB1bSGy5JUp1/+vB7iTUK7go
         c/hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790195637; x=1790800437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qLqxVVI2W+5x5FxmemlcrOYOC/dc0b91pPglr10ec0s=;
        b=b0q0DWzzon73QayFcrwlrxEUF8kWZ6j8f91sfsZ5DYowdMVwZhE5SyyeQfSkatOyNT
         zTG+4fItRPlxkyt3tbkHGPTNUwhNFXE3Nowrp6EtEQQ9Mlkpfkjl34Rt5cCe8QJmDag8
         e7V1MebSvcFFmUumpLbJ5zt3L577KKZ+iJ74vo9f7afIEpplIs/cy20ZfV3dRrz/OLjR
         HytuAc3SUAvR4T6XZ2337q66w2ey2ZfzoRlKdjoTukaPn6GnSb2B5yyERL+3G/09zf2k
         OmqD09+f/y7Rzxk78e1k8ocOCCscQmBqaHt5sJXBNxGGHNM4iifHojavrTkt3qN55kw6
         xDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790195637; x=1790800437;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qLqxVVI2W+5x5FxmemlcrOYOC/dc0b91pPglr10ec0s=;
        b=f7KOGy/SONaT97M+ks0SMSRCOwDxjCcMxJNkGwRJa2xnvV385S1hHtzUbwh4ZG6O7t
         4FhItRUoIxzQuU5cuadPD6AoTf/DJBnyZDrzVZe90QgZzA2m5obLiMxCionmORdc7iFn
         1D/W0HkjkF2dIYZ+WOMG+FxOyTVtWtJw/3yHgHPupkWdrNrjFGYirt4HWTFrZ9i5ivGE
         AbsbS8JrrDtvLNCyMb7nFOk63A0E3m9VYPQKAEgQwlaEdDyjCLg+K11F5qESc0O27T1b
         8OxBfuBGLfZS/bQhJleCdJ6wxTvxd9Hjpzhv/EGy178uYdFM/N0AzLGdDv46R7KncoCJ
         ybIQ==
X-Gm-Message-State: AFuF++kYRGh/SYNc5OifN63/IiZ0jgRcSf6RTG0Es1Tj0Daf0cxSt5pt
	BxyEuhit6FKrf3q1L2vA4r4QwdfukFWJkx794Y0qTqCaOWuhsQmGKZcCWvOXJsZKsiyPMsnnJLs
	O2gqO+0DZTyfsVRrEV0Ewz2slD6YB7YczDfcnyzYoIQ==
X-Gm-Gg: AYBFou1WmBT6kNte0nweVZHaFafQBtwIKmb1BA0A8YLDR/TI5QLodVQBCL275RaIDTt
	kKFzJcX6HB0xs4gVMM8HRcm4lCfSub82Wk9E0n+4YJzND4yxN5VWdcj8B3MvXIDH+D18jdDx8Fh
	Yz0Wb443OyXPH/YgTbdG1hILUZTUmwwrm9N+Loj2l46KlJXX8xebCtxUYfJc8QkpqxsbO+2cwEd
	VYTLXN5qSrAz9YT08ZqUVQema1zX7wib4NrfYyh3oOVCtND3WbIP5InY0qkqZZXOZMi0mzIvArX
	Eo3FV8Y8CxpdrBgELkf5SrF1D5GoLC8ryv6lP5TNXyUe0bevQD/NZpPFpTkgLPQ8kp9P1RLBINy
	Qz0tIDq5medQ4EYVbQeGdoY5UpaXncjpFV0ykUvet2w==
X-Received: by 2002:a05:690e:b81:b0:671:47bd:b7b6 with SMTP id
 956f58d0204a3-672ed3031d5mr288082d50.64.1790195636313; Wed, 23 Sep 2026
 13:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923203105.264648-1-luiz.dentz@gmail.com>
In-Reply-To: <20260923203105.264648-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 23 Sep 2026 16:33:45 -0400
X-Gm-Features: AcwNN1V2Rwhu1tEIdByrlFzImkmw9tLgAgqJ8DLw3bodN4Ma3MWEMBcFA4YxtYk
Message-ID: <CABBYNZ+NOPc4QDzamuCpHY0XfseOE7CJHarnyVFWKe+1jUfzMg@mail.gmail.com>
Subject: Re: [PATCH BlueZ vRFC] doc: Add functional-hfp documentation
To: linux-bluetooth@vger.kernel.org, 
	=?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Wed, Sep 23, 2026 at 4:31=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Document the HFP functional test cases, using the BlueZ HF
> implementation driven through bluetoothctl telephony submenu, and a
> minimal AG implemented by the test with org.bluez.Profile1:
>
> - profile connection and disconnection
> - audio connection (SCO) with CVSD and mSBC
>
> Document what is supported today, i.e. the SLC and calls, and the
> changes needed for the audio test cases, i.e. codec negotiation and
> audio connection in the HF, which are expected to fail until then.
> ---
>  Makefile.am                |   1 +
>  doc/functional-hfp.rst     | 286 +++++++++++++++++++++++++++++++++++++
>  doc/functional-testing.rst |   1 +
>  3 files changed, 288 insertions(+)
>  create mode 100644 doc/functional-hfp.rst
>
> diff --git a/Makefile.am b/Makefile.am
> index e5587c55d2dd..0248d439cb55 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -501,6 +501,7 @@ EXTRA_DIST +=3D doc/assigned-numbers.rst doc/supporte=
d-features.txt \
>                                 doc/functional-a2dp.rst \
>                                 doc/functional-avrcp.rst \
>                                 doc/functional-bap.rst \
> +                               doc/functional-hfp.rst \
>                                 doc/functional-hog.rst \
>                                 doc/functional-mpris-proxy.rst \
>                                 doc/functional-obex.rst \
> diff --git a/doc/functional-hfp.rst b/doc/functional-hfp.rst
> new file mode 100644
> index 000000000000..ab67b42d0148
> --- /dev/null
> +++ b/doc/functional-hfp.rst
> @@ -0,0 +1,286 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +functional-hfp
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +DESCRIPTION
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Hands-Free Profile (HFP) functional tests, `test/functional/test_hfp.py`=
,
> +using the BlueZ HFP Hands-Free (HF) implementation
> +(`profiles/audio/hfp-hf.c`) driven through the **telephony** submenu of
> +**bluetoothctl(1)**, see **bluetoothctl-telephony(1)**. See
> +**functional-testing(7)** for the conventions used here, and
> +**test-functional(1)** for how to run the suite.
> +
> +STATUS
> +=3D=3D=3D=3D=3D=3D
> +
> +Supported today
> +---------------
> +
> +HF role (host0)
> +       The ``hfp`` plugin (`profiles/audio/hfp-hf.c`, experimental,
> +       enabled with ``Experimental =3D true``) connects to the AG found =
in
> +       the SDP records of the peer and sets up the Service Level
> +       Connection (SLC) over RFCOMM using `src/shared/hfp.c`:
> +       ``AT+BRSF``, ``AT+CIND=3D?``, ``AT+CIND?``, ``AT+CMER``, and afte=
r
> +       the SLC ``AT+CHLD=3D?`` (when the AG supports three-way calling),
> +       ``AT+COPS``, ``AT+CLIP``, ``AT+CCWA``, ``AT+CMEE``, ``AT+NREC`` a=
nd
> +       ``AT+CLCC``.
> +
> +       It exposes an **org.bluez.Telephony1** object per connected AG,
> +       with the indicators reported by the AG (``Service``, ``Signal``,
> +       ``Roaming``, ``BattChg``), ``OperatorName`` and ``InbandRingtone`=
`,
> +       and an **org.bluez.Call1** object per call reported by the AG
> +       (``+CIEV``, ``+CLIP``, ``+CCWA``, ``+CLCC``).
> +
> +       Of the call control, ``Dial``, ``Call1.Answer`` and
> +       ``Call1.Hangup`` are supported.
> +
> +bluetoothctl (host0)
> +       The **telephony** submenu lists and shows the audio gateways and
> +       calls, and can ``dial``, ``answer`` and ``hangup``.
> +
> +AG role (host1)
> +       Not implemented by BlueZ, the test implements a minimal AG with
> +       **org.bluez.Profile1**. This is enough for the SLC and calls, and
> +       for the SCO socket once the HF supports audio.
> +
> +btvirt
> +       Emulates SCO and eSCO links, with the CVSD and transparent air
> +       modes, and forwards the SCO data between the controllers, so no
> +       emulator changes are expected for the audio test cases.
> +
> +This covers test_hfp_connect and test_hfp_disconnect.
> +
> +Changes needed
> +--------------
> +
> +Codec negotiation, in `src/shared/hfp.c`
> +       - Set Codec Negotiation (``HFP_HF_FEAT_CODEC_NEGOTIATION``, 0x80)
> +         in the HF supported features sent with ``AT+BRSF``, which are
> +         currently fixed by ``HFP_HF_FEATURES``.
> +       - Send ``AT+BAC=3D<codecs>`` after ``AT+BRSF`` when the AG suppor=
ts
> +         codec negotiation (0x200 in ``+BRSF``), listing CVSD and mSBC.
> +       - Handle ``+BCS: <codec>`` from the AG, replying ``AT+BCS=3D<code=
c>``
> +         when the codec is supported, and report the selected codec to t=
he
> +         user of `src/shared/hfp.c`.
> +       - Optionally, request an audio connection with ``AT+BCC``.
> +
> +Audio connection, in `profiles/audio/hfp-hf.c`
> +       - Listen for SCO connections from the AG, only accepting them fro=
m
> +         a connected AG, and with the voice setting of the selected code=
c:
> +         ``BT_VOICE_CVSD_16BIT`` for CVSD, ``BT_VOICE_TRANSPARENT`` for
> +         mSBC.
> +       - Report the audio connection over D-Bus. The test cases assume a
> +         **org.bluez.MediaTransport1** object for the telephony object, =
as
> +         done for A2DP, with the ``Codec`` in use and its ``State``, whi=
ch
> +         the user acquires to get the SCO socket. This needs HFP support=
 in
> +         `profiles/audio/transport.c`, which only handles A2DP, BAP and
> +         ASHA transports.
> +
> +bluetoothctl
> +       - The errors of all the telephony commands are reported as
> +         ``Failed to answer: <error>`` (`client/telephony.c`), which is
> +         misleading for ``dial`` and ``hangup``.
> +       - Nothing to do for the audio connection when using a transport, =
as
> +         the **transport** submenu already shows and acquires transports=
.
> +
> +Other limitations, not needed by the test cases
> +       - ``HangupAll``, ``SwapCalls``, ``ReleaseAndAnswer``,
> +         ``ReleaseAndSwap``, ``HoldAndAnswer``, ``CreateMultiparty`` and
> +         ``SendTones`` return ``org.bluez.Error.NotSupported``, so
> +         ``telephony.hangup-all`` fails.
> +       - ``HangupActive`` and ``HangupHeld`` are documented in
> +         **org.bluez.Telephony(5)** but not implemented.
> +       - The HF does not publish an SDP record nor listen for RFCOMM
> +         connections, so the SLC can only be connected by the HF.
> +
> +The audio test cases, test_hfp_sco, are marked as expected to fail
> +(``xfail``) until these changes are done.
> +
> +SETUP
> +=3D=3D=3D=3D=3D
> +
> +Two hosts, connected over BR/EDR:
> +
> +.. code-block::
> +
> +       +------------------------+                 +---------------------=
---+
> +       | host0                  |     BR/EDR      | host1               =
   |
> +       | HF                     | --------------> | AG                  =
   |
> +       | bluetoothd (hfp)       |   RFCOMM (AT)   | bluetoothd          =
   |
> +       | bluetoothctl           |                 | Python AG (Profile1)=
   |
> +       |                        | <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D> |                        |
> +       +------------------------+       SCO       +---------------------=
---+
> +
> +       --> connection is initiated by      =3D=3D> audio flows towards
> +
> +host0, the Hands-Free unit
> +       Runs **bluetoothd(8)** with ``Experimental =3D true``, as the ``h=
fp``
> +       plugin is experimental, and `bluetoothctl` to pair, connect and
> +       use the **telephony** submenu.
> +
> +host1, the Audio Gateway
> +       BlueZ does not implement the AG role, so the test implements it:
> +       it registers an **org.bluez.Profile1** for the HFP AG UUID
> +       (``0000111f-0000-1000-8000-00805f9b34fb``) with ``Role =3D server=
``,
> +       which also publishes the SDP record the HF looks for. It answers =
the
> +       AT commands of the HF over the RFCOMM socket handed over by
> +       ``NewConnection``, and handles the SCO socket for the audio
> +       connection. The AG supported features, in ``+BRSF``, are
> +       configurable, in particular Codec Negotiation (0x200), and the
> +       codecs it supports.
> +
> +Both hosts run `bluetoothctl` with an agent answering the pairing
> +automatically. The AG profile is registered *before* pairing, so its
> +SDP record is in place when the HF resolves the services.
> +
> +The HF connects the SLC itself, as the AG does not connect it: the hosts
> +are paired over BR/EDR, trust each other, and host0 connects.
> +
> +Codecs
> +------
> +
> +``CVSD`` (codec ID 1)
> +       Narrowband speech, mandatory. Used when codec negotiation is not
> +       supported by either side, or when the AG selects it. The SCO sock=
et
> +       uses the default voice setting (``BT_VOICE_CVSD_16BIT``).
> +
> +``mSBC`` (codec ID 2)
> +       Wideband speech. Requires codec negotiation on both sides: the HF
> +       lists it in ``AT+BAC=3D1,2`` and the AG selects it with ``+BCS: 2=
``,
> +       confirmed by the HF with ``AT+BCS=3D2``. The SCO socket uses the
> +       transparent voice setting (``BT_VOICE_TRANSPARENT``), i.e. the
> +       controller does not transcode the audio.
> +
> +TEST CASES
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +test_hfp_connect
> +----------------
> +
> +:Setup: As above, with the AG not supporting codec negotiation.
> +
> +:Steps:
> +       1. host1: register the AG profile.
> +       2. host0: pair with host1 over BR/EDR, and ``trust`` each other.
> +       3. host0: ``connect <host1 bdaddr>``.
> +       4. host0: ``telephony.list``.
> +       5. host0: ``telephony.show``.
> +
> +:Expected:
> +       1. The AG profile is registered.
> +       2. ``Pairing successful``, ``trust succeeded`` on both hosts.
> +       3. ``Connection successful``. The AG receives the SLC setup, in
> +          order: ``AT+BRSF=3D<features>``, ``AT+CIND=3D?``, ``AT+CIND?``=
,
> +          ``AT+CMER=3D3,0,0,1``, then the commands following the SLC, e.=
g.
> +          ``AT+COPS=3D3,0``, ``AT+CLIP=3D1``, ``AT+CCWA=3D1``, ``AT+CMEE=
=3D1``,
> +          ``AT+NREC=3D0`` and ``AT+CLCC``.
> +       4. ``[NEW] Telephony /org/bluez/hci0/dev_XX/telephony0`` and the
> +          audio gateway listed.
> +       5. ``Audio gateway /org/bluez/hci0/dev_XX/telephony0`` with
> +          ``UUID: Handsfree Audio Gateway (0000111f-...)``,
> +          ``State: connected``, and the indicators reported by the AG
> +          (``Service``, ``Signal``, ``Roaming``, ``BattChg``), and
> +          ``OperatorName`` as reported with ``+COPS``.
> +
> +:Notes: Supported today.
> +
> +       ``connect`` has to be issued by the HF, as the ``hfp`` plugin
> +       does not listen for incoming connections. Without ``trust``, the
> +       AG blocks on an **org.bluez.Agent1.AuthorizeService** prompt.
> +
> +test_hfp_disconnect
> +-------------------
> +
> +:Setup: As test_hfp_connect, with the SLC connected.
> +
> +:Steps: host0: ``disconnect <host1 bdaddr>``.
> +
> +:Expected:
> +       1. The AG sees the RFCOMM socket closed.
> +       2. ``[DEL] Telephony /org/bluez/hci0/dev_XX/telephony0`` on host0=
.
> +       3. ``Disconnection successful``.
> +
> +:Notes: Supported today.
> +
> +test_hfp_sco[cvsd]
> +------------------
> +
> +:Setup: As test_hfp_connect, with the AG not supporting codec
> +       negotiation.
> +
> +:Steps:
> +       1. Connect the SLC as in test_hfp_connect.
> +       2. host1: connect SCO to host0 with the CVSD voice setting.
> +       3. host1: send audio data over the SCO socket.
> +       4. host1: close the SCO socket.
> +
> +:Expected:
> +       1. The SLC is connected, the HF does not send ``AT+BAC``.
> +       2. The HF accepts the audio connection, which is reported on host=
0
> +          as a transport for the telephony object, with ``Codec: 0x01``
> +          (CVSD) and ``State: active``.
> +       3. The audio data is received on host0 over the transport.
> +       4. The transport is removed on host0.
> +
> +:Notes: Needs changes: audio connection in the HF, see STATUS.
> +       Expected to fail until then.
> +
> +test_hfp_sco[msbc]
> +------------------
> +
> +:Setup: As test_hfp_connect, with the AG supporting codec negotiation
> +       (0x200 in ``+BRSF``) and the CVSD and mSBC codecs.
> +
> +:Steps:
> +       1. Connect the SLC as in test_hfp_connect.
> +       2. host1: send ``+BCS: 2``.
> +       3. host1: connect SCO to host0 with the transparent voice setting=
.
> +       4. host1: send audio data over the SCO socket.
> +       5. host1: close the SCO socket.
> +
> +:Expected:
> +       1. The HF supports codec negotiation, 0x80 in ``AT+BRSF``, and
> +          lists its codecs with ``AT+BAC=3D1,2`` after ``AT+BRSF``.
> +       2. The HF confirms the codec with ``AT+BCS=3D2``, and the AG repl=
ies
> +          ``OK``.
> +       3. The HF accepts the audio connection, with the transparent air
> +          mode, which is reported on host0 as a transport for the
> +          telephony object, with ``Codec: 0x02`` (mSBC) and
> +          ``State: active``.
> +       4. The audio data is received on host0 over the transport.
> +       5. The transport is removed on host0.
> +
> +:Notes: Needs changes: codec negotiation and audio connection in the
> +       HF, see STATUS. Expected to fail until then.
> +
> +       The AG only connects SCO after the codec has been confirmed with
> +       ``AT+BCS``. If the HF replies with another codec, or with
> +       ``ERROR``, the AG shall select the codec again or fall back to
> +       CVSD.
> +
> +test_hfp_sco[msbc-to-cvsd]
> +--------------------------
> +
> +:Setup: As test_hfp_sco[msbc], except the AG only supports CVSD while
> +       supporting codec negotiation.
> +
> +:Steps:
> +       1. Connect the SLC as in test_hfp_connect.
> +       2. host1: send ``+BCS: 1``.
> +       3. host1: connect SCO to host0 with the CVSD voice setting.
> +
> +:Expected:
> +       1. The HF lists its codecs with ``AT+BAC=3D1,2``.
> +       2. The HF confirms the codec with ``AT+BCS=3D1``.
> +       3. The HF accepts the audio connection, reported on host0 as a
> +          transport with ``Codec: 0x01`` (CVSD).
> +
> +:Notes: Needs changes: codec negotiation and audio connection in the
> +       HF, see STATUS. Expected to fail until then.
> +
> +       This checks that the HF follows the codec selected by the AG
> +       rather than always using mSBC when both support codec
> +       negotiation.
> diff --git a/doc/functional-testing.rst b/doc/functional-testing.rst
> index 7b3cad1c66b1..79aade8e58ff 100644
> --- a/doc/functional-testing.rst
> +++ b/doc/functional-testing.rst
> @@ -15,6 +15,7 @@ are documented separately:
>  - **functional-a2dp(7)**: `test/functional/test_a2dp.py`
>  - **functional-avrcp(7)**: `test/functional/test_avrcp.py`
>  - **functional-bap(7)**: `test/functional/test_bap.py`
> +- **functional-hfp(7)**: `test/functional/test_hfp.py`
>  - **functional-hog(7)**: `test/functional/test_hog.py`
>  - **functional-mpris-proxy(7)**: `test/functional/test_mpris_proxy.py`
>  - **functional-obex(7)**: `test/functional/test_obex.py`
> --
> 2.55.0

Can you take a look at this? I was planning to introduce some testing
for HFP but it looks like it is not quite ready. Perhaps you can take
over if supporting end-to-end testing with BlueZ's HFP implementation
is within your plans, if not perhaps we can switch to a third-party
component suh as Pipewire.

--=20
Luiz Augusto von Dentz
