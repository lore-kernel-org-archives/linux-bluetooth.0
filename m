Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346441758F
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899820; cv=none; b=N5Hss+j782LxLKbkLJAo1qhHBKe9zYHHvu2jdP3KQFASdIvd7w+EJ4eLLujrZJzDi52McpDFUTXfp6Y/vlFu0dc/OhONevDt1HLF6Q7lYDAhUmMiRszxAi79j6VNYc20YhDwsygASG26Fdg3M1rYPzjxcz8zZd0w/n0/X4HLQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899820; c=relaxed/simple;
	bh=AGS8+8zP9Z+g9AhLV7i9KyBHYjuUvkaoU7uy+LPiBH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxFEyOaFfwhJ4PS1H27EgCApUF+//hYDEF54QqrQ4YFEv+xLPv90xPXtiOFXZhExhg81zrO91AYvmhsHYgfG8xRZc1ILqejSQ1yOXHnlJq3+JjJXv69sGqVuPEPEmT+nbNzihYFryifnAS/RO4cq15emED6wvK+Lkqgu7YPhVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsCAUuFs; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsCAUuFs"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c35b72f943so38885006d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Sep 2024 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725899818; x=1726504618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAbOBcE73gbZ/dq/POFpa2HDrqM0cRL3Kjj6Ygo6spU=;
        b=fsCAUuFsEyXMk0bGIQHaaDWh1eBb1IfxAMYtrhJQIS1J3AIPhPS5j+9vESFHPWaI0l
         Qk/9zN6dNnuln1M6H1PTUgL0ewuOyrEWpgezSjlqXTE5SZHyLL4ePP2CN/SfzDa/aafw
         UEbyZubtoPfD9Mf5vcxm/po0sSBcT5VHyokzx7OCtg33UGkVJUgtF5VdqVz9veMNdhJR
         MmsGK83JEDA2fIxVBsos0ybbGkSR6jcM/IiqKZT70KK4tmmDb8mfAnaIJbsp3J5BaDi+
         SL+obfup8ywqmiJG6JYdUGNLqVrjmE2SynzIB5UC3OMmzWauvoPICicDYSJ5MA+bCkao
         RElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899818; x=1726504618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAbOBcE73gbZ/dq/POFpa2HDrqM0cRL3Kjj6Ygo6spU=;
        b=czLZVVijtqJ7m0XhPEIZ19bOF2Jmni3EB+rMUWsmCM3bc3A12XlKK2MEVIUc+dwqJD
         ly+7K2spkNZnlE8Q8z7rnBLWrnTIXmiQuCmlIcBVJaL9vqGsqAlkVkkYOFOibW1TBtGk
         qBaH6vhbZbfo9JOj+8Ykas1OzrpSZ7O6RALoXZfV7icgjytJhKdXdwiWUY7bPVGdgwwo
         TmlE9kXWWgEhdfxM6rAKjsy2czjQskpCy0R9A36PvhnS/TVOdUl5JyOUW+rxqsJBF3y3
         SH2NvcJ3NuwD5navZP499Lte0aXuhPPYt5OccSUHcTT/1uRMinWb9oFIVsV0iG3FFGp5
         tlQQ==
X-Gm-Message-State: AOJu0YzEkMMNu7y0BchI2WfM0ArtmE6iwwu7LTzlrv42ElIPxq4NFF49
	82yXIH06yKN5juEPsS/Cf++n4MrVM1oZuJTpyKlYIrOCgnVPveZy7oFazFX9kUL48lAYFmRH9Ad
	23fo4zCe6+QI/Hg9c9H2KKDSmHwccuSDS
X-Google-Smtp-Source: AGHT+IGG38sjPHAGjltSQqdfRy12MFasloJXOWrP/nKNUncseeeohAcEWYXBbG6Ve6N0qn1poSHPrpTSgAviVYcZv4Y=
X-Received: by 2002:a05:6214:3b86:b0:6c3:5454:6e1e with SMTP id
 6a1803df08f44-6c554d6ffe3mr3131256d6.24.1725899818014; Mon, 09 Sep 2024
 09:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907204941.8006-1-vibhavp@gmail.com> <CABBYNZLVcMqXVXeWf7pSX50yRQNP-NMTUP-u91huuO-kpjU7ZA@mail.gmail.com>
In-Reply-To: <CABBYNZLVcMqXVXeWf7pSX50yRQNP-NMTUP-u91huuO-kpjU7ZA@mail.gmail.com>
From: Vibhav Pant <vibhavp@gmail.com>
Date: Mon, 9 Sep 2024 22:06:46 +0530
Message-ID: <CA+T2Sh07fL3jq5CnCK9ZxjUtK8pNkm73ft+VYn3T-z_BZZF+bw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] device: Add ConnectionType property.
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 9:00=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Vibhav,
>
> Don't really like where this is going, if we need bearer specific API
> like this then we need a whole new interface, besides you didn't
> really explain the reason why you needed this, is that to determine if
> there are SDP records to be fetched?

ConnectionType is needed only to differentiate between LE and BR/EDR
devices. This is because the NT kernel creates device objects for
every discovered Bluetooth device, and BR/EDR and LE devices exist
under different paths/hierarchies (I suppose the equivalent would be
BR/EDR devices existing under /dev/bluetooth/devices/bredr, and LE
devices under /dev/bluetooth/devices/le). Essentially, BR/EDR and LE
devices can be differentiated in several significant ways, and I could
not find a way to reliably do that. The current code checks if
AddressType is random, otherwise tries to see if the device object has
org.bluez.Gatt* interfaces to determine if the connection bearer is
LE. However, I understand that's not reliable, and doesn't determine
if the device is connected using dual-mode.

That being said, Bearer does sound like a better name for the
property, and I can modify the patch to that effect. However, I don't
foresee the need for a ConnectBearer property for Wine. Ultimately, my
goal is to implement Bluetooth functionality with the minimum possible
API surface added to BlueZ, hence the small (ish) patches.

--=20
Vibhav Pant
vibhavp@gmail.com
GPG: 7ED1 D48C 513C A024 BE3A  785F E3FB 28CB 6AB5 9598
