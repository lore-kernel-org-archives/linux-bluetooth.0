Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333DD1E9B32
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083952; cv=none; b=oxm+8J/9NtcDcayv80xriQfhGY/Qof2X331gr+vvnGti7X11zkmSTYfk7xtGWbkkZrN7nTod8/F+V8PNhxcmtFm8+M4eFu0W7ul2jmSmmTDaiEPCPQMHdpeBdTBjGTz89GbOGlJ2VGIBUue/kxXkyLcM/yoouQLmenf6lB7WHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083952; c=relaxed/simple;
	bh=JJj5scXl96Y3iRx4kFQDbvWGHsOS9Ng4dzUE4IlHeIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSR0yxZ8cpr211PT/gIP7/qRUyb09Hqm2Rfi8S+g8nnEy+QvwHyKg4mNEeErC/204YD6mSm/l1cWVNOHrYEVZVO3vFE1z/uqK/HN7MXXTrT33+3pbeHoqoKsbFOPTukv1gzXSpwStuHunEeuQenmX62szZMjjgZ+Fr6QIgh3LMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASQLqWvr; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASQLqWvr"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-307325f2436so13735811fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 12:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740083948; x=1740688748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70IT6kRv+1tkfGFKB/GJawFdgsbqV0ZRaZzvKP+35CI=;
        b=ASQLqWvr+j9fJ+xw2BzoRLwoM0p0hp9D5xX6+IuCsVRlTbIEbBuSHzBSUmuW7701Qu
         N9AgtMeiIMDTvjDvpMRMkgZMENSv3fRhw2xyeY9gy1MmhAU5uTQRuY/FnhIzMOOdV2cF
         wZgEAdckvK0Hm2q4UjhdC+BIoCAm4Jc5eWs+PKJg1Afni2KbDwUzYEL0bCPJ3zrOCpL6
         sd/QiTHrSmgUlFFX+0q4pzmlx4O9S85iRXG65cWDGH3sL3BBjo1IrXPQUjHB9Z/FTjNe
         ENnCHR+5s4Os35vKIOjgq8W7EXdtWrd9eTQhy8vBT1EENl7JY/T8ZnjCpGG6msiMiLGj
         va7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740083948; x=1740688748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70IT6kRv+1tkfGFKB/GJawFdgsbqV0ZRaZzvKP+35CI=;
        b=akDvyiPcO/7tuzFdDW/zunqPXdVEucBg1ozxOl0O+6z+gbUNN0LBh2I2mloP0Oh2Lm
         VVN8d89kH5YzVyLphqOTJCNOYTOhWEaizqVIOd83FyGteRLVLylgqtF5ZvYYIVYLkPXS
         ZYObGiqQyo5zCnoGRMvb6G5C6frKeSWRsUClXUOgJ7KgmavHVxEhDKLdZpilPyUPLFxK
         hN77jqiTqm3drImHIg2bLJyoX+/9/G/lj8I0JwxmuPIjqbcri4KoIf7Awj39ck0fRQrA
         S4E2ZYJFcE9nT825pVDT1rI87HmvapVCpIbKr4BGjFLtcHLq9nXKB7TtPK29mBMhaq1f
         xl/g==
X-Gm-Message-State: AOJu0YzcrZSMg73cctIAAxTrMl/XRpOCodL7nzeDcrXhB5DMdD/0izOE
	d04KUyeDzCj/J20SF6bf+j9JHzZFpDdpnpbBmOVbZSvNrU5wKpS0WZBifWHuJ4uMiDG20/l/mG/
	mYf9V+YOhwfEf1p1JLZQmEnHLVLU=
X-Gm-Gg: ASbGnctc3HBLXgw8fqnvi1UfQq09qwGfU3qImnNChxo2QIkIWTe7raRRwH5oxYy5eih
	OlmdBids62oye9ujtIi8fhgHsGRu26piSOXOYWFS1OgufEB72dwJ9y/YSSQhVrWzHBJ2W4W1sJw
	==
X-Google-Smtp-Source: AGHT+IF8S19NBdQzMLfQQYvzD5bzGdOQ62WXsySGkS8qJiJEpvXYMMonQ6VtH1ooKbNFuqaLcS4EYbv5nJUNs2Q6li0=
X-Received: by 2002:a2e:9ad9:0:b0:308:e0bd:a091 with SMTP id
 38308e7fff4ca-30a599ba31amr1712231fa.36.1740083947846; Thu, 20 Feb 2025
 12:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218214344.1519862-1-luiz.dentz@gmail.com> <7b563cafc5b7d3ad23e845f409cf9b992e37ac79.camel@iki.fi>
In-Reply-To: <7b563cafc5b7d3ad23e845f409cf9b992e37ac79.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Feb 2025 15:38:54 -0500
X-Gm-Features: AWEUYZkFwVsMHHfojtWMke8LfKWp8Ru83g_PmPvw-A9AL6YxCTcXngOSyfZgHJE
Message-ID: <CABBYNZJ4YXfSfVZrM7yQnqYELJCiPfo1Ho236rTb56Yda7oMyQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Feb 20, 2025 at 3:26=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ti, 2025-02-18 kello 16:43 -0500, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This enables buffer flow controler for SCO/eSCO which apparently for
> > some reason has not been in use up until now which caused sco_cnt to
> > never be updated, but recently this has caused the following problem:
>
> Should this first check or explicitly enable
> Synchronous_Flow_Control_Enable setting, via
> HCI_Read/Write_Synchronous_Flow_Control_Enable?
>
> IIRC SCO packets by default don't generate Number of Completed Packets,
> so is there something that is incrementing sco_cnt?

Yeah, totally forgot this exists for SCO, we will need to check if it
is supported before we can turn it on.

> > < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> > > HCI Event: Command Complete (0x0e) plen 11
> >       Read Buffer Size (0x04|0x0005) ncmd 1
> >         Status: Success (0x00)
> >         ACL MTU: 1021 ACL max packet: 5
> >         SCO MTU: 240  SCO max packet: 8
> > ...
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > > HCI Event: Hardware Error (0x10) plen 1
> >         Code: 0x0a
> >
> > Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/hci_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index e7ec12437c8b..5c88d3816c6a 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3564,6 +3564,7 @@ static void hci_sched_sco(struct hci_dev *hdev)
> >                       BT_DBG("skb %p len %d", skb, skb->len);
> >                       hci_send_frame(hdev, skb);
> >
> > +                     hdev->sco_cnt--;
> >                       conn->sent++;
> >                       if (conn->sent =3D=3D ~0)
> >                               conn->sent =3D 0;
> > @@ -3588,6 +3589,7 @@ static void hci_sched_esco(struct hci_dev *hdev)
> >                       BT_DBG("skb %p len %d", skb, skb->len);
> >                       hci_send_frame(hdev, skb);
> >
> > +                     hdev->sco_cnt--;
> >                       conn->sent++;
> >                       if (conn->sent =3D=3D ~0)
> >                               conn->sent =3D 0;
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
