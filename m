Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20EF29B8E6
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766415199; cv=none; b=hXrB9igazsDmpqKUc2G1OxwcGHgngvU9KAHBeeKpa1/GydA3eMQ4L/xEnK1fkSR2Qetadk7IC8VTKD6cs8xJ3xIM3nLnZEiUOg2karsxZA22upqZP3RbUwF+CaG+8s8ZZuBDhpLeYMApybI96GIk2ND35grdP9FBFpA+XXdO9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766415199; c=relaxed/simple;
	bh=hIRngQQ1gYgBk4n+lCllcP9czfLO90Wg7GPWbbfLOUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=akOpAKuNhNgd/MAtlty5HbgMfI+getjJN0knDBvNch3rY0qBMsotXEVV4i3ujLXWaNwblmSghussBW/rzcPrFa4PfiG5Mzk7ifuSnWUSz9d0tseJhAy0UCKVWZWFmn9trU60E+l0b1mov55udQj1Dfxto+SkJfHVfaJErvD1wVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZI6Ij5UN; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI6Ij5UN"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78ac9f30833so27945597b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 06:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766415197; x=1767019997; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQDJ2EGKJfnx2jO7JVJIL2CCGvDhzAnKimikF1hnwTQ=;
        b=ZI6Ij5UNuiD3tvleOyciKoBM516nSpb25Iz7qahhIWLhyM/Cz5uYuUrlhYXqtAXuDV
         jjfhL3SWkl4gLT/A8pzC14A+gAmBs25cZWhw2qM7OfDdantx67tdiccav+eEJvq5h2ge
         g01Ue8sRlu75c/7ejoSUbiluSQOydUjqSOqHFLuLKx4johT6DPfxlQ5Melm8hVrCyfF9
         Pb9N7tfn3zr6Wjyy6xHqUrxiRCiB6mRs9D15jmgKqksdvtGDMJplSeA6jtrd24AFvb7o
         B5144G2SqGXjtSmVI8s1r1SiEwNs106hI/U3nAm/1sVL3TFcz62chFs9gWWzvhwF8Xoz
         B3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766415197; x=1767019997;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQDJ2EGKJfnx2jO7JVJIL2CCGvDhzAnKimikF1hnwTQ=;
        b=B4eStSx/NQRAg500cuX8yygkq5yd8y7QthRCYyWXCWg6e0ia8chNYlaMFXKEnYl2eZ
         yw6My0xgnY74y2r+htGf7YONKlbbnoDaucABWDP/qLiQrDVm4vPwoqV9HNzj2K1Gu8bC
         ee4J5M59GCpgFdBBvOWdlt/kQoSqI9wurI3CAXvZvonT1mhwuEyFFerv1TVsD5h9mtTe
         y4jl9DmjSoYsupZjPZbYC08K46K1Vn08bwNQlXLJFTH0fRXXF3TwVU7+C4X1UXwtAGRf
         iFkTmPXtzGuF1Lw0bbcIdsOJHqF81p7r9//2p7ycu1ii4YyMiL6owjmmXPnr8iJ+aH6g
         GEfA==
X-Gm-Message-State: AOJu0YxU4GsmFEX1x52E5OzpEFXuRlWPyoHXEnI895A5I12QpgxlscBN
	IaYnokdeQYN7XiXaZ/r0Ei6qWiOl1CVJzh2O42Rx/2PCAbUUu8dCvvrrTuRj3vlHleXG2N9fVIO
	kVsnHQwZoiVcZ+t3LIjAPndi3FPHknQN6XIef
X-Gm-Gg: AY/fxX56Dhyuzgj62/+BIQlLkoVK8o83kkNu2bjhXt7f3zFRwzqieULx8+bRDW1a5KI
	iFztNWWRQHNEvIuJZptgGZBb2RURN3av3Onc3zJY7Xz36djQvpLsl3vwYOa7NU2FFbnmJvBfbIx
	/WSokhPdIX6VgywJ4hdUTEZLrTqR1vbKOAMtG73P9v9TQaatzdg1ZIAPu/YKxZ/o21a9Wj9FPx9
	cUWrisKcFZpqeZJUYyK6Xr7eG33Vr2PuUYUlpu5mKbh7eNIXX5uMsbMBbkDtR92DGLAj+kLlnSO
	/S3O
X-Google-Smtp-Source: AGHT+IG9c29Wfr0LmKrQujmaRuZorMKLn4Y6wsmJGvAke+Zudz3IudoKkTgilZzhsqGR8D8c6M366BUcZFV+7y1SwDs=
X-Received: by 2002:a05:690c:c1b:b0:786:56ec:e3c6 with SMTP id
 00721157ae682-78fb405be1fmr94449257b3.55.1766415196433; Mon, 22 Dec 2025
 06:53:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219162820.320823-1-luiz.dentz@gmail.com> <CABBYNZLuSFMttw2XU+F8+-YGL=yfhoWE1=jj3b5Dq9QYG4rAZw@mail.gmail.com>
In-Reply-To: <CABBYNZLuSFMttw2XU+F8+-YGL=yfhoWE1=jj3b5Dq9QYG4rAZw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Dec 2025 09:53:03 -0500
X-Gm-Features: AQt7F2rPEwh0ZKKxY1-RCcPC4YfyX2yKnBjBDgsUOU-21ZDUiYlLDM4dltzuoWs
Message-ID: <CABBYNZJEe3ow1xNRgFrUcJCZgTyGEvgtTZpTzxenmnChxijL+g@mail.gmail.com>
Subject: Re: [PATCH v1] fixup! Bluetooth: hci_sync: Add LE Channel Sounding
 HCI Command/event structures
To: linux-bluetooth@vger.kernel.org, 
	Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Fri, Dec 19, 2025 at 11:30=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Naga,
>
> On Fri, Dec 19, 2025 at 11:28=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > ---
> >  net/bluetooth/hci_sync.c | 38 +++++++++++++++++++++++++++-----------
> >  1 file changed, 27 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 5de98be752bc..ab0b68faa61c 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -4570,27 +4570,43 @@ static int hci_set_le_support_sync(struct hci_d=
ev *hdev)
> >  }
> >
> >  /* LE Set Host Feature */
> > -static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
> > +static int hci_le_set_host_feature_sync(struct hci_dev *hdev, u8 bit, =
u8 value)
> >  {
> >         struct hci_cp_le_set_host_feature cp;
> >
> > -       if (!iso_capable(hdev))
> > -               return 0;
> > -
> >         memset(&cp, 0, sizeof(cp));
> >
> >         /* Connected Isochronous Channels (Host Support) */
> > -       cp.bit_number =3D 32;
> > -       cp.bit_value =3D iso_enabled(hdev) ? 0x01 : 0x00;
> > -
> > -       /* Channel Sounding (Host Support) */
> > -       cp.bit_number =3D 47;
> > -       cp.bit_value =3D le_cs_capable(hdev) ? 0x01 : 0x00;
> > +       cp.bit_number =3D bit;
> > +       cp.bit_value =3D value;
> >
> >         return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HOST_FEATURE,
> >                                      sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> >  }
> >
> > +/* Set Host Features, each feature needs to be sent separately since
> > + * HCI_OP_LE_SET_HOST_FEATURE doesn't support setting all of them at o=
nce.
> > + */
> > +static int hci_le_set_host_features_sync(struct hci_dev *hdev)
> > +{
> > +       int err;
> > +
> > +       if (iso_capable(hdev)) {
> > +               /* Connected Isochronous Channels (Host Support) */
> > +               err =3D hci_le_set_host_feature_sync(hdev, 32,
> > +                                                  (iso_enabled(hdev) ?=
 0x01 :
> > +                                                   0x00));
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       if (le_cs_capable(hdev))
> > +               /* Channel Sounding (Host Support) */
> > +               err =3D hci_le_set_host_feature_sync(hdev, 47, 0x01);
> > +
> > +       return err;
> > +}
> > +
> >  /* LE Controller init stage 3 command sequence */
> >  static const struct hci_init_stage le_init3[] =3D {
> >         /* HCI_OP_LE_SET_EVENT_MASK */
> > @@ -4618,7 +4634,7 @@ static const struct hci_init_stage le_init3[] =3D=
 {
> >         /* HCI_OP_WRITE_LE_HOST_SUPPORTED */
> >         HCI_INIT(hci_set_le_support_sync),
> >         /* HCI_OP_LE_SET_HOST_FEATURE */
> > -       HCI_INIT(hci_le_set_host_feature_sync),
> > +       HCI_INIT(hci_le_set_host_features_sync),
>
> Let me know if you have any comments regarding this change, I'm
> planning to amend the original change since it hasn't been pushed to
> next-next yet, this has been found by:
>
> https://netdev-ai.bots.linux.dev/ai-review.html?id=3D999e331e-1161-4eec-a=
d26-fafc3fea6cfd

Any feedback?

>
> >         {}
> >  };
> >
> > --
> > 2.52.0
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
