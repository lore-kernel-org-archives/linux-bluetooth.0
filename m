Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7F219A89;
	Thu, 17 Jul 2025 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779542; cv=none; b=dObf3O0dVFHBFDmvWc8Ok38ZF8IUWS5HFPRPj/r75ZHDkTdgkekv6I8wiGNUa1mru2BU8dkvdrozEdiXL1AigZyoocOF8GEi4imPvQ+/r6bHw9vlxZ/1JFsGp8ZeL2h+eQrglHWFfYq/bE35eoKgBzU38ri+IIHPZnqT6V9x9Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779542; c=relaxed/simple;
	bh=F+z9dJqtorOP+qQIzHQYSO2CaHwSC7NGKb/mEtxj7+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOxKk4JMMZuxyUv8IZ5ZR5/w334Ge+L/GkU4hG6/PER6AUF2hDdHhFLEXYEp6uzm6V23dstg1fv+DlShdpiZ3kLzbYLfNJJqHM2dEprgtZ0PlC7WW5P26X63zGBgob/cYCjHEH8k5BK8JpfN5xa2vvyX5KOrFvRXb05AAkN88pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSwgFfZG; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSwgFfZG"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32e14ce168eso15159131fa.1;
        Thu, 17 Jul 2025 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752779539; x=1753384339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8cy/I2SGSe5R+g8DSOkgMJeJimpkG4pmlMho5BfIgY=;
        b=HSwgFfZGrwCWl4HPgRYCT4TJAZkiooM2MX8dA3RJqJbzpZUdcysuUPpdmDGfMhrkFT
         NT3lX811+hDFfqQLVuWIcIsLA100o1da08KY3SThAzfLnKqweP2tKW3czv7EZ3z/UqVa
         haK3cC4kea7TXh2+hpKyTuJ6Ro/Hqky3LMK4NgSU8pXkDzkBfKQECy1exTaWYMk0ZnmU
         cJTJ/qcvbj6yZy38WhY1T37hCs2qCVYgrD4o2/cz5Hsf2+wOaV5rH0bU6CYDhBwUfakD
         2QXsALkCTyKZQ00wGp81hHzu53QJUi/Qr0n+kAwtZ/t7Uhna864f6iWAkwUq9HF85CWC
         5rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752779539; x=1753384339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8cy/I2SGSe5R+g8DSOkgMJeJimpkG4pmlMho5BfIgY=;
        b=GXP8Q1+wDTRzK5izhng9ja88ov8cR6EGUdlon6Ax+3HhipqB3Oils7YfSKb9R/LfT6
         Nis3qvl0N0nxTB9gnmunZ1+8zyf6721NYjdiozc63OEj0GcjZkUAzc8Ti35RJL8Emtgo
         9IPDN8ZNqNf5beQyIAimLt+Etg4eoKZug6EuEQ6LEWwtHJppzSQDJe6j+nUxh08Ki9RN
         I4zKxXRTWjLL4J6V2177Ut/zw5GIDUBaRjMHG8OYDpydlAPw80FUKLXQn15avMk/rLie
         KXNNE3QFSTkLWnarAliY2CuSMjHcmBY+IhABlVUXrOaX4HtDRpNoPqpFkYl9eEJOL2qL
         GkIg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ24oiCyuIw3OXBHBmFfRLg9xH9jK+suDWF6FeLXKapuYgy0fJKQCmyvdPbEkmxmDa0VowMRPT/PeXou8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqpRL7aO2jokPiXXhYBljSjjj03EmAe+u+C2wFIVlfw5DchoDV
	vLy3FMKNZiZF/EUT80MxAqQG4GIN3tg/dRCjVoXX+jRe3WWC78/VQEPTmbfx+q50WG1Iu30Nzrm
	324l3mGIl81b52peWx2U+MzT7SjITyyflqfV+S40=
X-Gm-Gg: ASbGnctfg4VH8eJWds78allFUuYRIzDJ4/QTwxxkZ+lqd6dBvoezO7mdf7ar0vCGsJW
	cqD5z6WVfZMm7xR5pQ2SUk49zgBlGVDzFm9WiCeZu8dWSnNAjJz6gF2/7hEYPqecH59aW9fzqW6
	1jhRbTYuLev5YlE5RUEX/fri90XCpOndsyXg0AsGfwMsOcvC2LWBR0ygnVj/DtwaiApsyQ2tLFF
	jLtSQ==
X-Google-Smtp-Source: AGHT+IEsQzxwh6vmqyje9uCfCmyVHTYc98stcN/PtmOAvNGrEr+2cYe5fzrz8IECuPcjkVU9pT++3NB/b/xV/lv38kM=
X-Received: by 2002:a2e:8216:0:b0:32a:7750:a0e1 with SMTP id
 38308e7fff4ca-3308f5df808mr24409731fa.26.1752779538369; Thu, 17 Jul 2025
 12:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aHfd_H6c9MheDoQP@chrisdown.name>
In-Reply-To: <aHfd_H6c9MheDoQP@chrisdown.name>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 17 Jul 2025 15:12:06 -0400
X-Gm-Features: Ac12FXzB_0zUIsSp5xm9ZWt9rc1hLN5Z9bpzBcsaxVhXAwI6y5RADY9QatDFkKs
Message-ID: <CABBYNZJo48983SWhxcB7UzWXPeUofRCMhQ8mJjih-rJoTET3_Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Mask data status from LE ext adv reports
To: Chris Down <chris@chrisdown.name>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@fb.com, Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Wed, Jul 16, 2025 at 1:14=E2=80=AFPM Chris Down <chris@chrisdown.name> w=
rote:
>
> The Event_Type field in an LE Extended Advertising Report uses bits 5
> and 6 for data status (e.g. fragmentation), not the PDU type itself.
>
> The ext_evt_type_to_legacy() function fails to mask these status bits
> before evaluation. This causes valid advertisements with status bits set
> (e.g. a fragmented non-connectable advertisement, which ends up showing
> as PDU type 0x40) to be misclassified as unknown and subsequently
> dropped. This is okay for most checks which use bitwise AND on the
> relevant event type bits, but it doesn't work for non-connectable types,
> which are checked with '=3D=3D LE_EXT_ADV_NON_CONN_IND' (that is, zero).

Can you include a sample trace of the above? Also it would be great to
have a mgmt-tester for example that attempts to generate an
advertisement like that to exercise such change.

> This patch introduces a PDU type mask to ensure only the relevant bits
> are evaluated, allowing for the correct translation of all valid
> extended advertising packets.
>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: linux-bluetooth@vger.kernel.org
> ---
>  net/bluetooth/hci_event.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index c0eb03e5cbf8..077c93b5fae0 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6237,10 +6237,14 @@ static void hci_le_adv_report_evt(struct hci_dev =
*hdev, void *data,
>         hci_dev_unlock(hdev);
>  }
>
> +#define LE_EXT_ADV_DATA_STATUS_MASK GENMASK(6, 5)



>  static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
>  {
> -       if (evt_type & LE_EXT_ADV_LEGACY_PDU) {
> -               switch (evt_type) {
> +       u16 pdu_type =3D evt_type & ~LE_EXT_ADV_DATA_STATUS_MASK;
> +
> +       if (pdu_type & LE_EXT_ADV_LEGACY_PDU) {
> +               switch (pdu_type) {
>                 case LE_LEGACY_ADV_IND:
>                         return LE_ADV_IND;
>                 case LE_LEGACY_ADV_DIRECT_IND:
> @@ -6257,21 +6261,21 @@ static u8 ext_evt_type_to_legacy(struct hci_dev *=
hdev, u16 evt_type)
>                 goto invalid;
>         }
>
> -       if (evt_type & LE_EXT_ADV_CONN_IND) {
> -               if (evt_type & LE_EXT_ADV_DIRECT_IND)
> +       if (pdu_type & LE_EXT_ADV_CONN_IND) {
> +               if (pdu_type & LE_EXT_ADV_DIRECT_IND)
>                         return LE_ADV_DIRECT_IND;
>
>                 return LE_ADV_IND;
>         }
>
> -       if (evt_type & LE_EXT_ADV_SCAN_RSP)
> +       if (pdu_type & LE_EXT_ADV_SCAN_RSP)
>                 return LE_ADV_SCAN_RSP;
>
> -       if (evt_type & LE_EXT_ADV_SCAN_IND)
> +       if (pdu_type & LE_EXT_ADV_SCAN_IND)
>                 return LE_ADV_SCAN_IND;
>
> -       if (evt_type =3D=3D LE_EXT_ADV_NON_CONN_IND ||
> -           evt_type & LE_EXT_ADV_DIRECT_IND)
> +       if (pdu_type =3D=3D LE_EXT_ADV_NON_CONN_IND ||

I'm not sure I would keep checking for  LE_EXT_ADV_NON_CONN_IND, maybe
just return LE_ADV_NONCONN_IND, LE_EXT_ADV_NON_CONN_IND is not
actually a bit it is the absence of any bits being set, so I guess the
only invalid adv are the ones for legacy which seem to require a bit
to be set.

> +           pdu_type & LE_EXT_ADV_DIRECT_IND)
>                 return LE_ADV_NONCONN_IND;
>
>  invalid:
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
