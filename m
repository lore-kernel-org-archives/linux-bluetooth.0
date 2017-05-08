Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <48520255-46C9-4696-8420-15DB4E8234B4@gmail.com>
References: <8474DEA7-88A2-4AE7-953E-64AC24B1881F@gmail.com>
 <CABBYNZJm0ViS8PZmHRno4T_rOjcJzvQbMfDMmAZ9W5xf-d9Bkg@mail.gmail.com> <48520255-46C9-4696-8420-15DB4E8234B4@gmail.com>
From: Cody P Schafer <dev@codyps.com>
Date: Mon, 8 May 2017 14:07:12 -0400
Message-ID: <CAPoQQ-1UJ45tM4pcKPmDin=J-Tf__52Gomt6xE9OwJDULY5rLg@mail.gmail.com>
Subject: Re: BLE Advertisement frustrations with pydbus
To: Travis Griggs <travisgriggs@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> NAME                                TYPE      SIGNATURE RESULT/VALUE FLAG=
S
> .GetAll                             method    s         a{sv}        -

>
> BUT=E2=80=A6 if I try to access as GetAll as you suggest:
>
> $ sudo busctl call :1.5 /nic/twigpilot org.freedesktop.DBus.Properties Ge=
tAll
> No such interface 'org.freedesktop.DBus.Properties' on object at path /ni=
c/twigpilot

GetAll takes a string argument which is the interface name. Try:

$ sudo busctl call :1.5 /nic/twigpilot org.freedesktop.DBus.Properties
GetAll org.bluez.LEAdvertisement1

Or similar.
