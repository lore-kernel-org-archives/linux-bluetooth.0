Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1940275877;
	Wed,  2 Jul 2025 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461268; cv=none; b=DFAm3QDYCv7H/3fcSOxVXGClrS3v+hAtxp/8vndr2TFzQ9UOkUXfN8u9DpzgAoQxXK8asJSFKA6VLbHMOVPkoptDxvK/OOjp4ZY/CrdZLobpm1OD4a2ZgRxLR3BjHXu1JQTL5CI5MKHMmVlmyOTykyTsWCceeLPiwl9xwoOOcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461268; c=relaxed/simple;
	bh=oHtjucSZxaZwNJaUYZ6Kk9eISn8K2MSsGiIsH6XwZHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klD81k8R9QlforSN5Ay/gJH784L9xSah7/AZxkri3XXa0/Q+2I2uYu3buMP2Cbu18GxZ5zUaflns22ECF/G8ZDYeCjs5UPL16g3yf96qbPdq6H+MErvuy6rtfWsTlfaqRYtrmxNX7214T0kXiXpJfvJWvqWTj84H7/bF7c/Xp68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GU8rvFqy; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GU8rvFqy"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so35500201fa.0;
        Wed, 02 Jul 2025 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751461265; x=1752066065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xJ6U6fhhyI4HTTHLmRj3kXljBB6GbgNkgKuGIW58iE=;
        b=GU8rvFqypZ7s2IF6PkZ3W1bV0h0SBgBK07RbS4wzv3+Xc8gRaEcq+mCb/V4j0xwue3
         GNA47uYgOqT3r7HvU/V7+ydh+4NPtSNeS7xrttS1XTycmpBnYkXSitEdHVZVZykPc3mr
         ByDiKDOACR/KLVbD4D9rJj8MFSiQU/FVGulX6KP6aS9jKQZ8BuRIWlhhrswXx2Z5KO23
         MfbKF3Cnw+MsmvIF9wsSX96Pnw+NXT6JTI1YlpjF44Qytdx428OwMX8ovlkWahDJBRqT
         7wZcwfji+5SbkPu8w+aXUVcjgrF/KR9zSbeWZ/iMHbKoO1ZBI15jzQTsT8sFumNjSEMP
         K3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751461265; x=1752066065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xJ6U6fhhyI4HTTHLmRj3kXljBB6GbgNkgKuGIW58iE=;
        b=eY/U1k4oqewfsq/SAi/jyyRlWScAoWVtfrFd1yj57aRCxF1GWecconAdWnnTd6lhRV
         lRNzv4KqMavSBan0wedjeQX1VopxbySwLzoEkyoWVVts6CtVREaQfEq5rtAeMDG4C1LO
         lBf2LNoEbChBvIOTutcvJxOSWdspk+j6cQMvwvHGVdyLRpTKGk0JcTDJMXyLqIWPUaUR
         d7E+yeEQw0shLQf88OQHG2MmuP223h0fkE6X+vwfmtuDHjVFKiM9r2KvNqR4xukU6kom
         9rxv658PX7nyc3S416nlZNLUA07YN/U7EhkbdbuS45hLm/OjHK0ISw3qYPcTO0xzQV7N
         ZKZw==
X-Forwarded-Encrypted: i=1; AJvYcCWCOt1dxtF/LyCr9jt08LOTmVTbjvcemKNz8PJ4CtBnK1bhmxLEPqJcDEKS/4JFykXMs1F3ToVHhTE6SWlD@vger.kernel.org, AJvYcCWcSR8umeL70+KzAiLO8qgS45dc1+GsqZlS+HH4+gvyxefQuaUjOonmWH46+xzVDVggq+ZU3JaxKktR0WUtURA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5uQCCN155Oy2CeesobgCmDrQH5kHDjNTqyIp5oZyM3YmMYMat
	WjaM15S6RoKc/ce7ts3IIB5ygu/U7NM9bpPKoVvtT+PwICsmcwbUC39a33vNIXtVaWsHdqgVv7T
	rArr4yc0nXIAs1kJrcHRwh+Icnq/kJyc=
X-Gm-Gg: ASbGncsPYzGTeMcposTSLKdHYm3wheFiKkDw9ZGavZC7c6s1GPBgY9trRc8LSDco5LG
	mNO5zw08RcaARLRv4egjU5GCmAKeoysM7MfhwlCTRYTfXtuVMP9FCRmzBsWEvefR3iY8LVjCenC
	GVcn5qAcXYD4bIHWFl2OEdmemufwFwD341ln7Dwn/Jrw==
X-Google-Smtp-Source: AGHT+IFOJ9w83aEKdkUoh7hkyEX+qUzPTvBWRn9piUx0ibukE4EIxsk9AEX+lHieMZM0lBTt9X8bvZifhUwojgcUYAw=
X-Received: by 2002:a05:651c:410d:b0:32b:9652:2c13 with SMTP id
 38308e7fff4ca-32e0004b7a1mr6909941fa.26.1751461264170; Wed, 02 Jul 2025
 06:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-hold_pa_sync-v1-1-3cbdd2c29c41@amlogic.com>
In-Reply-To: <20250702-hold_pa_sync-v1-1-3cbdd2c29c41@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Jul 2025 09:00:52 -0400
X-Gm-Features: Ac12FXyRW2MhuSvqwUw4Z_lzyvzs1WEciN9JQiSM4B0YzxVkuBz1iY64-8a4FDI
Message-ID: <CABBYNZJJJcjhwbDwYZxqxu-RHtyUd9T3Lvf-qEqgNfxfCsk+9w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Hold PA sync conn when BIG sync established
To: yang.li@amlogic.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 1, 2025 at 11:12=E2=80=AFPM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> Hold PA sync connection to prevent cleanup during hci_conn_timeout.

You will need to do a better job explaining what is the issue here.

> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  net/bluetooth/hci_event.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index e817c4a77f97..85ae1608e028 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6968,6 +6968,9 @@ static void hci_le_big_sync_established_evt(struct =
hci_dev *hdev, void *data,
>
>                 if (!ev->status) {
>                         conn->state =3D BT_CONNECTED;
> +                       /* Prevent cleanup in hci_conn_timeout. */
> +                       hci_conn_hold(conn);
> +
>                         set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
>                         hci_debugfs_create_conn(conn);
>                         hci_conn_add_sysfs(conn);
>
> ---
> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
> change-id: 20250702-hold_pa_sync-91ca7a81adf0
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>


--=20
Luiz Augusto von Dentz
