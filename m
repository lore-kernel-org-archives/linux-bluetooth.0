Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809765;
	b=2K3urRUFqo1CJVodsk8cvSrf+ZFdsk3usaEjxKDRZFoMjIl6JvuJHLDTWuOGwPN+yRYW
	 QyJ78kZA/ij7/qfQPJkbVc6edgu6GGguYIgHIgFnpbJvHogV/RPtw1zMIodqKArSoqe9X
	 RP+5wbB5G6L3GpfysZgMXgfnRfZjoMMBAKa0TRQW6kLgwdmTqiKaroN2TNHDPqpvm1ccU
	 kWbtgSMhPzSD8OS0FnSMIPv6T8SitKVNXhjD1uhGkdPc4sKL2aGIzjtO/fZieuEtxuXUI
	 PW3NlVM3V2MLsIsfLyYEuJwbY2dkCrOKC+Ww/kxBGNuNya4o0zGns/2Y/YtnuMQfbBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=m4qzkUPaTb2whrGmY/+Op6+Vx//rob+Ce4Qzd/Bakc0=;
	b=OQ208qrA031UjjrwkFKjfIF6WlnFNd1SIl0gk9yCMCYgPOn/hv3VTQQHFlcJC/MB/xAS
	 xl63GnjAVf3YNPQ/kpBwpDPWjspKyMm1JdAnPzEHyVdvdGisKTjbOVdvjN1T40rCRE83K
	 9P8XHgtB5gX+21jCP1bvmnm30D9dNsE2AmIoRw/2leAZsSwxBkQFJ2p/5bB9oRl22VF8u
	 34D7gkdnX0cD2DbqATlUTxnIxQpguHdbjotss0v4jrjFk3Y8In9ha8DLfzttTyGmveGB5
	 i9CjAoTOw74SqsEzn4n3OTKzx9dXXI77sGUe6Bo2y87PTym+zJQa8Wa+yb/m366im4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Xmf7N/QN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F1D606A33F
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 16:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59F1D606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xmf7N/QN
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-679e86015e2so2144695d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:29:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793809764; cv=none;
        d=google.com; s=arc-20260327;
        b=ByLuqzmDaMCSjelPc8W2xdUb8vbBKGsAOsY4sAQe6LlRGQm3MNnbSiCZpYyp6z6Fs8
         iaDJWFxFzBK+NwR0S8y1JpdgNm9vctrc97v0CAXYFJEF0Y3+aILoI8GpZy51MSM4F5z2
         tweKaSvhxz/qfm/942yJHLwLCSEK7e3PjNUGqhEm0zsjnCCzArv6rsEHBgwgWsfXdmJ8
         p0JPEfSdWBdd/3fBOIyc0zjaIkNwXxDOXVmNtJW7WsM3SkJg4Qbp8FQPlrrv+3YYUtrq
         S8qEZGrHF4xAy1ZxJYDboQB7c6gVh6tCua59lMX5pDn4wAv3yJYpwpuruo/u9bbrnBEH
         zB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m4qzkUPaTb2whrGmY/+Op6+Vx//rob+Ce4Qzd/Bakc0=;
        fh=DxpSf1+xwNPPLhdxwg/c2sSa/GkE41pjg0jXyiDPLis=;
        b=Fz/T6n8YUAcbFYqfVi0H8bKaRXyyejDI9JcqeEFHVMirUOZTEJ8ma9QjVD8MidFqOz
         F/9I5ZRvk5SK/ndhOkpbHySFzfMiHjp/Z5XEn3nq4XjTdGM74aSoNeqNwhm77LDUenWc
         7znAmy9/0b20JpY1ISNJq/QPde1nmfok1jbbNivsQNmIS2MEVqG0tzQKyxpGAmrGIHXP
         gZB0EnLdOnqrpX3ykezjYrnwuqGDq8DfokMNU+bG3nni4fbBpH6B4zkDY55j5MYiEF6X
         2/Rs7kyF+O1HUFDxTvX6Xa1ISvsBKkTgwcjaYpchg1f07oh0KxsofZjJ/XKuZTeepVGp
         Bq5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793809764; x=1794414564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m4qzkUPaTb2whrGmY/+Op6+Vx//rob+Ce4Qzd/Bakc0=;
        b=Xmf7N/QNySydGbaaWTzB/1f4sTZdzS7RdP9XGcWCCBOFbdQRU4HznnYmtkKZ1CyTR8
         D+vFJJ/OHWexlTTx53EgYhh5eWBrg+GZQqNMT/MybcqKpBGHG4G+FWhCfyNNdQ2kEnrL
         f516l+MSEZllz6IOaIqdMs1JKogYNj9BJlpNKACjeKUsZLWRmrsGHUY9xoAVP4BmBgJm
         cQZARxgVsJ8Cwx0aLm3CmM2P8MO9QRJvRiJ0r2DWxGjBd6kVsaWAfn0Kkmm3DF/Kdoqb
         vJpqfmtEhZSajtZCWzQ+6sfrbm4rrz2mBRncizv/wAZmHovHx62F1ClsH7IWEZUzH1/w
         Eh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809764; x=1794414564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m4qzkUPaTb2whrGmY/+Op6+Vx//rob+Ce4Qzd/Bakc0=;
        b=ye0upcRBT3kX3yKx2+mR/yi+keVgPGJEmWmNkZ0sWQY+aIHhLIAPYukCuUMIw1nx8a
         jqFzSznMpYRYgLAIGv64XdWh5tFYyVQPtQBOQr5k/6qySqdJ7Ia9ATW/X5K7OimVQG08
         KhdO2yySC7bHx39fdygFetPo7LD+Dr1o0yTgdiKuJEBm1bvQY4O1iemseho0F4SGZ0v6
         b9uHGEf1gCK7u9paRyjCF8X7qCSRu2oFM87k2E6QCNSjTPpJH3wg6tud+H4CWCfg4h9c
         6/DwUyzctpk5Mmgeb1Vf3bvjNv3dZXZi32Og548XsP5phEBaK//L4bePJ3DNUr271HYx
         h4Qg==
X-Forwarded-Encrypted: i=1; AKwUvBxLBr/XhrSKwqscAhyG3E52HP9jrINKJ4DgehOAZTevmyHlGNr93LK/4qt64pDi6YIT5MAQl2vPS3AAvEmVNDQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/glxcSIeA/++3yfJjYe1t29MnPUReO+wIqQNhqCTIn1h99Ng3R
	oNrktmRCIMCoUIbXl64mK0Oyx55cXaA2vV1KF/RSG9tMNTjpbAnK72qUH8aKa05IqltkhXMUpc0
	SAldFWUOM3jC6lHbmTf7i2WOZrOsLZp8=
X-Gm-Gg: AYBFou3liEwr0PXyFV+KK9fcYSuX9o38liH6nvhA8FRcnVa6CU8vloOCP9XeJgq6cNY
	3i7A9ZiPLD3c/Wmh3wrDBZSDWeRuqGIfGCIetPfoCaU9v4h3gWqx+HAtqNLUfl4mzvnb69w6Pi0
	OAqvNUDmzsaH+iRPRec/ixjQx7gwEJi5EHaComTLEOK4bQJq0PzgfSCWN4uuVDb0hl1RDlyuude
	EeNkF4oU4R5mivogCl4YbD2aBG4xDIn4WOOwRD2gDXk7OEJuCvR43+vo/uzaIe/z8Wq9O+1V8+P
	sX0UOnUDANGS86qUJlhhab0ix7v50k8KRWGsjrjakRaw88RUq9xIo0kM7fZIa+2JmbAECOvxjkG
	nOB+VJhOZZXEeBzkXoKp4B8vzRGfqNDps1Qfyo0pH52S1FVF99eXsS+j2YQd/PacUQx8QQxRqNV
	MVlcHh9jsBniSWx5gmmqd39lrtLMT1Bb/X5RYwRhoRuN+tbbvJ7beXJNmSpg==
X-Received: by 2002:a05:690e:80b:10b0:67c:18:cc8d with SMTP id
 956f58d0204a3-67c030026e0mr23243d50.0.1793809764215; Wed, 04 Nov 2026
 08:29:24 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104151601.70493-1-dev@deq.rocks> <20261104151601.70493-3-dev@deq.rocks>
 <CABBYNZLMVso40XpULwTwBwAE4tpXndSJMKhmoVLrmgm+unBNCA@mail.gmail.com> <20261104164647.5e9351cb@kait2en-mbp15-1>
In-Reply-To: <20261104164647.5e9351cb@kait2en-mbp15-1>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Nov 2026 11:29:11 -0500
X-Gm-Features: AclHuK8doVEFo6j2Fi68c-P_EfTM3lCyF-M5HVrIdSqvITfMTgBypxfl_seEBVY
Message-ID: <CABBYNZLwMW68WYBVp=-R=4Mji+-Q5AEtrcu5F_7rRYju8d-XNA@mail.gmail.com>
Subject: Re: [PATCH 2/4] Bluetooth: btbcm: clear vendor bits in LE advertising
 report types
To: =?UTF-8?Q?Andr=C3=A9_Eikmeyer?= <dev@deq.rocks>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sven@kernel.org, j@jannau.net, neal@gompa.dev, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	66ton99@gmail.com, josemiguelo.ochoa@gmail.com, aditya.garg@linux.dev, 
	Yossef Osman <Yossef.Osman@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andre,

On Wed, Nov 4, 2026 at 10:46=E2=80=AFAM Andr=C3=A9 Eikmeyer <dev@deq.rocks>=
 wrote:
>
> On Wed, 4 Nov 2026 10:24:47 -0500
> Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>
> > I don't think I agree with this being cleaner then doing at
> > hci_event.though; not only is it more code but it also walks the
> > packet which is inefficient and may have security implications as
> > well.
>
> You are right, the driver should not parse the event a second time.
>
> What I would like to keep is limiting the mask to the controllers that
> set these bits, as hci_bcm4377 already does with
> HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY:
>
> - add HCI_QUIRK_FIXUP_LE_ADV_REPORT_TYPE
> - set it in hci_bcm on Apple machines and in hci_bcm4377
> - test the quirk in hci_le_adv_report_evt() instead of the
>   manufacturer, keeping the mask from 88397423671f
>
> That drops patch 2 and replaces the revert in patch 3. Would that work
> for you? Then I would send a v2 along these lines, with patch 1 and 4
> unchanged.

Yes that would work. That said, I don't think it is worth adding a
quirk for this. Masking the reserved bits shouldn't cause any side
effects afaik, well except if those bits are later adopted by
Bluetooth SIG. Then these controllers would become
non-compliant=E2=80=94though they already are, as the bits are reserved and
not in use. In that case we would probably require a quirk to avoid a
conflict. So, is that what you are trying to fix?


--=20
Luiz Augusto von Dentz
