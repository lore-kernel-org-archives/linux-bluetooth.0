Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E06A02356@NL0105EXC01V01.eur.slb.com>
References: <20090513154809.GK6984@titan.makhutov-it.de>
	 <d89ddf300905132146t31b860ddtb43e3371f094f79b@mail.gmail.com>
	 <6AC5A55546F64545AE996F8200E3AC4E06A01AA4@NL0105EXC01V01.eur.slb.com>
	 <20090616192137.GB10684@titan.makhutov-it.de>
	 <6AC5A55546F64545AE996F8200E3AC4E06A01D43@NL0105EXC01V01.eur.slb.com>
	 <20090617071245.GA9177@jh-x301>
	 <6AC5A55546F64545AE996F8200E3AC4E06A02356@NL0105EXC01V01.eur.slb.com>
Date: Wed, 17 Jun 2009 09:35:33 -0600
Message-ID: <d89ddf300906170835m3a2fb054rc5bb60a24d56f75c@mail.gmail.com>
Subject: Re: Passkey-Agent for bluez 4.xx
From: Brad Midgley <bmidgley@gmail.com>
To: John Frankish <j-frankish@slb.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

John,

> Thanks - ./simple-agent hci0 <remote address> does indeed work and the terminal window feedback (as opposed to bluez-gnome) also enabled me to find that the reason I could not pair using the more recent /etc/dbus-1/system.d/bluetooth.conf was that you need to be root to do so, which wasn't the case circa bluez-4.17

if bluez-gnome is silently failing or issuing an error that doesn't
help, it would help if you make sure there's a ticket. It looks like
the list to check is
http://bugzilla.gnome.org/buglist.cgi?query=product%3Agnome-bluetooth+

-- 
Brad Midgley
