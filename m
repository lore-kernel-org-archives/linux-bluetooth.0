Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4EA3FC5A8
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003116; cv=none; b=UZfYpDi6LZPfyn7wKXQ2oOMz7xoDi8ekyzRCD6b7uas/1Ec9fukTCKfv7q9XKJxc7uM9tZsrt7G/IfiCxXYhitcEG/fw6IRhsC5KhS5wB6CkTW2ByCrNwkt71J4DCZwceK3nQzpkBAtXc8tHmZi0TZaZwc72iqeBqsVL94qT9eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003116; c=relaxed/simple;
	bh=FzHeD0sMZk02bfUIOVbZ7vcbl5dWXL2/Txt+74srelk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0/GP3v9lpagW2+5nVwdU4iYVplh9QpYP6PmZWP/qUyGDFGVRlDRJLuqUu/NgndumiAtxu8fg+bijirRg8qvxuPTG3U7wKaYzVe5hwPMJJKHjx18DwlNXiis1Xnp0aFgj9nzrCCyv17BuG1gy8OmDzfZ1MxJ9sA6tIwgzmZqY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGDhzDnd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGDhzDnd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C000B1F00898
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781003113;
	bh=+sX9ATTxluLYTPpyn9xT27ptWmmBF8CPbs0HcxCOGLE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=RGDhzDndKBB2dkoo2ExWmstsyWaeZ8qJ18zZpU/Zh0vnaXRYAMzekOdsxjslSMmMP
	 Zz8+CTH0TaVqx9FQtV3+0bfwMumlGnwVxTC4XbD3pQ9vXv5cjQPwxw+p/urFIYe+M1
	 23mhKFfJTqrlZpJV745TVZPiLITUlVY6C7d5E8xA1cDZC81W784rbDYRkz7hR5lGZL
	 64Iy0/HNkiWIMrL9ECwoHOiIF9wCFEfpU8Auj711VfrHHZui/L8EP/HRqjhrowKr2W
	 OxVlAEX7eB4eXwfcJe6BQDfh51Xjtyo6bbEDsj8hF5jBGM4+Ii4e2FKcVqq3Vj0HgK
	 9xuzxLAHXn0zA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa68dbd44fso5488621e87.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 04:05:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/wg4t4H6fpjiUHt5VJZ2Gtq7tjlX4COD9/5kGAitE+g8rh50Z+RsqcInDZeg8/XW70eB/xWcd8H5Uyaf+bc8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpdgO2AqSSsb5Wbw49Tc6T7dUYNovVoSb9dq0eIq9dFzgbLkmp
	+8fUg4v3KDPQCWeKC+TuQZRaw0ZLbw27mzqr4qAyE1Y1oTRk4P3r3PNRS/5LCVx8aT6PCp/sYwx
	/7UAZYiGaIsVfGm0Qy8u6iWFwRPYLuBSITuAyUSNm7Q==
X-Received: by 2002:a05:6512:2253:b0:5aa:5c8c:9cf4 with SMTP id
 2adb3069b0e04-5aa87b5f803mr5428916e87.17.1781003111998; Tue, 09 Jun 2026
 04:05:11 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 07:05:10 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 07:05:10 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAFEp6-1syMQsvuQ+dLU39bnDeL5Ok7vK1mA7CS0v1m7cjhyMQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-4-45712e6b22c6@oss.qualcomm.com>
 <CAMRc=MfuiPMkSm=-G6VEJpqKhos0TD_pf0ScBGqfwLHT0uk8yQ@mail.gmail.com> <CAFEp6-1syMQsvuQ+dLU39bnDeL5Ok7vK1mA7CS0v1m7cjhyMQw@mail.gmail.com>
Date: Tue, 9 Jun 2026 07:05:10 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mc=-G0+ESPJUUgxd+jJWwuEzBcVXSJyAbAhx6BFkHeimA@mail.gmail.com>
X-Gm-Features: AVVi8CdBM8fdpM7hiE50yrSmJrPYo7K9sdF-J87b4PfgsolvJ2MbyT4LVehGYdI
Message-ID: <CAMRc=Mc=-G0+ESPJUUgxd+jJWwuEzBcVXSJyAbAhx6BFkHeimA@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] block: implement NVMEM provider
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@makrotopia.org, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jun 2026 12:13:08 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Hi bartosz,
>

...

>>
>> On the other hand, we don't want to not provide the block device just be=
cause
>> someone added a DT property on one that's too big. I'd say: warn, but re=
turn 0.
>> Does it make sense?
>
> It=E2=80=99s still technically an error in the sense that we cannot provi=
de
> the required nvmem feature. However, it only becomes a real issue if a
> consumer actually attempts to use it.
> Also, the block device should still be added, since the return code
> from add_dev is not checked. In any case, I=E2=80=99m fine with either
> approach, as long as we emit a warning message.
>

We don't check the return value now (why?) but if we ever do, the safer opt=
ion
is to return 0 IMO.

>>
>> > +     }
>> > +
>> > +     config.id =3D NVMEM_DEVID_NONE;
>> > +     config.dev =3D dev;
>> > +     config.name =3D dev_name(dev);
>> > +     config.owner =3D THIS_MODULE;
>> > +     config.priv =3D (void *)(uintptr_t)dev->devt;
>> > +     config.reg_read =3D blk_nvmem_reg_read;
>> > +     config.size =3D bdev_nr_bytes(bdev);
>> > +     config.word_size =3D 1;
>> > +     config.stride =3D 1;
>> > +     config.read_only =3D true;
>> > +     config.root_only =3D true;
>> > +     config.ignore_wp =3D true;
>> > +     config.of_node =3D to_of_node(dev->fwnode);
>> > +
>> > +     return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
>>
>> And that was a wrong suggestion on my part too because I was under the
>> impression that we're in the probe() path, not device_add(). You can't u=
se
>> devres here as the device at this point is not yet bound and may never b=
e.
>
> So I understand The bd_device is purely a class device with no bus, no dr=
iver.
> For driverless devices, devres_release_all() is called explicitly
> within device_del() .
>

Right.

>>
>> Which leads me to the second point: this is not the moment to add the nv=
mem
>> provider. This should happen at or after probe(). Once nvmem_register()
>> returns, you have a visible nvmem resource but nothing backing it in the=
 block
>> layer.
>
> There is a short window during which a read attempt will 'properly'
> fail, but this does seem somewhat fragile indeed.
>
>> Either do this in block core when registering a new device or schedule
>> a notifier here for the BUS_NOTIFY_BOUND_DRIVER event and do it in the n=
otifier
>> callback.
>
> So in the end, it seems that the simpler and more robust approach is
> probably to move away from the class_interface driver and instead
> register/unregister the nvmem directly in add_disk/del_gendisk.
> If that's ok I will move to this approach in the next version.
>

Yes, I think it's the right approach.

Bart
