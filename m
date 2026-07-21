Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C5383316
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642833; cv=pass; b=K9pdh1XqsH7D7OYG6OeU8OWT7lfAjsWDLAabT6oSwbfpPTn5W4VMzG08rIs59CMxex64elTBcdHCq6WXQXGTf5rjzK6iTO5c/CzP04vVfA2d2jpTju6vntCAuLMYmapuRZ1VlUimIrAZt5TdbwUz8qiLnFir86Z7sIHRIA9KXRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642833; c=relaxed/simple;
	bh=MF7Gt6xSCvBWH5Z8rKDVT5ogNz4KYEfCwUkYY6EOwK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGLPcUhcW6GrbrCnjQnoOc3+DSvZ2/yB3uo2824yRJm/KrLsWRohBRKm2qofDN51DwMPWOzRVm7JLJPx5cjgj0ciS2BbHZMb1Q9FhBOSjDs4F5xjXWhSMSwi//5zJkljKMlXxARkyrN0IfaqV6vO4Q6TmrUyv04OkelGFREcKCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFpdR9RL; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFpdR9RL"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81ef11a0972so50235937b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 07:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784642831; cv=none;
        d=google.com; s=arc-20260327;
        b=Yv6YP2aU9+gZNJrWE1lAfPUK2ZeGvR6A8V6CE+6POeFXTERpB7K/dWRG9xq8mV/tV4
         5e6mq9yY/8sJGtBrEZbEKs4ghx5KbVTAaYSygwf6dwob7i44C114YeZxKCNYMYfK3aL5
         O81l84aTWTxNMTITwN26pCZ0qIy9b40li5y8PnO2C/UB2LST04fRTxADTmZEK2FwkgMc
         I1WwYDkbiF4AScV8XlQscpYVrme1uGE5AxR6nq2fTi2zCXF2wYuR0OvOowQaoA2X8ODa
         Ggi7dysv5fBqYxaA2/Y4tHZjGy+0TEvIeuIEjEf4NiFpAPlVj5G/HfFlNe9qE6WkJ7Li
         hTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mEZScEO+sxo4ItYgtDTRhGAjuHMSOfwApD7XiOQK37A=;
        fh=SPnlVb3xEGVdPPJKCVG7yadbn/6o62p4zP6U7FBxm1U=;
        b=Pii3VFk9QV4CZqWMtdV3IWC/1r4gUb8iadIOD3zwB/wYQRwuAR7Tu1RUJTEPII8snC
         ZNpigkShAIziUxVKJX5oFIf0SAg4qbtlfp+4jP46F9UfqXdJMzKFZMDhNR0Vafesjc+B
         BAF5DPe5Cs2/HmhS9k7WD4jUWmSmk7lMvgIKjyIg8WudLE7l2oXKh7XGAkBLjmHLqqET
         7lA+90vkNaSpjY4rz9iUbturlVAUfXHuvuRve3EeDRCtaVAjf5VJ0s1/StOQzx187VC/
         4K6Q1DMglEeWPxENBk+jzhjNwsyvn92UJy0l6GOZ5YpcNkIlfjalyd/yEVHPrnEq9XHd
         pkVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784642831; x=1785247631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mEZScEO+sxo4ItYgtDTRhGAjuHMSOfwApD7XiOQK37A=;
        b=YFpdR9RLUul3f9ylcFRCP83ryrEJ1EK161S6aD5iIvRvk9tFdeKSrdjSY7rnwTzACO
         ktgg77musa6agLG1i+Vf+IXk9tilM4C+JqYP5gn2J7w69F6vwzZksb7fx6Iijr5ZvMnV
         TXGYWS0FPMBNnhWNdm85ELqHxAoqHN7wl3sib+dlWPxeBhwVQfWZYVdZ0/iD/6PGjQtS
         LrsijRVYT/sTG6rWD0BAk7KvM9jFHijDrXZ6I2zcIjztUcrN69eO4aSxou7lz0aB6wCm
         GYKQVfisrQxy++JQZBZGS8YCkIbSKdFIXl138IezAQxnkq+JWo08FYAuXy4MvVyUmkPg
         jsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642831; x=1785247631;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mEZScEO+sxo4ItYgtDTRhGAjuHMSOfwApD7XiOQK37A=;
        b=EzcP5AqQG1748NJlySqVi3ynBgRNJVwisl9JI+qZEnNNaxbp2zQ2t8LA6K0dWeQ/iX
         2cdvGAxC94x4CCbtpgi/1PuSmH1ykueCmMLMTr8ZR9m8+jsG0uhiOV6Seh/SsI+tDRZw
         XQAQ9P3/vDyJJT6KdDq5np3K/H0BqwHZbeZ3e8k9jV+Z+8Kx159mNbM3WZeHnllAxZ8o
         b6EfU47F//aPma3Kw8I10URKo3FsglnvuclE5OrRSysLUrR5w/vchdu9yjb6nAjiPVmn
         PHk0iuV03EbgXF7YwS8AD6kBLtdZYS/n+n7Os9E2fDtsDyWTye9oPwiLmAXnUH5s84/S
         xvAQ==
X-Forwarded-Encrypted: i=1; AHgh+RrbEvx90ToJh/qM3nEjwSR+V0Dm7lsjHov6idOaCIyeRZ6XUDyZU6FDkq++1SK5ONTwIXaxKwnoAbpCCEBO+3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS86QbM3n2VfCP7dNR9dB+gr3li1TCv2GYhnuhb3EVZTCPELPb
	D6atVSKZLG2As4KBWH6FvMmpCkAn7wXX4CYXa3Yj/4T1Z/Drmbhz+fMiKPaarx79vlNuuQqT2hv
	VGP66sLj32xD0doiQI+PSgUssGoAUuxtqP37Sj8du0Q==
X-Gm-Gg: AR+sD10EmuLUxV7bDX/iMWGFyGzXlmgDQSlHTF2P25caNaooDlP40CQb+TQ7afHXPh8
	R6Y1gWTmpj3zILmISXh9I8lRskQa/Q5WpB/JLlT0dRsIOb4EkhROG7J99ocAxmrFs0IYh5slGz1
	VyzI8MwtyGaQK1aL2Pijyxb6gaLwBgc+89Io22F21AIWqR7qtLElB37xRk/gTFtna7TEzu5bDgf
	a8zcnAixICzhjBWiYqqWb73RIr3hHkyC3NNIgcgovG29HIGfyK95GlZM46N8XBPssO2KR98VSOS
	0kEoWjVR652VZIcjQHtE7q1+Mks8c/SUMwPqJ/5E6iDX/heQKJsYhBUhrxg=
X-Received: by 2002:a05:690c:650e:b0:80a:ed07:9c1a with SMTP id
 00721157ae682-81ef22e4812mr67235557b3.6.1784642830996; Tue, 21 Jul 2026
 07:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719-vendor_hci-v1-0-df2ac5a50117@oss.qualcomm.com>
 <20260719-vendor_hci-v1-2-df2ac5a50117@oss.qualcomm.com> <CABBYNZK0RSZ6xOgkx=wcme9kUWXFHydAvHR+EXwkp4eJwp-QKw@mail.gmail.com>
 <12ee8fef-c8b5-4e77-874d-789b24c5458f@oss.qualcomm.com>
In-Reply-To: <12ee8fef-c8b5-4e77-874d-789b24c5458f@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Jul 2026 10:06:59 -0400
X-Gm-Features: AUfX_mxILpP_PU1lByQCJlFTnyktKXMXCf9B-whaW-stZ42voq2jt3XSF1OFG6I
Message-ID: <CABBYNZ+mYA9xgXhXTUdV4C1jM1iFvFSvYAtVUbGavZObGFuhoA@mail.gmail.com>
Subject: Re: [PATCH bluez RFC 2/3] doc: hci-protocol: Add sock option
 BT_RCV_VENDOR_PKT for HCI_CHANNEL_USER
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Tue, Jul 21, 2026 at 5:07=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> On 7/20/2026 10:10 PM, Luiz Augusto von Dentz wrote:
> >> +-----------------------------------
> >> +
> >> +Enable receiving vendor HCI frames, requires hci_channel to be set to
> >> +HCI_CHANNEL_USER.
> >> +
> >> +Default is disabled.
> >> +
> >> +Example:
> >> +
> >> +.. code-block::
> >> +
> >> +    int enable =3D 1;
> >> +    int err;
> >> +
> >> +    err =3D setsockopt(fd, SOL_BLUETOOTH, BT_RCV_VENDOR_PKT, &enable,
> >> +                                                    sizeof(enable));
> >> +
> > I don't think we have any socket option with this name, besides this
> > should really go as an HCI packet with an H4 header set accordingly.
>
> Hi Luiz,
>
> I named it after BT_SNDMTU/BT_RCVMTU, but that may not be a good fit.
> Any preferred name?
> Happy to rename.

I mean we don't need it, you just prefix with packet type 0xff and the
kernel should accept it.

--=20
Luiz Augusto von Dentz
