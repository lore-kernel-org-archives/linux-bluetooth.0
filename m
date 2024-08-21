Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF05170A3F
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275155; cv=none; b=gVpBZT+el8lOwPxqm2rKzAhhbHEi4dEay7wtdCF57gL6G37eirAQtaegcNrNXCrAIGTZ4wtTq5YwRHRs2/ME2O48+eLfzhQ85dfGaqUA/Wbo452B/lUXtevFuCXSMVJWHg2QIxonU6iAc09GRRhV12wNKJE6KKzo2qJ+bQu+a+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275155; c=relaxed/simple;
	bh=hwIqym5Mq22k+IOcOcKfcjl1vWN3BDhdby9UJo1dl0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpAGZlger+JlTgTqOBo6nrVBOvsU1Vq97II1EpvApyvClOL8R1q1I5tSu26p6MZEPZ/WnN4mem/VRBtEWm2ptq51LUOshWgugmyHfAROuTB6/Z6bwRD6ZBEOKciUVrJMvzGaHpNAWlpXAX/pBJIVZpclOb7bjwaTUKrXxXq5PK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bNjkjQei; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bNjkjQei"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3dc16d00ba6so78573b6e.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724275151; x=1724879951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mMqsV426iAd7wqkB5gTGvJ52fuCD5N8hcVLuM2nRtU=;
        b=bNjkjQeiVDuLAo5yWpJaLdDvRGtdOhNqKKf54ToDK/RxIUHDeFPzn+uGT0uulYfyrp
         OxVTKFzWW9zDqezNoYhAVVLuB4mwNwKWHVsaVbP+nwjmE8Xq3T3wyp8p+Ws0pzTwJQ5n
         3Ypv32J72rHCuXWxVng9z1L9PoY4gW8P/+Gj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275151; x=1724879951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mMqsV426iAd7wqkB5gTGvJ52fuCD5N8hcVLuM2nRtU=;
        b=Kq6m4jA7WOOiy+pvqCcoXUT0Yf6eLUagt8Qqxeepxxg8zCvpXcIq5CCJ9nygy+RlyK
         7+MA+ilQTkN0Y60jV9gtOY69DZEqfHpL7rMpwQgf3FU0z1DtTfiJrMpHHuJhYhQumJuu
         vkyy/3evBwdUAdW4sLXyReDUj6oE3cazmPEOLkBGEa/T1Xx7HF+CLurP8zGK+uAdFSTF
         Gume1/k7otCs1vT+Ds7fXdLijoJqocvGRH38VD5dhyBf4G2g/wDNHGSVpbSmzyHZuVrX
         3wx7IBESuUZMP3MC/ZKciUjdC51Y0zFBfVfZvbwPajHTop8LH523u/zCGw8nvPv5dCUx
         dsSA==
X-Forwarded-Encrypted: i=1; AJvYcCWZyn22ATJl0ANXKyP1wkbTtHQDCcDHR4t0B5o0xwPNupKATbM7J/zL/X4b3kK7R8gjZWF+vwp0I1hGJ1zH18c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfWOiMW6sraNvQZBEhogL/mCslUyHVI70DgrYpcT8yOBNTr6Yu
	I8erzB3yfCK59yXuA004zZydre9DEHvQjLSXKT+m4fsvNjQIdel3TiZdAMJM4WJhPezy2p9ajgN
	N2w==
X-Google-Smtp-Source: AGHT+IF+6m/bSrcjRS+Nw66eiLhPmquYZA5oS/B+h+hgZoBbbWvF7FstA//V3n9odB/nVq3Ez82b7Q==
X-Received: by 2002:a05:6808:e8a:b0:3da:a779:ab70 with SMTP id 5614622812f47-3de1958d851mr4052759b6e.45.1724275151670;
        Wed, 21 Aug 2024 14:19:11 -0700 (PDT)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe1b2825sm132651cf.80.2024.08.21.14.19.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 14:19:10 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bf784346b9so320676d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:19:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoaYN0weo5Cc49brqlPkfo2/hvn+zkMO10mPUZF35IRA83iyJq9ejA3QO14/iz7eMKP7/M05e8OuD2XQFWry4=@vger.kernel.org
X-Received: by 2002:a05:6214:4301:b0:6bf:786d:45cf with SMTP id
 6a1803df08f44-6c155d8bf66mr46298786d6.22.1724275150045; Wed, 21 Aug 2024
 14:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
 <CAD=FV=Wd4UdjGdFODGCa4acviQG2V_YuM9J8oxi8A--ZmseNUA@mail.gmail.com> <CAD=FV=WqyEo9mWgYyRQjLmhh1pNTNTFM1zwbi2g0n9FMseUtHg@mail.gmail.com>
In-Reply-To: <CAD=FV=WqyEo9mWgYyRQjLmhh1pNTNTFM1zwbi2g0n9FMseUtHg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 21 Aug 2024 14:18:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VKogUZEhON5D9zM7hrLKzfBro-HPVuNqdy0HNozDJmaQ@mail.gmail.com>
Message-ID: <CAD=FV=VKogUZEhON5D9zM7hrLKzfBro-HPVuNqdy0HNozDJmaQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Johan Hovold <johan+linaro@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Sai Teja Aluvala <quic_saluvala@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 31, 2024 at 1:29=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Jun 10, 2024 at 4:52=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Fri, May 17, 2024 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chro=
mium.org> wrote:
> > >
> > > On systems in the field, we are seeing this sometimes in the kernel l=
ogs:
> > >   Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95
> > >
> > > This means that _something_ decided that it wanted to get a memdump
> > > but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).
> > >
> > > The cleanup code in qca_controller_memdump() when we get back an erro=
r
> > > from hci_devcd_init() undoes most things but forgets to clear
> > > QCA_IBS_DISABLED. One side effect of this is that, during the next
> > > suspend, qca_suspend() will always get a timeout.
> > >
> > > Let's fix it so that we clear the bit.
> > >
> > > Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump suppor=
t")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > I'm nowhere near an expert on this code so please give extra eyes on
> > > this patch. I also have no idea how to reproduce the problem nor even
> > > how to trigger a memdump to test it. I'd love any advice that folks
> > > could give. ;-)
> > >
> > >  drivers/bluetooth/hci_qca.c | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > Totally fine if you just need more time, but I wanted to follow up and
> > check to see if there is anything you need me to do to help move this
> > patch forward. If not, I'll snooze this patch and check up on it again
> > sometime around the end of July.
>
> It being the end of July, I'm back to check up on this patch. I
> checked mainline and bluetooth-next and I don't see any sign of this
> patch. Is there anything blocking it? Do you need me to repost it or
> take any other actions?

I feel like I'm shouting into the wind. Am I following some incorrect
process for submitting this patch? Can anyone suggest something I
should do differently to get a response here?

Thanks!

-Doug
