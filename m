Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C52741A1
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157396; cv=none; b=u93QlAHWvqR0I8JlzbZo1TZbItGlKzV7Rb12rSPAOkWs1UkQS9GiUF3uN5m3Nw8IK6DsmjZUkX9OnRRECbv/FviTZx7XYeiPi1tKkENTwG0zBvcbfURaGSmTnYIHRLpDicH7XOxX9ejBJnz2tSTNivk+LAjiDEjZcD11Uoew92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157396; c=relaxed/simple;
	bh=+2O7n70Q9HyPnPKoQKMyWLJfULAWed8IA2lb5U3945c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioIb1VDHMFqwTOBSPj4H0jDhzB20ChNcV5BFYm5fYYEmtnWjs15+xqfY5oayR+YXN8no+HlOAoV7zDv4DTZp2LwIfTyBf+UwzjJVv46XHVaytTrBNMMF3mMRbipKlzNpwdKXzcrF63oHrMp91sY9ixZmw9swiXzJHgJtubRlU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=wSHdRkYq; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="wSHdRkYq"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c51860bf5so1733371a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1752157391; x=1752762191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7J9CBx1TsWwVW9ZoNN4bXkoI0z5IKx6JEfVv7IPkQI=;
        b=wSHdRkYqgwDL06aliEef6HWuxsmtC6c8Qiy4iqpQOz7an+BrzVMmWF6VYC0McKFUZm
         jYsEYEEUhxBYHoAsDSFVDpKEpi1gjNJLG+dDg+qPU5szsqNBkpseY6f09T9UwsF5jQpf
         2v+x27ORLxya+o99NiZNtMtH01ic/fOS8iAHUJG1f0VyZh1SiMvT6xiwBSvkuNQ6MF/B
         CfeLfPN/oAi1IqI7yrqd8j2QxxOmhZvZKCfpjGnW8huaHXf6HXP8wATyYxYoU7VyNx2e
         uryo/+iBZ5tJ0XHYT2FbCGy+z+0Mjn1KWM3c2BQooP1JjkDp45Golpv5fA7+UyKPbwBo
         x+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752157391; x=1752762191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7J9CBx1TsWwVW9ZoNN4bXkoI0z5IKx6JEfVv7IPkQI=;
        b=PKolCs+s7/cVQdPWs1QQEsD7lJsCUGP+E1/7cAAPxEy7VH+1pwxycVd8n7fXEIfZ0D
         lv+B8Q0RdkBWvjY3V+hAsYV6trVYoxDxO8k0HqeRg32+CNgBfAUn4QRryt0sDED4Cl+X
         u6Uy2f3u/rK+ed7aAbZt4vU3XZLaMxvzFlSxGv3CscQLZeMp2mSq6bRLqEZYSRFTQ1QW
         5FjFV3tzXgurjIq98I6iulH6QGIshbIewVfBjbb6zFenFH/mdLtN8uEXm/lxALrZqpNG
         eU3TSsyqsVsyYsJu7IKOmM00Ka0+875NQBhXQGLQzPXYhTNmOsf4G3vLGLGeGSPhT2xH
         rT4A==
X-Gm-Message-State: AOJu0Yz7MkadMtCeulpmGDmSCN9z1rOuZ4nmg62ITneoCJH+6ecXLYNm
	HuQNB88hvG3w6//0g13dssEp7vU8DyoUV2rz6eJLyKFv2SABjg+n9lLByLqYfaBBRLIiBel1ywv
	MCyy4rj+p+G5GhyQJDogrtjuzoFovyW8H++dVqcep
X-Gm-Gg: ASbGnct4SIUl9cPeec1sDQfi59CHU5t5QvyBdUwFsxP+upRWGmHp2+PZUnBkbhPaOT0
	Ytk0Zx3xEXQCw8tskvRT4TS6QgjGyZxGhtgI2OiwyXhYScigQlXckPZdu6/NCUMHkAjEfAzNN7L
	c7MtRdutYUCCYO+lfKVkbAL4xVlxyQhh81xY1eUtAwDg==
X-Google-Smtp-Source: AGHT+IGb/KhsnFp2R/ifBWOLvln5r94BVtfLHw5gs/NICpQJVZ5hJxh7C919Q7AaxCYx415TtSq7aqb9xPlidrtRwVw=
X-Received: by 2002:a05:6402:234b:b0:608:a7a0:48 with SMTP id
 4fb4d7f45d1cf-611a74adb9dmr6385276a12.28.1752157390999; Thu, 10 Jul 2025
 07:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709191333.3374053-1-luiz.dentz@gmail.com>
 <CABBYNZJLLWu2EEEsZ+tE0+0H4o1ba3gG2ab9dLaPbAxz2BzGmA@mail.gmail.com>
 <CABtds-0U4mD9kr708UdB+SAHRvBAPYrEaOSCjKkqTDXjJpWOUw@mail.gmail.com> <CABBYNZ+Xo8Ou=dLfHhPVfiqMCehh23aFY=G+KRMb6d9uoKxjjQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+Xo8Ou=dLfHhPVfiqMCehh23aFY=G+KRMb6d9uoKxjjQ@mail.gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 10 Jul 2025 15:23:00 +0100
X-Gm-Features: Ac12FXy_CedwWCqM5preZ9it6JMpCZkJIFVejRGXAydc1WIyf_kLwKblYng4vQg
Message-ID: <CABtds-0gkRj+ns84Avc6pQ9ofXRXQ2PEO-mwbr70hZea-N9DQg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Check if controller is ISO capable
 on btintel_classify_pkt_type
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Like thus? Sorry, not too familiar with the email patches.

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Due to what seem to be a bug with variant version returned by some
> firmwares the code may set hdev->classify_pkt_type with
> btintel_classify_pkt_type when in fact the controller doesn't even
> support ISO channels feature but may use the handle range expected from
> a controllers that does causing the packets to be reclassified as ISO
> causing several bugs.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219553
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2100565
> Link: https://github.com/StarLabsLtd/firmware/issues/180
> Fixes: f25b7fd36cc3 ("Bluetooth: Add vendor-specific packet classificatio=
n for ISO data")
> Tested-by: Sean McAllen <sean.mcallen@example.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 55cc1652bfe4..06575a0b9aee 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2670,7 +2670,7 @@ static u8 btintel_classify_pkt_type(struct hci_dev =
*hdev, struct sk_buff *skb)
>          * Distinguish ISO data packets form ACL data packets
>          * based on their connection handle value range.
>          */
> -       if (hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA_PKT) {
> +       if (iso_capable(hdev) && hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA=
_PKT) {
>                 __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->handle);
>
>                 if (hci_handle(handle) >=3D BTINTEL_ISODATA_HANDLE_BASE)
> --
> 2.50.0


On Thu, 10 Jul 2025 at 14:33, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sean,
>
> On Thu, Jul 10, 2025 at 9:18=E2=80=AFAM Sean Rhodes <sean@starlabs.system=
s> wrote:
> >
> > Hi Luiz
> >
> > Yes, works perfectly with that patch.
> >
> > Thanks
> >
> > Sean
> >
> > On Wed, 9 Jul 2025 at 21:06, Luiz Augusto von Dentz <luiz.dentz@gmail.c=
om> wrote:
> >>
> >> Hi Sean,
> >>
> >> On Wed, Jul 9, 2025 at 3:13=E2=80=AFPM Luiz Augusto von Dentz
> >> <luiz.dentz@gmail.com> wrote:
> >> >
> >> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >> >
> >> > Due to what seem to be a bug with variant version returned by some
> >> > firmwares the code may set hdev->classify_pkt_type with
> >> > btintel_classify_pkt_type when in fact the controller doesn't even
> >> > support ISO channels feature but may use the handle range expected f=
rom
> >> > a controllers that does causing the packets to be reclassified as IS=
O
> >> > causing several bugs.
> >> >
> >> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219553
> >> > Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2100565
> >> > Link: https://github.com/StarLabsLtd/firmware/issues/180
> >> > Fixes: f25b7fd36cc3 ("Bluetooth: Add vendor-specific packet classifi=
cation for ISO data")
> >> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >> > ---
> >> >  drivers/bluetooth/btintel.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel=
.c
> >> > index 55cc1652bfe4..06575a0b9aee 100644
> >> > --- a/drivers/bluetooth/btintel.c
> >> > +++ b/drivers/bluetooth/btintel.c
> >> > @@ -2670,7 +2670,7 @@ static u8 btintel_classify_pkt_type(struct hci=
_dev *hdev, struct sk_buff *skb)
> >> >          * Distinguish ISO data packets form ACL data packets
> >> >          * based on their connection handle value range.
> >> >          */
> >> > -       if (hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA_PKT) {
> >> > +       if (iso_capable(hdev) && hci_skb_pkt_type(skb) =3D=3D HCI_AC=
LDATA_PKT) {
> >> >                 __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->han=
dle);
> >> >
> >> >                 if (hci_handle(handle) >=3D BTINTEL_ISODATA_HANDLE_B=
ASE)
> >> > --
> >> > 2.50.0
> >>
> >> Can you try with the changes above?
> >>
> >> --
> >> Luiz Augusto von Dentz
>
> Please add Tested-by so we can move to get it merged, I do intend to
> send a pull request later this week.
>
> --
> Luiz Augusto von Dentz
