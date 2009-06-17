Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E06A01AA4@NL0105EXC01V01.eur.slb.com>
References: <20090513154809.GK6984@titan.makhutov-it.de>
	 <d89ddf300905132146t31b860ddtb43e3371f094f79b@mail.gmail.com>
	 <6AC5A55546F64545AE996F8200E3AC4E06A01AA4@NL0105EXC01V01.eur.slb.com>
Date: Wed, 17 Jun 2009 00:27:49 -0600
Message-ID: <d89ddf300906162327p20cce116r7f98be97ef4d4808@mail.gmail.com>
Subject: Re: Passkey-Agent for bluez 4.xx
From: Brad Midgley <bmidgley@gmail.com>
To: John Frankish <j-frankish@slb.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

John,

> ..but what next - do I specify the bt address of the device I would like to pair with PIN 5555, or?

make your laptop discoverable and connect to it from the other device.
That was the purpose of this script, to set the pin for incoming
connections.

To make it discoverable, use the kde or gnome applet for bluetooth or
have a look at bluez-4.26/test/test-discovery for a headless machine.

-- 
Brad Midgley
