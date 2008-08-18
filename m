Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Mon, 18 Aug 2008 18:03:48 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200807311452.24166.oliver@neukum.org> <200808181638.51851.oliver@neukum.org> <1219072360.7591.59.camel@violet.holtmann.net>
In-Reply-To: <1219072360.7591.59.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808181803.48778.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag 18 August 2008 17:12:40 schrieb Marcel Holtmann:

> actually we can't move the URB killing for ACL into notify() since that
> gives me a kernel panic (fatal exception in interrupt).
> 
> Your patch for the IRQ disabling doesn't make a difference.

Please send me the version that triggers it.

	Regards
		Oliver
