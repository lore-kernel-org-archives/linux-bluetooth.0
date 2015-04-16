Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3B9B5B7C-9801-4A1D-8585-59DBD156148C@holtmann.org>
References: <1429130874-24831-1-git-send-email-drake@endlessm.com>
	<3B9B5B7C-9801-4A1D-8585-59DBD156148C@holtmann.org>
Date: Thu, 16 Apr 2015 10:22:32 -0600
Message-ID: <CAD8Lp468eiB4j-gTxQrXRHBO_QGsn3_yctyUrE5PFCJA+Xtj4g@mail.gmail.com>
Subject: Re: [PATCH v7] Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A support
From: Daniel Drake <drake@endlessm.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Larry Finger <larry.finger@lwfinger.net>,
	Champion Chen <champion_chen@realsil.com.cn>, Carlo Caione <carlo@endlessm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for the fast feedback!

On Wed, Apr 15, 2015 at 4:26 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Since this is not your fault, I am willing to merge this change (after mi=
nor cleanup) and then convert it over to move the vendor HCI commands into =
btrtl.ko separate module.
>
> I have already done this for btbcm.ko and btintel.ko and I will do this w=
ith other vendor details as well. So this is the strategy that we are headi=
ng towards. As I said, this is something that came along and is a new requi=
rement and I am willing to do fix this up for you after merging the patch. =
So nothing to worry about. It is just a heads up.

Nice. I would be happy to do this, but it might take me a week or so
to get to it.

> This needs to be a separate patch on top of adding basic support for Real=
tek devices. So please split this out.
>
> And while you do, please create a data->flags for it and not copy the dri=
ver_info into the btusb_data structure. Lets define a common flag indicatin=
g the need for reset_resume =3D 1. And then only if the Realtek hardware ha=
s been detected, this flag gets set.

OK. I will submit this as a separate patch once the main part has gone in.

Thanks
Daniel
