Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Jun 2009 21:21:39 +0200
From: Artem Makhutov <artem@makhutov.org>
To: John Frankish <j-frankish@slb.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Passkey-Agent for bluez 4.xx
Message-ID: <20090616192137.GB10684@titan.makhutov-it.de>
References: <20090513154809.GK6984@titan.makhutov-it.de> <d89ddf300905132146t31b860ddtb43e3371f094f79b@mail.gmail.com> <6AC5A55546F64545AE996F8200E3AC4E06A01AA4@NL0105EXC01V01.eur.slb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E06A01AA4@NL0105EXC01V01.eur.slb.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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
