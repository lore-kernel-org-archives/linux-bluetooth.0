Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Jun 2009 17:48:28 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] test/agent.c: pairing via CreatePairedDevice
Message-ID: <20090630154828.GD10475@esaurito.net>
References: <20090630133439.GA27640@jh-x301>
 <1246375008-8282-3-git-send-email-filippo@esaurito.net>
 <20090630153910.GA5428@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090630153910.GA5428@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[JFTR I'm subscribed to linux-bluetooth, no need to CC]

On Tue, Jun 30, 2009 at 06:39:10PM +0300, Johan Hedberg wrote:
> Thanks for the updated patches. There are still some issues however:
> 
> $ test/agent 1234
> Can't register agent
> Method "RegisterAgent" with signature "os" on interface "org.bluez.Adapter" doesn't exist
> 
> whereas running test/simple-agent (without arguments) works fine. Or am I
> giving the wrong arguments to test/agent in order to run it in passive
> mode?

You are right, I thought I had sent the patch for calling DefaultDevice and that
went unnoticed but it seems I didn't send it, sending now.

> Also, the RequestPasskey agent method is only used if we are a Bluetooth
> 2.1 keyboard, so it's not particularly useful for the typical environment
> that BlueZ gets run in. To get at least the most common Bluetooth 2.1
> Secure Simple Pairing cases covered at least the RequestConfirmation and
> DisplayPasskey callbacks should be supported. Also, once these do become
> supported the PIN code command line parameter should probably be set as
> optional since you won't be asked for a PIN code when doing SSP.

Indeed, I'll try to update agent.c to better match simple-agent behaviour in the
future

filippo
-- 
Filippo Giunchedi - http://esaurito.net - 0x6B79D401

UNIX is simple, but it just takes a genius to understand the simplicity.
-- Dennis Ritchie
