Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E81FAA;
	Thu,  6 Jun 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717704267; cv=none; b=MR35sbfMpPBXZPWQPDOf93vG+me3lrzejHXUS8SRRdB1Z2s3BmXdiX0eZ1CMAWWiT5X0PBzKs1u0gK6l5Hu7QM6UR6A8663Z4H7iuiVp7zJ7FcTPkz44lNdXsi5DXov4g9Ll8NmX1qypBtl8vjRu+iT3L6PBN8NJsuA3Zx56qY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717704267; c=relaxed/simple;
	bh=/G3jstf66m0MVDwW/vbsLQCy0RU2r+Dp06fH2y3b4T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kD+NLOj4KxAhZWvJC9eu8WJnPFf9Jlx1wZKS132g2pt4h8dEDom6ObVR0VPnYWylETsx9iI8+0zw4AIE2V0y6QePWUjFLcmpvRJOcWjk7qFDHLQqUMyYHRjKHW6TmaKeZ9Yrw5A2sEKi8jKcQGMl2wXVK1Rg2BMsuUkshU+ruEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuihxeWH; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuihxeWH"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaccc097e2so15704211fa.0;
        Thu, 06 Jun 2024 13:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717704264; x=1718309064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8zBiOnzctc1Ld3pBSWs+XeG/g5v5NHQpM9V6CGdabk=;
        b=cuihxeWHToMumF8P9ZjfmKSNcKHkOAF1xBmpjxy8t2BBszmy3FrrTdwBDMwUHUcAZX
         0Tg4r5nv7Kr9QxLYvCp2eljgZKJSM7WPTTkTSQC9Wbo53LN260IHsU/ZvRTgS82uiK+O
         JDC4Ig6WS+aK/tNGalNWwlJARx5LiGYwacmQuJuVIPdQm9dLIDFHxorqB6hvhRjEFijh
         0RsewhY6C1+eMYSIz2EBbo/i+5rGaqoEm2FCXP1ntzGfGJvNyQecnrc/MnjVAF2dd6c6
         u+RXx768Bsxk3YcArSFOAkH/3IQIyzTUDYn3VbfjVnz4AZmcbVrx2UFvJtpnxzVbOmvt
         az9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717704264; x=1718309064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8zBiOnzctc1Ld3pBSWs+XeG/g5v5NHQpM9V6CGdabk=;
        b=iM+U4GvijWmbizNND9vHkgiqvsbc9OYGpvvL+8T7R9xX0C0HfsiPtzu3mpxBmEn4jn
         MrQki0bV0rw66oXd3YcxcJJUcvjJiPTPlnZVKTl0FMbtJrk4C4KH/IUuijNixD+q+z+g
         ztACxPkHCt9tDCFq+SghwLRYPjnO8PrAcD4t3Uyp7ge/9bjA+PVv6CCgqioStWRJmcnu
         jDt2yKDCC1Z1qx1o6Kdnr+Dd27KDxle9skiM8ws8NpdwrV7+0msWYrS37rTw8J+LABng
         MZpWTl4L8G4ICZp4oMV9M3JJRNSAzNTMoRG5A8Egw/j3DWTY+FEnZl3nb+jUQQ0n7h8x
         9SxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg5tKZwmpNgCle6QcpzKxlem6IqFvLUJ21cSt2wVF8/gO4daxplUGRuJxjTKw1ZSaNtm8DKEQRR8UknzP/MQCNGc3Q/NMo2oO3XYSWupwM+iV3OUeo30qdpvZVs/rrOgY418+cXibGRifG6gIb
X-Gm-Message-State: AOJu0YysxWus66onUzflyfR5tlDkKTFSpW8xWT97WKa7dZ4Dk/kM34VC
	YrPy696CCWDOVuGbla399ATjawc037WDIhTvm4XhSWqlSkkYZ6yax+2BTFJ6tPXjtPYFX0av9e7
	glcYcUDMtDQ5+VdgPkOGKOhTmbnz7kA==
X-Google-Smtp-Source: AGHT+IEPatTRNz4t3IlZrrARONOfqpJodkwoY1B33k2VOZpGRppSY/lcC+zUbX86vGLB2+n8TDuKrhpCnoWPGZbt2pc=
X-Received: by 2002:a2e:9c53:0:b0:2ea:d13b:cc38 with SMTP id
 38308e7fff4ca-2eadce16e40mr4413171fa.3.1717704263707; Thu, 06 Jun 2024
 13:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606183032.684481-1-andreas@kemnade.info>
In-Reply-To: <20240606183032.684481-1-andreas@kemnade.info>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 6 Jun 2024 16:04:10 -0400
Message-ID: <CABBYNZ+Fz2TLSNa28H3kjVKOSA7C-XOzdQJiHdJs3FKxnq01DA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Bluetooth/gnss: GNSS support for TiWi chips
To: Andreas Kemnade <andreas@kemnade.info>
Cc: marcel@holtmann.org, johan@kernel.org, pmenzel@molgen.mpg.de, 
	jirislaby@kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>, tomi.valkeinen@ideasonboard.com, 
	=?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, robh@kernel.org, 
	hns@goldelico.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Thu, Jun 6, 2024 at 2:30=E2=80=AFPM Andreas Kemnade <andreas@kemnade.inf=
o> wrote:
>
> Some of these chips have GNSS support. In some vendor kernels
> a driver on top of misc/ti-st can be found providing a /dev/tigps
> device which speaks the secretive Air Independent Interface (AI2) protoco=
l.
>
> To be more compatible with userspace send out NMEA by default but
> allow a more raw mode by using a module parameter.
>
> This was tested on the Epson Moverio BT-200.
>
> Who will take this series (1-3)? GNSS with ack from Bluetooth?
>
> Changes since V3:
> - Finally remove the period from 1/4 subject
> - include things directly for get_unaligned_le16() to fix 0-day issues
>
> Changes since V2:
> - Optimize waits
> - Fix some packet analysis / checksum computation issue
> - Adding a proposal for removing those waits as RFC
> - Minor spell corrections and improved descriptions
>
> Changes since V1:
> - Set up things for NMEA output
> - Powerup/down at open()/close()
> - split out logic between drivers/bluetooth and drivers/gnss
> - leave out drivers/misc/ti-st driver removal to avoid
>   filling up mailboxes during the iterations, this series is
>   still a proof that it is not needed, will take the brush after
>   this series is accepted.
>
>
> Andreas Kemnade (4):
>   gnss: Add AI2 protocol used by some TI combo chips
>   Bluetooth: ti-st: Add GNSS subdevice for TI Wilink chips

The bluetooth one looks relatively simple so I could take that one and
push to bluetooth-next if there are no dependencies on the other
changes.

>   gnss: Add driver for AI2 protocol
>   gnss: ai2: replace long sleeps by wait for acks
>
>  drivers/bluetooth/hci_ll.c   |  81 +++++
>  drivers/gnss/Kconfig         |  13 +
>  drivers/gnss/Makefile        |   3 +
>  drivers/gnss/ai2.c           | 560 +++++++++++++++++++++++++++++++++++
>  drivers/gnss/core.c          |   1 +
>  include/linux/gnss.h         |   1 +
>  include/linux/ti_wilink_st.h |   8 +
>  7 files changed, 667 insertions(+)
>  create mode 100644 drivers/gnss/ai2.c
>
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
