Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 15:45:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv3 3/7] Add DBus OOB API documentation.
Message-ID: <20101118134539.GA5850@jh-x301>
References: <1289922247-20712-1-git-send-email-szymon.janc@tieto.com>
 <20101116163729.GA3854@jh-x301>
 <201011171349.51512.szymon.janc@tieto.com>
 <201011181151.48796.szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201011181151.48796.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Nov 18, 2010, Szymon Janc wrote:
> OOB hierarchy
> =================
> 
> Service         unique name
> Interface       org.bluez.OOB

I suppose this should be called org.bluez.OobProvider, OobAgent or
something similar?

> Methods		array{byte} hash, array{byte} randomizer
> 			RequestRemoteOobData(object device)
> 
> 			This method gets called when the service daemon needs to
> 			get device's hash and randomizer for an OOB
> 			authentication. Each array should be 16 bytes long.
> 
> 			Possible errors: org.bluez.Error.NoData
> 
> 		void Release()
> 
> 			This method gets called when D-Bus plug-in for OOB was
> 			deactivated. There is no need to unregister provider,
> 			because when this method gets called it has already been
> 			unregistered.
> 
> --------------------------------------------------------------------------------
> 
> Service         org.bluez
> Interface       org.bluez.OOB

Interface definitions are supposed to be unique. You can't reuse the
same interface name for a different set of methods and signals.

> Object path     /

Regarding this, as you said the healt stuff is using /org/bluez. I'd
like to have someone who knows comment on the reasons why /org/bluez was
chosen instead of /. It seems inconsistent to me since the manager
interface uses /.

> --------------------------------------------------------------------------------
> 
> Service		org.bluez
> Interface	org.bluez.Adapter
> Object path	[variable prefix]/{hci0,hci1,...}
> 
> 		array{byte} hash, array{byte} randomizer ReadLocalOobData()

I agree that this is good to have in the Adapter path, but we can still
discuss about whether it should be on it's own interface or not. Maybe
reusing the adapter path is fine since we're only dealing with one
method in it.

> Service		unique name
> Interface	org.bluez.Agent
> Object path	freely definable
> 
> Methods		void RequestPairingApproval(object device)

I still like RequestPairing better (it's shorter). Marcel, do you have
any opinion or new suggestions for this? It would be reused for incoming
just-works pairing too (though only for 5.x).

Johan
