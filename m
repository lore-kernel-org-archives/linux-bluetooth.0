Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Jun 2009 10:38:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Timothy Murphy <gayleard@eircom.net>
Cc: John Frankish <j-frankish@slb.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Passkey-Agent for bluez 4.xx
Message-ID: <20090617073831.GA9544@jh-x301>
References: <20090513154809.GK6984@titan.makhutov-it.de> <d89ddf300905132146t31b860ddtb43e3371f094f79b@mail.gmail.com> <6AC5A55546F64545AE996F8200E3AC4E06A01AA4@NL0105EXC01V01.eur.slb.com> <200906161530.45295.gayleard@eircom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200906161530.45295.gayleard@eircom.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jun 16, 2009, Timothy Murphy wrote:
> 3. I don't understand why one cannot put the Bluetooth PIN
> in a file, as one used to be able to do.

Most of the times I've heard people requesting this feature it has turned
out that they didn't understand what pairing is and what role the PIN
plays in it. The purpose of pairing is to create a common link key between
two devices. The link key can also be reused in later connections to avoid
pairing again. The purpose of the pin is to act as a one-time input in
this pairing process to create the common link key. It is the link key
that you want permanently stored so you don't need to repair when
connecting later, and bluez already does this for you.

So, the value of having a fixed PIN somewhere in the system is in most
cases rather low since pairing is an infrequent event after which the
generated link key is used to establish secure connections between the
devices. Having a fixed PIN has also the security implication that anyone
who knows your address can create a pairing with you without any knowledge
of the local user. However, bluez doesn't want to define or enforce rules
for where the PIN comes from. Instead, bluez externalizes the whole
process using the agent concept so you are free to have whatever kind of
mechanism you want (e.g. reading the PIN from the filesystem) for replying
to PIN requests.

Johan
