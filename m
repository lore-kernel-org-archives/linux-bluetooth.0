Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B231EA7F4
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747673119; cv=none; b=sYKseUwAosEbeGCKHNPrHLk9Tl3jSBPYlxNSRhjQGrWTZrPuPQsi9aNU+XKZAnM622grn8lnA6IEdk2H1BPuFWMP3owICX1kmkALrC/rzmlwbyAIxyq97L+hagSNYqv7UXciK+hHHE72t12mLAT4CxZtkQG8sHhubd97avPFO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747673119; c=relaxed/simple;
	bh=zrizK59M+HuC9tOvi4uUpKsvOZUr7Dq34/6iL43Q8tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXcq9zGkClRHM2uJJhogcNMRSszbJhnBrINow7AJAQFRQMGJF2Dt4lHny7ldVSWdf006394qq11z81K61xPQ3VBVF/kv2J8v7geJM9dL4gJOHSNqH4Y3horB/nOJVwSqvIy11Z2mxibnAY28CRrAUVFRGCE2wxgzuDcs9hlpvG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX+yjFSl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX+yjFSl"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5499614d3d2so5712619e87.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747673116; x=1748277916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fqpIRWmDm4OV5/hVF+4Z6n8N/S4bydkb3gVSrwpyrU=;
        b=SX+yjFSls6AQHzi9T7S9Zp66L21cOH5qE7n7xID6Cbk+Pkj6SqFSIHC+xSos2BO5pL
         NPtNAntC1w8vesbxHu9OZqhDo6RxmfIeGlFnvcR6yr0/S0yXDTJzBOYlwSoh//Qnzj+n
         +AVULXLUz18at5XmQ829HpngJSBw9xXMq+tiWUp4xojUdWp8HtkKrEX0tms3GasXRIMN
         hyxLjsDeJZPY2f/7ahKP02Jo9qN9gn9aEgX/AvrLgFiYoBRqmSidHJbgF4lp762oczqN
         IybN8PghdRy41uty19XRYLOh1cVO8udsC+tj+yTNEnQd9GmpMTVlK6FxcyILSQzYnYMv
         vXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747673116; x=1748277916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fqpIRWmDm4OV5/hVF+4Z6n8N/S4bydkb3gVSrwpyrU=;
        b=Dv92X/3BE6NgovyGy3n0BpkrE/TGzye/Uqy5+kLpf9+ctsx2frctyca1vXhI2tBIA5
         CsxxdK180DmkqMasFvH9ellI3KWmcQWdUzSHHrIu2tc8XPdGNdCt3hLiNU1TqP0Y7Nj0
         g0NgxENd5obNQ8p+phGGTYY7wx6N3wK0MJXXIeSUus8l0nxJOWwOm1vAQx0K+Suyyuek
         6t9x5bsEvS3qutDSWuqS5V3F6NSG8UXXb6n9IPFRyvoqKzsEAilpF5heem1IhcjrALsv
         sA/lW/8WGkWrpG4pulUD4YQjDp96Lu1pTmrz44K/HxZecPNvcl2PIB8pxFaHD23YAgsB
         lBbw==
X-Gm-Message-State: AOJu0YxK2G8lCFDJMt8w1SW2cMN3RBz/FPxH5u5bafCYqyP4g/pLVXYr
	Q353j6bkK6KQ4krokwsHW3oRMdAvuXRxus3Zcxge95wKsJ6R5P7Dgp8u+CsGdDhkf2dUJkLzTFu
	tePldUMIFWuRitqVr02aMCWFvAT2uLVi9QK/7nN8=
X-Gm-Gg: ASbGnctLUGA0KCO2TgcWtGT1acDstY85drPnk1dY8X2bFPnUwEFp2UF1pYIanyjpDXx
	0VaPlzuMwYRGlMY9/L1MBpccuwQZv7cePgFQx3pzPJKl2Ac+QCVwL+dJDen5D6fHV4+4EcNUcy4
	uQO5IWKahECFZT3h4oerjWcjHFWbLMqnKwHmVKOoHPFw==
X-Google-Smtp-Source: AGHT+IEfB3Koov89PPahbx9n2d27VKEFAYOnVR0KiwOE5GM7OzEgUk4KTgDWhPmR0ww+6bP+y7oc3WcRvxwVnAQ1DtU=
X-Received: by 2002:a05:651c:304c:b0:30d:b8a5:9b8d with SMTP id
 38308e7fff4ca-3280771d53emr40425191fa.16.1747673115815; Mon, 19 May 2025
 09:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519161412.107904-1-frederic.danis@collabora.com> <20250519161412.107904-3-frederic.danis@collabora.com>
In-Reply-To: <20250519161412.107904-3-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 19 May 2025 12:44:52 -0400
X-Gm-Features: AX0GCFvbTMQagaaLG7tv09bN6aoY0MHy1pwzssJBb0Al2uDFF6XFm0rVF8tn7DA
Message-ID: <CABBYNZL2LBBSMvBDONLf6H8-re26YHKBxsnQwNbX8kNuiq8m_Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] doc/device: Add Disconnected signal
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Mon, May 19, 2025 at 12:18=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> ---
>  doc/org.bluez.Device.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
> index 80501eddd..6229f95ad 100644
> --- a/doc/org.bluez.Device.rst
> +++ b/doc/org.bluez.Device.rst
> @@ -155,6 +155,23 @@ array{array{byte}} GetServiceRecords() [experimental=
]
>         :org.bluez.Error.NotConnected:
>         :org.bluez.Error.DoesNotExist:
>
> +Signals
> +-------
> +
> +void Disconnected(string reason)
> +````````````````````````````````
> +
> +       This signal is launched when a device is disconnected with the re=
ason of
> +       the disconnection.
> +
> +       Possible reasons:
> +
> +       :disconnection-unknown:
> +       :disconnection-timeout:
> +       :disconnection-local-host:
> +       :disconnection-remote:
> +       :disconnection-local-suspend:

Perhaps it would be better to use to the actual HCI code instead of
converting it to string, since I suspect application using this signal
may want to recover the actual error to do some sort of reconnecting
policy, etc, or having them both in case the client just wants to
print it.

> +
>  Properties
>  ----------
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
