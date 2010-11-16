Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Nov 2010 16:37:29 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 3/7] Add DBus OOB API documentation.
Message-ID: <20101116163729.GA3854@jh-x301>
References: <1289922247-20712-1-git-send-email-szymon.janc@tieto.com>
 <1289922247-20712-4-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289922247-20712-4-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 16, 2010, Szymon Janc wrote:
> +Service         org.bluez
> +Interface       org.bluez.OOB
> +Object path     /org/bluez

I think this should use the same path as the Manager API, which at the
moment is /

> +Methods		void RegisterProvider(object provider)
> +
> +			This method registers provider for DBus OOB plug-in.
> +			When provider is successfully registered plug-in becomes
> +			active. Only one provider can be registered at time.
> +
> +			Possible errors: org.bluez.Error.AlreadyExists
> +
> +		void UnregisterProvider(object provider)
> +
> +			This method unregisters provider for DBus OOB plug-in.
> +
> +			Possible errors: org.bluez.Error.DoesNotExist

Ok, these methods make sense.

> +		array{byte} hash, array{byte} randomizer
> +			ReadLocalOobData(object adapter)

Having to pass an adapter path as a parameter seems weird. Wouldn't it
make more sense to have this method in the Adapter path/interface
instead? Also, we could toy around with the thought of putting the two
other methods into the current Manager interface.

One general thing throughout your patches, both the in-code comments and
commit messages: D-Bus is spelled D-Bus, not DBus :)

Johan
