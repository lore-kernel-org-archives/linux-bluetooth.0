Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7933637A498
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070352; cv=pass; b=HbPS2qLAl8cyYq4evieUADIvrHmrgW3nrjObAcs3FtghaZdnXSzd9yz3LateOzyQSKkU5FDGDr7S6b6OGcZTJzOqu47+3VZpTflVuoaIjp3UxoPQzfzJA2NUe3mdsyVXe9Br9ZFacGmrzUBuI04EeLMX7on3V/FyLRFxivExM6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070352; c=relaxed/simple;
	bh=ty91lziidXZxmAMM66DZHkOcSSsElmV5TL2zAt87H6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1rbtOgdrWqgiivrjVphXeH+/AwvNcJaSdkaxVwPrxpOzygzzjPOD5HG6UzF0ar/bHZqTYjJGzGJQhsZLhfBDm/wp6XGTLZ6F1IUQX4sDREzLRWjHF/xk3I281BxlY8Y5wYvqIhq1FIJcIHVB6ZHDjql79Mz/pjG38h2XbmA7tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX+w3VK7; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX+w3VK7"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8200b55dc47so1107427b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789070350; cv=none;
        d=google.com; s=arc-20260327;
        b=m+HEue+vTUBJDNHIog9Cro9YcOxO6rH3ifJXV71j40vNQQfQ3upu+ItmMbYmkA2bAX
         DYJ1OnWp/KNYjnr8bfpCMwgY4T5xYB0m28IW8yuTxyJsqMdv0X9PTpWgfJS5CBtSNxNL
         mN7A7WWHa11tG98NmfwInuOMQ6UT1HNxMBUNzOWIF+PHei6izkzHw5wnjPkenA7c/A1/
         7gApJR1Ab+FtJ3USA7HMwyZPOPM7HMna1PHbr4zOSJEGMZdWxK09qEsOlKH9KqLVB1OL
         4pWVraGFsyeg219NVZt0vMdMxYQTAHQZbbXpwYr9TehVyJzpivHg0I6+ufxTNQYamAeE
         Apng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x8V9Q/N2TETnzSfWfUpZ6dEVCEuKJUGf18w0ts5/6IM=;
        fh=o3JKAh/qBwWNgSJ2+o8dftIw6ycERjG63tKeUon+7vY=;
        b=p8yQ5caQ+1Xw0bRd1oH5glVU16MJbEmOzZ0BWz5LujBV96jEebSXm2hmA5Duu2/egE
         AH7h83Sst63adFFl42TRc67o7qIPLNLrHZJ4PwdjxP8wxomsTbRibBCmKicLkbspFX3z
         ExuPDzO95BDmuxHg6vFSdIIHS2QgPKoyAUAyiE9G8W8vJAOtWPPYlnWVQByIgAcrAXD3
         YCWjOltOKv2VZDNhkJI50oVA2iTUGGen3TWC6o2LkSZWdut4ia25rBrNfvMuZ/RCOBla
         EuTTrkRc1aghTY3yXJrfPEgGaVp5qXiG1ZPM4aVJsjUWiOPfKbEESOzpuiORZg+BgDZh
         5mnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789070350; x=1789675150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x8V9Q/N2TETnzSfWfUpZ6dEVCEuKJUGf18w0ts5/6IM=;
        b=mX+w3VK7+TYzXs7SulSpJiJMyww50y3L9PZeo57pIqkkJxyRApdCPWe130hI6zjMDL
         lrJxIx00aQVaIPIJMHz0XOonazmAoVCuSBF15gM2VHwzFojVF4JzQWNXou1G5hhWF6K9
         ZhdwVwUB1p0RNC92pk/eVY00ghEm90t67AGXn2b6PycEsTZCmYKHQeZQPFEMGCDFjq6t
         0xEXekyYbpl0E3YLP/ppbg01KoJdjzHGeoPRw5e/WlGHCdaHq5MIjBKgvusxvetQt8dE
         OXu12zNot/cxHWy6f12DRwXiSqHlUsMwRw14wutRy9ZyNVTtyi6c+3a92woPke1AA0ml
         cgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789070350; x=1789675150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x8V9Q/N2TETnzSfWfUpZ6dEVCEuKJUGf18w0ts5/6IM=;
        b=mQTt+ICBhHy7j0LKr8zyzG4eYonxRymquGpej3jybWz9EMAUgWvMFZ3mqa49lQBJPf
         aioykiZNsBAZL0/tzYs72cpnTERZffYK0j1/u/0zHODSydQRPh2ZVoHJ5pggjoYNMksQ
         88SRLjM20Gm2jD7ATRfjwE5YDmZJ1tD+x2nYK9T8jD2oE5dYKBx892UlYKnNIi4+Gwml
         ZqFhI/webL0THLmB/UEX+35CPDdSG6Wk2C+5wc5NYMJXa4K4GyrXAohn4HdkUNO49qdS
         pJsYcmRzy1GAFwrD+BTPWScMW9z/BAmm84RXh/KUm+upgBz+IyJoB4fT6ecUTxWPNMxh
         gdQw==
X-Gm-Message-State: AFuF++k6P8oRR46wxAdvzG5k74vHuCeK2y3Bx1DOzqdVDoFiVTPIm2Xx
	XYvLBHbQlIFCgsUxVj6U057fdpMnjozXLyrGFzw53NtwBBU3yZG35m3pGRqjs8NbIeDe+as4aXP
	ZHiXp9QA2HXl2Fj6sWGF2zblRK37ZX6c=
X-Gm-Gg: AYBFou25clgV56ku9KXg2svv6KbLpfOmzpzAdT5Av2IsrLbM0FUjpK66XnEJYZtAeX4
	glNNkNruiG7t2Pnr2eyK2tgKeEoUm3wIlN0FK2zlAr3jcXxoSv8jqmpl3d3/HqIltuTdTylERLz
	BS2pfjr8v6VB+watyk9QBTHrZT8MDq85piWka/54is0YzQ6gCSAPLBGYed/sxfjiZXRNygaLS6u
	Zdn05LfCN/0Jer61gfJZVSNk90iBcOgdckE0D8VqkUV1JZJN8oJySY5oSG12CpQTzarO87jLH5N
	qXFpX4N7T8aO6QFc60YTgyfJLnEum0xk21LQsMcEkvWS9TKVd9prn/WbOY0DH2FtbkKHPEQt65U
	Bh0URvKEHg0JndMqAs8KzZIwMfiPCpj0nVfBuvF07Dw==
X-Received: by 2002:a05:690c:6e87:b0:841:773e:8d86 with SMTP id
 00721157ae682-884aec92ac6mr5789117b3.15.1789070350256; Thu, 10 Sep 2026
 12:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820140547.1148128-1-lidaoxun25@mails.ucas.ac.cn>
In-Reply-To: <20260820140547.1148128-1-lidaoxun25@mails.ucas.ac.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 10 Sep 2026 15:58:58 -0400
X-Gm-Features: AcwNN1UcCn1NgQQZghiLaxTYFaiVVwdXbhlLm0BkXgLeWRgYGH9EZgSOBXNocPM
Message-ID: <CABBYNZ+meesuqnY1KUzT=khvi6b5V77U58-0ZzrTzgFvVECAPA@mail.gmail.com>
Subject: Re: [RFC PATCH bluetooth-next] Bluetooth: hci_event: Use General
 Bonding for ATS2851
To: Li Daoxun <lidaoxun25@mails.ucas.ac.cn>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 20, 2026 at 10:06=E2=80=AFAM Li Daoxun <lidaoxun25@mails.ucas.a=
c.cn> wrote:
>
> Actions Semiconductor ATS2851 controllers can stall BR/EDR Secure
> Simple Pairing when the host replies to an IO Capability Request with
> Dedicated Bonding.
>
> This was observed with an Actions controller at USB ID 10d7:b012,
> revision 88.91, while pairing a Sony WF-C510. After the host sent
> Dedicated Bonding, no peer IO Capability Response arrived and the local
> host disconnected after approximately 30 seconds.
>
> Sending General Bonding instead allowed the IO capability exchange to
> continue, followed by successful Simple Pairing, link key notification
> and encryption.
>
> Add a quirk that substitutes General Bonding in the HCI IO Capability
> Reply while preserving the MITM bit and the connection authentication
> state. Enable it for ATS2851 based devices.
>
> Signed-off-by: Li Daoxun <lidaoxun25@mails.ucas.ac.cn>
> ---
>  drivers/bluetooth/btusb.c   |  1 +
>  include/net/bluetooth/hci.h | 10 ++++++++++
>  net/bluetooth/hci_event.c   |  4 ++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2bae85b001..e82cb0c44c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4384,6 +4384,7 @@ static int btusb_probe(struct usb_interface *intf,
>                 hci_set_quirk(hdev, HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE);
>                 hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_CREATE_CONN);
>                 hci_set_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_T=
IMEOUT);
> +               hci_set_quirk(hdev, HCI_QUIRK_BROKEN_DEDICATED_BONDING);
>         }
>
>         if (!reset)
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 1641d879db..ee01795ea5 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -320,6 +320,16 @@ enum {
>          */
>         HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT,
>
> +       /*
> +        * When this quirk is set, Dedicated Bonding authentication
> +        * requirements are sent to the controller as General Bonding whi=
le
> +        * preserving the MITM requirement. This is required for Actions
> +        * Semiconductor ATS2851 based controllers, which can fail to con=
tinue
> +        * the SSP IO capability exchange with some peers when Dedicated =
Bonding
> +        * is used.
> +        */
> +       HCI_QUIRK_BROKEN_DEDICATED_BONDING,

I don't think that works out, though; dedicated bonding is used to
persist the bonding, usually triggered with devices like the
Device.Pair() method, so I don't think we can really just switch to
general bonding and expect it to work.

>         /* When this quirk is set, MSFT extension monitor tracking by
>          * address filter is supported. Since tracking quantity of each
>          * pattern is limited, this feature supports tracking multiple
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 2f5e21ff97..5496913d8d 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5386,6 +5386,10 @@ static void hci_io_capa_request_evt(struct hci_dev=
 *hdev, void *data,
>                         conn->auth_type &=3D HCI_AT_NO_BONDING_MITM;
>
>                 cp.authentication =3D conn->auth_type;
> +               if (hci_test_quirk(hdev, HCI_QUIRK_BROKEN_DEDICATED_BONDI=
NG) &&
> +                   (cp.authentication & ~0x01) =3D=3D HCI_AT_DEDICATED_B=
ONDING)
> +                       cp.authentication =3D HCI_AT_GENERAL_BONDING |
> +                                           (cp.authentication & 0x01);
>                 cp.oob_data =3D bredr_oob_data_present(conn);
>
>                 hci_send_cmd(hdev, HCI_OP_IO_CAPABILITY_REPLY,
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
