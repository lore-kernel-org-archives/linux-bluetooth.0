Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78D187346;
	Thu, 30 Jan 2025 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262259; cv=none; b=NfypKwvtaw5lPEtbzl9XxMYiwVk3BbDDFtLuI4U7Hhf7AWNbJT5H+x7hJV7NYafEAzyly72F+r30pLQBNUl4B5upzieM9OpP3mZXuxD6yPaW/dORuXwdqcvUpI2UOzLMd6KCdLSVaM1qioTgffKqKlSgdhtoTJuLbOnqKErDULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262259; c=relaxed/simple;
	bh=vOwZ+ACAFpMPdDLsWCC7+eR5A4+jCPqA+ASIm8GRAzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R29y+eYUf7q6KB0Kqd0p1eEcgBi9XKKPgWcyA0ZKC1/B9dE1b7FUCca4zJh5Rl46ZIAgaHkxkrM7OyTn1dMe87x4k6WpaThfWhdk1zqzZL5b3TXtYNRar+Oo8HEFmxmiVhGiWlLtzkTIRFp5MHgMoqp2WwfjNbLwHSo3mZeJfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yedl69cZ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yedl69cZ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so1402244e87.1;
        Thu, 30 Jan 2025 10:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738262256; x=1738867056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRQgpcZ93mW5DBGdzNIoBycuwMkboGtcanKKs6jsCyI=;
        b=Yedl69cZnOnJB1TETA5M7Ou5Z/S1aZBEfo6fjKl8sxirq0J/MPUI+AqQLffqSDzKsr
         tLVmRB6vcxLo1SHEc8jGS9l6BMmMcfsCLSOwyvngVG/JJjdWdWG1VuH8WDgrg902x5g+
         nA//7eG9Rhrz2NmR1CQP7lUkJRyG8TIifAsSQqNUILo/0OvIctxgScw8kGRoAnLyAdMG
         3+9u9FdTHA7cHsQoMimd9rvNo4G9BTmWQQiAZZYDQ0zYqdyxRySIXx74aKU88GxTQ1Vp
         2sz6hqk7SERUPGskKOBJVT7pyvBNApvgWBFOHaTscKqqzq68rUFG8Z29BD/oI/Afuvji
         ndrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738262256; x=1738867056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRQgpcZ93mW5DBGdzNIoBycuwMkboGtcanKKs6jsCyI=;
        b=Zs3WXkcgt8/wPDGYEYygAj+tE+j54xY0V8ENhz5nvZbEe8jCkx3khG3r9BwTGsgjli
         6fH8w7eoyocfoEGJF6OjakTuBKDGlahHbQK0qbfO66sLf/Twm3UC3BZTK0jPpH+1YKyu
         MuAHrRjqHV3CQ6uOrGNIpSlXszhTR9zPnQrPTEVGtUWzLBeCcfRGFvUYyzRPbp8GGRIz
         9V/ZqMNBvedjkK7mhNXq1++gHHfaIrZhX/4r/nXGuD50rehbGulbpt8sgQlBNrCIWwx0
         +G3jQyczePTPhyQOnHARRZKqAlGC/cz4kYJy8KNVIVGDeZBPJwe7a/QyTcRgLmhwspgQ
         R1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7YdJdRmYsNuOvbFTEozMbhtGkVhk6nrS5mgu0oRcuzDzfsRc53VBCD5kUbbj7sLbGBTPAa88hO282R0sEJHQ=@vger.kernel.org, AJvYcCVF4kOeelXZlmvyg77oL8XXGBcanemSCRetC7I6p4uikGKbPW4+3s59N/Q3iGcAO8KsI0PiorbznOFDK1B4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4I73z8xLmZ47gJSTkDLRRc4A7s7J8x64ZflzEz2/1ObRGcOs4
	Utnrhan4baBmaltWknfnHu9oLiOkmLLQgiAA+vKFOHj9vIBu2SxyDZwR4qYWHkpiLdvwHAEpthI
	LVJ2gCwyjdIHwI/W8xGVxsWI382s=
X-Gm-Gg: ASbGncstd4bDUlTFzLEBFZJ6YE0LbNfIU3jW6ih4LwxSGG0DudBRXpK5BcEGmFTd1OG
	iiYLK7a3VmvHm6fiK1DXD8imctrvGYi2fW5Jg0UaXVTXZZ98KgiWKsdDf6cXnNfEyRgPMe88=
X-Google-Smtp-Source: AGHT+IFjnKx48Ypj22gunFniX94bJSH4EsZTSx08ahplfbQ/Lu9eEN9a6ZYdcMY/45PT7s/zgK5zB+DioKmQUWoAm0E=
X-Received: by 2002:a05:6512:3d21:b0:540:1fae:b355 with SMTP id
 2adb3069b0e04-543e4c37a94mr2802777e87.52.1738262255391; Thu, 30 Jan 2025
 10:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com>
 <CABBYNZLa9amkcQzqRyiCK7acKeXiPLkfX8thMonQhXN+5PnmmQ@mail.gmail.com>
 <e0b77a36-2d2b-735c-7a23-bbaab5adeba7@salutedevices.com> <a2a239f1-5697-cb09-5e4f-83c024fd5ea6@salutedevices.com>
 <95904850-fe5c-4866-3da6-3e021c6becf8@salutedevices.com>
In-Reply-To: <95904850-fe5c-4866-3da6-3e021c6becf8@salutedevices.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 30 Jan 2025 13:37:22 -0500
X-Gm-Features: AWEUYZnwRPiumDhFkYKDhybUiE_2LzKeM2ZIjMZ-9cHMHz2_AqDwGEFtj48ANRU
Message-ID: <CABBYNZL4AAdr3HaOQheSmHr2TMWpH2bXNgwn20tGSbuewys_SQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_uart: fix race during initialization
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, oxffffaa@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arseniy,

On Thu, Jan 30, 2025 at 1:34=E2=80=AFPM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Hi, sorry ping
>
> Thanks
>
> On 08.01.2025 15:39, Arseniy Krasnov wrote:
> >
> >
> > On 19.12.2024 23:07, Arseniy Krasnov wrote:
> >>
> >>
> >> On 19.12.2024 22:18, Luiz Augusto von Dentz wrote:
> >>> Hi Arseniy,
> >>>
> >>> On Tue, Dec 17, 2024 at 3:12=E2=80=AFAM Arseniy Krasnov
> >>> <avkrasnov@salutedevices.com> wrote:
> >>>>
> >>>> 'hci_register_dev()' calls power up function, which is executed by
> >>>> kworker - 'hci_power_on()'. This function does access to bluetooth c=
hip
> >>>> using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame=
()'.
> >>>> Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, a=
nd
> >>>> if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set aft=
er
> >>>> 'hci_register_dev()', and there is tiny chance that 'hci_power_on()'=
 will
> >>>> be executed before setting this bit. In that case HCI init logic fai=
ls.
> >>>>
> >>>> Patch moves setting of 'HCI_UART_PROTO_READY' before calling functio=
n
> >>>> 'hci_uart_register_dev()'.
> >>>>
> >>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >>>> ---
> >>>>  Changelog v1->v2:
> >>>>  * Move 'set_bit()' before 'hci_uart_register_dev()' instead of
> >>>>    adding new bit 'HCI_UART_PROTO_INIT'.
> >>>
> >>> What drivers/controllers this was tested with? I want to make sure
> >>> this doesn't cause regressions to other drivers if there are perhaps
> >>> some drivers assuming HCI_UART_PROTO_READY was set in a certain order=
.
> >>
> >> Hi,
> >>
> >> I tested this on:
> >>
> >> CONFIG_BT=3Dy
> >> CONFIG_BT_HCIUART=3Dy
> >> CONFIG_BT_HCIUART_H4=3Dy
> >
> > Hi, sorry, but is this enough info about my test env ?
> >
> > Thanks
> >
> >>
> >> Yes, my v1 patchset with extra INIT bit was targeted to keep
> >> original behaviour - e.g. PROTO_READY bit usage still the same,
> >> just adding extra bit to handle this specific case.
> >>
> >> Thanks
> >>
> >>>
> >>>>  drivers/bluetooth/hci_ldisc.c | 3 ++-
> >>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_l=
disc.c
> >>>> index 30192bb083549..07b9aa09bbe2e 100644
> >>>> --- a/drivers/bluetooth/hci_ldisc.c
> >>>> +++ b/drivers/bluetooth/hci_ldisc.c
> >>>> @@ -704,12 +704,13 @@ static int hci_uart_set_proto(struct hci_uart =
*hu, int id)
> >>>>
> >>>>         hu->proto =3D p;
> >>>>
> >>>> +       set_bit(HCI_UART_PROTO_READY, &hu->flags);
> >>>> +
> >>>>         err =3D hci_uart_register_dev(hu);
> >>>>         if (err) {
> >>>>                 return err;
> >>>>         }
> >>>>
> >>>> -       set_bit(HCI_UART_PROTO_READY, &hu->flags);
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> --
> >>>> 2.30.1
> >>>
> >>>
> >>>

Please resend it.

--=20
Luiz Augusto von Dentz
