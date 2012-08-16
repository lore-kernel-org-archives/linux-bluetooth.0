Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Aug 2012 02:10:56 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: koko Aborigines <7aborigines7@gmail.com>
Cc: marcel@holtmann.org, padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add support bluetooth usb 0489:e046 Foxconn / Hon Hai
Message-ID: <20120816051056.GA25290@joana>
References: <1344757304-11555-1-git-send-email-7aborigines7@gmail.com>
 <20120815044111.GG3344@joana>
 <CA+iwHK1VYJ+G-9aVgkzvAV4C3Unhyz-sqC+_SkUmPhffs1_=CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CA+iwHK1VYJ+G-9aVgkzvAV4C3Unhyz-sqC+_SkUmPhffs1_=CQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

* koko Aborigines <7aborigines7@gmail.com> [2012-08-16 10:12:44 +0700]:

> Hi, Gustavo
>=20
> i have error with your patch
>=20
>  CC [M]  drivers/bluetooth/btusb.o
> drivers/bluetooth/btusb.c:113:2: error: implicit declaration of function
> =E2=80=98USB_VENDOR_AND_INTERFACE_INFO=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]
> drivers/bluetooth/btusb.c:113:2: error: initializer element is not consta=
nt
> drivers/bluetooth/btusb.c:113:2: error: (near initialization for
> =E2=80=98btusb_table[22].match_flags=E2=80=99)

You need to apply it against the bluetooth-next tree (or linux-next).

	Gustavo
