Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 18 Dec 2017 17:24:14 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-ID: <1436200831.125917.1513614254229.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <CABBYNZKh_7MEVktwcEtRjm_+98FTfNJiM96R1dOuFCO3mg6KkA@mail.gmail.com>
References: <50287825.52691.1513592889715.JavaMail.zimbra@karlsbakk.net> <CABBYNZKh_7MEVktwcEtRjm_+98FTfNJiM96R1dOuFCO3mg6KkA@mail.gmail.com>
Subject: Re: Setting a static pin to allow pairing
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>> I'm trying to setup a raspberry pi as a bluetooth host allowing pairing =
from a
>> phone, but with a predefined pincode, and I can't find any docs on how t=
o do
>> this. I find some on how to do this interactively, but then, this isn't =
meant
>> to be used like that, more like a "blackbox". I've tried to google this =
quite a
>> bit and reading the docs, but I can't find much. Any idea how to do this=
?
>=20
> With SSP, introduced in Bluetooth 2.1, there is no longer a need to
> have predefined pincode. In case that you don't have any means to
> confirm you should be able to use "NoInputNoOutput", you can check how
> this is done in bluetoothctl:

Perhaps I'm overseeing something, but I don't quite understand how SSP will=
 help. I'm more concerned about unauthorized bluetooth clients pairing with=
 this than MITM-attacks. I want pairing to be fairly simple, but I need a w=
ay to identify the client.

Vennlig hilsen

roy
--
Roy Sigurd Karlsbakk
(+47) 98013356
http://blogg.karlsbakk.net/
GPG Public key: http://karlsbakk.net/roysigurdkarlsbakk.pubkey.txt
--
Hi=C3=B0 g=C3=B3=C3=B0a skaltu =C3=AD stein h=C3=B6ggva, hi=C3=B0 illa =C3=
=AD snj=C3=B3 rita.
