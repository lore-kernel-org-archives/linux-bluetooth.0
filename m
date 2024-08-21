Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A54D79D1;
	Wed, 21 Aug 2024 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724278253; cv=none; b=jHPmoTr5j3uFL7j2o+Tj5v4e2oIiQJ+qrmbRrTCd2eedcXEDdD+WPXbrTA52H86pr5ape17RtMUEofB4fo8E8XTQSWF9pmMnqHGuKeZ9zMCRQvi8xaW0W5h9nUzZxZZ1hupcEyv4UwvkhKCyxVszeC9eohc608MuYKtppz2HpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724278253; c=relaxed/simple;
	bh=rIzBN03LieOWtCMMKZkkOFkdKHhyjSG7to70Fa3f60k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXzhhySN1k38LS97nIk7rXPo4ZjwmaVN0yKRAaN3reU2JV2u9ugNFJZrVCWD5A9J8+Eo27EyfGxCwjOIhwtBNn4uWLHaC6+raa1XuflhpLGYfRD+++99u1BvmlSS95bS9+lbYqRErYuPz1DUccsO6HBlLSTaCceOidYhibt1EsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9txSdlq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9txSdlq"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso1320371fa.1;
        Wed, 21 Aug 2024 15:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724278249; x=1724883049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCx8/ZTzCS5jQ+3sVFypnT0tf4E4jHCF3XHiYlj0Chg=;
        b=U9txSdlqnrWG19kmZEgkXKBb1wAF79AVn0HrrHUfiLoucrZ7IBIBgfMu9RVsybqmoR
         4pRolTk1rn56J1yuUDIHNnRU4n51UeGOYRpg1jqI8Vup+6V017FhRAMLHFGHUGlHPtK2
         auc1tzA8SnfVD9UFceQglPz4THjyGNX73esWdBAvfez3RuHecto+Gq/Y79BCEo04DFYp
         CTT2+sy9K3Bm2612DWKNDGjvmmG6t4sgKOe9c+wU2u7Ym2bvD1JT8yOV6EHvud881jo7
         BTjsXxuU7M6OLML2zlLk8zt6Dt9rQk2IOxyFaw/thrJDsUCYZhjF9NoKUWhZ0BWFYC7U
         fYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724278249; x=1724883049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCx8/ZTzCS5jQ+3sVFypnT0tf4E4jHCF3XHiYlj0Chg=;
        b=OvFlET0b2sQszPrODyR1BaPln9aU3CAkBcwi/hPNsW1fcXC/4lk9RBIHFxWxIiqIS+
         YOUYN0gdHw/ZbEQYg4Nxd+pLQnV8uTT6csamj0UaL216fB6wIA0nxC3YCYR9ybR6H9NO
         vBXVBT5OzJIXEGR53X2J+ybuGLoW4CAWO92pZ9hXqfiaiuWBQV4zi41AQiCM4ks5jzp+
         JTVPhuVpr+Nwl90WkEZJXWH+VNUTTeZKlIMHjgvV08WEJeX6GjkOCSIa0K5q1Xm7xvQZ
         I1QYmSS9KJ41a1dpAPbFTw5Ogna0prPmkADBX63QNv/CBbTik88swNDJPN4Pq2uXK7sd
         XjOw==
X-Forwarded-Encrypted: i=1; AJvYcCUimRWk0Q/NqLe8l+ZN3X7zQ4uY24lO+RytGzc5Y+24YpXl3Pz0v9oV0FObiFAIL/IjjftdoKIMP5b7SKn8dTU=@vger.kernel.org, AJvYcCW+BY3Z/aYm/t8UrGnfRO6fGdexIIhibseMavTKfi8Nz7u19G96xNZ4xwe+05HsXKw6ayc0MtpEGm7g1HZM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26Z4AghzA+dBOMuvzkTf17j8uimglV7NdzOvfNNz8gNHiLfII
	2o07YyIcgFcPAoSzAJW1BwK/IVmNjluhqEQOh0B0OX6G77410Qgjxnx9btkkzwjLNug32TLY/u0
	KyUwVRxMLaPb1pAvfYqxTdOO7VqI=
X-Google-Smtp-Source: AGHT+IFPWf5vpWW49EviJwV2fKPPa+rOOTdrMEN49lXBNmoFajIb9MSMKC4eMUGAxGjIPBHQbny4XAPs9hYxn1UIzQ0=
X-Received: by 2002:a2e:9207:0:b0:2ef:2f37:345b with SMTP id
 38308e7fff4ca-2f3f893f40fmr18819271fa.30.1724278248617; Wed, 21 Aug 2024
 15:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
 <CAD=FV=Wd4UdjGdFODGCa4acviQG2V_YuM9J8oxi8A--ZmseNUA@mail.gmail.com>
 <CAD=FV=WqyEo9mWgYyRQjLmhh1pNTNTFM1zwbi2g0n9FMseUtHg@mail.gmail.com> <CAD=FV=VKogUZEhON5D9zM7hrLKzfBro-HPVuNqdy0HNozDJmaQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VKogUZEhON5D9zM7hrLKzfBro-HPVuNqdy0HNozDJmaQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 21 Aug 2024 18:10:36 -0400
Message-ID: <CABBYNZ+P474ABLjMPKiFqd4R2p7sB0HwGjnhQU4r4iAjqqLv5g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
To: Doug Anderson <dianders@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Stephen Boyd <swboyd@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Sai Teja Aluvala <quic_saluvala@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Wed, Aug 21, 2024 at 5:19=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, Jul 31, 2024 at 1:29=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Mon, Jun 10, 2024 at 4:52=E2=80=AFPM Doug Anderson <dianders@chromiu=
m.org> wrote:
> > >
> > > Hi,
> > >
> > > On Fri, May 17, 2024 at 5:03=E2=80=AFPM Douglas Anderson <dianders@ch=
romium.org> wrote:
> > > >
> > > > On systems in the field, we are seeing this sometimes in the kernel=
 logs:
> > > >   Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-=
95
> > > >
> > > > This means that _something_ decided that it wanted to get a memdump
> > > > but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).
> > > >
> > > > The cleanup code in qca_controller_memdump() when we get back an er=
ror
> > > > from hci_devcd_init() undoes most things but forgets to clear
> > > > QCA_IBS_DISABLED. One side effect of this is that, during the next
> > > > suspend, qca_suspend() will always get a timeout.
> > > >
> > > > Let's fix it so that we clear the bit.
> > > >
> > > > Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump supp=
ort")
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > > I'm nowhere near an expert on this code so please give extra eyes o=
n
> > > > this patch. I also have no idea how to reproduce the problem nor ev=
en
> > > > how to trigger a memdump to test it. I'd love any advice that folks
> > > > could give. ;-)
> > > >
> > > >  drivers/bluetooth/hci_qca.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > >
> > > Totally fine if you just need more time, but I wanted to follow up an=
d
> > > check to see if there is anything you need me to do to help move this
> > > patch forward. If not, I'll snooze this patch and check up on it agai=
n
> > > sometime around the end of July.
> >
> > It being the end of July, I'm back to check up on this patch. I
> > checked mainline and bluetooth-next and I don't see any sign of this
> > patch. Is there anything blocking it? Do you need me to repost it or
> > take any other actions?
>
> I feel like I'm shouting into the wind. Am I following some incorrect
> process for submitting this patch? Can anyone suggest something I
> should do differently to get a response here?

Just resend it since it is no longer listed on patchwork it felt off my rad=
ar.

> Thanks!
>
> -Doug



--=20
Luiz Augusto von Dentz
