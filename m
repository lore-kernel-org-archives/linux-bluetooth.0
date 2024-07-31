Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87B14AD3F
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457786; cv=none; b=pqQPZYTzC8J9FeTS+OzRoH4yY+Co0IUKHwofps0/MzsdRIow/ZtTWTpM4bVH6hquKvg+PI/ICgWhe/pOIrgel5/T/0bBJ9zADb+WddCGDwPj9uUpzeCOts0Pv28ETjjZi2kGKQREk+22kBGPgrI5hNv9jpBTy3dN3xpdSCrZEKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457786; c=relaxed/simple;
	bh=FqYVA6k1iLJ0poKNCNzTySZxGfnEvNDdUMDGkm/7lBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHe9q3CsXyzkK5CQ3FwVnufc+GU77vEN3NyZRaebGaniPH93nFEZ2jzUkkYtTXFkAfihRLbH16G2PyhfKcEzH5bbIVlP1a3MV4HTeWqnjgF6Mvt7EDfXApQ+YcGcp+OdaDST4wncmrNPCTDS7nZtydS4irbS/yJUlbz1n6O6E9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H7HsdI36; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H7HsdI36"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79f19f19059so380629385a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 13:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722457782; x=1723062582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SZR84pufxEJHH9akehyEVjbbV4hh1UfXsmtqulpwvc=;
        b=H7HsdI3655HKZWKn26fhQ2CLdgGdE05XP2gb5MdKoDKXlZjvcfxDk0OoI+RbxhkLRB
         8msU5x/5c0vnJJjl5YY9L29ih7GQHQi3jko7uvlGrmrKghCMBbON+7BJPJ61P1xme1Rh
         JWQ7auhFVEKCJqSxzS2/gUz3riu/TZHQ/7YJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722457782; x=1723062582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SZR84pufxEJHH9akehyEVjbbV4hh1UfXsmtqulpwvc=;
        b=asWjiDwVU6QIYf5YWp5RzVtRTm0CicHepOho98e3wr0i52R3xOu/XvFxoKHF6yLQt1
         jpiplbRYLKI5qJRg43EhSsUDzAserKEEQAfgrn5tqoQxxZG/0ZDZot6nfTRsesqJFJLD
         dnyQxkyTri4yQ78H4iGbTmTJuk1yVKPF3zEjQBjxyK++EC87VXBH9dOafwXw62GwEeNP
         qQq5yipX2MJQVQyZ+qCJawemruQONj5IEU07THZW1nBbC7Vip3TYDydBEtVzKNn7JDki
         H3YPEVw8YfIPM8BmjXtXi4jPb9M8nUwY7G8N01fs9xQ3EoJ1ZREuTFEWOpB2IXRl2nA2
         s7TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN3dtVudFPvK4yhRzqDB7lzfqrSmp0Il5ARpmxBYjeOiwm2NOGV35OW0+PSHLtAnVjRW1A80ODG0qgBiNIC3AYTFsvIDrs9zVY8mVMRo5E
X-Gm-Message-State: AOJu0YwMBtbUrGOsK+ZU+sDM6onqDmx98VELqmxZZ8+F/2/dyE/KUzSK
	strss9Q69zIwY4yDMUeXpj9CziFRsJxH9sPGstrvQZ1gfOqLHdUQ4/CyArCQOca0h7ePl//CfHk
	=
X-Google-Smtp-Source: AGHT+IEuz8VtGJQu4QdXfuO8RvdjI6/UITUbY0IjlJPJWQOzX+ia3Y60+00F5xH3gcXk4/LGwkyUHQ==
X-Received: by 2002:a05:620a:24c9:b0:79f:1869:11fe with SMTP id af79cd13be357-7a30c6e26d7mr40346885a.52.1722457782147;
        Wed, 31 Jul 2024 13:29:42 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7435509sm783979385a.84.2024.07.31.13.29.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 13:29:40 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44fee2bfd28so484431cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 13:29:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBgvywRkah/cA7ntvdub/kI03Ve4Lvndd6qxPrVnx8sQcKRg3QqNie5prlQeIqj0FZSlhT4BgNgUv3NJPfzd+sZSNCgoHGOZq83EJ73EcV
X-Received: by 2002:a05:622a:13c7:b0:447:f914:8719 with SMTP id
 d75a77b69052e-4504199ef23mr5362921cf.2.1722457779975; Wed, 31 Jul 2024
 13:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
 <CAD=FV=Wd4UdjGdFODGCa4acviQG2V_YuM9J8oxi8A--ZmseNUA@mail.gmail.com>
In-Reply-To: <CAD=FV=Wd4UdjGdFODGCa4acviQG2V_YuM9J8oxi8A--ZmseNUA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 31 Jul 2024 13:29:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqyEo9mWgYyRQjLmhh1pNTNTFM1zwbi2g0n9FMseUtHg@mail.gmail.com>
Message-ID: <CAD=FV=WqyEo9mWgYyRQjLmhh1pNTNTFM1zwbi2g0n9FMseUtHg@mail.gmail.com>
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

On Mon, Jun 10, 2024 at 4:52=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, May 17, 2024 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > On systems in the field, we are seeing this sometimes in the kernel log=
s:
> >   Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95
> >
> > This means that _something_ decided that it wanted to get a memdump
> > but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).
> >
> > The cleanup code in qca_controller_memdump() when we get back an error
> > from hci_devcd_init() undoes most things but forgets to clear
> > QCA_IBS_DISABLED. One side effect of this is that, during the next
> > suspend, qca_suspend() will always get a timeout.
> >
> > Let's fix it so that we clear the bit.
> >
> > Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support"=
)
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I'm nowhere near an expert on this code so please give extra eyes on
> > this patch. I also have no idea how to reproduce the problem nor even
> > how to trigger a memdump to test it. I'd love any advice that folks
> > could give. ;-)
> >
> >  drivers/bluetooth/hci_qca.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Totally fine if you just need more time, but I wanted to follow up and
> check to see if there is anything you need me to do to help move this
> patch forward. If not, I'll snooze this patch and check up on it again
> sometime around the end of July.

It being the end of July, I'm back to check up on this patch. I
checked mainline and bluetooth-next and I don't see any sign of this
patch. Is there anything blocking it? Do you need me to repost it or
take any other actions?

Thanks!

-Doug
