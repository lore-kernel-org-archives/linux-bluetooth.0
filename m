Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2D11D47C3;
	Wed, 19 Mar 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404403; cv=none; b=pnWWa4n+brmjp/HGywzenDZw67zkMNev6K72svFG+HHlgmRFgvAKdzvEWC3de9F1zTHA4ktGDJMaDP1m5SHY1sIEwbwd4NGjiEH+Uej4wcXQFpim4DeR8PeGUEc3lniiZvx17b/OxHqcE84OMFtpWWQYRo9pTiWdT/fbT74uvyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404403; c=relaxed/simple;
	bh=hRSmVjV0rceokmbdBVXihtPIiricMpaKWBhS3mUGQ84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntpJFDJB3vxGwLe8Q+0/PVrGLiObs644z1PU21egN7emVHIA3fq5iGsWyFACTixcmK22Ng0umB/IsdwZi8UJGsgI1n5NfURNj1wjdX121ovK022RjzRC6SSuvYQ+Jujumim9SdP6JdWtsNwkV9zuZBH5Rh8nYtfGwzEj5kvTfnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHNv3HLR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHNv3HLR"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30c0517142bso62729601fa.1;
        Wed, 19 Mar 2025 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742404399; x=1743009199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsY55RCNGyHfx6aZMWvZi3TVmt7S40UABNFgJQXxiqk=;
        b=XHNv3HLRVuUKz4/5Uk/nm7vbZS9nIZOhtZJ2ppaQhdm2DeSZuXUiY5oNfY8olJpFpZ
         fp/HL7inX+1lUyu32+tYrAqojco7WPo/83VNMq0K7x39wpIuwqcWUoAErarXHFj6RmTX
         951Nqe4p3gexjHpfQggYy94h6/+VHucX2ia+QyXglBIut1El1qa4b6R2KTQGesluu9Sw
         ekepG7NMJfbbWxeAx5djgtfXJsOTYrTsbAIiIrF+mBPWrBf3JFEj/TXud0DBe4C6y2Zx
         Lfbggo8L0veiN+QevNIA1uPJUcOxt36j+FN5P6e4KKGzuHIIKg3umqdFDXaWnq5pChx/
         ITTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742404399; x=1743009199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsY55RCNGyHfx6aZMWvZi3TVmt7S40UABNFgJQXxiqk=;
        b=Pznxkz2Wj76VSrvttdNPDLX9dUz7VWcTJQBnF83xciqHJQdsLWdrXim6+rJQ3JOBWv
         Std3VPPbsmKY8uZyV/RNg3zI+KIQ42e8P32Q/okBJvzukGutSfAj8pmp7UQrQWtqAxYL
         g559gZn3ExVOxO02t3jRFjdljGji/ytTKyH8SuUiBnfDxqSOp0qkNPwb6xqLN5qK2IG6
         YhjvmxO8Rxemeu2Igl7SO//7lhBeNMS8M1/FXECGNhV+vawaQdKcI2sNQqXvG/Emcf1R
         JegCitPGekcP4W7OzeKBPiq8rMIDIbMyG6fH3n7KAJEniBRcZRm3pCSFI4Gu4HVrsa5h
         wbsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSniPWeCUdSCFLA7oGe8Yln4S0eZxI/FmVKLev2vVSpkx97fOAQwabRiOp4MSylHn+FgtIi3Ua576xhM+OXWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAw9D4kxOJDB/J/S6A0QVBI4FYY9M3BTK4cgtablEE90fA08k3
	0dcu4ftPfgxi7zd9NkuNdgZUopsJTr8HHEO9gUU5VHtvnxP6IryPczKx9Gl0pjfXFY27HgJsGDI
	UJY6TSBcRK19F94cR0lINfTXqsc1E4M3F
X-Gm-Gg: ASbGncsFscVOFRCxJEpyPHOAMQvM/V39RoHjCehX+/hh3S1fHbTf3SaRiqLtbMd2FRb
	q+THgxXmif0io/c1gFvoa6ycnHRLY5NREfGmakGsJHrfCnHkJpKoZX7ggkNUNcY9SrBqkl1CYZo
	LUAUxzix8WplAfK7V+J/tWmnsn
X-Google-Smtp-Source: AGHT+IF7eRn9Qqhav+r0W/aY/lFt1sOQv82hZIOgKM7eemFDpOso9Z0b+SPrjotbCDewAWU+h5BP24ocBqe0I2x6GR0=
X-Received: by 2002:a2e:b608:0:b0:30c:177c:9e64 with SMTP id
 38308e7fff4ca-30d6a44ba5dmr14153701fa.35.1742404398839; Wed, 19 Mar 2025
 10:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2b612e2c1f4fa697b47b5dd9b72f1949d7c206f5.1742324401.git.calvin@wbinvd.org>
In-Reply-To: <2b612e2c1f4fa697b47b5dd9b72f1949d7c206f5.1742324401.git.calvin@wbinvd.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 19 Mar 2025 13:13:06 -0400
X-Gm-Features: AQ5f1JrFeLGkw9l24ev3Eh-rv0QrNx4gxklCjtOgd0nIm834e1eCZJ9mox2auDM
Message-ID: <CABBYNZ+ONkYtq2fR-8PtL3X-vetvJ0BdP4MTw9cNpjLDzG3HUQ@mail.gmail.com>
Subject: Re: [PATCH][QUESTION] bluetooth: Remove duplicated h4_recv_buf() in header
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, 
	Neeraj Kale <neeraj.sanjaykale@nxp.com>, linux-bluetooth@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Calvin,

On Tue, Mar 18, 2025 at 3:31=E2=80=AFPM Calvin Owens <calvin@wbinvd.org> wr=
ote:
>
> Hello all,
>
> In the course of other debugging, I've discovered that h4_recv_buf() is
> almost completely duplicated in an inline header definiton, and I don't
> understand why.
>
> I'd like to clean this up: see the patch below for an explanation.
>
> Does anybody who was around at the time remember any more details about
> this? Or failing that, perhaps somebody with access to the bpa10x
> hardware can test it with the core function?

Don't think Ive been involved with kernel internals for this long to
give you an answer, but I assume it was due to alignment differences
in the drivers, but it looks like you could only find bpa10x, which
seems to be a usb driver for a single model (Tektronix BPA 100/105
(Digianswer)) and a quick google seem to refer to a protocol analyzer
for Bluetooth 2.1, so it is not really a regular Bluetooth controller.

> Thanks,
> Calvin
>
> ---8<---
> From: Calvin Owens <calvin@wbinvd.org>
> Subject: [PATCH] bluetooth: Remove duplicated h4_recv_buf() in header
>
> The "h4_recv.h" header contains a duplicate h4_recv_buf() that is nearly
> but not quite identical to the h4_recv_buf() in hci_h4.c.
>
> This duplicated header was added in commit 07eb96a5a7b0 ("Bluetooth:
> bpa10x: Use separate h4_recv_buf helper"). Unfortunately, there was no
> discussion about it on the list at the time:
>
>     https://lore.kernel.org/all/20180320181855.37297-1-marcel@holtmann.or=
g/
>     https://lore.kernel.org/all/20180324091954.73229-2-marcel@holtmann.or=
g/
>
> This is the diff between the two implementations as they exist today:
>
>     --- /home/calvinow/orig.c   2025-03-10 14:43:18.383882623 -0700
>     +++ /home/calvinow/copy.c   2025-03-10 14:42:57.109953576 -0700
>     @@ -1,117 +1,100 @@
>      {
>     -   struct hci_uart *hu =3D hci_get_drvdata(hdev);
>     -   u8 alignment =3D hu->alignment ? hu->alignment : 1;
>     -
>         /* Check for error from previous call */
>         if (IS_ERR(skb))
>                 skb =3D NULL;
>
>         while (count) {
>                 int i, len;
>
>     -           /* remove padding bytes from buffer */
>     -           for (; hu->padding && count > 0; hu->padding--) {
>     -                   count--;
>     -                   buffer++;
>     -           }
>     -           if (!count)
>     -                   break;
>     -
>                 if (!skb) {
>                         for (i =3D 0; i < pkts_count; i++) {
>                                 if (buffer[0] !=3D (&pkts[i])->type)
>                                         continue;
>
>                                 skb =3D bt_skb_alloc((&pkts[i])->maxlen,
>                                                    GFP_ATOMIC);
>                                 if (!skb)
>                                         return ERR_PTR(-ENOMEM);
>
>                                 hci_skb_pkt_type(skb) =3D (&pkts[i])->typ=
e;
>                                 hci_skb_expect(skb) =3D (&pkts[i])->hlen;
>                                 break;
>                         }
>
>                         /* Check for invalid packet type */
>                         if (!skb)
>                                 return ERR_PTR(-EILSEQ);
>
>                         count -=3D 1;
>                         buffer +=3D 1;
>                 }
>
>                 len =3D min_t(uint, hci_skb_expect(skb) - skb->len, count=
);
>                 skb_put_data(skb, buffer, len);
>
>                 count -=3D len;
>                 buffer +=3D len;
>
>                 /* Check for partial packet */
>                 if (skb->len < hci_skb_expect(skb))
>                         continue;
>
>                 for (i =3D 0; i < pkts_count; i++) {
>                         if (hci_skb_pkt_type(skb) =3D=3D (&pkts[i])->type=
)
>                                 break;
>                 }
>
>                 if (i >=3D pkts_count) {
>                         kfree_skb(skb);
>                         return ERR_PTR(-EILSEQ);
>                 }
>
>                 if (skb->len =3D=3D (&pkts[i])->hlen) {
>                         u16 dlen;
>
>                         switch ((&pkts[i])->lsize) {
>                         case 0:
>                                 /* No variable data length */
>                                 dlen =3D 0;
>                                 break;
>                         case 1:
>                                 /* Single octet variable length */
>                                 dlen =3D skb->data[(&pkts[i])->loff];
>                                 hci_skb_expect(skb) +=3D dlen;
>
>                                 if (skb_tailroom(skb) < dlen) {
>                                         kfree_skb(skb);
>                                         return ERR_PTR(-EMSGSIZE);
>                                 }
>                                 break;
>                         case 2:
>                                 /* Double octet variable length */
>                                 dlen =3D get_unaligned_le16(skb->data +
>                                                           (&pkts[i])->lof=
f);
>                                 hci_skb_expect(skb) +=3D dlen;
>
>                                 if (skb_tailroom(skb) < dlen) {
>                                         kfree_skb(skb);
>                                         return ERR_PTR(-EMSGSIZE);
>                                 }
>                                 break;
>                         default:
>                                 /* Unsupported variable length */
>                                 kfree_skb(skb);
>                                 return ERR_PTR(-EILSEQ);
>                         }
>
>                         if (!dlen) {
>     -                           hu->padding =3D (skb->len + 1) % alignmen=
t;
>     -                           hu->padding =3D (alignment - hu->padding)=
 % alignment;
>     -
>                                 /* No more data, complete frame */
>                                 (&pkts[i])->recv(hdev, skb);
>                                 skb =3D NULL;
>                         }
>                 } else {
>     -                   hu->padding =3D (skb->len + 1) % alignment;
>     -                   hu->padding =3D (alignment - hu->padding) % align=
ment;
>     -
>                         /* Complete frame */
>                         (&pkts[i])->recv(hdev, skb);
>                         skb =3D NULL;
>                 }
>         }
>
>         return skb;
>      }
>
> It seems fairly obvious from the above that, if alignment is one,
> hu->padding is always zero, and in that case the two functions behave
> strictly identically.
>
> Since that is the case for every driver except hci_nokia, clean this up
> and let them use the core function. I've done some light testing on
> btnxpuart, so far everything seems to work.
>
> I would love to eliminate the duplicate function entirely, but I don't
> have access to hardware for bpa10x. Since bpa10x breaking was the
> original justification for the change, I've left it there for now. I'm
> hoping somebody else can shed more light on this.
>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  drivers/bluetooth/btmtksdio.c | 2 +-
>  drivers/bluetooth/btmtkuart.c | 2 +-
>  drivers/bluetooth/btnxpuart.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.=
c
> index bd5464bde174..47d1073fb4a4 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -29,7 +29,7 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>
> -#include "h4_recv.h"
> +#include "hci_uart.h"
>  #include "btmtk.h"
>
>  #define VERSION "0.1"
> diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.=
c
> index c97e260fcb0c..aeb111a0f242 100644
> --- a/drivers/bluetooth/btmtkuart.c
> +++ b/drivers/bluetooth/btmtkuart.c
> @@ -27,7 +27,7 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>
> -#include "h4_recv.h"
> +#include "hci_uart.h"
>  #include "btmtk.h"
>
>  #define VERSION "0.2"
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index aa5ec1d444a9..e6db563088cb 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -21,7 +21,7 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>
> -#include "h4_recv.h"
> +#include "hci_uart.h"
>
>  #define MANUFACTURER_NXP               37
>
> --
> 2.47.2
>


--=20
Luiz Augusto von Dentz
