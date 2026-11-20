Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795188908;
	b=4qinRE70GVqNgj9hkwckTqJyw05No8UvwbLsEyHcpQfnLJUgW/beuSSz6PVaGKeZw35F
	 FHKTyQsa+vStbw8/Le+g24fXW3JtWkxaF0D/qblDNcEePSUVtQodYjvTrGxDnJPomDP7p
	 W3kecr51ZfrlE9NSxbc8RsnG2oVkfG1Y+a1tkNbgnIziO67VwLNoncjXBJJCNF0Rxt/AL
	 o11rC+QwrcHygYrkVHrgXLl3U4TU/FbfbIdTdtebbb/9+2vmve8pZiZtOg9ktYjQPBCxh
	 LX6Vzfy9a8naRrpuoPl9XoDV/a2FBb9Iy4CUHwX+gw/p3gjXNU8bFfk94duBJ3cG8tw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=kdvpAaIP0Ysil/5z88aElcWf9+zqSZ48c4IOxLoi6BE=;
	b=cgi3zBBrrmgJLjS1koj4EL/Ou2JxNCMIUD6j+196vrqEy2fZtRHs6Qr76qN+gYmlYcaW
	 3ynklMqXzts8QFizaMOwx8X1wktnCMM0SIBGhruRyILOxZSMZJNrG2u5vL/DASXPm0kd+
	 Clsjljb9Dkwd5dT4Ifw9ES5oD/tTaG1wcUsTihsMOgZ5bpf1+kdKbD2EP6R2OXJ4OFFmE
	 mGZCg1BXv2JADq/pFZQeCjNwrnS39BgJThwfTiJx/1UXWHVXHL/5/WU/fDZxX81qo7D6l
	 QGZbRzzhAV6XuLOITe7eWRp4Sbfn81/PUjhbv9INr4OaJRyfhQ/S2GIKDXVJKKtsrcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=coV7ahsv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E78606A320
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 15:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71E78606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=coV7ahsv
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-679a2b5fe87so1079579d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 07:35:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795188907; cv=none;
        d=google.com; s=arc-20260327;
        b=KXE5uMEgTI8AvnL66grocIgRuTaeLd2a+1AYQMZyndeiJQqXb9wbTjQo0r0r6v3ZWz
         sbczpET9Y3sQYY61UQmua2H9/0xHBxpAg+n98ekdgQNHcm+7SZ/sC+oZvKB5GodguMgF
         w/q6FLZYT2kIKw7CnBpYCqde2A5itOskzMm8ZZxPkhaDADecTPw7sk8c4GX8hrPX95RW
         FiqP/LzsqY4NYne0un/mnjwrgKQLtER0vB24ZwSkVuESuj3Nvxjx9E4O14r8LJpDyS1Q
         g0oWuU42YTM4vtuAQh+wr9l3bTE9QtSZM0TR8hlGwgROSpqlv8oz7p5Np+l/a5LZxz77
         ZA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kdvpAaIP0Ysil/5z88aElcWf9+zqSZ48c4IOxLoi6BE=;
        fh=fJTvNhOwO3AM3tYUbNMUqA+BVc/up3gAa8zqoR5nDD4=;
        b=nwGSGBcM6rZF3NGdoImBgMSYthDdwFXqBkW7kDum06nu13sbosNdoF6y/bs5b5jvPb
         tNcSyWLFS7FEehvm4U8yAA19nN1KpRG5+kTDJRv/IH4/bePsrsBID1w4aZPsnmCYzE5T
         r2LM5iFZQUgKOB2UDWbdrhC2UuqvxV1QP3tNCrx1/KZPOv+bgI1PsS9pSEwud7SwAbXN
         evmDPqqc7zC/LhUtEs/z4XqE4wTQX9Frc6KvBusJ8TkI2vPJ2uZ7WGOwA5K2b96cVBRm
         8PBQmP47cDAn4gU3uAgpft9W15gTvfUeT+SK8x+hKYk2mUwECT6NCE0T50BcLTWb8j6T
         /JQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795188907; x=1795793707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kdvpAaIP0Ysil/5z88aElcWf9+zqSZ48c4IOxLoi6BE=;
        b=coV7ahsvQwWamKZfGGqJn7bh5NNkOEnaYNw1ForPi3FtdcuoPoVtAaKclq2f5MevR6
         aLTkax/OggVudzfnxCtU250SCN5xxo5AiTo/Is/JDdY+m4orfMCFdX1nYlWEv26Ro+Z2
         6NDxoIpk5j7tQpoWFK/AxpvqH077U9SuCfD/JNytscD1fiW+3AhrGJgREHCEwAumPl+s
         +WnNNC/8LS+SDo8pAz81458iqIKvggnCX+jxXJQaMOj9jGJ855PRi3ABKaXK+pDwPJ5G
         8BQXN5diykO6cc5mU4lnh2xZc/8gGcNpbxIoKKjnKjVai4FS0BL4UXU4kOsQHAS5bQe2
         52wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795188907; x=1795793707;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdvpAaIP0Ysil/5z88aElcWf9+zqSZ48c4IOxLoi6BE=;
        b=D6XSMnnb1XzPOr9PWidgnmQh04iq398ENCfxwHOlMm+n+UsiSGmJafeiUA/dctoYQM
         UL2Iz31/jhTUhp7ZbHeIKi2XKm1LdeNe+/MH+tlcbkrNVX/ZlTpBBc0CJebaPM9FFR4K
         lZ5ZQ0ynO709JbhUXQG0wcPZ1uo39D5FjD82KWKWS8QnM1reLDNpilmi3Q7P/G1sGr1y
         sFR9rQYPrOpvFD0ET44aY/lE8Y//vTQTfuu9+DmB3RscaujbdGC8GO8wodvMqqgv0mNj
         n+FDScHaCroBPAV95XObqr/AfSTOjihh4zH/TVsFNG8PMqmDCHv/n5Xi7uXBcnRWyc+E
         sZmw==
X-Gm-Message-State: APuU4Z/65M49dnMLhBMhivEtvTVTsfR9HfCEZ8w/cVABcHgoR0FjhhfG
	DOph/mPjiMDz1jcCKzCOKD58q1HthW5ZbuE+amGIIvGpoTvMOQwmduSEA9WoSQbmdYc+/4yZtZK
	l7dYDhF1Bw8CCbxlY3VvywVCNzbMHC0Q=
X-Gm-Gg: AZFdTZd44d3bWxf+vSA8KVDZedQ5taCU9YgfJPlPXCu17koEI0U26LnUkfjrfYoMubo
	8wFKP/4I65eEL8/mogbDCJPe0LbP7X8AYsoPyjJlOCKfpisGDiWVJ1G63/7LHQEfuSiSZZMubO6
	Ex1nL113T0APT8e1w2H3i55ilFQYhCbWp9QGAqKa8mXCyUMoh78wwFnC6GZkFkg46Vk/LJDTpf2
	w9cNErfbVOPT0t9mmaxmyvrP5lQM0gF3X4s7uIz8zQTwnOrMjkI8QrH6RLo7o1pE+xxdrkAEA7/
	nhMITFA3dKhS2sjiRDquBjmeE1k4iwSWltC/6tYKbQznrzRU4YHe+sER0nwsOvINTnSRYfQJccN
	7Jpe5CJLMioPJ+LNfMGhymmXAzmGYTYjTRqkcyvkYoEA6Ea6bqqKn/JV50ebIFJHXU0H/7lJxlo
	Xi1UMsHvk/+H6ItAB1e57AWQJK/qqBEv31oyGjhcFAhoKqH8oyiF44pi4xgC8=
X-Received: by 2002:a05:690e:bca:b0:67d:b1bf:c41f with SMTP id
 956f58d0204a3-67df449b3acmr1125999d50.93.1795188907226; Fri, 20 Nov 2026
 07:35:07 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120063856.16585-1-rolandschober1968@gmail.com>
In-Reply-To: <20261120063856.16585-1-rolandschober1968@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Nov 2026 10:34:53 -0500
X-Gm-Features: AclHuK9o4N6NczLI95brlB1_AcM0isW-Z4lA3hsQfGsPK6Ruc01cujj4zuMfLvk
Message-ID: <CABBYNZLhuiDu38Sf4KD4Cca9KYDGYNxLPaHQHoF_39je+A3Jyw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 00/10] monitor: Decode Periodic Advertising with Responses
To: Roland Schober <rolandschober1968@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roland,

On Fri, Nov 20, 2026 at 1:39=E2=80=AFAM Roland Schober
<rolandschober1968@gmail.com> wrote:
>
> This series teaches btmon the HCI commands and events of Periodic
> Advertising with Responses (PAwR, Bluetooth 5.4). Until now they were
> only listed by name in the opcode table and the events were printed as
> unknown.
>
> It is meant as the first step towards supporting the PAwR advertiser
> role in the kernel and in BlueZ, which is what an access point of the
> Electronic Shelf Label profile needs: being able to read the traces
> comes before changing anything else.
>
> Patches 1 to 7 fix existing decoders which the new ones use or which
> were found on the way:
>  - the Connection_Handle returned by the Periodic Advertising Sync
>    Transfer commands and by LE Remove ISO Data Path was read as one
>    octet,
>  - LE Periodic Advertising Report trusted Data_Length and
>    LE Extended Create Connection trusted the number of PHY parameter
>    blocks, so truncated packets made them decode octets outside the
>    packet,
>  - the LE Set Periodic Advertising commands printed the advertising
>    handle as a connection handle,
>  - LE Periodic Advertising Report printed an unavailable TX power as
>    127 dBm and named the AoD CTE type with 1 us slots AoA,
>  - LE PAST Received printed the handle twice and decoded the clock
>    accuracy as a BR/EDR one,
>  - the Sync_Handle of two events and the properties of LE Set Periodic
>    Advertising Parameters were printed without byte order conversion.
>
> Patch 8 splits the LE Periodic Advertising Report decoding into
> helpers without changing its output, so that patch 10 can share it.
>
> Patch 9 decodes the five commands and patch 10 the six events,
> including the [v2] variants of existing events.
>
> Testing: I have no controller with PAwR support at hand yet. The
> commands were sent with hcitool to a controller which rejects them, so
> that btmon decodes what the host sent, and the events and the
> successful command responses were decoded from hand-made btsnoop
> traces. Every command and event of these traces was also fed to the
> decoders cut to every length, in a buffer of exactly that size, with
> AddressSanitizer, which found no read beyond a packet. The output for
> well formed packets of the existing decoders was compared with the
> current tree. I have no big-endian host either: the byte order was
> checked with a btmon whose little-endian conversions swap, on traces
> with the fields of more than one octet reversed, which has to print
> the same as the normal btmon on the normal traces.
>
> v4:
>  - Add patch 7, and convert the Sync_Handle and the properties in the
>    new decoders as well. Copilot found two of these places, the test
>    described above two more.
>  - The fix of the LE Extended Create Connection PHY decoding no longer
>    adds a size to a void pointer, which CodeQL reported.
>
> v3:
>  - Add the fixes of the advertising handle, of the TX power and CTE
>    type and of LE PAST Received, and print these fields the same way
>    in the new decoders.
>  - LE Periodic Advertising Report fix: also report octets beyond
>    Data_Length.
>  - LE Extended Create Connection fix: report extra PHY parameter
>    blocks, and do not report the remaining PHYs as unknown after a
>    truncated block.
>  - Commands: reuse the [v1] decoder for LE Set Periodic Advertising
>    Parameters [v2], print 0x00 subevent timings as none, check
>    Response_Data_Length, and match LE Extended Create Connection [v2]
>    with the events which complete it.
>  - Events: Data_Status 0xff keeps its reserved meaning in the [v1]
>    LE Periodic Advertising Report, LE Enhanced Connection Complete [v2]
>    is matched with the command which started the connection.
>  - Commands and events: report a subevent data command or a response
>    report with fewer entries than announced.
>
> v2:
>  - Add the fixes of the LE Periodic Advertising Report Data_Length
>    and of the LE Extended Create Connection PHY blocks. The two
>    problems Copilot found in v1 were in the [v2] decoders, but they
>    came from the [v1] decoders they reuse, so they are fixed there.
>  - The patch which splits the LE Periodic Advertising Report decoding
>    keeps the new Data_Length check in the shared helper.
>
> Roland Schober (10):
>   monitor: Fix handle decoding of status_handle_rsp
>   monitor: Fix data length of LE PA Report decoding
>   monitor: Fix PHY decoding of LE Ext Create Connection
>   monitor: Fix advertising handle of LE PA commands
>   monitor: Fix TX power and CTE Type of LE PA Report
>   monitor: Fix LE PAST Received decoding
>   monitor: Fix byte order of LE PA Sync Handle and Properties
>   monitor: Split LE PA Report decoding into helpers
>   monitor: Add PAwR HCI commands decoding
>   monitor: Add PAwR HCI events decoding
>
>  monitor/analyze.c |   1 +
>  monitor/bt.h      | 174 ++++++++++++++
>  monitor/packet.c  | 590 +++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 711 insertions(+), 54 deletions(-)
>
> --
> 2.47.3

Copilot flagged more problem:

https://github.com/bluez/bluez/pull/2855#pullrequestreview-5995150018

--=20
Luiz Augusto von Dentz
