Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1436200831.125917.1513614254229.JavaMail.zimbra@karlsbakk.net>
References: <50287825.52691.1513592889715.JavaMail.zimbra@karlsbakk.net>
 <CABBYNZKh_7MEVktwcEtRjm_+98FTfNJiM96R1dOuFCO3mg6KkA@mail.gmail.com> <1436200831.125917.1513614254229.JavaMail.zimbra@karlsbakk.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Dec 2017 14:43:15 -0200
Message-ID: <CABBYNZJgMgNdKEk+8ZKrKGqYJ11xD2Cve4WuiLe5jhktj5tFrg@mail.gmail.com>
Subject: Re: Setting a static pin to allow pairing
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Roy,

On Mon, Dec 18, 2017 at 2:24 PM, Roy Sigurd Karlsbakk <roy@karlsbakk.net> wrote:
>>> I'm trying to setup a raspberry pi as a bluetooth host allowing pairing from a
>>> phone, but with a predefined pincode, and I can't find any docs on how to do
>>> this. I find some on how to do this interactively, but then, this isn't meant
>>> to be used like that, more like a "blackbox". I've tried to google this quite a
>>> bit and reading the docs, but I can't find much. Any idea how to do this?
>>
>> With SSP, introduced in Bluetooth 2.1, there is no longer a need to
>> have predefined pincode. In case that you don't have any means to
>> confirm you should be able to use "NoInputNoOutput", you can check how
>> this is done in bluetoothctl:
>
> Perhaps I'm overseeing something, but I don't quite understand how SSP will help. I'm more concerned about unauthorized bluetooth clients pairing with this than MITM-attacks. I want pairing to be fairly simple, but I need a way to identify the client.

Authorization is a separate concept, usually services will require
certain security level which when not met may cause the pairing
process to kick in, authorization may happen regardless of that if the
device is not trusted. In other words, Paired property tells if the
device if the device has been authenticated and a link-key exists and
Trusted tell if the device can connect without being authorized by the
agent, the 2 properties acts completely independent.

For instance, this is how we handle authorization in bluetoothctl:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/client/agent.c#n242

Note that RequestAuthorization is for authorizing a new pairing not a
new connection, which is done by AuthorizeService:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/agent-api.txt#n161
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/agent-api.txt#n174

In both cases the device object is given so you can identify who is
pairing/connecting.

-- 
Luiz Augusto von Dentz
