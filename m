Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 18 Dec 2017 17:53:56 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-ID: <392812518.130143.1513616036626.JavaMail.zimbra@karlsbakk.net>
In-Reply-To: <CABBYNZJgMgNdKEk+8ZKrKGqYJ11xD2Cve4WuiLe5jhktj5tFrg@mail.gmail.com>
References: <50287825.52691.1513592889715.JavaMail.zimbra@karlsbakk.net> <CABBYNZKh_7MEVktwcEtRjm_+98FTfNJiM96R1dOuFCO3mg6KkA@mail.gmail.com> <1436200831.125917.1513614254229.JavaMail.zimbra@karlsbakk.net> <CABBYNZJgMgNdKEk+8ZKrKGqYJ11xD2Cve4WuiLe5jhktj5tFrg@mail.gmail.com>
Subject: Re: Setting a static pin to allow pairing
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>>>> I'm trying to setup a raspberry pi as a bluetooth host allowing pairin=
g from a
>>>> phone, but with a predefined pincode, and I can't find any docs on how=
 to do
>>>> this. I find some on how to do this interactively, but then, this isn'=
t meant
>>>> to be used like that, more like a "blackbox". I've tried to google thi=
s quite a
>>>> bit and reading the docs, but I can't find much. Any idea how to do th=
is?
>>>
>>> With SSP, introduced in Bluetooth 2.1, there is no longer a need to
>>> have predefined pincode. In case that you don't have any means to
>>> confirm you should be able to use "NoInputNoOutput", you can check how
>>> this is done in bluetoothctl:
>>
>> Perhaps I'm overseeing something, but I don't quite understand how SSP w=
ill
>> help. I'm more concerned about unauthorized bluetooth clients pairing wi=
th this
>> than MITM-attacks. I want pairing to be fairly simple, but I need a way =
to
>> identify the client.
>=20
> Authorization is a separate concept, usually services will require
> certain security level which when not met may cause the pairing
> process to kick in, authorization may happen regardless of that if the
> device is not trusted. In other words, Paired property tells if the
> device if the device has been authenticated and a link-key exists and
> Trusted tell if the device can connect without being authorized by the
> agent, the 2 properties acts completely independent.
>=20
> For instance, this is how we handle authorization in bluetoothctl:
>=20
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/client/agent.c#n2=
42
>=20
> Note that RequestAuthorization is for authorizing a new pairing not a
> new connection, which is done by AuthorizeService:
>=20
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/agent-api.txt=
#n161
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/agent-api.txt=
#n174
>=20
> In both cases the device object is given so you can identify who is
> pairing/connecting.

I see - thanks. This is all pretty new to me. Do you know how I can use blu=
etoothectl or similar tools to script up authorisation with the client with=
out digging deeply into the API?

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
