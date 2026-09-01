Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04EC2D6E5A
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282226; cv=pass; b=frE014OeS1QoSLl2w3ZFqKQSpR44sX9BxRY+UITJ3oDF3SXUXFQggmUsRJtGSe5kz0xLPIH0PrpjpmDGwy06xHl+jtoUCoXkeof5tahgSvVm3ivUjpfbKtv7dF2kw24JwbiG3EJ5K9VGB5sUV/gRtj4yy/qCfHVBE7VRAbowJSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282226; c=relaxed/simple;
	bh=GKlx4yvSnA6UqqKK/Wzp+ZAjm9oSWTZzHZEpluwBDzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rz4G4uIJ32ftjrBKRa3H563c4HA6RpRix5iO+/B5j/D43ZdU4hZrfMsP77RPAeMAmPe2FH/NAwmI0kVG6kejYcgLuLT+ZHrsomY7jzhz0O9sxZWh/kbKpRxU+JdUKAbHpeD2HQuF2PFK5TsHF0MELxknpgQpG4iPf1j6HJ+04AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwcLyBel; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwcLyBel"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-855c26cf490so2334287b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 10:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788282224; cv=none;
        d=google.com; s=arc-20260327;
        b=o+kPCdbNyx8hxXVK1JHiiE3C2XDHLmNe7uYbzTxkMupUQRXpeCnir2EU8ujJKALDVM
         WX6TrP2rOI9Q+KJpLUpPnfhmixCYoyW/po9XXaL3Kf9RRmKNTsi62v1IJPrPy9tBafhu
         32h/opROs1XkthJgsTJ6ERhReei6OYc40pkMNGnvvTK3cDVSe7Ru/Qhf0EzVLwxHTkmk
         ugdh5nPISLWj61RFiu3ma7g6jImrsuOnHC0HXadZwHhx8Z04RG+P5vYzQjjpiAOfez6f
         Go6ga4GqAHOolNbCUiGKg8gsAKekvtAq4zAgPBYFMZBxn3pov8QGDFzVXp3S9+FxN2YK
         AYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GKlx4yvSnA6UqqKK/Wzp+ZAjm9oSWTZzHZEpluwBDzE=;
        fh=9cvoDK9JtW8iXrFg0AVniGf0OCcOJKRU7oLJcpNV3aU=;
        b=qz9Jp41oHet+sPyeq75HOi9osLua2NoDbicbQve140O/692eAeGhZY6NQ4KRDXnpgX
         ZnF5FY81WdepBIz8jaSIDHTS3F4rl0HBEwRh75u9studx3H+8kS70u+6x8fm5hRhNoCI
         z2ACZ0HKojM1+bKkEEXgpe68xY29aHuTLGGRljHmbCXBdM4GShZ0PEtlcThqyEQZaj1R
         FgsjOkMSoGaMI828F9UokKRgjTAEarX7qmj/B09BuZEbs2z5F6WSbHdjKmUm4W9LDWBy
         3Pys1VPzJRtB1X1j/OxDyUr04YiPYSd1gtx8iBkHG/ajTOkDHreyc79bjmyxaTNlkqGT
         zPtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788282224; x=1788887024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GKlx4yvSnA6UqqKK/Wzp+ZAjm9oSWTZzHZEpluwBDzE=;
        b=fwcLyBelYaiGU1OEybOsSChJVV+4QqVRFyA3Q2ZWfkn6ZrzdH4F4jscCKyXG2KRDbW
         ujFWrtrDGk7YMJvRhKvUFV4SLXmTPleU9gWlwJs8DodOHN+EzGcQkRWZL1CrBFmF0A9j
         AR6gKjonA8gp0FCGg7GiK4fzMKJ37A/PCMxs0JTxBShspKG82i9Sk865DNa6HY5iGBNu
         YgA9no14g9Nemr8nrVSqGJd1dfc1Fl8jY2KFXuAJm7KImna4sIN+AcQjwiPrN+I0UH8f
         ZdD4dJ0xm0eLBoKy1WIUwJuAexXSNAGkEBxnXLG7pglHbcW5jydVou8mzQPtzNeazjJ5
         P8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282224; x=1788887024;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GKlx4yvSnA6UqqKK/Wzp+ZAjm9oSWTZzHZEpluwBDzE=;
        b=IYIsOvVkGMstXBgxHqrFQAEybtwzKoiOTD87f+rAQ4amAAVUFmtMpbCBKOO2miKeWJ
         2RiMoiUp+5HA9lPWe6sEyIPh/Kau+evkTI2m7hGr1YXCcXk+HoaObB9f0v7EJ2tUgykl
         9LLEkN/WJzjfpvwnFa7M6BIBFeD9/dDE+N6A6ZTaKYB5YJWhIKwaPhMsJvI2PasdMzgt
         7BohqLiePJ4ucXwVe296I5fuR+SopWA8dc2BHHgwazEX68YX1s0zQXktA6+y9OFlk5fx
         RWBfxz0mKdl+ZZPe0U9HbHG5WV97p2CRTBjsyIcYygfdv5KORiWsIRb62BrYFqzNCcNm
         7TiQ==
X-Gm-Message-State: AFuF++mkrtqO6J/zUCu1WAIr8Kja6rnjqr3HR4vDz4tm558FW+FpYdol
	4wJn1xqCak4atlFYeb3RSB5Oq0D4PDEwMuvqyf3EvET91ccQ5guhOAfIBrgTmgNj8lT/ZmALoni
	X9W7QBrAiOxa3xGi6hrVA/uLUOFwF5p4=
X-Gm-Gg: AR+sD12g4G8a7u7GXI9QZAcbIUVZo17ZakRi7ciFU9Hvway6D9q2+3oN1TdeG1g4PB5
	rfyzLNO4Km8X1sCXgLjvWN9xk+8easzgN5dcZDZb9qLX3NnHPY0q6/34b4GyWv2VzuaUkbxa7s4
	TCgaV9Ik5HX2WsNiO5qRqsJ1BVYAn8SVWEu9YeAptbyOKEvB3/7Mbn6nnvSA/LJelIdy3UMlXJ0
	FHV5TWN1tMx0I+2SHPyNHss9X9Ing2pICS1kggDsEjkL8JzUAqrYGYAJnTA4SQ3XGbAn8NjrkBm
	unzCfn9zgvC4F0cPeuQr1JgF17rwVQwgV+KM9CEEtlpLyz21lUERZcMFZsotIoK3ZCnOJXCykzZ
	yyT/pTy0GDn8qBVwaGX2N59iTug7dZdgLpCgE4Y7ZOA==
X-Received: by 2002:a05:690c:4005:b0:841:8f97:e8cb with SMTP id
 00721157ae682-85d6cdc2671mr117031457b3.17.1788282223554; Tue, 01 Sep 2026
 10:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787327795.git.m.kurz@irregular.at> <CAO=2mx7zXHmahddsPMaDAZ=2zOdonYOE2nvJB__S6ORU_by3-A@mail.gmail.com>
In-Reply-To: <CAO=2mx7zXHmahddsPMaDAZ=2zOdonYOE2nvJB__S6ORU_by3-A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Sep 2026 13:03:31 -0400
X-Gm-Features: AcwNN1UwMHraicmOhTcjM9gWSRJszP87K2Xbro0MdxpOY3fTFQ-e8fNZq0dR_EE
Message-ID: <CABBYNZLBvSo+gM5tjRL052tuhj+Ki+Zb7KucAWqs=2nszreoAA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/4] Add component batteries and Fast Pair
 Message Stream
To: Matthias Kurz <m.kurz@irregular.at>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

On Tue, Sep 1, 2026 at 12:34=E2=80=AFPM Matthias Kurz <m.kurz@irregular.at>=
 wrote:
>
> Hi,
>
> A gentle ping on this v2 series. It addresses the feedback on v1 and
> was tested end-to-end with Pixel Buds Pro through UPower and KDE Plasma.
>
> Would you have time to take another look? Please let me know if I should
> change or split anything to make the series easier to review.

A full review may take a while since this is a large set. I'll move
the unit-testable part to src/shared/fastpair.{c,h} though and have it
as a separate commit. Regarding the test ID check, if Google doesn't
have a set o test cases it performs for certification, we can mimic
those as unit tests.

Btw, these device would only use fastpair to expose their batteries or
it does expose them as well via AT command? In fact it looks like HFP
1.8 has introduced support for battery indicator:

https://learn.microsoft.com/en-us/windows-hardware/design/accessory-guideli=
nes/bluetooth-accessory-guidelines/bluetooth-accessory-guidelines-battery-p=
rofiles-services

So I'm not sure we should go with the proprietary Google FastPair,
which is probably only really meant for Android, unless it is the only
source. Also, are you going to be available to maintain this code or
is this a one-time effort just to get it working for your device? Im
probably not interested in maintaining proprietary protocols at the
stack, so maybe this should be pushed back to some other layer that
uses RegisterProfile and just registers batteries from an external
entity. That way, what we would be left to do is just to support
multiple batteries per device.

--=20
Luiz Augusto von Dentz
