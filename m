Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7218C19
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713389272; cv=none; b=Bj9xZllEb6+F2MAJuc2/Z8Hs+BHRsQh4QmOA8pMFfC2U2nSPE5sZjiUG457pGp/O18gO9J8NMFg+ZF82hQ3zsE93cTTCebkYpMDuEVnH5ofovYlqxXMjhb+zXGQhWsJ1xv6wqjDwEERXrEbno/7G4hdZxiqBhVH+rpW3gECWxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713389272; c=relaxed/simple;
	bh=24AGLOTKEK2yvBm+JCW+KhYF0U2RyyIe/xXmz6xDDyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUkmb0vBYLadPoqvJ30QRvbJ4VsmMHpgov+S4e/cksz616e2Zo8uMMyhjhIW2VAksDi5tANy0rIVAHs+NUco9FbYhuYypIaz1miq4U/SFqzOSP+EYDKgo6L2eN/d06kmS4iEqNj+sIpsuS15SGpvPwskoYJXKKigni0KoQ6x70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V04z0Y7b; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V04z0Y7b"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so3928481fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 14:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713389269; x=1713994069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NJ8qoLOtThMeVWfj9en2g/yXE+5JiXhbDzivXcvPeM=;
        b=V04z0Y7bXyfkqN2RFrByAqNiv6AtmGy/d51TcX9uv9/2beKDqwJlMLH67zkTlZmGZd
         18olfi1O+m6mvWMIe1DGzn52XyewWE7o2o14qC+2yvUl4Bjx0y8LFUZusWW8U1Hm9ScM
         zI3Jd9m6Rac3UZGdGCaDLXz5zM3RMMKzJdAFpIn8EsrY+zmFWsGPOOGdugsY/K5hJVNK
         SmWkc4tioBI8KmGxEARUda+2Ln6EwspiYhR6x+kPlBq2x4kzCDZ7hls73XABe6Dn1MZZ
         8pCEIj7ndYEf32vC4wxrRM6k5S+GsaTTp0kyGFhaG89PxRihUiQMu9Z7al2qcCFnSDpH
         h5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713389269; x=1713994069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NJ8qoLOtThMeVWfj9en2g/yXE+5JiXhbDzivXcvPeM=;
        b=Q2b0DAKq2GGbUcX6YeE3WZGUOvMqEuP3aXFPK8Avm5vaNUF9qE7dZLgte21mZmWum5
         a469wxFZvNg7ijNmk25uM09HgL+hsA2VQ8kiWPFnXdqD9zJHREDpCjvX0zsX5vG/ViMt
         FmX0Qz6Y2pVgsh16pmx2tJ0tUio7scqNh522QLe2F4k+AB1/XSfnLyDN0nEqBHgYiTuh
         R5NfkjD9XH6XyWUlZcSYvLedxq7p7DZaXlHrI1X2zGvbQlaQUgUyU1gSuEL6wbYo5x/G
         YeH5sNfs7zPqg1HIoxmGUmgIa+2H4BAbFWON8rLmSMzeTXEdHYsoYhOTh3gmEjbr3aKR
         jBxg==
X-Forwarded-Encrypted: i=1; AJvYcCUrARjaZo7eBTsOjAK+b1RycrKZFh28zgVN7mr1Ji+jHwDze4zby1u4R5QS2Ml0sSaNu8lihjv4aV0SRaSuDK540ygwNTNFLd06sJqqjI+b
X-Gm-Message-State: AOJu0YyUSik+Dhr6G1XqO9+0ZVTBdDw8NRiji0qK7D1NlxoLBUz42s3W
	dIdXotoPfao+btcCm2gIBLD+A82yXf+PmtFktkDs+ziJsuh76FUc05yl1LE9oCeMShKZgUL1TGN
	fvt1sTB+bZRf1Kcyi1uY8u3GSFTo=
X-Google-Smtp-Source: AGHT+IG3JVu55nE1YZgjQY6V62i4qwNwyCUTR17RgjyDjpnnVpdwrrZLPBcvVTcdrJOOwd1f8O+Nggeq9ZkAsXF2zbo=
X-Received: by 2002:a2e:a784:0:b0:2d4:6a34:97bf with SMTP id
 c4-20020a2ea784000000b002d46a3497bfmr340822ljf.49.1713389268688; Wed, 17 Apr
 2024 14:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com> <1713358336-29619-4-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1713358336-29619-4-git-send-email-quic_zijuhu@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 17 Apr 2024 17:27:35 -0400
Message-ID: <CABBYNZKPK8d2yKKDnpNrr0vYj1u4wygvL-bSuDva31mY-4BwEw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Bluetooth: hci_ldisc: Add a ioctl HCIUARTSETPROTODATA
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Wed, Apr 17, 2024 at 8:53=E2=80=AFAM Zijun Hu <quic_zijuhu@quicinc.com> =
wrote:
>
> HCIUARTSETPROTODATA is introduced to specify protocol specific settings
> prior to HCIUARTSETPROTO, for protocal QCA, it is used by tool btattch
> to specify soc type.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/bluetooth/hci_ldisc.c | 10 ++++++++++
>  drivers/bluetooth/hci_uart.h  |  3 +++
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.=
c
> index a26367e9fb19..4be09c61bae5 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -506,6 +506,7 @@ static int hci_uart_tty_open(struct tty_struct *tty)
>         /* disable alignment support by default */
>         hu->alignment =3D 1;
>         hu->padding =3D 0;
> +       hu->proto_data =3D 0;
>
>         INIT_WORK(&hu->init_ready, hci_uart_init_work);
>         INIT_WORK(&hu->write_work, hci_uart_write_work);
> @@ -795,6 +796,15 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty=
, unsigned int cmd,
>                 err =3D hu->hdev_flags;
>                 break;
>
> +       case HCIUARTSETPROTODATA:
> +               if (test_bit(HCI_UART_PROTO_SET, &hu->flags)) {
> +                       err =3D -EBUSY;
> +               } else {
> +                       hu->proto_data =3D arg;
> +                       BT_DBG("HCIUARTSETPROTODATA %lu okay.", arg);
> +               }
> +               break;
> +
>         default:
>                 err =3D n_tty_ioctl_helper(tty, cmd, arg);
>                 break;
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 68c8c7e95d64..fc35e9bd4398 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -18,6 +18,8 @@
>  #define HCIUARTGETDEVICE       _IOR('U', 202, int)
>  #define HCIUARTSETFLAGS                _IOW('U', 203, int)
>  #define HCIUARTGETFLAGS                _IOR('U', 204, int)
> +/* Used prior to HCIUARTSETPROTO */
> +#define HCIUARTSETPROTODATA    _IOW('U', 205, unsigned long)

Don't think this will gonna fly, Im not going to introduce vendor
specific like this, besides if the kernel is not able to discover this
data why would userspace be?

>  /* UART protocols */
>  #define HCI_UART_MAX_PROTO     12
> @@ -71,6 +73,7 @@ struct hci_uart {
>         struct work_struct      init_ready;
>         struct work_struct      write_work;
>
> +       unsigned long proto_data;
>         const struct hci_uart_proto *proto;
>         struct percpu_rw_semaphore proto_lock;  /* Stop work for proto cl=
ose */
>         void                    *priv;
> --
> 2.7.4
>


--=20
Luiz Augusto von Dentz
