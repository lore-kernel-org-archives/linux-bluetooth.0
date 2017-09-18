Return-Path: <oliverzabel@gmx.de>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: meshctl fails on rpi 3
From: "Zabel, Oliver" <oliverzabel@gmx.de>
In-Reply-To: <EF2EC730-AB08-460A-8545-653982057FBC@holtmann.org>
Date: Mon, 18 Sep 2017 10:54:27 +0200
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Brian Gix <brian.gix@intel.com>, Laczen JMS <laczenjms@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <6C104080-2AFC-4D11-84EC-862CF31BC796@gmx.de>
References: <CAFxSrVsZcJxkgAFL8yoSK9buoSzFJryNT18mGSRUUq17VPdOEg@mail.gmail.com> <7560B49A-22C4-4A62-AE3F-B1AFA4712B30@intel.com> <CABBYNZL5Q-szxged20DgzBnvJnf6AhVkCaQJEM3Ztg4Z1fPy1g@mail.gmail.com> <EF2EC730-AB08-460A-8545-653982057FBC@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

what is then the procedure to get crypto/meshctl running on rpi3/pi zero w?

Thanks!

Von meinem iPhone gesendet

> Am 18.09.2017 um 10:38 schrieb Marcel Holtmann <marcel@holtmann.org>:
>=20
> Hi Luiz,
>=20
>>> Meshctl' crypto does depend on a lot of Kernel based crypto... pretty mu=
ch everything except for the AES-CCM.
>>=20
>> We might want to update
>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/test-runner.t=
xt
>> if that is not covering the mesh crypto.
>=20
> I would also prefer that we start using AES-CCM from the kernel. Someone s=
hould take up that task and also use src/shared/crypto.c for it. We should e=
nsure that we use a single place for all the crypto helpers.
>=20
> Regards
>=20
> Marcel
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
