Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295F214228
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851464; cv=none; b=livwGof9C1o8ueQDXMYCqCrv8tTUp0hyqPb2G4BE5POnpkMv8iND6fSzg50to+ak5Y5M1CTcIN4ZbP2GtpUZyq8dNwn5O2QsqCLWfKRFuxnTsYznWmin7vjvrOBx1NNmPx89NV3W1L3NHh2lLTKUyBrIFXLoOuRxyR/cPFvCRW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851464; c=relaxed/simple;
	bh=L7kZmLJlE/XnLH36V+KbooGTUFxyOdCgz9Dbqy36BeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5RGtbNoaQPB//HQ7yy0sTnX+v8y3gc2tAWxcU5pOJxB1IFbRSA2ezkc72BPvUZ8b9N/qfo8gpurDtJ0XevghHEDYtRXAjII2BOuOgiL0i6Xgfch0AWoGTkRW4zaijyKoPYzhu3eeRJz/4meSR2Qcayp0Lvd6YyvlJqwti1x2sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANZff9WV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANZff9WV"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-636535e4b1aso11651a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759851461; x=1760456261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hb/tRSMmrbyt+RrLMSUvBfmKbSdCAS5olFHTKGvQ14=;
        b=ANZff9WV8GUQeRFAz+Oj7Y5vi30mNBjZoUQm43Nt/bDJRn9CvlcvrLJBv9VKqsPEKD
         x7QKScMhCOQnpjFW49XR/muoQcPYlk5DNKNjTANASV1dha24NVYUbrU1URKkhMUTvqA/
         UCpFGxuZqWWmGJw9b9JBAa6ZDoLxcKSTv88iLrgxuQTZ/GubBNx+amq57cgBCpFnYZEh
         CweZhSXNS8p3Sbq/59LTpeIl03//KpYwsusIYGT5Z4IRNuSIHmpKbvbEYTx7Kvi+li/H
         6NIcpVdrmAKgw3JuCIRNeuj/d+tBp+IXqr/tKCUTAad6JTgE+K70GfN3PImXgINO1nI6
         AW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759851461; x=1760456261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hb/tRSMmrbyt+RrLMSUvBfmKbSdCAS5olFHTKGvQ14=;
        b=TGNrUBUnalLnMP/qj9oGtSzluaceQz7qor0Nr7B4D0j4MAyGEs0l0MbQZfKpHA66NS
         7BIJ8grgPet2xcoQKletjh53zpxsUpZJEWVx0J/LiembCvfVZz8fVPmahT7BLi409xk/
         dZXeAETw67l2I+hcfAQBHgJdetmCUU6Iif5pt6hFEB/Nld+5CsK5p2RGZVvlOOOQY7pX
         kTr8aE9S7Ivj79sGhZeD4VvYcn2gQWZzgGEKJPDP4T1qRC7WwO4wDVCuwwQRkOHJKC6V
         H5h1+hKfnjAEP15Dcj9sCrM8lvWYFu6te9rNKJ2VfjnXdhSnoWE4pUmdk45yz24WkB89
         g9AA==
X-Forwarded-Encrypted: i=1; AJvYcCWRXX1EMIawqOOj0r4Fw7JYWHUv4Jd8xF07TbvUoANu7b+HM6LawiT7WVT87+xoWNukBgsW9lwVtk8qN8QwMiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9eXx2fNnLINcMnXrrOmaU0ItldHsZdfYAHl11gaW1uFA6h8W
	OV2Bpwll/DQ8oMZfrAMogmSchFlRMiTmJVjU4kvx6ymgOSq5R3b3jmLL1PlpkS2sJrwUjjSigxd
	Jp0IDYNQWyWKB7XsCbWE3uqeNW86WfCc=
X-Gm-Gg: ASbGncv8nZlHJmiHNfBiFHyoPF2TIHHFIJE1nPjkpbyRe6Rtol39QvSueEf+Qwhwc9q
	UwdNvaAdpaox56FB8AOZyhOvpsbZ5fXq/tj/LZkgKzKDu0BDSYqIgk9BOFI2oiWtpOqLyFhT5rU
	AE/Wo4g0MnYHHxlyt8FpmdGi8rLPLeGG1rERf1vAax8KybkGzSmwzvgov+OUqx3XldQHY+eg1Y+
	IHW3fDlFbEJO7pHwtHOzX3P+zPNaqCy
X-Google-Smtp-Source: AGHT+IFeGZAoU6mrp7imBCnsZPcOpjW6G/kPmwm08fy9awGkAfSzNFLnsP0jVcdxuj0iVAw1MUuK2k5LknXhWKZ15SU=
X-Received: by 2002:a17:907:8991:b0:b33:821f:156e with SMTP id
 a640c23a62f3a-b4f4116a352mr542894866b.12.1759851460500; Tue, 07 Oct 2025
 08:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003205837.10748-1-pascal.giard@etsmtl.ca>
 <CABBYNZJVUoVnJPdOXARvk7T_9EsvomJ_oe_ZZ_QZMTQBVjNDHw@mail.gmail.com>
 <CAJNNDmm-sBv4Qz9J+bFGWmmQ8jdOKQtRr9xDcwAsDYQQMm0Uxw@mail.gmail.com> <CABBYNZ+0W5Aaq1BfzMc1fcQGCUFrDfQcDyffaG=+0LE0=G-wug@mail.gmail.com>
In-Reply-To: <CABBYNZ+0W5Aaq1BfzMc1fcQGCUFrDfQcDyffaG=+0LE0=G-wug@mail.gmail.com>
From: Pascal Giard <evilynux@gmail.com>
Date: Tue, 7 Oct 2025 11:37:29 -0400
X-Gm-Features: AS18NWBifganGU3gnea5zVfE5SuNtP-BCyc7qXGlS_0mmKLSkwbXK6usYwBVIGo
Message-ID: <CAJNNDm=C4PFTUy93jpKDNwZPbDt4fC-rykWRHC=NDsL_fkkJiQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add filter for Qualcomm debug packets
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pascal Giard <pascal.giard@etsmtl.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,


Le mar. 7 oct. 2025, =C3=A0 10 h 46, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> a =C3=A9crit :
>
> Hi Pascal,
>
> On Tue, Oct 7, 2025 at 10:16=E2=80=AFAM Pascal Giard <evilynux@gmail.com>=
 wrote:
> >
> > Dear Luiz,
> >
> > Le lun. 6 oct. 2025, =C3=A0 13 h 21, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> a =C3=A9crit :
> > >
> > > Hi Pascal,
> > >
> > > On Fri, Oct 3, 2025 at 4:59=E2=80=AFPM Pascal Giard <evilynux@gmail.c=
om> wrote:
> > > >
> > > > Some Qualcomm Bluetooth controllers, e.g., QCNFA765 send debug pack=
ets
> > > > as ACL frames with header 0x2EDC. The kernel misinterprets these as
> > > > malformed ACL packets, causing repeated errors:
> > > >
> > > >   Bluetooth: hci0: ACL packet for unknown connection handle 3804
> > > >
> > > > This can occur hundreds of times per minute, greatly cluttering log=
s.
> > > > On my computer, I am observing approximately 7 messages per second
> > > > when streaming audio to a speaker.
> > > >
> > > > For Qualcomm controllers exchanging over UART, hci_qca.c already
> > > > filters out these debug packets. This patch is for controllers
> > > > not going through UART, but USB.
> > > >
> > > > This patch filters these packets in btusb_recv_acl() before they re=
ach
> > > > the HCI layer, redirecting them to hci_recv_diag().
> > > >
> > > > Tested on: Thinkpad T14 gen2 (AMD) with QCNFA765, kernel 6.16.9
> > > >
> > > > Signed-off-by: Pascal Giard <pascal.giard@etsmtl.ca>
> > > > ---
> > > >  drivers/bluetooth/btusb.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > > index 5e9ebf0c5312..900400646315 100644
> > > > --- a/drivers/bluetooth/btusb.c
> > > > +++ b/drivers/bluetooth/btusb.c
> > > > @@ -68,6 +68,9 @@ static struct usb_driver btusb_driver;
> > > >  #define BTUSB_ACTIONS_SEMI             BIT(27)
> > > >  #define BTUSB_BARROT                   BIT(28)
> > > >
> > > > +/* Qualcomm firmware debug packets header */
> > > > +#define QCA_DEBUG_HEADER       0x2EDC
> > > > +
> > > >  static const struct usb_device_id btusb_table[] =3D {
> > > >         /* Generic Bluetooth USB device */
> > > >         { USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
> > > > @@ -1229,6 +1232,12 @@ static int btusb_recv_intr(struct btusb_data=
 *data, void *buffer, int count)
> > > >
> > > >  static int btusb_recv_acl(struct btusb_data *data, struct sk_buff =
*skb)
> > > >  {
> > > > +       /* Drop QCA firmware debug packets sent as ACL frames */
> > > > +       if (skb->len >=3D 2) {
> > > > +               if (get_unaligned_le16(skb->data) =3D=3D QCA_DEBUG_=
HEADER)
> > > > +                       return hci_recv_diag(data->hdev, skb);
> > > > +       }
> > >
> > > Well it turns out that handle 0x2EDC is actually a valid handle, so w=
e
> > > can't just reclassify these packets just because Qualcomm thinks that
> > > it could reserve it for its own, so this needs to be using
> > > classify_pkt_type to reclassify the packets to the handle 0x2EDC to
> > > HCI_DIAG_PKT for the models affected.
> >
> > Thank you for considering my patch. Based on your comment, I had a
> > look at how btintel.c uses classify_pkt_type, and I think I understand
> > what you are expecting of me.
> >
> > Before I submit a new version, should I go very narrow (just the
> > VID:PID=3D0x0489:0xe0d0 I know for certain has the issue) or should I
> > lump in all modules with the WCN6855 chip? The latter seems somewhat
> > reasonable to me given how hci_qca.c does it (even broader).
> > Therefore, I'm thinking of reusing BTUSB_QCA_WCN6855.
>
> I'm afraid you will need to figure it out, probably only qualcomm
> folks can tell which chips use this logic, also is it always enabled
> to send debug information or that requires a vendor command to enable
> debug traces to be sent using that handle?

I went with lumping in all WCN6855 chips. I have not sent any command
to enable debug traces, so my understanding is that this is the
default behavior on at least some controllers.
I have sent a new version of the patch for your consideration, where I
have tried to follow the approach you suggested.

Thanks again!

-Pascal
