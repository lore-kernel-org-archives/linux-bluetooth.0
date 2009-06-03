Return-Path: <cyrus@holtmann.org>
Subject: Re: net-next-2.6: Bluetooth: NULL pointer dereference in
 tty_register_device
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Hartkopp <oliver@hartkopp.net>
Cc: Linux Netdev List <netdev@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <4A26AEF2.2000900@hartkopp.net>
References: <4A26AEF2.2000900@hartkopp.net>
Content-Type: text/plain
Date: Wed, 03 Jun 2009 21:32:28 +0200
Message-Id: <1244057548.4145.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> this morning i got this NULL pointer dereference at boot time
> with Daves (that time) latest net-next-2.6 tree.
> 
> Any idea about this bug?
> 
> I only got this problem once so far.

I have never seen it before. Could be a problem with changes inside the
TTY layer.

Regards

Marcel


