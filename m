Return-Path: <cyrus@holtmann.org>
Message-ID: <4A38DEE1.2080707@koala.ie>
Date: Wed, 17 Jun 2009 13:17:37 +0100
From: Simon Kenyon <simon@koala.ie>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Passkey-Agent for bluez 4.xx
References: <20090513154809.GK6984@titan.makhutov-it.de> <d89ddf300905132146t31b860ddtb43e3371f094f79b@mail.gmail.com> <6AC5A55546F64545AE996F8200E3AC4E06A01AA4@NL0105EXC01V01.eur.slb.com> <200906161530.45295.gayleard@eircom.net> <20090617073831.GA9544@jh-x301>
In-Reply-To: <20090617073831.GA9544@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan Hedberg wrote:
> Most of the times I've heard people requesting this feature it has turned
> out that they didn't understand what pairing is and what role the PIN
> plays in it. The purpose of pairing is to create a common link key between
> two devices. The link key can also be reused in later connections to avoid
> pairing again. The purpose of the pin is to act as a one-time input in
> this pairing process to create the common link key. It is the link key
> that you want permanently stored so you don't need to repair when
> connecting later, and bluez already does this for you.
>
> So, the value of having a fixed PIN somewhere in the system is in most
> cases rather low since pairing is an infrequent event after which the
> generated link key is used to establish secure connections between the
> devices. Having a fixed PIN has also the security implication that anyone
> who knows your address can create a pairing with you without any knowledge
> of the local user. However, bluez doesn't want to define or enforce rules
> for where the PIN comes from. Instead, bluez externalizes the whole
> process using the agent concept so you are free to have whatever kind of
> mechanism you want (e.g. reading the PIN from the filesystem) for replying
> to PIN requests.
>   
maybe it is because the documentation is a little, how can i put it, light
--
simon
