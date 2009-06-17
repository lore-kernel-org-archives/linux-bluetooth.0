Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Jun 2009 10:12:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: John Frankish <j-frankish@slb.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Passkey-Agent for bluez 4.xx
Message-ID: <20090617071245.GA9177@jh-x301>
References: <20090513154809.GK6984@titan.makhutov-it.de> <d89ddf300905132146t31b860ddtb43e3371f094f79b@mail.gmail.com> <6AC5A55546F64545AE996F8200E3AC4E06A01AA4@NL0105EXC01V01.eur.slb.com> <20090616192137.GB10684@titan.makhutov-it.de> <6AC5A55546F64545AE996F8200E3AC4E06A01D43@NL0105EXC01V01.eur.slb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E06A01D43@NL0105EXC01V01.eur.slb.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jun 17, 2009, John Frankish wrote:
> You should issue the pairing from your mobile phone. I don't know how to
> start pairing from the console.

The very same script you're discussing here (both the modified with the
'5555' and the unmodified version) acts as an passive acceptor for pairing
when you run it without arguments and as an initiator for pairing when you
give it two arguments.  So something like

./simple-agent hci0 <remote address>

should initiate a pairing from the command line to the remote device. This
has btw been discussed a few times on the mailing lists and you'd probably
also have found the answer by googling "bluez simple-agent" or something
similar.

Johan
