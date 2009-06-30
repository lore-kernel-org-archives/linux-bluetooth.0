Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Jun 2009 18:39:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Filippo Giunchedi <filippo@esaurito.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] test/agent.c: pairing via CreatePairedDevice
Message-ID: <20090630153910.GA5428@jh-x301>
References: <20090630133439.GA27640@jh-x301> <1246375008-8282-3-git-send-email-filippo@esaurito.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1246375008-8282-3-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Filippo,

Thanks for the updated patches. There are still some issues however:

$ test/agent 1234
Can't register agent
Method "RegisterAgent" with signature "os" on interface "org.bluez.Adapter" doesn't exist

whereas running test/simple-agent (without arguments) works fine. Or am I
giving the wrong arguments to test/agent in order to run it in passive
mode?

Also, the RequestPasskey agent method is only used if we are a Bluetooth
2.1 keyboard, so it's not particularly useful for the typical environment
that BlueZ gets run in. To get at least the most common Bluetooth 2.1
Secure Simple Pairing cases covered at least the RequestConfirmation and
DisplayPasskey callbacks should be supported. Also, once these do become
supported the PIN code command line parameter should probably be set as
optional since you won't be asked for a PIN code when doing SSP.

I guess these patches do improve the current situation in anycase since
now calling CreatePairedDevice should at least be possible with test/agent
but I'm not sure if I should wait for another update or just apply the
current versions. Marcel?

Johan
