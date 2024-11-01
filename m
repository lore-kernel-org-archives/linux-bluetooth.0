Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D284E1C
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482689; cv=none; b=Cqc+1Mr6GWq2SB5IjCXyr7RCcCiX/cOB1xcOawp3o62A0sRaX1rrsWyUxgD40Bem/AFMEVo80VqxakJBcW6O1lD/+yfV4gUrJ6A1vLXNICH6Zkw5rY4tSXXTVjzBj/UTLFDIauYdH7n+WZbHWU7HpGo1tDodBIWlwfqhg49qG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482689; c=relaxed/simple;
	bh=jG0gc6maN7OossyTQIyxsB/1ykflG9GTCBjUAqYbU/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4vhVpN3Xwbjs0VQj4ZVR9PmydZ8/Wo6Jb8tgfhB964Tg2mJVmZYJnL02uNgCf0TkELPS5+n3PM+D2ZPAMFmLcnG9wy1KDzH3YHNubLE3ugj6XCaTntiAoVTUAn1FgArqEvluEz9Ply0CxwR8eWpxaZ8nabAMOdN2Qsa9046/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf1Lu4P7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf1Lu4P7"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so18817841fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2024 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730482686; x=1731087486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AgUQrda3S/GKwqo3DSfiOXX5BC0rXLD43OFc1TasJk=;
        b=Bf1Lu4P7BSSchqtxngrT3b+Y87QtERmknBkOxroIBYLlqIDb0+DK+h6OvYaZdzyfuc
         vLH958qJUmvk/CzFEiS2DZDC+Fbjbrc80JSyEMSFOsE2cnweG2v0u16RbafXnwKNtJNP
         /1HjM61kQE3HC5l+H24npBnmESRdVBcHSuyLsNyVz1JFNo5OZ1t6Omhe0vFOmuq6A4Fd
         PgKpzViCFFY0pjg6pfqSBMtSlm654fZXGvkO58uPLUlpWEsqhSQmiGh5NVeMg41MpPj/
         oVNcflJCv/3jUEeBOlWq7SjjpHq6X9hviBptxMrbWK4HGNR8nzuJ6ODA+LTN6Cfguszl
         oq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730482686; x=1731087486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AgUQrda3S/GKwqo3DSfiOXX5BC0rXLD43OFc1TasJk=;
        b=wIv4wV/ic7K8+WlSTc93hqprPNCtRpAkVTB87e2CirROQxHMyH7MPJI/+FXH1m/VG3
         pqFVLsmqY792g3u94PfSLgnFktyItmTYZoNjk/izJpxXnNA17IWYYJxTfv1/qouVp9Lb
         gsCO/qeInUXTTu35ZfrRkyc/Y9TdTGYDb0JbqmjLcgwgEqKoMww+1fzUoZFmrH7olPko
         PMtzAQjoKeweBU/RVkllP1o5C/Nyeh/j+HL3YqAI3qTIYOdRq3C+AcjJWMDdKU5GBV75
         CEgJj/BAXYIsjAmbofsutkw57ZPHTKapqJeX+qReRoOsSMOtSOz72fhG+JNqT/MlHGga
         G+AA==
X-Forwarded-Encrypted: i=1; AJvYcCWVpDslYkW4a8tJb5glDj/lssxKYeb0JmTIMCz2KFtuHyyApFcOuomSofnOPO5ai44AXm8KkQe7BTDtmTQ2JG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH7wo/X3JN0BWTSCTrqgx1XHG9GJKcnHEec+/yMbxgwd6ICk1z
	Md7EqK3BtB9ngfw8ESXcOnmeQa2l0Nz8zANUzbxG5qWYVSbAwUcW4inJxVW9pM7WNJAgmbwCY8k
	S3KZYsulkib3IV/3H3iLYXTOKOE0=
X-Google-Smtp-Source: AGHT+IGmAHBs5halvpjWSkw2lZKfFvRxOy2LiMa9FoN8Ejw1kPkiNGMws8y4T6JFf33UAvRbO7FJfGUXWiE6IeFB6nM=
X-Received: by 2002:a2e:a88b:0:b0:2fa:d67a:ada7 with SMTP id
 38308e7fff4ca-2fedb7ca0c0mr24317031fa.23.1730482685435; Fri, 01 Nov 2024
 10:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101114410.234311-1-dmantipov@yandex.ru> <CABBYNZK=H9JtzaQudQ1b7TGU5VaJ_qX_bbSJhKSwWKh+5_1uUQ@mail.gmail.com>
 <5cc24ab9-80c0-4280-8c4c-d8b052524e1d@yandex.ru> <CABBYNZKvP3u+7juqNNUHOS0PTb=QVzxob+rC3PVq-XXu9vGU+A@mail.gmail.com>
 <fe1588ee-1f00-429c-a917-d1c5e08f3831@yandex.ru> <CABBYNZJiYHWgtBExZ2jbuemJdyo6inpiYMGF7qc9Xbjqu__L7w@mail.gmail.com>
In-Reply-To: <CABBYNZJiYHWgtBExZ2jbuemJdyo6inpiYMGF7qc9Xbjqu__L7w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 1 Nov 2024 13:37:52 -0400
Message-ID: <CABBYNZJXMyJ0bjVAe=sY+zonvFwS2Eh2wiSuzGd+a6U-3-8=fg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: fix use-after-free in device_for_each_child()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, Nov 1, 2024 at 11:31=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Dmitry,
>
> On Fri, Nov 1, 2024 at 11:17=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.=
ru> wrote:
> >
> > On 11/1/24 6:12 PM, Luiz Augusto von Dentz wrote:
> >
> > > There is no Tested-by thus why I assumed it wasn't tested by syzbot y=
et.
> >
> > Ugh. Until today I've assumed that Tested-by: is applicable to human-dr=
iven
> > testing only :-).
>
> Nope, in fact it is very handy to have syzbot test your changes since
> it may hit other problems as well.

Looks like this doesn't solve the problem, in fact I think you are
getting it backwards, you are trying to reparent the parent dev not
the child and I assume by destroying the parent device there should be
some way to reset the parent which seems to be the intent the
following code in hci_conn_del_sysfs:

    while (1) {
        struct device *dev;

        dev =3D device_find_child(&conn->dev, NULL, __match_tty);
        if (!dev)
            break;
        device_move(dev, NULL, DPM_ORDER_DEV_LAST);
        put_device(dev);
    }

But note that it only does that after matching tty, but I guess we
want to do it regardless otherwise we may have the child objects still
access it, that said we should probably use device_for_each_child
though if that is safe to do calls to device_move under its callback.

> > Dmitry
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
