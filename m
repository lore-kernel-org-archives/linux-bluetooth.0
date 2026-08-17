Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B123AB9D
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976493; cv=pass; b=PBLF9qpGzXBSSCQ4Gy0JhIFcpBCvn7YrKtQVqFKR4wz2FpyV77nNaOaaz5FeR8DOaf+KfZ6rSqPAzDnpXEHw2grx/d7rXckunVywJpzlGf/3F5DxOSZo/WDTRJswbkyaUqGrkB/p/k+oEMAYYiDGpKx35xGopoRv2XpKoc9ze0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976493; c=relaxed/simple;
	bh=CNsPUm4LHclK4Q07jcLeHb+t+VTgnoncNQkV16x9KEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lime0Vhw1pXlDXMxTFMRZMHDQ+7P5CSf72coxuYtKh5/uqpb+dSKjPeq4NAtFZuGGXI4umIC7Yp9pQoQWJBGNgO1IlMK9GMtJvhUwLpEz414BD454Zm9FF9g7A8SwIEU+r2b9ohbDFftGq8puldWKyE10voA7atcgiLkdzgN9xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7XnHhSi; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7XnHhSi"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81e6f0b4610so35181677b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 07:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786976490; cv=none;
        d=google.com; s=arc-20260327;
        b=Ix2yGMr8dkNml9kc841q9MblBSdkX9+AX9UJ6ucKWCRPh7R7AA3/uwtZHBLnmJLexq
         3/uIJwb8qwwK6B7AR1pThz6kyVfiw8AO7gR9Pdimh82R/sTxwPPrAvHUwYkfhlyaqVql
         sstdXNwRI+Xahw/HBIjGMLGXIKkx/kBKYwrn5gXwC7flvpqwoCqTscT6G9as+sl3NUrT
         l/bYFQICIcX/ht55ga+/1P9K1FNz9rKLauvehjhFix/PIUY5ppKDXbxIV6mTMyrTXWsx
         MXAYiAXMkHvsq+sjH1xmdwHUEBtbN1eeV1y0rt0eW609Uzse7sgZAez4gPVfRQSliH3m
         clCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sVwQPXUBYPoSgO14nKF9ocKl6p9v6WsMLHqW7IG327Y=;
        fh=FPmZos/ewCwd36nN0Fb6s72F28Pq4ETWBqED36wS+94=;
        b=Uw2fLenM9SFoac+UbhF3xIhtcgsgt92unxMLQr69Dlr+dDsJTB/BuwR9du7oQLLXza
         vTczsk60xH9ELkkOpZQW5i37auAHoSFV7sFxS8jE8Ma6V1Es3VRTAT5EBGjmUVFCVBdM
         54GKX1OGW7pqBynZNop9HLIKtFT2k2RcI4CfXP3qlVFymDchjM4MU6bdJvJnofMaHSdV
         x/1cXHI08zp/jV4Mf64YVMcD5UA74HEoHNeIQCLnThopnQaFKRFSCcB9x32mZ5ZUQ3Mg
         ak4N/8+OeWC0oBG5+aC+7rwEqYDx9Iyp6UrYCm2nwjDi1RXihC9bdOBX7MwiAMnTYYUQ
         3NYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786976490; x=1787581290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sVwQPXUBYPoSgO14nKF9ocKl6p9v6WsMLHqW7IG327Y=;
        b=f7XnHhSi4hsgSnuh33H41PAO9PZIbCmvrK5KPVpiEOuBbzGujZCp+94CemkYxD+FuN
         qw1NAAkIRGHxoyEKr7asIJm3uGl90V5p0CwJBKuhoyHW2ki5OD9rS372Hi9+YFqFYufb
         BmAEtfA30UW4HC98oKUWzGcdJwf24RN3Rk6PmnWYtBqpUtpWmdp+wqfVQiAeFPfNW7g4
         X/C7c3jV2KN1qIhoThtv5TWfC4glEHl5FanuTqilHe3WP3Htpxz49g80vXI8L+eANtez
         mCCvR8UJ2deG7qBTfaCLnCncKo+/e0ZG++Dt2QO18JxCOZFo7NqKNwMhLRzAiprLqGdD
         7P9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786976490; x=1787581290;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sVwQPXUBYPoSgO14nKF9ocKl6p9v6WsMLHqW7IG327Y=;
        b=KKPDtAKeL4PEg7+kD+ftQxueAOiMeMR9cWhomRRQdhZCP8u5TdoBgLkI1dPGaf1O1a
         RUBiaCZqgzQkRH7tKEOXi2dRbC2CfqpEnAnB4/RVOyH2/DWJUTNIzWk96BpR0ajNAtg2
         sJfhwxEnIqs1/I7pT576hUF30C6NSEBYeg4WgOsUFKG1ScWY8eN0+WuMYgjfsbKLMbjq
         oVVUy8hGPinOthbFsFxWS0ZbiGS+EvB8cEF9VnHlc0a6RvDwQSLGb3dNaUc4RWhfQ281
         y19bW0LIpcWW6Q/YuC0OBNhGxHRsafVQHHqNKmvSc+QKtSIFhQySivTk/zRNMQBmoNzC
         Cvlw==
X-Gm-Message-State: AOJu0YzmhcNVkejQQY/b3ZDpURa56FYKT8TM4NtyBpvBABJcmkMhHKso
	gzcP9cLM58UD0ypPHeP+qdQzRKEVM5UFfyUszj3tqfiRnzQMW/2zBET81aGEOMvM2VtYi2m3wAF
	n7Ywctuw+sHEuHzw7KqVTDcV8e56tUnqTplpjPZyPbw==
X-Gm-Gg: AR+sD13l9p/LigQ77zsz3XwCz8n3yPiJ4RDviy+HrHXhyLGVIf/PRe1rnNBXRglvAjj
	VSWGZkACajwNoYVd62rTlmycyW5b5v6xAuXDmCCefPHpafPHFJC3VZbJgzP/OTEDvX5p3ZuG7Z4
	ajmmV+vdoA7786KWCXEOVGRPGlgHPn9bDtnXj1GynD/a2eKal+g9NWzme8fop4yisGpoTOO/8Dw
	v9oDXUVG1r+zHJ7pPKFrmn9B3K7Dj8K1lr62yN5bolchx/NEd2xWpObM5kchUjY/uOn54YLYHdd
	SeOMwMDj1a76CAWWSQH+bINQB/AKmZ2Hkl7UwZqX6VYvAjjrt02ImRspJ4toWuLuVfZxCtted4f
	sAYeIc6DZFKAsOuEU4zzvgAeNS1Uu
X-Received: by 2002:a05:690c:7003:b0:81f:650c:98ce with SMTP id
 00721157ae682-84133394466mr4640287b3.31.1786976489852; Mon, 17 Aug 2026
 07:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM7PR03MB61504B7CDB46CF6F9FD1EF81D7A72@AM7PR03MB6150.eurprd03.prod.outlook.com>
In-Reply-To: <AM7PR03MB61504B7CDB46CF6F9FD1EF81D7A72@AM7PR03MB6150.eurprd03.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Aug 2026 10:21:18 -0400
X-Gm-Features: AcwNN1VEtkIf2Z7yHpORdmL4qtHziFjEN6g3-Xp8clLRQpfRJaBfD5WD6BIZ6XE
Message-ID: <CABBYNZ+7T9o+rF9D8AgyOFnmUv=ay38yC7OffjcBnTsO=Nru0Q@mail.gmail.com>
Subject: Re: Buggy parameter passing using hci.cmd in bluetoothctl
To: "Vanwezemael Kris (DGJ)" <Kris.Vanwezemael@police.belgium.eu>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vanwezemael,

On Mon, Aug 17, 2026 at 4:52=E2=80=AFAM Vanwezemael Kris (DGJ)
<Kris.Vanwezemael@police.belgium.eu> wrote:
>
> Dear,
>
> I would like to report a particularity with executing hci commands though=
 the bluetoothctrl program.
>
> My system is:
> Linux XXXXXX 6.12.47+rpt-rpi-v8 #1 SMP PREEMPT Debian 1:6.12.47-1+rpt1 (2=
025-09-16) aarch64 GNU/Linux
> My Bluez version is:
> bluetoothctl: 5.82
>
> While executing site examples, there is something not going right when pa=
rameter processing is needed, as errors like =E2=80=98invalid packet size=
=E2=80=99 and =E2=80=98invalid parameter size=E2=80=99 are reported.

What site report, are you talking about bluetoothctl-hci.rst?

> I captured as much as a could below.
>
> Thank you for your feedback
>
> sudo bluetoothctl
> hci0 new_settings: powered bondable ssp br/edr le secure-conn
> Agent registered
> [CHG] Controller 2C:CF:67:6D:5A:17 Pairable: yes
> [bluetoothctl]> hci.open 0 raw
> HCI index 0 raw channel opened
> [bluetoothctl]> hci.cmd 0x1003
> HCI Command complete:
>   00 bf fe cf fe db ff 7b 87                       .......{.
> [bluetoothctl]> hci.cmd 0x1009
> HCI Command complete:
>   00 17 5a 6d 67 cf 2c                             ..Zmg.,
> [bluetoothctl]> hci.cmd 0x0c01 0x01
> HCI Command complete:
>   12                                               .
> [bluetoothctl]> hci.cmd 0x200f 0x00 0x08
> HCI Command complete:
>   00 80                                            ..
> [bluetoothctl]> hci.cmd 0x2008 0x20 0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x=
08
> HCI Command complete:
>   00                                               .
> [bluetoothctl]> hci.cmd 0x0c05 0x02
> HCI Command complete:
>   00                                               .
> [bluetoothctl]> hci.cmd 0x0c2a 0x01
> HCI Command complete:
>   00                                               .
> [bluetoothctl]> hci.cmd 0x0c23 0x00 0x08
> HCI Command complete:
>   12                                               .
> [bluetoothctl]>
>
> Sudo btmon gives me this :
>
> sudo btmon
> Bluetooth monitor ver 5.82
> btmon[26844]: =3D Note: Linux version 6.12.47+rpt-rpi-v8 (aarch64)       =
                                      0.359032
> btmon[26844]: =3D Note: Bluetooth subsystem version 2.22                 =
                                      0.359043
> =3D New Index: 2C:CF:67:6D:5A:17 (Primary,UART,hci0)                     =
                               [hci0] 0.359046
> =3D Open Index: 2C:CF:67:6D:5A:17                                        =
                               [hci0] 0.359048
> =3D Index Info: 2C:CF:67:6D:5A:17 (Cypress Semiconductor)                =
                               [hci0] 0.359050
> bluetoothctl[26788]: @ RAW Open: bluetoothctl (privileged) version 2.22  =
                    {0x0003} [hci0] 0.359053
> bluetoothctl[26788]: @ MGMT Open: bluetoothctl (privileged) version 1.23 =
                           {0x0002} 0.359056
> bluetoothd[26729]: @ MGMT Open: bluetoothd (privileged) version 1.23     =
                           {0x0001} 0.359060
> bluetoothctl[26788]: @ MGMT Close: bluetoothctl                          =
                          {0x0002} 12.664823
> bluetoothctl[26788]: @ RAW Close: bluetoothctl                           =
                   {0x0003} [hci0] 12.666624
> bluetoothd[26729]: @ MGMT Command: Set Bondable (0x0009) plen 1          =
                   {0x0001} [hci0] 12.713440
>         Bondable: Disabled (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 7                           =
                   {0x0001} [hci0] 12.713468
>       Set Bondable (0x0009) plen 4
>         Status: Success (0x00)
>         Current settings: 0x00000ac1
>           Powered
>           Secure Simple Pairing
>           BR/EDR
>           Low Energy
>           Secure Connections
> bluetoothctl[26849]: @ MGMT Open: bluetoothctl (privileged) version 1.23 =
                          {0x0002} 15.897158
> bluetoothd[26729]: @ MGMT Command: Set Bondable (0x0009) plen 1          =
                   {0x0001} [hci0] 15.971613
>         Bondable: Enabled (0x01)
> @ MGMT Event: Command Complete (0x0001) plen 7                           =
                   {0x0001} [hci0] 15.971629
>       Set Bondable (0x0009) plen 4
>         Status: Success (0x00)
>         Current settings: 0x00000ad1
>           Powered
>           Bondable
>           Secure Simple Pairing
>           BR/EDR
>           Low Energy
>           Secure Connections
> @ MGMT Event: New Settings (0x0006) plen 4                               =
                   {0x0002} [hci0] 15.971632
>         Current settings: 0x00000ad1
>           Powered
>           Bondable
>           Secure Simple Pairing
>           BR/EDR
>           Low Energy
>           Secure Connections
> bluetoothd[26729]: @ MGMT Command: Set IO Capability (0x0018) plen 1     =
                   {0x0001} [hci0] 15.971720
>         Capability: KeyboardDisplay (0x04)
> @ MGMT Event: Command Complete (0x0001) plen 3                           =
                   {0x0001} [hci0] 15.971724
>       Set IO Capability (0x0018) plen 0
>         Status: Success (0x00)
> bluetoothctl[26849]: @ RAW Open: bluetoothctl (privileged) version 2.22  =
                   {0x0003} [hci0] 36.172604
> bluetoothctl[26849]: @ RAW Close: bluetoothctl                           =
                   {0x0003} [hci0] 44.460094
> bluetoothctl[26849]: @ MGMT Close: bluetoothctl                          =
                          {0x0002} 46.645576
> bluetoothd[26729]: @ MGMT Command: Set Bondable (0x0009) plen 1          =
                   {0x0001} [hci0] 46.688706
>         Bondable: Disabled (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 7                           =
                   {0x0001} [hci0] 46.688752
>       Set Bondable (0x0009) plen 4
>         Status: Success (0x00)
>         Current settings: 0x00000ac1
>           Powered
>           Secure Simple Pairing
>           BR/EDR
>           Low Energy
>           Secure Connections
> bluetoothctl[26855]: @ MGMT Open: bluetoothctl (privileged) version 1.23 =
                          {0x0002} 48.404793
> bluetoothd[26729]: @ MGMT Command: Set Bondable (0x0009) plen 1          =
                   {0x0001} [hci0] 48.469700
>         Bondable: Enabled (0x01)
> @ MGMT Event: Command Complete (0x0001) plen 7                           =
                   {0x0001} [hci0] 48.469719
>       Set Bondable (0x0009) plen 4
>         Status: Success (0x00)
>         Current settings: 0x00000ad1
>           Powered
>           Bondable
>           Secure Simple Pairing
>           BR/EDR
>           Low Energy
>           Secure Connections
> @ MGMT Event: New Settings (0x0006) plen 4                               =
                   {0x0002} [hci0] 48.469723
>         Current settings: 0x00000ad1
>           Powered
>           Bondable
>           Secure Simple Pairing
>           BR/EDR
>           Low Energy
>           Secure Connections
> bluetoothd[26729]: @ MGMT Command: Set IO Capability (0x0018) plen 1     =
                   {0x0001} [hci0] 48.469848
>         Capability: KeyboardDisplay (0x04)
> @ MGMT Event: Command Complete (0x0001) plen 3                           =
                   {0x0001} [hci0] 48.469853
>       Set IO Capability (0x0018) plen 0
>         Status: Success (0x00)
> bluetoothctl[26855]: @ MGMT Close: bluetoothctl                          =
                          {0x0002} 50.227543
> bluetoothd[26729]: @ MGMT Command: Set Bondable (0x0009) plen 1          =
                   {0x0001} [hci0] 50.269123
>         Bondable: Disabled (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 7                           =
                   {0x0001} [hci0] 50.269146
>       Set Bondable (0x0009) plen 4
>         Status: Success (0x00)
>         Current settings: 0x00000ac1
>           Powered
>           Secure Simple Pairing
>           BR/EDR
>           Low Energy
>           Secure Connections
> bluetoothctl[26861]: @ MGMT Open: bluetoothctl (privileged) version 1.23 =
                          {0x0002} 54.599424
> bluetoothd[26729]: @ MGMT Command: Set Bondable (0x0009) plen 1          =
                   {0x0001} [hci0] 54.663378
>         Bondable: Enabled (0x01)
> @ MGMT Event: Command Complete (0x0001) plen 7                           =
                   {0x0001} [hci0] 54.663395
>       Set Bondable (0x0009) plen 4
>         Status: Success (0x00)
>         Current settings: 0x00000ad1
>           Powered
>           Bondable
>           Secure Simple Pairing
>           BR/EDR
>           Low Energy
>           Secure Connections
> @ MGMT Event: New Settings (0x0006) plen 4                               =
                   {0x0002} [hci0] 54.663398
>         Current settings: 0x00000ad1
>           Powered
>           Bondable
>           Secure Simple Pairing
>           BR/EDR
>           Low Energy
>           Secure Connections
> bluetoothd[26729]: @ MGMT Command: Set IO Capability (0x0018) plen 1     =
                   {0x0001} [hci0] 54.663485
>         Capability: KeyboardDisplay (0x04)
> @ MGMT Event: Command Complete (0x0001) plen 3                           =
                   {0x0001} [hci0] 54.663489
>       Set IO Capability (0x0018) plen 0
>         Status: Success (0x00)
> bluetoothctl[26861]: @ RAW Open: bluetoothctl (privileged) version 2.22  =
                   {0x0003} [hci0] 58.502480
> bluetoothctl[26861]: < HCI Command: Read Local Supported Features (0x04|0=
x0003) plen 0           #1 [hci0] 204.076330
> > HCI Event: Command Complete (0x0e) plen 12                             =
                        #2 [hci0] 204.076756
>       Read Local Supported Features (0x04|0x0003) ncmd 1
>         Status: Success (0x00)
>         Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
>           3 slot packets
>           5 slot packets
>           Encryption
>           Slot offset
>           Timing accuracy
>           Role switch
>           Sniff mode
>           Power control requests
>           Channel quality driven data rate (CQDDR)
>           SCO link
>           HV2 packets
>           HV3 packets
>           u-law log synchronous data
>           A-law log synchronous data
>           CVSD synchronous data
>           Paging parameter negotiation
>           Power control
>           Transparent synchronous data
>           Flow control lag (most significant bit)
>           Broadcast Encryption
>           Enhanced Data Rate ACL 2 Mbps mode
>           Enhanced Data Rate ACL 3 Mbps mode
>           Enhanced inquiry scan
>           Interlaced inquiry scan
>           Interlaced page scan
>           RSSI with inquiry results
>           Extended SCO link (EV3 packets)
>           EV4 packets
>           EV5 packets
>           AFH capable peripheral
>           AFH classification peripheral
>           LE Supported (Controller)
>           3-slot Enhanced Data Rate ACL packets
>           5-slot Enhanced Data Rate ACL packets
>           Sniff subrating
>           Pause encryption
>           AFH capable central
>           AFH classification central
>           Enhanced Data Rate eSCO 2 Mbps mode
>           Enhanced Data Rate eSCO 3 Mbps mode
>           3-slot Enhanced Data Rate eSCO packets
>           Extended Inquiry Response
>           Simultaneous LE and BR/EDR (Controller)
>           Secure Simple Pairing
>           Encapsulated PDU
>           Erroneous Data Reporting
>           Non-flushable Packet Boundary Flag
>           Link Supervision Timeout Changed Event
>           Inquiry TX Power Level
>           Enhanced Power Control
>           Extended features
> bluetoothctl[26861]: < HCI Command: Read BD ADDR (0x04|0x0009) plen 0    =
                        #3 [hci0] 212.433915
> > HCI Event: Command Complete (0x0e) plen 10                             =
                        #4 [hci0] 212.434301
>       Read BD ADDR (0x04|0x0009) ncmd 1
>         Status: Success (0x00)
>         Address: 2C:CF:67:6D:5A:17 (Raspberry Pi (Trading) Ltd)
> bluetoothctl[26861]: < HCI Command: Set Event Mask (0x03|0x0001) plen 1  =
                        #5 [hci0] 225.962367
>         invalid packet size
>         01                                               .
> > HCI Event: Command Complete (0x0e) plen 4                              =
                        #6 [hci0] 225.962708
>       Set Event Mask (0x03|0x0001) ncmd 1
>         Status: Invalid HCI Command Parameters (0x12)
> bluetoothctl[26861]: < HCI Command: LE Read Accept List Size (0x08|0x000f=
) plen 1                #7 [hci0] 236.666394
>         invalid packet size
>         00                                               .
> > HCI Event: Command Complete (0x0e) plen 5                              =
                        #8 [hci0] 236.666770
>       LE Read Accept List Size (0x08|0x000f) ncmd 1
>         Status: Success (0x00)
>         Size: 128
> bluetoothctl[26861]: < HCI Command: LE Set Advertising Data (0x08|0x0008)=
 plen 1                 #9 [hci0] 302.700321
>         invalid packet size
>         20
> > HCI Event: Command Complete (0x0e) plen 4                              =
                       #10 [hci0] 302.700735
>       LE Set Advertising Data (0x08|0x0008) ncmd 1
>         Status: Success (0x00)
> bluetoothctl[26861]: < HCI Command: Set Event Filter (0x03|0x0005) plen 1=
                       #11 [hci0] 311.468582
>         Type: Connection Setup (0x02)
>           invalid parameter size
> > HCI Event: Command Complete (0x0e) plen 4                              =
                       #12 [hci0] 311.468958
>       Set Event Filter (0x03|0x0005) ncmd 1
>         Status: Success (0x00)
> bluetoothctl[26861]: < HCI Command: Write Num Broadcast Retransmissions (=
0x03|0x002a) plen 1    #13 [hci0] 321.421130
>         Number of broadcast retransmissions: 1
> > HCI Event: Command Complete (0x0e) plen 4                              =
                       #14 [hci0] 321.421552
>       Write Num Broadcast Retransmissions (0x03|0x002a) ncmd 1
>         Status: Success (0x00)
> bluetoothctl[26861]: < HCI Command: Read Class of Device (0x03|0x0023) pl=
en 1                   #15 [hci0] 329.832604
>         invalid packet size
>         00                                               .
> > HCI Event: Command Complete (0x0e) plen 4                              =
                       #16 [hci0] 329.833014
>       Read Class of Device (0x03|0x0023) ncmd 1
>         Status: Invalid HCI Command Parameters (0x12)
>
> ________________________________
> Als u niet de beoogde ontvanger van deze email bent, lees onze disclaimer=
<https://www.politie.be/nl/maildisclaimer>.
> Si vous n=E2=80=99=C3=AAtes pas le destinataire pr=C3=A9vu de cet email, =
lisez notre disclaimer<https://www.politie.be/fr/maildisclaimer>.
> Wenn Sie nicht der beabsichtigte Empf=C3=A4nger dieser email sind, lesen =
Sie unseren disclaimer<https://www.politie.be/de/maildisclaimer>.
> If you aren=E2=80=99t the intended recipient of this email, read our disc=
laimer<https://www.politie.be/en/maildisclaimer>.
>


--=20
Luiz Augusto von Dentz
