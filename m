Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3052798EC
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386045; cv=none; b=btPm19T5oG/sulGQAYrrJc7h2Qy4BSCDGUDNcfsYLubvn9ruJVhAqA3DN18gk0Hz3VOruGsfQLofMPnmqDf/KlHz65K9M5zOo41RANiLJgg1M7A34gGtvAPZR3HYVtWwCmVHtI/vjw9TsYcxXpovwaOpB/ylQPV/NmiSFtWHveY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386045; c=relaxed/simple;
	bh=+f/gAxcIgaOXuhpk5Diy1+EcB09f+EB8SmE6WjGD/pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qs1ev27mnl1AakdvYjEydC1kAgyv1Es3Mik/CCXTAucudF+DQrMp5K69TNLzEDGNAnsToolDowSl2P3XzptLg+R1mQ8ofFRUiMjAU3ptweEVJgBVZqZd9PSDKM7nKMdalapkXdrqwPHuh3Hedo+W4BLHXHlH+Xy7BEJNsmNH9Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K15HC6Mj; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K15HC6Mj"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32ce252c3acso17823831fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jul 2025 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751386042; x=1751990842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znw+5EzjcZ7kjyGjlA7JDjYLoRPM31z1b9zkf15AT3s=;
        b=K15HC6MjzfZFNrnQQicArYz6elhZBK+lpBWgqIf8unVNEp+Rdo/jfXe4jTOUvgVuYb
         sdPJyEtlJTFUsoaK4BCB51SCCIGhIlsCeUlcLXE8vRykIjiZV2Zir0NoAr2lzChCeW5+
         swnwa/8BzdoG3MnUMDwQuSIzkx83EkXvgD0uF1dcVPFn+Q4Z5wrNobkT9VIo7Our9E3Z
         X94tgx3ay9cjMqKF06rBonbnFJDytniW9m0GxeqDgEKqLEZPkqO5a5OBqEYG+ciywoiz
         2QemEA0b4kmQtgTIEcAnqkm15OF7r2rlvNB/RCraZsEgU4cF7L4BQ84uujhJ/vaurm+b
         +q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751386042; x=1751990842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znw+5EzjcZ7kjyGjlA7JDjYLoRPM31z1b9zkf15AT3s=;
        b=tbGhkQG81VpyLF1TndyIj4rTCdzmz9/583ipBiSYVh/rTy5cY2dpskWiUZ/EOCzTkL
         DmYhfrZqWY7fw6aIC5gKLHG87RSa3lO3iUbQoPlGf5lwZuO0GKx+CiLcrDFbNOuUm9Ny
         qjy85PeIUKYuyy5uicAqo7zspG0BaPWxgFBVMYYiUizWAzI/U2ctI7eJsYehPYCDki1U
         lgt2yOYXzmV4xQmmp63UkNfgrCVXuVCtg/d0YZ+7Cw/56+O4vLDtt1/PwG+kb7nMdNaO
         qIOE+3E0sk2cQcVAe+AlfaFfnFopPQ0fTzkQOT1G2nS2J+YBgfEqcE6GK6GGyUir0Tw1
         qsJA==
X-Gm-Message-State: AOJu0Yx2DckTzczh3s5ZnAPJ3EiK/M2eNJ2jyjXGbEZY+usk2v9JcMps
	+XUd471Ev2+KU+xqrpRDfvkM6yrMhBIUbRaSNaFzPnPm/JEvMTXAbz4IJk/B4yJAiXe2C2ng62v
	DTjVPzZzN2/9wAwu1Xxv/6XNqWIay1/I=
X-Gm-Gg: ASbGncvM4iafIbhNE5shh63B9ccf0a96D0LCnDnHHdQ4ty6abmpJ/W/k/cWSZ0+amEd
	M2ZBuQDydUkajY1slWjqMV1N6Z8DbG+RlHTHudijMrrUkxxlu+whfKd/w8d+ajBt1Xb1oxRnSyV
	k+8trPOswuAs6v8LyCZyPJ5vxW1+eb01WiyRNULmalAQ==
X-Google-Smtp-Source: AGHT+IF3wQqIcxWwTDW13mZysKs25QSogBko8Wgtcr9UYRd9uLRx4fwvKgExO3Xnppb1OyplSp7DPcXxEwRmsZOIVGM=
X-Received: by 2002:a05:651c:3059:b0:32c:a709:80ee with SMTP id
 38308e7fff4ca-32cdc517bfdmr41332471fa.39.1751386039682; Tue, 01 Jul 2025
 09:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701144647.19572-2-ceggers@arri.de>
In-Reply-To: <20250701144647.19572-2-ceggers@arri.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Jul 2025 12:07:06 -0400
X-Gm-Features: Ac12FXwlbBQNIQCXoGV2fPmG7grOZdUxjJsAmTkN7m2bejhQSRd0itS971eGFn0
Message-ID: <CABBYNZLUu3KnXBOeCkWHtpG_es+yF7vzXjd-fOsHv-S_UMWU2A@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ 0/4] Initial support for GATT Proxy Service
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org, Brian Gix <brian.gix@gmail.com>, 
	Inga Stotland <inga.stotland@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Tue, Jul 1, 2025 at 10:47=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> This series adds initial support for the GATT Proxy Service feature.
> This allows provision and management of MESH devices from mobile phones.
>
> Before continuing, I would be happy to get some feedback about this initi=
al
> part (and about what has to be done in order to mainline it). Any help fo=
r
> doing the missing features (e.g. relaying between GATT and ADV) would be
> highly appreciated.
>
> What seems to work:
> - Provisioning from another Linux computer via meshctl (sometimes I need
>   to repeatedly enter 'discover-unprovisioned on' and 'provision <uuid>'
>   if it doesn't work on the first try).
> - Reading the composition (composition-get in meshctl). It looks like
>   meshctl tries to connect to the GATT Proxy Service automatically after
>   provisioning, but I have to enter 'connect' several times in order to
>   get a connection. You also need to manually set the target unicast
>   address ('target' command in 'config' menu).
> - Adding extra network keys (Advertising for GATT Proxy Service cycles
>   between different network ids every 3 seconds).
> - Transferring and binding of application keys.
> - Using the OnOff client in meshctl (you again have to set the unicast
>   address in the 'onoff' menu).
> - Provisioning and configuration of an OnOff device from iOS (using
>   the SMART+ app from Ledvance). This app requires at least basic
>   support for proxy configuration messages (patch 4/4).

Meshctl is sort of considered deprecated by meshd, it was created
because at the time bluetoothd and meshd couldn't operate in the same
controller so we need the GATT client to be used against bluetoothd,
which is why the whole tools/mesh-gatt is sort of duplicated from
mesh/ portion, but now that there is possible to have both bluetoothd
and meshd we should probably move meshctl to be a client of meshd
directly and then remove the whole tools/mesh-gatt/ directory.

> What maybe added later:
> - Proper selection of the output interface (GATT vs. ADV) when sending
>   messages.
> - Relaying of network messages / beacons between GATT and ADV
>   interfaces (in order to access further devices via the proxy).

Afaik the tools/mesh-gatt does already relay messages, but since it
has been a long time I don't deal with mesh perhaps I don't remember
it correctly so please have a look.

> Note: I don't use the test-join script, because python3-pygobject is
> (currently) not available on my (embedded) system. Instead, I use a
> custom C++ program for the 'Join' and 'Attach' D-Bus calls.
>


--=20
Luiz Augusto von Dentz
