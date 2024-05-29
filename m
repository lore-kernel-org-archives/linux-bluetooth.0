Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7BA1591EC;
	Wed, 29 May 2024 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996082; cv=none; b=R1GYN1m/Y5CmYmGsYPpUZYmGZMmID2+zAqycXC22eOW/Uf9/xsz/XqQc6107LhfUA3OMM9I39FFNujnB6J10vVB/vteW9lwbDUmIkKj8IRmWKAVjRuZJiPult59d1IvUeFnSEHpL7xuLuHPDh1sRKZLhNvBTLwR3e1DyfegVMcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996082; c=relaxed/simple;
	bh=c79RSFffyvc5WdzsCjY1kDeP9xSeffakKqMVS7yp8ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGEyqoBCntY9e4DfboW991bPtL/BNzWr/Ll0+I9Th3Cmzhc2xiwOkH+6h9R0t24hcFsM4DW13pPkeUam80iGnQ9QdHmsCe/xbchQ2R6dhu/Ow2ar/v6WkWYYA0kwCi+x6iFLgkFgVzDMNfHWNaSeGDa1DlcLmIDKMEy5dxlrigk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxNsOFBU; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxNsOFBU"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e968e77515so27219571fa.0;
        Wed, 29 May 2024 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716996079; x=1717600879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTV/N/Q3fP3Vcah0VLqoOxvD6zs2GRo1SBCQqNoRyzU=;
        b=FxNsOFBUUXZ3VbwHIz9GNxYf118Az+JvXKgPpgDH7yzBD9g06IOu5+4EclfAwOyLVd
         ETGDNZw26KJXxq3qmtrQZFyXQZHiX0HjLmNo5ONh7pWNKOw4DH0lK7ndrqj4nAH1eLVt
         G4q7I+kEUlXG8hGqRfS+HiFvMbfRpJDV7/pVcRs5Rpy7bjXnbHS2NCFUtmOyJ7+iFLf5
         8eZjXbNMEjnj9B6yPjOsXB+jZC0dvq9OmuAjZklNDIR5mIol8q7EGFijMHckPR9UKv6p
         DHdZZEPxK+DCBASBPUaXEzlWUs0DbJaKMami+IhSq7MKrfpQHNYj5TOIryNDKYpmfVzS
         /dlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716996079; x=1717600879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTV/N/Q3fP3Vcah0VLqoOxvD6zs2GRo1SBCQqNoRyzU=;
        b=FVbBYFz7dH/qok0ukc0toeb6R1e6bH9orPpL1+Vn8493eG7IfEpZ2jaSjQn/t6ToCN
         2qtBbbmvkK9A7XaC1c/U+ETMBfdvUfxox1Mf9qitYjwKcr2pB6UTaA34aHCCEfiPzL1C
         BFbHZYVrBJ0QYWEyBfELJYRd1hpsrWrSZJ67NM/NPAIT0J1WjqT6TQtx7EJ+BnLRTLjG
         f4Pb1YjPKZm41AgGYlR0f+MzOvw/EYAR/RuM0ncbUfo96qbRLX25zWD0n4AAXS7VQlg/
         ZPX//lQN7126LhVbn4Zl1z7tHuhbQ57vJ9uxEmCxJKIk9dNN53rOnBGNcCbgWBFrCosx
         9o6A==
X-Forwarded-Encrypted: i=1; AJvYcCU3NMeFEyfAz6PpdGFP78geRUtHMxLNwWnnpducCbNBeUmNXP+Rz/3Ja6xUBoAEYkSlDCV9BUOHmLaW4eZKk9pqwjoz2zCTZgNnDC/OTBxV8cabumNlB/X31FaRxQkuIxuSvRo/dEJo47tiDRiy
X-Gm-Message-State: AOJu0YzMxsa0C+gLU8WGSKxb2dV+w/LMTY4nVQ70UlMA8WZbFtaEaSbz
	GZJcN9ijNHooUTyfiz9ruVA+8FS5BivU6YAa7slti9yXkYHcPM+32VIMYVfOVTPsqOataGBIkja
	bm4vl8Oiomyx2sGK7DxeSYzv+GDo=
X-Google-Smtp-Source: AGHT+IHr6ULrcnT5E/lPVWVaYF04PbQdUY+CLMl9D6kJ5eWkus/DlhrB4/8Oqdw9chZZVdGRAkKgQALZY45Y+brbwxo=
X-Received: by 2002:a2e:bc08:0:b0:2e5:15d0:511c with SMTP id
 38308e7fff4ca-2e95b287586mr129735891fa.40.1716996078653; Wed, 29 May 2024
 08:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529033038.28458-1-chris.lu@mediatek.com>
In-Reply-To: <20240529033038.28458-1-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 29 May 2024 11:21:05 -0400
Message-ID: <CABBYNZLEWCFo_OWvPxaM54S65-mAhZ-3R1XgRqb-UnUChcJV9w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Bluetooth: btusb: MediaTek ISO data transmission support
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>, 
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 28, 2024 at 11:30=E2=80=AFPM Chris Lu <chris.lu@mediatek.com> w=
rote:
>
> Since SIG hasn't clearly defined the specification about ISO data over US=
B
> transmission yet, MediaTek adopts a method by adding an additional interr=
upt
> endpoint for ISO data transmission which is different from current way
> on Bluetooth upstream driver using existed bulk. Interrupt endpoint has
> guaranteed bandwidth, sufficient max data length for LE audio packet and
> support error checking. These characteristics are similar to the use of I=
SO data.
>
> Chris Lu (3):
>   Bluetooth: net: add hci_iso_hdr function for iso data
>   Bluetooth: btmtk: add macro to get/set/clear MediaTek defined flags
>   Bluetooth: btusb: mediatek: add MediaTek ISO data transmission
>     function
>
>  drivers/bluetooth/btmtk.c   |  35 +++++
>  drivers/bluetooth/btmtk.h   |  46 ++++++
>  drivers/bluetooth/btusb.c   | 293 +++++++++++++++++++++++++++++++++++-
>  include/net/bluetooth/hci.h |   5 +
>  4 files changed, 378 insertions(+), 1 deletion(-)

This probably needs to be handled in btmtk.c though, since it is not
standard we shall avoid having vendor specific transports like this in
btusb.c


--=20
Luiz Augusto von Dentz
