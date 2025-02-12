Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D677720459F;
	Wed, 12 Feb 2025 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399038; cv=none; b=udcTUpnXRrZM9/SZsa1hPRhuOm3T0Cg/cUDyAK2sXCs53GXsDgKRnfdheQeGHI9vj6jfR+nlLCBmHBMliy4LAv/KCxY/oXTUSSRFI39kiqT/hk9Ma7qvc7ENndx2u2EgK+ze/l6ZgtmxQcs0Ap65LzWQR29oe6/Vw2r5i0eGhmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399038; c=relaxed/simple;
	bh=Zm3qk6IXfqOq9LBAuhVvYVET/2+DLHzMgdpfCT9oBiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eP8drDU0dMpK1uW1ENKW8vhQUNEzVHPmv+qc3DsICE/WWENZweDziYSuysbuoSLYRwbkZIJ/D+F3tq2E3PerkzVZHHRvAQgc/RcQWuBrejkVgt3XDbsxwGPxtCnOdIaK8mrOh41qte8TlPdiXV7QhuYoFApvvyN94KD3XEXvmJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJL1HxRA; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJL1HxRA"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30795988ebeso2487701fa.3;
        Wed, 12 Feb 2025 14:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739399035; x=1740003835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzPV8xI6x4DGWcbO/p/xTSDSebleAH+JJRzOXv+eWoo=;
        b=PJL1HxRAyV2Hc1xNZNtbTgLJ7x1OENUpY3TtqsDwMpPvS+kS54MdE4AJs+5j179Uu0
         Jo8AlKz+u6NSFT9pKF0bqJnrjB/wsFK5UHnrI8QW+lRESTy4CLJgKNHOSxYyDH7HGHIx
         zE8GdK1v9ERASitVZJamPvzmK8pdT2Wl/hzKHPZuZcuVULWs5jx4cQoS70SoG5MuSvQf
         YR9uCDKwpOyhO4tPmUGLp5aONF9+PlzQXrkJFZvwzmAMB0BIRotkaW5u/V/gF9TYaAns
         SiIklT112qmGOFFYXGng6XYnQN9gmXs+ixCd/LGqCV8MtTopAJaRteG/Oy/1sWIyshUT
         SQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399035; x=1740003835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzPV8xI6x4DGWcbO/p/xTSDSebleAH+JJRzOXv+eWoo=;
        b=NQ0u2Km9pM7UAE5isBmoFNufE5PR6vSvpXaasYTkt8u/+2WjXMhcdEoyTSSOicnKaK
         nOO32Fh1qnr5GWs6u9bxUkkMuO8Tq9iykKIjmg4AcqhiQCr6I9Z0TiyyVAwqjUsrA80i
         ehdyNoZMVP6LOi3MACLykH1ecyKFSDCHYocyuf+7iw72Mn3rsMnORocaPqOtQ2m0q8Ww
         lmgHhJ7/tmUAHha4ZYH5C2CyacotlTpWaA7r1d4wYGT5+jTGXgqMpTtIdP1nhf+W6GkI
         QOXNSKghvUbM10bHjs0jrgZJDxd6n9TJ/vikY7rMfQ8OxuQpF0jBnblsOiZsNMAwavu9
         7DQA==
X-Forwarded-Encrypted: i=1; AJvYcCUEcr4WCIEKFSXn0d4fhnXiWYOTD3ANWkCz/Yn7OZ0WBU8tNKW3rjC+XABPCetb7alGnolcLXc2bi9jqtYj@vger.kernel.org, AJvYcCWNLGaV0BRbDKIAGUJigfZd7KU6u6CCUyrCiJP3WAzjGDKNcZ3GFhWb2A5mGouoYCI7UBtw1mVrCWwoNiSVCDlB@vger.kernel.org, AJvYcCXkmN3x2bkHJGo5NfqtO+CkmvL3bBahR7y6d63IRQSl7qiFJ29qeeGYrAEEVcHRgg9znyGJQMaMTDX6oI+Pf1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE0I+KTG3nTeKwV/FqYvlinsWVvn6cpzBNkDxtoatXd7izX0wV
	frEt0gWk3ADJit7sPQyX/P+xvRZgGN6F4cLdgPeUFkPyoKcAX45gLO4CByY8IOeIO1NDdDTr6Vs
	KoF0MzmOUCvzy8wWyDuUcvt70zUE=
X-Gm-Gg: ASbGncviwVsysd1LXmEv6AUqIehjeCf0yKgYYwvd/PgFfzCx2dWQEdMFkhnzVTxi9Pk
	7uDgURlBDnxeLyVj192KpKyKr1jRH8bOPwdlnqL9jK37ztfvZurZrofOTSTmKXZdywareSTX4mQ
	==
X-Google-Smtp-Source: AGHT+IFmIMz5/96ffXlGEO/PiEhxi13fP3EW28PYwfbuAOycQ5rgE8G7lU+aTSRRyZoN+hdXnQT+nm4OMAbTotZA8lg=
X-Received: by 2002:a05:651c:1505:b0:308:f39c:96b3 with SMTP id
 38308e7fff4ca-3090ddbfc27mr4014081fa.30.1739399034719; Wed, 12 Feb 2025
 14:23:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f9975604-6a65-4bcc-b532-15fcaa6da0e5@stanley.mountain>
In-Reply-To: <f9975604-6a65-4bcc-b532-15fcaa6da0e5@stanley.mountain>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 12 Feb 2025 17:23:42 -0500
X-Gm-Features: AWEUYZkcyIALuJteIaTDNLZmLlmdJ9IGNfHsTQ6eK0ZDLJ1s_Ft9EEtztmIkhXw
Message-ID: <CABBYNZK-ibR-+ri_+FFiorLkEvT_1tD2YKSOeSuTsyoS4dM1CA@mail.gmail.com>
Subject: Re: [PATCH next] Bluetooth: L2CAP: Fix NULL dereference in l2cap_recv_acldata()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Wed, Feb 12, 2025 at 11:40=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> The "conn" pointer is NULL so this "goto drop;" will lead to a NULL
> dereference when we call mutex_unlock(&conn->lock). Free the skb and
> return directly instead.
>
> Fixes: dd6367916d2d ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_de=
l")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  net/bluetooth/l2cap_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 6cdc1dc3a7f9..fec11e576f31 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7456,8 +7456,10 @@ void l2cap_recv_acldata(struct hci_conn *hcon, str=
uct sk_buff *skb, u16 flags)
>
>         hci_dev_unlock(hcon->hdev);
>
> -       if (!conn)
> -               goto drop;
> +       if (!conn) {
> +               kfree_skb(skb);
> +               return;
> +       }
>
>         BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
>
> --
> 2.47.2

I went ahead and fixed this in place since it has not been sent to net
yet, I did add your Signed-off-by though.

--=20
Luiz Augusto von Dentz
