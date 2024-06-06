Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFBE6D1A9;
	Thu,  6 Jun 2024 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717704635; cv=none; b=aatqwfwPrU8Ga/bhGiG0lNG25lh2bqPObM23F3FPtt/jK76HvyxS+9VJLwNUHwPFwe4x0kI91znsD6CS2gNAuqfeGGO684l3MgrfJwwF+LSdCfIAU7cRSVqfN+T2+yLu4SnVvqZIFIl50vVuus+3YBQgAnsdAXJuckGQidkTlgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717704635; c=relaxed/simple;
	bh=f+0mO3lyWhRWDhdZwJ+G9tdZPcEOT4dALbeWYuTQdWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NobLgBLdsyWms0LCy6a43WVaQR2CDCHxnJQaITlIx9/aSd7+ZgIBwwhK+SHygxzSKYfNMTaTgnz0NxLcreh06ZSKXA26fdMuJJj/aC+O/bw5kkHeLkra/uwrCZtRd9i9Dopm4vANY0uaHo/GomBr278j7HXBjZEegsJQZW157WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjPEoNy4; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjPEoNy4"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaa80cb573so16231111fa.1;
        Thu, 06 Jun 2024 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717704631; x=1718309431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hutjf4WwE6IKhYhoDpmSZWk+TUgz4ul3jgLdpMGfmk8=;
        b=BjPEoNy4cBa8kVaLImqSclFKfQrxUvdxLPAtwk8zCwpEV+OLg59Ra07GSPwnZRLNgE
         u+8RYXl98neYllmkFByMFe8tE0OrmHaAGEMIhJIcUJAmPT4XFH+svtUhLOjYiymK7uHN
         5fxM5IYvBWk9Nt9RM47Q88AQoyrPJ8PPqBQSgjMDb8w/cyFJkXL0Gqb21B5DsiR2C3U7
         QpQX80g9Y0DAa7PDrr2kKySwTtIvUMgedzauf1rbyrnPtBELhCN/+DgoRNTTGaiFdFWr
         kS3gqvYzwkfAPxp4nxlz0gevEzuS7L64ELZ/0jEDK1rJ5ZtJ/5yYEYdRUdqyJJ7NJNci
         b8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717704631; x=1718309431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hutjf4WwE6IKhYhoDpmSZWk+TUgz4ul3jgLdpMGfmk8=;
        b=Fxy0oP7ASe+wMv9wmaRCjY10jYuI/yz1jYy5D29E2wo/FD4r57H0ssfsvTwlquuf2k
         2q3KzEpar1E6DkGxEGe4C53rhCcPyEbKvgTS2BHpI91nAAF+tNyhax6SrzUoEpmZK66F
         UE6SQJs7OLIWNyMYTHwZfkKI1dsWSHoHBWeYMicdJZ7hKrg8UMAxOlh62JOmvtRq9CXn
         QmwmKCbiDBVjLjaAHjmtd2gB/mm0rtYmeFS/X00/ez+nG8Xi4iet4nkpuS8ytOiZVVfZ
         k9W/fTiSz8JfLQ6dlxYAfx/CUTrgWXBDGclkcoPn+QTZwjyxMUOon2ySqWU/UEdS6krB
         YuQg==
X-Forwarded-Encrypted: i=1; AJvYcCUp512Rey1aog1YdB1C90m1/g4f+DK8FnbI1FmCJHic2DBC1TErb28uOUixQ6ukZOmc0I68//zAK6xoiYctJ7X9jea58n7wtwOH+eMaj++OXugu/n5ZiNZrMzLwf7nPGxAPuUfjqKPNFWY+gRHR
X-Gm-Message-State: AOJu0YwpVmngoN6lWZDGEyqHian9ncJoxxtiGWKJTJv+7N1LAGnDoNiV
	jWaRTT6j9gwonVgogHNDIuAebdMsaXnHTHhsCmCCQnSN3eyEKkmkT1KpzqgE9NVy1NdhI8q4MYa
	UlOYawJRWHFMi5tkIo1mxlDQCjBB/7g==
X-Google-Smtp-Source: AGHT+IHAsDb5+nsNxizNL0s50nQsiWVLkPf55QznG57cKaBnbaVfMJ/g6/XbUdNeCRsat4LY6v+75fSHMUV0aMYRwfU=
X-Received: by 2002:a2e:b016:0:b0:2e1:7acb:6c40 with SMTP id
 38308e7fff4ca-2eadce3f9a6mr4248981fa.29.1717704630713; Thu, 06 Jun 2024
 13:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606114321.30515-1-chris.lu@mediatek.com> <20240606114321.30515-2-chris.lu@mediatek.com>
In-Reply-To: <20240606114321.30515-2-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 6 Jun 2024 16:10:17 -0400
Message-ID: <CABBYNZJdY8Oo5rwoJx7rAFPaTRhYRe7p0CEN52hv+7tBEoYCxg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] Bluetooth: net: add hci_iso_hdr function for iso data
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>, 
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Thu, Jun 6, 2024 at 7:43=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wro=
te:
>
> Add function hci_iso_hdr to get skb->data when packet type is ISO.
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  include/net/bluetooth/hci.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index e372a88e8c3f..b9f8f91f6c7f 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -2898,6 +2898,11 @@ static inline struct hci_sco_hdr *hci_sco_hdr(cons=
t struct sk_buff *skb)
>         return (struct hci_sco_hdr *) skb->data;
>  }
>
> +static inline struct hci_iso_hdr *hci_iso_hdr(const struct sk_buff *skb)
> +{
> +       return (struct hci_iso_hdr *) skb->data;
> +}

We might as well check the skb->len before attempting to cast
skb->data or better yet use skb_pull_data but I guess that is not
possible since you don't want to consume the skb?

>  /* Command opcode pack/unpack */
>  #define hci_opcode_pack(ogf, ocf)      ((__u16) ((ocf & 0x03ff)|(ogf << =
10)))
>  #define hci_opcode_ogf(op)             (op >> 10)
> --
> 2.18.0
>


--=20
Luiz Augusto von Dentz
