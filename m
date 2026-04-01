Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E154407575
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055139; cv=pass; b=AYDArwPqM5AulXS476Oj52GBwuBndhamsiox9319YFgCWX7zTqNf8dft5QcIJkc2ouSDFtRtCW/G72HATpQXIwuLw07PRx8jXqyFJmwAIOUcFbPOwuZgJxmkgkbSqyfW0r2ErEkZ7XRNtR6ELR5LeAfH17v6N8MzzdxhN3EZF/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055139; c=relaxed/simple;
	bh=9oF4jBzws6O/TpabI615tifuG5lTukWmyR0BaxYgP50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KM51jKsX/17n0amZl6hjXp04jRMhlrfUewNQYlntB40adV5djB0+716tWYaXlFdFXE/puT5eIqJxWSGfpFc9QNxnXQb8uU3pG7/qtyDf7mck4wSf+h2FM2AehRKiTxZ4Wpv9mwM85AG4QUpbRnoKdGahXUL8WYWU3lMnj2wMdjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0SkNCmV; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0SkNCmV"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66bf15430ecso6244522a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 07:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775055134; cv=none;
        d=google.com; s=arc-20240605;
        b=GsjOS2aibmYKmEPJGJf79AsPLmI3So57GVdkIeQIZSvZcXj57Ab365Z9W93eAIPDbm
         vCKxyQkEhePCzENJlOygVUDhPrQNoU24HjaR1vqYDLoacKowU6+mk5G9iWnGUXFu7kVf
         fRsnJkfGgbWZBt4TvSRi8Pc4UoP4t/Yuv+YFLOj9kQywYCQtcLlPMDIvas7e90JIA4eT
         hb1gjIS55bctopgG3WiojJqPkAUIMjDswoODLg1tJblmD0Gee9ntwKmQPgywvH/P5zSR
         UAz32xToBKjd+nuLSFtf7EA4+4dyXRfXLYYlagitOHnJskIaETR8TJZcpM+RGMYnaecm
         +X1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s5wWYdzsVjLlXY5l0PsS4aBTb87zLbksqlks0I0jLBs=;
        fh=XdQh8zPpA3gUQ2FFg++kUOIsqdO4hz00C6sJZsibDj4=;
        b=etFPmOaXekFgtYIZTmV/T8E8Sg4cQXE9cGcSUTCKlQaxVG44OkqrKzqb+ar1wwo8ie
         1cdii8b24g6X7yIgSIo4hlBDRaZw9yYrs6zwamwe0JUKOkkqC93ezdfM98rVq5S0ztgl
         TTCC6xkSsYiLWUBNE7LfMHDP4FYdkPg3rroRqxPM0eyuLRpVlbamKxbWhDdTFg77T3W1
         zbtTWNRYJapiFezj4wqofSES7/AOm785BfTarvEdVnFV068IxxNsWxwdwWvyOShZxZSC
         eE2H8rz0SWai0MJffUxoVMvd0rA0aPCxyt2GN6XjJurGbwrey6POI3jy42WornANsWhO
         2MMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775055134; x=1775659934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5wWYdzsVjLlXY5l0PsS4aBTb87zLbksqlks0I0jLBs=;
        b=o0SkNCmVZxMJfxwARRNBDHNNHk2uWYCD7a3vzwedc06jrNnCDwKnnalFYPy9tA7D1v
         1g/bjV+PcfDKzancHe/5+lfd9xWtLX1r5VyFCcy+0RE+w5lCXIgEW0zmgICX2Ndm8Tfy
         /aKtdULsXuIopxllj8t8CR3Slg50mE+i7i39uiPdqEye5JF4hgOVhaQaZPmlZG9asxGX
         nLtHVdWtsTFZqID5GzTCoVg3O5YShrmqZUqjE1oTZzkn+gdH59ZShcDigZSqsgK1LgJp
         klyfzRF8oLGePN7JpMWEFwav64QDdHBuhQ1Z63lr7I2B6rShsPVOk6HBMnBsfubNO3cd
         cysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775055134; x=1775659934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s5wWYdzsVjLlXY5l0PsS4aBTb87zLbksqlks0I0jLBs=;
        b=BjXuq5Ek99wlddz0+7kc2FyC2XF5KIZzk2mSpACxsr8Cs7QOoDwYiC7YbAzMhbk40u
         D02qhfld9C5zNpX7moQlz/YfXwEVgG83dN9JwSTA/Eb7Bg2tf5lP8pYZvJ+3wPnJVMSH
         0N9MM6eG4jUWaMtwkdxf+RQw3kYQ1eKuIH2htaig33KHHhN7we62QWOEi/LFamC7fTvS
         n1CpnjVtOPClLnAUENzs13ZoLhfUb11IfxG+IJLcn7WvGJAcIWVLoPFreM98TxwqBiBm
         MQCcOUWtK2L2eGQnCg3ur7RFPVCTMOa3L5dXdTRoZGGUyM5fvs0H18T67KZekdkkRfCu
         XyhA==
X-Gm-Message-State: AOJu0Ywo7A8mc4JW4qNelSCOq29Ll4+XZdMx13dEHjn+uXjdDQUUI8xF
	3kPJQ0IgwNG1++ldbuLR9JCzUp6payhfhM2V/jomXgMBi6OfrLQDE37arDQRdIjLGmZAl4aTbC8
	rKGGOCrdx6iu1tmhiK8/laOWwyGSI7Y0=
X-Gm-Gg: ATEYQzzcutSo9BPOt23lrjBeM6i1zFsqjK8AhAdQabW1wmSa66QyqkcyVI18JIm8XYk
	V1pMthELLp3N7eXzMhU5c3Xk+CrYT8Wswut7C0b+i6LmlV2rPN9LoKUhrP9QR4/QCNbvugSYCfZ
	j4qA8aWg3OcsHGnrkrbYS2fqC0eLZHb1YC4smbhXzepTR1d1VgWsOEt/REELXyi/R3PcMCS9Si7
	7o9LBV/TIwXOmMAN6xIlbrtIhvbDnlBcIjLhQlj4fmgg19k71Aja9A5QW7RibD3EOxknc+EQudz
	r6ISAwShWZ4CeJdFOTDofYuwzATl5pYlPAuJ/HS5Ug==
X-Received: by 2002:a05:6402:210a:b0:66d:d942:22e3 with SMTP id
 4fb4d7f45d1cf-66dd9519f9fmr1090996a12.8.1775055133557; Wed, 01 Apr 2026
 07:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328084648.51158-1-keenanat2000@gmail.com>
 <20260328084648.51158-2-keenanat2000@gmail.com> <CABBYNZKEWUtkZX9jB9nrTzLUwQh0MCVVaN0x6W1bNM1A5LXKRg@mail.gmail.com>
In-Reply-To: <CABBYNZKEWUtkZX9jB9nrTzLUwQh0MCVVaN0x6W1bNM1A5LXKRg@mail.gmail.com>
From: Keenan Dong <keenanat2000@gmail.com>
Date: Wed, 1 Apr 2026 22:52:02 +0800
X-Gm-Features: AQROBzBRO6HOB_-WCF78O6VxyXPLI66q7ZqFySOgm4bMjVsURTg35YtO9PTL91w
Message-ID: <CAG0CALzMXt6FxNc=fJQqX3WXEcgYMBaP-YxioFVp_iDXGcDcdA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: require exact mesh send payload length
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I've submitted a revised version of the patch.

Regarding your comment about mesh-tester, I'm not entirely sure about
the expectation =E2=80=94 would you like me to also add test coverage for
these conditions in tools/mesh-tester.c?

If so, should I include that as part of a new patch revision, or
handle it separately (e.g. as a PR to the BlueZ repository)?

Best regards,
Xianrui Dong






On Tue, Mar 31, 2026 at 4:07=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Keenan,
>
> On Sat, Mar 28, 2026 at 4:47=E2=80=AFAM Keenan Dong <keenanat2000@gmail.c=
om> wrote:
> >
> > mesh_send() only checks that the total command length falls within a
> > broad range. A malformed MGMT_OP_MESH_SEND request can therefore claim
> > a larger adv_data_len than the bytes actually present, and the async
> > mesh send path later copies past the end of the stored command buffer.
> >
> > Require the command length to exactly match the variable advertising
> > payload size before queueing the request.
> >
> > Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
> > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
> > ---
> >  net/bluetooth/mgmt.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index e5f9287fb..aad0da033 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -2478,6 +2478,7 @@ static int mesh_send(struct sock *sk, struct hci_=
dev *hdev, void *data, u16 len)
> >         struct mgmt_mesh_tx *mesh_tx;
> >         struct mgmt_cp_mesh_send *send =3D data;
> >         struct mgmt_rp_mesh_read_features rp;
> > +       u16 expected_len;
> >         bool sending;
> >         int err =3D 0;
> >
> > @@ -2491,6 +2492,11 @@ static int mesh_send(struct sock *sk, struct hci=
_dev *hdev, void *data, u16 len)
> >                 return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
> >                                        MGMT_STATUS_REJECTED);
> >
> > +       expected_len =3D struct_size(send, adv_data, send->adv_data_len=
);
> > +       if (expected_len !=3D len)
> > +               return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
> > +                                      MGMT_STATUS_INVALID_PARAMS);
>
> Ok, I guess you are saying the following is not actually correct:
>
>     if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
>         len <=3D MGMT_MESH_SEND_SIZE ||
>         len > (MGMT_MESH_SEND_SIZE + 31))
>
> So is MGMT_MESH_SEND_SIZE is not the size of mgmt_cp_mesh_send? Anyway
> your check can probably replace these checks above, it would be great
> to have these conditions covered by the likes of mesh-tester:
>
> https://github.com/bluez/bluez/blob/master/tools/mesh-tester.c
>
> >         hci_dev_lock(hdev);
> >
> >         memset(&rp, 0, sizeof(rp));
> > --
> > 2.43.0
> >
>
>
> --
> Luiz Augusto von Dentz
