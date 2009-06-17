Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 17 Jun 2009 06:14:46 +0200
Subject: RE: Passkey-Agent for bluez 4.xx
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E06A01D43@NL0105EXC01V01.eur.slb.com>
References: <20090513154809.GK6984@titan.makhutov-it.de>
 <d89ddf300905132146t31b860ddtb43e3371f094f79b@mail.gmail.com>
 <6AC5A55546F64545AE996F8200E3AC4E06A01AA4@NL0105EXC01V01.eur.slb.com>
 <20090616192137.GB10684@titan.makhutov-it.de>
In-Reply-To: <20090616192137.GB10684@titan.makhutov-it.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


-----Original Message-----
From: Artem Makhutov [mailto:artem@makhutov.org]
Sent: 16 June, 2009 23:22
To: John Frankish
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Passkey-Agent for bluez 4.xx

Hi,

> [...]
> I tried out the modified simple-agent:
>
> $ sudo passkey-agent_mod
> Agent registered
> [in separate terminal]
> # bluetoothd -dn
> ...
> bluetoothd[10350]: Agent registered for hci0 at :1.7:/test/agent
>
> ..but what next - do I specify the bt address of the device I would like to pair with PIN 5555, or?

You should issue the pairing from your mobile phone. I don't know how to start pairing from the console.

Regards, Artem
---------------
Thanks - I was afraid you were going to say that...

For some reason, my laptop does not appear to be discoverable from my mobile phone (even though everything seems to be set correctly in /etc/bluetooth/main.conf) - is there a trick to this?

Regards, John
