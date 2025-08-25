Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C85272E61
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148233; cv=none; b=iag5BKVM3yID0o+GsoalE3rDKCWAIh2eKXh9UB5PqGdEAZ/kLgG7/fDQYV84xJj7/hHmmceTDMo5JF4S1kyaNCURnpMtKl82D0czoKN+oOd7aOJR28SEp1uwDGaON4kTByi9B3ZG9rBvpYFLLSRgVZtiuLSe4dxCq2gz+USb3cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148233; c=relaxed/simple;
	bh=xI/Q+l710VG6+j0obZDUaR0ohaz6j9sAhYSvBO9QK6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D256w4KcsTmpOBMuT7SwLu7S0VG1vjJX6wHS7Ba1rYwYrNZ+561uSuC6pfwym3vFN1zJh4f4bLuak0t9GOsyKDqF9IrueN4SVTWYCny4u6xCadVnstjtRIUGg9PHGyDGQS7WgRB1pLmgnatplcatfSM1b1Xr89NXZJz0Yk18RGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIEpN7Z5; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIEpN7Z5"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3367144d196so13398961fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756148230; x=1756753030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xI/Q+l710VG6+j0obZDUaR0ohaz6j9sAhYSvBO9QK6A=;
        b=nIEpN7Z5k75PIl9owNEIpituhOVSB1M4Ow+WUjOfextVJ7oxYX1hQem7ftFclJuHPD
         kpSDpPcarT56knRQ5oQhYlp6QCjJBM5OWgXhk6J1lYPY96Syo7r+H7c0F/JCJZ6NjL2h
         pDDbmWaPb7bAeBPD3GPJm5EhNVFM7FEsK3wZiomgVc3Qqg1CTMXedHyiMilNnM/FOPKh
         m8heyT0U4R0Uc6uUXuXtcLar62nw3jplel2fj4c3OovnmRuMBcX290rpKs9hAAoZRzHl
         QVvVH+gOhMToSioMMijr7tRYSkBtzGWPK6AA1ml5YuxS/NYaqrJj1xOgn7UeWHggHUuU
         xgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756148230; x=1756753030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xI/Q+l710VG6+j0obZDUaR0ohaz6j9sAhYSvBO9QK6A=;
        b=NIckeYKEqyjoC1pcc1jUY7vlXJ1D//AEIJDCtQavtNake172c6qOrJoXJYHlvnBMwK
         Iy8FfiBFUQDXLabhqKm6gToPRSB3dIdhX/9OD5valDIpcvEttsyNnxI9E6PYAmBCb5d5
         uV1Rvcf2En6qJYlfE2YFn4zEF8wxZN7OTsiC6wETzrQlee1bTvaGxgiEr6FMpuiqN1GX
         XpcUMNuBrPOroYVdvCX7Mzl+Pvt9jBYFW0B6yDBSiVmeYyxdUAjaRyS03OmQQcps7wFW
         7sJBrDuO1vUpNLi0Ajyw67YuKQBdco+XUiAC6MCOc9iqJl1qBNqSQ5TWahQWHGnUOzYn
         xz2Q==
X-Gm-Message-State: AOJu0YyxIp6Kh8v28WW8QHI+fDGMD2GA1N93fitTZGiX11TEFUVq3bAt
	2Bp89Ok0R/fU0Iaj3qHYmFL4/g9TzAq5d8A6BaoOX6E6YbGoROgXHhjDWXwf9GU+S72lulS3K6F
	2JGYKCNjybqfsbMnm62EsepCw1CExQ35PNHbVId0=
X-Gm-Gg: ASbGncui5xoenmLzaWqolGPOqzGX9v+N6okvR4oaykyb8aHOkx//V7KQerdogEPYxxo
	AvEl/8a7o1dehdbiWSJ0i6Xy+fs7D99bj4HgSpq0qYbzUsMghf4ytE038/1PTMXFSqYsIChyjSN
	fZBzagzWOgBkQiBk4FvCKt8j30dH2XxE1t4rGM9SKMuiXvNmJWHUirU4sOiccW3M14zr5dnxCH3
	23Ksq2blx7ELQNDibhwUc71zBztDbZiQvJqvPTQAO+f/Q==
X-Google-Smtp-Source: AGHT+IFoDxP3P5JaALfQKo4CdspQ3249Ibf21q1etynkJDJHA4EQ9pvSN8RgsmJfFi19qiyLAiqGIq0eDAHflmwtmG8=
X-Received: by 2002:a05:651c:b1e:b0:336:7a29:462c with SMTP id
 38308e7fff4ca-3367a294949mr8472541fa.4.1756148229610; Mon, 25 Aug 2025
 11:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
 <CABBYNZKazQ0zROk1+gs5=U+zaZDwkMmD01MTYLuMZ3VUaoZZQg@mail.gmail.com> <CAGFh027fC8z3mx4zMm9Zu8GKFu7Ae7MKbze3Ef+4g0x90sRCag@mail.gmail.com>
In-Reply-To: <CAGFh027fC8z3mx4zMm9Zu8GKFu7Ae7MKbze3Ef+4g0x90sRCag@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 25 Aug 2025 14:56:57 -0400
X-Gm-Features: Ac12FXzk2TIugAK-JbID_SvRWkSy0eAQwp0SKpBgRwVDe3s-470lGcjBciI2-PA
Message-ID: <CABBYNZL23GLaO0tQD9iYaG=OeUbxvbKrKCX1yOv7kfvM+L7W5Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fixup quirk for reading ext features on
 some Barrot controllers
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Mon, Aug 25, 2025 at 2:49=E2=80=AFPM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> > This issue above seem to be something different though, it looks like
> > there is some fragmentation of the response but then in the meantime
> > we send another command (HCI_OP_READ_BUFFER_SIZE 0x1005) and that
> > times out, so the description and the code changes don't really seem
> > to match.
>
> This extra byte tripps wireshark as well. I have exactly the same
> dissection in my case, and also I thought that the problem is with
> fragmentation (which kind of is). If you look at raw bytes in
> wireshark (not the reassembled packet), then you will see that the
> 0x1005 command response is correct on its own, however, it is
> reassembled with this extra byte from 0x1004 command and then
> everything goes sideways....

Yeah, but that is just working around the extra byte, but it seems
there is some way to detect that not all data has been read, which is
why wireshard is only considering the Read Local Extended Features as
received on frame 127 not on frame 123, so Im afraid we are not
checking something in urb that tells there are more bytes, then we
must read that and only then call btusb_recv_event with the entire
response, then we can have a quirk to ignore the extra byte.


--=20
Luiz Augusto von Dentz
