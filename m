Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1F84AEE2
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573707; cv=pass; b=tWSzCAf2jMeO1K0icXFXpk2YVwzhKp9qQ2YcxUMEoNq1IUARLugRw4lshufJUTVJSm+YP6D0OGiivR7rtg6JyahLLUIJcfdKHgGHncVcCH1qypazisLKe3QMEc5V34plU2C+xQbxk3T25Cahf28X7Y+dWgKId5EKT0NZk181ICU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573707; c=relaxed/simple;
	bh=eVsxr0t9Fw2c0fWOeoXpNiaWDH7faElE7igJEVdU2jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emezLG6MCLj5+X7v28/MfbjCo/L4X3JiGHyTi9lQ+7yz9ykOhUHKDjGukPFMoZwngdosuKS6NcG+Z+Uwcy73a2XfK1YguqpxFnwayDHGZQgMJOr/U7+REabKEIu3HjlQ878201xYAPHpMiApuApSY2asZ2YiNUVFqXwJ6vcxdF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0+i+o/z; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0+i+o/z"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ef161129bso4174746d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 07:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775573705; cv=none;
        d=google.com; s=arc-20240605;
        b=hsb4BYHuVJmuUs9QKjja6EznZAUU0IrTeTg5QUH2PuBuUM3pVV7/WNXloVgaXbLwAi
         NuVi+DeH91AoA0qKbZRhRLMje8nfP4P/J+tkEFtv+0qgBy27yc4gQX5fkp7w5i6g+v+T
         vvhuHQl+C+f1ZHaoN3SFFJrn0dwY3U6gI1c8pcUn71GGmfZyciYHUe8JGf7y79k7ve/1
         ysOnUfab7DS+u0jlgfP4+rA3wwrXpglI552EJTQRz1rt/GzMGMxrwcVRCPitreWBuNie
         QCaCYuWBOTrBv4AHxQcjS49RmzWQOGAGYzdaoiKVBKfjOG0BErffLj+yI5qNLSGHk8qj
         S7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7O+zSSK3GIsBsnq81maqI5w/67B+NUUKHtZOyjDy8dE=;
        fh=6EeECuHNuBLCqlaYjGRBxONu/+r2ru0fCrTPKK5dPvY=;
        b=lcQ90DFfg3R9CKDmXVCuM8yYacPHdC1UO7XgrDDeRRokC6wVkULalqwqJ+vQUSl9QE
         dYR1wK80EIYSz+KjSC09+JHPFdabvZOKCwy2BuSvVbzyJByYrPnICmbAegu2zW8d5sJy
         NPabuupOaIWHkoj80Oy1bfs2O+9Urolr+kfSfZiBnlur4fVTKDkYu+nr0FBLQc+TXxKF
         QDk1aUuZ7BSMw212q55jA7V2X4tk3WciPVR6mEtipxl2Ls5wJeB1FFMEEU51N2AXvSqc
         H6a0WTlFLa/B4x/g68jfXWpt5NpQb31C4QKdbmciJXZDlYoOURTgkIPY+yFyIsZytzz0
         Q4WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775573705; x=1776178505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7O+zSSK3GIsBsnq81maqI5w/67B+NUUKHtZOyjDy8dE=;
        b=r0+i+o/zeWSLfN0XzAMGmKZWSVREhRuVusA3eDieXxAMStAN39S2mwVS0sHmY3jgXl
         neRJklJbLx0HyhITCkzRedM5PvOHKggCvz9mtBW6E7ZgS2hFFzvfk+XU+1nHrNcS1iYR
         CcORtD+C9ildMe1Ar6WzYo7A9+UYFhjZGAaMWs3mgBzY1wTDdZt5I+ZjkvP4vBpQCqry
         uCg3MmapL0QLUWK3q5mLskxjOAfo+9pvmaO2n3iBupOoGbjqjb+UvotRdZmrsoizZAtC
         3koYhaKtG/bAOzTGsDCCPoGFoWBB5TQWpiCVLA81m8gOQ4ImpCBgJPmUulrL5+Vw/1p/
         4/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775573705; x=1776178505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7O+zSSK3GIsBsnq81maqI5w/67B+NUUKHtZOyjDy8dE=;
        b=iyJlLSH72kaZZUxWvaKUcojGCIlYoX3RngZ8oOdzQtLR6XLhvdR5W8X9UNJ8GjS0K7
         sOr2qMKvxrO3BOP+1h2L3sR+qytESV6ExUoskuhLrwUsWwhaaTtxZVXNAE7aIFPldOVf
         432gad3XFqtVWyCIxUDnsqLVYcHyNe5T3zte4dQYZjkvpPKyPGuSJzjwYqa5VkDjccDL
         BJkkMwW6rV1ToLRmMEeNLuBl2yHSBRbyoipepFjshcKM/Ic8qsjubeziI8QeWuAkyUz4
         UrUN6MHle574WQtTFLHSd2xU11z3N7N/YOcfD4xca2VaYwGHudUGSuaNoVFmUSvtr9lx
         X6ww==
X-Forwarded-Encrypted: i=1; AJvYcCVNG3cm7526SJ2BM/hnpOZ51kLI4JfmwflPsrlQsgvGkDSAXurF4uvATnWV4gbl7WdCZQxD0mAy+V+M/T2ZDvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/i3lMSSAZPRHOfua65izKaDs1MCrhzfaw7S7oMSS5fTYEa3S2
	CBDboxTpFud1j6svNxigvdg8M5v1cmI9fbFZ+SqmJkJP1qLu+4JM4rdhCPYyr2Tn+Fm7hYLMbrH
	PYKikpbLZd/vq6+g9fEP21j+O3eVv/PA=
X-Gm-Gg: AeBDieuvway49P75rXoP6BVdNx1d96O/mJ0RvqLWVwmfo1deRj2MhBTTkyWGMHdek8Y
	3R4BzfTv3NfNU5OhGPwq60GjoJDAYFjqGclIur2iGt8mBYjRC9HHsbHYqgIOuUYRp1iPO/CXgyn
	0MuvVvjI3lv7b7/Hh/dnI7t1QMK7LOMiPXRqzSaGj/5I67RRCFiZ+UcC8d/bHQYtYXmOKg8fINa
	W4TRRU11LicBQvy1H87UpA6kWOZUHODQZsX5NdugZcYI5tuemjlv/rRoluuqhGWX5skoY3HA0ka
	jFf03g4E6Cg3yFx6ZiAVxnweAg9t/WFVIR1l2Zomt5YVxoHC6UcDOqx0PnB+dQAnNS552TuywVp
	ZPw==
X-Received: by 2002:a05:690e:1482:b0:650:7a8a:f89e with SMTP id
 956f58d0204a3-6507a8afa29mr3439862d50.9.1775573705119; Tue, 07 Apr 2026
 07:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407114851.3087886-1-chris.lu@mediatek.com>
In-Reply-To: <20260407114851.3087886-1-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Apr 2026 10:54:53 -0400
X-Gm-Features: AQROBzAHknm1LcaBHn6KcplFZfkI-H597cHtdCF_vlpcMyfjpqsUG1hHk8Yd4sw
Message-ID: <CABBYNZ+xi_ktCMSeXP_aNTVLZzKoz+Ye4gFZFvF7eiMRZcULww@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btmtk: add event filter to filter specific event
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>, 
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Tue, Apr 7, 2026 at 7:48=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wro=
te:
>
> Add an event filter to filter event with specific opcode to prevent BT
> stack from receiving unexpected event.
>
> Event with opcode 0xfc5d is generated when MediaTek's Bluetooth enable
> firmware logs and is not expected to be sent to userspace.
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
> v1 -> v2: update commit message
> ---
>  drivers/bluetooth/btmtk.c | 22 ++++++++++++++++++++++
>  drivers/bluetooth/btmtk.h |  7 +++++++
>  drivers/bluetooth/btusb.c |  2 ++
>  3 files changed, 31 insertions(+)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 55516b4602db..302d6ddf9062 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -1503,6 +1503,28 @@ int btmtk_usb_shutdown(struct hci_dev *hdev)
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(btmtk_usb_shutdown);
> +
> +int btmtk_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       struct hci_event_hdr *hdr =3D (void *)skb->data;
> +
> +       if (hdr->evt =3D=3D HCI_EV_CMD_COMPLETE) {
> +               struct hci_ev_cmd_complete *ec;
> +               u16 opcode;
> +
> +               ec =3D (void *)(skb->data + HCI_EVENT_HDR_SIZE);
> +               opcode =3D __le16_to_cpu(ec->opcode);
> +
> +               /* Filter vendor opcode */
> +               if (opcode =3D=3D 0xfc5d) {
> +                       kfree_skb(skb);
> +                       return 0;
> +               }
> +       }
> +
> +       return hci_recv_frame(hdev, skb);
> +}
> +EXPORT_SYMBOL_GPL(btmtk_recv_event);
>  #endif
>
>  MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index adaf385626ee..08b73927c8f3 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -218,6 +218,8 @@ int btmtk_usb_suspend(struct hci_dev *hdev);
>  int btmtk_usb_setup(struct hci_dev *hdev);
>
>  int btmtk_usb_shutdown(struct hci_dev *hdev);
> +
> +int btmtk_recv_event(struct hci_dev *hdev, struct sk_buff *skb);
>  #else
>
>  static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
> @@ -296,4 +298,9 @@ static inline int btmtk_usb_shutdown(struct hci_dev *=
hdev)
>  {
>         return -EOPNOTSUPP;
>  }
> +
> +static inline int btmtk_recv_event(struct hci_dev *hdev, struct sk_buff =
*skb)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f9d515ee9124..daf8a387e660 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4150,6 +4150,8 @@ static int btusb_probe(struct usb_interface *intf,
>         } else if (id->driver_info & BTUSB_MEDIATEK) {
>                 /* Allocate extra space for Mediatek device */
>                 priv_size +=3D sizeof(struct btmtk_data);
> +
> +               data->recv_event =3D btmtk_recv_event;
>         }
>
>         data->recv_acl =3D hci_recv_frame;
> --
> 2.45.2


https://sashiko.dev/#/patchset/20260407114851.3087886-1-chris.lu%40mediatek=
.com

Both issues seem valid to me. That said, I wonder if it wouldn't have
been better to allow drivers to register with its own struct
hci_ev/struct hci_cc tables, that way the driver can extend event
parsing rather than intercepting it and performing custom parsing
which can lead to bugs like the ones mentioned above.


--=20
Luiz Augusto von Dentz
