Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DDC374EA
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846608; cv=none; b=YPSB/gmiTE0w8Xzr1DmbqDmK/jUDvm9cE2Tt6arThOtFc7d/E/1DkadPkd8z9tnBuyNELR80Ru3eImmd42o5XPUwSJxHRrSRYcx8fmGtJkTDe2Pv9tJrffN4tvJGsi3cm+te7DrccnyfxH+RYiNMTGIRZqEEZg6fWa2NUiGwLZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846608; c=relaxed/simple;
	bh=aaMvmWCsiURlT61ttb49Aw69W7JtRP1PMfNbx+wtqns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aslMHVWj6fIyjAtnJs+c1og7S0zBAqEyVH/Yjensv7YbBOyw00mNa2nZb5xYKnG6zmCuu3/xJVr268f4Q8kiC1SZIarukFhgWcI8XGl+j+0LVzn27UXCa30NZ4to5TDG/LrmvhitfQE14wbCa4c+IMfEEq9cOhWi/NSzUF/lrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcGRW7A/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcGRW7A/"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso1162328566b.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759846605; x=1760451405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlNrYksHLMfAVeQP3yUtYa9PE9Wf6Qdn7i1hS35K1lA=;
        b=ZcGRW7A/MNCWgrkcfz/mIrCGcZ7pRUU8+Q+m82XnCfdggI3XWwvrPI0kiVdBezXLAU
         s1KH72Pt9EIntk4qgOZHh/RtfnIzwRD2kcRKauaSCLFe5bgCpxZiIbkuCwA8h/rhf1T6
         7yy7Uyf0vDh/HRmhPyNM7PWyTydfUkot6Z2WT7F5DbbABQhbo11O07fMwwvpxR8MnHir
         tS0tnjA70Sox93s/NtVwpkqFIne5K1dky0Oik+B97KdaPY8QLbag3Ap41M0K78yi2zws
         yHM19keDuw18vKveLygk6sXJzJIEFl2riofrjD2m4mc1uWV3uaXyltVNO23ImXkUMClh
         w2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759846605; x=1760451405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlNrYksHLMfAVeQP3yUtYa9PE9Wf6Qdn7i1hS35K1lA=;
        b=qCUbUKykcnWdaNOs18TG3gRAwIo6+zW6wbEeLbWSFWje0jH2SdstELcv3jhajfXzt3
         4lxwYxPLsXOQMETEOtEuGvElKbxrcOWVmaHy6TC7gHgozyOZ6tzmPMpNh3cEbPKIn3Ye
         AetnPFGAx1opo3D5sr1IGvBPM92ok4SLvyuRNwGeJldlSgQbWfGve36yyC++0ek9SyZT
         gUihwaHmqheo0PdocAM/hleK8nqYLJWwoOCbfrTNp+nb+CxZAlVjTk349X3521VhAN7s
         UQibTsoNlA7Ji0FLK5UbpAbhqZf1/S8mLQKO5D2BJqxA4ua/Ed+BshokGw43dbDwFJc6
         Nk2w==
X-Forwarded-Encrypted: i=1; AJvYcCUerMtVKRQnZtWi1mrjoG7MO5BT2yynQUfHqhckPv8PpowMvtXIt0wKIMrPkJrOfdEtGjm30ULgFK0IKVFDnNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwstPo7ld7MrOhXwPg/nv+8qW43GlDETaxFV95kq1Nw4aPt89Mf
	xQIxHL21w5BY0PoLcPGWAHam75HOXo3FnEel/tHXkY9xX0WXWZonr5H/eeM/7YzGRHtqlMlb5sW
	oNVzLysuN08gb0C9QPsbpTnylYTHHL1M=
X-Gm-Gg: ASbGncuPbJOjiMhtv3x/fvOgPEh4G0tTVjV3vgaUa00FIM1lKuv0qnYnPk94Q0vDwMb
	Z9jG0ocoKAT/cPhQB8uNn4MPPhOWcHxYqtKDSS9LJIFkn0VEYwkYPjxIetz5+9UlToEEJnu56H6
	cTkCRhNAd4/eN1OfB0f+bAfXuT/rCyJEyCxf9TY7jB3y8cEtsL0AtlD0XPwZA9p5fwoM501Vh9f
	PDXhcMta4GGksZyblI7/DjmUy6qBZS6
X-Google-Smtp-Source: AGHT+IHHcmxe7xACPAEy8QV/B2eyRrCFpBlq18//7M+WWVut43Uk241D1fmqAzqfxbqBEfa0YeS5Ndpszg4TAJ9iGyA=
X-Received: by 2002:a17:907:7293:b0:b04:61aa:6adc with SMTP id
 a640c23a62f3a-b49c12806cbmr1771245066b.7.1759846604448; Tue, 07 Oct 2025
 07:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003205837.10748-1-pascal.giard@etsmtl.ca> <CABBYNZJVUoVnJPdOXARvk7T_9EsvomJ_oe_ZZ_QZMTQBVjNDHw@mail.gmail.com>
In-Reply-To: <CABBYNZJVUoVnJPdOXARvk7T_9EsvomJ_oe_ZZ_QZMTQBVjNDHw@mail.gmail.com>
From: Pascal Giard <evilynux@gmail.com>
Date: Tue, 7 Oct 2025 10:16:33 -0400
X-Gm-Features: AS18NWDMEhKXRd_AXB1cgsGhtd6LO1y4YZjcNM87YeMK5w4MccS9LFkhHrMIC10
Message-ID: <CAJNNDmm-sBv4Qz9J+bFGWmmQ8jdOKQtRr9xDcwAsDYQQMm0Uxw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add filter for Qualcomm debug packets
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pascal Giard <pascal.giard@etsmtl.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Luiz,

Le lun. 6 oct. 2025, =C3=A0 13 h 21, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> a =C3=A9crit :
>
> Hi Pascal,
>
> On Fri, Oct 3, 2025 at 4:59=E2=80=AFPM Pascal Giard <evilynux@gmail.com> =
wrote:
> >
> > Some Qualcomm Bluetooth controllers, e.g., QCNFA765 send debug packets
> > as ACL frames with header 0x2EDC. The kernel misinterprets these as
> > malformed ACL packets, causing repeated errors:
> >
> >   Bluetooth: hci0: ACL packet for unknown connection handle 3804
> >
> > This can occur hundreds of times per minute, greatly cluttering logs.
> > On my computer, I am observing approximately 7 messages per second
> > when streaming audio to a speaker.
> >
> > For Qualcomm controllers exchanging over UART, hci_qca.c already
> > filters out these debug packets. This patch is for controllers
> > not going through UART, but USB.
> >
> > This patch filters these packets in btusb_recv_acl() before they reach
> > the HCI layer, redirecting them to hci_recv_diag().
> >
> > Tested on: Thinkpad T14 gen2 (AMD) with QCNFA765, kernel 6.16.9
> >
> > Signed-off-by: Pascal Giard <pascal.giard@etsmtl.ca>
> > ---
> >  drivers/bluetooth/btusb.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 5e9ebf0c5312..900400646315 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -68,6 +68,9 @@ static struct usb_driver btusb_driver;
> >  #define BTUSB_ACTIONS_SEMI             BIT(27)
> >  #define BTUSB_BARROT                   BIT(28)
> >
> > +/* Qualcomm firmware debug packets header */
> > +#define QCA_DEBUG_HEADER       0x2EDC
> > +
> >  static const struct usb_device_id btusb_table[] =3D {
> >         /* Generic Bluetooth USB device */
> >         { USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
> > @@ -1229,6 +1232,12 @@ static int btusb_recv_intr(struct btusb_data *da=
ta, void *buffer, int count)
> >
> >  static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb=
)
> >  {
> > +       /* Drop QCA firmware debug packets sent as ACL frames */
> > +       if (skb->len >=3D 2) {
> > +               if (get_unaligned_le16(skb->data) =3D=3D QCA_DEBUG_HEAD=
ER)
> > +                       return hci_recv_diag(data->hdev, skb);
> > +       }
>
> Well it turns out that handle 0x2EDC is actually a valid handle, so we
> can't just reclassify these packets just because Qualcomm thinks that
> it could reserve it for its own, so this needs to be using
> classify_pkt_type to reclassify the packets to the handle 0x2EDC to
> HCI_DIAG_PKT for the models affected.

Thank you for considering my patch. Based on your comment, I had a
look at how btintel.c uses classify_pkt_type, and I think I understand
what you are expecting of me.

Before I submit a new version, should I go very narrow (just the
VID:PID=3D0x0489:0xe0d0 I know for certain has the issue) or should I
lump in all modules with the WCN6855 chip? The latter seems somewhat
reasonable to me given how hci_qca.c does it (even broader).
Therefore, I'm thinking of reusing BTUSB_QCA_WCN6855.

Thanks,

-Pascal
--
Homepage (http://pascal.giard.info)
=C3=89cole de technologie sup=C3=A9rieure (http://etsmtl.ca)
