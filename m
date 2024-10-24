Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848322B660
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729798543; cv=none; b=CKopxYF6BIVyy8ZqMr7Qu/nopRxZ/aJK/W4oavsZctXDHIn8+95G+ruVBBv3wnTfq4kxWntADF5H0rkbzkKMy5fj6O2nCMuxA6W4bX1oDk2n7Y7ycIpUBDr4pJKw2hDpwOfZ3G6SPIAbBA1ZkF50mTFtPM9yQVVbRFHCjsEka2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729798543; c=relaxed/simple;
	bh=/6GQA0RifX6iTI6xHJxSNqR1+GfsYqdog/gEft2/pNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLFX7ILGbrQK8Qs3LwysfsH4QA6WL/Prfmx9Hk/augPbm9+Cw1RI50VqmjEEbGchaS2BDQhySIQeRDQ54oxpq6QaWQaEXwmG7ttRyvWIWjDsBNlgNUeeKVQvkzLHnbbEdOtBGNlioxuEDE9qw1Gbx4ZCHHfYmNJSOnuOQv3We8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daTB7x/O; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daTB7x/O"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so14921221fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729798539; x=1730403339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDFYwlWEEy4FkN02m815+xHM4QA17JxhZgPDbjA46AI=;
        b=daTB7x/O6b3ytjilsotTsxK9HG3t7vXtwQl4oLu3XcWdp/ZHIlVgt2kvSod3B6YqQc
         /s3AXRnWvWh1l7/3SAwW/ZOhF9EVq8bN0Z6XavarsNwt2SSAyGKHqgle1Ih8V3Kpogc3
         Z10+lTpqrEbchRy8YoAUiQcOEOXeBirDXtzksMRRPGCXAg/DmUUMLkN4E5XKeNxrDI5a
         L8BMlVm0N5yAToQNGYPL5MQwHzinTXuirp77JCqrcvBVglpiKIFdN0NVx7G2g8QwLsd+
         PtMQb+HH8alihAYdj3qiL0LzJpssiGFFBCaYoUsK6x6D9xpxqxoa5SHePh/S/HQYn8CO
         FgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729798539; x=1730403339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDFYwlWEEy4FkN02m815+xHM4QA17JxhZgPDbjA46AI=;
        b=nbbCSFf7QuFkvJt5ZhNMEAsw0VT7PDTXYpsiDBSAfh8uIZ+hqAn2iqvSnmoLaqep4V
         nwx+Ppp5qqkdOLbVyYpd8SCmQiTI2FSB8ATtamaru/x7QdcgfOx7mN/0syTaFoa2sGhQ
         cXv9hXFN8GU3XT4KeXTXfCSuKo598xkwMwu8FWCAO/aXP5uQ/Xq9OOKYvMzCLs8/gNRk
         c8Ci91srT4+jEezC6fSQFG99owAowKZgI+3ZPS403y7WQmRUHPY65bxwveGdOfcD2+Tl
         RYq/bBH7fy1cZ8t211Jr2gqIN1Qy9ZjBMjXj5lJ5dXkwMeGMCcU5edvfPwJxjgGrqW0j
         d6xg==
X-Gm-Message-State: AOJu0Yw34LQ6aGbrt7IruIxjXXHN5Xwns7qK0UrK3XDjRcLW3lbrsjaX
	8Aw59ukM3K9EbPq9KKe3EH7TiIzzrFFiyI5rCC/aX7ODE/SiJsp4jbg3wwpcOflx2+fnD6f/ZCA
	zH3GpgMk/JGSUpgqBhVnfNh9dV9HYDA==
X-Google-Smtp-Source: AGHT+IENjT3yoWhOefOuu+8J9ypfZeZNDjs9VmwSKDhHVAVtWEKWAVHshXZ6aBzv8QcGQOS0FfRZvHLzB79rde++vJQ=
X-Received: by 2002:a05:651c:198e:b0:2fa:cac0:2a14 with SMTP id
 38308e7fff4ca-2fc9d2f5f8fmr43295661fa.11.1729798538998; Thu, 24 Oct 2024
 12:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024110223.77254-1-iulia.tanasescu@nxp.com> <20241024110223.77254-10-iulia.tanasescu@nxp.com>
In-Reply-To: <20241024110223.77254-10-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 24 Oct 2024 15:35:25 -0400
Message-ID: <CABBYNZL8JcLggAFCBvhnKK3VcxhvchMu7MoXENvrmP3gosPTmQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 09/14] doc/media: Update Links property for broadcast
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Thu, Oct 24, 2024 at 7:03=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This adds details about the "Links" property for broadcast.
> ---
>  doc/org.bluez.MediaTransport.rst | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransp=
ort.rst
> index 4d998b2a8..2173e0177 100644
> --- a/doc/org.bluez.MediaTransport.rst
> +++ b/doc/org.bluez.MediaTransport.rst
> @@ -149,6 +149,9 @@ array{object} Links [readonly, optional, ISO only, ex=
perimental]
>
>         Linked transport objects which the transport is associated with.
>
> +       For Broadcast transports, the property is writable and it is
> +       not optional.

We might update the heading and perhaps use CIS only and BIS only
instead of ISO only, perhaps we need to have 2 entries for Links in
order to document this properly so we don't have to mix the behavior
of CIS and BIS transports together.

Also perhaps stating why we are linking BISes of the same BIG together
might be a good idea, so again people don't think it was a mistake not
knowing that we did that in order to avoid having to redo the BIG sync
procedure everytime the Transport.Acquire is invoked.

> +
>  dict QoS [readwrite, optional, ISO only, experimental]
>  ``````````````````````````````````````````````````````
>
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
